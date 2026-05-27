-- =============================================================================
-- Migración 00044 — Configuración de Cargos por Socio y Gestión de Giros
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- 1. ALTER socios: cobro_admin_activo, cobro_prev_social_activo (BOOLEAN)
-- 2. RPC toggle_cargo_socio   → activa/desactiva cargo admin o prev_social por socio
-- 3. Refactor generar_cargos_fijos_mes → respeta flags por socio y tipo_ocupante
-- 4. RPC rpc_eliminar_giro    → soft-delete de giro con validación de puestos
-- =============================================================================

-- =============================================================================
-- 1. Nuevas columnas en socios
-- =============================================================================
ALTER TABLE public.socios
    ADD COLUMN IF NOT EXISTS cobro_admin_activo      BOOLEAN NOT NULL DEFAULT true,
    ADD COLUMN IF NOT EXISTS cobro_prev_social_activo BOOLEAN NOT NULL DEFAULT true;

COMMENT ON COLUMN public.socios.cobro_admin_activo IS
    'Si false, este socio queda excluido del cargo mensual de Gastos Administrativos.';
COMMENT ON COLUMN public.socios.cobro_prev_social_activo IS
    'Si false, este socio queda excluido del cargo mensual de Previsión Social.';


-- =============================================================================
-- 2. RPC toggle_cargo_socio
--    Activa o desactiva un cargo fijo a nivel de socio.
--    p_cargo: 'admin' | 'prev_social'
-- =============================================================================
CREATE OR REPLACE FUNCTION public.toggle_cargo_socio(
    p_socio_id  bigint,
    p_cargo     text,
    p_activo    boolean,
    p_usuario   uuid
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_socio        record;
    v_col          text;
    v_val_anterior boolean;
    v_tabla_audit  boolean := false;
BEGIN
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede modificar la configuración de cargos.';
    END IF;

    IF p_cargo NOT IN ('admin', 'prev_social') THEN
        RAISE EXCEPTION 'Cargo inválido: %. Use "admin" o "prev_social".', p_cargo;
    END IF;

    SELECT * INTO v_socio FROM public.socios WHERE id = p_socio_id AND deleted_at IS NULL;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Socio % no encontrado.', p_socio_id;
    END IF;

    IF p_cargo = 'admin' THEN
        v_col := 'cobro_admin_activo';
        v_val_anterior := v_socio.cobro_admin_activo;
        UPDATE public.socios SET cobro_admin_activo = p_activo WHERE id = p_socio_id;
    ELSE
        v_col := 'cobro_prev_social_activo';
        v_val_anterior := v_socio.cobro_prev_social_activo;
        UPDATE public.socios SET cobro_prev_social_activo = p_activo WHERE id = p_socio_id;
    END IF;

    -- Auditoría dinámica (mismo patrón que 00013)
    SELECT EXISTS (
        SELECT 1 FROM information_schema.tables
        WHERE table_schema = 'public' AND table_name = 'auditoria'
    ) INTO v_tabla_audit;

    IF v_tabla_audit THEN
        EXECUTE
            'INSERT INTO public.auditoria
             (tabla_afectada, registro_id, accion, valor_anterior, valor_nuevo, usuario_id, fecha_cambio)
             VALUES ($1, $2, $3, $4, $5, $6, now())'
        USING
            'socios',
            p_socio_id,
            'Actualizar',
            jsonb_build_object(v_col, v_val_anterior),
            jsonb_build_object(v_col, p_activo),
            p_usuario;
    END IF;

    RETURN jsonb_build_object(
        'socio_id',  p_socio_id,
        'cargo',     p_cargo,
        'anterior',  v_val_anterior,
        'nuevo',     p_activo
    );
END;
$$;

COMMENT ON FUNCTION public.toggle_cargo_socio IS
    'Activa/desactiva el cargo mensual de "admin" o "prev_social" para un socio específico. '
    'Solo Administrador. Registra en auditoría. (00044)';

GRANT EXECUTE ON FUNCTION public.toggle_cargo_socio TO authenticated;


-- =============================================================================
-- 3. Refactor generar_cargos_fijos_mes
--    Ahora respeta cobro_admin_activo y cobro_prev_social_activo por socio.
--    Para Almacenes:
--      - admin/prevision: solo si tipo_ocupante='Socio' con flags activos
--      - mantenimiento:   todos los almacenes con ocupación activa (sin filtro)
-- =============================================================================
CREATE OR REPLACE FUNCTION public.generar_cargos_fijos_mes(
    p_anio                  smallint,
    p_mes                   smallint,
    p_usuario               uuid,
    p_monto_admin           numeric  DEFAULT NULL,
    p_monto_prevision       numeric  DEFAULT NULL,
    p_monto_mantenimiento   numeric  DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_id_admin   bigint;
    v_id_prev    bigint;
    v_id_mant    bigint;
    v_cnt_admin  int := 0;
    v_cnt_prev   int := 0;
    v_cnt_mant   int := 0;
    v_cnt_alm_admin int := 0;
    v_cnt_alm_prev  int := 0;
    v_cnt_alm_mant  int := 0;
    v_cnt_principales int := 0;
    v_cnt_almacenes   int := 0;
BEGIN
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el rol Administrador puede generar cargos masivos.';
    END IF;

    IF p_monto_admin IS NULL THEN
        SELECT valor INTO p_monto_admin FROM public.configuraciones WHERE clave = 'MONTO_GASTOS_ADMIN';
    END IF;
    IF p_monto_prevision IS NULL THEN
        SELECT valor INTO p_monto_prevision FROM public.configuraciones WHERE clave = 'MONTO_PREVISION_SOCIAL';
    END IF;
    IF p_monto_mantenimiento IS NULL THEN
        SELECT valor INTO p_monto_mantenimiento FROM public.configuraciones WHERE clave = 'MONTO_MANTENIMIENTO';
    END IF;

    IF p_anio NOT BETWEEN 2000 AND 2100 THEN RAISE EXCEPTION 'Año inválido: %', p_anio; END IF;
    IF p_mes  NOT BETWEEN 1 AND 12      THEN RAISE EXCEPTION 'Mes inválido: %', p_mes;  END IF;
    IF coalesce(p_monto_admin, 0) <= 0         THEN RAISE EXCEPTION 'MONTO_GASTOS_ADMIN inválido.';       END IF;
    IF coalesce(p_monto_prevision, 0) <= 0     THEN RAISE EXCEPTION 'MONTO_PREVISION_SOCIAL inválido.';   END IF;
    IF coalesce(p_monto_mantenimiento, 0) <= 0 THEN RAISE EXCEPTION 'MONTO_MANTENIMIENTO inválido.';      END IF;

    SELECT id INTO v_id_admin FROM public.conceptos WHERE nombre = 'Gastos administrativos' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_id_prev  FROM public.conceptos WHERE nombre = 'Previsión social'        AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_id_mant  FROM public.conceptos WHERE nombre = 'Mantenimiento'           AND deleted_at IS NULL LIMIT 1;

    IF v_id_admin IS NULL THEN RAISE EXCEPTION 'Concepto "Gastos administrativos" no encontrado.'; END IF;
    IF v_id_prev  IS NULL THEN RAISE EXCEPTION 'Concepto "Previsión social" no encontrado.';       END IF;
    IF v_id_mant  IS NULL THEN RAISE EXCEPTION 'Concepto "Mantenimiento" no encontrado.';          END IF;

    SELECT count(*) INTO v_cnt_principales
    FROM public.puestos p
    JOIN public.historial_titularidad ht ON ht.puesto_id = p.id AND ht.fecha_fin IS NULL
    JOIN public.socios s ON s.id = ht.socio_id
    WHERE p.estado = 'Activo' AND p.deleted_at IS NULL
      AND s.estado = 'Activo' AND s.deleted_at IS NULL;

    SELECT count(DISTINCT p.id) INTO v_cnt_almacenes
    FROM public.puestos p
    JOIN public.ocupaciones_almacenes oa ON oa.puesto_id = p.id AND oa.fecha_fin IS NULL
    WHERE p.tipo_espacio = 'Almacen' AND p.estado = 'Activo' AND p.deleted_at IS NULL;

    -- ── Regular/Pequeño: Gastos administrativos (respeta cobro_admin_activo) ──
    INSERT INTO public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes,
         monto, estado, metodo_calculo, fecha_generacion, created_by)
    SELECT p.id, v_id_admin, p_anio, p_mes, p_monto_admin,
           'Pendiente', 'Fijo', current_date, p_usuario
    FROM public.puestos p
    JOIN public.historial_titularidad ht ON ht.puesto_id = p.id AND ht.fecha_fin IS NULL
    JOIN public.socios s ON s.id = ht.socio_id
    WHERE p.estado = 'Activo' AND p.deleted_at IS NULL
      AND s.estado = 'Activo' AND s.deleted_at IS NULL
      AND s.cobro_admin_activo = true
    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
        WHERE deleted_at IS NULL AND puesto_id IS NOT NULL DO NOTHING;
    GET DIAGNOSTICS v_cnt_admin = ROW_COUNT;

    -- ── Regular/Pequeño: Previsión social (respeta cobro_prev_social_activo) ──
    INSERT INTO public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes,
         monto, estado, metodo_calculo, fecha_generacion, created_by)
    SELECT p.id, v_id_prev, p_anio, p_mes, p_monto_prevision,
           'Pendiente', 'Fijo', current_date, p_usuario
    FROM public.puestos p
    JOIN public.historial_titularidad ht ON ht.puesto_id = p.id AND ht.fecha_fin IS NULL
    JOIN public.socios s ON s.id = ht.socio_id
    WHERE p.estado = 'Activo' AND p.deleted_at IS NULL
      AND s.estado = 'Activo' AND s.deleted_at IS NULL
      AND s.cobro_prev_social_activo = true
    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
        WHERE deleted_at IS NULL AND puesto_id IS NOT NULL DO NOTHING;
    GET DIAGNOSTICS v_cnt_prev = ROW_COUNT;

    -- ── Regular/Pequeño: Mantenimiento (todos los socios activos) ─────────────
    INSERT INTO public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes,
         monto, estado, metodo_calculo, fecha_generacion, created_by)
    SELECT p.id, v_id_mant, p_anio, p_mes, p_monto_mantenimiento,
           'Pendiente', 'Fijo', current_date, p_usuario
    FROM public.puestos p
    JOIN public.historial_titularidad ht ON ht.puesto_id = p.id AND ht.fecha_fin IS NULL
    JOIN public.socios s ON s.id = ht.socio_id
    WHERE p.estado = 'Activo' AND p.deleted_at IS NULL
      AND s.estado = 'Activo' AND s.deleted_at IS NULL
    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
        WHERE deleted_at IS NULL AND puesto_id IS NOT NULL DO NOTHING;
    GET DIAGNOSTICS v_cnt_mant = ROW_COUNT;

    -- ── Almacén: Gastos administrativos (solo Socio con cobro_admin_activo) ───
    INSERT INTO public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes,
         monto, estado, metodo_calculo, fecha_generacion, created_by)
    SELECT DISTINCT p.id, v_id_admin, p_anio, p_mes, p_monto_admin,
           'Pendiente', 'Fijo', current_date, p_usuario
    FROM public.puestos p
    JOIN public.ocupaciones_almacenes oa ON oa.puesto_id = p.id AND oa.fecha_fin IS NULL
    JOIN public.socios s ON s.id = oa.socio_id
    WHERE p.tipo_espacio = 'Almacen' AND p.estado = 'Activo' AND p.deleted_at IS NULL
      AND oa.tipo_ocupante = 'Socio'
      AND s.estado = 'Activo' AND s.deleted_at IS NULL
      AND s.cobro_admin_activo = true
    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
        WHERE deleted_at IS NULL AND puesto_id IS NOT NULL DO NOTHING;
    GET DIAGNOSTICS v_cnt_alm_admin = ROW_COUNT;

    -- ── Almacén: Previsión social (solo Socio con cobro_prev_social_activo) ───
    INSERT INTO public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes,
         monto, estado, metodo_calculo, fecha_generacion, created_by)
    SELECT DISTINCT p.id, v_id_prev, p_anio, p_mes, p_monto_prevision,
           'Pendiente', 'Fijo', current_date, p_usuario
    FROM public.puestos p
    JOIN public.ocupaciones_almacenes oa ON oa.puesto_id = p.id AND oa.fecha_fin IS NULL
    JOIN public.socios s ON s.id = oa.socio_id
    WHERE p.tipo_espacio = 'Almacen' AND p.estado = 'Activo' AND p.deleted_at IS NULL
      AND oa.tipo_ocupante = 'Socio'
      AND s.estado = 'Activo' AND s.deleted_at IS NULL
      AND s.cobro_prev_social_activo = true
    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
        WHERE deleted_at IS NULL AND puesto_id IS NOT NULL DO NOTHING;
    GET DIAGNOSTICS v_cnt_alm_prev = ROW_COUNT;

    -- ── Almacén: Mantenimiento (todos los almacenes con ocupación activa) ─────
    INSERT INTO public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes,
         monto, estado, metodo_calculo, fecha_generacion, created_by)
    SELECT DISTINCT p.id, v_id_mant, p_anio, p_mes, p_monto_mantenimiento,
           'Pendiente', 'Fijo', current_date, p_usuario
    FROM public.puestos p
    JOIN public.ocupaciones_almacenes oa ON oa.puesto_id = p.id AND oa.fecha_fin IS NULL
    WHERE p.tipo_espacio = 'Almacen' AND p.estado = 'Activo' AND p.deleted_at IS NULL
    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
        WHERE deleted_at IS NULL AND puesto_id IS NOT NULL DO NOTHING;
    GET DIAGNOSTICS v_cnt_alm_mant = ROW_COUNT;

    RETURN jsonb_build_object(
        'periodo',                    jsonb_build_object('anio', p_anio, 'mes', p_mes),
        'puestos_principales',        v_cnt_principales,
        'puestos_almacenes',          v_cnt_almacenes,
        'gastos_administrativos',     v_cnt_admin  + v_cnt_alm_admin,
        'prevision_social',           v_cnt_prev   + v_cnt_alm_prev,
        'mantenimiento',              v_cnt_mant   + v_cnt_alm_mant,
        'total_insertados',           v_cnt_admin  + v_cnt_prev  + v_cnt_mant
                                    + v_cnt_alm_admin + v_cnt_alm_prev + v_cnt_alm_mant
    );
