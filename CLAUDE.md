# CLAUDE.md — SistemaCooperativa (Cooperativa Primero de Mayo)

Guía operativa para agentes de programación y desarrolladores al trabajar en este repositorio. Léelo siempre antes de proponer cambios.
Documentos hermanos: [CONTEXT.md](CONTEXT.md) (negocio y flujos) · [ARCHITECTURE.md](ARCHITECTURE.md) (decisiones y porqués) · [AUDITORIA_2026.md](AUDITORIA_2026.md) (snapshot funcional de corte julio 2026) · [TODO.md](TODO.md) (backlog priorizado).

---

## 1. Contexto del Proyecto

ERP web administrativo para la **Cooperativa Primero de Mayo** (`https://sistema.mercadoprimerodemayo.com`). Gestiona el ciclo completo: padrón de socios, inquilinos y terceros con control de puestos y almacenes, facturación mensual automatizada, tesorería diaria (pagos mixtos, saldo a favor, Caja Rápida, recaudación semanal por tarjeta y su gestión), cuenta corriente individual, bancos, inventario, Central de Reportes con ApexCharts/Excel/PDF, Arqueo de Caja en 3 bloques, **Reporte Contable** (`/reportes/contable`), Estados de Cuenta, Padrón Electoral de Asambleas, portal público de consultas (`/consultas`), dietas/provisión social, notificaciones híbridas y **auditoría narrativa inmutable** (`/auditoria`).

**Estado actual (noviembre 2026):** Sistema **en producción** en Cloudflare Pages (commit productivo base post-migración Angular 22 integrado en `main`, dominio `https://sistema.mercadoprimerodemayo.com`). Frontend modernizado a **Angular 22.3.0** + **TypeScript 6.0.3** con `ChangeDetectionStrategy.Eager`. Último script de migración en `supabase/migrations/`: `00100` (`00099` optimización set-based de deudas, `00100` gestión de tarjeta). *Regla de verificación:* no asumir automáticamente que una migración `.sql` del repositorio ya corrió en Supabase remoto sin confirmar en el proyecto destino.

---

## 2. Stack Técnico

| Capa | Tecnología |
|---|---|
| Framework | **Angular 22.3.0 (Standalone Components)** · `ChangeDetectionStrategy.Eager` · `Zone.js ~0.15.0` · prohibido `NgModule` |
| Lenguaje | **TypeScript 6.0.3** (`strict: true`; prohibido `any`) |
| Estilos | **Tailwind CSS v4** (`@tailwindcss/postcss`, PostCSS) · dark mode obligatorio en vistas nuevas |
| Compilación / Ruteo | `@angular/build:application` · `app.routes.ts` centralizado con `loadComponent` (lazy) |
| UI & Gráficos | Patrones TailAdmin (skeletons, badges, modales) · SVG inline · `apexcharts` + `ng-apexcharts` (Dashboard y Reportes) |
| PDF | `pdfmake` (recibos A4 y tickets térmicos 80mm Epson TM-T20IV-L, arqueo 2 niveles, bancos, asambleas, informes A4) |
| Excel | `xlsx` (SheetJS) **exclusivamente vía `import()` dinámico** en `ExcelExportService`, `ReportesExcelService` y `ReporteContableExcelService` |
| Backend | **Supabase** (PostgreSQL + Auth + Triggers + RPCs `SECURITY DEFINER` + RLS + Realtime en `bancos`, `gastos` y `pagos`) |
| Pruebas | **Karma** (`~6.4.0`) + **Jasmine** (`~5.6.0`) · `npm test` (`15` specs en `validacion-fases-1-2.spec.ts` y `reporte-contable.spec.ts`) |
| Hosting | **Cloudflare Pages** (Build System v3, `NODE_VERSION=22.23.4`, `npm run build` → `dist/ng-tailadmin/browser`, cabeceras en `public/_headers`) |

---

## 3. Estructura del Proyecto

