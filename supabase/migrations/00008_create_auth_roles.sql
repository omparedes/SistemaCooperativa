-- =============================================================================
-- Migración 00008 — Sistema de Autenticación y Roles
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Crea:
--   * ENUM tipo_rol          ('Administrador', 'Caja', 'Asistente')
--   * public.perfiles        (espejo de auth.users con rol asignado)
--   * tg_handle_new_user     (trigger: auto-inserta perfil al crear usuario)
--   * get_my_rol()           (helper estable para RLS, security definer)
--   * RLS refinada en tablas financieras clave
--
-- Matriz de permisos (§7 skill cooperative-payments-domain):
--
--   Tabla                │ Administrador       │ Caja           │ Asistente
--   ─────────────────────┼─────────────────────┼────────────────┼──────────
--   pagos                │ SELECT/INSERT/UPDATE │ SELECT/INSERT  │ SELECT
--   detalle_pagos        │ SELECT/INSERT/UPDATE │ SELECT/INSERT  │ SELECT
--   montos_por_cobrar    │ SELECT/INSERT/UPDATE │ SELECT         │ SELECT
--   conceptos            │ SELECT/INSERT/UPDATE │ SELECT         │ SELECT
--   mediciones_luz       │ SELECT/INSERT/UPDATE │ SELECT/INSERT  │ SELECT
--   registro_artefactos  │ SELECT/INSERT/UPDATE │ SELECT/INSERT  │ SELECT
--   gastos               │ SELECT/INSERT/UPDATE │ SELECT/INSERT  │ SELECT
--   categorias_gasto     │ SELECT/INSERT/UPDATE │ SELECT         │ SELECT
--   socios               │ SELECT/INSERT/UPDATE │ SELECT         │ SELECT
--   inquilinos           │ SELECT/INSERT/UPDATE │ SELECT         │ SELECT
--   puestos / giros      │ SELECT/INSERT/UPDATE │ SELECT         │ SELECT
--   perfiles             │ SELECT (all) /UPDATE │ SELECT (own)   │ SELECT (own)
--   vistas financieras   │ SELECT               │ SELECT         │ SELECT
--
-- DELETE: bloqueado estructuralmente en todas las tablas (no hay policy).
--         Las "eliminaciones" son SIEMPRE soft-delete vía UPDATE (deleted_at).
-- =============================================================================


-- =============================================================================
-- 1. ENUM tipo_rol
-- =============================================================================
do $$ begin
    if not exists (select 1 from pg_type where typname = 'tipo_rol') then
        create type public.tipo_rol as enum ('Administrador', 'Caja', 'Asistente');
    end if;
end $$;

comment on type public.tipo_rol is
    'Roles de usuario del sistema. Administrador = acceso total. Caja = operación diaria. Asistente = solo lectura.';


-- =============================================================================
-- 2. TABLA perfiles
--    Una fila por usuario de auth.users.  El trigger la rellena al registrar.
-- =============================================================================
create table if not exists public.perfiles (
    id          uuid            primary key
                                references auth.users(id) on delete cascade,
    email       text            not null,
    rol         public.tipo_rol not null default 'Asistente',
    nombres     text,
    activo      boolean         not null default true,
    created_at  timestamptz     not null default now(),
    updated_at  timestamptz     not null default now()
);

comment on table public.perfiles is
    'Perfil de cada usuario del sistema. Creado automáticamente por tg_handle_new_user al registrarse en auth.users.';
comment on column public.perfiles.rol is
    'El rol inicial es ''Asistente''. Un Administrador debe promoverlo desde la tabla o el dashboard.';

drop trigger if exists trg_perfiles_set_updated_at on public.perfiles;
create trigger trg_perfiles_set_updated_at
    before update on public.perfiles
    for each row execute function public.tg_set_updated_at();


-- =============================================================================
-- 3. TRIGGER: auto-crear perfil cuando se registra un usuario en auth.users
-- =============================================================================
create or replace function public.tg_handle_new_user()
returns trigger
language plpgsql
security definer           -- ejecuta con permisos del owner (postgres) para escribir en perfiles
set search_path = public
as $$
begin
    insert into public.perfiles (id, email, rol, nombres)
    values (
        new.id,
        new.email,
        'Asistente',       -- rol mínimo por defecto; el Admin lo sube manualmente
        coalesce(
            new.raw_user_meta_data->>'nombres',
            new.raw_user_meta_data->>'full_name',
            split_part(new.email, '@', 1)   -- fallback: parte local del email
        )
    )
    on conflict (id) do nothing;            -- idempotente si se re-corre la migración
    return new;
