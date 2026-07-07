# ARCHITECTURE.md — Decisiones Arquitectónicas

> Registro de las decisiones estructurales del SistemaCooperativa y su justificación.
> Audiencia: desarrolladores e IAs que necesiten entender **por qué** el sistema es como es antes de tocarlo.
> Última actualización: 2026-07-07 (post-auditoría funcional; ver [AUDITORIA_2026.md](AUDITORIA_2026.md)).

---

## ADR-01 · La lógica financiera vive en PostgreSQL (RPC), no en Angular

Toda escritura financiera con más de un paso (`rpc_procesar_pago`, `anular_pago`, `rpc_recaudacion_masiva`, `rpc_transferir_puesto`, `generar_cargos_fijos_mes`…) es un stored procedure `SECURITY DEFINER` con chequeo de rol (`get_my_rol()`) al inicio. **Razón:** atomicidad real (un fallo de red del cliente no deja pagos sin detalle) y una sola implementación de la regla, independiente del frontend. El frontend nunca encadena inserts dependientes.

## ADR-02 · Fuente única de deuda: `fn_deudas_pagador` (migración 00082)

La deuda consolidada de una persona = cargos personales (`socio_id`) ∪ puestos vigentes (`historial_titularidad` / `historial_arriendos`) ∪ almacenes vigentes (`ocupaciones_almacenes`). Esa unión vive en **una sola función** (`fn_deudas_pagador(tipo, id)`, sin exposición PostgREST) y cuatro wrappers la consumen: `rpc_caja_cargar_deudas` (Caja y Padrón), `rpc_public_cargar_deudas` (portal anónimo), `rpc_cc_detalle_persona` y `rpc_cc_listar_personas`.

**Razón:** antes de 00082 cada módulo reimplementaba el filtro y divergían (Caja no veía almacenes y no podía cobrarlos). **Regla derivada:** ninguna vista nueva reimplementa el predicado; delega en la función o en `rpc_caja_cargar_deudas`.

## ADR-03 · Reportes agregan en el servidor y devuelven UN valor JSON (00085)

PostgREST limita las respuestas a **1000 filas por defecto**; sumar filas crudas en el navegador producía totales anuales silenciosamente incompletos y quemaba egress del Free Tier. Los reportes (00085: `rpc_reporte_resumen`, `rpc_reporte_detalle_concepto`, `rpc_reporte_detalle_egresos`) y el timeline de auditoría (00086) agregan en SQL y devuelven `json` — un solo valor no está sujeto al límite de filas. El drill-down se carga lazy (una RPC por fila expandida, cacheada por filtros) y la exportación Excel pide el detalle completo en una sola llamada (`p_concepto = NULL`).

## ADR-04 · Zona horaria: fechas de negocio en hora de Lima

- Columnas `date` (gastos, movimientos bancarios, aperturas) se filtran con strings `YYYY-MM-DD` calculados en la zona del navegador (helpers `fechaLocal`/`calcularRango` en `reportes.service.ts`).
- Columnas `timestamptz` (pagos, ingresos internos, recaudación) se filtran en SQL con `p_desde::timestamp AT TIME ZONE 'America/Lima'` y límite superior **exclusivo** `(p_hasta + 1 día)`. El literal `'America/Lima'` está deliberadamente fijo: la cooperativa es una entidad física en Perú; un admin viajando no debe desplazar el corte del día contable.

## ADR-05 · Soft-delete universal + inmutabilidad de recibos

Prohibido `DELETE` en tablas financieras y de personas (RLS sin policy de DELETE = denegado estructural). La anulación escribe `deleted_at`, `anulado_por`, `motivo_anulacion` (CHECK de consistencia: los tres NULL o los tres llenos) y cascada soft a `detalle_pagos`, restaurando estados de deuda y saldo a favor (`anular_pago`, 00030). Los recibos emitidos son inmutables: correcciones = anulación + recibo nuevo. *Excepción tolerada y auditada:* `rpc_cc_editar_pago` permite ajustar solo `comprobante` y `fecha_pago` de un pago vigente.

