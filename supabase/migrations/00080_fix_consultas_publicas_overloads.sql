-- =============================================================================
-- Migración 00080 — Fix de rpc_public_cargar_deudas (Sobrecarga de 3 argumentos)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- En la migración 00079 creamos la versión de 1 argumento para soportar almacenes,
-- pero el frontend llama explícitamente a la de 3 argumentos introducida en 00017.
-- Esta migración:
-- 1. Elimina la versión de 1 argumento para evitar ambigüedades.
-- 2. Actualiza la versión de 3 argumentos para que incluya los almacenes.
-- =============================================================================

-- Eliminar la versión de 1 argumento para evitar colisiones
drop function if exists public.rpc_public_cargar_deudas(bigint);

-- Actualizar la versión de 3 argumentos
create or replace function public.rpc_public_cargar_deudas(
    p_puesto_id bigint,
    p_persona_id bigint default null,
    p_tipo text default null
)
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
    v_socio_id bigint;
    v_inquilino_id bigint;
    v_result json;
begin
    -- 1. Intentar buscar si el puesto pertenece a un socio (vía historial_titularidad)
    select socio_id into v_socio_id
    from public.historial_titularidad
    where puesto_id = p_puesto_id and fecha_fin is null
    limit 1;

    -- Si no se encontró por titularidad principal, intentar buscar si es un almacén
    if v_socio_id is null then
        select socio_id into v_socio_id
        from public.ocupaciones_almacenes
        where puesto_id = p_puesto_id and fecha_fin is null
        limit 1;
    end if;
    
    -- También confiamos en el p_persona_id pasado por el frontend si es socio
    if v_socio_id is null and p_tipo = 'socio' and p_persona_id is not null then
        v_socio_id := p_persona_id;
    end if;

    -- 2. Si no pertenece a un socio, quizás es de un inquilino (vía historial_arriendos)
    if v_socio_id is null then
        select inquilino_id into v_inquilino_id
        from public.historial_arriendos
        where puesto_id = p_puesto_id and fecha_fin is null
        limit 1;
        
        if v_inquilino_id is null and p_tipo = 'inquilino' and p_persona_id is not null then
            v_inquilino_id := p_persona_id;
        end if;
    end if;

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
        where m.estado <> 'Cancelado'
          and m.deleted_at is null
          and (
             -- Si el pagador es un socio, mostramos TODO lo que le corresponde:
             (v_socio_id is not null and (
                m.socio_id = v_socio_id or 
                m.puesto_id in (select puesto_id from public.historial_titularidad where socio_id = v_socio_id and fecha_fin is null) or
                m.puesto_id in (select puesto_id from public.ocupaciones_almacenes where socio_id = v_socio_id and fecha_fin is null)
             ))
             or
             -- Si el pagador es un inquilino, mostramos los puestos que arrienda:
             (v_inquilino_id is not null and (
                m.puesto_id in (select puesto_id from public.historial_arriendos where inquilino_id = v_inquilino_id and fecha_fin is null)
             ))
             or
             -- Si no tiene a nadie activo, al menos mostramos las deudas directas del puesto consultado (fallback seguro):
             (v_socio_id is null and v_inquilino_id is null and m.puesto_id = p_puesto_id)
          )
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

comment on function public.rpc_public_cargar_deudas(bigint, bigint, text) is
    'Portal público: devuelve saldos pendientes unificados de un puesto. '
    'Se extendió para agrupar automáticamente las deudas de los almacenes '
    'asociados al mismo titular (socio) que el puesto consultado.';

grant execute on function public.rpc_public_cargar_deudas(bigint, bigint, text) to anon;
grant execute on function public.rpc_public_cargar_deudas(bigint, bigint, text) to authenticated;
