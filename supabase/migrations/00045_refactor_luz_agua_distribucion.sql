-- =============================================================================
-- Migración 00045 — Refactor Facturación Luz y Agua: Distribución Manual
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Contexto:
--   El cálculo de consumo Luz/Agua se realiza externamente. El ERP actúa
--   únicamente como sistema de registro y distribución. Se eliminan las
--   dependencias de amperaje del flujo principal; la nueva pantalla permite
--   ingresar el monto total del recibo real y distribuirlo entre los puestos
--   activos para el servicio.
--
-- Crea:
--   1. distribuciones_mensuales  — encabezado de distribución (borrador → aprobado)
--   2. distribucion_detalles     — monto por puesto por distribución
--   3. RLS + políticas básicas en ambas tablas
--   4. Trigger de auditoría en distribuciones_mensuales
--   5. RPC guardar_progreso_distribucion    (Upsert idempotente)
--   6. RPC resetear_distribucion_mensual    (Borrar borrador/revisión)
--   7. RPC aprobar_distribucion_mensual     (Genera montos_por_cobrar)
-- =============================================================================

BEGIN;

-- =============================================================================
-- 1. TABLA distribuciones_mensuales
-- =============================================================================
CREATE TABLE IF NOT EXISTS public.distribuciones_mensuales (
    id              bigserial       PRIMARY KEY,
    periodo_anio    smallint        NOT NULL CHECK (periodo_anio BETWEEN 2000 AND 2100),
    periodo_mes     smallint        NOT NULL CHECK (periodo_mes  BETWEEN 1    AND 12),
    servicio        text            NOT NULL CHECK (servicio IN ('Luz', 'Agua')),
    monto_recibo_real numeric(12,2) NOT NULL CHECK (monto_recibo_real >= 0),
    estado          text            NOT NULL DEFAULT 'Borrador'
                                    CHECK (estado IN ('Borrador', 'En Revision', 'Aprobado')),

    created_by      uuid            REFERENCES auth.users(id) ON DELETE SET NULL,
    aprobado_at     timestamptz,
    aprobado_por    uuid            REFERENCES auth.users(id) ON DELETE SET NULL,

    created_at      timestamptz     NOT NULL DEFAULT now(),
    updated_at      timestamptz     NOT NULL DEFAULT now(),

    -- Un período/servicio solo puede tener UN encabezado de distribución activo
    CONSTRAINT uq_distribuciones_periodo_servicio
        UNIQUE (periodo_anio, periodo_mes, servicio)
);

COMMENT ON TABLE public.distribuciones_mensuales IS
    'Encabezado del proceso de distribución mensual de Luz o Agua. '
    'Un registro por período+servicio. Flujo: Borrador → En Revision → Aprobado. '
    'Una vez Aprobado genera montos_por_cobrar y no puede modificarse. (00045)';

COMMENT ON COLUMN public.distribuciones_mensuales.monto_recibo_real IS
    'Importe total del recibo real pagado a la empresa de servicios. '
    'Se ingresa manualmente y sirve de referencia para validar que la distribución '
    'entre puestos no supere lo facturado.';

CREATE INDEX IF NOT EXISTS idx_distribuciones_periodo
    ON public.distribuciones_mensuales (periodo_anio DESC, periodo_mes DESC);

CREATE INDEX IF NOT EXISTS idx_distribuciones_estado
    ON public.distribuciones_mensuales (estado);

-- Trigger updated_at
DROP TRIGGER IF EXISTS trg_distribuciones_set_updated_at ON public.distribuciones_mensuales;
CREATE TRIGGER trg_distribuciones_set_updated_at
    BEFORE UPDATE ON public.distribuciones_mensuales
    FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();


-- =============================================================================
-- 2. TABLA distribucion_detalles
-- =============================================================================
CREATE TABLE IF NOT EXISTS public.distribucion_detalles (
    id                  bigserial   PRIMARY KEY,
    distribucion_id     bigint      NOT NULL
                                    REFERENCES public.distribuciones_mensuales(id)
                                    ON DELETE CASCADE,
    puesto_id           bigint      NOT NULL
                                    REFERENCES public.puestos(id)
                                    ON DELETE RESTRICT,
    monto               numeric(12,2) NOT NULL CHECK (monto >= 0),
    observacion         text,

    created_at          timestamptz NOT NULL DEFAULT now(),
    updated_at          timestamptz NOT NULL DEFAULT now(),

    -- Un puesto aparece una sola vez por distribución
    CONSTRAINT uq_distribucion_detalles_puesto
        UNIQUE (distribucion_id, puesto_id)
);

