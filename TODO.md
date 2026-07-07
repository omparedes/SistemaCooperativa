# TODO / ROADMAP — SistemaCooperativa

> Backlog derivado de la [Auditoría Funcional 2026](AUDITORIA_2026.md) (2026-07-07).
> Convención: marcar con `[x]` al completar y anotar la migración/PR que lo resolvió.

## 🔴 Integridad Financiera (Alta)

- [ ] **Bloqueo de concurrencia en el cobro**: `rpc_procesar_pago` debe hacer `SELECT ... FOR UPDATE` sobre los `montos_por_cobrar` de la distribución y revalidar `aplicado + nuevo ≤ monto` (con tolerancia de céntimos), lanzando excepción clara si otro cajero ya cobró. Hoy dos cajas simultáneas pueden sobre-pagar la misma deuda.
- [ ] **Dietas/Provisión ↔ Caja**: decidir con la Junta el flujo del dinero (¿cada beneficio genera un `gasto` con categoría propia, o un movimiento bancario?) e implementarlo. Hoy `beneficios_socios` mueve dinero real sin tocar arqueo ni reportes.
- [ ] **Validación pagador↔deuda** en `rpc_procesar_pago`: verificar que cada `monto_id` de la distribución pertenezca al ámbito del pagador (`fn_deudas_pagador`), bloqueando distribuciones manuales arbitrarias.
- [ ] Proteger `saldo_a_favor` contra carreras (UPDATE con bloqueo de fila o expresión atómica verificada).

## 🟠 Trazabilidad y Seguridad (Alta / Media-Alta)

- [ ] **Quick win — triggers de auditoría** `log_audit_action()` en: `beneficios_socios`, `perfiles`, `configuraciones`, `configuracion_recibos`, `caja_aperturas`. Volumen bajísimo, valor alto para la Junta. (Añadir las entidades nuevas a `TABLA_LABELS` en `auditoria-labels.ts`.)
- [ ] **Regla "último admin"**: RPC `rpc_gestionar_usuario` que impida que un Administrador se degrade/desactive a sí mismo o deje el sistema sin admins activos. Reemplazar los `.update()` directos de `usuarios.component.ts`.
- [ ] **Modificar cargo con motivo**: convertir la edición de monto de `montos_por_cobrar` (Cuenta Corriente) en RPC con motivo obligatorio + registro dirigido en `audit_logs` (sin trigger de tabla, por volumen de facturación).
- [ ] Motivo obligatorio al eliminar un beneficio (dieta/provisión) + convención `anulado_por`/`motivo_anulacion` en vez de `deleted_by`.
- [ ] Decidir el destino del rol **`Asistente`**: completarlo (guards + vistas de solo lectura funcionales) o eliminar su asignación por defecto en `tg_handle_new_user`.

## 🟡 Negocio / Funcional (Media)

- [ ] Recalculo automático de `socios.habilitado` tras cierre de período o pago (hoy es manual; la regla dice que debe recalcularse).
- [ ] RPC atómico `rpc_crear_socio` / `rpc_crear_inquilino` (alta + asignación de espacio en una transacción).
- [ ] Mostrar `codigo_puesto` por fila de deuda en la UI de Cuenta Corriente (la RPC ya lo devuelve desde 00082).
- [ ] Advertencia visual fuerte cuando se crea una persona con DNI temporal `TEMP_########`.
- [ ] Unificar la semántica del estado `Cancelado` (hoy significa "anulado por admin" y también "pagado" en datos migrados por 00077). Opcional: UPDATE de normalización a `Pagado` en los saldados.

## 🧹 Limpieza de Código (Media / Baja)

- [ ] Extraer formateadores compartidos (`fmtSoles`, fechas, periodos) a `shared/utils/formato.ts` (hoy hay 6+ copias privadas).
- [ ] Renombrar una de las dos interfaces `DeudaItem` (`pago.model.ts` vs `cuenta-corriente.model.ts`).
- [ ] Unificar `socio-form`/`inquilino-form` y `socio-detail`/`inquilino-detail` (pares ~80 % idénticos).
- [ ] Eliminar `PagosService.buscarPagador` o `rpc_public_buscar_pagador` como implementación duplicada de la misma búsqueda (elegir una).
- [ ] Tipado estricto en `beneficios.service.ts` (eliminar `as any[]`).
- [ ] Sanitizar el término de búsqueda antes de interpolarlo en filtros `.or()` de PostgREST (comas/paréntesis rompen el filtro).
- [ ] Consolidar la migración duplicada `20260607063839_filtro_dashboard.sql` vs `00060_filtro_dashboard.sql`.
- [ ] Mover `implementation_plan.md` a `docs/` o ignorarlo en git (archivo de trabajo transitorio).
- [ ] Quitar imports `NgClass` sin uso (warnings NG8113 en `beneficios-reporte` y `transferir-puesto-dialog`).

## 📈 UX / Presentación (Baja)

- [ ] Vista de solo lectura coherente para rol Asistente (si se decide conservarlo).
- [ ] Botón "Ver JSON técnico" bajo demanda en el timeline de auditoría (RPC puntual por evento; los payloads ya no viajan por defecto).
- [ ] Gráficos en la Central de Reportes (apexcharts ya está instalado y sin uso real).
- [ ] Rate-limiting / CAPTCHA ligero en el portal público si la enumeración de nombres preocupa a la Junta.

## 🏗️ Escalabilidad (Baja, monitorear)

- [ ] Migrar `cargarArqueo` a RPC agregada si el volumen diario de recibos crece (hoy: 6 queries PostgREST, aceptable).
- [ ] Índice/estrategia para `rpc_auditoria_timeline` con `p_busqueda` cuando `audit_logs` supere ~100k filas (la búsqueda calcula la narrativa antes de filtrar).
- [ ] Almacenamiento de PDFs en Supabase Buckets + envío por email (pendiente histórico del README).
- [ ] Buffer offline de transacciones de caja (IndexedDB) para cortes de internet (pendiente histórico del README).

## ✅ Completado recientemente (referencia)

- [x] Unificación de deuda consolidada en `fn_deudas_pagador` — todas las vistas idénticas (00082, 2026-07-07).
- [x] Regularización de 173 conceptos huérfanos de recibos migrados + fix monto 10894 (00083).
- [x] Paridad del portal público: `codigo_puesto` por línea de historial (00084).
- [x] Central de Reportes v2: agregación server-side, drill-down, filtro socios/inquilinos, Excel multi-hoja (00085).
- [x] Auditoría narrativa tipo timeline con motivo transaccional (00086).
- [x] Limpieza de prototipos mock (registro-pago, auditoria.component, reportes.component.html).
