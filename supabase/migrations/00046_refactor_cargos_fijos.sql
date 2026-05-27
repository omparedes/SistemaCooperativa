-- =============================================================================
-- Migración 00046 — Refactor Cargos Fijos Mensuales
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Cambios respecto a 00044:
--   1. Elimina el concepto "Mantenimiento" del proceso de cargos fijos.
--   2. Montos fijos definitivos: Admin = S/ 60.00 (S/ 56.00 en Febrero),
--      Previsión = S/ 5.00.
--   3. Unicidad mensual estricta: lanza excepción si el período ya fue
--      procesado (impide doble facturación).
--   4. Signature actualizada: sin p_monto_mantenimiento.
--   5. Retorno sin clave "mantenimiento".
-- =============================================================================

BEGIN;

-- =============================================================================
-- Eliminar la versión anterior de la función (firma con p_monto_mantenimiento).
-- PostgreSQL trata firmas distintas como overloads independientes, por lo que
-- CREATE OR REPLACE no reemplaza la versión de 00044 — hay que borrarla primero.
-- =============================================================================
DROP FUNCTION IF EXISTS public.generar_cargos_fijos_mes(
    smallint, smallint, uuid, numeric, numeric, numeric
);

-- =============================================================================
-- NUEVA generar_cargos_fijos_mes (sin Mantenimiento, unicidad mensual,
-- defaults de Febrero)
-- =============================================================================
CREATE OR REPLACE FUNCTION public.generar_cargos_fijos_mes(
    p_anio              smallint,
    p_mes               smallint,
    p_usuario           uuid,
    p_monto_admin       numeric  DEFAULT NULL,
    p_monto_prevision   numeric  DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_id_admin          bigint;
    v_id_prev           bigint;
    v_cnt_admin         int := 0;
    v_cnt_prev          int := 0;
    v_cnt_alm_admin     int := 0;
    v_cnt_alm_prev      int := 0;
    v_cnt_principales   int := 0;
    v_cnt_almacenes     int := 0;
    v_ya_generados      int := 0;
BEGIN
    -- ── Acceso ──────────────────────────────────────────────────────────────
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el rol Administrador puede generar cargos masivos.';
    END IF;

    -- ── Validaciones de período ──────────────────────────────────────────────
    IF p_anio NOT BETWEEN 2000 AND 2100 THEN
        RAISE EXCEPTION 'Año inválido: %', p_anio;
    END IF;
    IF p_mes NOT BETWEEN 1 AND 12 THEN
        RAISE EXCEPTION 'Mes inválido: %', p_mes;
    END IF;

    -- ── Unicidad mensual: impide doble facturación ───────────────────────────
    -- Considera que ya fueron generados si existe al menos un monto activo
    -- de Admin o Previsión para el período solicitado.
    SELECT count(*) INTO v_ya_generados
    FROM public.montos_por_cobrar mpc
    JOIN public.conceptos c ON c.id = mpc.concepto_id
    WHERE mpc.periodo_anio = p_anio
      AND mpc.periodo_mes  = p_mes
      AND mpc.deleted_at   IS NULL
      AND c.nombre IN ('Gastos administrativos', 'Previsión social')
      AND c.deleted_at IS NULL;

    IF v_ya_generados > 0 THEN
        RAISE EXCEPTION
            'Los cargos fijos para el período %-% ya fueron generados previamente y no pueden duplicarse.',
            p_anio, p_mes;
    END IF;

    -- ── Montos por defecto ───────────────────────────────────────────────────
    -- Admin: S/ 56.00 en Febrero, S/ 60.00 el resto del año.
    -- Previsión: S/ 5.00 siempre.
    IF p_monto_admin IS NULL THEN
        p_monto_admin := CASE WHEN p_mes = 2 THEN 56.00 ELSE 60.00 END;
    END IF;
    IF p_monto_prevision IS NULL THEN
        p_monto_prevision := 5.00;
    END IF;

    -- Validaciones de monto
    IF p_monto_admin       <= 0 THEN RAISE EXCEPTION 'El monto de Gastos Administrativos debe ser positivo.'; END IF;
    IF p_monto_prevision   <= 0 THEN RAISE EXCEPTION 'El monto de Previsión Social debe ser positivo.';      END IF;

    -- ── Lookup de conceptos ──────────────────────────────────────────────────
    SELECT id INTO v_id_admin FROM public.conceptos
    WHERE nombre = 'Gastos administrativos' AND deleted_at IS NULL LIMIT 1;

    SELECT id INTO v_id_prev FROM public.conceptos
    WHERE nombre = 'Previsión social' AND deleted_at IS NULL LIMIT 1;

    IF v_id_admin IS NULL THEN RAISE EXCEPTION 'Concepto "Gastos administrativos" no encontrado.'; END IF;
    IF v_id_prev  IS NULL THEN RAISE EXCEPTION 'Concepto "Previsión social" no encontrado.';       END IF;

    -- ── Conteo de espacios elegibles (solo estadístico) ──────────────────────
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

    -- =========================================================================
    -- PUESTOS PRINCIPALES — Gastos Administrativos
    -- =========================================================================
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

    -- =========================================================================
    -- PUESTOS PRINCIPALES — Previsión Social
    -- =========================================================================
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

    -- =========================================================================
    -- ALMACENES — Gastos Administrativos (solo Socio con cobro_admin_activo)
    -- =========================================================================
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

    -- =========================================================================
    -- ALMACENES — Previsión Social (solo Socio con cobro_prev_social_activo)
    -- =========================================================================
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

    RETURN jsonb_build_object(
        'periodo',                jsonb_build_object('anio', p_anio, 'mes', p_mes),
        'puestos_principales',    v_cnt_principales,
        'puestos_almacenes',      v_cnt_almacenes,
        'gastos_administrativos', v_cnt_admin  + v_cnt_alm_admin,
        'prevision_social',       v_cnt_prev   + v_cnt_alm_prev,
        'total_insertados',       v_cnt_admin  + v_cnt_prev + v_cnt_alm_admin + v_cnt_alm_prev
    );
END;
$$;

COMMENT ON FUNCTION public.generar_cargos_fijos_mes IS
    'Genera masivamente los cargos fijos del mes (Gastos Administrativos y Previsión Social). '
    'Admin: S/ 60.00 (S/ 56.00 en Febrero). Previsión: S/ 5.00. '
    'Sin concepto Mantenimiento. Unicidad mensual: lanza excepción si el período ya '
    'fue procesado. Respeta cobro_admin_activo y cobro_prev_social_activo por socio. '
    'Almacenes: solo Socio ocupante con flags activos. Idempotente. (00046)';

GRANT EXECUTE ON FUNCTION public.generar_cargos_fijos_mes TO authenticated;


-- =============================================================================
-- VERIFICACIÓN FINAL
-- =============================================================================
DO $$
DECLARE
    v_fn_existe boolean;
BEGIN
    SELECT EXISTS (
        SELECT 1 FROM pg_proc p
        JOIN pg_namespace n ON n.oid = p.pronamespace
        WHERE n.nspname = 'public' AND p.proname = 'generar_cargos_fijos_mes'
    ) INTO v_fn_existe;

    IF NOT v_fn_existe THEN
        RAISE EXCEPTION '00046 FALLO: función generar_cargos_fijos_mes no encontrada.';
    END IF;

    RAISE NOTICE '00046 ✓ Migración completada: Cargos Fijos sin Mantenimiento, defaults de Febrero y unicidad mensual.';
END $$;

COMMIT;
