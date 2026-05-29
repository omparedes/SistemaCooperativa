---
name: supabase-security-and-rls
description: "Inspecciona RLS, políticas, roles y exposición de claves en Supabase para garantizar la seguridad del portal y panel administrativo."
metadata:
  author: Antigravity
  version: "1.0.0"
---

# Supabase Security & Row Level Security (RLS)

Este manual de estándares asegura que cualquier cambio en la base de datos de Supabase mantenga los máximos niveles de seguridad requeridos por el ERP.

## Principios de Seguridad Críticos

### 1. Claves y Variables de Entorno
* **Llave `anon` (Publishable Key)**: Es la única llave que puede ser expuesta en el frontend Angular (`src/environments/environment.ts`).
* **Llave `service_role` (Secret Key)**: NUNCA debe estar en el cliente. Esta llave salta todas las políticas de RLS. Solo se permite en scripts de migración, seeds o tareas administrativas en backend.

### 2. Políticas RLS (Row Level Security)
* Toda tabla creada en el esquema `public` **debe** tener RLS activado:
  ```sql
  alter table public.nombre_tabla enable row level security;
  ```
* Se debe definir políticas explícitas de acceso (`SELECT`, `INSERT`, `UPDATE`) para los roles `authenticated` y `anon` (según corresponda).
* NUNCA utilices `raw_user_meta_data` en las políticas RLS para autorización, ya que el usuario puede editarla desde el cliente. Usa `public.get_my_rol()` para validar el rol administrativo o cajero del usuario.

### 3. Seguridad en Vistas (Views)
* Por defecto, las vistas SQL en PostgreSQL saltan las políticas RLS de las tablas subyacentes.
* Toda vista creada debe incluir la opción de seguridad del invocador en PostgreSQL 15 o superior:
  ```sql
  create or replace view public.nombre_vista
  with (security_invoker = true)
  as select ...
  ```

### 4. Funciones RPC con `security definer`
* Si creas funciones que requieren saltar RLS temporalmente para realizar tareas administrativas (ej. auditoría o creación de usuarios), defínelas con `security definer`.
* **IMPORTANTE**: Establece siempre explícitamente el `search_path` en estas funciones para evitar ataques de inyección de esquemas:
  ```sql
  create or replace function public.rpc_funcion_segura()
  returns void
  language plpgsql
  security definer
  set search_path = public
  as $$ ... $$;
  ```
* Valida el rol al inicio de toda función crítica de escritura:
  ```sql
  if public.get_my_rol() <> 'Administrador' then
      raise exception 'Acceso denegado';
  end if;
  ```
