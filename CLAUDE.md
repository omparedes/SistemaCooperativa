# CLAUDE.md — SistemaCooperativa (Cooperativa Primero de Mayo)

Guía operativa para Claude Code al trabajar en este repositorio. Léelo siempre antes de proponer cambios.

---

## 1. Contexto del Proyecto

ERP web administrativo para la **Cooperativa Primero de Mayo** (mercado), basado en el template **TailAdmin Angular**. Gestiona el ciclo completo: padrón de socios e inquilinos con control de puestos, facturación mensual automatizada (luz, agua, cuotas fijas, cargos extraordinarios), tesorería diaria (caja rápida, recaudación semanal por tarjeta), cuenta corriente individual por persona, bancos, inventario interno, reportes de cierre de turno y auditoría inmutable.

**Estado actual:** Sistema en producción con **Supabase como backend real** (PostgreSQL + RPC ACID + RLS). La migración Mock→Supabase está en curso módulo a módulo; algunos componentes aún leen de LocalStorage como fallback mientras se conectan al servicio HTTP correspondiente.

---

## 2. Stack Técnico

| Capa | Tecnología |
|---|---|
| Framework | **Angular 20+ (Standalone Components)** |
| Lenguaje | **TypeScript 5.8** (strict) |
| Estilos | **Tailwind CSS v4** (configuración en `@theme`, PostCSS) |
| Bootstrapping | `bootstrapApplication` en `main.ts` (sin `AppModule`) |
| Ruteo | `app.routes.ts` centralizado — migración progresiva a Lazy Loading |
| Charts | ApexCharts (`ng-apexcharts`) y amCharts 5 |
| Calendario | FullCalendar |
| Backend | **Supabase** (PostgreSQL + Auth + RPCs `SECURITY DEFINER` + RLS) |
| Hosting | **Vercel** (CI/CD desde rama `main`) |
| Control de versiones | **GitHub** |

---

## 3. Estructura del Proyecto

```
src/app/
├── core/services/              # Singletons globales + clientes Supabase
│   ├── supabase.service.ts     # Cliente singleton de @supabase/supabase-js
│   ├── reportes.service.ts     # Datos de cierre de turno y arqueo
│   └── sidebar.service.ts / theme.service.ts / ...
├── pages/                      # Features de negocio (un folder por módulo)
│   ├── socios/                 # Padrón: listado, detalle y formulario de Socios
│   ├── cuenta-corriente/       # Gestión Financiera: deudas, pagos e historial por persona
│   │   ├── cuenta-corriente-list.component.ts
│   │   ├── cuenta-corriente-detail.component.ts
│   │   ├── cuenta-corriente.service.ts
│   │   └── cuenta-corriente.model.ts
│   ├── pagos/                  # Caja: Wizard de Pago, Caja Rápida (Ingresos Internos)
│   ├── recaudacion/            # Recaudación Semanal por Tarjeta (prepago de socios)
│   │   ├── recaudacion.component.ts
│   │   ├── recaudacion.service.ts
│   │   └── recaudacion.model.ts
│   ├── facturacion/            # Emisión masiva: Medidores, Cargos Fijos, Extraordinarios
│   ├── gastos/                 # Egresos operativos del día
│   ├── bancos/                 # Movimientos bancarios corporativos
│   ├── inventario/             # Almacén interno (kardex de entradas/salidas)
│   ├── reportes/               # Arqueo de Caja Diario + Central de Reportes
│   ├── auditoria/              # Log inmutable de acciones críticas (solo lectura)
│   ├── consultas/              # Portal público: consulta de deuda sin login
│   ├── config/                 # Tarifas globales parametrizables
│   ├── profile/                # Perfil de usuario autenticado
│   └── dashboard/              # KPIs y métricas gerenciales
├── shared/
│   ├── layout/                 # AppLayout, AppSidebar, AppHeader
│   ├── components/             # UI reutilizables (modales, badges, etc.)
│   └── pipe/                   # SafeHtml y pipes de presentación
├── app.routes.ts
├── app.config.ts
└── app.component.ts
```

