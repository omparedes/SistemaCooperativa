-- =============================================================================
-- Migración 00001 — Módulo Gastos
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Crea:
--   * categorias_gasto (catálogo + seed)
--   * gastos (con soft delete y campos de auditoría de anulación)
--   * trigger updated_at
--   * RLS habilitado con políticas base (refinar cuando existan roles)
-- =============================================================================


-- -----------------------------------------------------------------------------
-- 1. Catálogo: categorias_gasto
-- -----------------------------------------------------------------------------
create table if not exists public.categorias_gasto (
    id           bigserial primary key,
    nombre       text        not null unique,
    activo       boolean     not null default true,
    created_at   timestamptz not null default now()
);

comment on table public.categorias_gasto is
    'Catálogo de categorías para clasificar los egresos operativos.';


-- -----------------------------------------------------------------------------
-- 2. Tabla principal: gastos
-- -----------------------------------------------------------------------------
create table if not exists public.gastos (
    id                  bigserial   primary key,
    categoria_gasto_id  bigint      not null
                                    references public.categorias_gasto(id)
                                    on delete restrict,
    fecha               date        not null,
    monto               numeric(12,2) not null check (monto > 0),
    descripcion         text,
    comprobante_ref     text,

    -- Auditoría básica
    created_at          timestamptz not null default now(),
    updated_at          timestamptz not null default now(),
    created_by          uuid        references auth.users(id) on delete set null,

    -- Soft delete / anulación (regla de dominio: NO borrar históricos)
    deleted_at          timestamptz,
    anulado_por         uuid        references auth.users(id) on delete set null,
    motivo_anulacion    text,

    constraint chk_anulacion_consistente
        check (
            (deleted_at is null and anulado_por is null and motivo_anulacion is null)
            or
            (deleted_at is not null and anulado_por is not null and motivo_anulacion is not null)
        )
);

comment on table public.gastos is
    'Egresos operativos y administrativos. Append-only: las eliminaciones se hacen vía deleted_at + anulado_por + motivo_anulacion.';
comment on column public.gastos.deleted_at is
    'Soft delete. NULL = vigente. Una vez seteado, el registro queda anulado y no debe modificarse.';


-- -----------------------------------------------------------------------------
-- 3. Índices
-- -----------------------------------------------------------------------------
create index if not exists idx_gastos_fecha
    on public.gastos (fecha desc)
    where deleted_at is null;

create index if not exists idx_gastos_categoria
    on public.gastos (categoria_gasto_id)
    where deleted_at is null;


-- -----------------------------------------------------------------------------
-- 4. Trigger: updated_at automático
-- -----------------------------------------------------------------------------
create or replace function public.tg_set_updated_at()
returns trigger
language plpgsql
as $$
begin
    new.updated_at := now();
    return new;
end;
$$;

drop trigger if exists trg_gastos_set_updated_at on public.gastos;
create trigger trg_gastos_set_updated_at
    before update on public.gastos
    for each row
    execute function public.tg_set_updated_at();


-- -----------------------------------------------------------------------------
-- 5. Row Level Security
--    NOTA: políticas iniciales — refinar cuando existan roles (admin/cajero/auditor).
--    DELETE NO se permite a nadie por política: la "eliminación" es UPDATE deleted_at.
-- -----------------------------------------------------------------------------
alter table public.categorias_gasto enable row level security;
alter table public.gastos           enable row level security;

-- Categorías: lectura para usuarios autenticados
drop policy if exists pol_categorias_gasto_select on public.categorias_gasto;
create policy pol_categorias_gasto_select
    on public.categorias_gasto
    for select
    to authenticated
    using (true);

-- Gastos: lectura para autenticados
drop policy if exists pol_gastos_select on public.gastos;
create policy pol_gastos_select
    on public.gastos
    for select
    to authenticated
    using (true);

-- Gastos: insert para autenticados (created_by = auth.uid())
drop policy if exists pol_gastos_insert on public.gastos;
create policy pol_gastos_insert
    on public.gastos
    for insert
    to authenticated
    with check (created_by = auth.uid());

-- Gastos: update para autenticados (incluye soft delete vía deleted_at)
drop policy if exists pol_gastos_update on public.gastos;
create policy pol_gastos_update
    on public.gastos
    for update
    to authenticated
    using (true)
    with check (true);

-- Gastos: DELETE bloqueado a nivel de política (no existe ninguna policy FOR DELETE).


-- -----------------------------------------------------------------------------
-- 6. Seed: categorías base (las mismas que ya usa el frontend)
-- -----------------------------------------------------------------------------
insert into public.categorias_gasto (nombre) values
    ('Operativo'),
    ('Mantenimiento'),
    ('Servicios')
on conflict (nombre) do nothing;