end;
$$;

comment on function public.tg_handle_new_user() is
    'Trigger AFTER INSERT ON auth.users → inserta perfil con rol Asistente por defecto.';

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
    after insert on auth.users
    for each row execute function public.tg_handle_new_user();


-- =============================================================================
-- 4. HELPER para RLS: get_my_rol()
--    Devuelve el rol del usuario actual como TEXT (null si no tiene perfil).
--    security definer + stable → se ejecuta una vez por query, no por fila.
-- =============================================================================
create or replace function public.get_my_rol()
returns text
language sql
stable
security definer
set search_path = public
as $$
    select rol::text from public.perfiles where id = auth.uid();
$$;

comment on function public.get_my_rol() is
    'Devuelve el rol (texto) del usuario autenticado actual. Usado en políticas RLS.';


-- =============================================================================
-- 5. RLS en public.perfiles
-- =============================================================================
alter table public.perfiles enable row level security;

-- Cualquier usuario autenticado ve su propio perfil
drop policy if exists pol_perfiles_select_own on public.perfiles;
create policy pol_perfiles_select_own on public.perfiles
    for select to authenticated
    using (id = auth.uid());

-- Administrador ve todos los perfiles
drop policy if exists pol_perfiles_select_admin on public.perfiles;
create policy pol_perfiles_select_admin on public.perfiles
    for select to authenticated
    using (public.get_my_rol() = 'Administrador');

-- Solo Administrador puede cambiar roles / datos de otros usuarios
drop policy if exists pol_perfiles_update on public.perfiles;
create policy pol_perfiles_update on public.perfiles
    for update to authenticated
    using  (public.get_my_rol() = 'Administrador')
    with check (public.get_my_rol() = 'Administrador');


-- =============================================================================
-- 6. RLS REFINADA — PAGOS
-- =============================================================================

-- ── pagos ───────────────────────────────────────────────────────────────────
drop policy if exists pol_pagos_select  on public.pagos;
drop policy if exists pol_pagos_insert  on public.pagos;
drop policy if exists pol_pagos_update  on public.pagos;

create policy pol_pagos_select on public.pagos
    for select to authenticated using (true);

create policy pol_pagos_insert on public.pagos
    for insert to authenticated
    with check (
        public.get_my_rol() in ('Administrador', 'Caja')
        and created_by = auth.uid()
    );

-- UPDATE solo para Administrador (anulación soft-delete)
create policy pol_pagos_update on public.pagos
    for update to authenticated
    using  (public.get_my_rol() = 'Administrador')
    with check (public.get_my_rol() = 'Administrador');

-- ── detalle_pagos ───────────────────────────────────────────────────────────
drop policy if exists pol_detalle_select on public.detalle_pagos;
drop policy if exists pol_detalle_insert on public.detalle_pagos;
drop policy if exists pol_detalle_update on public.detalle_pagos;

create policy pol_detalle_select on public.detalle_pagos
    for select to authenticated using (true);

create policy pol_detalle_insert on public.detalle_pagos
    for insert to authenticated
    with check (
        public.get_my_rol() in ('Administrador', 'Caja')
        and created_by = auth.uid()
    );

create policy pol_detalle_update on public.detalle_pagos
    for update to authenticated
    using  (public.get_my_rol() = 'Administrador')
    with check (public.get_my_rol() = 'Administrador');


-- =============================================================================
-- 7. RLS REFINADA — MONTOS POR COBRAR
-- =============================================================================
drop policy if exists pol_montos_select on public.montos_por_cobrar;
drop policy if exists pol_montos_insert on public.montos_por_cobrar;
drop policy if exists pol_montos_update on public.montos_por_cobrar;

create policy pol_montos_select on public.montos_por_cobrar
    for select to authenticated using (true);

-- Solo Administrador genera / cancela deudas
create policy pol_montos_insert on public.montos_por_cobrar
    for insert to authenticated
    with check (
        public.get_my_rol() = 'Administrador'
        and created_by = auth.uid()
    );

create policy pol_montos_update on public.montos_por_cobrar
    for update to authenticated
    using  (public.get_my_rol() = 'Administrador')
    with check (public.get_my_rol() = 'Administrador');


