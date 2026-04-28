-- =============================================================================
-- Migración 00011 — RPCs de Facturación: lectura de tarifas desde configuraciones
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Reemplaza los defaults hardcoded de las funciones RPC de la migración 00009
-- por lecturas dinámicas desde public.configuraciones.
--
-- Cambios respecto a 00009:
--   • generar_cargos_fijos_mes     → p_monto_* pasan de DEFAULT fijo a DEFAULT NULL;
--                                    si llegan NULL se leen de configuraciones.
--   • guardar_mediciones_luz_bulk  → p_precio_kwh pasa a DEFAULT NULL;
--                                    si llega NULL se lee PRECIO_KWH_SOCIO.
--
-- Compatibilidad: los llamadores Angular siempre pasan los valores explícitos
-- (pre-cargados desde ConfiguracionService), por lo que el cambio a DEFAULT NULL
-- no rompe código existente.
-- =============================================================================


-- =============================================================================
-- 1. FUNCIÓN: generar_cargos_fijos_mes  (lee configuraciones si param = NULL)
-- =============================================================================
create or replace function public.generar_cargos_fijos_mes(
    p_anio                  smallint,
    p_mes                   smallint,
    p_usuario               uuid,
    p_monto_admin           numeric  default null,   -- NULL → lee MONTO_GASTOS_ADMIN
    p_monto_prevision       numeric  default null,   -- NULL → lee MONTO_PREVISION_SOCIAL
    p_monto_mantenimiento   numeric  default null    -- NULL → lee MONTO_MANTENIMIENTO
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
    v_id_admin    bigint;
    v_id_prev     bigint;
    v_id_mant     bigint;
    v_cnt_admin   int := 0;
    v_cnt_prev    int := 0;
    v_cnt_mant    int := 0;
    v_cnt_puestos int := 0;
begin
    -- ── Validación de rol ────────────────────────────────────────────────────
    if public.get_my_rol() <> 'Administrador' then
        raise exception 'Acceso denegado: solo el rol Administrador puede generar cargos masivos.';
    end if;

    -- ── Leer valores desde configuraciones cuando no se pasan explícitamente ─
    if p_monto_admin is null then
        select valor into p_monto_admin
        from public.configuraciones where clave = 'MONTO_GASTOS_ADMIN';
    end if;

    if p_monto_prevision is null then
        select valor into p_monto_prevision
        from public.configuraciones where clave = 'MONTO_PREVISION_SOCIAL';
    end if;

    if p_monto_mantenimiento is null then
        select valor into p_monto_mantenimiento
        from public.configuraciones where clave = 'MONTO_MANTENIMIENTO';
    end if;

    -- ── Validación de período ────────────────────────────────────────────────
    if p_anio not between 2000 and 2100 then
        raise exception 'Año inválido: %', p_anio;
    end if;
    if p_mes not between 1 and 12 then
        raise exception 'Mes inválido: %', p_mes;
    end if;

    if p_monto_admin is null or p_monto_admin <= 0 then
        raise exception 'Valor de MONTO_GASTOS_ADMIN no encontrado o inválido en configuraciones.';
    end if;
    if p_monto_prevision is null or p_monto_prevision <= 0 then
        raise exception 'Valor de MONTO_PREVISION_SOCIAL no encontrado o inválido en configuraciones.';
    end if;
    if p_monto_mantenimiento is null or p_monto_mantenimiento <= 0 then
        raise exception 'Valor de MONTO_MANTENIMIENTO no encontrado o inválido en configuraciones.';
    end if;

    -- ── Obtener IDs de conceptos ─────────────────────────────────────────────
    select id into v_id_admin   from public.conceptos where nombre = 'Gastos administrativos' and deleted_at is null limit 1;
    select id into v_id_prev    from public.conceptos where nombre = 'Previsión social'        and deleted_at is null limit 1;
    select id into v_id_mant    from public.conceptos where nombre = 'Mantenimiento'           and deleted_at is null limit 1;

    if v_id_admin is null then
        raise exception 'Concepto "Gastos administrativos" no encontrado en el catálogo.';
    end if;
    if v_id_prev is null then
        raise exception 'Concepto "Previsión social" no encontrado en el catálogo.';
    end if;
    if v_id_mant is null then
        raise exception 'Concepto "Mantenimiento" no encontrado en el catálogo.';
    end if;

    -- ── Contar puestos elegibles ─────────────────────────────────────────────
    select count(*) into v_cnt_puestos
    from public.puestos p
    join public.historial_titularidad ht on ht.puesto_id = p.id and ht.fecha_fin is null
    join public.socios s on s.id = ht.socio_id
    where p.estado    = 'Activo'
      and p.deleted_at is null
      and s.estado    = 'Activo'
      and s.deleted_at is null;

    -- ── INSERT: Gastos administrativos ───────────────────────────────────────
    insert into public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto,
         estado, metodo_calculo, fecha_generacion, created_by)
    select
        p.id, v_id_admin, p_anio, p_mes, p_monto_admin,
        'Pendiente', 'Fijo', current_date, p_usuario
    from public.puestos p
    join public.historial_titularidad ht on ht.puesto_id = p.id and ht.fecha_fin is null
    join public.socios s on s.id = ht.socio_id
    where p.estado    = 'Activo'
      and p.deleted_at is null
      and s.estado    = 'Activo'
      and s.deleted_at is null
    on conflict (puesto_id, concepto_id, periodo_anio, periodo_mes)
        where deleted_at is null and puesto_id is not null
        do nothing;

    get diagnostics v_cnt_admin = row_count;

    -- ── INSERT: Previsión social ─────────────────────────────────────────────
    insert into public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto,
         estado, metodo_calculo, fecha_generacion, created_by)
    select
        p.id, v_id_prev, p_anio, p_mes, p_monto_prevision,
        'Pendiente', 'Fijo', current_date, p_usuario
    from public.puestos p
    join public.historial_titularidad ht on ht.puesto_id = p.id and ht.fecha_fin is null
    join public.socios s on s.id = ht.socio_id
    where p.estado    = 'Activo'
      and p.deleted_at is null
      and s.estado    = 'Activo'
      and s.deleted_at is null
    on conflict (puesto_id, concepto_id, periodo_anio, periodo_mes)
        where deleted_at is null and puesto_id is not null
        do nothing;

    get diagnostics v_cnt_prev = row_count;

    -- ── INSERT: Mantenimiento ────────────────────────────────────────────────
    insert into public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto,
         estado, metodo_calculo, fecha_generacion, created_by)
    select
        p.id, v_id_mant, p_anio, p_mes, p_monto_mantenimiento,
        'Pendiente', 'Fijo', current_date, p_usuario
    from public.puestos p
    join public.historial_titularidad ht on ht.puesto_id = p.id and ht.fecha_fin is null
    join public.socios s on s.id = ht.socio_id
    where p.estado    = 'Activo'
      and p.deleted_at is null
      and s.estado    = 'Activo'
      and s.deleted_at is null
    on conflict (puesto_id, concepto_id, periodo_anio, periodo_mes)
        where deleted_at is null and puesto_id is not null
        do nothing;

    get diagnostics v_cnt_mant = row_count;

    return jsonb_build_object(
        'periodo',                jsonb_build_object('anio', p_anio, 'mes', p_mes),
        'puestos_elegibles',      v_cnt_puestos,
        'gastos_administrativos', v_cnt_admin,
        'prevision_social',       v_cnt_prev,
        'mantenimiento',          v_cnt_mant,
        'total_insertados',       v_cnt_admin + v_cnt_prev + v_cnt_mant
    );
