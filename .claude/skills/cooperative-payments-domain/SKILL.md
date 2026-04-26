---
name: cooperative-payments-domain
description: Reglas de negocio del SistemaCooperativa (Cooperativa Primero de Mayo) — gestión de socios e inquilinos, puestos, cálculo de luz/agua, generación y aplicación de pagos, ciclo mensual y auditoría. Úsala SIEMPRE al modelar entidades, escribir lógica de cobros, calcular consumos, o tocar los módulos de pagos / socios / inquilinos / puestos.
---

# Cooperative Payments Domain — SistemaCooperativa

Conocimiento de dominio destilado del documento *"Reglas de Negocio y Modelado de Base de Datos"* de la Cooperativa Primero de Mayo. Esta skill es la fuente de verdad funcional cuando trabajes en cobros, pagos, mediciones, ciclo mensual o el modelo de socios/inquilinos.

---

## ⚠️ 0. Reglas con Prioridad Absoluta (de CLAUDE.md)

Si algo en este documento parece contradecir las directivas técnicas de [CLAUDE.md](../../../CLAUDE.md), **gana CLAUDE.md**. En particular:

| Tema | Regla técnica que prevalece |
|---|---|
| Eliminación | **Soft delete obligatorio** (`deleted_at`, `anulado_por`, `motivo_anulacion`). Nunca `DELETE FROM` sobre pagos, recibos, montos, mediciones, recaudación, bancos, gastos cerrados, auditoría. |
| Recibos generados | **Inmutables.** Las correcciones se hacen con **asiento compensatorio** (recibo de reverso), no editando el original. |
| Auditoría | **Append-only.** RLS bloquea UPDATE y DELETE para todos los roles excepto `service_role`. |
| Períodos cerrados | Solo el rol **Admin** puede reabrirlos, y el reabrir queda registrado en auditoría. |

Cuando el doc original diga "eliminar", léelo como "anular vía soft delete".

---

## 1. Modelo de Personas: Socios **e** Inquilinos

El sistema gestiona **dos perfiles independientes** asociados a un puesto. Ambos deben poder agregarse, editarse y gestionarse libremente desde la UI.

### 1.1 Socio (titular / dueño)
Asociado de la cooperativa. Es el **dueño del derecho** sobre un puesto.
- Identificación: `dni` (único).
- Atributos: `nombres`, `apellidos`, `direccion`, `telefono`, `email?`, `fecha_ingreso`.
- **Estado** (Activo / Inactivo): un socio Inactivo (fallecimiento, expulsión, venta del puesto) **no genera nuevos cobros**.
- **Habilitación** (Hábil / Inhábil): un socio Inhábil tiene al menos una deuda pendiente y **no puede participar en asambleas**. La habilitación se recalcula en cada cierre o pago.

### 1.2 Inquilino (posesionario temporal)
Persona física que **ocupa físicamente** un puesto bajo arriendo del socio titular. Puede pagar las deudas del puesto sin transferir la titularidad.
- Mismos campos identitarios que un socio (`dni` único, contacto), más:
  - `socio_titular_id` (FK al socio dueño del puesto).
  - `puesto_id` (FK al puesto que ocupa).
  - `fecha_inicio_arriendo`, `fecha_fin_arriendo?`.
  - `estado_arriendo` (Vigente / Finalizado).
- Un inquilino **no genera derechos de socio** (no vota en asambleas, no recibe remanentes), pero **sí aparece como pagador** en los recibos cuando paga.

### 1.3 Cómo se integran al modelo de cobros

| Concepto | Quién lo "debe" | Quién puede pagarlo |
|---|---|---|
| Deuda del puesto (luz, agua, admin., previsión) | El **puesto** (no la persona) | Socio titular **o** inquilino vigente |
| Multas personales del socio | El **socio** | Solo el socio |
| Aportes extraordinarios de socio | El **socio** | Solo el socio |

**Regla:** la deuda se modela contra el **puesto** (`puesto_id`), no contra el socio. La tabla `pagos` registra **quién pagó** (FK a socio o FK a inquilino, exactamente uno de los dos). Esto permite que un puesto siga acumulando deuda aunque cambie el socio o el inquilino, conservando el histórico.

**UI:** los formularios de socios e inquilinos son CRUDs independientes pero relacionados. Al ver el detalle de un puesto, deben mostrarse **ambos** (titular y ocupante actual) más el historial de cada uno.

---

## 2. Puestos y Giros

