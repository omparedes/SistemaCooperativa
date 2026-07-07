# AUDITORÍA FUNCIONAL 2026 — SistemaCooperativa

> **Fecha:** 2026-07-07 · **Auditor:** Claude Code (rol: Arquitecto/Inspector, solo lectura)
> **Alcance:** 9 módulos funcionales + capa de datos (migraciones 00001–00086).
> **Método:** lectura directa de componentes, servicios, RPCs y políticas RLS. Ningún archivo de código fue modificado durante esta auditoría.

## Resumen Ejecutivo

El sistema está **sano en su núcleo financiero**: la deuda consolidada tiene una única fuente de verdad (`fn_deudas_pagador`, 00082), toda escritura financiera crítica es ACID vía RPC, el soft-delete es consistente en las tablas de dinero, y la auditoría (00086) es inmutable y narrativa. Los riesgos residuales se concentran en **(1) concurrencia en el cobro** (sin bloqueo de fila, dos cajeros pueden sobre-pagar la misma deuda), **(2) el módulo de Dietas/Provisión Social**, que mueve dinero real sin integrarse al arqueo de caja ni a la auditoría, y **(3) deuda técnica de prototipos** (helpers duplicados, `any` en un servicio, rol `Asistente` a medio implementar).

| Módulo | Salud | Prioridad de atención |
|---|---|---|
| Caja (Wizard de pago) | Buena | **Alta** (concurrencia) |
| Dietas y Provisión Social | Frágil | **Alta** |
| Usuarios y Seguridad | Buena con huecos | **Media-Alta** |
| Socios | Buena | Media |
| Inquilinos | Buena | Media |
| Cuenta Corriente | Buena | Media |
| Reportes y Arqueo | Muy buena (recién renovada) | Baja |
| Consultas (Portal Público) | Buena | Baja |
| Configuración | Buena | Baja |

---

## 1. Socios (Padrón)

**¿Qué hace?** Padrón maestro de asociados: identidad, estado (Activo/Inactivo), habilitación, titularidad de puesto principal (`historial_titularidad`), almacenes (`ocupaciones_almacenes`), toggles de cargos fijos (G. Adm / P. Social), deudas pendientes, historial de pagos con reimpresión de recibos, y pestañas de Dietas/Provisión Social.

**¿Cómo funciona?** `socios.service.ts` (PostgREST para lectura; `rpc_actualizar_con_motivo` para edición desde 00086; `rpc_eliminar_socio` para baja; `rpc_gestionar_titularidad` para puesto; `toggle_cargo_socio`). Las deudas del detalle usan `rpc_caja_cargar_deudas` (misma fuente canónica que Caja/CC/Público). `socio-detail` se suscribe por Realtime a nuevos pagos del socio.

**Riesgos.** (a) La creación (`crear`) sigue siendo un `.insert()` PostgREST directo sin RPC — si falla la asignación de titularidad posterior, queda un socio sin puesto (recuperable manualmente, no huérfano crítico). (b) DNI temporal autogenerado `TEMP_XXXXXXXX` en el formulario cuando se omite el DNI: útil en migración, pero en producción permite crear socios sin identidad real sin advertencia visual fuerte.

**Inconsistencias.** El campo `habilitado` existe y es editable por la whitelist, pero **no hay proceso que lo recalcule** tras cierres/pagos (la regla de negocio dice "se recalcula en cada cierre o pago" — hoy es puramente manual).

**Código duplicado.** `fmtSoles`/`formatPeriodo`/formateadores de fecha replicados en socio-detail, inquilino-detail, wizard, consultas, reportes y arqueo (6+ copias privadas).

**Mejoras propuestas.** RPC `rpc_crear_socio` atómico (alta + titularidad opcional); job o trigger de recálculo de `habilitado`; extraer helpers de formato a `shared/utils/formato.ts`.

**Deuda técnica.** Ninguna grave; el componente detail es grande (~1100 líneas) y mezclaría bien con subcomponentes de pestañas.

**Prioridad: Media.**

## 2. Inquilinos

**¿Qué hace?** Padrón paralelo de arrendatarios (incluye tipo `Tercero`, que solo puede ocupar almacenes). Arriendo vigente vía `historial_arriendos`, deudas, historial de pagos, reimpresión.

