-- =============================================================================
-- Migración 00023 — Saldo a Favor de Socios e Inquilinos
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Agrega la columna saldo_a_favor a socios e inquilinos, y reemplaza
-- rpc_procesar_pago para que:
--   1. Acepte el parámetro p_saldo_utilizado (saldo previo aplicado al pago).
--   2. Calcule el excedente tras aplicar la distribución FIFO.
--   3. Actualice saldo_a_favor del pagador en la misma transacción atómica.
-- =============================================================================


-- -----------------------------------------------------------------------------
-- 1. Columna saldo_a_favor en socios e inquilinos
-- -----------------------------------------------------------------------------
alter table public.socios
    add column if not exists saldo_a_favor numeric(10,2) not null default 0.00;

alter table public.inquilinos
    add column if not exists saldo_a_favor numeric(10,2) not null default 0.00;

comment on column public.socios.saldo_a_favor is
    'Monto acumulado a favor del socio por pagos en exceso. '
    'Se debita al reutilizarse en pagos futuros vía rpc_procesar_pago.';

comment on column public.inquilinos.saldo_a_favor is
    'Monto acumulado a favor del inquilino por pagos en exceso. '
    'Se debita al reutilizarse en pagos futuros vía rpc_procesar_pago.';


-- -----------------------------------------------------------------------------
-- 2. Eliminar la función con la firma anterior (9 parámetros) para evitar
--    ambigüedad de overloads en PostgREST al agregar el nuevo parámetro.
-- -----------------------------------------------------------------------------
drop function if exists public.rpc_procesar_pago(
    bigint, bigint, bigint, numeric, text, text, text, uuid, jsonb
);


-- -----------------------------------------------------------------------------
-- 3. Nueva versión de rpc_procesar_pago (10 parámetros)
--    p_saldo_utilizado — saldo previo del pagador consumido en esta operación.
--    DEFAULT 0 garantiza compatibilidad hacia atrás si alguien no lo pasa.
-- -----------------------------------------------------------------------------
create or replace function public.rpc_procesar_pago(
    p_puesto_id       bigint,
    p_socio_id        bigint,     -- NULL si pagador es inquilino
    p_inquilino_id    bigint,     -- NULL si pagador es socio
    p_monto_total     numeric,    -- efectivo/transferencia recibido (puede ser 0 si usa saldo)
    p_metodo_pago     text,       -- 'Efectivo' | 'Transferencia'
    p_comprobante     text,       -- puede ser NULL o vacío
    p_observacion     text,       -- puede ser NULL o vacío
    p_usuario_id      uuid,
    p_distribucion    jsonb,      -- [{monto_id, monto_aplicado, cubierto_completo}]
    p_saldo_utilizado numeric default 0
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
    -- Validación de rol
    if public.get_my_rol() not in ('Administrador', 'Caja') then
        raise exception 'Acceso denegado: solo Administrador o Caja puede procesar pagos.';
    end if;

    -- Validación XOR pagador
    if (p_socio_id is null) = (p_inquilino_id is null) then
        raise exception 'Debe especificar exactamente uno de: p_socio_id, p_inquilino_id.';
    end if;

    -- Validación de monto disponible: efectivo + saldo a favor utilizado
    v_monto_disponible := p_monto_total + coalesce(p_saldo_utilizado, 0);
    if v_monto_disponible <= 0 then
        raise exception 'El monto disponible debe ser mayor a cero.';
    end if;

    if p_metodo_pago not in ('Efectivo', 'Transferencia') then
        raise exception 'Método de pago inválido: %.', p_metodo_pago;
    end if;

    -- 1. Insertar pago (código_transaccion se genera por DEFAULT de la tabla)
    --    monto_total registra el efectivo/transferencia recibido (sin incluir saldo previo)
    insert into public.pagos (
        puesto_id, socio_id, inquilino_id,
        monto_total, metodo_pago,
        comprobante, observacion,
        created_by
    )
    values (
        p_puesto_id,
        p_socio_id,
        p_inquilino_id,
        p_monto_total,
        p_metodo_pago,
        nullif(p_comprobante, ''),
        nullif(p_observacion, ''),
        p_usuario_id
    )
    returning id, codigo_transaccion into v_pago_id, v_codigo;

    -- 2. Insertar detalle_pagos e ir acumulando el total efectivamente aplicado
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

    -- 3. Marcar como Pagados los montos completamente cubiertos
    if array_length(v_ids_pagar, 1) is not null then
        update public.montos_por_cobrar
        set estado = 'Pagado'
        where id = any(v_ids_pagar);
    end if;

    -- 4. Calcular excedente y actualizar saldo_a_favor del pagador.
    --    Fórmula: saldo_delta = v_excedente - p_saldo_utilizado
    --             = (v_monto_disponible - v_total_aplicado) - p_saldo_utilizado
    --             = p_monto_total - v_total_aplicado   (simplificado)
    --    Ejemplos:
    --      • Pago en exceso 120 para deuda 100  → saldo_delta = +20
    --      • Saldo cubre deuda 100, efectivo 0  → saldo_delta = −100
    --      • Efectivo 60 + saldo 40 para 100    → saldo_delta = −40
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

comment on function public.rpc_procesar_pago(bigint,bigint,bigint,numeric,text,text,text,uuid,jsonb,numeric) is
    'RPC atómico v2: inserta pagos + detalle_pagos + actualiza montos_por_cobrar + '
    'ajusta saldo_a_favor del pagador en una sola transacción. '
    'p_monto_total = efectivo/transferencia recibido (puede ser 0 si el saldo cubre todo). '
    'p_saldo_utilizado = saldo previo del pagador consumido en esta operación. '
    'SECURITY DEFINER: control de acceso via validación de rol (Admin|Caja).';

grant execute on function public.rpc_procesar_pago(bigint,bigint,bigint,numeric,text,text,text,uuid,jsonb,numeric)
    to authenticated;
