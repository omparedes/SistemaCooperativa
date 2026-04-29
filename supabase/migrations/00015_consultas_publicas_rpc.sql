-- =============================================================================
-- Migración 00015 — RPCs Públicos de Consultas (Portal sin autenticación)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Crea tres funciones SECURITY DEFINER que exponen datos de solo lectura al
-- rol `anon`, sin abrir las políticas RLS de las tablas base.
--
-- Las funciones NUNCA modifican datos; solo hacen SELECT y devuelven JSON.
-- El search_path fijo previene ataques de manipulación de rutas de búsqueda.
--
-- Funciones:
--   * rpc_public_buscar_pagador(p_query text)         → BusquedaResultado[]
--   * rpc_public_cargar_deudas(p_puesto_id bigint)    → DeudaItem[]
--   * rpc_public_obtener_historial(p_id bigint, p_tipo text) → PagoHistorial[]
-- =============================================================================


-- =============================================================================
-- 1. rpc_public_buscar_pagador
--    Busca socios, inquilinos y puestos que coincidan con el término.
--    Deduplica por puesto_id. Devuelve hasta 10 resultados.
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

        -- Socios: coincidencia por DNI, nombre o apellidos
        (select
            'socio'::text                                as tipo,
            s.id                                         as persona_id,
            s.dni,
            s.apellidos || ', ' || s.nombres             as nombre_completo,
            p.id                                         as puesto_id,
            p.codigo_puesto,
            1                                            as prioridad
        from public.socios s
        join public.historial_titularidad ht
             on ht.socio_id = s.id and ht.fecha_fin is null
        join public.puestos p
             on p.id = ht.puesto_id and p.deleted_at is null
        where s.deleted_at is null
          and (   upper(s.dni)       like '%' || v_termino || '%'
               or upper(s.nombres)   like '%' || v_termino || '%'
               or upper(s.apellidos) like '%' || v_termino || '%')
        limit 8)

        union all

        -- Inquilinos: coincidencia por DNI, nombre o apellidos
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
          and (   upper(i.dni)       like '%' || v_termino || '%'
               or upper(i.nombres)   like '%' || v_termino || '%'
               or upper(i.apellidos) like '%' || v_termino || '%')
        limit 8)

        union all

        -- Puestos: coincidencia por código (devuelve el titular socio vigente)
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
          and upper(p.codigo_puesto) like '%' || v_termino || '%'
        limit 5)

    ),

    -- Deduplicar por puesto_id; cuando hay duplicado preferir prioridad menor
    dedupe as (
        select distinct on (puesto_id)
            tipo, persona_id, dni, nombre_completo, puesto_id, codigo_puesto
        from all_matches
        order by puesto_id, prioridad
    )

    select coalesce(
        json_agg(
            json_build_object(
                'tipo',           tipo,
                'persona_id',     persona_id,
                'dni',            dni,
                'nombre_completo', nombre_completo,
                'puesto_id',      puesto_id,
                'codigo_puesto',  codigo_puesto
            )
        ),
        '[]'::json
    )
    into v_result
    from (select * from dedupe limit 10) final_set;

    return v_result;
end;
$$;

comment on function public.rpc_public_buscar_pagador(text) is
    'Portal público: busca pagadores (socios/inquilinos/puestos) por DNI, nombre o '
    'código. SECURITY DEFINER — bypasea RLS de solo lectura para uso anon. '
    'Devuelve hasta 10 resultados deduplicados por puesto_id.';

grant execute on function public.rpc_public_buscar_pagador(text) to anon;
grant execute on function public.rpc_public_buscar_pagador(text) to authenticated;


-- =============================================================================
-- 2. rpc_public_cargar_deudas
--    Devuelve los saldos pendientes de un puesto, con el cálculo ya_pagado
--    basado en detalle_pagos activos (no anulados).
-- =============================================================================
create or replace function public.rpc_public_cargar_deudas(p_puesto_id bigint)
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
    v_result json;