end;
$$;

comment on function public.generar_cargos_fijos_mes is
    'Genera masivamente los cargos fijos del mes para todos los puestos activos con titular Activo. '
    'Los montos se leen desde public.configuraciones si no se pasan explícitamente. Idempotente.';

grant execute on function public.generar_cargos_fijos_mes to authenticated;


-- =============================================================================
-- 2. FUNCIÓN: guardar_mediciones_luz_bulk  (lee PRECIO_KWH_SOCIO si param = NULL)
-- =============================================================================
create or replace function public.guardar_mediciones_luz_bulk(
    p_lecturas   jsonb,
    p_anio       smallint,
    p_mes        smallint,
    p_precio_kwh numeric  default null,   -- NULL → lee PRECIO_KWH_SOCIO de configuraciones
    p_usuario    uuid
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
    v_lectura        jsonb;
    v_puesto_id      bigint;
    v_amperaje       numeric(8,2);
    v_horas_uso      smallint;
    v_dias_uso       smallint;
    v_med_id         bigint;
    v_monto_calc     numeric(12,2);
    v_id_luz         bigint;
    v_insertadas     int := 0;
    v_ignoradas      int := 0;
    v_montos_gen     int := 0;
begin
    -- ── Validación de rol ────────────────────────────────────────────────────
    if public.get_my_rol() <> 'Administrador' then
        raise exception 'Acceso denegado: solo el rol Administrador puede guardar mediciones masivas.';
    end if;

    -- ── Leer precio desde configuraciones si no se pasó explícitamente ───────
    if p_precio_kwh is null then
        select valor into p_precio_kwh
        from public.configuraciones where clave = 'PRECIO_KWH_SOCIO';
    end if;

    if p_precio_kwh is null or p_precio_kwh <= 0 then
        raise exception 'Valor de PRECIO_KWH_SOCIO no encontrado o inválido en configuraciones (%.4f).', coalesce(p_precio_kwh, 0);
    end if;

    -- ── Concepto "Luz" ───────────────────────────────────────────────────────
    select id into v_id_luz from public.conceptos
    where nombre = 'Luz' and deleted_at is null limit 1;

    if v_id_luz is null then
        raise exception 'Concepto "Luz" no encontrado en el catálogo.';
    end if;

    -- ── Iterar sobre cada lectura del array ──────────────────────────────────
    for v_lectura in select value from jsonb_array_elements(p_lecturas) loop

        v_puesto_id := (v_lectura->>'puesto_id')::bigint;
        v_amperaje  := coalesce((v_lectura->>'amperaje')::numeric(8,2), 0);
        v_horas_uso := coalesce((v_lectura->>'horas_uso')::smallint, 12);
        v_dias_uso  := coalesce((v_lectura->>'dias_uso')::smallint,  30);

        if v_amperaje < 0 then
            raise exception 'Amperaje negativo para puesto_id %', v_puesto_id;
        end if;

        insert into public.mediciones_luz
            (puesto_id, periodo_anio, periodo_mes, fecha_medicion,
             amperaje, horas_uso, dias_uso, precio_kwh, monto_alumbrado, created_by)
        values
            (v_puesto_id, p_anio, p_mes, current_date,
             v_amperaje, v_horas_uso, v_dias_uso, p_precio_kwh, 0, p_usuario)
        on conflict (puesto_id, periodo_anio, periodo_mes)
            where deleted_at is null
            do nothing
        returning id, monto_calculado into v_med_id, v_monto_calc;

        if v_med_id is not null then
            v_insertadas := v_insertadas + 1;

            if v_monto_calc > 0 then
                insert into public.montos_por_cobrar
                    (puesto_id, concepto_id, periodo_anio, periodo_mes,
                     monto, estado, metodo_calculo, medicion_luz_id, fecha_generacion, created_by)
                values
                    (v_puesto_id, v_id_luz, p_anio, p_mes,
                     v_monto_calc, 'Pendiente', 'Amperaje', v_med_id, current_date, p_usuario)
                on conflict (puesto_id, concepto_id, periodo_anio, periodo_mes)
                    where deleted_at is null and puesto_id is not null
                    do nothing;

                if found then
                    v_montos_gen := v_montos_gen + 1;
                end if;
            end if;
        else
            v_ignoradas := v_ignoradas + 1;
        end if;

    end loop;

    return jsonb_build_object(
        'periodo',                   jsonb_build_object('anio', p_anio, 'mes', p_mes),
        'precio_kwh_usado',          p_precio_kwh,
        'mediciones_nuevas',         v_insertadas,
        'mediciones_ya_existian',    v_ignoradas,
        'montos_luz_generados',      v_montos_gen
    );
end;
$$;

comment on function public.guardar_mediciones_luz_bulk is
    'Inserta mediciones_luz en batch (método Amperaje §3.1) y genera montos_por_cobrar de Luz. '
    'El precio kWh se lee desde public.configuraciones (PRECIO_KWH_SOCIO) si no se pasa explícitamente. Idempotente.';

grant execute on function public.guardar_mediciones_luz_bulk to authenticated;
