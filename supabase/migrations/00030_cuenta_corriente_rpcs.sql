-- =============================================================================
-- Migración 00030 — RPCs de Cuenta Corriente
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Funciones:
--   1. rpc_cc_listar_personas      — Listado unificado socios + inquilinos
--   2. rpc_cc_detalle_persona      — Dashboard financiero de una persona
--   3. rpc_anular_cargo            — Soft-delete de un monto_por_cobrar sin pagos
--   4. anular_pago (ACTUALIZADO)   — Ahora revierte saldo_a_favor
-- =============================================================================


-- =============================================================================
-- 1. rpc_cc_listar_personas
--    Devuelve socios e inquilinos con su deuda_pendiente y saldo_a_favor.
--    Deuda del socio = deudas de su puesto + deudas personales (multas).
--    Deuda del inquilino = deudas del puesto que ocupa.
-- =============================================================================
create or replace function public.rpc_cc_listar_personas()
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
  result json;
begin
  if public.get_my_rol() not in ('Administrador', 'Caja') then
    raise exception 'Acceso denegado.';
  end if;

  select coalesce(json_agg(t order by t.tipo, t.nombre), '[]'::json)
  into result
  from (

    -- ── SOCIOS ────────────────────────────────────────────────────────────────
    select
      'socio'::text                   as tipo,
      s.id,
      s.apellidos                     as nombre,
      s.dni,
      s.estado,
      s.habilitado,
      s.saldo_a_favor,
      p.codigo_puesto,
      p.id                            as puesto_id,
      coalesce(
        (
          select sum(mc.monto)
          from   public.montos_por_cobrar mc
          where  mc.deleted_at is null
            and  mc.estado = 'Pendiente'
            and  (mc.puesto_id = p.id or mc.socio_id = s.id)
        ), 0
      )                               as deuda_pendiente
    from public.socios s
    left join public.historial_titularidad ht
           on ht.socio_id = s.id and ht.fecha_fin is null
    left join public.puestos p on p.id = ht.puesto_id
    where s.deleted_at is null

    union all

    -- ── INQUILINOS ────────────────────────────────────────────────────────────
    select
      'inquilino'::text               as tipo,
      i.id,
      i.apellidos                     as nombre,
      i.dni,
      'Activo'::text                  as estado,
      null::boolean                   as habilitado,
      i.saldo_a_favor,
      p.codigo_puesto,
      p.id                            as puesto_id,
      coalesce(
        (
          select sum(mc.monto)
          from   public.montos_por_cobrar mc
          where  mc.deleted_at is null
            and  mc.estado = 'Pendiente'
            and  mc.puesto_id = p.id
        ), 0
      )                               as deuda_pendiente
    from public.inquilinos i
    left join public.historial_arriendos ha
           on ha.inquilino_id = i.id and ha.fecha_fin is null
    left join public.puestos p on p.id = ha.puesto_id
    where i.deleted_at is null

  ) t;

  return result;
end;
$$;

comment on function public.rpc_cc_listar_personas() is
  'Cuenta Corriente: listado unificado de socios e inquilinos con deuda_pendiente y saldo_a_favor.';

grant execute on function public.rpc_cc_listar_personas() to authenticated;


-- =============================================================================
-- 2. rpc_cc_detalle_persona
--    Dashboard financiero completo de una persona (socio o inquilino).
--    Retorna: info persona, deudas pendientes (con ya_pagado), historial pagos.
-- =============================================================================
create or replace function public.rpc_cc_detalle_persona(
  p_tipo text,    -- 'socio' | 'inquilino'
  p_id   bigint
)
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
  v_puesto_id  bigint;
  v_persona    json;
  v_deudas     json;
  v_pagos      json;
