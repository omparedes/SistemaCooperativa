# CLAUDE.md — SistemaCooperativa (Cooperativa Primero de Mayo)

Guía operativa para Claude Code al trabajar en este repositorio. Léelo siempre antes de proponer cambios.

---

## 1. Contexto del Proyecto

ERP web administrativo para la **Cooperativa Primero de Mayo** (mercado), basado en el template **TailAdmin Angular**. Gestiona el ciclo completo: padrón de socios e inquilinos con control de puestos, facturación mensual automatizada, tesorería diaria, cuenta corriente individual por persona, bancos, inventario, reportes de cierre de turno, notificaciones y auditoría inmutable.

**Estado actual:** Sistema en producción (Go-Live) con **Supabase como backend real** (PostgreSQL + RPC ACID + RLS). La base de datos fue sometida a un **Hard Reset** controlado (`00036`) para consolidar un padrón inmaculado de 288 registros (Socios, Inquilinos y Depósitos), logrando inyectar el historial financiero con cuadre perfecto al céntimo (S/ 116,569.87 de deuda total pendiente). El sistema actual está estabilizado y preparándose para recibir la facturación de Enero 2026.

---

## 2. Stack Técnico

| Capa | Tecnología |
|---|---|
| Framework | **Angular 20+ (Standalone Components)** |
| Lenguaje | **TypeScript 5.8** (strict) |
| Estilos | **Tailwind CSS v4** (configuración en `@theme`, PostCSS) |
| Bootstrapping | `bootstrapApplication` en `main.ts` (sin `AppModule`) |
| Ruteo | `app.routes.ts` centralizado — migración progresiva a Lazy Loading |
| Interfaz UI | Componentes TailAdmin (Skeletons, Badges, Modales) |
| PDF | `jspdf` y `jspdf-autotable` (Soporte A4 y Tickets térmicos 80mm) |
| Backend | **Supabase** (PostgreSQL + Auth + Triggers + RPCs `SECURITY DEFINER` + RLS) |
| Hosting | **Vercel** (CI/CD desde rama `main`) |
| Git | **GitHub** |

---

## 3. Estructura del Proyecto

```
src/app/
├── core/services/              # Singletons globales + clientes Supabase
│   ├── supabase.service.ts     # Cliente singleton de @supabase/supabase-js
│   ├── reportes.service.ts     # Lógica de Arqueo y Control de Caja Física
│   ├── notificaciones.service.ts # Lógica Híbrida (BD + Computadas al vuelo)
│   └── pdf-generator.service.ts# Motor de impresión Ticket/A4 (Base64 Logo)
├── pages/                      # Features de negocio (un folder por módulo)
│   ├── socios/                 # Padrón: listado, detalle y formulario
│   ├── cuenta-corriente/       # Gestión Financiera: deudas, pagos, historial y edición manual
│   ├── pagos/                  # Caja: Wizard de Pago, Caja Rápida (Ingresos Internos)
│   ├── recaudacion/            # Recaudación Semanal por Tarjeta (prepago de socios)
│   ├── facturacion/            # Emisión masiva: Medidores, Cargos Fijos, Extraordinarios
│   ├── gastos/                 # Egresos operativos del día
│   ├── reportes/               # Arqueo de Caja Diario + Central de Reportes
│   ├── config/                 # Tarifas parametrizables y Configuración de Recibos
│   ├── auditoria/              # Log inmutable de acciones críticas (solo lectura)
│   └── consultas/              # Portal público: consulta de deuda sin login
├── shared/
│   ├── layout/                 # AppLayout, AppSidebar, AppHeader (con Campana de Notif.)
│   └── components/             # UI reutilizables
```

**Migraciones Supabase** en `supabase/migrations/` (numeradas secuencialmente > 00041).

---

## 4. Reglas de Dominio (CRÍTICAS)

Estas reglas son **no negociables**. Cualquier cambio que las viole debe rechazarse o discutirse antes de implementar.

