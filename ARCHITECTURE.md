# ARCHITECTURE.md — Decisiones Arquitectónicas

> Registro de las decisiones estructurales del SistemaCooperativa y su justificación.
> Audiencia: desarrolladores y agentes que necesiten entender **por qué** el sistema es como es antes de modificarlo.
> Última actualización: 2026-11-19 (alineada al estado real en `main`, Angular 22.3.0 y migraciones `00001`–`00100`).

---

## ADR-01 · La lógica financiera vive en PostgreSQL (RPC), no en Angular

Toda escritura financiera con más de un paso (`rpc_procesar_pago`, `anular_pago`, `rpc_recaudacion_masiva`, `rpc_editar_ingreso_interno`, `rpc_anular_ingreso_interno`, `rpc_editar_recaudacion_abono`, `rpc_anular_recaudacion_abono`, `rpc_editar_beneficio_socio`, `rpc_eliminar_beneficio_socio`, `rpc_transferir_puesto`, `generar_cargos_fijos_mes`…) es un stored procedure `SECURITY DEFINER` con chequeo de rol (`get_my_rol()`) al inicio. **Razón:** atomicidad real (un fallo de red del cliente no deja estados parciales), bloqueo pesimista (`FOR UPDATE`) y control de concurrencia optimista (`p_updated_at`) cuando aplica (`00096`, `00097`, `00098`, `00100`). El frontend nunca encadena inserts dependientes críticos.

## ADR-02 · Fuente única de deuda: `fn_deudas_pagador` (00082) y variante set-based (00099)

La deuda consolidada de una persona = cargos personales (`socio_id` / `inquilino_id`) ∪ puestos vigentes (`historial_titularidad` / `historial_arriendos`) ∪ almacenes vigentes (`ocupaciones_almacenes`). Esa regla vive en `fn_deudas_pagador(tipo, id)` para consultas individuales (`rpc_caja_cargar_deudas`, `rpc_public_cargar_deudas`, `rpc_cc_detalle_persona`) y en la función auxiliar set-based `fn_resumen_deudas_por_pagador()` (`00099`) para las 4 RPCs de listado masivo (`rpc_cc_listar_personas`, `rpc_reporte_resumen_deudas`, `rpc_asambleas_padron`, `rpc_dashboard_ejecutivo`), eliminando el patrón N+1 sin alterar reglas contables.

**Regla derivada:** ninguna vista nueva reimplementa el predicado de deuda en Angular o SQL ad-hoc; delega en las funciones canónicas.

## ADR-03 · Reportes agregan en el servidor y concilian por período (00085, 00095, Reporte Contable)

PostgREST limita respuestas directas por defecto; sumar filas crudas en el navegador producía totales anuales incompletos. La Central de Reportes (`00085`: `rpc_reporte_resumen`, `rpc_reporte_detalle_concepto`, `rpc_reporte_detalle_egresos`, actualizados en `00097` para `monto_total = 0`), Estados de Cuenta (`00095`: `rpc_reporte_resumen_deudas`), Movimientos Bancarios (`00094`: `rpc_reporte_movimientos_bancarios`) y Asambleas (`00088`: `rpc_asambleas_padron`) agregan server-side devolviendo JSON.

El módulo **Reporte Contable** (`/reportes/contable`, `ReporteContableService`) cruza los comprobantes del período (`pagos`, `ingresos_internos`, `recaudacion_abonos`) diferenciando dinero nuevo caja/banco vs saldo a favor aplicado, validando formatos documentales (DNI/RUC/CE, clasificando ausencias y placeholders como `SIN REGISTRAR` o `NO APLICA`, nunca como DNI reales) y conciliando los totales frente a la Central de Reportes.

## ADR-04 · Zona horaria: fechas de negocio en hora de Lima

- Columnas `date` (gastos, movimientos bancarios, aperturas) se filtran con strings `YYYY-MM-DD` calculados en la zona del navegador.
- Columnas `timestamptz` (pagos, ingresos internos, recaudación) se filtran en SQL con `AT TIME ZONE 'America/Lima'` y límite superior exclusivo `(p_hasta + 1 día)`, garantizando cortes contables consistentes en horario de Perú.

## ADR-05 · Soft-delete universal + inmutabilidad de recibos

Prohibido `DELETE` físico en tablas financieras y de personas. La anulación escribe `deleted_at`, `anulado_por`, `motivo_anulacion` (salvo `beneficios_socios`, que en `00098` conserva `deleted_by`) y ejecuta reversa atómica. En `ingresos_internos` (`00096`) y `recaudacion_abonos` (`00100`), la política RLS de `UPDATE` directo desde PostgREST está denegada (`false`) para forzar el paso exclusivo por RPCs auditadas. Los recibos emitidos son inmutables (excepción auditada: ajuste de `comprobante` y `fecha_pago` en `rpc_cc_editar_pago`).

## ADR-06 · Auditoría: bitácora técnica inmutable + narrativa resuelta al leer (00016 → 00086 → 00100)

`audit_logs` guarda snapshots `jsonb` en modo append-only (RLS solo-Admin) mediante `log_audit_action()`. El timeline (`rpc_auditoria_timeline`) resuelve actor, rol, entidad y deltas al leer, usando el motivo transaccional `set_config('app.audit_motivo', ..., true)`. Tablas cubiertas por trigger en migraciones: `socios`, `inquilinos`, `puestos`, `pagos`, `distribuciones_mensuales`, `ocupaciones_almacenes`, `gastos`, `caja_ajustes`, `movimientos_bancarios` (`00094`), `ingresos_internos` (`00096`), `beneficios_socios` (`00098`) y `recaudacion_abonos` (`00100`). Las etiquetas viven en el frontend ([auditoria-labels.ts](src/app/pages/auditoria/auditoria-labels.ts)).