begin
    with deudas_calculadas as (
        select
            m.id                                            as monto_id,
            coalesce(c.nombre, 'Sin concepto')              as concepto,
            m.periodo_anio,
            m.periodo_mes,
            m.monto                                         as monto_original,
            m.fecha_generacion,
            coalesce(
                sum(dp.monto_aplicado) filter (where dp.deleted_at is null),
                0
            )                                               as ya_pagado
        from public.montos_por_cobrar m
        join public.conceptos c on c.id = m.concepto_id
        left join public.detalle_pagos dp on dp.monto_id = m.id
        where m.puesto_id = p_puesto_id
          and m.estado    <> 'Cancelado'
          and m.deleted_at is null
        group by m.id, c.nombre, m.periodo_anio, m.periodo_mes, m.monto, m.fecha_generacion
        order by m.periodo_anio, m.periodo_mes
    )

    select coalesce(
        json_agg(
            json_build_object(
                'monto_id',        monto_id,
                'concepto',        concepto,
                'periodo_anio',    periodo_anio,
                'periodo_mes',     periodo_mes,
                'monto_original',  monto_original,
                'ya_pagado',       ya_pagado,
                'saldo_pendiente', round(monto_original - ya_pagado, 2),
                'fecha_generacion', fecha_generacion
            )
        ) filter (where round(monto_original - ya_pagado, 2) > 0),
        '[]'::json
    )
    into v_result
    from deudas_calculadas;

    return v_result;
end;
$$;

comment on function public.rpc_public_cargar_deudas(bigint) is
    'Portal público: devuelve los montos pendientes de un puesto con saldo_pendiente > 0. '
    'SECURITY DEFINER — bypasea RLS de solo lectura para uso anon.';

grant execute on function public.rpc_public_cargar_deudas(bigint) to anon;
grant execute on function public.rpc_public_cargar_deudas(bigint) to authenticated;


-- =============================================================================
-- 3. rpc_public_obtener_historial
--    Historial de pagos de un socio o inquilino, incluyendo los anulados
--    (para que se muestren tachados en la UI). Para pagos vigentes solo
--    incluye detalle activos; para anulados incluye todos los detalles
--    (para mostrar qué conceptos contenía).
-- =============================================================================
create or replace function public.rpc_public_obtener_historial(p_id bigint, p_tipo text)
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
    v_result json;
begin
    if p_tipo not in ('socio', 'inquilino') then
        raise exception 'Tipo inválido: %. Valores aceptados: socio, inquilino.', p_tipo;
    end if;

    select coalesce(
        json_agg(pago_obj order by fecha_pago desc),
        '[]'::json
    )
    into v_result
    from (
        select
            p.fecha_pago,
            json_build_object(
                'id',               p.id,
                'codigo_transaccion', p.codigo_transaccion,
                'fecha_pago',       p.fecha_pago,
                'monto_total',      p.monto_total,
                'metodo_pago',      p.metodo_pago,
                'comprobante',      p.comprobante,
                'codigo_puesto',    coalesce(pu.codigo_puesto, '—'),
                'anulado',          (p.deleted_at is not null),
                'motivo_anulacion', p.motivo_anulacion,
                'deleted_at',       p.deleted_at,
                'detalle', (
                    select coalesce(
                        json_agg(
                            json_build_object(
                                'monto_aplicado', dp.monto_aplicado,
                                'concepto',       coalesce(c.nombre, 'Concepto eliminado'),
                                'periodo_anio',   coalesce(m.periodo_anio, 0),
                                'periodo_mes',    coalesce(m.periodo_mes,  0),
                                'monto_original', coalesce(m.monto, dp.monto_aplicado)
                            )
                        ),
                        '[]'::json
                    )
                    from public.detalle_pagos dp
                    left join public.montos_por_cobrar m on m.id = dp.monto_id
                    left join public.conceptos c         on c.id = m.concepto_id
                    where dp.pago_id = p.id
                      -- Para pagos anulados: mostrar todos los detalles (incluye soft-deleted)
                      -- Para pagos vigentes: solo detalles activos
                      and (p.deleted_at is not null or dp.deleted_at is null)
                )
            ) as pago_obj
        from public.pagos p
        left join public.puestos pu on pu.id = p.puesto_id
        where (
            case
                when p_tipo = 'socio'     then p.socio_id     = p_id
                when p_tipo = 'inquilino' then p.inquilino_id = p_id
            end
        )
        order by p.fecha_pago desc
        limit 200
    ) pagos_con_detalle;

    return v_result;
end;
$$;

comment on function public.rpc_public_obtener_historial(bigint, text) is
    'Portal público: historial de pagos de un socio o inquilino, incluyendo anulados. '
    'SECURITY DEFINER — bypasea RLS de solo lectura para uso anon. '
    'p_tipo acepta: socio | inquilino.';

grant execute on function public.rpc_public_obtener_historial(bigint, text) to anon;
grant execute on function public.rpc_public_obtener_historial(bigint, text) to authenticated;
