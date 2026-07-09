-- =============================================================================
-- Migración 00087 — Dashboard Ejecutivo + Módulo de Asambleas (Padrón Electoral)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
--   1. rpc_dashboard_ejecutivo — un solo JSON para el panel visual del dashboard:
--      ingresos vs egresos del mes en curso (delegado a rpc_reporte_resumen,
--      misma fuente que la Central de Reportes), nivel de morosidad y ranking
--      de deuda pendiente por concepto.
--   2. asistencias_asamblea — registro de asistencia del padrón electoral,
--      con la condición de habilidad (deuda = 0) congelada al momento del
--      registro. Única por socio y fecha. RLS Admin|Caja + auditoría.
-- =============================================================================

BEGIN;

-- =============================================================================
-- 1. rpc_dashboard_ejecutivo
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_dashboard_ejecutivo()
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_hoy        date := (now() AT TIME ZONE 'America/Lima')::date;
    v_desde      date := date_trunc('month', (now() AT TIME ZONE 'America/Lima'))::date;
    v_resumen    json;
    v_morosidad  json;
    v_conceptos  json;
BEGIN
    IF public.get_my_rol() NOT IN ('Administrador', 'Caja') THEN
        RAISE EXCEPTION 'Acceso denegado.';
    END IF;

    -- ── Mes en curso: misma fuente que la Central de Reportes (00085) ────────
    v_resumen := public.rpc_reporte_resumen(v_desde, v_hoy, 'todos');

    -- ── Morosidad: personas con deuda vencida vs padrón activo ───────────────
    SELECT json_build_object(
        'personas_con_deuda', (SELECT count(*) FROM public.vw_morosos_filtrados),
        'total_personas',
            (SELECT count(*) FROM public.socios
             WHERE deleted_at IS NULL AND estado = 'Activo')
          + (SELECT count(*) FROM public.inquilinos WHERE deleted_at IS NULL),
        'deuda_total', (
            SELECT round(coalesce(sum(mc.monto - pag.ya_pagado), 0), 2)
            FROM public.montos_por_cobrar mc
            CROSS JOIN LATERAL (
                SELECT coalesce(sum(dp.monto_aplicado), 0) AS ya_pagado
                FROM public.detalle_pagos dp
                WHERE dp.monto_id = mc.id AND dp.deleted_at IS NULL
            ) pag
            WHERE mc.deleted_at IS NULL
              AND mc.estado <> 'Cancelado'
              AND mc.monto - pag.ya_pagado > 0
        )
    ) INTO v_morosidad;

    -- ── Ranking: conceptos con mayor deuda pendiente ─────────────────────────
    SELECT coalesce(json_agg(t ORDER BY t.monto DESC), '[]'::json)
    INTO v_conceptos
    FROM (
        SELECT
            coalesce(c.nombre, 'Sin concepto') AS concepto,
            round(sum(mc.monto - pag.ya_pagado), 2) AS monto,
            count(*)::int AS cantidad
        FROM public.montos_por_cobrar mc
        LEFT JOIN public.conceptos c ON c.id = mc.concepto_id
        CROSS JOIN LATERAL (
            SELECT coalesce(sum(dp.monto_aplicado), 0) AS ya_pagado
            FROM public.detalle_pagos dp
            WHERE dp.monto_id = mc.id AND dp.deleted_at IS NULL
        ) pag
        WHERE mc.deleted_at IS NULL
          AND mc.estado <> 'Cancelado'
          AND mc.monto - pag.ya_pagado > 0
        GROUP BY coalesce(c.nombre, 'Sin concepto')
        ORDER BY 2 DESC
        LIMIT 8
    ) t;

    RETURN json_build_object(
        'mes', json_build_object(
            'desde',    v_desde,
            'hasta',    v_hoy,
            'ingresos', (v_resumen->'caja'->>'efectivo')::numeric
                      + (v_resumen->'caja'->>'transferencia')::numeric,
            'egresos',  (v_resumen->'caja'->>'egresos')::numeric
        ),
        'morosidad',          v_morosidad,
        'deuda_por_concepto', v_conceptos
    );
END;
$$;

COMMENT ON FUNCTION public.rpc_dashboard_ejecutivo() IS
    'Dashboard ejecutivo: ingresos vs egresos del mes (delegado a rpc_reporte_resumen), '
    'nivel de morosidad y ranking de deuda pendiente por concepto, en un solo JSON. '
    'Rol Admin|Caja. (00087)';

GRANT EXECUTE ON FUNCTION public.rpc_dashboard_ejecutivo() TO authenticated;

-- =============================================================================
-- 2. asistencias_asamblea — Padrón Electoral
-- =============================================================================
CREATE TABLE IF NOT EXISTS public.asistencias_asamblea (
    id               bigserial     PRIMARY KEY,
    socio_id         bigint        NOT NULL REFERENCES public.socios(id),
    fecha_asamblea   date          NOT NULL DEFAULT (now() AT TIME ZONE 'America/Lima')::date,
    habil            boolean       NOT NULL,
    deuda_al_momento numeric(12,2) NOT NULL DEFAULT 0 CHECK (deuda_al_momento >= 0),
    created_by       uuid          REFERENCES auth.users(id),
    created_at       timestamptz   NOT NULL DEFAULT now(),
    UNIQUE (socio_id, fecha_asamblea)
);

COMMENT ON TABLE public.asistencias_asamblea IS
    'Registro de asistencia a asambleas. La habilidad (deuda = 0) queda congelada '
    'al momento del registro como evidencia del padrón electoral. (00087)';

CREATE INDEX IF NOT EXISTS idx_asistencias_asamblea_fecha
    ON public.asistencias_asamblea (fecha_asamblea);

-- RLS: solo Administrador y Caja operan el padrón electoral.
ALTER TABLE public.asistencias_asamblea ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS pol_asistencias_select ON public.asistencias_asamblea;
CREATE POLICY pol_asistencias_select ON public.asistencias_asamblea
    FOR SELECT TO authenticated
    USING (public.get_my_rol() IN ('Administrador', 'Caja'));

DROP POLICY IF EXISTS pol_asistencias_insert ON public.asistencias_asamblea;
CREATE POLICY pol_asistencias_insert ON public.asistencias_asamblea
    FOR INSERT TO authenticated
    WITH CHECK (public.get_my_rol() IN ('Administrador', 'Caja'));
-- Sin policies de UPDATE/DELETE: el registro de asistencia es inmutable.

-- Auditoría: cada registro de asistencia queda en el timeline.
DROP TRIGGER IF EXISTS trg_audit_asistencias_asamblea ON public.asistencias_asamblea;
CREATE TRIGGER trg_audit_asistencias_asamblea
    AFTER INSERT OR UPDATE OR DELETE ON public.asistencias_asamblea
    FOR EACH ROW EXECUTE FUNCTION public.log_audit_action();

COMMIT;
