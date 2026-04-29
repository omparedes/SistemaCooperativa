-- =============================================================================
-- Migración 00017 — Fix Cargos Extraordinarios y Consultas Públicas
-- =============================================================================

-- 1. Fix: generar_cargo_segmentado (quitar filtro deleted_at de historial_arriendos)
create or replace function public.generar_cargo_segmentado(
    p_concepto_id               bigint,
    p_monto                     numeric,
    p_segmento                  text,       -- 'SOCIOS' | 'INQUILINOS' | 'TODOS' | 'ESPECIFICO'
    p_anio                      smallint,
    p_mes                       smallint,
    p_usuario                   uuid,
    p_socio_id_especifico       bigint   default null,
    p_inquilino_id_especifico   bigint   default null
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
    v_insertados_socios     int := 0;
    v_insertados_inquilinos int := 0;
    v_puesto_id             bigint;
begin
    -- ── Validación de rol ────────────────────────────────────────────────────
    if public.get_my_rol() <> 'Administrador' then
        raise exception 'Acceso denegado: solo el rol Administrador puede generar cargos masivos.';
    end if;

    -- ── Validaciones básicas ─────────────────────────────────────────────────
    if p_monto <= 0 then
        raise exception 'El monto debe ser mayor a cero (recibido: %).', p_monto;
    end if;

    if p_anio not between 2000 and 2100 then
        raise exception 'Año inválido: %.', p_anio;
    end if;

    if p_mes not between 1 and 12 then
        raise exception 'Mes inválido: %.', p_mes;
    end if;

    if p_segmento not in ('SOCIOS', 'INQUILINOS', 'TODOS', 'ESPECIFICO') then
        raise exception 'Segmento inválido: %. Usar SOCIOS, INQUILINOS, TODOS o ESPECIFICO.', p_segmento;
    end if;

    -- Verificar que el concepto exista y esté activo
    if not exists (
        select 1 from public.conceptos
        where id = p_concepto_id and deleted_at is null and activo = true
    ) then
        raise exception 'Concepto con id=% no encontrado o inactivo.', p_concepto_id;
    end if;

    -- Para ESPECIFICO: exactamente uno de los dos IDs debe estar presente
    if p_segmento = 'ESPECIFICO' then
        if p_socio_id_especifico is null and p_inquilino_id_especifico is null then
            raise exception 'Segmento ESPECIFICO requiere p_socio_id_especifico o p_inquilino_id_especifico.';
        end if;
        if p_socio_id_especifico is not null and p_inquilino_id_especifico is not null then
            raise exception 'Segmento ESPECIFICO acepta solo uno: socio O inquilino, no ambos.';
        end if;
    end if;

    -- ── SOCIOS: cargo personal (socio_id) ────────────────────────────────────
    if p_segmento in ('SOCIOS', 'TODOS') then
        insert into public.montos_por_cobrar
            (socio_id, concepto_id, periodo_anio, periodo_mes,
             monto, estado, metodo_calculo, fecha_generacion, created_by)
        select
            s.id, p_concepto_id, p_anio, p_mes,
            p_monto, 'Pendiente', 'Manual', current_date, p_usuario
        from public.socios s
        where s.estado    = 'Activo'
          and s.deleted_at is null
        on conflict (socio_id, concepto_id, periodo_anio, periodo_mes)
            where deleted_at is null and socio_id is not null
            do nothing;

        get diagnostics v_insertados_socios = row_count;
    end if;

    -- ── INQUILINOS: cargo al puesto con arriendo vigente (puesto_id) ─────────
    if p_segmento in ('INQUILINOS', 'TODOS') then
        insert into public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes,
             monto, estado, metodo_calculo, fecha_generacion, created_by)
        select distinct
            ha.puesto_id, p_concepto_id, p_anio, p_mes,
            p_monto, 'Pendiente', 'Manual', current_date, p_usuario
        from public.historial_arriendos ha
        join public.inquilinos i on i.id = ha.inquilino_id
        join public.puestos    p on p.id = ha.puesto_id
        where ha.fecha_fin   is null
          and i.deleted_at   is null
          and p.estado       = 'Activo'
          and p.deleted_at   is null
        on conflict (puesto_id, concepto_id, periodo_anio, periodo_mes)
            where deleted_at is null and puesto_id is not null
            do nothing;

        get diagnostics v_insertados_inquilinos = row_count;
    end if;

    -- ── ESPECIFICO: socio personal ────────────────────────────────────────────
    if p_segmento = 'ESPECIFICO' and p_socio_id_especifico is not null then
        if not exists (
            select 1 from public.socios
            where id = p_socio_id_especifico and deleted_at is null
        ) then
            raise exception 'Socio con id=% no encontrado.', p_socio_id_especifico;
        end if;

        insert into public.montos_por_cobrar
            (socio_id, concepto_id, periodo_anio, periodo_mes,
             monto, estado, metodo_calculo, fecha_generacion, created_by)
        values
            (p_socio_id_especifico, p_concepto_id, p_anio, p_mes,
             p_monto, 'Pendiente', 'Manual', current_date, p_usuario)
        on conflict (socio_id, concepto_id, periodo_anio, periodo_mes)
            where deleted_at is null and socio_id is not null
            do nothing;

        get diagnostics v_insertados_socios = row_count;
    end if;

    -- ── ESPECIFICO: inquilino → cargo a su puesto vigente ────────────────────
    if p_segmento = 'ESPECIFICO' and p_inquilino_id_especifico is not null then
        select ha.puesto_id into v_puesto_id
        from public.historial_arriendos ha
        where ha.inquilino_id = p_inquilino_id_especifico
          and ha.fecha_fin    is null
        limit 1;

        if v_puesto_id is null then
            raise exception 'El inquilino con id=% no tiene arriendo vigente.', p_inquilino_id_especifico;
        end if;

        insert into public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes,
             monto, estado, metodo_calculo, fecha_generacion, created_by)
        values
            (v_puesto_id, p_concepto_id, p_anio, p_mes,
             p_monto, 'Pendiente', 'Manual', current_date, p_usuario)
        on conflict (puesto_id, concepto_id, periodo_anio, periodo_mes)
            where deleted_at is null and puesto_id is not null
            do nothing;

        get diagnostics v_insertados_inquilinos = row_count;
    end if;

    return jsonb_build_object(
        'segmento',              p_segmento,
        'periodo',               jsonb_build_object('anio', p_anio, 'mes', p_mes),
        'insertados_socios',     v_insertados_socios,
        'insertados_inquilinos', v_insertados_inquilinos,
        'omitidos',              0,
        'total_insertados',      v_insertados_socios + v_insertados_inquilinos
    );
end;
$$;


-- 2. Fix: rpc_public_cargar_deudas (ahora consulta también las deudas personales del socio)
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
        where (
                m.puesto_id = p_puesto_id
                or (p_persona_id is not null and p_tipo = 'socio' and m.socio_id = p_persona_id)
              )
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
