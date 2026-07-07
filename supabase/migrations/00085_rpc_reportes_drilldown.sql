-- =============================================================================
-- Migración 00085 — Central de Reportes v2: agregación server-side + drill-down
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Reemplaza los 5 queries PostgREST crudos de cargarReporteConsolidado() que
-- descargaban todas las filas del rango al navegador (sujetos al límite de
-- 1000 filas de PostgREST → totales anuales silenciosamente incompletos).
--
--   1. rpc_reporte_resumen          — KPIs de caja/banco + desglose por concepto
--                                     + egresos por categoría, en un solo JSON.
--   2. rpc_reporte_detalle_concepto — drill-down: líneas de ingreso (recibo,
--                                     pagador, puesto, periodo, monto, cajero).
--                                     p_concepto NULL → todas (export Excel).
--   3. rpc_reporte_detalle_egresos  — drill-down de gastos por categoría.
--
-- Convenciones:
--   · p_desde / p_hasta son fechas locales (America/Lima); las columnas
--     timestamptz se filtran con el intervalo [desde 00:00, hasta+1 00:00) Lima.
--   · Solo filas vigentes (deleted_at IS NULL) — los anulados no suman.
--   · p_tipo_pagador: 'todos' | 'socios' | 'inquilinos'. Los ingresos internos
--     (sin pagador) y la recaudación tarjeta (socios) respetan el filtro.
--   · Rol Administrador | Caja, SECURITY DEFINER (patrón del proyecto).
-- =============================================================================

BEGIN;

