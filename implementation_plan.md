# Plan de Implementación — Central de Reportes v2 + Auditoría de Arqueo

> **Estado: APROBADO Y EJECUTADO** (2026-07-07). Decisiones del cliente: arqueo intacto
> (sin filas de conciliación), limpieza de huérfanos aprobada, columna Cajero solo Admin.
> Pendiente del lado del cliente: `supabase db push` (migración 00085) + `npm install`.
> Fecha: 2026-07-07 · Autor: Claude Code

---

## 1. Diagnóstico del estado actual

### 1.1 Central de Reportes (`reportes.component.ts`)

- El componente usa **template inline** y solo muestra 3 tarjetas estáticas por sección (Caja, Banco, Almacén). No hay desglose por concepto, ni drill-down, ni filtros de pagador, ni exportación.
- `ReportesService.cargarReporteConsolidado()` hace **5 queries PostgREST crudas** que descargan *todas las filas* del rango (`select monto_total` de cada pago). Para el rango "Este Año" eso significa miles de filas transferidas solo para sumarlas en el navegador. Riesgos:
  - **Free Tier**: tráfico innecesario (egress) en cada visita a la pantalla.
  - **Límite de 1000 filas** de PostgREST: si un rango supera 1000 pagos, los totales salen **silenciosamente incompletos** (hoy el año ya bordea ese volumen). Este es el defecto más grave del módulo actual.
- El total "Caja Física · Ingresos" **mezcla efectivo y transferencias** — semánticamente incorrecto según CLAUDE.md §4.2 (las transferencias no entran a gaveta).
- `reportes.component.html` es un **archivo huérfano** (el componente usa template inline; ese HTML referencia `apx-chart`, `ngModel` y métodos que no existen en ninguna clase). Igualmente `registro-pago.component.ts` (ruta `pagos/registrar/:id`) sigue usando **datos mock** — la caja real es `pago-wizard`. Propongo limpieza en la fase final.

### 1.2 Auditoría del Arqueo de Caja (`arqueo-caja.component.ts` + `cargarArqueo`)

**Veredicto: la lógica central está correcta — se deja intacta.** Verificado:

| Punto auditado | Resultado |
|---|---|
| Pagos anulados | ✅ Se listan (tachados) pero se excluyen de `total_efectivo`/`total_transferencia` y del desglose por concepto. `anular_pago` soft-deletea también `detalle_pagos`, así que no hay fugas. |
| Efectivo vs Transferencia | ✅ Separados; transferencias no entran a `efectivo_fisico_caja`. |
| Fórmula de gaveta | ✅ `apertura + efectivo − gastos − faltantes + sobrantes` — idéntica a CLAUDE.md §4.2. Los `gastos` no tienen método de pago (los egresos bancarios viven en `movimientos_bancarios`), así que restar el 100 % de gastos de la gaveta es correcto por diseño. |
| Recaudación tarjeta / ingresos internos | ✅ Suman a efectivo y al desglose; filtro "solo mi caja" deliberadamente no aplica a recaudación (operación masiva). |

**Dos observaciones menores** (no rompen el cuadre, decisión aparte):

- **(A) Desglose por concepto vs Total del día**: la tabla "Desglose por concepto" suma `monto_aplicado` de los detalles, mientras el KPI "Total Recaudado" suma `monto_total` de los pagos. Cuando un pago usa **saldo a favor** (detalle > dinero recibido) o deja **excedente a saldo a favor** (detalle < dinero recibido), la tabla no suma exactamente el total del día. *Propuesta opcional*: añadir dos filas sintéticas de conciliación "(+) Saldo a favor utilizado" y "(−) Excedente a saldo a favor" al pie de la tabla. No toco nada si prefieres dejarlo.
- **(B) Anulaciones retroactivas**: si hoy se anula un pago de ayer, el arqueo de ayer cambia retroactivamente (el PDF impreso ayer ya no coincide). Es una propiedad del diseño actual, la documento pero no propongo cambio.

---

## 2. Diseño propuesto

### 2.1 Capa SQL — Migración `00085_rpc_reportes_drilldown.sql`