### 4.1. Padrón: Puestos Múltiples y Entidades
- El sistema soporta asignaciones múltiples. Un socio/inquilino puede alquilar su Puesto Principal y, simultáneamente, un Puesto en el 2do Piso (-SP), Espacio (-EP) o Depósito (-D).
- Todos los alquileres son directamente con "LA COOPERATIVA" (Socio Maestro con DNI `00000000`).

### 4.2. Control de Caja Física y Arqueo (¡Nuevo!)
- El "Arqueo de Caja" desglosa los métodos de pago. Las transferencias, BBVA o PLIN **no entran en la gaveta**.
- El **Efectivo Físico en Caja** se calcula rigurosamente como:
  `Apertura_Monto + Total_Ingresos_Efectivo - Total_Gastos_Efectivo - Total_Faltantes + Total_Sobrantes`.
- Las tablas `caja_aperturas` (fecha única) y `caja_ajustes` manejan estos saldos.

### 4.3. No Borrar Históricos (Append-Only y Soft Delete)
- **Prohibido `DELETE FROM`** en tablas financieras o de historiales de personas.
- La anulación de pagos se hace vía `rpc_anular_pago`, lo que dispara **Triggers** en la base de datos para registrar la auditoría en la tabla `notificaciones`.

### 4.4. Notificaciones Híbridas
- **Eventos Persistentes:** La anulación de pagos/cargos y el bajo stock insertan filas en la tabla `notificaciones` vía Triggers (`SECURITY DEFINER`).
- **Alertas Dinámicas:** Alertas como "Morosidad Crítica" (>= 3 meses) o "Cierre de Caja" (>= 6PM) se computan dinámicamente en TypeScript en el `notificaciones.service.ts` sin llenar la base de datos.

### 4.5. Configuración de Recibos (Identidad Visual)
- Existe una tabla singleton `configuracion_recibos` que dicta los textos y diseño de los tickets generados. La UI (`/configuracion/recibos`) permite modificar dinámicamente este diseño con *Live Preview*.

---

## 5. Arquitectura de Backend (Supabase/PostgreSQL)

### 5.1. Roles RLS (`tipo_rol` ENUM)
| Rol | Permisos |
|---|---|
| **Administrador** | Acceso total. Único que puede anular pagos, registrar aperturas/ajustes de caja, y modificar configuración de recibos. |
| **Caja** | Operativa del día a día (cobros, gastos). Bloqueado de ver la auditoría y ajustes de caja mayor. |

### 5.2. Patrón RPC (ACID)
- Toda escritura financiera crítica (pagos, recaudación masiva, edición de deuda) se ejecuta mediante **Stored Procedures (`rpc_*`)**. Si un paso falla, se aplica `ROLLBACK` automático.
- No hacer lógicas transaccionales distribuidas en Angular. Si requiere más de 1 insert/update dependiente, hacer un RPC.

---

## 6. Directivas Técnicas (Frontend)

### 6.1. Angular 20 Standalone y Signals
- **Prohibido `NgModule`.** Usa `standalone: true`.
- Usa intensivamente **Signals** (`signal`, `computed`, `effect`) para reactividad fina sin RxJS donde sea posible.

### 6.2. Tailwind y UI
- Evitar frameworks de componentes externos. Respetar el DOM de TailAdmin.
- Soportar siempre `dark:` mode en las vistas nuevas.

---

## 7. Roadmap Actual

| Fase | Foco | Estado |
|---|---|---|
| **Fase 1** | Arquitectura base, Ruteo, UI Framework | Completada |
| **Fase 2** | Migración Financiera, Hard Reset de Padrón, Arqueos exactos, RLS | **Completada** |
| **Fase 3** | Inyección de Egresos e Ingresos Extraordinarios de Enero 2026, Auditoría visual | **Siguiente Paso** |

_Nota para Claude Code: El usuario inyectará la data extracontable de Enero 2026 usando la UI y scripts. Limítate a optimizar consultas, mantener el Free Tier de Supabase a salvo, y no alteres la fórmula de la caja física._
