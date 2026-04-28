-- =============================================================================
-- Migración 00010 — Tabla de Configuraciones del Sistema
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Almacena tarifas y montos fijos editables por el Administrador.
-- Los RPCs de facturación leen estos valores en lugar de constantes hardcoded.
--
-- Estructura mínima (clave PK, valor, descripcion) conforme a lo solicitado.
-- Se agregan updated_at/updated_by para auditoría básica y trigger automático.
-- =============================================================================

create table public.configuraciones (
    clave       text primary key,
    valor       numeric(12,4) not null check (valor > 0),
    descripcion text not null default '',
    updated_at  timestamptz not null default now(),
    updated_by  uuid references auth.users(id) on delete set null
);

comment on table public.configuraciones is
    'Parámetros del sistema editables por el Administrador: tarifas de luz, agua y cargos fijos mensuales.';

-- ── Datos iniciales ───────────────────────────────────────────────────────────
insert into public.configuraciones (clave, valor, descripcion) values
    ('PRECIO_KWH_SOCIO',        0.7500, 'Precio por kWh para puestos con titular socio (S/)'),
    ('PRECIO_KWH_INQUILINO',    0.7700, 'Precio por kWh para puestos con inquilino activo (S/)'),
    ('PRECIO_M3_AGUA',         12.7500, 'Precio por m³ de agua (S/)'),
    ('MONTO_MANTENIMIENTO',    10.0000, 'Cargo mensual fijo por mantenimiento de áreas comunes (S/ por puesto)'),
    ('MONTO_GASTOS_ADMIN',      8.0000, 'Cargo mensual por gastos administrativos (S/ por puesto)'),
    ('MONTO_PREVISION_SOCIAL',  5.0000, 'Cargo mensual por previsión social (S/ por puesto)');

-- ── RLS ──────────────────────────────────────────────────────────────────────
alter table public.configuraciones enable row level security;

-- Lectura: cualquier usuario autenticado
create policy "configuraciones_select"
    on public.configuraciones for select
    to authenticated
    using (true);

-- Escritura: solo Administrador
create policy "configuraciones_update"
    on public.configuraciones for update
    to authenticated
    using  (public.get_my_rol() = 'Administrador')
    with check (public.get_my_rol() = 'Administrador');

-- ── Trigger: sella updated_at / updated_by en cada UPDATE ────────────────────
create or replace function public.tg_configuraciones_stamp()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
    new.updated_at := now();
    new.updated_by := auth.uid();
    return new;
end;
$$;

comment on function public.tg_configuraciones_stamp is
    'Actualiza updated_at y updated_by automáticamente antes de cada UPDATE en configuraciones.';

create trigger tg_configuraciones_before_update
    before update on public.configuraciones
    for each row execute function public.tg_configuraciones_stamp();

-- ── Permisos ──────────────────────────────────────────────────────────────────
grant select, update on public.configuraciones to authenticated;
