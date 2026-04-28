-- =============================================================================
-- Migración 00014 — Ingresos Internos (sin recibo)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Crea:
--   * conceptos.grupo (text)  — categoriza conceptos en SOCIOS / INQUILINOS / OTROS
--   * ingresos_internos       — tabla para cobros espontáneos sin recibo formal
--   * registrar_ingreso_interno(…) — RPC que valida e inserta
--
-- Decisión de diseño:
--   Los ingresos internos (SS.HH, Parqueo, Donaciones, etc.) NO son pagos de
--   deuda, por lo que NO se insertan en pagos (que exige socio_id XOR inquilino_id)
--   ni en montos_por_cobrar (que exige puesto_id XOR socio_id).
--   Una tabla propia preserva la integridad del modelo de pagos y facilita
--   extender el tipo de ingreso sin violar constraints existentes.
-- =============================================================================


-- =============================================================================
-- 1. Añadir columna grupo a conceptos
-- =============================================================================
alter table public.conceptos
  add column if not exists grupo text
  check (grupo in ('SOCIOS', 'INQUILINOS', 'OTROS'));

comment on column public.conceptos.grupo is
  'Categoría del concepto: SOCIOS (cobros mensuales de socios), '
  'INQUILINOS (arriendos y tickets), OTROS (ingresos espontáneos sin deuda).';


-- =============================================================================
-- 2. Clasificar conceptos existentes
-- =============================================================================
update public.conceptos set grupo = 'SOCIOS'
where nombre in (
  'Luz', 'Agua', 'Gastos administrativos', 'Previsión social',
  'Mantenimiento', 'Multa', 'Aporte extraordinario', 'Deuda anterior', 'Ajuste manual'
);

update public.conceptos set grupo = 'OTROS'
where nombre in ('Otros Ingresos');


-- =============================================================================
-- 3. Insertar conceptos INQUILINOS (del Excel de Abril)
-- =============================================================================
insert into public.conceptos (nombre, tipo, aplica_descuento, activo, grupo, descripcion)
values
  ('Alquiler', 'Variable', false, true, 'INQUILINOS', 'Cobro de alquiler de puesto o espacio comercial.'),
  ('TICKET',   'Variable', false, true, 'INQUILINOS', 'Venta de ticket de ingreso al mercado o evento.'),
  ('Espacio',  'Variable', false, true, 'INQUILINOS', 'Arriendo de espacio comercial temporal.'),
  ('Parqueo',  'Variable', false, true, 'INQUILINOS', 'Cobro por uso de estacionamiento.')
on conflict (nombre) do update
  set grupo = excluded.grupo;


-- =============================================================================
-- 4. Insertar conceptos OTROS (del Excel de Abril)
-- =============================================================================
insert into public.conceptos (nombre, tipo, aplica_descuento, activo, grupo, descripcion)
values
  ('SS.HH 1er PISO', 'Variable', false, true, 'OTROS', 'Cobro por uso de servicios higiénicos primer piso.'),
  ('Deposito',        'Variable', false, true, 'OTROS', 'Depósito o garantía de local o espacio.'),
  ('Donacion',        'Variable', false, true, 'OTROS', 'Donación recibida por la cooperativa.'),
  ('Otros',           'Variable', false, true, 'OTROS', 'Ingresos varios no categorizados.')
on conflict (nombre) do update
  set grupo = excluded.grupo;


-- =============================================================================
-- 5. Tabla ingresos_internos
-- =============================================================================
create table if not exists public.ingresos_internos (
    id              bigserial    primary key,

    concepto_id     bigint       not null
                                 references public.conceptos(id)
                                 on update cascade on delete restrict,

    monto           numeric(12,2) not null check (monto > 0),
    metodo_pago     text          not null
                                 check (metodo_pago in ('Efectivo','Transferencia')),
    observacion     text,

    fecha_ingreso   timestamptz   not null default now(),

    created_at      timestamptz   not null default now(),
    updated_at      timestamptz   not null default now(),
    created_by      uuid          references auth.users(id) on delete set null,

    deleted_at      timestamptz,
    anulado_por     uuid          references auth.users(id) on delete set null,
    motivo_anulacion text,

    constraint chk_ingresos_internos_anulacion_consistente
        check (
            (deleted_at is null and anulado_por is null and motivo_anulacion is null)
            or
            (deleted_at is not null and anulado_por is not null and motivo_anulacion is not null)
        )
);

comment on table public.ingresos_internos is
    'Cobros espontáneos sin recibo formal (SS.HH, Parqueo, Donaciones, etc.). '
    'No generan deuda ni son pagos de montos_por_cobrar; se suman al total del arqueo diario.';

create index if not exists idx_ingresos_internos_fecha
    on public.ingresos_internos (fecha_ingreso desc)
    where deleted_at is null;

create index if not exists idx_ingresos_internos_concepto
    on public.ingresos_internos (concepto_id)
    where deleted_at is null;

drop trigger if exists trg_ingresos_internos_set_updated_at on public.ingresos_internos;
create trigger trg_ingresos_internos_set_updated_at
    before update on public.ingresos_internos
    for each row execute function public.tg_set_updated_at();


-- =============================================================================
-- 6. RLS en ingresos_internos
-- =============================================================================
alter table public.ingresos_internos enable row level security;

drop policy if exists pol_ingresos_internos_select on public.ingresos_internos;
create policy pol_ingresos_internos_select on public.ingresos_internos
    for select to authenticated using (true);

drop policy if exists pol_ingresos_internos_insert on public.ingresos_internos;
create policy pol_ingresos_internos_insert on public.ingresos_internos
    for insert to authenticated with check (created_by = auth.uid());

drop policy if exists pol_ingresos_internos_update on public.ingresos_internos;
create policy pol_ingresos_internos_update on public.ingresos_internos
    for update to authenticated using (true) with check (true);

-- DELETE: ninguna policy → PostgreSQL deniega → soft delete forzado.


-- =============================================================================
-- 7. RPC registrar_ingreso_interno
-- =============================================================================
create or replace function public.registrar_ingreso_interno(
    p_concepto_id  bigint,
    p_monto        numeric,
    p_metodo_pago  text,
    p_usuario_id   uuid,
    p_observacion  text default null
)
returns bigint
language plpgsql
as $$
declare
    v_id bigint;
begin
    -- Validaciones
    if p_monto is null or p_monto <= 0 then
        raise exception 'El monto debe ser mayor a cero.';
    end if;

    if p_metodo_pago not in ('Efectivo', 'Transferencia') then
        raise exception 'Método de pago inválido: %.', p_metodo_pago;
    end if;

    if not exists (
        select 1 from public.conceptos
        where id = p_concepto_id
          and activo = true
          and deleted_at is null
    ) then
        raise exception 'Concepto % no encontrado o inactivo.', p_concepto_id;
    end if;

    insert into public.ingresos_internos
        (concepto_id, monto, metodo_pago, observacion, created_by)
    values
        (p_concepto_id, p_monto, p_metodo_pago, p_observacion, p_usuario_id)
    returning id into v_id;

    return v_id;
end;
$$;

comment on function public.registrar_ingreso_interno(bigint, numeric, text, uuid, text) is
    'Registra un ingreso interno (sin recibo). Valida concepto activo, monto > 0 y '
    'método de pago. Inserta en ingresos_internos. No genera montos_por_cobrar ni pagos.';

grant execute on function public.registrar_ingreso_interno(bigint, numeric, text, uuid, text)
    to authenticated;