COMMENT ON TABLE public.distribucion_detalles IS
    'Monto asignado a cada puesto dentro de una distribución mensual de Luz o Agua. '
    'Eliminados en cascada cuando se borra el encabezado. (00045)';

CREATE INDEX IF NOT EXISTS idx_distribucion_detalles_dist_id
    ON public.distribucion_detalles (distribucion_id);

CREATE INDEX IF NOT EXISTS idx_distribucion_detalles_puesto
    ON public.distribucion_detalles (puesto_id);

-- Trigger updated_at
DROP TRIGGER IF EXISTS trg_distribucion_detalles_set_updated_at ON public.distribucion_detalles;
CREATE TRIGGER trg_distribucion_detalles_set_updated_at
    BEFORE UPDATE ON public.distribucion_detalles
    FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();


-- =============================================================================
-- 3. ROW LEVEL SECURITY
-- =============================================================================

ALTER TABLE public.distribuciones_mensuales ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.distribucion_detalles    ENABLE ROW LEVEL SECURITY;

-- distribuciones_mensuales: acceso total para usuarios autenticados
-- (restricciones de negocio se aplican dentro de los RPCs, no aquí)
DROP POLICY IF EXISTS pol_distribuciones_select  ON public.distribuciones_mensuales;
DROP POLICY IF EXISTS pol_distribuciones_insert  ON public.distribuciones_mensuales;
DROP POLICY IF EXISTS pol_distribuciones_update  ON public.distribuciones_mensuales;
DROP POLICY IF EXISTS pol_distribuciones_delete  ON public.distribuciones_mensuales;

CREATE POLICY pol_distribuciones_select ON public.distribuciones_mensuales
    FOR SELECT TO authenticated USING (true);
CREATE POLICY pol_distribuciones_insert ON public.distribuciones_mensuales
    FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY pol_distribuciones_update ON public.distribuciones_mensuales
    FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY pol_distribuciones_delete ON public.distribuciones_mensuales
    FOR DELETE TO authenticated USING (true);

-- distribucion_detalles: misma apertura (los RPCs son SECURITY DEFINER)
DROP POLICY IF EXISTS pol_dist_detalles_select ON public.distribucion_detalles;
DROP POLICY IF EXISTS pol_dist_detalles_insert ON public.distribucion_detalles;
DROP POLICY IF EXISTS pol_dist_detalles_update ON public.distribucion_detalles;
DROP POLICY IF EXISTS pol_dist_detalles_delete ON public.distribucion_detalles;

CREATE POLICY pol_dist_detalles_select ON public.distribucion_detalles
    FOR SELECT TO authenticated USING (true);
CREATE POLICY pol_dist_detalles_insert ON public.distribucion_detalles
    FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY pol_dist_detalles_update ON public.distribucion_detalles
    FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY pol_dist_detalles_delete ON public.distribucion_detalles
    FOR DELETE TO authenticated USING (true);


-- =============================================================================
-- 4. TRIGGER DE AUDITORÍA en distribuciones_mensuales
--    Usa la función genérica log_audit_action() de la migración 00016.
-- =============================================================================
DROP TRIGGER IF EXISTS trg_audit_distribuciones ON public.distribuciones_mensuales;
CREATE TRIGGER trg_audit_distribuciones
    AFTER INSERT OR UPDATE OR DELETE ON public.distribuciones_mensuales
    FOR EACH ROW EXECUTE FUNCTION public.log_audit_action();


