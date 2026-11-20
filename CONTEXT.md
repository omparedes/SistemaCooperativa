# Contexto del Proyecto: ERP SistemaCooperativa

Este documento es la **fuente de la verdad de negocio** para desarrolladores y agentes que trabajen en el ERP. Las reglas técnicas viven en [CLAUDE.md](CLAUDE.md); las decisiones arquitectónicas en [ARCHITECTURE.md](ARCHITECTURE.md); la auditoría histórica de julio 2026 en [AUDITORIA_2026.md](AUDITORIA_2026.md); el backlog vivo en [TODO.md](TODO.md).

## 1. Pila Tecnológica (Tech Stack)
- **Frontend:** Angular `22.3.0` (*Standalone Components*, sin `NgModules`), estado reactivo con **Signals** (`signal`, `computed`, `effect`), `ChangeDetectionStrategy.Eager` y `Zone.js ~0.15.0`. TypeScript `6.0.3` (`strict: true`).
- **Estilos:** Tailwind CSS v4 (PostCSS, dark mode en todas las vistas, layout basado en TailAdmin).
- **Backend/BD:** Supabase (PostgreSQL, Auth, RLS, Realtime channels y RPCs `SECURITY DEFINER`). Configurado en cliente mediante [src/environments/environment.ts](src/environments/environment.ts) (`supabaseUrl` y clave pública `supabaseAnonKey` protegida por RLS; `.env` es solo para scripts/CLI locales y jamás se expone en el frontend).
- **Salidas y Gráficos:** `apexcharts` + `ng-apexcharts` (Dashboard y Central de Reportes), `pdfmake` (recibos A4 y tickets térmicos 80mm Epson TM-T20IV-L, arqueos en 2 niveles y reportes A4) y `xlsx`/SheetJS bajo `import()` dinámico en `ExcelExportService`, `ReportesExcelService` y `ReporteContableExcelService` (libro contable de 9 hojas).
- **Hosting y Pruebas:** Cloudflare Pages (Build System v3, `NODE_VERSION=22.23.4`, `public/_headers`) y Karma/Jasmine (`npm test`, 15 specs).

## 2. Reglas de Arquitectura Críticas
- **Soft Deletes estrictos:** prohibido `DELETE` físico en entidades financieras y personas (`deleted_at` + `anulado_por` + `motivo_anulacion`, salvo `beneficios_socios` que actualmente usa `deleted_by` en `00098`).
- **Transacciones ACID:** toda escritura financiera y transferencia de espacios pasa por RPCs en PostgreSQL (`rpc_procesar_pago`, `anular_pago`, `rpc_editar_ingreso_interno`, `rpc_editar_recaudacion_abono`, etc.).
- **Seguridad RLS:** políticas basadas en `get_my_rol()` (`Administrador`, `Caja`, y `Asistente` con alcance restringido en app). Ninguna credencial administrativa (`service_role`) puede residir en el frontend.
- **Deuda unificada:** `fn_deudas_pagador` (`00082`) y su equivalente set-based para listados masivos (`00099`) definen "cuánto debe una persona". Caja, Cuenta Corriente, Padrón, Asambleas, Estados de Cuenta y Portal Público (`/consultas`) deben consumir esas fuentes canónicas.
- **Reportes server-side:** los totales de rangos amplios se agregan en SQL devolviendo JSON único (evita el límite de 1000 filas de PostgREST y reduce egress).
- **Auditoría inmutable con motivo:** `audit_logs` es append-only; acciones críticas envían justificación mediante `app.audit_motivo` y se leen en timeline (`/auditoria`, solo Admin).

