# CLAUDE.md — SistemaCooperativa (Cooperativa Primero de Mayo)

Guía operativa para Claude Code al trabajar en este repositorio. Léelo siempre antes de proponer cambios.
Documentos hermanos: [CONTEXT.md](CONTEXT.md) (negocio y flujos) · [ARCHITECTURE.md](ARCHITECTURE.md) (decisiones y porqués) · [AUDITORIA_2026.md](AUDITORIA_2026.md) (estado de salud por módulo) · [TODO.md](TODO.md) (backlog priorizado).

---

## 1. Contexto del Proyecto

ERP web administrativo para la **Cooperativa Primero de Mayo** (mercado), basado en el template **TailAdmin Angular**. Gestiona el ciclo completo: padrón de socios e inquilinos con control de puestos y almacenes, facturación mensual automatizada, tesorería diaria, cuenta corriente individual, bancos, inventario, reportes con drill-down y exportación Excel, portal público de consultas, dietas/provisión social, notificaciones y **auditoría narrativa inmutable** (timeline).

**Estado actual (julio 2026):** Sistema **en producción (Go-Live)** con Supabase como backend real. Padrón consolidado de 288 registros tras el Hard Reset (`00036`); historial financiero de enero–junio 2026 cargado, regularizado y cuadrado al céntimo (00083). La deuda consolidada está unificada en una sola fuente de verdad (00082), los reportes agregan server-side (00085) y la auditoría es tipo timeline con motivos (00086). Última migración: `00086`.

---

## 2. Stack Técnico

| Capa | Tecnología |
|---|---|
| Framework | **Angular 20+ (Standalone Components)** — prohibido `NgModule` |
| Lenguaje | **TypeScript 5.8** (strict; prohibido `any`) |
| Estilos | **Tailwind CSS v4** (`@theme`, PostCSS) · dark mode obligatorio en vistas nuevas |
| Ruteo | `app.routes.ts` centralizado con `loadComponent` (lazy) |
| UI | Patrones TailAdmin (skeletons, badges, modales) · SVG inline, sin librerías de iconos |
| PDF | `pdfmake` (tickets térmicos 80mm y A4; diseño dinámico desde `configuracion_recibos`) |
| Excel | `xlsx` (SheetJS) **solo vía `import()` dinámico** en `ExcelExportService` — nunca importarlo estático |
| Backend | **Supabase** (PostgreSQL + Auth + Triggers + RPCs `SECURITY DEFINER` + RLS) |
| Hosting | **Vercel** (CI/CD desde `main`) · cuidar el **Free Tier** (egress y storage) |

---

## 3. Estructura del Proyecto

```
src/app/
├── core/
│   ├── guards/                 # authGuard, adminGuard, noAuthGuard
│   └── services/               # Singletons + cliente Supabase
│       ├── supabase.client.ts / auth.service.ts (signals de sesión y rol)
│       ├── pagos.service.ts    # Caja: búsqueda, deudas (RPC), cobro, historial, anulación
│       ├── socios/inquilinos/puestos/giros/gastos/bancos/inventario .service.ts
│       ├── reportes.service.ts # Arqueo diario + Reportes v2 (RPCs 00085)
│       ├── auditoria.service.ts# Timeline (RPC 00086, keyset pagination)
│       ├── excel-export.service.ts / pdf-generator.service.ts
│       ├── beneficios.service.ts (dietas / provisión social)
│       └── notificaciones.service.ts (híbrido: BD + computadas)
├── pages/                      # Un folder por módulo de negocio (standalone, template inline)
│   ├── socios/                 # Padrón: list/detail/form de socios e inquilinos
│   ├── espacios/               # Puestos, almacenes, ocupaciones, transferencias
│   ├── pagos/                  # pago-wizard (Caja), Caja Rápida, recaudación diaria
│   ├── recaudacion/            # Recaudación semanal por tarjeta (prepago)
│   ├── cuenta-corriente/       # Gestión financiera por persona
│   ├── facturacion/            # Medidores, cargos fijos, distribución, extraordinarios
│   ├── gastos/ · bancos/ · inventario/
│   ├── reportes/               # Central de Reportes (drill-down + Excel) + Arqueo + Beneficios
│   ├── auditoria/              # Timeline narrativo (+ auditoria-labels.ts, diccionario UI)
│   ├── consultas/              # Portal público sin login
│   ├── config/                 # Tarifas + diseño de recibos (live preview)
│   └── usuarios/               # Gestión de roles (solo Admin)
└── shared/                     # AppLayout, AppSidebar, AppHeader, componentes UI
```

**Migraciones** en `supabase/migrations/` (numeradas `000NN_...`, última `00086`). **Generadores y diagnósticos** en `scripts/` (p. ej. `deteccion_recibos_huerfanos.sql`).

---

## 4. Reglas de Dominio (CRÍTICAS — no negociables)

### 4.1. Deuda consolidada: UNA sola fuente de verdad
- `fn_deudas_pagador(tipo, id)` (00082) define qué debe una persona: cargos personales + puestos vigentes + almacenes vigentes. **Prohibido reimplementar ese predicado**: toda vista nueva consume `rpc_caja_cargar_deudas` (o delega en la función desde SQL). Caja, Cuenta Corriente, Padrón y Portal Público deben mostrar exactamente los mismos conceptos y saldos.

### 4.2. Padrón: espacios y ocupantes
- Espacios: `Regular` y `Pequeño` (principales) y `Almacén` (complementario, nunca principal). Personas: `Socio` (titular), `Inquilino` (arrendatario) y `Tercero` (solo almacenes).
- Todos los alquileres son con "LA COOPERATIVA" (Socio Maestro DNI `00000000`).
- Historial inmutable: transferencias y liberaciones cierran la fila vigente (`fecha_fin`) y crean una nueva; jamás se sobreescribe quién ocupó qué.

