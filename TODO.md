# TODO / ROADMAP — SistemaCooperativa

> Backlog derivado originalmente de [AUDITORIA_2026.md](AUDITORIA_2026.md) (corte `2026-07-07`) y actualizado según el estado verificado en `main` (`2026-11-19`).
> **Criterio de estado:** `[x]` = implementado en código e integrado en `main` (para cambios con migración SQL, la ejecución efectiva en Supabase remoto debe confirmarse en el historial del proyecto destino si no se auditó directamente la BD). `[ ]` = pendiente en código o por confirmar decisión.

## 🔴 Integridad Financiera (Alta)

- [ ] **Dietas/Provisión ↔ Caja:** definir con la Junta el flujo contable de dinero (¿cada beneficio genera un `gasto` con categoría propia o un `movimiento_bancario`?) e integrarlo al arqueo y reportes. Hoy `beneficios_socios` ya tiene edición/baja/auditoría (`00098`), pero sigue sin descontar de gaveta física ni de egresos.

## 🟠 Trazabilidad y Seguridad (Alta / Media-Alta)

- [ ] **Quick win — triggers de auditoría faltantes** `log_audit_action()` en: `perfiles`, `configuraciones`, `configuracion_recibos`, `caja_aperturas` (y añadir `ingresos_internos` y `recaudacion_abonos` en `TABLA_LABELS` de [auditoria-labels.ts](src/app/pages/auditoria/auditoria-labels.ts)).
- [ ] **Regla "último admin":** crear RPC `rpc_gestionar_usuario` que impida que un Administrador se degrade/desactive a sí mismo o deje el sistema sin admins activos, reemplazando los `.update()` directos en [usuarios.component.ts](src/app/pages/usuarios/usuarios.component.ts). Confirmar también si `/admin/usuarios` debe enlazarse en el sidebar o menú de usuario.
- [ ] **Modificar cargo con motivo:** convertir la edición manual de monto en `montos_por_cobrar` (Cuenta Corriente) en RPC con motivo obligatorio e inserción dirigida en `audit_logs`.
- [ ] **Motivo obligatorio y unificación de baja en `beneficios_socios`:** `00098` usa `deleted_by` y un motivo fijo en `app.audit_motivo`; evaluar migrar a motivo ingresado por el Administrador + convención `anulado_por`/`motivo_anulacion`.
- [ ] **Decidir destino del rol `Asistente`:** completarlo de forma coherente (RPCs de solo lectura sin errores) o retirar su asignación por defecto en `tg_handle_new_user`. (Hoy `ReporteContableService` bloquea explícitamente exportación DNI para `Asistente`).

## 🟡 Negocio / Funcional (Media)

- [ ] Recálculo automático de `socios.habilitado` tras cierre de período o pago (hoy manual).
- [ ] RPC atómico `rpc_crear_socio` / `rpc_crear_inquilino` (alta + asignación de espacio en una transacción).
- [ ] Mostrar `codigo_puesto` por fila de deuda en la UI de Cuenta Corriente (la RPC ya lo devuelve desde `00082`).
- [ ] Advertencia visual fuerte en formularios de padrón cuando se usa DNI temporal `TEMP_########`.
- [ ] Unificar semántica histórica del estado `Cancelado` (anulado vs pagado en migración `00077`).
- [ ] Confirmar vigencia operativa de rutas fuera del sidebar (`/facturacion/medidores`, `/facturacion/alquiler-almacenes`, `/pagos/recaudacion-diaria`) y de la coexistencia `/login` vs `/signin` + archivos huérfanos de `sign-up`.

## 🧹 Limpieza de Código (Media / Baja)

- [ ] Quitar imports `NgClass` sin uso que actualmente emiten advertencia **NG8113** en `ng build`: [beneficios-reporte.component.ts](src/app/pages/reportes/beneficios-reporte.component.ts), [transferir-puesto-dialog.component.ts](src/app/pages/espacios/components/transferir-puesto-dialog.component.ts) y [asignar-almacen-dialog.component.ts](src/app/pages/espacios/components/asignar-almacen-dialog.component.ts).
- [ ] Extraer formateadores privados repetidos (`fmtSoles`, fechas, periodos) a `shared/utils/`.
- [ ] Renombrar una de las dos interfaces `DeudaItem` (`pago.model.ts` vs `cuenta-corriente.model.ts`).
- [ ] Unificar `socio-form`/`inquilino-form` y `socio-detail`/`inquilino-detail`.
- [ ] Eliminar duplicidad entre `PagosService.buscarPagador` y `rpc_public_buscar_pagador`.
- [ ] Revisar tipado estricto en `beneficios.service.ts` y sanitizar búsquedas interpoladas en filtros `.or()` de PostgREST.
- [ ] Consolidar la migración duplicada `20260607063839_filtro_dashboard.sql` vs `00060_filtro_dashboard.sql`.
- [ ] Normalizar títulos residuales `"| TailAdmin"` en [app.routes.ts](src/app/app.routes.ts) (`socios`, `pagos/recaudacion-diaria`, `gastos`, `socios/:id`, `inquilinos/:id`).
- [ ] Revisar advertencias CommonJS de `pdfmake` en `angular.json` / `pdf-generator.service.ts` y conectar el texto del banner de novedades en [app-layout.component.html](src/app/shared/layout/app-layout/app-layout.component.html) a `APP_VERSION_DATA`.