```
src/
├── environments/               # environment.ts / environment.development.ts (supabaseUrl + anon key pública bajo RLS)
└── app/
    ├── core/
    │   ├── config/             # version.config.ts (APP_VERSION_DATA)
    │   ├── guards/             # authGuard, adminGuard, noAuthGuard
    │   └── services/           # Singletons + SUPABASE_CLIENT
    │       ├── supabase.client.ts / auth.service.ts (signals de sesión y rol)
    │       ├── pagos.service.ts / recaudacion / gestion-ingresos.service.ts / gestion-tarjeta.service.ts
    │       ├── socios/inquilinos/puestos/giros/gastos/bancos/inventario .service.ts
    │       ├── reportes.service.ts / reportes-pdf.service.ts / reportes-excel.service.ts
    │       ├── reporte-contable.service.ts / reporte-contable-excel.service.ts / estados-cuenta.service.ts
    │       ├── auditoria.service.ts / beneficios.service.ts / notificaciones.service.ts
    │       └── excel-export.service.ts / pdf-generator.service.ts
    ├── pages/                  # Módulos standalone por dominio de negocio
    │   ├── dashboard/          # Dashboard + DashboardEjecutivoComponent + ApexCharts
    │   ├── asambleas/          # Padrón electoral de asambleas (Excel/PDF)
    │   ├── socios/             # Padrón: list/detail/form de socios e inquilinos + beneficios
    │   ├── espacios/           # Puestos, almacenes, ocupaciones y transferencias
    │   ├── pagos/              # pago-wizard (Caja 3 pasos), Caja Rápida (ingresos internos)
    │   ├── recaudacion/        # Recaudación semanal por tarjeta (prepago)
    │   ├── cuenta-corriente/   # Cuenta corriente, gestión de ingresos (00096) y gestión de tarjeta (00100)
    │   ├── facturacion/        # Luz, Agua, Cargos Fijos, Extraordinarios, Medidores, Alquiler Almacenes
    │   ├── gastos/ · bancos/ · inventario/ · giros/
    │   ├── reportes/           # Central de Reportes + Arqueo + Reporte Contable + Bancos + Dietas/PS + Estados de Cuenta
    │   ├── auditoria/          # Timeline narrativo (+ auditoria-labels.ts)
    │   ├── consultas/          # Portal público sin login (/consultas)
    │   ├── config/             # Tarifas + diseño de recibos A4/80mm
    │   ├── documentation/      # Manual de usuario, Documentación Técnica y Novedades
    │   └── usuarios/           # Gestión de roles (/admin/usuarios, solo Admin)
    └── shared/                 # AppLayout (banner versión + recuperación ChunkLoadError), AppSidebar, AppHeader, UI
```

**Migraciones** en `supabase/migrations/` (`00001`–`00100` + `20260607063839_filtro_dashboard.sql`) y reversiones en `supabase/rollback/`. **Generadores y diagnósticos** en `scripts/`. **Archivo `.env`** (ignorado por Git): exclusivo para CLI/scripts locales (`SUPABASE_SERVICE_ROLE_KEY`), **nunca** leído por Angular.

---

## 4. Reglas de Dominio (CRÍTICAS — no negociables)

### 4.1. Deuda consolidada: UNA sola fuente de verdad
- `fn_deudas_pagador(tipo, id)` (00082) define qué debe una persona: cargos personales + puestos vigentes + almacenes vigentes. Los listados masivos delegan en la lógica equivalente set-based `fn_resumen_deudas_por_pagador()` (00099). **Prohibido reimplementar ese predicado**: toda vista nueva consume `rpc_caja_cargar_deudas` o las RPCs canónicas. Caja, Cuenta Corriente, Padrón, Asambleas, Estados de Cuenta y Portal Público deben mostrar exactamente los mismos saldos.

### 4.2. Padrón: espacios y ocupantes
- Espacios: `Regular` y `Pequeño` (principales) y `Almacén` (complementario, nunca principal). Personas: `Socio` (titular), `Inquilino` (arrendatario) y `Tercero` (solo almacenes).
- Todos los alquileres son con "LA COOPERATIVA" (Socio Maestro DNI `00000000`).
- Historial inmutable: transferencias y liberaciones cierran la fila vigente (`fecha_fin`) y crean una nueva; jamás se sobreescribe quién ocupó qué.

