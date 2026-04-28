-- =============================================================================
-- Migración 00012 — Cargos Extraordinarios Segmentados
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Agrega el concepto "Otros Ingresos" al catálogo y crea la función RPC
-- generar_cargo_segmentado que inserta montos_por_cobrar en masa según el
-- segmento elegido (SOCIOS / INQUILINOS / TODOS / ESPECIFICO).
--
-- Modelado de la inserción:
--   • SOCIOS     → socio_id   por cada socio Activo (cargo personal)
--   • INQUILINOS → puesto_id  de cada puesto con arriendo vigente
--   • TODOS      → ambos anteriores en la misma transacción
--   • ESPECIFICO → un único registro (socio_id o puesto_id según tipo)
--
-- Idempotente: ON CONFLICT DO NOTHING usando los índices únicos parciales
-- de migración 00005 (idx_montos_unica_socio_concepto_periodo y
-- idx_montos_unica_puesto_concepto_periodo).
-- =============================================================================


-- ── Nuevo concepto "Otros Ingresos" ──────────────────────────────────────────
insert into public.conceptos (nombre, tipo, aplica_descuento, descripcion) values
    ('Otros Ingresos', 'Variable', false,
     'Cobro misceláneo o ingreso no categorizado en los conceptos estándar.')
on conflict (nombre) do nothing;


-- =============================================================================
-- FUNCIÓN: generar_cargo_segmentado
-- =============================================================================
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
          and ha.deleted_at  is null
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
          and ha.deleted_at   is null
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

comment on function public.generar_cargo_segmentado is
    'Genera cargos extraordinarios (montos_por_cobrar) por segmento: '
    'SOCIOS (cargo personal), INQUILINOS (puesto con arriendo vigente), '
    'TODOS (ambos), ESPECIFICO (una persona). Idempotente: ON CONFLICT DO NOTHING.';

grant execute on function public.generar_cargo_segmentado to authenticated;
