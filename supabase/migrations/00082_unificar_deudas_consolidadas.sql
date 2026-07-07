-- =============================================================================
-- Migración 00082 — Unificación de la lógica de deudas consolidadas
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Problema: cada módulo calculaba las deudas de una persona con lógica propia:
--   · Cuenta Corriente (rpc_cc_*, 00072)        → puesto + socio_id + almacenes ✔
--   · Portal Público (rpc_public_cargar_deudas) → titularidades + almacenes de
--     socio, pero SIN almacenes de inquilino (00080) ✘
--   · Caja / Wizard de Pago                     → query directa PostgREST con UN
--     solo puesto_id: los almacenes eran invisibles y no se podían cobrar ✘
--   · Padrón (socio-detail)                     → query directa con exclusión
--     hardcodeada de concepto_id=11 ✘
--
-- Solución: una ÚNICA fuente de verdad:
--   1. fn_deudas_pagador(p_tipo, p_id)     — set canónico de deudas de una persona
--      (deudas personales + todos sus puestos vigentes + todos sus almacenes).
--   2. fn_resolver_pagador(...)            — resolución puesto → persona compartida.
--   3. rpc_caja_cargar_deudas              — NUEVA, para Caja/Padrón (Admin|Caja).
--   4. rpc_public_cargar_deudas            — reescrita como wrapper del mismo fn.
--   5. rpc_cc_detalle_persona              — deudas delegadas al mismo fn.
--   6. rpc_cc_listar_personas              — deuda_pendiente delegada al mismo fn.
--
-- Todas devuelven exactamente los mismos conceptos y saldos. Se agrega la clave
-- adicional `codigo_puesto` (additiva, no rompe frontends existentes) para poder
-- distinguir en UI/recibos a qué espacio pertenece cada cargo.
-- =============================================================================

BEGIN;

-- =============================================================================
-- 1. fn_deudas_pagador — FUENTE CANÓNICA de deudas de un pagador
--    p_tipo: 'socio' | 'inquilino' | 'puesto' (fallback: solo deudas del puesto)
--    Devuelve TODAS las filas no anuladas y no Canceladas (incluye saldo 0 para
--    vistas históricas); cada wrapper decide si filtra saldo_pendiente > 0.
-- =============================================================================

CREATE OR REPLACE FUNCTION public.fn_deudas_pagador(
    p_tipo text,
    p_id   bigint
)
RETURNS TABLE (
    monto_id         bigint,
    concepto         text,
    puesto_id        bigint,
    codigo_puesto    text,
    periodo_anio     int,
    periodo_mes      int,
    monto_original   numeric,
    ya_pagado        numeric,
    saldo_pendiente  numeric,
    estado           text,
    fecha_generacion date,
    observacion      text
)
LANGUAGE sql
STABLE
SET search_path = public
AS $$
    SELECT
        mc.id                                   AS monto_id,
        coalesce(c.nombre, 'Sin concepto')      AS concepto,
        mc.puesto_id,
        p.codigo_puesto,
        mc.periodo_anio::int,
        mc.periodo_mes::int,
        mc.monto::numeric                       AS monto_original,
        pag.ya_pagado,
        round(mc.monto - pag.ya_pagado, 2)      AS saldo_pendiente,
        mc.estado::text,
        mc.fecha_generacion::date,
        mc.observacion
    FROM public.montos_por_cobrar mc
    JOIN public.conceptos c ON c.id = mc.concepto_id
    LEFT JOIN public.puestos p ON p.id = mc.puesto_id
    CROSS JOIN LATERAL (
        SELECT coalesce(sum(dp.monto_aplicado), 0)::numeric AS ya_pagado
        FROM   public.detalle_pagos dp
        WHERE  dp.monto_id = mc.id
          AND  dp.deleted_at IS NULL
    ) pag
    WHERE mc.deleted_at IS NULL
      AND mc.estado <> 'Cancelado'
      AND (
        (p_tipo = 'socio' AND (
            mc.socio_id = p_id
            OR mc.puesto_id IN (
                SELECT ht.puesto_id FROM public.historial_titularidad ht
                WHERE  ht.socio_id = p_id AND ht.fecha_fin IS NULL
            )
            OR mc.puesto_id IN (
                SELECT oa.puesto_id FROM public.ocupaciones_almacenes oa
                WHERE  oa.socio_id = p_id AND oa.fecha_fin IS NULL
            )
        ))
        OR
        (p_tipo = 'inquilino' AND (
            mc.puesto_id IN (
                SELECT ha.puesto_id FROM public.historial_arriendos ha
                WHERE  ha.inquilino_id = p_id AND ha.fecha_fin IS NULL
            )
            OR mc.puesto_id IN (
                SELECT oa.puesto_id FROM public.ocupaciones_almacenes oa
                WHERE  oa.inquilino_id = p_id AND oa.fecha_fin IS NULL
            )
        ))
        OR
        (p_tipo = 'puesto' AND mc.puesto_id = p_id)
      )
    ORDER BY mc.periodo_anio, mc.periodo_mes, mc.id;
