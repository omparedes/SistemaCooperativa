-- =============================================================================
-- Migración 00021 — Módulo de Movimientos Bancarios
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Crea:
--   * bancos_cuentas         — catálogo de cuentas bancarias de la cooperativa
--   * movimientos_bancarios  — registro append-only de movimientos por cuenta
--   * tg_actualizar_saldo    — trigger SECURITY DEFINER que mantiene saldo_actual
--   * RLS en ambas tablas
-- =============================================================================


-- =============================================================================
-- 1. bancos_cuentas
-- =============================================================================
create table if not exists public.bancos_cuentas (
    id              bigserial       primary key,
    nombre_banco    text            not null,
    numero_cuenta   text            not null unique,
    moneda          text            not null default 'PEN'
                                    check (moneda in ('PEN', 'USD')),
    saldo_actual    numeric(14,2)   not null default 0,
    activo          boolean         not null default true,
    created_at      timestamptz     not null default now(),
    created_by      uuid            references auth.users(id) on delete set null
);

comment on table public.bancos_cuentas is
    'Catálogo de cuentas bancarias de la cooperativa. '
    'saldo_actual se mantiene automáticamente via trigger tg_actualizar_saldo.';


-- =============================================================================
-- 2. movimientos_bancarios
-- =============================================================================
create table if not exists public.movimientos_bancarios (
    id                  bigserial       primary key,

    cuenta_id           bigint          not null
                                        references public.bancos_cuentas(id)
                                        on update cascade on delete restrict,

    fecha_operacion     date            not null,
    tipo                text            not null
                                        check (tipo in ('Ingreso', 'Egreso')),
    monto               numeric(14,2)   not null check (monto > 0),
    motivo_detalle      text,
    nro_operacion       text,

    created_at          timestamptz     not null default now(),
    created_by          uuid            references auth.users(id) on delete set null,

    -- Soft delete (regla §4.2 del dominio: no borrar movimientos bancarios)
    deleted_at          timestamptz,
    anulado_por         uuid            references auth.users(id) on delete set null,
    motivo_anulacion    text,

    constraint chk_movimientos_anulacion_consistente
        check (
            (deleted_at is null and anulado_por is null and motivo_anulacion is null)
            or
            (deleted_at is not null and anulado_por is not null and motivo_anulacion is not null)
        )
);

comment on table public.movimientos_bancarios is
    'Movimientos bancarios (ingresos y egresos) por cuenta. '
    'Inmutables: solo se anulan con soft delete. El trigger tg_actualizar_saldo '
    'ajusta saldo_actual en bancos_cuentas tras cada INSERT y anulación.';

create index if not exists idx_movimientos_cuenta_fecha
    on public.movimientos_bancarios (cuenta_id, fecha_operacion desc)
    where deleted_at is null;

create index if not exists idx_movimientos_fecha
    on public.movimientos_bancarios (fecha_operacion desc)
    where deleted_at is null;


-- =============================================================================
-- 3. Trigger: actualizar saldo_actual de la cuenta tras cada movimiento
--    SECURITY DEFINER → bypasea RLS para escribir en bancos_cuentas.
--    Cubre dos casos:
--      a) INSERT  → aplica el movimiento al saldo.
--      b) UPDATE que cambia deleted_at de NULL a valor → revierte el movimiento.
-- =============================================================================
create or replace function public.tg_actualizar_saldo_banco()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
    if TG_OP = 'INSERT' and NEW.deleted_at is null then
        if NEW.tipo = 'Ingreso' then
            update public.bancos_cuentas
            set saldo_actual = saldo_actual + NEW.monto
            where id = NEW.cuenta_id;
        else
            update public.bancos_cuentas
            set saldo_actual = saldo_actual - NEW.monto
            where id = NEW.cuenta_id;
        end if;

    elsif TG_OP = 'UPDATE'
          and OLD.deleted_at is null
          and NEW.deleted_at is not null then
        -- Anulación: revertir el efecto del movimiento sobre el saldo
        if NEW.tipo = 'Ingreso' then
            update public.bancos_cuentas
            set saldo_actual = saldo_actual - NEW.monto
            where id = NEW.cuenta_id;
        else
            update public.bancos_cuentas
            set saldo_actual = saldo_actual + NEW.monto
            where id = NEW.cuenta_id;
        end if;
    end if;

    return NEW;
end;
$$;

comment on function public.tg_actualizar_saldo_banco() is
    'Trigger AFTER INSERT OR UPDATE. Aplica o revierte el movimiento en '
    'bancos_cuentas.saldo_actual. SECURITY DEFINER para bypassear RLS.';

drop trigger if exists trg_actualizar_saldo_banco on public.movimientos_bancarios;
create trigger trg_actualizar_saldo_banco
    after insert or update on public.movimientos_bancarios
    for each row execute function public.tg_actualizar_saldo_banco();


-- =============================================================================
-- 4. RLS
-- =============================================================================
alter table public.bancos_cuentas      enable row level security;
alter table public.movimientos_bancarios enable row level security;

-- ── bancos_cuentas ────────────────────────────────────────────────────────────
-- SELECT: cualquier usuario autenticado ve las cuentas activas.
-- INSERT/UPDATE: bloqueado para clientes directos; solo el trigger escribe saldo.
drop policy if exists pol_bancos_cuentas_select on public.bancos_cuentas;
create policy pol_bancos_cuentas_select on public.bancos_cuentas
    for select to authenticated using (activo = true);

-- ── movimientos_bancarios ─────────────────────────────────────────────────────
drop policy if exists pol_movimientos_select on public.movimientos_bancarios;
create policy pol_movimientos_select on public.movimientos_bancarios
    for select to authenticated using (deleted_at is null);

-- Administrador puede ver también los anulados (auditoría)
drop policy if exists pol_movimientos_select_admin on public.movimientos_bancarios;
create policy pol_movimientos_select_admin on public.movimientos_bancarios
    for select to authenticated
    using (public.get_my_rol() = 'Administrador');

drop policy if exists pol_movimientos_insert on public.movimientos_bancarios;
create policy pol_movimientos_insert on public.movimientos_bancarios
    for insert to authenticated
    with check (
        public.get_my_rol() in ('Administrador', 'Caja')
        and created_by = auth.uid()
    );

-- UPDATE solo para anulación (soft delete); solo Administrador
drop policy if exists pol_movimientos_update on public.movimientos_bancarios;
create policy pol_movimientos_update on public.movimientos_bancarios
    for update to authenticated
    using  (public.get_my_rol() = 'Administrador')
    with check (public.get_my_rol() = 'Administrador');

-- DELETE: ninguna policy → PostgreSQL deniega → soft delete forzado.


-- =============================================================================
-- 5. Seed: 2 cuentas bancarias de ejemplo
-- =============================================================================
insert into public.bancos_cuentas (nombre_banco, numero_cuenta, moneda, saldo_actual)
values
    ('BCP — Banco de Crédito del Perú', '194-12345678-0-12', 'PEN', 0),
    ('Interbank',                        '200-3084522920',    'PEN', 0)
on conflict (numero_cuenta) do nothing;
