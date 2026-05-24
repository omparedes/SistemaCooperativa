-- =============================================================================
-- Migración 00041 — Control de Caja Física
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Crea:
--   * caja_aperturas   — saldo inicial con el que arranca el día
--   * caja_ajustes     — faltantes/sobrantes para justificar cuadres físicos
--
-- RLS:
--   SELECT → cualquier authenticated (cajero necesita leer para el arqueo)
--   INSERT/UPDATE → solo rol Administrador
--   DELETE → bloqueado estructuralmente (sin policy FOR DELETE)
-- =============================================================================


-- =============================================================================
-- 1. caja_aperturas — saldo inicial del día
-- =============================================================================
create table if not exists public.caja_aperturas (
    id            bigserial     primary key,
    fecha         date          not null unique,  -- una apertura por día
    monto_inicial numeric(12,2) not null check (monto_inicial >= 0),
    user_id       uuid          references auth.users(id) on delete set null,
    created_at    timestamptz   not null default now(),
    updated_at    timestamptz   not null default now()
);

comment on table  public.caja_aperturas        is 'Saldo inicial con el que arranca la caja cada día. Una fila por fecha.';
comment on column public.caja_aperturas.fecha  is 'Fecha del día. UNIQUE: solo puede haber una apertura por día.';
comment on column public.caja_aperturas.monto_inicial is 'Dinero físico que había en la gaveta al abrir el día.';

drop trigger if exists trg_caja_aperturas_updated_at on public.caja_aperturas;
create trigger trg_caja_aperturas_updated_at
    before update on public.caja_aperturas
    for each row execute function public.tg_set_updated_at();

alter table public.caja_aperturas enable row level security;

-- SELECT: todos los usuarios autenticados (el arqueo lo necesita)
drop policy if exists pol_caja_aperturas_select on public.caja_aperturas;
create policy pol_caja_aperturas_select on public.caja_aperturas
    for select to authenticated using (true);

-- INSERT: solo Administrador
drop policy if exists pol_caja_aperturas_insert on public.caja_aperturas;
create policy pol_caja_aperturas_insert on public.caja_aperturas
    for insert to authenticated
    with check (public.get_my_rol() = 'Administrador');

-- UPDATE: solo Administrador
drop policy if exists pol_caja_aperturas_update on public.caja_aperturas;
create policy pol_caja_aperturas_update on public.caja_aperturas
    for update to authenticated
    using  (public.get_my_rol() = 'Administrador')
    with check (public.get_my_rol() = 'Administrador');


-- =============================================================================
-- 2. caja_ajustes — faltantes y sobrantes del cierre físico
-- =============================================================================
create table if not exists public.caja_ajustes (
    id          bigserial     primary key,
    fecha       date          not null,
    tipo        text          not null check (tipo in ('FALTANTE', 'SOBRANTE')),
    monto       numeric(12,2) not null check (monto > 0),
    descripcion text,
    user_id     uuid          references auth.users(id) on delete set null,
    created_at  timestamptz   not null default now(),
    updated_at  timestamptz   not null default now()
);

comment on table  public.caja_ajustes            is 'Ajustes de cuadre físico: faltantes (billetes que no están) y sobrantes (billetes de más).';
comment on column public.caja_ajustes.tipo       is 'FALTANTE = dinero que debería estar y no está. SOBRANTE = dinero de más en la gaveta.';
comment on column public.caja_ajustes.monto      is 'Siempre positivo. El tipo determina si resta o suma al efectivo físico.';

create index if not exists idx_caja_ajustes_fecha on public.caja_ajustes (fecha desc);

drop trigger if exists trg_caja_ajustes_updated_at on public.caja_ajustes;
create trigger trg_caja_ajustes_updated_at
    before update on public.caja_ajustes
    for each row execute function public.tg_set_updated_at();

alter table public.caja_ajustes enable row level security;

-- SELECT: todos los usuarios autenticados
drop policy if exists pol_caja_ajustes_select on public.caja_ajustes;
create policy pol_caja_ajustes_select on public.caja_ajustes
    for select to authenticated using (true);

-- INSERT: solo Administrador
drop policy if exists pol_caja_ajustes_insert on public.caja_ajustes;
create policy pol_caja_ajustes_insert on public.caja_ajustes
    for insert to authenticated
    with check (public.get_my_rol() = 'Administrador');

-- UPDATE: solo Administrador
drop policy if exists pol_caja_ajustes_update on public.caja_ajustes;
create policy pol_caja_ajustes_update on public.caja_ajustes
    for update to authenticated
    using  (public.get_my_rol() = 'Administrador')
    with check (public.get_my_rol() = 'Administrador');