-- =============================================================================
-- 5. RPC: guardar_progreso_distribucion
--    Crea o actualiza el encabezado y realiza Upsert de los detalles.
--    Valida: estado no Aprobado, servicio activo por puesto.
-- =============================================================================
CREATE OR REPLACE FUNCTION public.guardar_progreso_distribucion(
    p_servicio          text,
    p_anio              smallint,
    p_mes               smallint,
    p_monto_recibo_real numeric,
    p_detalles          jsonb,
    p_usuario           uuid DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_dist_id       bigint;
    v_estado_actual text;
    v_detalle       jsonb;
    v_puesto_id     bigint;
    v_monto         numeric(12,2);
    v_observacion   text;
    v_cobro_activo  boolean;
    v_codigo        text;
    v_cnt_detalles  int := 0;
BEGIN
    -- Validaciones de entrada
    IF p_servicio NOT IN ('Luz', 'Agua') THEN
        RAISE EXCEPTION 'Servicio inválido: "%". Use "Luz" o "Agua".', p_servicio;
    END IF;
    IF p_anio NOT BETWEEN 2000 AND 2100 THEN
        RAISE EXCEPTION 'Año inválido: %', p_anio;
    END IF;
    IF p_mes NOT BETWEEN 1 AND 12 THEN
        RAISE EXCEPTION 'Mes inválido: %', p_mes;
    END IF;
    IF coalesce(p_monto_recibo_real, -1) < 0 THEN
        RAISE EXCEPTION 'El monto del recibo real no puede ser negativo.';
    END IF;

    -- Resolver usuario desde el contexto de sesión si no se pasó
    IF p_usuario IS NULL THEN
        p_usuario := auth.uid();
    END IF;

    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede guardar distribuciones.';
    END IF;

    -- Buscar encabezado existente
    SELECT id, estado INTO v_dist_id, v_estado_actual
    FROM public.distribuciones_mensuales
    WHERE periodo_anio = p_anio
      AND periodo_mes  = p_mes
      AND servicio     = p_servicio;

    IF v_estado_actual = 'Aprobado' THEN
        RAISE EXCEPTION
            'La distribución de % %/% ya está Aprobada y no puede modificarse.',
            p_servicio, p_anio, p_mes;
    END IF;

    -- Crear o actualizar encabezado
    IF v_dist_id IS NULL THEN
        INSERT INTO public.distribuciones_mensuales
            (periodo_anio, periodo_mes, servicio, monto_recibo_real, estado, created_by)
        VALUES
            (p_anio, p_mes, p_servicio, p_monto_recibo_real, 'Borrador', p_usuario)
        RETURNING id INTO v_dist_id;
    ELSE
        UPDATE public.distribuciones_mensuales
        SET monto_recibo_real = p_monto_recibo_real,
            updated_at        = now()
        WHERE id = v_dist_id;
    END IF;

    -- Upsert de cada detalle
    FOR v_detalle IN SELECT value FROM jsonb_array_elements(p_detalles) LOOP

        v_puesto_id   := (v_detalle->>'puesto_id')::bigint;
        v_monto       := coalesce((v_detalle->>'monto')::numeric(12,2), 0);
        v_observacion := v_detalle->>'observacion';

        IF v_monto < 0 THEN
            RAISE EXCEPTION 'El monto no puede ser negativo para puesto_id %.', v_puesto_id;
        END IF;

        -- Verificar que el puesto tiene el servicio activo
        IF p_servicio = 'Luz' THEN
            SELECT cobro_luz_activo,  codigo_puesto
              INTO v_cobro_activo, v_codigo
            FROM public.puestos WHERE id = v_puesto_id AND deleted_at IS NULL;
        ELSE
            SELECT cobro_agua_activo, codigo_puesto
              INTO v_cobro_activo, v_codigo
            FROM public.puestos WHERE id = v_puesto_id AND deleted_at IS NULL;
        END IF;

        IF v_codigo IS NULL THEN
            RAISE EXCEPTION 'Puesto id=% no encontrado o dado de baja.', v_puesto_id;
        END IF;

        IF NOT coalesce(v_cobro_activo, true) THEN
            RAISE EXCEPTION
                'El puesto "%" (id=%) no tiene habilitado el cobro de %. '
                'Active el servicio antes de incluirlo en la distribución.',
                v_codigo, v_puesto_id, p_servicio;
        END IF;

        INSERT INTO public.distribucion_detalles
            (distribucion_id, puesto_id, monto, observacion)
        VALUES
            (v_dist_id, v_puesto_id, v_monto, v_observacion)
        ON CONFLICT (distribucion_id, puesto_id)
            DO UPDATE SET
                monto       = EXCLUDED.monto,
                observacion = EXCLUDED.observacion,
                updated_at  = now();

        v_cnt_detalles := v_cnt_detalles + 1;
    END LOOP;

    RETURN jsonb_build_object(
        'distribucion_id',   v_dist_id,
        'servicio',          p_servicio,
        'periodo',           jsonb_build_object('anio', p_anio, 'mes', p_mes),
        'monto_recibo_real', p_monto_recibo_real,
        'detalles_guardados', v_cnt_detalles
    );
END;
$$;

COMMENT ON FUNCTION public.guardar_progreso_distribucion IS
    'Crea o actualiza el encabezado de distribución mensual de Luz/Agua y realiza '
    'Upsert de los montos por puesto. Idempotente. Bloquea si ya está Aprobado. '
    'Valida cobro_luz/agua_activo por puesto. Solo Administrador. (00045)';

GRANT EXECUTE ON FUNCTION public.guardar_progreso_distribucion TO authenticated;


-- =============================================================================
-- 6. RPC: resetear_distribucion_mensual
--    Elimina todos los detalles y el encabezado (solo si no está Aprobado).
-- =============================================================================
CREATE OR REPLACE FUNCTION public.resetear_distribucion_mensual(
    p_servicio  text,
    p_anio      smallint,
    p_mes       smallint
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_dist_id      bigint;
    v_estado       text;
    v_cnt_detalles int;
BEGIN
    IF p_servicio NOT IN ('Luz', 'Agua') THEN
        RAISE EXCEPTION 'Servicio inválido: "%". Use "Luz" o "Agua".', p_servicio;
    END IF;

    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede resetear distribuciones.';
    END IF;

    SELECT id, estado INTO v_dist_id, v_estado
    FROM public.distribuciones_mensuales
    WHERE periodo_anio = p_anio
      AND periodo_mes  = p_mes
      AND servicio     = p_servicio;

    IF v_dist_id IS NULL THEN
        RETURN jsonb_build_object(
            'resultado', 'no_existia',
            'servicio',  p_servicio,
            'periodo',   jsonb_build_object('anio', p_anio, 'mes', p_mes)
        );
    END IF;

    IF v_estado = 'Aprobado' THEN
        RAISE EXCEPTION
            'La distribución de % %/% está Aprobada y no puede resetearse. '
            'Los montos_por_cobrar ya fueron generados.',
            p_servicio, p_anio, p_mes;
    END IF;

    -- Contar detalles antes de borrar (para el reporte)
    SELECT count(*) INTO v_cnt_detalles
    FROM public.distribucion_detalles
    WHERE distribucion_id = v_dist_id;

    -- DELETE en cascada (los detalles se borran automáticamente)
    DELETE FROM public.distribuciones_mensuales WHERE id = v_dist_id;

    RETURN jsonb_build_object(
        'resultado',       'reseteado',
        'servicio',        p_servicio,
        'periodo',         jsonb_build_object('anio', p_anio, 'mes', p_mes),
        'detalles_borrados', v_cnt_detalles
    );
END;
$$;

COMMENT ON FUNCTION public.resetear_distribucion_mensual IS
    'Elimina el encabezado y todos los detalles de una distribución en estado '
    'Borrador o En Revision. Bloquea si ya está Aprobada. Solo Administrador. (00045)';

GRANT EXECUTE ON FUNCTION public.resetear_distribucion_mensual TO authenticated;


-- =============================================================================
-- 7. RPC: aprobar_distribucion_mensual
--    Cambia estado a 'Aprobado' y genera montos_por_cobrar por cada detalle
--    con monto > 0. Idempotente si el monto_por_cobrar ya existe (ON CONFLICT DO NOTHING).
-- =============================================================================
CREATE OR REPLACE FUNCTION public.aprobar_distribucion_mensual(
    p_servicio  text,
    p_anio      smallint,
    p_mes       smallint,
    p_usuario   uuid DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_dist_id       bigint;
    v_estado        text;
    v_concepto_id   bigint;
    v_concepto_nom  text;
    v_detalle       record;
    v_cnt_generados int := 0;
    v_cnt_omitidos  int := 0;
BEGIN
    IF p_servicio NOT IN ('Luz', 'Agua') THEN
        RAISE EXCEPTION 'Servicio inválido: "%". Use "Luz" o "Agua".', p_servicio;
    END IF;

    IF p_usuario IS NULL THEN
        p_usuario := auth.uid();
    END IF;

    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede aprobar distribuciones.';
    END IF;

    -- Nombre del concepto según servicio (catálogo en tabla conceptos)
    v_concepto_nom := p_servicio;  -- 'Luz' o 'Agua'

    SELECT id INTO v_concepto_id
    FROM public.conceptos
    WHERE nombre = v_concepto_nom AND deleted_at IS NULL
    LIMIT 1;

    IF v_concepto_id IS NULL THEN
        RAISE EXCEPTION 'Concepto "%" no encontrado en el catálogo de conceptos.', v_concepto_nom;
    END IF;

    -- Buscar encabezado
    SELECT id, estado INTO v_dist_id, v_estado
    FROM public.distribuciones_mensuales
    WHERE periodo_anio = p_anio
      AND periodo_mes  = p_mes
      AND servicio     = p_servicio;

    IF v_dist_id IS NULL THEN
        RAISE EXCEPTION
            'No existe distribución de % para %/%. Guarda al menos un borrador antes de aprobar.',
            p_servicio, p_anio, p_mes;
    END IF;

    IF v_estado = 'Aprobado' THEN
        RAISE EXCEPTION
            'La distribución de % %/% ya está Aprobada.', p_servicio, p_anio, p_mes;
    END IF;

    -- Generar montos_por_cobrar para cada detalle con monto > 0
    FOR v_detalle IN
        SELECT dd.puesto_id, dd.monto, dd.observacion
        FROM public.distribucion_detalles dd
        WHERE dd.distribucion_id = v_dist_id
          AND dd.monto > 0
    LOOP
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes,
             monto, estado, metodo_calculo, fecha_generacion, created_by, observacion)
        VALUES
            (v_detalle.puesto_id, v_concepto_id, p_anio, p_mes,
             v_detalle.monto, 'Pendiente', 'Manual',
             current_date, p_usuario,
             coalesce(v_detalle.observacion, 'Distribución manual ' || p_servicio || ' ' || p_anio || '/' || p_mes))
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
            DO NOTHING;

        IF FOUND THEN
            v_cnt_generados := v_cnt_generados + 1;
        ELSE
            v_cnt_omitidos := v_cnt_omitidos + 1;
        END IF;
    END LOOP;

    -- Marcar distribución como Aprobada
    UPDATE public.distribuciones_mensuales
    SET estado       = 'Aprobado',
        aprobado_at  = now(),
        aprobado_por = p_usuario,
        updated_at   = now()
    WHERE id = v_dist_id;

    RETURN jsonb_build_object(
        'distribucion_id',       v_dist_id,
        'servicio',              p_servicio,
        'periodo',               jsonb_build_object('anio', p_anio, 'mes', p_mes),
        'montos_generados',      v_cnt_generados,
        'montos_ya_existian',    v_cnt_omitidos
    );
END;
$$;

COMMENT ON FUNCTION public.aprobar_distribucion_mensual IS
    'Aprueba una distribución mensual de Luz/Agua: cambia estado a "Aprobado" y genera '
    'montos_por_cobrar (metodo_calculo="Manual") por cada detalle con monto > 0. '
    'Idempotente sobre montos_por_cobrar (ON CONFLICT DO NOTHING). Solo Administrador. (00045)';

GRANT EXECUTE ON FUNCTION public.aprobar_distribucion_mensual TO authenticated;


-- =============================================================================
-- 8. VERIFICACIÓN FINAL
-- =============================================================================
DO $$
DECLARE
    v_tbl_dist    boolean;
    v_tbl_det     boolean;
    v_rpc_guardar boolean;
    v_rpc_reset   boolean;
    v_rpc_aprobar boolean;
BEGIN
    SELECT EXISTS (
        SELECT 1 FROM information_schema.tables
        WHERE table_schema = 'public' AND table_name = 'distribuciones_mensuales'
    ) INTO v_tbl_dist;

    SELECT EXISTS (
        SELECT 1 FROM information_schema.tables
        WHERE table_schema = 'public' AND table_name = 'distribucion_detalles'
    ) INTO v_tbl_det;

    SELECT EXISTS (
        SELECT 1 FROM pg_proc p
        JOIN pg_namespace n ON n.oid = p.pronamespace
        WHERE n.nspname = 'public' AND p.proname = 'guardar_progreso_distribucion'
    ) INTO v_rpc_guardar;

    SELECT EXISTS (
        SELECT 1 FROM pg_proc p
        JOIN pg_namespace n ON n.oid = p.pronamespace
        WHERE n.nspname = 'public' AND p.proname = 'resetear_distribucion_mensual'
    ) INTO v_rpc_reset;

    SELECT EXISTS (
        SELECT 1 FROM pg_proc p
        JOIN pg_namespace n ON n.oid = p.pronamespace
        WHERE n.nspname = 'public' AND p.proname = 'aprobar_distribucion_mensual'
    ) INTO v_rpc_aprobar;

    IF NOT (v_tbl_dist AND v_tbl_det AND v_rpc_guardar AND v_rpc_reset AND v_rpc_aprobar) THEN
        RAISE EXCEPTION
            '00045 FALLO: tablas/RPCs faltantes. '
            'distribuciones_mensuales=% distribucion_detalles=% '
            'guardar=% resetear=% aprobar=%',
            v_tbl_dist, v_tbl_det, v_rpc_guardar, v_rpc_reset, v_rpc_aprobar;
    END IF;

    RAISE NOTICE '00045 ✓ Migración completada correctamente.';
END $$;

COMMIT;
