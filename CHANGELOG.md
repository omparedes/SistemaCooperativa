# Historial de Cambios — ERP Mercado Cooperativo Primero de Mayo

Todos los cambios notables en este proyecto están documentados en este archivo.
El formato se basa en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/) y sigue [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Sin publicar] — Cambios integrados en `main` posteriores a v2.5.0

> *Nota de versionado:* Esta sección recopila los hitos ya integrados en `main` (y validados en producción cuando aplica) después del tag `v2.5.0`, manteniéndose el identificador de versión visible en `2.5.0` hasta una futura decisión de publicación.

### Funcionalidades de Producto e Informes
- **Reporte Contable (`/reportes/contable`):** Módulo independiente de auditoría y conciliación de ingresos contra la Central de Reportes (`ReporteContableService`, `ReporteContableExcelService`), con clasificación documental (`REGISTRADO`, `SIN REGISTRAR`, `POR VALIDAR`, `NO APLICA`), exportación Excel de **9 hojas** (`00_RESUMEN` a `08_DOCUMENTOS_PENDIENTES`), modo de muestra anonimizada, restricción de exportación DNI para roles `Administrador` y `Caja`, y 8 pruebas unitarias (`cabccec`).
- **Gestión de Tarjeta (`/cuenta-corriente/gestion-tarjeta`):** Edición y anulación lógica de recaudaciones semanales por tarjeta mediante RPCs `rpc_editar_recaudacion_abono` y `rpc_anular_recaudacion_abono` (`00100`), con bloqueo pesimista `FOR UPDATE`, control de concurrencia optimista (`p_updated_at`), ajuste atómico de `saldo_a_favor`, bloqueo si el saldo ya fue consumido y registro en `audit_logs` (`154c2c2`).
- **Modernización de la Central de Reportes (Etapas 1–3):** Filtros rediseñados, análisis gráfico de evolución y comparativa entre períodos con **ApexCharts**, exportaciones Excel de 4 hojas (`ReportesExcelService`), PDF institucional A4 con gráfico incrustado (`ReportesPdfService`) y notas aclaratorias entre criterio devengado y flujo de caja (`ea24a87`).
- **Recibos Duales A4 y Tickets Térmicos 80mm:** Soporte calibrado para impresora térmica Epson TM-T20IV-L (escala 100%, márgenes y logo monocromo) junto al formato A4 y configuración visual (`/configuracion/recibos`) (`a28a361`, `08090e9`).

### Rendimiento, Arquitectura y Modernización Técnica
- **Migración Angular 20 → 21 → 22 (`22.3.0`):** Actualización de `@angular/*` y `@angular/build` a `22.3.0`, TypeScript a `6.0.3`, `ng-apexcharts` a `2.1.0`, conservación de `Zone.js` y Karma/Jasmine, y adopción explícita de `ChangeDetectionStrategy.Eager` en 72 archivos (`fc6e5cb`, `fa4bce2`).
- **Optimización de Rendimiento y Navegación (Fases 1–3):** Desacople de `cargarPerfil` fuera de `onAuthStateChange` (`54f9187`), escucha optimizada `NavigationEnd` en sidebar y banner de recuperación no destructiva ante `ChunkLoadError` (`718c736`), desacople de historial en fichas individuales (`22be613`), retiro de script global duplicado de ApexCharts (`a0e8543`), optimización SQL set-based de cálculo masivo de deudas (`00099` + script de reversión en `supabase/rollback/`) y suite automatizada de 7 specs en `validacion-fases-1-2.spec.ts` (`2e13db3`, `43dcded`, `235c8be`).

### Seguridad, Accesibilidad e Infraestructura
- **Cloudflare Pages y Cabeceras HTTP:** Eliminación de artefactos heredados de Vercel (`b1b5454`), configuración de Build System v3 con `NODE_VERSION=22.23.4` y cabeceras HTTP de seguridad (`X-Frame-Options: DENY`, `Content-Security-Policy: frame-ancestors 'none'`, `Permissions-Policy`) en `public/_headers` (`e4c1703`).
- **Accesibilidad y Cierre de Registro Público:** Retiro de ruta pública `/signup`, `<html lang="es">`, contenedor semántico `<main>` en `AppLayoutComponent` y atributos `aria-label`/`aria-pressed`/`aria-hidden` en controles de contraseña (`5f282a1`).
- **Higiene de Scripts:** Retiro de credenciales históricas en scripts heredados (`c5faf42`).

---

## [2.5.0] - 2026-11-02
### Resumen Ejecutivo
Consolidación de la auditoría operativa y financiera del ERP: habilitación de edición y eliminación segura de Dietas y Provisión Social, cobro de recibos mensuales 100% cubiertos con saldo a favor sin dinero físico, y nuevo esquema de Arqueo de Caja Diario en 3 bloques.

### Nivel Administrativo (Directiva, Administración y Caja)
- **Dietas y Provisión Social:** Se incorporó la posibilidad de corregir y dar de baja registros erróneos directamente desde el perfil del socio, de uso exclusivo para el Administrador, evitando duplicidades y garantizando datos limpios.
- **Cobro con Saldo a Favor:** Ahora el sistema permite cancelar recibos mensuales utilizando el 100% del saldo acumulado en tarjeta (efectivo S/ 0.00), emitiendo su respectivo recibo oficial sin distorsionar la recaudación de la caja física del día.
- **Arqueo de Caja Diario:** Se reorganizó la vista y el PDF del arqueo en 3 bloques claros (Efectivo, Tarjeta y Depósitos Bancarios) con subtotales independientes y exclusión total de comprobantes anulados.
- **Protección de Datos:** Se reforzó la seguridad de la información del proyecto y se formalizó el sistema de versionado institucional `v2.5.0`.