### 4.3. Control de Caja Física, Saldo a Favor y Arqueo
- Transferencias/PLIN/BBVA **no entran en la gaveta**. El efectivo físico se calcula **rigurosamente** como:
  `Apertura + Ingresos_Efectivo − Gastos − Faltantes + Sobrantes`
  (`caja_aperturas` con fecha única, `caja_ajustes`). **No alterar esta fórmula.**
- El Arqueo de Caja agrupa los ingresos válidos (`deleted_at IS NULL`) en 3 bloques (**Socios**, **Inquilinos**, **Otros Ingresos**) y separa el efectivo en gaveta del canal bancario/QR tanto en web como en el PDF de 2 niveles.
- Diferenciar siempre **nuevo ingreso de caja/banco** (`monto_total > 0`) vs **aplicación de saldo a favor** (`monto_total = 0` o pagos mixtos en `rpc_procesar_pago`, `00097`): aplicar saldo a favor existente cancela deudas sin generar efectivo nuevo en gaveta.
- Los gastos operativos en `gastos` no distinguen método de pago porque los egresos bancarios viven en `movimientos_bancarios`.

### 4.4. Append-Only, Soft Delete y Control de Concurrencia
- **Prohibido `DELETE`** físico en tablas financieras/personas. Anulación = `deleted_at + anulado_por + motivo_anulacion` (salvo `beneficios_socios`, que aún usa `deleted_by` en `00098`). Pagos se anulan vía `anular_pago` (con `FOR UPDATE` en `00097`); ingresos internos vía `rpc_anular_ingreso_interno` (`00096`); recaudación de tarjeta vía `rpc_editar_recaudacion_abono` / `rpc_anular_recaudacion_abono` (`00100`, con `FOR UPDATE` y OCC `p_updated_at`, bloqueando reducciones o anulaciones si el `saldo_a_favor` ya fue consumido).
- **Gestión de ingresos internos (`ingresos_internos`):** `UPDATE` directo bloqueado por RLS; solo se edita/anula vía RPCs `00096` con `p_updated_at` y restricción exclusiva de `Administrador` para fechas operativas anteriores.

### 4.5. Auditoría narrativa (`00086` + `00094`–`00100`)
- `audit_logs` es append-only (RLS solo-Admin, sin UPDATE/DELETE). `log_audit_action()` captura snapshots `jsonb` y `set_config('app.audit_motivo', p_motivo, true)`.
- Tablas conectadas al trigger de auditoría en migraciones: `socios`, `inquilinos`, `puestos`, `pagos`, `distribuciones_mensuales`, `ocupaciones_almacenes`, `gastos`, `caja_ajustes`, `movimientos_bancarios` (`00094`), `ingresos_internos` (`00096`), `beneficios_socios` (`00098`) y `recaudacion_abonos` (`00100`).
- Ediciones directas del padrón pasan por `rpc_actualizar_con_motivo` (whitelist de columnas). **No** añadir triggers de auditoría a `montos_por_cobrar`/`detalle_pagos` por volumen masivo.

### 4.6. Reporte Contable (`/reportes/contable`)
- Consolida `pagos`, `ingresos_internos` y `recaudacion_abonos` en período, concilia contra la Central de Reportes y exporta un libro Excel de **9 hojas** (`00_RESUMEN` a `08_DOCUMENTOS_PENDIENTES`), además de una **muestra anonimizada**.
- Cuando una persona no tiene DNI válido o tiene un placeholder sintético (`TEMP_*`, `SOC-*`, `INQ-*`, `DEP-*`, etc.), se clasifica y exporta como **`SIN REGISTRAR`** (y **`NO APLICA`** cuando no existe persona de padrón vinculada). La exportación con DNI completo está restringida en el servicio/UI a `Administrador` y `Caja`.