-- =============================================================================
-- 8. RLS REFINADA — GASTOS
-- =============================================================================
drop policy if exists pol_gastos_select on public.gastos;
drop policy if exists pol_gastos_insert on public.gastos;
drop policy if exists pol_gastos_update on public.gastos;

create policy pol_gastos_select on public.gastos
    for select to authenticated using (true);

create policy pol_gastos_insert on public.gastos
    for insert to authenticated
    with check (
        public.get_my_rol() in ('Administrador', 'Caja')
        and created_by = auth.uid()
    );

-- UPDATE para anular (soft-delete): solo Administrador
create policy pol_gastos_update on public.gastos
    for update to authenticated
    using  (public.get_my_rol() = 'Administrador')
    with check (public.get_my_rol() = 'Administrador');


-- =============================================================================
-- 9. RLS REFINADA — CONCEPTOS, MEDICIONES, ARTEFACTOS
-- =============================================================================

-- conceptos
drop policy if exists pol_conceptos_select on public.conceptos;
drop policy if exists pol_conceptos_insert on public.conceptos;
drop policy if exists pol_conceptos_update on public.conceptos;

create policy pol_conceptos_select on public.conceptos
    for select to authenticated using (true);
create policy pol_conceptos_insert on public.conceptos
    for insert to authenticated
    with check (public.get_my_rol() = 'Administrador' and created_by = auth.uid());
create policy pol_conceptos_update on public.conceptos
    for update to authenticated
    using (public.get_my_rol() = 'Administrador')
    with check (public.get_my_rol() = 'Administrador');

-- mediciones_luz
drop policy if exists pol_mediciones_select on public.mediciones_luz;
drop policy if exists pol_mediciones_insert on public.mediciones_luz;
drop policy if exists pol_mediciones_update on public.mediciones_luz;

create policy pol_mediciones_select on public.mediciones_luz
    for select to authenticated using (true);
create policy pol_mediciones_insert on public.mediciones_luz
    for insert to authenticated
    with check (
        public.get_my_rol() in ('Administrador', 'Caja')
        and created_by = auth.uid()
    );
create policy pol_mediciones_update on public.mediciones_luz
    for update to authenticated
    using (public.get_my_rol() = 'Administrador')
    with check (public.get_my_rol() = 'Administrador');

-- registro_artefactos
drop policy if exists pol_artefactos_select on public.registro_artefactos;
drop policy if exists pol_artefactos_insert on public.registro_artefactos;
drop policy if exists pol_artefactos_update on public.registro_artefactos;

create policy pol_artefactos_select on public.registro_artefactos
    for select to authenticated using (true);
create policy pol_artefactos_insert on public.registro_artefactos
    for insert to authenticated
    with check (
        public.get_my_rol() in ('Administrador', 'Caja')
        and created_by = auth.uid()
    );
create policy pol_artefactos_update on public.registro_artefactos
    for update to authenticated
    using (public.get_my_rol() = 'Administrador')
    with check (public.get_my_rol() = 'Administrador');


-- =============================================================================
-- 10. GRANT a las vistas financieras (revocar acceso anon)
--     Solo authenticated puede leer las vistas. anon ya no debe acceder.
-- =============================================================================
revoke select on public.vw_deuda_total_por_puesto from anon;
revoke select on public.vw_socios_morosos          from anon;
revoke select on public.vw_recaudacion_mensual     from anon;

-- authenticated ya tiene el grant de migración 00006; confirmamos.
grant select on public.vw_deuda_total_por_puesto to authenticated;
grant select on public.vw_socios_morosos          to authenticated;
grant select on public.vw_recaudacion_mensual     to authenticated;

-- Perfiles: acceso al rol de lectura de PostgREST
grant select, update on public.perfiles to authenticated;


-- =============================================================================
-- 11. INSTRUCCIONES POST-MIGRACIÓN
-- =============================================================================
-- Para crear el primer Administrador:
--
--   1. Crea el usuario en Supabase Dashboard → Authentication → Users → "Add user"
--      (email + contraseña). El trigger inserta automáticamente su perfil como 'Asistente'.
--
--   2. Promuévelo a Administrador en SQL Editor:
--
--      update public.perfiles
--      set rol = 'Administrador'
--      where email = 'tu@email.com';
--
--   3. Crea usuarios adicionales (Caja, Asistente) del mismo modo y ajusta su rol.
-- =============================================================================