END;
$$;

COMMENT ON FUNCTION public.generar_cargos_fijos_mes IS
    'Genera masivamente los cargos fijos del mes respetando cobro_admin_activo y '
    'cobro_prev_social_activo por socio. Almacenes: admin/prevision solo para Socio ocupante '
    'con flags activos; mantenimiento para todos. Idempotente. (00044)';

GRANT EXECUTE ON FUNCTION public.generar_cargos_fijos_mes TO authenticated;


-- =============================================================================
-- 4. RPC rpc_eliminar_giro
--    Soft-delete con validación de puestos activos.
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_eliminar_giro(
    p_giro_id    bigint,
    p_motivo     text,
    p_usuario_id uuid
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_giro          record;
    v_puestos_activos int;
    v_tabla_audit   boolean := false;
BEGIN
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede eliminar giros.';
    END IF;

    IF p_motivo IS NULL OR trim(p_motivo) = '' THEN
        RAISE EXCEPTION 'El motivo de eliminación no puede estar vacío.';
    END IF;

    SELECT * INTO v_giro FROM public.giros WHERE id = p_giro_id AND deleted_at IS NULL;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Giro % no encontrado.', p_giro_id;
    END IF;

    SELECT count(*) INTO v_puestos_activos
    FROM public.puestos
    WHERE giro_id = p_giro_id AND estado = 'Activo' AND deleted_at IS NULL;

    IF v_puestos_activos > 0 THEN
        RAISE EXCEPTION 'No se puede eliminar el giro "%": tiene % puesto(s) activo(s) asignado(s).',
            v_giro.nombre, v_puestos_activos;
    END IF;

    UPDATE public.giros
    SET deleted_at       = now(),
        anulado_por      = p_usuario_id,
        motivo_anulacion = p_motivo
    WHERE id = p_giro_id;

    SELECT EXISTS (
        SELECT 1 FROM information_schema.tables
        WHERE table_schema = 'public' AND table_name = 'auditoria'
    ) INTO v_tabla_audit;

    IF v_tabla_audit THEN
        EXECUTE
            'INSERT INTO public.auditoria
             (tabla_afectada, registro_id, accion, valor_anterior, valor_nuevo, usuario_id, fecha_cambio)
             VALUES ($1, $2, $3, $4, $5, $6, now())'
        USING
            'giros',
            p_giro_id,
            'Anular',
            jsonb_build_object('nombre', v_giro.nombre, 'activo', v_giro.activo),
            jsonb_build_object('deleted_at', now()::text, 'motivo', p_motivo),
            p_usuario_id;
    END IF;
END;
$$;

COMMENT ON FUNCTION public.rpc_eliminar_giro IS
    'Soft-delete de un giro comercial. Valida que no tenga puestos activos asignados. '
    'Solo Administrador. Registra en auditoría. (00044)';

GRANT EXECUTE ON FUNCTION public.rpc_eliminar_giro TO authenticated;