**Migraciones Supabase** en `supabase/migrations/` (00001 → 00032 numeradas secuencialmente).

---

## 4. Reglas de Dominio (CRÍTICAS)

Estas reglas son **no negociables**. Cualquier cambio que las viole debe rechazarse o discutirse antes de implementar.

### 4.1. Padrón: Socios e Inquilinos
- El sistema diferencia estructuralmente dos perfiles: **socios** (titulares/dueños de puesto) e **inquilinos** (arrendatarios que ocupan un puesto y asumen deudas operativas).
- La asignación de un puesto se registra en `historial_titularidad` (socios) y `historial_arriendos` (inquilinos). Estos historiales son **inmutables** — nunca se eliminan ni se editan retroactivamente.
- El titular activo de un puesto en un momento dado se determina por el registro vigente en el historial, no por un campo "activo" editable.

### 4.2. Manejo de Pagos y Deudas
- Las deudas se generan vía RPC desde el módulo de Facturación o Cuenta Corriente (cargo manual). Nunca se insertan directamente en `montos_por_cobrar` desde el frontend.
- El registro de pagos sigue el **wizard de 3 pasos** (`pago-wizard.component.ts`): (1) selección de deudas/conceptos, (2) confirmación de monto y método, (3) generación de recibo. No alterar este flujo sin consenso.
- Una vez generado un pago (`pagos` + `detalle_pagos`), su monto, fecha y conceptos son **inmutables**. Las correcciones usan anulación (soft delete) + pago compensatorio. Solo se permite editar `comprobante` y `fecha_pago` mediante `rpc_editar_pago`.
- Validar siempre **monto > 0** y que las deudas seleccionadas existan y no estén anuladas antes de invocar el RPC.

### 4.3. No Borrar Históricos (Append-Only)
- **Prohibido `DELETE FROM`** en las tablas: `pagos`, `detalle_pagos`, `montos_por_cobrar`, `recaudacion_abonos`, `movimientos_bancarios`, `gastos`, `historial_titularidad`, `historial_arriendos` y cualquier tabla de auditoría.
- Para "anular": usar **soft delete** con el triple `(deleted_at, anulado_por, motivo_anulacion)`. El RPC `rpc_anular_pago` es el único punto de entrada válido para anular pagos.
- La auditoría (`/auditoria`) es de **solo lectura** y append-only. Los triggers la escriben automáticamente.

### 4.4. Cuadre de Caja
- El Arqueo de Caja Diario calcula: `(Recibos del día + Ingresos Internos) - Gastos = Saldo Neto Físico en Caja`.
- Si efectivo + transferencias ≠ total esperado, la discrepancia debe mostrarse **explícitamente** en la UI. Nunca ocultar diferencias.

### 4.5. Recaudación por Tarjeta (Prepago Semanal)
- Solo participan socios marcados con `usa_recaudacion_tarjeta = true`.
- Los abonos se procesan por lote (`rpc_recaudacion_masiva`) y se acumulan en `socios.saldo_a_favor`.
- Un abono fallido en el lote (socio inexistente, monto ≤ 0) se omite con WARNING sin revertir el resto del lote (skip-on-error intencional).
- El saldo a favor acumulado se aplica luego en el Wizard de Pagos.

### 4.6. Cuenta Corriente
- La vista de Cuenta Corriente es el **estado financiero completo** de una persona (socio o inquilino): deudas pendientes, historial de pagos y saldo a favor.
- Desde aquí el Administrador puede agregar cargos manuales (sin pasar por facturación masiva) y registrar abonos directos.
- La búsqueda acepta tanto socios como inquilinos; el frontend filtra por `tipo: 'socio' | 'inquilino'` desde el modelo `PersonaResumen`.

---

## 5. Arquitectura de Backend (Supabase/PostgreSQL)

### 5.1. Roles RLS (`tipo_rol` ENUM)

| Rol | Permisos |
|---|---|
| **Administrador** | SELECT/INSERT/UPDATE en todas las tablas financieras. Único que puede anular pagos, cambiar roles y gestionar el padrón completo. |
| **Caja** | SELECT/INSERT en pagos, gastos, mediciones, recaudación. No puede anular ni modificar deudas. |
| **Asistente** | Solo SELECT en todo. Rol por defecto al crear usuario. |