Tres RPCs `SECURITY DEFINER` (rol `Administrador | Caja`, mismo patrón `get_my_rol()` del proyecto). Todas devuelven **un solo valor JSON** (evita el límite de 1000 filas y minimiza egress: la agregación ocurre en Postgres).

**Parámetros comunes**: `p_desde date, p_hasta date, p_tipo_pagador text DEFAULT 'todos'` (`'todos' | 'socios' | 'inquilinos'`). El frontend seguirá calculando el rango con los pills existentes (hoy/semana/mes/año) — la lógica temporal no cambia, solo se pasa como fechas explícitas.

1. **`rpc_reporte_resumen(p_desde, p_hasta, p_tipo_pagador)`** → reemplaza los 5 queries de `cargarReporteConsolidado`. Devuelve:
   ```json
   {
     "caja":  { "efectivo": 0, "transferencia": 0, "ingresos_internos": 0,
                "recaudacion_tarjeta": 0, "egresos": 0, "saldo": 0,
                "count_recibos": 0, "count_internos": 0, "count_anulados": 0 },
     "banco": { "ingresos": 0, "egresos": 0, "saldo": 0, "count": 0 },
     "por_concepto": [
       { "concepto": "Luz", "monto": 0, "cantidad": 0,
         "monto_socios": 0, "monto_inquilinos": 0 }
     ],
     "egresos_por_categoria": [ { "categoria": "...", "monto": 0, "cantidad": 0 } ]
   }
   ```
   - `por_concepto` se agrega desde `detalle_pagos` (activos) × `montos_por_cobrar` × `conceptos`, filtrando `pagos.deleted_at IS NULL` y el rango sobre `fecha_pago`. "Almacenes" aparece naturalmente como los conceptos `Alquiler de almacén` / `Deposito`.
   - Filtro pagador: `pagos.socio_id IS NOT NULL` → socios; `inquilino_id IS NOT NULL` → inquilinos. Los **ingresos internos** (sin pagador) solo se incluyen con `'todos'`, como fila propia por concepto.
   - Separa efectivo/transferencia (corrige la mezcla semántica actual de "Ingresos Caja").

2. **`rpc_reporte_detalle_concepto(p_desde, p_hasta, p_concepto text, p_tipo_pagador)`** → el drill-down. JSON array de líneas:
   ```json
   [ { "fecha_pago": "...", "codigo_transaccion": "PAG-...", "recibo_anulado": false,
       "pagador": "APELLIDOS, Nombres", "tipo_pagador": "socio",
       "codigo_puesto": "A-12", "periodo": "2026/05",
       "monto_aplicado": 43.50, "metodo_pago": "Efectivo" } ]
   ```
   - `p_concepto = NULL` → **todas** las líneas del rango (lo usa la exportación Excel para la hoja de detalle completo).
   - Orden: `fecha_pago DESC`. Solo detalles y pagos vigentes.

3. **`rpc_reporte_detalle_egresos(p_desde, p_hasta, p_categoria text DEFAULT NULL)`** → drill-down de gastos (fecha, comprobante, responsable, categoría, descripción, monto).

*Nota*: no toco ninguna RPC existente; el arqueo diario queda intacto.

### 2.2 Capa servicio (Angular)

- **`ReportesService`**: nuevos métodos `cargarResumenV2(rango, tipoPagador)`, `cargarDetalleConcepto(...)`, `cargarDetalleEgresos(...)` que llaman a las RPCs. `calcularRango()` existente se reutiliza (misma lógica temporal). `cargarReporteConsolidado` se elimina cuando la UI nueva esté lista.
- **`ExcelExportService`** (nuevo, `core/services/excel-export.service.ts`): wrapper de **SheetJS `xlsx@0.18.5`**, que **ya está en `package.json`** (devDependencies → se mueve a `dependencies`). Se carga con `import()` dinámico para no engordar el bundle inicial (~800 KB solo cuando se exporta). API: `exportar(nombreArchivo, hojas: { nombre: string; filas: Record<string, unknown>[] }[])`.
  - *Alternativa descartada*: CSV crudo — no soporta multi-hoja ni tipos numéricos limpios, y la librería ya está instalada.

### 2.3 Capa UI — reescritura de `reportes.component.ts`