**¿Cómo funciona?** Espejo de Socios: `inquilinos.service.ts` + `rpc_eliminar_inquilino` + `rpc_actualizar_con_motivo` + `gestionarArriendo`. Deudas por `rpc_caja_cargar_deudas` (incluye almacenes del inquilino desde 00082).

**Riesgos.** Los mismos del padrón de socios (creación no atómica, DNI temporal).

**Inconsistencias.** El inquilino no tiene `estado` propio en la UI (se muestra 'Activo' hardcodeado en las RPCs de CC); la regla "inquilino solo paga deudas del puesto que ocupa mientras `estado_arriendo = Vigente`" se garantiza por resolución de puestos vigentes, no por validación explícita en `rpc_procesar_pago` (un `p_inquilino_id` arbitrario con distribución manual pasaría).

**Código duplicado.** `inquilino-form` ≈ `socio-form` (~80 % idéntico); `inquilino-detail` ≈ `socio-detail` en anulación/PDF/historial.

**Mejoras.** Validar en `rpc_procesar_pago` que el pagador tenga relación vigente con los `monto_id` de la distribución; unificar formularios de persona en un componente parametrizado.

**Prioridad: Media.**

## 3. Caja (Registro de Pagos / Wizard)

**¿Qué hace?** Cobro en 3 pasos: búsqueda de pagador → distribución FIFO automática o manual sobre las deudas consolidadas (puesto + personales + almacenes) → confirmación, recibo inmutable y ticket PDF (80mm/A4). Maneja saldo a favor (uso y generación de excedente). Incluye Caja Rápida (ingresos internos sin recibo) y Recaudación semanal por tarjeta.

**¿Cómo funciona?** `pago-wizard.component.ts` + `PagosService`: `rpc_caja_cargar_deudas` (00082) para las deudas, `rpc_procesar_pago` v3 (00031) para el cobro ACID (inserta pago + detalles, marca `Pagado`, ajusta `saldo_a_favor`), `anular_pago` (00030) para reversas con soft-delete en cascada. La recaudación masiva usa `rpc_recaudacion_masiva` (abonos → `saldo_a_favor`).

**Riesgos.**
1. **Concurrencia (el riesgo más importante del sistema):** `rpc_procesar_pago` confía en la distribución calculada por el cliente y **no bloquea (`SELECT ... FOR UPDATE`) ni revalida el saldo** de cada `monto_id` al insertar el detalle. Dos cajeros cobrando a la misma persona simultáneamente (o un doble clic que evada el guard de UI) pueden aplicar dos pagos completos a la misma deuda. La sobre-aplicación queda detectable (consulta 4 de `scripts/deteccion_recibos_huerfanos.sql`) pero no prevenida.
2. `saldo_a_favor = saldo_a_favor + ...` sin bloqueo de fila: carrera teórica entre wizard y recaudación masiva simultáneos.
3. `buscarPagador` interpola el término de búsqueda en un filtro `.or(...)` de PostgREST; un término con comas/paréntesis puede alterar el filtro (no es inyección SQL — PostgREST lo parsea — pero puede romper la búsqueda o ampliar resultados). Sanitizar.

**Inconsistencias.** `rpc_procesar_pago` marca deudas cubiertas como `'Pagado'`, pero las migraciones de datos (00077) usaron `'Cancelado'` para lo mismo — el estado `Cancelado` tiene doble semántica histórica (anulado por admin vs. pagado en migración). Las vistas lo excluyen igual, así que no hay impacto de saldo, pero confunde en CC.

**Código duplicado.** `PagosService.buscarPagador` (3 queries PostgREST) duplica la lógica de `rpc_public_buscar_pagador`; dos modelos distintos llamados `DeudaItem` (en `pago.model.ts` y `cuenta-corriente.model.ts`).

**Mejoras.** En `rpc_procesar_pago`: `FOR UPDATE` sobre los `montos_por_cobrar` de la distribución + revalidación `aplicado + nuevo <= monto (+tolerancia)` con excepción clara; renombrar uno de los `DeudaItem`.

**Deuda técnica.** El wizard concentra ~1000 líneas (aceptable pero al límite).