## 📈 UX / Escalabilidad (Baja)

- [ ] Botón "Ver JSON técnico" bajo demanda en timeline de auditoría e índice/estrategia si `audit_logs` supera alto volumen.
- [ ] Migrar `cargarArqueo` a RPC agregada si aumenta significativamente el volumen diario de recibos.
- [ ] Almacenamiento de PDFs en Supabase Storage + envío por email y búfer offline de caja en IndexedDB.
- [ ] Control anti-enumeración / rate-limit adicional en `/consultas` si la Junta lo requiere.

---

## ✅ Implementado en código e integrado en `main` (referencia verificada)

- [x] **Unificación y optimización de deuda:** `fn_deudas_pagador` (`00082`), paridad portal público con `codigo_puesto` (`00084`) y optimización set-based `fn_resumen_deudas_por_pagador` (`00099`, con rollback en `supabase/rollback/`).
- [x] **Concurrencia, pagos mixtos y validación pagador↔deuda (`00097`):** bloqueo `FOR UPDATE` sobre `socios`/`inquilinos`/`montos_por_cobrar` en `rpc_procesar_pago` y `anular_pago`, soporte `monto_total = 0` con 100 % saldo a favor y validación de titularidad/arriendo/almacén *(confirmar estado aplicado en cada BD remota)*.
- [x] **Gestión de Ingresos Internos (`00096`) y Gestión de Tarjeta (`00100`):** edición/anulación con RLS restrictivo (`UPDATE` directo bloqueado), OCC `p_updated_at`, `FOR UPDATE`, ajuste atómico de `saldo_a_favor` y trigger a `audit_logs` *(confirmar estado aplicado en BD remota donde aplique)*.
- [x] **Auditoría y Edición/Baja en `beneficios_socios` (`00098`):** trigger `trg_audit_beneficios_socios`, RLS exclusivo Admin, `rpc_editar_beneficio_socio` y `rpc_eliminar_beneficio_socio`.
- [x] **Central de Reportes modernizada (`ea24a87`) y Arqueo en 3 bloques (`ede8fff`):** gráficos ApexCharts (`0bc352d`), Excel 4 hojas, PDF A4 institucional, notas devengado vs flujo de caja, matriz Socios/Inquilinos/Otros sin anulados y PDF 2 niveles.
- [x] **Reporte Contable (`/reportes/contable`, `cabccec`):** conciliación contra Central de Reportes, clasificación DNI/RUC (`SIN REGISTRAR` / `NO APLICA`), exportación anonimizada y Excel de 9 hojas + 8 pruebas unitarias.
- [x] **Recibos duales A4 y térmicos 80mm (`a28a361`, `08090e9`)** para Epson TM-T20IV-L.
- [x] **Bancos (`00094`) y Estados de Cuenta (`00095`):** edición/soft-delete atómico, reporte bancario PDF y resumen consolidado de deudas.
- [x] **Rendimiento Fases 1–2 (`2e13db3`, `43dcded`):** desacople de `cargarPerfil` fuera de `onAuthStateChange` (`54f9187`, nota: ante cambios rápidos de ruta/pestaña pueden observarse avisos de `Navigator LockManager` de `@supabase/auth-js` en consola), `NavigationEnd` en sidebar, banner no destructivo `ChunkLoadError`, retiro de ApexCharts global duplicado y suite de 7 specs (`validacion-fases-1-2.spec.ts`).
- [x] **Seguridad, a11y e Infraestructura (`5f282a1`, `b1b5454`, `2ea31f6`, `fc6e5cb`, `fa4bce2`):** retiro de Vercel, cabeceras HTTP `public/_headers`, retiro de `/signup`, `<html lang="es">`, `<main>`, `aria-*`, y actualización **Angular 22.3.0 + TypeScript 6.0.3 + `ChangeDetectionStrategy.Eager`**.
