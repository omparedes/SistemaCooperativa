-- =============================================================================
-- Migración 00060 — Vistas para Filtros del Dashboard
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- =============================================================================

BEGIN;

-- 1. Recreación de vw_recaudacion_mensual con la columna tipo_pagador
DROP VIEW IF EXISTS public.vw_recaudacion_mensual CASCADE;

CREATE OR REPLACE VIEW public.vw_recaudacion_mensual
WITH (security_invoker = true) AS
SELECT
    EXTRACT(year  FROM p.fecha_pago)::smallint AS anio,
    EXTRACT(month FROM p.fecha_pago)::smallint AS mes,
    c.id   AS concepto_id,
    c.nombre AS concepto,
    c.tipo  AS concepto_tipo,
    CASE 
        WHEN p.socio_id IS NOT NULL THEN 'socio'
        WHEN p.inquilino_id IS NOT NULL THEN 'inquilino'
        ELSE 'otros'
    END AS tipo_pagador,
    COUNT(DISTINCT p.id)             AS cantidad_pagos,
    SUM(d.monto_aplicado)::numeric(14,2) AS total_recaudado,
    COUNT(DISTINCT p.id) FILTER (WHERE p.metodo_pago = 'Efectivo')        AS pagos_efectivo,
    COUNT(DISTINCT p.id) FILTER (WHERE p.metodo_pago = 'Transferencia')   AS pagos_transferencia,
    SUM(d.monto_aplicado) FILTER (WHERE p.metodo_pago = 'Efectivo')::numeric(14,2)      AS recaudado_efectivo,
    SUM(d.monto_aplicado) FILTER (WHERE p.metodo_pago = 'Transferencia')::numeric(14,2) AS recaudado_transferencia
FROM public.pagos p
JOIN public.detalle_pagos    d ON d.pago_id  = p.id AND d.deleted_at IS NULL
JOIN public.montos_por_cobrar m ON m.id      = d.monto_id
JOIN public.conceptos        c ON c.id      = m.concepto_id
WHERE p.deleted_at IS NULL
GROUP BY anio, mes, c.id, c.nombre, c.tipo, tipo_pagador
ORDER BY anio DESC, mes DESC, total_recaudado DESC;

COMMENT ON VIEW public.vw_recaudacion_mensual IS
    'Recaudación agrupada por año, mes, concepto y origen (tipo_pagador: socio, inquilino, otros).';

-- 2. Nueva vista vw_deuda_filtrada
DROP VIEW IF EXISTS public.vw_deuda_filtrada CASCADE;

CREATE OR REPLACE VIEW public.vw_deuda_filtrada
WITH (security_invoker = true) AS
SELECT 
    m.id AS monto_id,
    m.puesto_id,
    m.socio_id,
    m.monto,
    m.estado,
    m.deleted_at,
    CASE
        WHEN m.puesto_id IS NOT NULL AND EXISTS (
            SELECT 1 FROM public.historial_arriendos ha 
            WHERE ha.puesto_id = m.puesto_id AND ha.fecha_fin IS NULL
        ) THEN 'inquilino'
        WHEN m.socio_id IS NOT NULL OR m.puesto_id IS NOT NULL THEN 'socio'
        ELSE 'otros'
    END AS tipo_deudor,
    m.monto - COALESCE(
        (SELECT SUM(d.monto_aplicado) FROM public.detalle_pagos d WHERE d.monto_id = m.id AND d.deleted_at IS NULL), 
        0
    ) AS saldo
FROM public.montos_por_cobrar m
WHERE m.deleted_at IS NULL AND m.estado <> 'Cancelado';

COMMENT ON VIEW public.vw_deuda_filtrada IS
    'Desglose individual de saldos pendientes de cobro clasificados por tipo de deudor (socio o inquilino según el arriendo vigente).';

-- 3. Nueva vista vw_morosos_filtrados
DROP VIEW IF EXISTS public.vw_morosos_filtrados CASCADE;