$$;

COMMENT ON FUNCTION public.fn_deudas_pagador(text, bigint) IS
    'Fuente canónica del consolidado de deudas de un pagador: cargos personales '
    '(socio_id), puestos vigentes (historial_titularidad / historial_arriendos) y '
    'almacenes vigentes (ocupaciones_almacenes). Usada por Caja, Cuenta Corriente, '
    'Padrón y Portal Público. No exponer directamente vía PostgREST. (00082)';

-- No exponer como endpoint: solo la invocan los RPC SECURITY DEFINER.
REVOKE EXECUTE ON FUNCTION public.fn_deudas_pagador(text, bigint) FROM PUBLIC;
REVOKE EXECUTE ON FUNCTION public.fn_deudas_pagador(text, bigint) FROM anon;
REVOKE EXECUTE ON FUNCTION public.fn_deudas_pagador(text, bigint) FROM authenticated;

-- =============================================================================
-- 2. fn_resolver_pagador — resolución compartida puesto → persona
--    Prioridad: persona explícita del frontend > titular socio > ocupante de
--    almacén (socio) > arrendatario inquilino > ocupante de almacén (inquilino)
--    > fallback 'puesto' (deudas directas del puesto consultado).
-- =============================================================================

CREATE OR REPLACE FUNCTION public.fn_resolver_pagador(
    p_puesto_id  bigint,
    p_persona_id bigint DEFAULT NULL,
    p_tipo       text   DEFAULT NULL,
    OUT o_tipo   text,
    OUT o_id     bigint
)
LANGUAGE plpgsql
STABLE
SET search_path = public
AS $$
BEGIN
    IF p_persona_id IS NOT NULL AND p_tipo IN ('socio', 'inquilino') THEN
        o_tipo := p_tipo;
        o_id   := p_persona_id;
        RETURN;
    END IF;

    SELECT socio_id INTO o_id
    FROM public.historial_titularidad
    WHERE puesto_id = p_puesto_id AND fecha_fin IS NULL
    LIMIT 1;
    IF o_id IS NOT NULL THEN o_tipo := 'socio'; RETURN; END IF;

    SELECT socio_id INTO o_id
    FROM public.ocupaciones_almacenes
    WHERE puesto_id = p_puesto_id AND fecha_fin IS NULL AND socio_id IS NOT NULL
    LIMIT 1;
    IF o_id IS NOT NULL THEN o_tipo := 'socio'; RETURN; END IF;

    SELECT inquilino_id INTO o_id
    FROM public.historial_arriendos
    WHERE puesto_id = p_puesto_id AND fecha_fin IS NULL
    LIMIT 1;
    IF o_id IS NOT NULL THEN o_tipo := 'inquilino'; RETURN; END IF;

    SELECT inquilino_id INTO o_id
    FROM public.ocupaciones_almacenes
    WHERE puesto_id = p_puesto_id AND fecha_fin IS NULL AND inquilino_id IS NOT NULL
    LIMIT 1;
    IF o_id IS NOT NULL THEN o_tipo := 'inquilino'; RETURN; END IF;

    o_tipo := 'puesto';
    o_id   := p_puesto_id;
END;
$$;

COMMENT ON FUNCTION public.fn_resolver_pagador(bigint, bigint, text) IS
    'Resuelve el pagador efectivo de un puesto consultado (socio, inquilino o el '
    'propio puesto como fallback). Compartida por rpc_caja_cargar_deudas y '
    'rpc_public_cargar_deudas. (00082)';

REVOKE EXECUTE ON FUNCTION public.fn_resolver_pagador(bigint, bigint, text) FROM PUBLIC;
REVOKE EXECUTE ON FUNCTION public.fn_resolver_pagador(bigint, bigint, text) FROM anon;
REVOKE EXECUTE ON FUNCTION public.fn_resolver_pagador(bigint, bigint, text) FROM authenticated;