## ADR-06 · Auditoría: bitácora técnica inmutable + narrativa resuelta al leer (00016 → 00086)

`audit_logs` guarda el evento crudo (payloads jsonb, append-only, RLS solo-Admin, sin UPDATE/DELETE posible) vía un único trigger genérico `log_audit_action()`. La **traducción a lenguaje humano no se guarda: se calcula al leer** en `rpc_auditoria_timeline` (actor+rol por JOIN a `perfiles`, entidad resuelta desde el propio payload — funciona aunque el registro haya sido borrado —, acción semántica derivada del delta, deltas campo a campo). Las **etiquetas** de columnas viven en el frontend (`auditoria-labels.ts`): cambiar un rótulo no requiere migración.

**Motivos:** viajan por la variable transaccional `set_config('app.audit_motivo', ..., true)` que el trigger lee (se autolimpia al terminar la transacción); los RPCs que ya persisten motivo en la fila (`motivo_anulacion`, `motivo_cierre`) aparecen retroactivamente porque el timeline los extrae del delta. Las ediciones directas del padrón pasan por `rpc_actualizar_con_motivo` (whitelist dura de columnas).

**Exclusión deliberada:** `montos_por_cobrar`/`detalle_pagos` no tienen trigger — la facturación mensual generaría ~1,700 filas de ruido por ciclo; esos movimientos se narran a través del evento del pago.

## ADR-07 · Paginación keyset, no offset

Listas potencialmente largas (timeline de auditoría) paginan por cursor (`p_before = created_at` del último elemento) en lugar de OFFSET. Estable ante inserciones concurrentes y sin costo creciente por página.

## ADR-08 · Excel con SheetJS bajo `import()` dinámico

`xlsx` está en `dependencies` pero **solo** se importa dentro de `ExcelExportService.exportar()` (código-split de esbuild): ~800 KB que el usuario descarga únicamente si exporta. El sistema solo **genera** XLSX (nunca parsea archivos subidos por usuarios), lo que neutraliza la superficie de los CVEs conocidos de la librería. PDFs: `pdfmake` (tickets térmicos 80mm y A4, configurables por `configuracion_recibos`).

## ADR-09 · Frontend: Standalone + Signals, PostgREST solo para lecturas simples

Sin `NgModule`; estado con `signal/computed/effect` (RxJS mínimo). Lecturas simples de una tabla van por PostgREST directo; **cualquier lectura que cruce >2 tablas o agregue → RPC**. Componentes de página autocontenidos con template inline (patrón TailAdmin, dark mode obligatorio, SVG inline sin librerías de iconos).

## ADR-10 · Migraciones numeradas como historia inmutable

`supabase/migrations/000NN_descripcion.sql`, secuenciales, con cabecera explicando el *porqué*. Las migraciones de datos (00048–00083) documentan cada decisión de empate en comentarios — eso permitió reconstruir los 173 conceptos huérfanos de 00077 parseando sus propios comentarios (`00083`, generado por `scripts/generar_regularizacion_00083.cjs`). Los generadores viven en `scripts/` y producen SQL idempotente con `RAISE NOTICE '... SKIP ...'` para casos no resolubles.

## Deudas arquitectónicas conocidas (aceptadas o pendientes)

| Tema | Estado |
|---|---|
| `rpc_procesar_pago` sin `FOR UPDATE` (carrera entre cajas) | **Pendiente — prioridad alta** ([TODO.md](TODO.md)) |
| Dietas/Provisión fuera del circuito de caja | **Pendiente — prioridad alta** |
| `perfiles`, `configuraciones`, `beneficios_socios` sin trigger de auditoría | Pendiente (quick win) |
| Estado `Cancelado` con doble semántica (anulado vs pagado-en-migración) | Aceptada y documentada; las vistas lo excluyen igual |
| Arqueo por PostgREST (no RPC) | Aceptada mientras el volumen diario sea bajo |
| Desglose por concepto del arqueo vs total del día (saldo a favor) | Aceptada por decisión del cliente (2026-07-07) |
| Rol `Asistente` a medio implementar | Pendiente de decisión de negocio |