Un solo componente standalone con signals (mismo estilo que `arqueo-caja`), sin modales ni componentes anidados nuevos — **tablas expansibles tipo acordeón** dentro del mismo template:

```
┌─ Central de Reportes ────────────────────────────────────────────┐
│ [Hoy] [Últimos 7 días] [Este Mes] [Este Año]   [Todos|Socios|Inq]│
│                                            [⬇ Exportar a Excel]  │
├─ KPIs Caja: Efectivo · Transferencia · Egresos · Saldo ──────────┤
├─ KPIs Banco (igual que hoy) ─────────────────────────────────────┤
├─ INGRESOS POR CONCEPTO (expansible) ─────────────────────────────┤
│ ▸ Luz                 142 recibos    S/ 8,420.50   ▓▓▓▓░ 34 %    │
│ ▾ Alquiler de almacén   6 recibos    S/ 1,200.00   ▓░░░░  5 %    │
│     22/06 PAG-000123  CALLE ALVAREZ (socio)  D-10  2026/05  S/100│
│     ...(sub-tabla lazy: se carga al expandir, 1 RPC por fila)    │
├─ EGRESOS POR CATEGORÍA (mismo patrón expansible) ────────────────┤
└─ Estado del Almacén (se conserva tal cual) ──────────────────────┘
```

- **Estado**: `rango`, `tipoPagador`, `resumen` (signals); expansión con `expandido = signal<Set<string>>` y caché `detalles = signal<Map<string, DetalleLinea[]>>` — cada concepto se pide **una sola vez** por rango/filtro (lazy), y se invalida al cambiar filtros.
- **Filtro pagador**: segmented control `Todos | Solo Socios | Solo Inquilinos` → recarga el resumen con `p_tipo_pagador` (el filtrado es 100 % server-side, coherente en resumen y detalle).
- **Exportación**: botón único que genera un libro con 4 hojas — `Resumen` (KPIs), `Por Concepto`, `Detalle Ingresos` (todas las líneas vía `rpc_reporte_detalle_concepto(NULL)`), `Egresos`. Respeta rango y filtro de pagador activos. Nombre: `reporte_YYYY-MM-DD_a_YYYY-MM-DD.xlsx`.
- Dark mode y skeletons TailAdmin como el resto del proyecto.

### 2.4 Limpieza (fase final, opcional pero recomendada)

- Eliminar `reportes.component.html` (huérfano, referencia código inexistente).
- `registro-pago.component.ts` (ruta `pagos/registrar/:id`) sigue con **datos mock**: propongo redirigir esa ruta al wizard real (`pago-wizard`) y eliminar el componente muerto. **Requiere tu confirmación** — puede haber un motivo histórico para conservarlo.

---

## 3. Secuencia de trabajo

| # | Entregable | Toca |
|---|---|---|
| 1 | Migración `00085_rpc_reportes_drilldown.sql` (3 RPCs) | `supabase/migrations/` |
| 2 | `ExcelExportService` + mover `xlsx` a dependencies | `core/services/`, `package.json` |
| 3 | Métodos nuevos en `ReportesService` | `core/services/reportes.service.ts` |
| 4 | Reescritura UI `reportes.component.ts` (drill-down + filtros + export) | `pages/reportes/` |
| 5 | (Opcional, aparte) Filas de conciliación de saldo a favor en el arqueo — hallazgo A | `reportes.service.ts` + `arqueo-caja` |
| 6 | Limpieza de huérfanos + `ng build` + verificación manual | — |

**No se toca**: fórmula de caja física, arqueo diario, RPCs existentes, módulos de pagos.

---

## 4. Preguntas antes de ejecutar

1. **Arqueo — hallazgo A**: ¿agrego las filas de conciliación de saldo a favor al desglose por concepto del arqueo, o lo dejo intacto?
2. **Limpieza**: ¿confirmas eliminar `reportes.component.html` y el `registro-pago.component.ts` mock (redirigiendo su ruta al wizard)?
3. **Drill-down**: ¿el detalle expandido debe mostrar también al **cajero** que registró cada pago (visible solo para Administrador, como en el arqueo)?