-- =============================================================================
-- 3. rpc_caja_cargar_deudas — NUEVO endpoint para Caja y Padrón (Admin | Caja)
--    Mismo contrato de salida que rpc_public_cargar_deudas (DeudaItem del front)
--    + codigo_puesto. Solo saldos > 0.
-- =============================================================================

CREATE OR REPLACE FUNCTION public.rpc_caja_cargar_deudas(
    p_puesto_id  bigint,
    p_persona_id bigint DEFAULT NULL,
    p_tipo       text   DEFAULT NULL
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_tipo   text;
    v_id     bigint;
    v_result json;
BEGIN
    IF public.get_my_rol() NOT IN ('Administrador', 'Caja') THEN
        RAISE EXCEPTION 'Acceso denegado: solo Administrador o Caja puede cargar deudas.';
    END IF;

    SELECT o_tipo, o_id INTO v_tipo, v_id
    FROM public.fn_resolver_pagador(p_puesto_id, p_persona_id, p_tipo);

    SELECT coalesce(
        json_agg(
            json_build_object(
                'monto_id',         d.monto_id,
                'concepto',         d.concepto,
                'codigo_puesto',    d.codigo_puesto,
                'periodo_anio',     d.periodo_anio,
                'periodo_mes',      d.periodo_mes,
                'monto_original',   d.monto_original,
                'ya_pagado',        d.ya_pagado,
                'saldo_pendiente',  d.saldo_pendiente,
                'fecha_generacion', d.fecha_generacion
            )
            ORDER BY d.periodo_anio, d.periodo_mes, d.monto_id
        ) FILTER (WHERE d.saldo_pendiente > 0),
        '[]'::json
    )
    INTO v_result
    FROM public.fn_deudas_pagador(v_tipo, v_id) d;

    RETURN v_result;
END;
$$;

COMMENT ON FUNCTION public.rpc_caja_cargar_deudas(bigint, bigint, text) IS
    'Caja / Padrón: consolidado de deudas pendientes de un pagador (puesto principal '
    '+ cargos personales + almacenes). Idéntico a rpc_public_cargar_deudas pero con '
    'control de rol Admin|Caja. (00082)';

GRANT EXECUTE ON FUNCTION public.rpc_caja_cargar_deudas(bigint, bigint, text) TO authenticated;

-- =============================================================================
-- 4. rpc_public_cargar_deudas — reescrito como wrapper del fn canónico
--    Misma firma y mismas claves que 00080 (+ codigo_puesto, additivo).
-- =============================================================================

CREATE OR REPLACE FUNCTION public.rpc_public_cargar_deudas(
    p_puesto_id  bigint,
    p_persona_id bigint DEFAULT NULL,
    p_tipo       text   DEFAULT NULL
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_tipo   text;
    v_id     bigint;
    v_result json;
BEGIN
    SELECT o_tipo, o_id INTO v_tipo, v_id
    FROM public.fn_resolver_pagador(p_puesto_id, p_persona_id, p_tipo);

    SELECT coalesce(
        json_agg(
            json_build_object(
                'monto_id',         d.monto_id,
                'concepto',         d.concepto,
                'codigo_puesto',    d.codigo_puesto,
                'periodo_anio',     d.periodo_anio,
                'periodo_mes',      d.periodo_mes,
                'monto_original',   d.monto_original,
                'ya_pagado',        d.ya_pagado,
                'saldo_pendiente',  d.saldo_pendiente,
                'fecha_generacion', d.fecha_generacion
            )
            ORDER BY d.periodo_anio, d.periodo_mes, d.monto_id
        ) FILTER (WHERE d.saldo_pendiente > 0),
        '[]'::json
    )
    INTO v_result
    FROM public.fn_deudas_pagador(v_tipo, v_id) d;

    RETURN v_result;
END;
$$;

COMMENT ON FUNCTION public.rpc_public_cargar_deudas(bigint, bigint, text) IS
    'Portal público: consolidado de deudas pendientes de un pagador. Delegado a '
    'fn_deudas_pagador — misma fuente que Caja, Cuenta Corriente y Padrón. (00082)';

GRANT EXECUTE ON FUNCTION public.rpc_public_cargar_deudas(bigint, bigint, text) TO anon;
GRANT EXECUTE ON FUNCTION public.rpc_public_cargar_deudas(bigint, bigint, text) TO authenticated;

-- =============================================================================
-- 5. rpc_cc_detalle_persona — sección de deudas delegada al fn canónico
--    Persona y pagos idénticos a 00072; claves de deudas preservadas
--    (id, concepto, periodo_*, monto, estado, fecha_generacion, observacion,
--    ya_pagado) + codigo_puesto additivo.
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
    SELECT row_to_json(t) INTO v_persona
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
  ELSE
    SELECT row_to_json(t) INTO v_persona
    FROM (
      SELECT
        'inquilino' AS tipo,
        i.id,
        i.apellidos  AS nombre,
        i.dni,
        'Activo'     AS estado,
        null         AS habilitado,
        i.saldo_a_favor,
        p.codigo_puesto,
        p.id         AS puesto_id
      FROM public.inquilinos i
      LEFT JOIN public.historial_arriendos ha
             ON ha.inquilino_id = i.id AND ha.fecha_fin IS NULL
      LEFT JOIN public.puestos p ON p.id = ha.puesto_id
      WHERE i.id = p_id AND i.deleted_at IS NULL
    ) t;
  END IF;

  -- ── Deudas: fuente canónica compartida ────────────────────────────────────
  SELECT coalesce(
    json_agg(
      json_build_object(
        'id',               d.monto_id,
        'concepto',         d.concepto,
        'codigo_puesto',    d.codigo_puesto,
        'periodo_anio',     d.periodo_anio,
        'periodo_mes',      d.periodo_mes,
        'monto',            d.monto_original,
        'estado',           d.estado,
        'fecha_generacion', d.fecha_generacion,
        'observacion',      d.observacion,
        'ya_pagado',        d.ya_pagado
      )
      ORDER BY d.periodo_anio, d.periodo_mes, d.monto_id
    ),
    '[]'::json
  )
  INTO v_deudas
  FROM public.fn_deudas_pagador(p_tipo, p_id) d;

  -- ── Historial de pagos (idéntico a 00072) ─────────────────────────────────
  DECLARE
    v_col text := CASE p_tipo WHEN 'socio' THEN 'socio_id' ELSE 'inquilino_id' END;
  BEGIN
    EXECUTE format(
      $sql$
      SELECT coalesce(json_agg(pg ORDER BY pg.fecha_pago DESC), '[]'::json)
      FROM (
        SELECT
          p.id,
          p.codigo_transaccion,
          p.fecha_pago,
          p.monto_total,
          p.metodo_pago,
          p.comprobante,
          p.deleted_at IS NOT NULL          AS anulado,
          p.motivo_anulacion,
          coalesce(
            (
              SELECT json_agg(
                json_build_object(
                  'concepto',       coalesce(c2.nombre, '?'),
                  'monto_aplicado', dp2.monto_aplicado
                )
              )
              FROM   public.detalle_pagos dp2
              JOIN   public.montos_por_cobrar mc2 ON mc2.id = dp2.monto_id
              JOIN   public.conceptos c2 ON c2.id = mc2.concepto_id
              WHERE  dp2.pago_id    = p.id
                AND  dp2.deleted_at IS NULL
            ), '[]'::json
          )                                 AS detalle
        FROM public.pagos p
        WHERE p.%I = $1
      ) pg
      $sql$,
      v_col
    )
    INTO v_pagos
    USING p_id;
  END;

  RETURN json_build_object(
    'persona', v_persona,
    'deudas',  v_deudas,
    'pagos',   v_pagos
  );
END;
$$;

COMMENT ON FUNCTION public.rpc_cc_detalle_persona(text, bigint) IS
  'Cuenta Corriente: dashboard financiero de una persona. Deudas delegadas a '
  'fn_deudas_pagador — misma fuente que Caja y Portal Público. (00082)';

GRANT EXECUTE ON FUNCTION public.rpc_cc_detalle_persona(text, bigint) TO authenticated;

-- =============================================================================
-- 6. rpc_cc_listar_personas — deuda_pendiente delegada al fn canónico
--    (suma de saldos positivos, mismo total que muestran las demás vistas)
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
          SELECT sum(d.saldo_pendiente)
          FROM   public.fn_deudas_pagador('socio', s.id) d
          WHERE  d.saldo_pendiente > 0
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
          SELECT sum(d.saldo_pendiente)
          FROM   public.fn_deudas_pagador('inquilino', i.id) d
          WHERE  d.saldo_pendiente > 0
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

COMMENT ON FUNCTION public.rpc_cc_listar_personas() IS
  'Cuenta Corriente: listado unificado de socios e inquilinos. deuda_pendiente '
  'delegada a fn_deudas_pagador — misma fuente que las demás vistas. (00082)';

GRANT EXECUTE ON FUNCTION public.rpc_cc_listar_personas() TO authenticated;

COMMIT;