### 4.3. Control de Caja Física y Arqueo
- Transferencias/PLIN/BBVA **no entran en la gaveta**. El efectivo físico se calcula **rigurosamente** como:
  `Apertura + Ingresos_Efectivo − Gastos − Faltantes + Sobrantes`
  (`caja_aperturas` con fecha única, `caja_ajustes`). **No alterar esta fórmula.**
- Los gastos no distinguen método de pago porque los egresos bancarios viven en `movimientos_bancarios`.

### 4.4. Append-Only y Soft Delete
- **Prohibido `DELETE`** en tablas financieras/personas. Anulación = `deleted_at + anulado_por + motivo_anulacion` (los tres o ninguno). Pagos se anulan solo vía `anular_pago` (cascada soft a detalles, restaura estados y saldo a favor). Recibos emitidos = inmutables.

### 4.5. Auditoría narrativa (00086)
- `audit_logs` es append-only (RLS solo-Admin, sin UPDATE/DELETE). El trigger genérico `log_audit_action()` captura payloads y el **motivo** desde `set_config('app.audit_motivo', p_motivo, true)` — todo RPC nuevo que haga cambios sensibles debe setear esa variable antes del UPDATE.
- Ediciones directas del padrón van por `rpc_actualizar_con_motivo` (whitelist de columnas), nunca `.update()` PostgREST.
- **No** añadir triggers de auditoría a `montos_por_cobrar`/`detalle_pagos` (ruido de facturación masiva); el pago ya narra esos movimientos.

### 4.6. Notificaciones híbridas
- Eventos persistentes (anulaciones, bajo stock) → filas en `notificaciones` vía triggers. Alertas dinámicas (morosidad ≥3 meses, cierre de caja ≥6PM) → computadas en `notificaciones.service.ts`, sin llenar la BD.

### 4.7. Recibos
- `configuracion_recibos` (singleton) dicta textos y diseño; letra grande (socios mayores); reimpresión permitida sin alterar el original. Cada línea del ticket anexa el `codigo_puesto` cuando el cargo pertenece a un espacio distinto del puesto de cabecera.

---

## 5. Arquitectura de Backend (Supabase/PostgreSQL)

### 5.1. Roles RLS (`tipo_rol` ENUM vía `get_my_rol()`)
| Rol | Permisos |
|---|---|
| **Administrador** | Total. Único que anula pagos, gestiona apertura/ajustes de caja, usuarios, tarifas, recibos y ve la auditoría. |
| **Caja** | Operativa diaria (cobros, gastos, padrón). Sin auditoría ni caja mayor. |
| **Asistente** | Solo-lectura *en RLS*, pero **a medio implementar** en la app (los RPCs lo rechazan). No construyas sobre él sin resolver [TODO.md](TODO.md). |

### 5.2. Patrón RPC (ACID)
- Toda escritura financiera crítica va por `rpc_*` `SECURITY DEFINER` con chequeo de rol al inicio. Si algo requiere >1 insert/update dependiente, es un RPC — nunca lógica transaccional en Angular.
- **Lecturas agregadas o multi-tabla → RPC que devuelve UN valor `json`** (evita el límite de 1000 filas de PostgREST y ahorra egress). Nunca sumar filas crudas en el navegador para rangos amplios. PostgREST directo solo para lecturas simples de una tabla.
- Fechas de negocio: rangos como `date` locales; columnas `timestamptz` se filtran con `AT TIME ZONE 'America/Lima'` y límite superior exclusivo (ver ADR-04 en ARCHITECTURE.md).
- Al cambiar la firma de un RPC existente: `DROP FUNCTION` de la firma vieja primero (los defaults nuevos crean sobrecargas ambiguas). En plpgsql, tras `EXECUTE` usa `GET DIAGNOSTICS ... ROW_COUNT` (no `FOUND`).

---

## 6. Directivas Técnicas (Frontend)

- **Signals** intensivos (`signal`, `computed`, `effect`); RxJS mínimo. Standalone siempre.
- Componentes de página con template inline estilo TailAdmin; drill-downs con carga lazy y caché por filtros (patrón de `reportes.component.ts`).
- Etiquetas/traducciones de presentación viven en el frontend (p. ej. `auditoria-labels.ts`), no en SQL.
- Exportación Excel: usar `ExcelExportService` (SheetJS lazy). PDF: `PdfGeneratorService`.
- Formateadores de moneda/fecha: hoy están duplicados por componente (deuda técnica conocida) — si tocas uno, considera extraerlo a `shared/utils/`.

---

## 7. Roadmap Actual

| Fase | Foco | Estado |
|---|---|---|
| 1 | Arquitectura base, ruteo, UI framework | Completada |
| 2 | Migración financiera, Hard Reset del padrón, arqueos exactos, RLS | Completada |
| 3 | Datos ene–jun 2026 + unificación de deuda (00082–00084) + Reportes v2 (00085) + Auditoría narrativa (00086) | **Completada (jul 2026)** |
| 4 | Hardening post-auditoría: concurrencia en cobros, Dietas↔Caja, triggers de auditoría faltantes, regla "último admin" | **Siguiente — ver [TODO.md](TODO.md)** |

_Nota para Claude Code: no alteres la fórmula de caja física ni el predicado de `fn_deudas_pagador`; mantén el Free Tier a salvo (agregación server-side, sin descargas masivas); y al cerrar un hito actualiza este archivo, CONTEXT.md §5 y TODO.md._