### 2.1 Puesto
- `codigo_puesto` (único), `giro_id` (FK), `area_m2`, `estado` (Activo/Inactivo).
- Flags: `tiene_medidor_luz` (bool), `tiene_medidor_agua` (bool). Determinan el método de cálculo aplicable.
- Un puesto **solo puede tener un socio titular** a la vez. El cambio de titularidad genera una fila en el historial (no se sobrescribe la anterior).

### 2.2 Giro Comercial
- `nombre` (abarrotes, comida, jugos, bazar, ...).
- `tarifa_agua_base`, `tarifa_luz_base` — usadas como referencia/default según el giro (comida → tarifa de agua mayor, etc.).

---

## 3. Cálculo de Servicios (Luz y Agua)

Estas fórmulas son **referenciales** — los coeficientes son configurables. Implementarlas como funciones puras tipadas, parametrizadas, y unitarias-testeables. No hardcodear constantes en componentes.

### 3.1 Luz — Método 1: por Amperaje (puestos sin medidor)
```
KWH       = (amperaje × 220V × horas_uso × dias_uso) / 1000
Subtotal  = KWH × precio_kwh
TotalLuz  = Subtotal + monto_alumbrado_publico
```
Defaults: `horas_uso = 12`, `dias_uso = 30`. `precio_kwh` y `monto_alumbrado_publico` son **configurables** y se persisten en cada `medicion` para reproducibilidad histórica.

**Validación crítica:** si el puesto reporta consumo, `KWH` no puede ser cero.

### 3.2 Luz — Método 2: por Medidor / Artefactos (registro manual)
Se registra el consumo del mes manualmente, sumando los artefactos relevantes (focos, tomacorrientes, otros equipos) y un `monto_asignado` resultante. Aplica cuando `tiene_medidor_luz = true` o cuando se opta por registro manual de artefactos.

### 3.3 Agua
**Monto fijo mensual asignado manualmente**, calibrado según:
- Tipo de **giro** (comida = tarifa mayor por uso intensivo).
- Consumo histórico del puesto.

Permite override manual en el período de ajuste mensual (ver §6).

### 3.4 Decisión de método
```
si puesto.tiene_medidor_luz   → método "Medidor/Artefactos"
si NO                         → método "Amperaje"
```
El método elegido se registra en `montos_por_cobrar.metodo_calculo` para auditoría.

---

## 4. Montos por Cobrar (Deudas)

### 4.1 Tipos
| Categoría | Conceptos | Generación |
|---|---|---|
| **Fijos** | Luz, Agua, Gastos administrativos, Previsión social | **Automática** mensual según fórmulas |
| **Variables / Especiales** | Multas (50% descuento por asamblea posible), Aportes extraordinarios, Deudas anteriores | **Manual** o por evento puntual |

### 4.2 Reglas de generación
- Se generan al **inicio del período** según las fórmulas (§3) y los conceptos asignados al puesto.
- Estado inicial: `Pendiente`. Pasa a `Pagado` (total) o sigue `Pendiente` (parcial). `Cancelado` solo por admin con motivo.
- **No se permiten montos negativos.**
- No generar cobros para puestos sin socio titular asignado, ni para socios `Inactivo`.

### 4.3 Aplicación de Pagos — ORDEN OBLIGATORIO

Cuando un socio o inquilino paga, el sistema **distribuye automáticamente** el monto recibido siguiendo este orden estricto:

```
1. Deudas más antiguas pendientes (FIFO por periodo_anio, periodo_mes)
2. Consumos del mes actual (luz, agua, admin., previsión del período en curso)
3. Conceptos especiales (multas, aportes extraordinarios)
```

Cada aplicación parcial se registra en `detalle_pagos` con `monto_aplicado` y `fecha_aplicacion`. Si sobra dinero después del paso 3, queda como **saldo a favor** (no se devuelve automáticamente).

El wizard de 3 pasos (CLAUDE.md §4.1) implementa esto:
1. **Conceptos:** se muestran las deudas pendientes ya ordenadas por antigüedad.
2. **Confirmación:** previsualiza la distribución FIFO antes de cobrar.
3. **Recibo:** genera el comprobante inmutable.

---

## 5. Pagos y Recibos

### 5.1 Pago
- `socio_id` **o** `inquilino_id` (exactamente uno — quien paga).
- `puesto_id` siempre presente (a qué puesto se aplica).
- `fecha_pago`, `monto_total`, `metodo_pago` (Efectivo / Transferencia), `comprobante` (referencia externa), `usuario_registro` (cajero).
- `detalle_pagos[]`: distribución del `monto_total` entre los `monto_id` afectados.

