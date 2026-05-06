-- =============================================================================
-- Migración 00032 — Recaudación por Tarjeta (Saldo Semanal)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Lógica: socios que participan entregan dinero semanalmente como prepago;
-- el monto se abona directamente a saldo_a_favor sin generar deuda/recibo.
-- A fin de mes lo usan en el Wizard de Pagos.
--
-- Crea:
--   1. socios.usa_recaudacion_tarjeta boolean DEFAULT false
--   2. recaudacion_abonos             — log append-only de cada depósito
--   3. rpc_recaudacion_masiva         — procesa un lote JSON atómicamente
-- =============================================================================


-- =============================================================================
-- 1. Flag en socios
-- =============================================================================
alter table public.socios
    add column if not exists usa_recaudacion_tarjeta boolean not null default false;

comment on column public.socios.usa_recaudacion_tarjeta is
    'TRUE si el socio participa en la recaudación semanal por tarjeta (prepago).';


-- =============================================================================
-- 2. Tabla de log de abonos
--    Append-only: no se permite UPDATE ni DELETE (solo soft-delete si se anula).
--    El triple (deleted_at, anulado_por, motivo_anulacion) sigue el patrón del
--    proyecto (skill CLAUDE.md §4.2).
-- =============================================================================
create table if not exists public.recaudacion_abonos (
    id               bigserial   primary key,
    socio_id         bigint      not null
                                 references public.socios(id)
                                 on update cascade on delete restrict,
    monto            numeric(10,2) not null check (monto > 0),
    fecha            timestamptz not null default now(),

    created_at       timestamptz not null default now(),
    created_by       uuid        references auth.users(id) on delete set null,

    deleted_at       timestamptz,
    anulado_por      uuid        references auth.users(id) on delete set null,
    motivo_anulacion text,

    constraint chk_abonos_anulacion_consistente
        check (
            (deleted_at is null and anulado_por is null and motivo_anulacion is null)
            or
            (deleted_at is not null and anulado_por is not null and motivo_anulacion is not null)
        )
);

comment on table public.recaudacion_abonos is
    'Log de abonos semanales por tarjeta. Cada fila = un prepago inyectado al '
    'saldo_a_favor del socio. Append-only; las anulaciones usan soft-delete.';

create index if not exists idx_rec_abonos_socio_fecha
    on public.recaudacion_abonos (socio_id, fecha desc)
    where deleted_at is null;

-- RLS
alter table public.recaudacion_abonos enable row level security;

drop policy if exists pol_rec_abonos_select on public.recaudacion_abonos;
create policy pol_rec_abonos_select on public.recaudacion_abonos
    for select to authenticated using (true);

drop policy if exists pol_rec_abonos_insert on public.recaudacion_abonos;
create policy pol_rec_abonos_insert on public.recaudacion_abonos
    for insert to authenticated with check (created_by = auth.uid());

drop policy if exists pol_rec_abonos_update on public.recaudacion_abonos;
create policy pol_rec_abonos_update on public.recaudacion_abonos
    for update to authenticated using (true) with check (true);
-- Sin policy FOR DELETE → soft-delete forzado.


-- =============================================================================
-- 3. RPC atómico rpc_recaudacion_masiva
--    Recibe un array JSON de {socio_id, monto}, una fecha y el user_id.
--    Para cada entrada: inserta en recaudacion_abonos Y suma a saldo_a_favor.
--    Si alguna fila falla (socio inexistente, monto ≤ 0) el item se omite con
--    RAISE WARNING, sin revertir toda la transacción (skip-on-error).
--
--    Retorna: {insertados: N, omitidos: M, total_abonado: X}
-- =============================================================================
create or replace function public.rpc_recaudacion_masiva(
    p_abonos  jsonb,          -- [{socio_id, monto}, ...]
    p_fecha   timestamptz,    -- fecha de la recaudación (puede ser pasada)
    p_user_id uuid
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
    v_item        jsonb;
    v_socio_id    bigint;
    v_monto       numeric(10,2);
    v_insertados  integer := 0;
    v_omitidos    integer := 0;
    v_total       numeric(12,2) := 0;
    v_fecha_uso   timestamptz;
begin
    -- Validación de rol
    if public.get_my_rol() not in ('Administrador', 'Caja') then
        raise exception 'Acceso denegado: solo Administrador o Caja puede registrar recaudación.';
    end if;

    if p_abonos is null or jsonb_array_length(p_abonos) = 0 then
        raise exception 'El listado de abonos no puede estar vacío.';
    end if;

    v_fecha_uso := coalesce(p_fecha, now());

    -- Iterar sobre cada abono del lote
    for v_item in select * from jsonb_array_elements(p_abonos)
    loop
        begin
            v_socio_id := (v_item->>'socio_id')::bigint;
            v_monto    := (v_item->>'monto')::numeric(10,2);

            -- Validaciones por item
            if v_monto is null or v_monto <= 0 then
                raise exception 'monto inválido';
            end if;

            if not exists (
                select 1 from public.socios
                where id = v_socio_id and deleted_at is null
            ) then
                raise exception 'socio % no existe', v_socio_id;
            end if;

            -- a) Insertar en log
            insert into public.recaudacion_abonos (socio_id, monto, fecha, created_by)
            values (v_socio_id, v_monto, v_fecha_uso, p_user_id);

            -- b) Acumular saldo_a_favor
            update public.socios
            set saldo_a_favor = saldo_a_favor + v_monto
            where id = v_socio_id;

            v_insertados := v_insertados + 1;
            v_total      := v_total + v_monto;

        exception when others then
            raise warning 'rpc_recaudacion_masiva: omitiendo item % — %', v_item, sqlerrm;
            v_omitidos := v_omitidos + 1;
        end;
    end loop;

    if v_insertados = 0 then
        raise exception 'Ningún abono pudo procesarse. Revisa los datos enviados.';
    end if;

    return jsonb_build_object(
        'ok',            true,
        'insertados',    v_insertados,
        'omitidos',      v_omitidos,
        'total_abonado', v_total,
        'fecha',         v_fecha_uso
    );
end;
$$;

comment on function public.rpc_recaudacion_masiva(jsonb, timestamptz, uuid) is
    'Procesa un lote de abonos semanales por tarjeta: inserta en recaudacion_abonos '
    'y acumula en socios.saldo_a_favor. Cada item fallido se omite con WARNING '
    'sin revertir el resto del lote.';

grant execute on function public.rpc_recaudacion_masiva(jsonb, timestamptz, uuid) to authenticated;