-- =============================================================================
-- 1. rpc_reporte_resumen
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_reporte_resumen(
    p_desde        date,
    p_hasta        date,
    p_tipo_pagador text DEFAULT 'todos'
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_ts_ini timestamptz;
    v_ts_fin timestamptz;
    v_caja   json;
    v_banco  json;
    v_conc   json;
    v_egr    json;
BEGIN
    IF public.get_my_rol() NOT IN ('Administrador', 'Caja') THEN
        RAISE EXCEPTION 'Acceso denegado.';
    END IF;
    IF p_tipo_pagador NOT IN ('todos', 'socios', 'inquilinos') THEN
        RAISE EXCEPTION 'p_tipo_pagador inválido: %. Usar todos | socios | inquilinos.', p_tipo_pagador;
    END IF;

    v_ts_ini := p_desde::timestamp AT TIME ZONE 'America/Lima';
    v_ts_fin := (p_hasta + 1)::timestamp AT TIME ZONE 'America/Lima';

    -- ── KPIs de caja ──────────────────────────────────────────────────────────
    SELECT json_build_object(
        'efectivo',            round(coalesce(pg.efectivo, 0) + coalesce(ii.efectivo, 0) + coalesce(rec.total, 0), 2),
        'transferencia',       round(coalesce(pg.transferencia, 0) + coalesce(ii.transferencia, 0), 2),
        'ingresos_internos',   round(coalesce(ii.total, 0), 2),
        'recaudacion_tarjeta', round(coalesce(rec.total, 0), 2),
        'egresos',             round(coalesce(g.total, 0), 2),
        'saldo',               round(coalesce(pg.efectivo, 0) + coalesce(pg.transferencia, 0)
                                     + coalesce(ii.total, 0) + coalesce(rec.total, 0)
                                     - coalesce(g.total, 0), 2),
        'count_recibos',       coalesce(pg.cnt, 0),
        'count_internos',      coalesce(ii.cnt, 0),
        'count_recaudacion',   coalesce(rec.cnt, 0),
        'count_anulados',      coalesce(pg.cnt_anulados, 0)
    )
    INTO v_caja
    FROM (
        SELECT
            sum(monto_total) FILTER (WHERE deleted_at IS NULL AND metodo_pago = 'Efectivo')  AS efectivo,
            sum(monto_total) FILTER (WHERE deleted_at IS NULL AND metodo_pago <> 'Efectivo') AS transferencia,
            count(*)         FILTER (WHERE deleted_at IS NULL)                               AS cnt,
            count(*)         FILTER (WHERE deleted_at IS NOT NULL)                           AS cnt_anulados
        FROM public.pagos p
        WHERE p.fecha_pago >= v_ts_ini AND p.fecha_pago < v_ts_fin
          AND (p_tipo_pagador = 'todos'
               OR (p_tipo_pagador = 'socios'     AND p.socio_id     IS NOT NULL)
               OR (p_tipo_pagador = 'inquilinos' AND p.inquilino_id IS NOT NULL))
    ) pg
    CROSS JOIN (
        SELECT
            sum(monto) FILTER (WHERE metodo_pago = 'Efectivo')  AS efectivo,
            sum(monto) FILTER (WHERE metodo_pago <> 'Efectivo') AS transferencia,
            sum(monto)                                          AS total,
            count(*)                                            AS cnt
        FROM public.ingresos_internos i
        WHERE i.deleted_at IS NULL
          AND i.fecha_ingreso >= v_ts_ini AND i.fecha_ingreso < v_ts_fin
          AND p_tipo_pagador = 'todos'
    ) ii
    CROSS JOIN (
        SELECT sum(monto) AS total, count(*) AS cnt
        FROM public.recaudacion_abonos r
        WHERE r.deleted_at IS NULL
          AND r.fecha >= v_ts_ini AND r.fecha < v_ts_fin
          AND p_tipo_pagador IN ('todos', 'socios')
    ) rec
    CROSS JOIN (
        SELECT sum(monto) AS total
        FROM public.gastos
        WHERE deleted_at IS NULL AND fecha BETWEEN p_desde AND p_hasta
    ) g;

    -- ── KPIs de banco (no dependen del filtro de pagador) ────────────────────
    SELECT json_build_object(
        'ingresos', round(coalesce(sum(monto) FILTER (WHERE tipo = 'Ingreso'), 0), 2),
        'egresos',  round(coalesce(sum(monto) FILTER (WHERE tipo = 'Egreso'), 0), 2),
        'saldo',    round(coalesce(sum(monto) FILTER (WHERE tipo = 'Ingreso'), 0)
                          - coalesce(sum(monto) FILTER (WHERE tipo = 'Egreso'), 0), 2),
        'count',    count(*)
    )
    INTO v_banco
    FROM public.movimientos_bancarios
    WHERE deleted_at IS NULL AND fecha_operacion BETWEEN p_desde AND p_hasta;

    -- ── Desglose por concepto (pagos + ingresos internos + recaudación) ──────
    SELECT coalesce(json_agg(t ORDER BY t.monto DESC), '[]'::json)
    INTO v_conc
    FROM (
        SELECT
            concepto,
            round(sum(monto), 2)             AS monto,
            sum(cantidad)::int               AS cantidad,
            round(sum(monto_socios), 2)      AS monto_socios,
            round(sum(monto_inquilinos), 2)  AS monto_inquilinos
        FROM (
            -- Conceptos cobrados en recibos
            SELECT
                coalesce(c.nombre, 'Sin concepto') AS concepto,
                dp.monto_aplicado                  AS monto,
                1                                  AS cantidad,
                CASE WHEN p.socio_id     IS NOT NULL THEN dp.monto_aplicado ELSE 0 END AS monto_socios,
                CASE WHEN p.inquilino_id IS NOT NULL THEN dp.monto_aplicado ELSE 0 END AS monto_inquilinos
            FROM public.pagos p
            JOIN public.detalle_pagos dp      ON dp.pago_id = p.id AND dp.deleted_at IS NULL
            JOIN public.montos_por_cobrar m   ON m.id = dp.monto_id
            LEFT JOIN public.conceptos c      ON c.id = m.concepto_id
            WHERE p.deleted_at IS NULL
              AND p.fecha_pago >= v_ts_ini AND p.fecha_pago < v_ts_fin
              AND (p_tipo_pagador = 'todos'
                   OR (p_tipo_pagador = 'socios'     AND p.socio_id     IS NOT NULL)
                   OR (p_tipo_pagador = 'inquilinos' AND p.inquilino_id IS NOT NULL))

            UNION ALL

            -- Ingresos internos (solo con filtro 'todos': no tienen pagador)
            SELECT
                coalesce(c.nombre, 'Sin concepto'), i.monto, 1, 0, 0
            FROM public.ingresos_internos i
            LEFT JOIN public.conceptos c ON c.id = i.concepto_id
            WHERE i.deleted_at IS NULL
              AND i.fecha_ingreso >= v_ts_ini AND i.fecha_ingreso < v_ts_fin
              AND p_tipo_pagador = 'todos'

            UNION ALL

            -- Recaudación semanal por tarjeta (prepago de socios)
            SELECT
                'Recaudación Tarjeta', r.monto, 1, r.monto, 0
            FROM public.recaudacion_abonos r
            WHERE r.deleted_at IS NULL
              AND r.fecha >= v_ts_ini AND r.fecha < v_ts_fin
              AND p_tipo_pagador IN ('todos', 'socios')
        ) lineas
        GROUP BY concepto
    ) t;

    -- ── Egresos por categoría ─────────────────────────────────────────────────
    SELECT coalesce(json_agg(t ORDER BY t.monto DESC), '[]'::json)
    INTO v_egr
    FROM (
        SELECT
            coalesce(cg.nombre, 'Sin categoría') AS categoria,
            round(sum(g.monto), 2)               AS monto,
            count(*)::int                        AS cantidad
        FROM public.gastos g
        LEFT JOIN public.categorias_gasto cg ON cg.id = g.categoria_gasto_id
        WHERE g.deleted_at IS NULL AND g.fecha BETWEEN p_desde AND p_hasta
        GROUP BY coalesce(cg.nombre, 'Sin categoría')
    ) t;

    RETURN json_build_object(
        'caja',                  v_caja,
        'banco',                 v_banco,
        'por_concepto',          v_conc,
        'egresos_por_categoria', v_egr
    );
END;
$$;

COMMENT ON FUNCTION public.rpc_reporte_resumen(date, date, text) IS
    'Central de Reportes: KPIs de caja/banco + desglose por concepto + egresos '
    'por categoría del rango, agregados server-side (evita el límite de 1000 '
    'filas de PostgREST y minimiza egress). Rol Admin|Caja. (00085)';

GRANT EXECUTE ON FUNCTION public.rpc_reporte_resumen(date, date, text) TO authenticated;

-- =============================================================================
-- 2. rpc_reporte_detalle_concepto — drill-down de ingresos
--    p_concepto NULL → todas las líneas del rango (exportación Excel).
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_reporte_detalle_concepto(
    p_desde        date,
    p_hasta        date,
    p_concepto     text DEFAULT NULL,
    p_tipo_pagador text DEFAULT 'todos'
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_ts_ini timestamptz;
    v_ts_fin timestamptz;
    v_result json;
BEGIN
    IF public.get_my_rol() NOT IN ('Administrador', 'Caja') THEN
        RAISE EXCEPTION 'Acceso denegado.';
    END IF;
    IF p_tipo_pagador NOT IN ('todos', 'socios', 'inquilinos') THEN
        RAISE EXCEPTION 'p_tipo_pagador inválido: %.', p_tipo_pagador;
    END IF;

    v_ts_ini := p_desde::timestamp AT TIME ZONE 'America/Lima';
    v_ts_fin := (p_hasta + 1)::timestamp AT TIME ZONE 'America/Lima';

    SELECT coalesce(json_agg(l ORDER BY l.fecha_pago DESC), '[]'::json)
    INTO v_result
    FROM (
        -- Líneas de recibos (una por detalle de pago)
        SELECT
            p.fecha_pago,
            p.codigo_transaccion,
            coalesce(c.nombre, 'Sin concepto')                       AS concepto,
            coalesce(s.apellidos || ', ' || s.nombres,
                     i.apellidos || ', ' || i.nombres, '—')          AS pagador,
            CASE WHEN p.socio_id IS NOT NULL THEN 'socio'
                 ELSE 'inquilino' END                                 AS tipo_pagador,
            coalesce(pu.codigo_puesto, '—')                          AS codigo_puesto,
            m.periodo_anio || '/' || lpad(m.periodo_mes::text, 2, '0') AS periodo,
            round(dp.monto_aplicado, 2)                              AS monto,
            p.metodo_pago,
            coalesce(pf.nombres, pf.email, '—')                      AS cajero
        FROM public.pagos p
        JOIN public.detalle_pagos dp    ON dp.pago_id = p.id AND dp.deleted_at IS NULL
        JOIN public.montos_por_cobrar m ON m.id = dp.monto_id
        LEFT JOIN public.conceptos c    ON c.id = m.concepto_id
        LEFT JOIN public.puestos pu     ON pu.id = m.puesto_id
        LEFT JOIN public.socios s       ON s.id = p.socio_id
        LEFT JOIN public.inquilinos i   ON i.id = p.inquilino_id
        LEFT JOIN public.perfiles pf    ON pf.id = p.created_by
        WHERE p.deleted_at IS NULL
          AND p.fecha_pago >= v_ts_ini AND p.fecha_pago < v_ts_fin
          AND (p_concepto IS NULL OR coalesce(c.nombre, 'Sin concepto') = p_concepto)
          AND (p_tipo_pagador = 'todos'
               OR (p_tipo_pagador = 'socios'     AND p.socio_id     IS NOT NULL)
               OR (p_tipo_pagador = 'inquilinos' AND p.inquilino_id IS NOT NULL))

        UNION ALL

        -- Ingresos internos (sin recibo, solo 'todos')
        SELECT
            i.fecha_ingreso,
            'INT-' || lpad(i.id::text, 6, '0'),
            coalesce(c.nombre, 'Sin concepto'),
            coalesce(nullif(trim(i.observacion), ''), 'Ingreso interno'),
            'interno',
            '—',
            to_char(i.fecha_ingreso AT TIME ZONE 'America/Lima', 'YYYY/MM'),
            round(i.monto, 2),
            i.metodo_pago,
            coalesce(pf.nombres, pf.email, '—')
        FROM public.ingresos_internos i
        LEFT JOIN public.conceptos c ON c.id = i.concepto_id
        LEFT JOIN public.perfiles pf ON pf.id = i.created_by
        WHERE i.deleted_at IS NULL
          AND i.fecha_ingreso >= v_ts_ini AND i.fecha_ingreso < v_ts_fin
          AND p_tipo_pagador = 'todos'
          AND (p_concepto IS NULL OR coalesce(c.nombre, 'Sin concepto') = p_concepto)

        UNION ALL

        -- Recaudación semanal por tarjeta
        SELECT
            r.fecha,
            'REC-' || lpad(r.id::text, 6, '0'),
            'Recaudación Tarjeta',
            coalesce(s.apellidos || ', ' || s.nombres, '—'),
            'socio',
            '—',
            to_char(r.fecha AT TIME ZONE 'America/Lima', 'YYYY/MM'),
            round(r.monto, 2),
            'Efectivo',
            '—'
        FROM public.recaudacion_abonos r
        LEFT JOIN public.socios s ON s.id = r.socio_id
        WHERE r.deleted_at IS NULL
          AND r.fecha >= v_ts_ini AND r.fecha < v_ts_fin
          AND p_tipo_pagador IN ('todos', 'socios')
          AND (p_concepto IS NULL OR p_concepto = 'Recaudación Tarjeta')
    ) l (fecha_pago, codigo_transaccion, concepto, pagador, tipo_pagador,
         codigo_puesto, periodo, monto, metodo_pago, cajero);

    RETURN v_result;
END;
$$;

COMMENT ON FUNCTION public.rpc_reporte_detalle_concepto(date, date, text, text) IS
    'Central de Reportes: líneas de ingreso del rango (drill-down por concepto). '
    'p_concepto NULL devuelve todas las líneas (exportación Excel). Incluye '
    'recibos, ingresos internos y recaudación tarjeta. Rol Admin|Caja. (00085)';

GRANT EXECUTE ON FUNCTION public.rpc_reporte_detalle_concepto(date, date, text, text) TO authenticated;

-- =============================================================================
-- 3. rpc_reporte_detalle_egresos — drill-down de gastos
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_reporte_detalle_egresos(
    p_desde     date,
    p_hasta     date,
    p_categoria text DEFAULT NULL
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_result json;
BEGIN
    IF public.get_my_rol() NOT IN ('Administrador', 'Caja') THEN
        RAISE EXCEPTION 'Acceso denegado.';
    END IF;

    SELECT coalesce(json_agg(t ORDER BY t.fecha DESC, t.id DESC), '[]'::json)
    INTO v_result
    FROM (
        SELECT
            g.id,
            g.fecha,
            coalesce(cg.nombre, 'Sin categoría') AS categoria,
            g.descripcion,
            g.comprobante_ref,
            g.responsable,
            round(g.monto, 2)                    AS monto
        FROM public.gastos g
        LEFT JOIN public.categorias_gasto cg ON cg.id = g.categoria_gasto_id
        WHERE g.deleted_at IS NULL
          AND g.fecha BETWEEN p_desde AND p_hasta
          AND (p_categoria IS NULL OR coalesce(cg.nombre, 'Sin categoría') = p_categoria)
    ) t;

    RETURN v_result;
END;
$$;

COMMENT ON FUNCTION public.rpc_reporte_detalle_egresos(date, date, text) IS
    'Central de Reportes: líneas de gastos del rango (drill-down por categoría). '
    'Rol Admin|Caja. (00085)';

GRANT EXECUTE ON FUNCTION public.rpc_reporte_detalle_egresos(date, date, text) TO authenticated;

COMMIT;