### 5.2 Recibo (formato y usabilidad)
Debe incluir, mínimamente:
- Nombre del socio titular **y** del inquilino si aplica.
- Código y giro del puesto.
- Detalle de conceptos pagados (Luz, Agua, Multas, ...).
- Fecha, método de pago, **código único de transacción**.

Usabilidad obligatoria:
- **Letra grande** (los socios suelen ser personas mayores).
- Opción de **reimpresión** sin alterar el recibo original.

### 5.3 Inmutabilidad
Una vez emitido el recibo, sus campos son **inmutables**. Para corregir un error: emitir un recibo de reverso (compensatorio) y luego uno nuevo. Nunca `UPDATE` sobre el original.

---

## 6. Ciclo Mensual

```
1. Medición / Registro    → captura amperaje o artefactos por puesto
2. Cálculo automático     → genera montos_por_cobrar de luz y agua
3. Período de ajuste      → 7 días de edición manual permitida
4. Cierre del mes         → bloquea ediciones; Inhábiles se recalculan
```

- Tras el **cierre**, los `montos_por_cobrar` del período son inmutables salvo reapertura por Admin (queda en auditoría).
- Tras el cierre, recalcular el flag `habilitado` de cada socio: si tiene deudas pendientes → `Inhábil`.

### 6.1 Reportes obligatorios mensuales
- Socios **hábiles / inhábiles** (insumo para asambleas).
- **Morosidad** (deudas pendientes por puesto).
- **Recaudación mensual** (total cobrado por concepto y por método de pago).

---

## 7. Roles y Niveles de Acceso

| Rol | Permisos clave |
|---|---|
| **Admin** | Modificar montos antes/después del cierre, reabrir meses cerrados, configurar tarifas, gestionar usuarios. |
| **Cajero** | Registrar pagos, emitir recibos. **No puede** modificar cálculos ni montos generados. |
| **Consulta / Auditor** | Solo lectura. Acceso a reportes y al log de auditoría. |

Implementar con RLS de Supabase + tabla `perfiles(role)` (ver skill `supabase-patterns`).

---

## 8. Auditoría

Toda mutación sobre tablas críticas (`montos_por_cobrar`, `pagos`, `socios.estado`, `socios.habilitado`, `inquilinos.estado_arriendo`, mediciones, configuración de tarifas, cierre/reapertura de períodos) debe generar una fila en `auditoria` con:
- `tabla_afectada`, `registro_id`, `accion` (Crear/Actualizar/Anular).
- `valor_anterior` y `valor_nuevo` como JSON.
- `usuario_id`, `fecha_cambio`.

Implementar **vía triggers en Supabase**, no confiar al frontend.

---

## 9. Validaciones Clave (checklist)

Aplica estas validaciones en cualquier servicio o formulario que toque el dominio:

- [ ] `dni` único por persona (socios y también para inquilinos — son padrones independientes pero ambos validan unicidad de DNI **en su propio padrón**).
- [ ] Un socio `Inactivo` no genera cobros nuevos.
- [ ] Un puesto sin socio titular asignado no genera cobros.
- [ ] `monto > 0` siempre.
- [ ] `KWH ≠ 0` si se reporta consumo en método Amperaje.
- [ ] Período cerrado: bloquear ediciones salvo flag de reapertura por Admin.
- [ ] Pago aplicado: respetar orden FIFO (§4.3).
- [ ] En `pagos`: validar que **exactamente uno** de `socio_id`/`inquilino_id` esté presente.
- [ ] Inquilino solo puede pagar deudas del puesto que ocupa, mientras `estado_arriendo = Vigente`.

---

## 10. Mapa de Entidades (resumen para Supabase)

```
socios            (1) ───┬─── (N) puestos_historial_titularidad
                         │
inquilinos        (N) ──── (1) puesto                ─── (N) inquilinos_historial
                                │
                                └── (N) montos_por_cobrar ── (N) detalle_pagos ── (1) pagos
                                                                                       │
                                                          (pagador: socio_id XOR inquilino_id)

giros             (1) ─── (N) puestos
mediciones_luz    (N) ─── (1) puesto
registros_artefactos (N) ─── (1) puesto
auditoria         (append-only, FK a usuarios)
```

Cada entidad lleva las columnas estándar del proyecto: `created_at`, `updated_at`, `created_by`, y donde aplique soft delete: `deleted_at`, `anulado_por`, `motivo_anulacion` con `CHECK` de consistencia (los tres NULL o los tres llenos), igual que en [supabase/migrations/00001_create_gastos_table.sql](../../../supabase/migrations/00001_create_gastos_table.sql).