### Nivel Técnico (Desarrollo y Auditoría)
- **Backend (Supabase / PostgreSQL):**
  - Migración `00098`: Columnas `updated_at`/`updated_by` en `beneficios_socios`, políticas RLS reforzadas a rol `Administrador` y RPCs transaccionales `rpc_editar_beneficio_socio` y `rpc_eliminar_beneficio_socio` con bloqueo `FOR UPDATE`.
  - Migración `00097`: Soporte para `p_monto_total = 0` (`S/ 0.00` de efectivo) y `metodo_pago = 'Saldo a Favor'` en `rpc_procesar_pago`, más bloqueo `FOR UPDATE` en `rpc_procesar_pago` y `anular_pago`.
- **Frontend (Angular 20):**
  - Componente `socio-detail.component.ts`: Modales reactivos de edición y confirmación de baja lógica con signals.
  - Componente `arqueo-caja.component.ts`: Exclusión de anulados y matriz consolidada de 3 bloques.
  - Servicio `pdf-generator.service.ts`: Rediseño de tickets térmicos y reporte de arqueo en 2 niveles de agregación.
- **Commits:** `1eec4fe`, `d2385b1`, `ede8fff`.

---

## [2.4.0] - 2026-10-14
### Resumen Ejecutivo
Integración de ingresos varios en caja (Caja Rápida) y regularización de cobranza para inquilinos con almacenes.

### Nivel Administrativo
- **Gestión de Ingresos Internos:** Módulo para cobrar y auditar servicios diarios sin recibo oficial (baños públicos, parqueo, servicios varios) con trazabilidad de anulación.
- **Atención a Inquilinos:** Habilitación de cobro en ventanilla y estados de cuenta para inquilinos que arriendan almacenes comerciales.
- **Asociación de Cargos:** Corrección de cargos de inquilinos en cuenta corriente cuando no poseen puesto comercial físico asignado.

### Nivel Técnico
- Migración `00096`: Tabla `ingresos_internos` con trigger a `audit_logs` y RPC `rpc_anular_ingreso_interno`.
- Modificación de `pago-wizard.component.ts` para permitir `socio_id IS NULL` con `inquilino_id` válido.
- Corrección de consultas en `cuenta-corriente.service.ts`.
- **Commits:** `4c5d302`, `5e60904`, `b11b3ea`.

---

## [2.3.0] - 2026-10-08
### Resumen Ejecutivo
Implementación de los módulos de Tesorería Bancaria y Estados de Cuenta Consolidados.

### Nivel Administrativo
- **Movimientos Bancarios:** Registro, edición y anulación de ingresos y egresos en cuentas bancarias institucionales con actualización automática del saldo contable.
- **Estados de Cuenta:** Reporte gerencial de saldos por cobrar consolidado por puesto y socio, con exportación a PDF y hojas de cálculo Excel.

### Nivel Técnico
- Migración `00094`: Función trigger `tg_actualizar_saldo_banco()` para actualización atómica de saldos en `bancos_cuentas`.
- Migración `00095`: Procedimiento almacenado `rpc_reporte_resumen_deudas` (`00095_reporte_estados_cuenta.sql`).
- Integración de librería `xlsx` (SheetJS) con carga dinámica vía `import()`.
- **Commits:** `c4410fd`, `1bbb067`.

---

## [2.2.0] - 2026-07-09
### Resumen Ejecutivo
Implementación del Padrón Electoral para Asambleas Generales y Central de Reportes con agregación en base de datos.

### Nivel Administrativo
- **Padrón Electoral:** Control de socios hábiles y morosos para asambleas de la cooperativa.
- **Central de Reportes:** Consultas rápidas con desglose detallado de pagos y exportación gerencial.
- **Acceso Móvil:** Adaptación del portal de consultas para teléfonos y tabletas.

### Nivel Técnico
- Migraciones `00085` a `00088`: RPCs de Central de Reportes (`rpc_reporte_resumen`, `rpc_reporte_detalle_concepto`, `rpc_reporte_detalle_egresos` en `00085`) y `rpc_asambleas_padron` (`00088`).
- Vistas móviles optimizadas en `consultas.component.ts`.
- **Commits:** `a01e083`, `ea297f5`, `feff237`.

---

## [2.1.0] - 2026-06-10
### Resumen Ejecutivo
Facturación mensual y cobranza de alquiler de almacenes comerciales.

### Nivel Administrativo
- Registro y asignación de almacenes secundarios a socios e inquilinos, generando sus cargos mensuales automáticos.

### Nivel Técnico
- Migración `00072`: Esquema de datos `ocupaciones_almacenes` y lógica de facturación fija mensual.
- **Commits:** `f6dc793`, `58d2e81`, `d7528ba`.

---

## [2.0.0] - 2026-05-29
### Resumen Ejecutivo
Lanzamiento oficial del ERP en producción (Go-Live). Módulos base de padrón, facturación comunitaria de agua/luz, cobranza en ventanilla, manual de usuario y documentación técnica.