CREATE OR REPLACE VIEW public.vw_morosos_filtrados
WITH (security_invoker = true) AS
WITH periodo_actual AS (
    SELECT
        EXTRACT(year  FROM CURRENT_DATE)::int AS anio,
        EXTRACT(month FROM CURRENT_DATE)::int AS mes
),
deudas_vencidas AS (
    -- (a) Deudas del puesto asociadas a Socios (ocupación titular actual y sin arriendo vigente)
    SELECT
        ht.socio_id AS persona_id,
        'socio' AS persona_tipo,
        m.id AS monto_id,
        m.periodo_anio,
        m.periodo_mes,
        m.monto - COALESCE(
            (SELECT SUM(d.monto_aplicado) FROM public.detalle_pagos d WHERE d.monto_id = m.id AND d.deleted_at IS NULL),
            0
        ) AS saldo
    FROM public.montos_por_cobrar m
    JOIN public.historial_titularidad ht ON ht.puesto_id = m.puesto_id AND ht.fecha_fin IS NULL
    WHERE m.deleted_at IS NULL
      AND m.puesto_id IS NOT NULL
      AND m.estado <> 'Cancelado'
      AND NOT EXISTS (
          SELECT 1 FROM public.historial_arriendos ha 
          WHERE ha.puesto_id = m.puesto_id AND ha.fecha_fin IS NULL
      )
      AND (m.periodo_anio < (SELECT anio FROM periodo_actual)
           OR (m.periodo_anio = (SELECT anio FROM periodo_actual) AND m.periodo_mes < (SELECT mes FROM periodo_actual)))
    
    UNION ALL

    -- (b) Deudas del puesto asociadas a Inquilinos (arriendo vigente)
    SELECT
        ha.inquilino_id AS persona_id,
        'inquilino' AS persona_tipo,
        m.id AS monto_id,
        m.periodo_anio,
        m.periodo_mes,
        m.monto - COALESCE(
            (SELECT SUM(d.monto_aplicado) FROM public.detalle_pagos d WHERE d.monto_id = m.id AND d.deleted_at IS NULL),
            0
        ) AS saldo
    FROM public.montos_por_cobrar m
    JOIN public.historial_arriendos ha ON ha.puesto_id = m.puesto_id AND ha.fecha_fin IS NULL
    WHERE m.deleted_at IS NULL
      AND m.puesto_id IS NOT NULL
      AND m.estado <> 'Cancelado'
      AND (m.periodo_anio < (SELECT anio FROM periodo_actual)
           OR (m.periodo_anio = (SELECT anio FROM periodo_actual) AND m.periodo_mes < (SELECT mes FROM periodo_actual)))

    UNION ALL

    -- (c) Deudas personales de socios (multas, aportes extraordinarios)
    SELECT
        m.socio_id AS persona_id,
        'socio' AS persona_tipo,
        m.id AS monto_id,
        m.periodo_anio,
        m.periodo_mes,
        m.monto - COALESCE(
            (SELECT SUM(d.monto_aplicado) FROM public.detalle_pagos d WHERE d.monto_id = m.id AND d.deleted_at IS NULL),
            0
        ) AS saldo
    FROM public.montos_por_cobrar m
    WHERE m.deleted_at IS NULL
      AND m.socio_id IS NOT NULL
      AND m.estado <> 'Cancelado'
      AND (m.periodo_anio < (SELECT anio FROM periodo_actual)
           OR (m.periodo_anio = (SELECT anio FROM periodo_actual) AND m.periodo_mes < (SELECT mes FROM periodo_actual)))
),
deudas_agrupadas AS (
    SELECT 
        persona_id,
        persona_tipo,
        monto_id,
        periodo_anio,
        periodo_mes,
        saldo
    FROM deudas_vencidas
    WHERE saldo > 0
)
SELECT
    da.persona_id,
    da.persona_tipo,
    CASE 
        WHEN da.persona_tipo = 'socio' THEN s.dni
        ELSE i.dni
    END AS dni,
    CASE 
        WHEN da.persona_tipo = 'socio' THEN s.apellidos
        ELSE i.apellidos
    END AS apellidos,
    CASE 
        WHEN da.persona_tipo = 'socio' THEN s.nombres
        ELSE i.nombres
    END AS nombres,
    p.codigo_puesto AS puesto_actual_codigo,
    COUNT(DISTINCT da.monto_id) AS cantidad_deudas_vencidas,
    SUM(da.saldo)::numeric(14,2) AS monto_total_vencido,
    MIN(da.periodo_anio * 100 + da.periodo_mes) AS periodo_mas_antiguo_yyyymm
FROM deudas_agrupadas da
LEFT JOIN public.socios s ON da.persona_tipo = 'socio' AND s.id = da.persona_id
LEFT JOIN public.inquilinos i ON da.persona_tipo = 'inquilino' AND i.id = da.persona_id
LEFT JOIN public.historial_titularidad ht ON da.persona_tipo = 'socio' AND ht.socio_id = s.id AND ht.fecha_fin IS NULL
LEFT JOIN public.historial_arriendos ha ON da.persona_tipo = 'inquilino' AND ha.inquilino_id = i.id AND ha.fecha_fin IS NULL
LEFT JOIN public.puestos p ON p.id = COALESCE(ht.puesto_id, ha.puesto_id)
WHERE (da.persona_tipo = 'socio' AND s.deleted_at IS NULL)
   OR (da.persona_tipo = 'inquilino' AND i.deleted_at IS NULL)
GROUP BY da.persona_id, da.persona_tipo, s.dni, s.apellidos, s.nombres, i.dni, i.apellidos, i.nombres, p.codigo_puesto;

COMMENT ON VIEW public.vw_morosos_filtrados IS
    'Socios e Inquilinos con ≥ 1 deuda vencida acumulada, listos para filtrado unificado en el Dashboard.';

-- 4. Otorgar permisos
GRANT SELECT ON public.vw_recaudacion_mensual TO authenticated, anon;
GRANT SELECT ON public.vw_deuda_filtrada TO authenticated, anon;
GRANT SELECT ON public.vw_morosos_filtrados TO authenticated, anon;

COMMIT;
