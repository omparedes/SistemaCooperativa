# Plan de Implementación — Auditoría Narrativa (Timeline ERP)

> **Estado: APROBADO Y EJECUTADO** (2026-07-07). Decisiones del cliente: triggers en las
> 3 tablas nuevas, motivo opcional en padrón, timeline sin límite de antigüedad.
> Pendiente del lado del cliente: `supabase db push` (migración 00086).
> Fecha: 2026-07-07 · Autor: Claude Code
> (El plan anterior — Central de Reportes v2 — fue ejecutado y aplicado el 2026-07-07.)

---

## 1. Diagnóstico del estado actual

### 1.1 Base de datos (`audit_logs`, migración 00016)

```
audit_logs (id uuid, table_name, record_id text, action INSERT|UPDATE|DELETE,
            old_data jsonb, new_data jsonb, changed_by uuid → auth.users, created_at)
```
- Trigger genérico `log_audit_action()` (SECURITY DEFINER) aplicado a **5 tablas**: `socios`, `inquilinos`, `puestos`, `pagos`, `distribuciones_mensuales` (00016 + 00045).
- Append-only real: RLS sin policies de UPDATE/DELETE; SELECT solo Administrador. ✅
- **Huecos detectados**:
  1. `ocupaciones_almacenes` — la tabla de tu Ejemplo 2 ("Retiró el almacén D-15") — **no tiene trigger**. Tampoco `gastos` ni `caja_ajustes` (dinero saliendo de gaveta sin rastro de quién lo tocó).
  2. No existe columna de **motivo**: hoy el motivo solo sobrevive cuando queda dentro de la propia fila (`pagos.motivo_anulacion` aparece en `new_data`), pero no para ediciones de padrón ni desasignaciones.
  3. La tabla `auditoria` que `rpc_cc_editar_pago` intenta poblar "gracefully" **no existe** → ese insert nunca escribe nada (bug silencioso heredado; el trigger de `pagos` sí captura el UPDATE, así que no se perdió trazabilidad, pero el código muerto confunde).

### 1.2 Frontend (`auditoria.service.ts` + `auditoria-list.component.ts`)

Tabla técnica: acción/tabla/`record_id` numérico/UUID truncado del usuario, y un modal con los **JSON crudos** `old_data`/`new_data` en `<pre>`. Cero resolución de nombres, cero deltas, ilegible para una Junta Directiva.

---

## 2. Decisión de arquitectura: ¿dónde se resuelve la narrativa?

**Híbrido — resolución de entidades y deltas en la BD (RPC), etiquetas y redacción final en Angular.**

| Responsabilidad | Dónde | Por qué |
|---|---|---|
| Resolver entidad ("socio 54" → "PAREDES, Oscar"; pago → recibo + conceptos + monto) | **RPC en Postgres** | Los nombres del pagador de un pago y los conceptos requieren JOINs (`detalle_pagos → conceptos`) que en el cliente costarían N+1 requests o diccionarios completos del padrón (288+ personas) descargados en cada visita — exactamente lo que el Free Tier no tolera. Además el payload jsonb ya trae `apellidos/nombres/codigo_puesto` aunque el registro haya sido borrado (resolución garantizada incluso para DELETE). |
| Calcular deltas (solo campos que cambiaron) | **RPC en Postgres** | `jsonb_each` compara old/new en una línea y evita enviar los payloads completos al navegador (un row de `socios` pesa ~1 KB; el delta típico, ~80 bytes). Menos egress, modal instantáneo. |
| Actor + rol | **RPC** (JOIN a `perfiles`) | Una sola fuente, sin caché de usuarios en el cliente. |
| Etiquetas de columnas (`telefono` → "Teléfono") y formato (fechas, S/, Sí/No) | **Angular** (diccionario estático `auditoria-labels.ts`) | Es presentación pura: cambiar un rótulo no debe requerir migración SQL. El diccionario vive junto a la UI que lo usa. |
| Acción semántica (UPDATE que setea `deleted_at` → "Anulación/Retiro", no "UPDATE") | **RPC** (se deriva del delta) | Así el filtro por tipo de evento funciona server-side. |

### 2.1 Nueva RPC `rpc_auditoria_timeline` (migración 00086)