## ADR-07 · Paginación keyset, no offset

El timeline de auditoría pagina por cursor (`p_before = created_at`) en lugar de `OFFSET`, evitando desplazamiento ante inserciones concurrentes.

## ADR-08 · Salidas documentales y gráficos (SheetJS lazy, pdfmake A4/80mm, ApexCharts)

- **Excel (`xlsx`):** importado **exclusivamente** bajo `import()` dinámico en tres servicios (`ExcelExportService`, `ReportesExcelService` 4 hojas, `ReporteContableExcelService` 9 hojas + modo anonimizado). El sistema solo genera libros `.xlsx`, no parsea archivos subidos por usuarios.
- **PDF (`pdfmake`):** recibos A4 y tickets térmicos 80mm configurables (`configuracion_recibos`, calibrados para Epson TM-T20IV-L), arqueo diario en 2 niveles con 3 bloques, movimientos bancarios, padrón electoral e informes institucionales (`ReportesPdfService`) con captura opcional de gráfico ApexCharts.
- **Gráficos:** `apexcharts` + `ng-apexcharts` integrados vía ESM en `DashboardComponent` y `ReportesComponent` (sin script global duplicado).

## ADR-09 · Frontend Angular 22.3, Eager + Zone.js, Signals y Realtime

- **Framework:** Angular `22.3.0` + TypeScript `6.0.3` (`strict: true`), 100 % Standalone Components, sin `NgModule`, rutas lazy con `loadComponent` en `app.routes.ts` y manejo no destructivo de `ChunkLoadError` en `app.config.ts` / `AppLayoutComponent`.
- **Detección de cambios:** `ChangeDetectionStrategy.Eager` explícito (72 archivos migrados en Angular 22) junto con `provideZoneChangeDetection({ eventCoalescing: true })` y `Zone.js ~0.15.0`, manteniendo compatibilidad con **Signals** y servicios existentes.
- **Supabase Realtime (WebSockets):** canales activos en `bancos.service.ts` (`bancos-live`), `gastos.service.ts` (`gastos-list-changes`) y `pagos.service.ts` (`pagos-${tipo}-${id}`). Credenciales cliente en `src/environments/environment*.ts` (`anon` key protegida por RLS; jamás `service_role` en frontend).
- **Calidad:** suite Karma/Jasmine (`npm test`, 15 specs en `validacion-fases-1-2.spec.ts` y `reporte-contable.spec.ts`).

## ADR-10 · Migraciones numeradas e historial inmutable

Scripts en `supabase/migrations/000NN_*.sql` (actualmente hasta `00100`, más `20260607063839_filtro_dashboard.sql` heredada y scripts de reversión en `supabase/rollback/`). La presencia de un `.sql` en el repositorio documenta el diseño/código fuente; su aplicación en cada instancia remota de Supabase debe verificarse mediante el registro de migraciones del proyecto destino.

## ADR-11 · Hosting y Seguridad Perimetral en Cloudflare Pages

- Despliegue continuo desde `main` en **Cloudflare Pages** (Build System v3, `NODE_VERSION=22.23.4`, `npm run build` → `dist/ng-tailadmin/browser`, dominio `https://sistema.mercadoprimerodemayo.com`).
- Cabeceras HTTP de seguridad gestionadas en [public/_headers](public/_headers): `X-Frame-Options: DENY`, `Content-Security-Policy: frame-ancestors 'none'`, `Permissions-Policy: camera=(), microphone=(), geolocation=()`.
- Ruta pública de registro `/signup` retirada (`5f282a1`) y artefactos legados de Vercel eliminados (`b1b5454`). Las ramas no integradas (como `feat/demo-comercial`) permanecen aisladas fuera de `main`.

---

## Deudas arquitectónicas y estado de mitigación

| Tema | Estado real (código / `main` vs remoto / pendiente) |
|---|---|
| Bloqueo `FOR UPDATE` y validación de saldo/pagador en `rpc_procesar_pago` / `anular_pago` | **Implementado en código y SQL (`00097`) / integrado en `main`** (verificar aplicación en BD remota donde corresponda) |
| Concurrencia optimista/pesimista y auditoría en `ingresos_internos` y `recaudacion_abonos` | **Implementado en código y SQL (`00096`, `00100`) / integrado en `main`** (confirmar en `auditoria-labels.ts` añadir etiquetas de tabla faltantes) |
| Auditoría (`trg_audit_beneficios_socios`) y edición/baja en `beneficios_socios` | **Implementado en código y SQL (`00098`) / integrado en `main`** (pendiente unificar `deleted_by` → `anulado_por` + motivo obligatorio ingresado por usuario) |
| Dietas/Provisión fuera del circuito físico de caja/arqueo | **Pendiente — prioridad alta** ([TODO.md](TODO.md)) |
| `perfiles`, `configuraciones`, `configuracion_recibos`, `caja_aperturas` sin trigger de auditoría | **Pendiente** (quick win) |
| Regla "último admin" y RPC de gestión de usuarios (`/admin/usuarios`) | **Pendiente** |
| Rol `Asistente` a medio implementar | **Pendiente de decisión de negocio** (en Reporte Contable bloquea exportación DNI) |
| Arqueo por PostgREST (`cargarArqueo`) y diferencia `monto_aplicado` vs `monto_total` | Aceptada mientras el volumen diario sea acotado |
| Estado `Cancelado` con doble semántica histórica (anulado vs pagado-en-migración) | Aceptada y documentada |
