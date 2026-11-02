# Historial de Cambios — ERP Mercado Cooperativo Primero de Mayo

Todos los cambios notables en este proyecto están documentados en este archivo.
El formato se basa en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/) y sigue [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
  - Migración `00097`: Soporte para `p_monto_recibido = 0` y `metodo_pago = 'Saldo a Favor'` en `rpc_registrar_pago_completo`.
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
- Migración `00095`: Procedimiento almacenado `rpc_reporte_estados_cuenta`.
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
- Migraciones `00085` a `00088`: RPCs `rpc_reportes_drilldown` y `rpc_padron_electoral`.
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
