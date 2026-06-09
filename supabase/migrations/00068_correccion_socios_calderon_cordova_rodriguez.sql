BEGIN;

-- =============================================================================
-- 1. Modificar vw_deuda_filtrada para clasificar Alquiler (concepto_id = 11) como 'inquilino'
-- =============================================================================
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
        WHEN m.concepto_id = 11 THEN 'inquilino'::text -- Alquiler siempre es del inquilino
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


-- =============================================================================
-- 2. Modificar vw_morosos_filtrados para excluir concepto_id = 11 (Alquiler) de los socios
-- =============================================================================
DROP VIEW IF EXISTS public.vw_morosos_filtrados CASCADE;

CREATE OR REPLACE VIEW public.vw_morosos_filtrados
WITH (security_invoker = true) AS
WITH period_actual AS (
    SELECT
        EXTRACT(year  FROM CURRENT_DATE)::int AS anio,
        EXTRACT(month FROM CURRENT_DATE)::int AS mes
),
deudas_vencidas AS (
    -- (a) Deudas del puesto asociadas a Socios (ocupación titular actual, sin arriendo vigente y excluyendo Alquiler)
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
      AND m.concepto_id <> 11 -- Excluir Alquiler para socios
      AND m.estado <> 'Cancelado'
      AND NOT EXISTS (
          SELECT 1 FROM public.historial_arriendos ha 
          WHERE ha.puesto_id = m.puesto_id AND ha.fecha_fin IS NULL
      )
      AND (m.periodo_anio < (SELECT anio FROM period_actual)
           OR (m.periodo_anio = (SELECT anio FROM period_actual) AND m.periodo_mes < (SELECT mes FROM period_actual)))
    
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
      AND (m.periodo_anio < (SELECT anio FROM period_actual)
           OR (m.periodo_anio = (SELECT anio FROM period_actual) AND m.periodo_mes < (SELECT mes FROM period_actual)))

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
      AND (m.periodo_anio < (SELECT anio FROM period_actual)
           OR (m.periodo_anio = (SELECT anio FROM period_actual) AND m.periodo_mes < (SELECT mes FROM period_actual)))
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


-- =============================================================================
-- 3. Modificar rpc_cc_listar_personas() para excluir Alquiler (concepto_id = 11) de los socios
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_cc_listar_personas()
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  result json;
BEGIN
  IF public.get_my_rol() NOT IN ('Administrador', 'Caja') THEN
    RAISE EXCEPTION 'Acceso denegado.';
  END IF;

  SELECT coalesce(json_agg(t ORDER BY t.tipo, t.nombre), '[]'::json)
  INTO result
  FROM (

    -- ── SOCIOS ────────────────────────────────────────────────────────────────
    SELECT
      'socio'::text                   AS tipo,
      s.id,
      s.apellidos                     AS nombre,
      s.dni,
      s.estado,
      s.habilitado,
      s.saldo_a_favor,
      p.codigo_puesto,
      p.id                            AS puesto_id,
      coalesce(
        (
          SELECT sum(
            mc.monto - coalesce(
              (
                SELECT sum(dp.monto_aplicado)
                FROM   public.detalle_pagos dp
                WHERE  dp.monto_id = mc.id
                  AND  dp.deleted_at IS NULL
              ), 0
            )
          )
          FROM   public.montos_por_cobrar mc
          WHERE  mc.deleted_at IS NULL
            AND  mc.estado = 'Pendiente'
            AND  ( (mc.puesto_id = p.id AND mc.concepto_id <> 11) OR mc.socio_id = s.id )
        ), 0
      )                               AS deuda_pendiente
    FROM public.socios s
    LEFT JOIN public.historial_titularidad ht
           ON ht.socio_id = s.id AND ht.fecha_fin IS NULL
    LEFT JOIN public.puestos p ON p.id = ht.puesto_id
    WHERE s.deleted_at IS NULL

    UNION ALL

    -- ── INQUILINOS ────────────────────────────────────────────────────────────
    SELECT
      'inquilino'::text               AS tipo,
      i.id,
      i.apellidos                     AS nombre,
      i.dni,
      'Activo'::text                  AS estado,
      NULL::boolean                   AS habilitado,
      i.saldo_a_favor,
      p.codigo_puesto,
      p.id                            AS puesto_id,
      coalesce(
        (
          SELECT sum(
            mc.monto - coalesce(
              (
                SELECT sum(dp.monto_aplicado)
                FROM   public.detalle_pagos dp
                WHERE  dp.monto_id = mc.id
                  AND  dp.deleted_at IS NULL
              ), 0
            )
          )
          FROM   public.montos_por_cobrar mc
          WHERE  mc.deleted_at IS NULL
            AND  mc.estado = 'Pendiente'
            AND  mc.puesto_id = p.id
        ), 0
      )                               AS deuda_pendiente
    FROM public.inquilinos i
    LEFT JOIN public.historial_arriendos ha
           ON ha.inquilino_id = i.id AND ha.fecha_fin IS NULL
    LEFT JOIN public.puestos p ON p.id = ha.puesto_id
    WHERE i.deleted_at IS NULL

  ) t;

  RETURN result;
END;
$$;


-- =============================================================================
-- 4. Modificar rpc_cc_detalle_persona() para excluir Alquiler (concepto_id = 11) de los socios
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_cc_detalle_persona(
  p_tipo text,
  p_id   bigint
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_puesto_id  bigint;
  v_persona    json;
  v_deudas     json;
  v_pagos      json;
BEGIN
  IF public.get_my_rol() NOT IN ('Administrador', 'Caja') THEN
    RAISE EXCEPTION 'Acceso denegado.';
  END IF;

  IF p_tipo NOT IN ('socio', 'inquilino') THEN
    RAISE EXCEPTION 'Tipo inválido: %. Usar socio o inquilino.', p_tipo;
  END IF;

  -- ── Persona + puesto ──────────────────────────────────────────────────────
  IF p_tipo = 'socio' THEN
    SELECT
      row_to_json(t) INTO v_persona
    FROM (
      SELECT
        'socio'    AS tipo,
        s.id,
        s.apellidos AS nombre,
        s.dni,
        s.estado,
        s.habilitado,
        s.saldo_a_favor,
        p.codigo_puesto,
        p.id       AS puesto_id
      FROM public.socios s
      LEFT JOIN public.historial_titularidad ht
             ON ht.socio_id = s.id AND ht.fecha_fin IS NULL
      LEFT JOIN public.puestos p ON p.id = ht.puesto_id
      WHERE s.id = p_id AND s.deleted_at IS NULL
    ) t;

    v_puesto_id := (v_persona->>'puesto_id')::bigint;

    -- Deudas: tanto las del puesto (sin alquiler) como las personales del socio
    SELECT COALESCE(json_agg(d ORDER BY d.periodo_anio, d.periodo_mes), '[]'::json)
    INTO v_deudas
    FROM (
      SELECT
        mc.id,
        COALESCE(c.nombre, 'Sin concepto')   AS concepto,
        mc.periodo_anio,
        mc.periodo_mes,
        mc.monto,
        mc.estado,
        mc.fecha_generacion,
        mc.observacion,
        COALESCE(
          (
            SELECT SUM(dp.monto_aplicado)
            FROM   public.detalle_pagos dp
            JOIN   public.pagos pg ON pg.id = dp.pago_id
            WHERE  dp.monto_id    = mc.id
              AND  dp.deleted_at  IS NULL
              AND  pg.deleted_at  IS NULL
          ), 0
        )                                    AS ya_pagado
      FROM public.montos_por_cobrar mc
      JOIN public.conceptos c ON c.id = mc.concepto_id
      WHERE mc.deleted_at IS NULL
        AND mc.estado     != 'Cancelado'
        AND ( (mc.puesto_id = v_puesto_id AND mc.concepto_id <> 11) OR mc.socio_id = p_id )
    ) d;

  ELSE
    -- inquilino
    SELECT
      row_to_json(t) INTO v_persona
    FROM (
      SELECT
        'inquilino' AS tipo,
        i.id,
        i.apellidos  AS nombre,
        i.dni,
        'Activo'     AS estado,
        NULL         AS habilitado,
        i.saldo_a_favor,
        p.codigo_puesto,
        p.id         AS puesto_id
      FROM public.inquilinos i
      LEFT JOIN public.historial_arriendos ha
             ON ha.inquilino_id = i.id AND ha.fecha_fin IS NULL
      LEFT JOIN public.puestos p ON p.id = ha.puesto_id
      WHERE i.id = p_id AND i.deleted_at IS NULL
    ) t;

    v_puesto_id := (v_persona->>'puesto_id')::bigint;

    SELECT COALESCE(json_agg(d ORDER BY d.periodo_anio, d.periodo_mes), '[]'::json)
    INTO v_deudas
    FROM (
      SELECT
        mc.id,
        COALESCE(c.nombre, 'Sin concepto') AS concepto,
        mc.periodo_anio,
        mc.periodo_mes,
        mc.monto,
        mc.estado,
        mc.fecha_generacion,
        mc.observacion,
        COALESCE(
          (
            SELECT SUM(dp.monto_aplicado)
            FROM   public.detalle_pagos dp
            JOIN   public.pagos pg ON pg.id = dp.pago_id
            WHERE  dp.monto_id   = mc.id
              and  dp.deleted_at IS NULL
              and  pg.deleted_at IS NULL
          ), 0
        )                                  AS ya_pagado
      FROM public.montos_por_cobrar mc
      JOIN public.conceptos c ON c.id = mc.concepto_id
      WHERE mc.deleted_at IS NULL
        AND mc.estado     != 'Cancelado'
        AND mc.puesto_id  = v_puesto_id
    ) d;
  END IF;

  -- ── Historial de pagos ────────────────────────────────────────────────────
  DECLARE
    v_col text := CASE p_tipo WHEN 'socio' THEN 'socio_id' ELSE 'inquilino_id' END;
    v_hist_pagos json;
  BEGIN
    EXECUTE FORMAT(
      $sql$
      SELECT COALESCE(json_agg(pg ORDER BY pg.fecha_pago DESC), '[]'::json)
      FROM (
        SELECT
          p.id,
          p.codigo_transaccion,
          p.fecha_pago,
          p.monto_total,
          p.metodo_pago,
          p.comprobante,
          p.observacion,
          COALESCE(
            json_agg(
              json_build_object(
                'concepto', c.nombre,
                'monto_aplicado', dp.monto_aplicado
              )
            ) FILTER (WHERE c.nombre IS NOT NULL),
            '[]'::json
          ) AS conceptos
        FROM public.pagos p
        LEFT JOIN public.detalle_pagos dp ON dp.pago_id = p.id AND dp.deleted_at IS NULL
        LEFT JOIN public.montos_por_cobrar mc ON mc.id = dp.monto_id
        LEFT JOIN public.conceptos c ON c.id = mc.concepto_id
        WHERE p.deleted_at IS NULL AND p.%I = %L
        GROUP BY p.id, p.codigo_transaccion, p.fecha_pago, p.monto_total, p.metodo_pago, p.comprobante, p.observacion
      ) pg
      $sql$,
      v_col,
      p_id
    ) INTO v_hist_pagos;

    RETURN json_build_object(
      'persona', v_persona,
      'deudas',  v_deudas,
      'pagos',   v_hist_pagos
    );
  END;
END;
$$;


-- =============================================================================
-- 5. Correcciones de montos para RODRIGUEZ CORDOVA MARCOS (Puesto 139)
-- =============================================================================
UPDATE public.montos_por_cobrar SET monto = 25.20 WHERE id = 9397;
UPDATE public.montos_por_cobrar SET monto = 6.00 WHERE id = 9398;
UPDATE public.montos_por_cobrar SET monto = 5.00 WHERE id = 9399;
UPDATE public.montos_por_cobrar SET monto = 60.00 WHERE id = 9392;


-- =============================================================================
-- 6. Insertar cargos separados para CORDOVA PEREZ MARCO ANTONIO (Puesto 94)
-- =============================================================================
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
VALUES 
  (189, 1, 2026, 4, 48.70, 'Pendiente', 'Manual', '2026-04-30', 'Separacion de cargo unificado (originalmente CORDOVA MARCO)'),
  (189, 2, 2026, 4, 189.40, 'Pendiente', 'Manual', '2026-04-30', 'Separacion de cargo unificado (originalmente CORDOVA MARCO)'),
  (189, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-30', 'Separacion de cargo unificado (originalmente CORDOVA MARCO)'),
  (189, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-30', 'Separacion de cargo unificado (originalmente CORDOVA MARCO)');

COMMIT;