**Prioridad: ALTA** (por el punto de concurrencia; es dinero real en Go-Live).

## 4. Cuenta Corriente (Gestión Financiera)

**¿Qué hace?** Dashboard financiero por persona: deuda consolidada, saldo a favor, cargos manuales, abonos con fecha retroactiva, edición de comprobante/fecha de pago, anulación de cargos y pagos.

**¿Cómo funciona?** `rpc_cc_listar_personas` y `rpc_cc_detalle_persona` (delegadas a `fn_deudas_pagador` desde 00082 — idénticas a Caja/Público), `rpc_procesar_pago` (abonos), `rpc_cc_editar_pago` v2 (00086, con motivo), `rpc_anular_cargo`, `anular_pago`. Modificación de cargo pendiente vía `.update()` directo sobre `montos_por_cobrar`.

**Riesgos.** La **modificación de monto de un cargo** es un `.update()` PostgREST directo (sin RPC, sin motivo, y `montos_por_cobrar` no tiene trigger de auditoría): un cargo puede cambiar de S/ 200 a S/ 2 sin rastro narrativo. Es la brecha de auditoría más relevante que queda.

**Inconsistencias.** El motivo de `rpc_anular_cargo` se guarda en la fila pero no llega al timeline (montos sin trigger — decisión deliberada de 00086 por volumen; el caso "modificar cargo" merece excepción).

**Mejoras.** Convertir "modificar cargo" en RPC con motivo obligatorio y auditoría dirigida (insert manual a `audit_logs` desde el RPC, sin trigger de tabla); mostrar `codigo_puesto` por fila de deuda en la UI (la RPC ya lo devuelve desde 00082).

**Prioridad: Media** (Alta si la modificación manual de cargos es frecuente en operación).

## 5. Reportes y Arqueo

**¿Qué hace?** (a) Central de Reportes: KPIs caja/banco, ingresos por concepto con drill-down a línea de recibo, egresos por categoría, filtro socios/inquilinos, exportación Excel 4 hojas. (b) Arqueo diario: efectivo físico en gaveta (`apertura + efectivo − gastos − faltantes + sobrantes`), desglose por concepto y método, aperturas/ajustes, PDF de cierre. (c) Reporte anual de Dietas/Provisión.

**¿Cómo funciona?** Reportes v2 con RPCs agregadas server-side (00085: `rpc_reporte_resumen/detalle_concepto/detalle_egresos`) — evita el límite de 1000 filas de PostgREST que recortaba silenciosamente los totales anuales. Arqueo: `ReportesService.cargarArqueo` (queries PostgREST del día, volumen acotado). Excel: `ExcelExportService` (SheetJS con `import()` dinámico).

**Riesgos.** Auditados en detalle el 2026-07-07: anulados excluidos, efectivo/transferencia separados, fórmula fiel a las reglas. Riesgo residual: el arqueo de un día pasado cambia retroactivamente si hoy se anula un pago de esa fecha (propiedad del diseño, aceptada por el cliente).

**Inconsistencias (aceptadas, documentadas).** El desglose por concepto del arqueo suma `monto_aplicado` mientras el KPI suma `monto_total`: no cuadran exactamente cuando interviene saldo a favor. El cliente decidió dejarlo intacto.

**Deuda técnica.** `cargarArqueo` sigue en PostgREST (6 queries + batch de perfiles); candidato natural a RPC si el volumen diario crece.

**Prioridad: Baja.**

## 6. Consultas (Portal Público)

**¿Qué hace?** Consulta anónima de deuda por DNI/nombre/puesto, con historial de pagos y reimpresión de recibos en PDF, sin login.

**¿Cómo funciona?** RPCs `SECURITY DEFINER` con grant a `anon`: `rpc_public_buscar_pagador` (con enmascaramiento de PII, 00047), `rpc_public_cargar_deudas` (delegada a `fn_deudas_pagador`, 00082) y `rpc_public_obtener_historial` (con `codigo_puesto` por línea, 00084). Paridad total de datos con el panel administrativo.

**Riesgos.** Sin rate-limiting propio (depende del de Supabase): el buscador anónimo permite enumeración de nombres del padrón por fuerza bruta paciente. El historial expone montos y conceptos de cualquier persona a quien conozca un nombre — decisión de negocio consciente (transparencia cooperativa), pero conviene dejarla escrita.