begin
  if public.get_my_rol() not in ('Administrador', 'Caja') then
    raise exception 'Acceso denegado.';
  end if;

  if p_tipo not in ('socio', 'inquilino') then
    raise exception 'Tipo inválido: %. Usar socio o inquilino.', p_tipo;
  end if;

  -- ── Persona + puesto ──────────────────────────────────────────────────────
  if p_tipo = 'socio' then
    select
      row_to_json(t) into v_persona
    from (
      select
        'socio'    as tipo,
        s.id,
        s.apellidos as nombre,
        s.dni,
        s.estado,
        s.habilitado,
        s.saldo_a_favor,
        p.codigo_puesto,
        p.id       as puesto_id
      from public.socios s
      left join public.historial_titularidad ht
             on ht.socio_id = s.id and ht.fecha_fin is null
      left join public.puestos p on p.id = ht.puesto_id
      where s.id = p_id and s.deleted_at is null
    ) t;

    v_puesto_id := (v_persona->>'puesto_id')::bigint;

    -- Deudas: tanto las del puesto como las personales del socio
    select coalesce(json_agg(d order by d.periodo_anio, d.periodo_mes), '[]'::json)
    into v_deudas
    from (
      select
        mc.id,
        coalesce(c.nombre, 'Sin concepto')   as concepto,
        mc.periodo_anio,
        mc.periodo_mes,
        mc.monto,
        mc.estado,
        mc.fecha_generacion,
        mc.observacion,
        coalesce(
          (
            select sum(dp.monto_aplicado)
            from   public.detalle_pagos dp
            join   public.pagos pg on pg.id = dp.pago_id
            where  dp.monto_id    = mc.id
              and  dp.deleted_at  is null
              and  pg.deleted_at  is null
          ), 0
        )                                    as ya_pagado
      from public.montos_por_cobrar mc
      join public.conceptos c on c.id = mc.concepto_id
      where mc.deleted_at is null
        and mc.estado     != 'Cancelado'
        and (mc.puesto_id = v_puesto_id or mc.socio_id = p_id)
    ) d;

  else
    -- inquilino
    select
      row_to_json(t) into v_persona
    from (
      select
        'inquilino' as tipo,
        i.id,
        i.apellidos  as nombre,
        i.dni,
        'Activo'     as estado,
        null         as habilitado,
        i.saldo_a_favor,
        p.codigo_puesto,
        p.id         as puesto_id
      from public.inquilinos i
      left join public.historial_arriendos ha
             on ha.inquilino_id = i.id and ha.fecha_fin is null
      left join public.puestos p on p.id = ha.puesto_id
      where i.id = p_id and i.deleted_at is null
    ) t;

    v_puesto_id := (v_persona->>'puesto_id')::bigint;

    select coalesce(json_agg(d order by d.periodo_anio, d.periodo_mes), '[]'::json)
    into v_deudas
    from (
      select
        mc.id,
        coalesce(c.nombre, 'Sin concepto') as concepto,
        mc.periodo_anio,
        mc.periodo_mes,
        mc.monto,
        mc.estado,
        mc.fecha_generacion,
        mc.observacion,
        coalesce(
          (
            select sum(dp.monto_aplicado)
            from   public.detalle_pagos dp
            join   public.pagos pg on pg.id = dp.pago_id
            where  dp.monto_id   = mc.id
              and  dp.deleted_at is null
              and  pg.deleted_at is null
          ), 0
        )                                  as ya_pagado
      from public.montos_por_cobrar mc
      join public.conceptos c on c.id = mc.concepto_id
      where mc.deleted_at is null
        and mc.estado     != 'Cancelado'
        and mc.puesto_id  = v_puesto_id
    ) d;
  end if;

  -- ── Historial de pagos ────────────────────────────────────────────────────
  declare
    v_col text := case p_tipo when 'socio' then 'socio_id' else 'inquilino_id' end;
  begin
    execute format(
      $sql$
      select coalesce(json_agg(pg order by pg.fecha_pago desc), '[]'::json)
      from (
        select
          p.id,
          p.codigo_transaccion,
          p.fecha_pago,
          p.monto_total,
          p.metodo_pago,
          p.comprobante,
          p.deleted_at is not null          as anulado,
          p.motivo_anulacion,
          coalesce(
            (
              select json_agg(
                json_build_object(
                  'concepto',       coalesce(c2.nombre, '?'),
                  'monto_aplicado', dp2.monto_aplicado
                )
              )
              from   public.detalle_pagos dp2
              join   public.montos_por_cobrar mc2 on mc2.id = dp2.monto_id
              join   public.conceptos c2 on c2.id = mc2.concepto_id
              where  dp2.pago_id    = p.id
                and  dp2.deleted_at is null
            ), '[]'::json
          )                                 as detalle
        from public.pagos p
        where p.%I = $1
      ) pg
      $sql$,
      v_col
    )
    into v_pagos
    using p_id;
  end;

  return json_build_object(
    'persona', v_persona,
    'deudas',  v_deudas,
    'pagos',   v_pagos
  );