```
rpc_auditoria_timeline(
  p_limit    int  DEFAULT 50,
  p_before   timestamptz DEFAULT NULL,   -- keyset pagination ("Cargar más")
  p_tabla    text DEFAULT NULL,          -- filtro por entidad
  p_accion   text DEFAULT NULL,          -- CREACION|EDICION|ANULACION|ELIMINACION
  p_busqueda text DEFAULT NULL           -- por nombre de entidad/actor
) RETURNS json  -- solo Administrador
```
Cada evento sale ya "resuelto":
```json
{
  "id": "…", "fecha": "…", "tabla": "pagos", "registro_id": "812",
  "accion": "CREACION",              // derivada: UPDATE+deleted_at ⇒ ANULACION
  "actor":   { "nombre": "María López", "rol": "Caja" },
  "entidad": "Recibo PAG-0001524 · PAREDES, Oscar (Socio)",
  "resumen": { "monto": 145.00, "metodo": "Efectivo",
               "conceptos": ["Agua", "Luz", "Gastos administrativos"] },  // solo pagos
  "cambios": [ { "campo": "telefono", "antes": "987654321", "despues": "999888777" } ],
  "motivo":  "Corrección de error de tipeo solicitada por el socio."
}
```
- Resolución por tabla vía `CASE table_name`: socios/inquilinos desde el propio payload; pagos con JOIN a socios/inquilinos + `detalle_pagos→conceptos`; puestos/almacenes por `codigo_puesto`; ocupaciones_almacenes con JOIN a puesto + ocupante.
- Deltas: `jsonb_each_text(old) ⋈ jsonb_each_text(new)` excluyendo ruido (`updated_at`, `created_at`, `created_by`).
- `motivo`: `coalesce(audit_logs.motivo, new_data->>'motivo_anulacion' si cambió)` — los motivos históricos de anulaciones aparecen retroactivamente sin backfill.

### 2.2 Inyección del "Motivo" en los triggers (misma migración 00086)

Mecanismo estándar de PostgreSQL: **variable de sesión local a la transacción**.

1. `ALTER TABLE audit_logs ADD COLUMN motivo text;`
2. `log_audit_action()` pasa a leer `nullif(current_setting('app.audit_motivo', true), '')` y guardarlo en la fila de auditoría.
3. Los **RPCs críticos existentes** setean la variable al inicio con `set_config('app.audit_motivo', p_motivo, true)` (el `true` = se limpia sola al terminar la transacción, imposible que "contamine" la siguiente operación):
   - `anular_pago` (ya recibe `p_motivo` — solo se añade el `set_config`),
   - `rpc_anular_cargo`, `rpc_liberar_almacen`, `rpc_modificar_costo_almacen`, `rpc_cc_editar_pago`, `rpc_eliminar_socio` / `rpc_eliminar_inquilino` — se les añade `p_motivo text DEFAULT NULL` (parámetro nuevo con default ⇒ **no rompe** las llamadas actuales del frontend).
   - De paso se elimina el bloque muerto de `rpc_cc_editar_pago` que insertaba en la tabla inexistente `auditoria`.
4. **Ediciones directas del padrón** (los formularios de socio/inquilino hoy hacen `.update()` PostgREST directo, sin lugar donde poner el motivo): nueva RPC genérica y acotada
   `rpc_actualizar_con_motivo(p_tabla text, p_id bigint, p_patch jsonb, p_motivo text)`
   con **whitelist dura** de tablas/columnas editables (`socios`/`inquilinos`: teléfono, dirección, email…; nada financiero), rol Admin|Caja. Los formularios de edición ganan un campo opcional "Motivo del cambio" y llaman a esta RPC en vez del update directo. El trigger captura todo.
5. **Triggers nuevos** con `log_audit_action()` en: `ocupaciones_almacenes` (imprescindible para el Ejemplo 2), `gastos` y `caja_ajustes` (dinero físico). *Deliberadamente NO* en `montos_por_cobrar`/`detalle_pagos`: la facturación mensual insertaría ~1,700 filas de auditoría por ciclo (ruido y storage del Free Tier); esos movimientos ya quedan narrados a través del evento del pago.