- El helper `get_my_rol()` (SECURITY DEFINER, STABLE) es el único punto de verdad para las políticas RLS. No duplicar esta lógica en el frontend.
- `DELETE` está bloqueado estructuralmente en todas las tablas de negocio (no hay policy FOR DELETE).

### 5.2. Patrón RPC (ACID)
- Toda escritura financiera crítica se realiza mediante **Stored Procedures (`rpc_*`)** invocados con `supabase.rpc(...)` desde el servicio Angular.
- Los RPCs usan `SECURITY DEFINER` y validan el rol del usuario internamente (no confiar solo en RLS para lógica de negocio compleja).
- Ejemplos clave: `rpc_procesar_pago`, `rpc_anular_pago`, `rpc_recaudacion_masiva`, `rpc_emitir_cargos_fijos`, `rpc_cargo_segmentado`, `rpc_editar_pago`.

### 5.3. Transacciones ACID
- Los RPCs envuelven todas sus operaciones en un bloque de transacción implícito (PL/pgSQL). Si falla cualquier paso, hace ROLLBACK automático.
- Los triggers activos (`tg_set_updated_at`, `tg_handle_new_user`, triggers de inventario y auditoría) se ejecutan a nivel BD sin intervención del frontend.

---

## 6. Directivas Técnicas (Frontend)

### 6.1. Arquitectura Standalone
- **Prohibido crear `NgModule`s nuevos.** El proyecto es 100% Standalone.
- Cada componente declara sus `imports` directamente.
- Bootstrapping vía `bootstrapApplication(AppComponent, appConfig)`.

### 6.2. Estado vía Servicios
- **No usar gestores de estado externos** (NgRx, Akita, etc.).
- El estado compartido vive en **servicios `providedIn: 'root'`** con señales (`signal`, `computed`) o `BehaviorSubject`s.
- Los servicios de negocio (Supabase HTTP) viven en `core/services/` o junto al feature (`cuenta-corriente.service.ts`, `recaudacion.service.ts`).

### 6.3. TypeScript
- **Prohibido `any`.** Usar tipos explícitos, `unknown` con narrowing, o generics.
- Modelos de dominio (Socio, Pago, Gasto, PersonaResumen, etc.) deben vivir en `*.model.ts` o `*.types.ts` junto al feature.
- `strict: true` activo — respetarlo.

### 6.4. UI / TailAdmin
- Respetar los **patrones visuales y de componentes de TailAdmin**: tarjetas, tablas, formularios, modales, breadcrumbs, dark mode.
- Usar clases `dark:` en todo elemento nuevo.
- Usar la paleta `brand-*` definida en `@theme` antes de inventar colores.
- No introducir librerías UI adicionales (Material, PrimeNG, etc.).

### 6.5. Ruteo
- Todas las rutas en `app.routes.ts`. No fragmentar en módulos de ruteo.
- Migrar progresivamente a **Lazy Loading** con `loadComponent`.

---

## 7. Roadmap por Fases

| Fase | Foco | Estado |
|---|---|---|
| **Fase 1** | Arquitectura Standalone, eliminar NgModules, ruteo centralizado | **Completada** |
| **Fase 2** | Integración Supabase: RPCs ACID, RLS por rol, Padrón real, Pagos, Recaudación | **En producción** |
| **Fase 3** | Auth UI completa, gestión de usuarios desde la app, reportes PDF en producción, Lazy Loading global | **En curso** |

---

## 8. Comandos

```bash
npm start          # ng serve → http://localhost:4200
npm run build      # producción
npm run watch      # build incremental
npm test           # Karma + Jasmine
```

---

## 9. Documentación Viva

El manual de usuario completo vive en la ruta `/documentation` de la propia app ([documentation.component.html](src/app/pages/documentation/documentation.component.html)). Es la fuente de verdad para alcance funcional, módulos y vistas.

Las migraciones de BD viven en `supabase/migrations/` y son la fuente de verdad del esquema. El número de migración es secuencial y nunca se reutiliza.
