-- =============================================================================
-- Migración 00031 — Fecha de Pago Manual + Editar Pago
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- 1. rpc_procesar_pago (v3): agrega p_fecha_pago timestamptz DEFAULT now()
--    para que los abonos manuales puedan registrar una fecha retroactiva.
-- 2. rpc_cc_editar_pago: UPDATE de comprobante y fecha_pago en un pago vigente.
-- =============================================================================


-- =============================================================================
-- 1. Actualizar rpc_procesar_pago → añadir p_fecha_pago (param 11)
--    DROP de la firma anterior (10 parámetros) + CREATE nueva (11 parámetros).
-- =============================================================================
drop function if exists public.rpc_procesar_pago(
    bigint, bigint, bigint, numeric, text, text, text, uuid, jsonb, numeric
);

create or replace function public.rpc_procesar_pago(
    p_puesto_id       bigint,
    p_socio_id        bigint,
    p_inquilino_id    bigint,
    p_monto_total     numeric,
    p_metodo_pago     text,
    p_comprobante     text,
    p_observacion     text,
    p_usuario_id      uuid,
    p_distribucion    jsonb,
    p_saldo_utilizado numeric      default 0,
    p_fecha_pago      timestamptz  default now()
)
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
    v_pago_id          bigint;
    v_codigo           text;
    v_n                integer;
    v_idx              integer;
    v_linea            jsonb;
    v_monto_id         bigint;
    v_monto_aplicado   numeric;
    v_cubierto         boolean;
    v_ids_pagar        bigint[] := '{}';
    v_monto_disponible numeric;
    v_total_aplicado   numeric := 0;
    v_excedente        numeric;
begin
    if public.get_my_rol() not in ('Administrador', 'Caja') then
        raise exception 'Acceso denegado: solo Administrador o Caja puede procesar pagos.';
    end if;

    if (p_socio_id is null) = (p_inquilino_id is null) then
        raise exception 'Debe especificar exactamente uno de: p_socio_id, p_inquilino_id.';
    end if;

    v_monto_disponible := p_monto_total + coalesce(p_saldo_utilizado, 0);
    if v_monto_disponible <= 0 then
        raise exception 'El monto disponible debe ser mayor a cero.';
    end if;

    if p_metodo_pago not in ('Efectivo', 'Transferencia') then
        raise exception 'Método de pago inválido: %.', p_metodo_pago;
    end if;

    insert into public.pagos (
        puesto_id, socio_id, inquilino_id,
        monto_total, metodo_pago,
        comprobante, observacion,
        created_by, fecha_pago
    )
    values (
        p_puesto_id,
        p_socio_id,
        p_inquilino_id,
        p_monto_total,
        p_metodo_pago,
        nullif(p_comprobante, ''),
        nullif(p_observacion, ''),
        p_usuario_id,
        coalesce(p_fecha_pago, now())
    )
    returning id, codigo_transaccion into v_pago_id, v_codigo;

    v_n := coalesce(jsonb_array_length(p_distribucion), 0);

    for v_idx in 0 .. v_n - 1
    loop
        v_linea          := p_distribucion->v_idx;
        v_monto_id       := (v_linea->>'monto_id')::bigint;
        v_monto_aplicado := (v_linea->>'monto_aplicado')::numeric;
        v_cubierto       := coalesce((v_linea->>'cubierto_completo')::boolean, false);

        if v_monto_aplicado <= 0 then
            continue;
        end if;

        insert into public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by)
        values (v_pago_id, v_monto_id, v_monto_aplicado, p_usuario_id);

        v_total_aplicado := v_total_aplicado + v_monto_aplicado;

        if v_cubierto then
            v_ids_pagar := v_ids_pagar || v_monto_id;
        end if;
    end loop;

    if array_length(v_ids_pagar, 1) is not null then
        update public.montos_por_cobrar
        set estado = 'Pagado'
        where id = any(v_ids_pagar);
    end if;

    v_excedente := v_monto_disponible - v_total_aplicado;

    if p_socio_id is not null then
        update public.socios
        set saldo_a_favor = saldo_a_favor + v_excedente - coalesce(p_saldo_utilizado, 0)
        where id = p_socio_id;
    elsif p_inquilino_id is not null then
        update public.inquilinos
        set saldo_a_favor = saldo_a_favor + v_excedente - coalesce(p_saldo_utilizado, 0)
        where id = p_inquilino_id;
    end if;

    return json_build_object('pago_id', v_pago_id, 'codigo_transaccion', v_codigo);
end;
$$;

comment on function public.rpc_procesar_pago(bigint,bigint,bigint,numeric,text,text,text,uuid,jsonb,numeric,timestamptz) is
    'RPC atómico v3: igual a v2 pero acepta p_fecha_pago para registrar abonos con fecha retroactiva.';

grant execute on function public.rpc_procesar_pago(bigint,bigint,bigint,numeric,text,text,text,uuid,jsonb,numeric,timestamptz)
    to authenticated;


-- =============================================================================
-- 2. rpc_cc_editar_pago
--    UPDATE de comprobante y/o fecha_pago en un pago vigente (no anulado).
--    Solo Administrador o Caja. Registra en auditoría si la tabla existe.
-- =============================================================================
create or replace function public.rpc_cc_editar_pago(
    p_pago_id     bigint,
    p_comprobante text,        -- nuevo comprobante (null = no cambiar)
    p_fecha_pago  timestamptz  -- nueva fecha     (null = no cambiar)
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
    v_pago             record;
    v_tabla_auditoria  boolean := false;
begin
    if public.get_my_rol() not in ('Administrador', 'Caja') then
        raise exception 'Acceso denegado: solo Administrador o Caja puede editar pagos.';
    end if;

    select * into v_pago from public.pagos where id = p_pago_id;
    if not found then
        raise exception 'Pago % no encontrado.', p_pago_id;
    end if;
    if v_pago.deleted_at is not null then
        raise exception 'El pago % está anulado y no puede editarse.', p_pago_id;
    end if;

    update public.pagos
    set
        comprobante = case
            when p_comprobante is not null then nullif(trim(p_comprobante), '')
            else comprobante
        end,
        fecha_pago  = coalesce(p_fecha_pago, fecha_pago),
        updated_at  = now()
    where id = p_pago_id;

    -- Auditoría (graceful)
    select exists (
        select 1 from information_schema.tables
        where table_schema = 'public' and table_name = 'auditoria'
    ) into v_tabla_auditoria;

    if v_tabla_auditoria then
        begin
            execute
                'insert into public.auditoria
                   (tabla_afectada, registro_id, accion, valor_anterior, valor_nuevo, usuario_id)
                 values ($1,$2,$3,$4,$5,auth.uid())'
            using
                'pagos', p_pago_id::text, 'Actualizar',
                jsonb_build_object('comprobante', v_pago.comprobante, 'fecha_pago', v_pago.fecha_pago),
                jsonb_build_object('comprobante', p_comprobante, 'fecha_pago', p_fecha_pago);
        exception when others then
            raise warning 'rpc_cc_editar_pago: no se pudo insertar en auditoría: %', sqlerrm;
        end;
    end if;

    return jsonb_build_object(
        'ok',      true,
        'pago_id', p_pago_id,
        'mensaje', 'Pago actualizado correctamente.'
    );
end;
$$;

comment on function public.rpc_cc_editar_pago(bigint, text, timestamptz) is
    'Edita el comprobante y/o fecha_pago de un pago vigente. Solo Admin/Caja.';

grant execute on function public.rpc_cc_editar_pago(bigint, text, timestamptz) to authenticated;
