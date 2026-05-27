# Contexto del Proyecto: ERP SistemaCooperativa

Este documento es la **fuente de la verdad** para cualquier IA (como Claude Code o AntiGravity) o desarrollador que se una al proyecto. Contiene la arquitectura base y las reglas críticas del negocio. **No asumas el comportamiento del sistema sin leer estas reglas primero.**

## 1. Pila Tecnológica (Tech Stack)
- **Frontend:** Angular 20 (Componentes *Standalone* estrictos, sin `NgModules`). Manejo de estado 100% reactivo usando **Signals** (`signal`, `computed`, `effect`). Uso mínimo de RxJS (sólo para HTTP).
- **Estilos:** Tailwind CSS v4 (Plantilla base inspirada en TailAdmin).
- **Backend/Base de Datos:** Supabase (PostgreSQL). Toda la lógica transaccional compleja se ejecuta en la BD a través de Procedimientos Almacenados (RPCs).

## 2. Reglas de Arquitectura Críticas (¡No Romper!)
- **Soft Deletes Estrictos:** NUNCA se hace un `DELETE` duro en la base de datos para entidades principales. Se debe usar un esquema de "Soft Delete" actualizando los campos `deleted_at`, `anulado_por` y `motivo_anulacion`.
- **Transacciones ACID:** Operaciones financieras o de transferencia de puestos deben usar RPCs de Postgres para asegurar atomicidad. Nunca hacer múltiples inserciones desde el frontend que puedan quedar huérfanas si falla la red.
- **Seguridad RLS:** Todo está protegido por Políticas de Seguridad a Nivel de Fila (RLS). Las políticas se basan en una función custom `get_my_rol()` para separar permisos de Administradores vs Cajeros/Lectura.

## 3. Lógica del Negocio: Módulo Financiero
- **El Cobro es al Espacio, no a la Persona:** Los servicios (Luz, Agua, Cuota Social) se generan en función del espacio físico activo.
- **Caja vs Bancos:** El sistema diferencia estrictamente la recaudación en la gaveta física (Efectivo) de las transferencias (PLIN, BBVA).

## 4. Lógica del Negocio: Espacios y Ocupación (El Padrón)
El sistema separa radicalmente el "Ladrillo" (El Espacio) del "Papel" (El Contrato).
- **Entidad Física (Espacios):** Existen 3 tipos lógicos y visuales:
  1. `Regular`: Puesto Comercial Principal.
  2. `Pequeño`: Puesto Comercial Principal de menor tamaño.
  3. `Almacén`: Espacio Complementario. NUNCA puede ser un espacio principal.
- **Entidad Legal (Personas):** Existen 3 tipos:
  1. `Socio`: Titular. Puede tener 1 Puesto Principal y N Almacenes.
  2. `Inquilino`: Arrendatario. Puede tener 1 Puesto Principal y N Almacenes.
  3. `Tercero`: Externo. **SÓLO** puede tener Almacenes asignados. Tiene prohibido ocupar Puestos Principales.
- **Historial Inmutable:** Cuando alguien transfiere un puesto o libera un almacén, **no se borra su registro**. Se actualiza la `fecha_fin` del contrato actual y se crea una nueva fila de ocupación. El historial de quién ocupó qué puesto en qué fecha es sagrado.

## 5. Estado Actual del Desarrollo
* Último Hito: Refactorización del módulo de Puestos (`/espacios`) dividiendo exitosamente la gestión de almacenes complementarios y la activación/desactivación granular de cobros de servicios (Luz/Agua).
* UI Actualizada: Tablas con Signals, ordenamiento por cabeceras y Toggles de servicios optimistas.

---
> **Nota para IAs:** Al implementar un nuevo *feature*, evalúa si rompe alguna de estas reglas de negocio. Una vez finalizado el desarrollo, actualiza la sección 5 de este archivo.