end;
$$;

comment on function public.rpc_cc_detalle_persona(text, bigint) is
  'Cuenta Corriente: dashboard financiero de una persona (deudas + pagos).';

grant execute on function public.rpc_cc_detalle_persona(text, bigint) to authenticated;


-- =============================================================================
-- 3. rpc_anular_cargo
--    Soft-delete de un monto_por_cobrar.
--    Solo permitido si NO tiene detalle_pagos activos.
-- =============================================================================
create or replace function public.rpc_anular_cargo(
  p_monto_id   bigint,
  p_motivo     text,
  p_usuario_id uuid
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_monto    record;
  v_pagado   numeric(12,2);
begin
  if public.get_my_rol() <> 'Administrador' then
    raise exception 'Solo el Administrador puede anular cargos.';
  end if;

  if p_motivo is null or trim(p_motivo) = '' then
    raise exception 'El motivo de anulación no puede estar vacío.';
  end if;

  select * into v_monto
  from public.montos_por_cobrar
  where id = p_monto_id;

  if not found then
    raise exception 'Cargo % no encontrado.', p_monto_id;
  end if;
  if v_monto.deleted_at is not null then
    raise exception 'El cargo % ya fue anulado.', p_monto_id;
  end if;
  if v_monto.estado = 'Cancelado' then
    raise exception 'El cargo % ya está cancelado.', p_monto_id;
  end if;

  -- Verificar que no tenga pagos activos
  select coalesce(sum(dp.monto_aplicado), 0)
  into v_pagado
  from public.detalle_pagos dp
  join public.pagos pg on pg.id = dp.pago_id
  where dp.monto_id    = p_monto_id
    and dp.deleted_at  is null
    and pg.deleted_at  is null;

  if v_pagado > 0 then
    raise exception
      'No se puede anular: el cargo tiene S/%.2f ya aplicado. '
      'Anula primero los pagos asociados.', v_pagado;
  end if;

  update public.montos_por_cobrar
  set
    deleted_at       = now(),
    anulado_por      = p_usuario_id,
    motivo_anulacion = p_motivo,
    estado           = 'Cancelado'
  where id = p_monto_id;

  return jsonb_build_object(
    'ok',       true,
    'monto_id', p_monto_id,
    'mensaje',  'Cargo anulado correctamente.'
  );
end;
$$;

comment on function public.rpc_anular_cargo(bigint, text, uuid) is
  'Anula (soft-delete) un monto_por_cobrar solo si no tiene pagos activos. Solo Administrador.';

grant execute on function public.rpc_anular_cargo(bigint, text, uuid) to authenticated;


-- =============================================================================
-- 4. anular_pago — ACTUALIZADO para revertir saldo_a_favor
--    Extiende la versión de 00013 con reversión del saldo_a_favor.
--    saldo_delta = SUM(detalle_pagos.monto_aplicado) − pagos.monto_total
--    La reversión es: saldo_a_favor += pagos.monto_total − SUM(monto_aplicado)
--                   = saldo_a_favor −= saldo_delta
-- =============================================================================
create or replace function public.anular_pago(
  p_pago_id    bigint,
  p_motivo     text,
  p_usuario_id uuid
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_pago             record;
  v_detalle          record;
  v_ya_pagado        numeric(12,2);
  v_nuevo_estado     text;
  v_sum_aplicado     numeric(12,2) := 0;
  v_tabla_auditoria  boolean := false;
begin

  if p_motivo is null or trim(p_motivo) = '' then
    raise exception 'El motivo de anulación no puede estar vacío.';
  end if;

  select * into v_pago from public.pagos where id = p_pago_id;
  if not found then
    raise exception 'Pago % no encontrado.', p_pago_id;
  end if;
  if v_pago.deleted_at is not null then
    raise exception 'El pago % ya está anulado.', p_pago_id;
  end if;

  -- ── 1. Soft-delete del pago ───────────────────────────────────────────────
  update public.pagos
  set
    deleted_at       = now(),
    anulado_por      = p_usuario_id,
    motivo_anulacion = p_motivo
  where id = p_pago_id;

  -- ── 2. Soft-delete de detalles + restauración de estados de montos ─────────
  for v_detalle in
    select id, monto_id, monto_aplicado
    from   public.detalle_pagos
    where  pago_id    = p_pago_id
      and  deleted_at is null
  loop
    update public.detalle_pagos
    set
      deleted_at       = now(),
      anulado_por      = p_usuario_id,
      motivo_anulacion = p_motivo
    where id = v_detalle.id;

    v_sum_aplicado := v_sum_aplicado + v_detalle.monto_aplicado;

    select coalesce(sum(dp.monto_aplicado), 0)
    into   v_ya_pagado
    from   public.detalle_pagos dp
    where  dp.monto_id   = v_detalle.monto_id
      and  dp.deleted_at is null;

    select case when v_ya_pagado >= m.monto then 'Pagado' else 'Pendiente' end
    into   v_nuevo_estado
    from   public.montos_por_cobrar m
    where  m.id = v_detalle.monto_id;

    update public.montos_por_cobrar
    set    estado = v_nuevo_estado
    where  id         = v_detalle.monto_id
      and  estado    != 'Cancelado'
      and  deleted_at is null;
  end loop;

  -- ── 3. Revertir saldo_a_favor ─────────────────────────────────────────────
  -- saldo_delta_original = monto_total − v_sum_aplicado
  -- Para revertir: saldo_a_favor -= saldo_delta_original
  --              = saldo_a_favor += v_sum_aplicado - monto_total
  if v_pago.socio_id is not null then
    update public.socios
    set saldo_a_favor = saldo_a_favor + v_sum_aplicado - v_pago.monto_total
    where id = v_pago.socio_id;
  elsif v_pago.inquilino_id is not null then
    update public.inquilinos
    set saldo_a_favor = saldo_a_favor + v_sum_aplicado - v_pago.monto_total
    where id = v_pago.inquilino_id;
  end if;

  -- ── 4. Auditoría ──────────────────────────────────────────────────────────
  select exists (
    select 1 from information_schema.tables
    where table_schema = 'public' and table_name = 'auditoria'
  ) into v_tabla_auditoria;

  if v_tabla_auditoria then
    begin
      execute
        'insert into public.auditoria
           (tabla_afectada, registro_id, accion, valor_anterior, valor_nuevo, usuario_id)
         values ($1, $2, $3, $4, $5, $6)'
      using
        'pagos', p_pago_id::text, 'Anular',
        '{"deleted_at":null,"motivo_anulacion":null}'::jsonb,
        jsonb_build_object(
          'deleted_at',       now(),
          'motivo_anulacion', p_motivo,
          'anulado_por',      p_usuario_id::text,
          'saldo_revertido',  v_sum_aplicado - v_pago.monto_total
        ),
        p_usuario_id;
    exception when others then
      raise warning 'anular_pago: no se pudo insertar en auditoría: %', sqlerrm;
    end;
  end if;

  return jsonb_build_object(
    'ok',              true,
    'pago_id',         p_pago_id,
    'saldo_revertido', v_sum_aplicado - v_pago.monto_total,
    'mensaje',         'Pago anulado correctamente. Saldo a favor actualizado.'
  );
end;
$$;

comment on function public.anular_pago(bigint, text, uuid) is
  'Anula un pago (v2): soft-delete pagos + detalle_pagos, restaura estados de montos '
  'y revierte el delta de saldo_a_favor generado por ese pago. Registra en auditoría.';

grant execute on function public.anular_pago(bigint, text, uuid) to authenticated;