**Mejoras.** CAPTCHA ligero o umbral de intentos en el edge si la enumeración preocupa a la Junta.

**Prioridad: Baja.**

## 7. Dietas y Provisión Social

**¿Qué hace?** Registra beneficios entregados a socios (dietas por asamblea, apoyos por salud/luto) con reporte anual agrupado. Tabla `beneficios_socios` (00081), pestañas en socio-detail y `beneficios-reporte.component`.

**¿Cómo funciona?** `beneficios.service.ts` con PostgREST directo (insert / select / soft-delete por update). RLS Admin|Caja.

**Riesgos (el módulo más frágil del sistema).**
1. **Dinero fuera del circuito de caja:** una dieta es dinero físico que sale de la cooperativa, pero **no descuenta del arqueo ni aparece en la Central de Reportes** — el "Efectivo en Gaveta" del día en que se pagan dietas cuadrará mal contra la realidad, o las dietas se pagan por fuera de gaveta sin que el sistema lo sepa. Falta definir el flujo: ¿toda dieta genera un `gasto` (categoría "Dietas"/"Provisión Social") o un movimiento bancario?
2. **Sin auditoría:** `beneficios_socios` no tiene trigger `log_audit_action()`; crear/borrar beneficios no deja rastro en el timeline.
3. **Soft-delete sin motivo y con convención distinta:** usa `deleted_by` (el resto del sistema usa `anulado_por` + `motivo_anulacion`), y el borrado no pide justificación.

**Inconsistencias.** `as any[]` en el servicio (viola el estándar estricto del proyecto); RLS de UPDATE permite a Caja modificar montos históricos sin restricción ni rastro.

**Mejoras.** (a) Trigger de auditoría en `beneficios_socios`; (b) decisión de negocio + implementación: enlazar cada beneficio a un egreso de caja o banco; (c) motivo obligatorio al eliminar; (d) tipado estricto.

**Prioridad: ALTA** (es el único módulo que mueve dinero sin trazabilidad completa).

## 8. Usuarios y Seguridad (Roles, RLS, Auth)

**¿Qué hace?** Sesión Supabase Auth con perfil espejo (`perfiles`), roles `Administrador | Caja | Asistente`, guards de ruta (`authGuard`, `adminGuard`, `noAuthGuard`), gestión de usuarios (cambio de rol, activar/desactivar) solo Admin.

**¿Cómo funciona?** `auth.service.ts` (signals `esAdmin`/`esCaja`, espera de inicialización para guards, desactivación efectiva al no cargar perfil `activo=false`). RLS por `get_my_rol()` (SECURITY DEFINER, 00008) en todas las tablas; DELETE bloqueado estructuralmente (sin policy). `usuarios.component.ts` edita `perfiles` con `.update()` directo.

**Riesgos.**
1. **Auto-degradación / último admin:** un Administrador puede cambiarse su propio rol o desactivarse; si es el único, el sistema queda sin administración (rescate solo por SQL directo).
2. **Cambios de rol sin auditoría:** `perfiles` no tiene trigger — promover a Administrador o desactivar un usuario no aparece en el timeline. Para un auditor externo, este es el evento más sensible de todos.
3. Rol **`Asistente` a medio implementar:** existe en el enum y en la matriz RLS (solo lectura), pero los RPCs financieros y de reportes exigen `Administrador|Caja`; un Asistente ve la app con pantallas que fallan al cargar. O se completa (guards + vistas de solo lectura) o se retira del alta por defecto (`tg_handle_new_user` asigna 'Asistente' a todo usuario nuevo).

**Mejoras.** Trigger de auditoría en `perfiles`; regla "no puedes editarte a ti mismo / debe quedar ≥1 admin activo" (mejor en un RPC `rpc_gestionar_usuario`); decidir el destino del rol Asistente.

**Prioridad: Media-Alta.**

## 9. Configuración

**¿Qué hace?** (a) Tarifas parametrizables (precio kWh, alumbrado, cuotas fijas) sobre la tabla `configuraciones` (00010/00046) que alimentan la facturación. (b) Identidad visual de recibos (`configuracion_recibos`, singleton 00034) con live-preview, consumida por `PdfGeneratorService` con caché.

