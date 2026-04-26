# CLAUDE.md — SistemaCooperativa (Cooperativa Primero de Mayo)

Guía operativa para Claude Code al trabajar en este repositorio. Léelo siempre antes de proponer cambios.

---

## 1. Contexto del Proyecto

Aplicación web administrativa para la **Cooperativa Primero de Mayo**, basada en el template **TailAdmin Angular**. Gestiona socios (puesteros/inquilinos del mercado), pagos, recaudación, gastos operativos, inventario interno y reportes.

**Estado actual:** prototipo de alta fidelidad. La UI está completa y funcional, pero la persistencia es **Mock Data hardcoded** o **LocalStorage**. Aún no hay backend real.

---

## 2. Stack Técnico

| Capa | Tecnología |
|---|---|
| Framework | **Angular 20+ (Standalone Components)** |
| Lenguaje | **TypeScript 5.8** (strict) |
| Estilos | **Tailwind CSS v4** (configuración en `@theme`, PostCSS) |
| Bootstrapping | `bootstrapApplication` en `main.ts` (sin `AppModule`) |
| Ruteo | `app.routes.ts` centralizado, mayormente Eager Loading |
| Charts | ApexCharts (`ng-apexcharts`) y amCharts 5 |
| Calendario | FullCalendar |
| Persistencia actual | Mock arrays + `localStorage` |
| Backend (Fase 2) | **Supabase** (PostgreSQL + Auth + Storage) |

---

## 3. Estructura del Proyecto

```
src/app/
├── core/services/      # Singletons globales (Sidebar, Theme, Modal — y futuros HTTP services)
├── pages/              # Features de negocio
│   ├── socios/         # Listado y detalle de socios/inquilinos
│   ├── pagos/          # Registro de pagos, recaudación diaria
│   ├── gastos/         # CRUD de egresos
│   ├── bancos/         # Movimientos bancarios
│   ├── inventario/     # Almacén interno
│   ├── reportes/       # Reportes históricos
│   ├── auditoria/      # Log de acciones críticas
│   └── dashboard/      # KPIs y métricas
├── shared/
│   ├── layout/         # AppLayout, Sidebar, Header
│   ├── components/     # UI puros reutilizables
│   └── pipe/           # Pipes
├── app.routes.ts
├── app.config.ts
└── app.component.ts
```

---

## 4. Reglas de Dominio (CRÍTICAS)

Estas reglas son **no negociables**. Cualquier cambio que las viole debe rechazarse o discutirse antes de implementar.

### 4.1. Manejo de Pagos
- Los pagos involucran a dos perfiles: **socios** (dueños/asociados de la cooperativa) e **inquilinos** (puesteros que arriendan). El modelo de datos y la UI deben distinguirlos claramente.
- El registro de pagos sigue un **wizard de 3 pasos**: (1) selección de conceptos, (2) confirmación de monto, (3) generación de recibo. No alterar este flujo sin consenso.
- Validar siempre **monto > 0** y que el concepto exista antes de persistir.
- Una vez generado un recibo, su monto, fecha y conceptos son **inmutables**. Las correcciones se hacen con un asiento compensatorio, nunca editando el original.

### 4.2. No Borrar Históricos
- **Prohibido eliminar físicamente** registros de: pagos, recibos, recaudación diaria, movimientos bancarios, gastos cerrados y eventos de auditoría.
- Para "anular" usar **soft delete** (`deleted_at`, `anulado_por`, `motivo_anulacion`) o un asiento de reversa. Nunca `DELETE FROM`.
- La auditoría (`/auditoria`) es de **solo lectura** y append-only.

### 4.3. Cuadre de Caja
- La recaudación diaria debe permitir visualizar diferencias (cuadres) sin ocultarlas. Si efectivo + transferencias ≠ total esperado, mostrar la discrepancia explícitamente.

---

## 5. Directivas Técnicas

### 5.1. Arquitectura Standalone
- **Prohibido crear `NgModule`s nuevos.** El proyecto es 100% Standalone y se eliminaron los módulos legacy (`SociosModule`, `GastosModule`, etc.).
- Cada componente declara sus `imports` directamente.
- Bootstrapping vía `bootstrapApplication(AppComponent, appConfig)`.

### 5.2. Estado vía Servicios
- **No usar gestores de estado externos** (NgRx, Akita, etc.) en esta fase.
- El estado compartido vive en **servicios `providedIn: 'root'`** que exponen señales (`signal`, `computed`) o `BehaviorSubject`s.
- El estado local de un componente vive en el componente. No subir a un servicio lo que solo necesita una vista.
- Los servicios de UI (Sidebar, Theme, Modal) viven en `core/services/`. Los servicios de negocio (Fase 2: HTTP a Supabase) también irán ahí.

### 5.3. TypeScript
- **Prohibido `any`.** Usar tipos explícitos, `unknown` con narrowing, o generics.
- Modelos de dominio (Socio, Pago, Gasto, etc.) deben vivir en `*.model.ts` o `*.types.ts` junto al feature.
- Activar `strict: true` (ya está) y respetarlo.

### 5.4. UI / TailAdmin
- Respetar los **patrones visuales y de componentes de TailAdmin**: tarjetas, tablas, formularios, modales, breadcrumbs, dark mode.
- Usar las clases `dark:` de Tailwind para soportar tema oscuro en todo elemento nuevo.
- Usar la paleta `brand-*` ya definida en `@theme` antes de inventar colores.
- No introducir librerías UI adicionales (Material, PrimeNG, etc.) — todo se construye con Tailwind sobre los componentes shared/.

### 5.5. Ruteo
- Todas las rutas en `app.routes.ts`. No fragmentar.
- Migrar progresivamente a **Lazy Loading** con `loadComponent` para reducir el bundle inicial (riesgo identificado en la arquitectura actual).

---

## 6. Roadmap por Fases

| Fase | Foco | Estado |
|---|---|---|
| **Fase 1** | Consolidación arquitectónica: Core, eliminar NgModules, Lazy Loading | En curso |
| **Fase 2** | Integración con **Supabase**: reemplazar Mocks/LocalStorage por servicios HTTP | Pendiente |
| **Fase 3** | Auth real, RLS por rol (admin/cajero/auditor), reportes en producción | Pendiente |

Ver el skill `supabase-patterns` para guía específica de la migración a Supabase.

---

## 7. Comandos

```bash
npm start          # ng serve → http://localhost:4200
npm run build      # producción
npm run watch      # build incremental
npm test           # Karma + Jasmine
```

---

## 8. Documentación Viva

La especificación funcional completa vive en la ruta `/documentation` de la propia app ([documentation.component.html](src/app/pages/documentation/documentation.component.html)). Es la fuente de verdad para alcance funcional, módulos y vistas.