## 3. Lógica del Negocio: Módulo Financiero
- **Cobro al Espacio vs a la Persona:** Luz, Agua y alquiler de almacén se asignan al espacio activo; cuotas fijas de socio (Gastos Administrativos y Previsión Social) al socio activo con suspensión individual.
- **Caja Física vs Bancos/QR:** la gaveta física separa estrictamente el **Efectivo** de **Transferencias/PLIN/BBVA**. Fórmula sagrada del arqueo: `Apertura + Efectivo − Gastos − Faltantes + Sobrantes`. El Arqueo clasifica los ingresos en 3 bloques (**Socios**, **Inquilinos**, **Otros Ingresos**) y excluye comprobantes anulados de tablas y totales.
- **Cobro con Saldo a Favor y Pagos Mixtos:** el wizard en 3 pasos aplica pagos en Efectivo, Transferencia, pagos mixtos o pagos cubiertos al 100 % con `saldo_a_favor` (`S/ 0.00` efectivo nuevo en `00097`). Debe distinguirse siempre el **nuevo ingreso de caja/banco** respecto de la **aplicación de saldo a favor ya recaudado** previamente.
- **Recaudación por Tarjeta y su Gestión:** el prepago semanal alimenta `saldo_a_favor` (`recaudacion_abonos`). Su edición o anulación (`/cuenta-corriente/gestion-tarjeta`, `00100`, solo Administrador) ajusta atómicamente `saldo_a_favor` y **bloquea** reducciones o anulaciones si parte de ese saldo ya fue consumido en pagos posteriores.
- **Ingresos Internos (Caja Rápida):** cobros sin recibo formal (baños, parqueo, etc.). Su revisión, edición y anulación pasan por `/cuenta-corriente/gestion-ingresos` (`00096`), exigiendo rol Administrador para fechas pasadas.
- **Reporte Contable (`/reportes/contable`):** consolida comprobantes del período, concilia contra la Central de Reportes, clasifica documentos (`REGISTRADO`, `SIN REGISTRAR`, `POR VALIDAR`, `NO APLICA` — exportando `SIN REGISTRAR` o `NO APLICA` en Excel cuando no hay DNI válido, sin exponer placeholders `TEMP_*`), permite muestra anonimizada y restringe exportación con DNI a `Administrador` y `Caja`.
- **Dietas y Provisión Social (`beneficios_socios`):** cuenta con edición, baja lógica y auditoría (`00098`), pero **aún no está integrada al circuito de gastos/arqueo de caja física**.

## 4. Lógica del Negocio: Espacios y Ocupación (El Padrón)
El sistema separa el **Espacio físico** (`Regular`, `Pequeño`, `Almacén`) de la **Persona** (`Socio`, `Inquilino` con puesto principal o almacenes, `Tercero` solo almacenes).
- Alquileres institucionales asociados al Socio Maestro "LA COOPERATIVA" (DNI `00000000`).
- **Historial inmutable:** transferencias y liberaciones cierran la ocupación anterior (`fecha_fin`) y crean una nueva fila.

## 5. Estado Actual del Desarrollo

### Hitos completados en `main` (julio – noviembre 2026)
- **Consistencia, Auditoría y Bancos (`00082`–`00095`):** fuente única `fn_deudas_pagador`, regularización de recibos, Central v2 (`00085`), auditoría narrativa (`00086`), Asambleas (`00088`), Movimientos Bancarios atómicos (`00094`) y Estados de Cuenta (`00095`).
- **Consolidación Operativa `v2.5.0` y Reportes Avanzados (`00096`–`00100`):** Gestión de Ingresos Internos (`00096`), pagos 100 % saldo a favor + bloqueo `FOR UPDATE` (`00097`), edición/auditoría de Dietas y Provisión (`00098`), Arqueo en 3 bloques y PDF 2 niveles, tickets térmicos 80mm, Central de Reportes con ApexCharts + Excel 4 hojas + PDF A4, Gestión de Tarjeta (`00100`) y **Reporte Contable** (`/reportes/contable`, Excel 9 hojas).
- **Rendimiento, Seguridad y Modernización (`fa4bce2`):** optimizaciones de Auth lock, sidebar, fichas y RPCs set-based (`00099`, + suite `validacion-fases-1-2.spec.ts` / `reporte-contable.spec.ts` con 15 specs), retiro de Vercel y `/signup`, cabeceras Cloudflare `_headers` y migración completa **Angular 20 → 21 → 22.3.0** (`TS 6.0.3`, `Node 22.23.4`).

> *Distinción de estado:* las funcionalidades frontend están integradas en `main` y desplegadas en Cloudflare Pages; en migraciones SQL recientes (`00096`–`00100`), la presencia del archivo `.sql` en `supabase/migrations/` acredita su implementación en repositorio, debiendo verificarse su ejecución en la instancia remota al auditar un entorno.

### Siguiente hito — Pendientes residuales en [TODO.md](TODO.md)
1. Integración Dietas/Provisión (`beneficios_socios`) ↔ circuito de egresos de caja/banco.
2. Regla "último admin" (`rpc_gestionar_usuario`), triggers de auditoría en `perfiles`, `configuraciones`, `configuracion_recibos` y `caja_aperturas`, y RPC con motivo para modificar cargos manuales en CC.
3. Definición del alcance definitivo del rol `Asistente` y limpieza técnica menor (incluidos `NG8113` `NgClass` pendientes).

---
> **Nota:** Excluir estrictamente cualquier rama no integrada en `main` (como `feat/demo-comercial`) de la documentación operativa y de producto.