### 4.7. Notificaciones híbridas y Recibos
- Eventos persistentes (`notificaciones` vía triggers) + alertas dinámicas en memoria en `notificaciones.service.ts`.
- `configuracion_recibos` (singleton) dicta textos, logo y diseño A4 / térmico 80mm; cada línea anexa `codigo_puesto` cuando corresponde a un espacio distinto del puesto cabecera.

---

## 5. Arquitectura de Backend (Supabase/PostgreSQL)

### 5.1. Roles RLS (`tipo_rol` ENUM vía `get_my_rol()`)
| Rol | Alcance real verificado |
|---|---|
| **Administrador** | Control total: anulaciones, caja/aperturas/ajustes, usuarios (`/admin/usuarios`), tarifas, recibos, edición/baja de beneficios y auditoría. |
| **Caja** | Operativa diaria: cobros, caja rápida, gastos, movimientos bancarios, padrón operativo, Reporte Contable (con exportación DNI). Sin auditoría ni edición de fechas pasadas en ingresos internos. |
| **Asistente** | Solo-lectura en RLS, pero **a medio implementar en la app**: los RPCs financieros/reportes principales exigen `Administrador`/`Caja` y Reporte Contable bloquea la exportación DNI para este rol. |

### 5.2. Patrón RPC (ACID)
- Toda escritura financiera crítica va por `rpc_*` `SECURITY DEFINER` con chequeo de rol al inicio. Lecturas agregadas o multi-tabla devuelven un solo `json`/`jsonb` desde Postgres para no verse afectadas por el límite de 1000 filas de PostgREST.
- Fechas `timestamptz` se filtran en SQL con `AT TIME ZONE 'America/Lima'` y límite superior exclusivo.
- Al cambiar la firma de un RPC existente: `DROP FUNCTION` de la firma anterior antes de recrearla.

---

## 6. Directivas Técnicas (Frontend)

- **Signals** intensivos (`signal`, `computed`, `effect`); RxJS mínimo. Standalone siempre con `ChangeDetectionStrategy.Eager` (por compatibilidad con Zone.js y señales existentes en Angular 22).
- `import()` dinámico obligatorio para `xlsx` (`ExcelExportService`, `ReportesExcelService`, `ReporteContableExcelService`).
- Accesibilidad y seguridad web: mantener `<html lang="es">`, `<main>` en `AppLayoutComponent`, controles con `aria-*`, ruta `/signup` deshabilitada (solo `/signin`) y `public/_headers` intacto.
- No incluir desarrollos de ramas no integradas (p. ej. `feat/demo-comercial`) en `main` ni en documentación pública.

---

## 7. Roadmap Actual

| Fase | Foco | Estado |
|---|---|---|
| 1–3 | Arquitectura base, Hard Reset, unificación de deuda (`00082`), Reportes v2 (`00085`), Auditoría narrativa (`00086`), Bancos (`00094`) y Estados de Cuenta (`00095`) | **Completadas** |
| 3.5 | Versión `v2.5.0`: Gestión de Ingresos (`00096`), Saldos a favor/concurrencia (`00097`), Beneficios edit/audit (`00098`), Arqueo 3 bloques, Recibos 80mm, Reportes ApexCharts/Excel/PDF, Gestión Tarjeta (`00100`), Reporte Contable | **Integrado en `main` y desplegado** (confirmar aplicación remota donde aplique) |
| 3.6–3C | Rendimiento Fases 1–3 (`00099`), retiro Vercel, cabeceras Cloudflare `_headers`, a11y/retiro `/signup` y **Migración Angular 20 → 21 → 22.3.0** (`TS 6.0.3`, `Node 22.23.4`) | **Completada y validada en producción (`fa4bce2`)** |
| 4 | Pendientes residuales: Beneficios↔Caja, triggers faltantes (`perfiles`, `configuraciones`, etc.), regla "último admin", RPC modificar cargo CC, rol `Asistente` | **Siguiente — ver [TODO.md](TODO.md)** |

_Nota: No alteres la fórmula física de caja ni `fn_deudas_pagador`; mantén intactos `public/_headers`, las credenciales cliente por RLS (nunca `service_role` en frontend) y la separación de ramas en desarrollo._
