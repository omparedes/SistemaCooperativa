-- =============================================================================
-- Migración 00018 — RPCs Atómicos (ACID) para operaciones críticas del ERP
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Mueve la lógica multi-tabla del frontend a stored procedures para garantizar
-- que cualquier fallo de red o error parcial haga rollback de la transacción
-- completa. Todas las funciones son SECURITY DEFINER con validación de rol.
--
-- Funciones:
--   1. rpc_procesar_pago          — INSERT pagos + detalle_pagos + UPDATE montos
--   2. rpc_eliminar_socio         — soft-delete socios + cierre titularidad
--   3. rpc_eliminar_inquilino     — soft-delete inquilinos + cierre arriendo
--   4. rpc_gestionar_titularidad  — UPDATE + INSERT historial atómico
--   5. rpc_public_buscar_pagador  — reemplaza la versión parcial por coincidencia
--                                   EXACTA de DNI / código (anti-scraping)
-- =============================================================================


-- =============================================================================
-- 1. rpc_procesar_pago
--    Reemplaza los 3 roundtrips secuenciales del frontend.
--    Si falla el INSERT de cualquier detalle_pago, toda la transacción revierte.
-- =============================================================================
create or replace function public.rpc_procesar_pago(
    p_puesto_id      bigint,
    p_socio_id       bigint,     -- NULL si pagador es inquilino
    p_inquilino_id   bigint,     -- NULL si pagador es socio
    p_monto_total    numeric,
    p_metodo_pago    text,
    p_comprobante    text,       -- puede ser NULL o vacío
    p_observacion    text,       -- puede ser NULL o vacío
    p_usuario_id     uuid,
    p_distribucion   jsonb       -- [{monto_id, monto_aplicado, cubierto_completo}]
)
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
    v_pago_id        bigint;
    v_codigo         text;
    v_n              integer;
    v_idx            integer;
    v_linea          jsonb;
    v_monto_id       bigint;
    v_monto_aplicado numeric;
    v_cubierto       boolean;
    v_ids_pagar      bigint[] := '{}';
begin
    -- Validación de rol
    if public.get_my_rol() not in ('Administrador', 'Caja') then
        raise exception 'Acceso denegado: solo Administrador o Caja puede procesar pagos.';
    end if;

    -- Validación XOR pagador
    if (p_socio_id is null) = (p_inquilino_id is null) then
        raise exception 'Debe especificar exactamente uno de: p_socio_id, p_inquilino_id.';
    end if;

    if p_monto_total <= 0 then
        raise exception 'El monto total debe ser mayor a cero.';
    end if;

    if p_metodo_pago not in ('Efectivo', 'Transferencia') then
        raise exception 'Método de pago inválido: %.', p_metodo_pago;
    end if;

    -- 1. Insertar pago (código_transaccion se genera por DEFAULT de la tabla)
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

    -- 2. Insertar detalle_pagos (iteración sobre el array JSONB)
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

    return json_build_object('pago_id', v_pago_id, 'codigo_transaccion', v_codigo);
end;
$$;

comment on function public.rpc_procesar_pago(bigint,bigint,bigint,numeric,text,text,text,uuid,jsonb) is
    'RPC atómico: inserta pagos + detalle_pagos + actualiza montos_por_cobrar en una '
    'sola transacción. Reemplaza los 3 roundtrips secuenciales del frontend. '
    'SECURITY DEFINER: los UPDATE sobre montos_por_cobrar son intencionales — la '
    'policy pol_montos_update (solo Administrador) no aplica dentro de esta función. '
    'El control de acceso lo hace la validación de rol al inicio (Admin|Caja).';

grant execute on function public.rpc_procesar_pago(bigint,bigint,bigint,numeric,text,text,text,uuid,jsonb)
    to authenticated;