### 2.3 UI — Timeline (reescritura de `auditoria-list.component.ts`)

Sin librerías nuevas (SVG inline como todo el proyecto, estilo TailAdmin, dark mode):

```
┌─ Auditoría — Registro de Actividad ───────────────────────────────┐
│ [Todas ▾ Entidad] [Todas ▾ Acción] [🔎 buscar persona/recibo]     │
├───────────────────────────────────────────────────────────────────┤
│  HOY · 07 julio 2026                                              │
│  ● 09:35  ✏️ EDICIÓN            María López · Caja                │
│  │  Modificó el socio PAREDES, Oscar                              │
│  │  · Teléfono:  987654321  ➔  999888777                          │
│  │  ▸ Motivo: “Corrección de error de tipeo solicitada…”          │
│  ● 10:00  💵 PAGO               Ana Gómez · Caja                  │
│  │  Registró el recibo PAG-0001524 · PAREDES, Oscar · S/ 145.00   │
│  │  [Agua] [Luz] [G. Administrativos]                             │
│  AYER · 06 julio 2026                                             │
│  ● 15:20  🗑 RETIRO             Carlos Rojas · Administrador      │
│     Retiró el almacén DEPOSITO 5-D1 del socio PÉREZ, Juan         │
│     · Estado: Activo ➔ Desasignado                                │
│                            [ Cargar más ]                         │
└───────────────────────────────────────────────────────────────────┘
```

- **Estructura**: un solo componente standalone con signals (patrón del proyecto) + `auditoria-labels.ts` (diccionario `COLUMN_LABELS`, `TABLA_LABELS`, formatters de valores: fechas → `dd/mm/yyyy`, montos → `S/`, booleanos → Sí/No, `deleted_at` → Activo/Anulado).
- Línea vertical con nodos coloreados por acción (verde creación, ámbar edición, rojo anulación/retiro), agrupación por día ("HOY", "AYER", fecha), tarjetas con actor+rol, narrativa, deltas "Antes ➔ Ahora" y callout de motivo.
- Filtros server-side (entidad, acción, búsqueda) + **keyset pagination** ("Cargar más" con `p_before`), en lugar del `limit 100` fijo actual.
- `AuditoriaService` se reescribe para consumir la RPC (se elimina la lectura directa de `audit_logs`).
- Se conserva un botón "Ver JSON técnico" por tarjeta (colapsable) para no perder la vista de programador.

---

## 3. Secuencia de trabajo

| # | Entregable | Toca |
|---|---|---|
| 1 | Migración `00086_auditoria_narrativa.sql`: columna `motivo`, trigger v2, triggers nuevos (ocupaciones_almacenes, gastos, caja_ajustes), `rpc_auditoria_timeline`, `rpc_actualizar_con_motivo`, `p_motivo` en RPCs críticos, limpieza del bloque muerto de `rpc_cc_editar_pago` | `supabase/migrations/` |
| 2 | `auditoria-labels.ts` (diccionario + formatters) | `pages/auditoria/` |
| 3 | `AuditoriaService` v2 (RPC + paginación) | `core/services/` |
| 4 | Timeline UI (reescritura de `auditoria-list.component.ts`) | `pages/auditoria/` |
| 5 | Campo "Motivo" en formularios de edición de socio/inquilino + modal de motivo en anulaciones que aún no lo pidan | `pages/socios/` |
| 6 | `ng build` + verificación | — |

**No se toca**: la tabla `audit_logs` existente (solo se le añade una columna nullable — los logs históricos siguen siendo legibles por la RPC), fórmulas financieras, RLS.

---

## 4. Preguntas antes de ejecutar

1. **Alcance de triggers nuevos**: ¿confirmas auditar también `gastos` y `caja_ajustes` (además de `ocupaciones_almacenes`, que es imprescindible)?
2. **Motivo obligatorio u opcional**: en las ediciones del padrón (teléfono, dirección…), ¿el motivo es opcional? En anulaciones ya es obligatorio hoy y así se mantiene.
3. **Retención**: el timeline pagina de 50 en 50 sin límite de antigüedad. ¿Correcto, o quieres un corte visual (p. ej. solo último año)?