**¿Cómo funciona?** `tarifas.component.ts` y `recibos-config.component.ts` con updates directos protegidos por RLS de Administrador; los RPCs de facturación leen las tarifas al generar cargos y las persisten en cada medición para reproducibilidad histórica.

**Riesgos.** Cambiar una tarifa no queda en el timeline (`configuraciones` sin trigger de auditoría) — para un ERP financiero, el cambio de precio del kWh es exactamente el tipo de evento que la Junta quiere ver firmado.

**Mejoras.** Trigger `log_audit_action()` en `configuraciones` y `configuracion_recibos` (volumen bajísimo, costo nulo).

**Prioridad: Baja** (esfuerzo mínimo, valor alto — candidata a "quick win" junto con `perfiles`).

---

## Hallazgos Transversales

**Duplicación de código (consolidado).**
- Formateadores (`fmtSoles`, fechas, periodos): 6+ copias privadas → extraer a `shared/utils/`.
- `socio-form` vs `inquilino-form` y `socio-detail` vs `inquilino-detail`: pares casi gemelos.
- Dos interfaces `DeudaItem` con shape distinto (pagos vs cuenta-corriente).
- `PagosService.buscarPagador` vs `rpc_public_buscar_pagador` (misma búsqueda, dos implementaciones).

**Deuda técnica de datos/migraciones.**
- Migración con timestamp `20260607063839_filtro_dashboard.sql` conviviendo con la numerada `00060_filtro_dashboard.sql` (mismo contenido aparente): riesgo de doble aplicación en un reset; consolidar nomenclatura.
- `xlsx@0.18.5` (SheetJS OSS) tiene CVEs conocidos de prototype pollution/ReDoS con archivos hostiles; aquí solo **genera** archivos (no parsea input no confiable), riesgo bajo pero documentado.
- Semántica doble del estado `Cancelado` (anulado vs pagado-en-migración).
- `implementation_plan.md` es un archivo de trabajo transitorio (candidato a carpeta `docs/` o a .gitignore).

**Fortalezas a preservar.**
- `fn_deudas_pagador` como única fuente de deuda (00082) — cualquier vista nueva debe delegarle.
- Agregación server-side con JSON único para reportes (00085) — patrón obligatorio para rangos amplios.
- Auditoría inmutable con motivo transaccional (`app.audit_motivo`, 00086).
- Convención de migraciones: numeradas, comentadas, idempotentes donde importa.

## Matriz de Priorización

| # | Acción | Módulo | Categoría | Prioridad |
|---|---|---|---|---|
| 1 | `FOR UPDATE` + revalidación de saldo en `rpc_procesar_pago` | Caja | Integridad | **Alta** |
| 2 | Integrar Dietas/Provisión al circuito de egresos (gasto o banco) | Beneficios | Integridad | **Alta** |
| 3 | Triggers de auditoría en `beneficios_socios`, `perfiles`, `configuraciones` | Transversal | Trazabilidad | **Alta** (esfuerzo bajo) |
| 4 | Regla "último admin" + RPC de gestión de usuarios | Seguridad | Seguridad | Media-Alta |
| 5 | RPC con motivo para "modificar cargo" de CC | Cuenta Corriente | Trazabilidad | Media |
| 6 | Decidir destino del rol `Asistente` | Seguridad | UX/Seguridad | Media |
| 7 | Validación pagador↔deuda en `rpc_procesar_pago` | Caja | Integridad | Media |
| 8 | Extraer helpers de formato compartidos; renombrar `DeudaItem` duplicado | Transversal | Limpieza | Media |
| 9 | Recalculo automático de `habilitado` | Socios | Negocio | Media |
| 10 | Sanitizar término de búsqueda en filtros `.or()` PostgREST | Caja | Robustez | Baja |
| 11 | Unificar formularios/detalles socio-inquilino | Padrón | Limpieza | Baja |
| 12 | Consolidar migración timestamp duplicada 00060 | Datos | Limpieza | Baja |

*(El detalle accionable vive en [TODO.md](TODO.md).)*