-- =============================================================================
-- 2. rpc_eliminar_socio
--    Soft-delete + cierre de titularidad vigente en una transacción.
--    Sin este RPC, un fallo de red entre los dos UPDATEs dejaba el socio
--    eliminado pero con la titularidad abierta (inconsistencia).
-- =============================================================================
create or replace function public.rpc_eliminar_socio(
    p_socio_id   bigint,
    p_motivo     text,
    p_usuario_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
    if public.get_my_rol() <> 'Administrador' then
        raise exception 'Acceso denegado: solo Administrador puede eliminar socios.';
    end if;

    -- Soft-delete del socio
    update public.socios
    set deleted_at       = now(),
        anulado_por      = p_usuario_id,
        motivo_anulacion = p_motivo
    where id = p_socio_id
      and deleted_at is null;

    if not found then
        raise exception 'Socio % no encontrado o ya eliminado.', p_socio_id;
    end if;

    -- Cierre de titularidad vigente (si existe — puede no tener puesto asignado)
    update public.historial_titularidad
    set fecha_fin     = current_date,
        motivo_cambio = p_motivo
    where socio_id = p_socio_id
      and fecha_fin is null;
end;
$$;

comment on function public.rpc_eliminar_socio(bigint, text, uuid) is
    'RPC atómico: soft-delete de socio + cierre de titularidad vigente.';

grant execute on function public.rpc_eliminar_socio(bigint, text, uuid) to authenticated;


-- =============================================================================
-- 3. rpc_eliminar_inquilino
--    Análogo a rpc_eliminar_socio pero para inquilinos e historial_arriendos.
-- =============================================================================
create or replace function public.rpc_eliminar_inquilino(
    p_inquilino_id bigint,
    p_motivo       text,
    p_usuario_id   uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
    if public.get_my_rol() <> 'Administrador' then
        raise exception 'Acceso denegado: solo Administrador puede eliminar inquilinos.';
    end if;

    -- Soft-delete del inquilino
    update public.inquilinos
    set deleted_at       = now(),
        anulado_por      = p_usuario_id,
        motivo_anulacion = p_motivo
    where id = p_inquilino_id
      and deleted_at is null;

    if not found then
        raise exception 'Inquilino % no encontrado o ya eliminado.', p_inquilino_id;
    end if;

    -- Cierre de arriendo vigente (si existe)
    update public.historial_arriendos
    set fecha_fin      = current_date,
        motivo_termino = p_motivo
    where inquilino_id = p_inquilino_id
      and fecha_fin is null;
end;
$$;

comment on function public.rpc_eliminar_inquilino(bigint, text, uuid) is
    'RPC atómico: soft-delete de inquilino + cierre de arriendo vigente.';

grant execute on function public.rpc_eliminar_inquilino(bigint, text, uuid) to authenticated;


-- =============================================================================
-- 4. rpc_gestionar_titularidad
--    UPDATE (cierre) + INSERT (apertura) en una transacción.
--    Sin este RPC, un fallo de red entre ambas operaciones podía dejar
--    al puesto sin titular o con dos titulares simultáneos.
-- =============================================================================
create or replace function public.rpc_gestionar_titularidad(
    p_socio_id        bigint,
    p_nuevo_puesto_id bigint,   -- NULL si solo se cierra la titularidad actual
    p_viejo_puesto_id bigint,   -- NULL si el socio no tenía puesto previo
    p_usuario_id      uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
    v_hoy date := current_date;
begin
    if public.get_my_rol() <> 'Administrador' then
        raise exception 'Acceso denegado: solo Administrador puede gestionar titularidades.';
    end if;

    -- Cierra titularidad anterior si existía puesto previo
    if p_viejo_puesto_id is not null then
        update public.historial_titularidad
        set fecha_fin     = v_hoy,
            motivo_cambio = 'Cambio gestionado en edición'
        where socio_id = p_socio_id
          and fecha_fin is null;
    end if;

    -- Abre nueva titularidad si se asignó un puesto
    if p_nuevo_puesto_id is not null then
        insert into public.historial_titularidad (socio_id, puesto_id, fecha_inicio, created_by)
        values (p_socio_id, p_nuevo_puesto_id, v_hoy, p_usuario_id);
    end if;
end;
$$;

comment on function public.rpc_gestionar_titularidad(bigint, bigint, bigint, uuid) is
    'RPC atómico: cierre de titularidad anterior + apertura de la nueva en una transacción.';

grant execute on function public.rpc_gestionar_titularidad(bigint, bigint, bigint, uuid) to authenticated;


-- =============================================================================
-- 5. rpc_public_buscar_pagador (reemplaza la versión con ILIKE parcial)
--    Cambia a coincidencia EXACTA de DNI o código de puesto para prevenir
--    scraping masivo por fuerza bruta. Elimina búsqueda por nombre.
-- =============================================================================
create or replace function public.rpc_public_buscar_pagador(p_query text)
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
    v_termino text;
    v_result  json;
begin
    v_termino := upper(trim(p_query));
    if v_termino = '' then
        return '[]'::json;
    end if;
    if length(v_termino) > 100 then
        return '[]'::json;
    end if;

    with all_matches as (

        -- Socios: coincidencia EXACTA por DNI
        (select
            'socio'::text                     as tipo,
            s.id                              as persona_id,
            s.dni,
            s.apellidos || ', ' || s.nombres  as nombre_completo,
            p.id                              as puesto_id,
            p.codigo_puesto,
            1                                 as prioridad
        from public.socios s
        join public.historial_titularidad ht
             on ht.socio_id = s.id and ht.fecha_fin is null
        join public.puestos p
             on p.id = ht.puesto_id and p.deleted_at is null
        where s.deleted_at is null
          and upper(s.dni) = v_termino
        limit 1)

        union all

        -- Inquilinos: coincidencia EXACTA por DNI
        (select
            'inquilino'::text,
            i.id,
            i.dni,
            i.apellidos || ', ' || i.nombres,
            p.id,
            p.codigo_puesto,
            2
        from public.inquilinos i
        join public.historial_arriendos ha
             on ha.inquilino_id = i.id and ha.fecha_fin is null
        join public.puestos p
             on p.id = ha.puesto_id and p.deleted_at is null
        where i.deleted_at is null
          and upper(i.dni) = v_termino
        limit 1)

        union all

        -- Puestos: coincidencia EXACTA por código de puesto
        (select
            'socio'::text,
            s.id,
            s.dni,
            s.apellidos || ', ' || s.nombres,
            p.id,
            p.codigo_puesto,
            3
        from public.puestos p
        join public.historial_titularidad ht
             on ht.puesto_id = p.id and ht.fecha_fin is null
        join public.socios s
             on s.id = ht.socio_id and s.deleted_at is null
        where p.deleted_at is null
          and upper(p.codigo_puesto) = v_termino
        limit 1)

    ),

    dedupe as (
        select distinct on (puesto_id)
            tipo, persona_id, dni, nombre_completo, puesto_id, codigo_puesto
        from all_matches
        order by puesto_id, prioridad
    )

    select coalesce(
        json_agg(
            json_build_object(
                'tipo',            tipo,
                'persona_id',      persona_id,
                'dni',             dni,
                'nombre_completo', nombre_completo,
                'puesto_id',       puesto_id,
                'codigo_puesto',   codigo_puesto
            )
        ),
        '[]'::json
    )
    into v_result
    from (select * from dedupe limit 3) final_set;

    return v_result;
end;
$$;

comment on function public.rpc_public_buscar_pagador(text) is
    'Portal público (v2): coincidencia EXACTA por DNI o código de puesto. '
    'Reemplaza la búsqueda parcial ILIKE para prevenir scraping por fuerza bruta.';

-- Mantener acceso público (ya existían; los re-emitimos para ser explícitos)
grant execute on function public.rpc_public_buscar_pagador(text) to anon;
grant execute on function public.rpc_public_buscar_pagador(text) to authenticated;
