-- =============================================================================
-- Migración 00072 — Módulo de Alquiler de Almacenes
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Cambios:
--   1. Columna costo_alquiler en puestos y ocupaciones_almacenes.
--   2. Concepto "Alquiler de almacén".
--   3. Vista vw_espacios_con_ocupacion actualizada con costo_alquiler.
--   4. rpc_asignar_almacen actualizado con p_costo_alquiler opcional.
--   5. rpc_modificar_costo_almacen — actualiza tarifa base y contrato vigente.
--   6. generar_alquiler_almacenes_mes — facturación masiva idempotente.
--   7. rpc_cc_listar_personas actualizado — incluye deudas de almacenes.
--   8. rpc_cc_detalle_persona actualizado — incluye deudas de almacenes.
-- =============================================================================

BEGIN;

-- =============================================================================
-- 1. Columnas de costo de alquiler
-- =============================================================================

ALTER TABLE public.puestos
  ADD COLUMN IF NOT EXISTS costo_alquiler numeric(10,2) NOT NULL DEFAULT 0.00
  CHECK (costo_alquiler >= 0.00);

ALTER TABLE public.ocupaciones_almacenes
  ADD COLUMN IF NOT EXISTS costo_alquiler numeric(10,2) NOT NULL DEFAULT 0.00
  CHECK (costo_alquiler >= 0.00);

COMMENT ON COLUMN public.puestos.costo_alquiler IS
  'Tarifa mensual base de alquiler del almacén. Solo significativa para puestos tipo Almacén.';
COMMENT ON COLUMN public.ocupaciones_almacenes.costo_alquiler IS
  'Costo mensual acordado en el contrato de ocupación (puede diferir de la tarifa base del puesto).';

-- =============================================================================
-- 2. Concepto de pago — idempotente
-- =============================================================================

INSERT INTO public.conceptos (nombre, tipo, activo, descripcion)
VALUES (
  'Alquiler de almacén',
  'Fijo',
  true,
  'Cobro mensual por arriendo de depósito o almacén complementario'
)
ON CONFLICT DO NOTHING;

-- =============================================================================
-- 3. Vista vw_espacios_con_ocupacion — añade costo_alquiler del puesto
--    DROP + CREATE porque CREATE OR REPLACE no permite insertar columnas en medio.
-- =============================================================================

DROP VIEW IF EXISTS public.vw_espacios_con_ocupacion;

CREATE VIEW public.vw_espacios_con_ocupacion
WITH (security_invoker = true) AS
SELECT
  p.id                AS puesto_id,
  p.codigo_puesto,
  p.tipo_espacio,
  p.estado,
  p.giro_id,
  g.nombre            AS giro_nombre,
  p.area_m2,
  p.tiene_medidor_luz,
  p.tiene_medidor_agua,
  p.cobro_luz_activo,
  p.cobro_agua_activo,
  p.costo_alquiler,

  -- Titular socio: historial_titularidad para Regular/Pequeño;
  -- ocupaciones_almacenes tipo=Socio para Almacén.
  COALESCE(
    ht.socio_id,
    CASE WHEN oa.tipo_ocupante = 'Socio' THEN oa.socio_id ELSE NULL END
  )                   AS titular_id,
  COALESCE(s_t.nombres,   s_oa.nombres)   AS titular_nombres,
  COALESCE(s_t.apellidos, s_oa.apellidos) AS titular_apellidos,
  COALESCE(s_t.dni,       s_oa.dni)       AS titular_dni,
  COALESCE(s_t.estado,    s_oa.estado)    AS titular_estado,
  COALESCE(
    ht.fecha_inicio,
    CASE WHEN oa.tipo_ocupante = 'Socio' THEN oa.fecha_inicio ELSE NULL END
  )                   AS titularidad_inicio,

  -- Arrendatario: historial_arriendos para Regular/Pequeño;
  -- ocupaciones_almacenes tipo=Inquilino/Tercero para Almacén.
  COALESCE(
    ha.inquilino_id,
    CASE WHEN oa.tipo_ocupante IN ('Inquilino', 'Tercero') THEN oa.inquilino_id ELSE NULL END
  )                   AS inquilino_id,
  COALESCE(inq_h.nombres,   inq_oa.nombres)   AS inquilino_nombres,
  COALESCE(inq_h.apellidos, inq_oa.apellidos) AS inquilino_apellidos,
  COALESCE(inq_h.tipo_inquilino, inq_oa.tipo_inquilino) AS tipo_inquilino,
  COALESCE(
    ha.fecha_inicio,
    CASE WHEN oa.tipo_ocupante IN ('Inquilino', 'Tercero') THEN oa.fecha_inicio ELSE NULL END
  )                   AS arriendo_inicio,

  -- Tipo de ocupante explícito (00043)
  CASE
    WHEN ht.socio_id IS NOT NULL                                           THEN 'Socio'
    WHEN ha.inquilino_id IS NOT NULL AND inq_h.tipo_inquilino = 'Tercero'  THEN 'Tercero'
    WHEN ha.inquilino_id IS NOT NULL                                       THEN 'Inquilino'
    WHEN oa.tipo_ocupante IS NOT NULL                                      THEN oa.tipo_ocupante
    ELSE NULL
  END                 AS tipo_ocupante,

  -- ID de ocupacion_almacen activa (para rpc_liberar_almacen)
  CASE WHEN p.tipo_espacio = 'Almacen' THEN oa.id ELSE NULL END AS ocupacion_almacen_id,

  -- Costo contratado de la ocupación activa (solo Almacén)
  CASE WHEN p.tipo_espacio = 'Almacen' THEN oa.costo_alquiler ELSE NULL END AS costo_alquiler_contrato

FROM public.puestos p
LEFT JOIN public.giros g
  ON g.id = p.giro_id AND g.deleted_at IS NULL
LEFT JOIN public.historial_titularidad ht
  ON ht.puesto_id = p.id AND ht.fecha_fin IS NULL
LEFT JOIN public.socios s_t
  ON s_t.id = ht.socio_id AND s_t.deleted_at IS NULL
LEFT JOIN public.historial_arriendos ha
  ON ha.puesto_id = p.id AND ha.fecha_fin IS NULL
LEFT JOIN public.inquilinos inq_h
  ON inq_h.id = ha.inquilino_id AND inq_h.deleted_at IS NULL
LEFT JOIN public.ocupaciones_almacenes oa
  ON oa.puesto_id = p.id AND oa.fecha_fin IS NULL
LEFT JOIN public.socios s_oa
  ON s_oa.id = oa.socio_id AND s_oa.deleted_at IS NULL
LEFT JOIN public.inquilinos inq_oa
  ON inq_oa.id = oa.inquilino_id AND inq_oa.deleted_at IS NULL
WHERE p.deleted_at IS NULL
ORDER BY p.tipo_espacio, p.codigo_puesto;

COMMENT ON VIEW public.vw_espacios_con_ocupacion IS
  'Vista operativa de todos los espacios con su tipo, estado de servicios y '
  'ocupante vigente. Regular/Pequeño usan historial_titularidad/arriendos; '
  'Almacén usa ocupaciones_almacenes. '
  'Incluye costo_alquiler (tarifa base puesto) y costo_alquiler_contrato (contrato activo). '
  '(00043 → 00072)';

GRANT SELECT ON public.vw_espacios_con_ocupacion TO authenticated;

-- =============================================================================
-- 4. rpc_asignar_almacen — acepta p_costo_alquiler opcional
--    Si NULL, lee costo_alquiler base de puestos.
--    DROP de la firma anterior (6 args): una nueva firma crea una sobrecarga,
--    no reemplaza, y el nombre quedaría ambiguo.
-- =============================================================================

DROP FUNCTION IF EXISTS public.rpc_asignar_almacen(bigint, text, bigint, bigint, date, uuid);

CREATE FUNCTION public.rpc_asignar_almacen(
    p_puesto_id      bigint,
    p_tipo_ocupante  text,
    p_socio_id       bigint   DEFAULT NULL,
    p_inquilino_id   bigint   DEFAULT NULL,
    p_fecha_inicio   date     DEFAULT current_date,
    p_usuario        uuid     DEFAULT NULL,
    p_costo_alquiler numeric  DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_tipo            text;
    v_cod             text;
    v_costo_base      numeric(10,2);
    v_costo_contrato  numeric(10,2);
    v_id              bigint;
BEGIN
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede asignar Almacenes.';
    END IF;
    IF p_usuario IS NULL THEN p_usuario := auth.uid(); END IF;

    IF p_tipo_ocupante NOT IN ('Socio', 'Inquilino', 'Tercero') THEN
        RAISE EXCEPTION 'tipo_ocupante inválido: "%". Usar Socio | Inquilino | Tercero.', p_tipo_ocupante;
    END IF;
    IF p_tipo_ocupante = 'Socio' AND p_socio_id IS NULL THEN
        RAISE EXCEPTION 'tipo_ocupante=Socio requiere p_socio_id.';
    END IF;
    IF p_tipo_ocupante IN ('Inquilino', 'Tercero') AND p_inquilino_id IS NULL THEN
        RAISE EXCEPTION 'tipo_ocupante=% requiere p_inquilino_id.', p_tipo_ocupante;
    END IF;

    SELECT tipo_espacio, codigo_puesto, costo_alquiler
    INTO v_tipo, v_cod, v_costo_base
    FROM public.puestos
    WHERE id = p_puesto_id AND deleted_at IS NULL;

    IF v_tipo IS NULL THEN
        RAISE EXCEPTION 'Puesto id=% no encontrado o dado de baja.', p_puesto_id;
    END IF;
    IF v_tipo <> 'Almacen' THEN
        RAISE EXCEPTION 'rpc_asignar_almacen solo aplica a puestos tipo Almacén. Puesto "%" es tipo "%".', v_cod, v_tipo;
    END IF;

    IF EXISTS (
        SELECT 1 FROM public.ocupaciones_almacenes
        WHERE puesto_id = p_puesto_id AND fecha_fin IS NULL
    ) THEN
        RAISE EXCEPTION
            'El Almacén "%" ya tiene una ocupación activa. '
            'Ejecute rpc_liberar_almacen primero.', v_cod;
    END IF;

    v_costo_contrato := COALESCE(p_costo_alquiler, v_costo_base, 0.00);

    INSERT INTO public.ocupaciones_almacenes
        (puesto_id, tipo_ocupante, socio_id, inquilino_id, fecha_inicio, costo_alquiler, created_by)
    VALUES
        (p_puesto_id, p_tipo_ocupante, p_socio_id, p_inquilino_id, p_fecha_inicio, v_costo_contrato, p_usuario)
    RETURNING id INTO v_id;

    RETURN jsonb_build_object(
        'id',              v_id,
        'puesto_id',       p_puesto_id,
        'codigo_puesto',   v_cod,
        'tipo_ocupante',   p_tipo_ocupante,
        'fecha_inicio',    p_fecha_inicio,
        'costo_alquiler',  v_costo_contrato
    );
END;
$$;

COMMENT ON FUNCTION public.rpc_asignar_almacen(bigint, text, bigint, bigint, date, uuid, numeric) IS
    'Crea una ocupacion_almacen activa para un espacio tipo Almacén. Solo Administrador. '
    'Acepta p_costo_alquiler opcional; si NULL usa la tarifa base del puesto. (00072)';

GRANT EXECUTE ON FUNCTION public.rpc_asignar_almacen(bigint, text, bigint, bigint, date, uuid, numeric) TO authenticated;

-- =============================================================================
-- 5. rpc_modificar_costo_almacen
--    Actualiza la tarifa base en puestos Y el contrato activo en ocupaciones_almacenes.
-- =============================================================================

CREATE OR REPLACE FUNCTION public.rpc_modificar_costo_almacen(
    p_puesto_id bigint,
    p_monto     numeric
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_cod  text;
    v_tipo text;
BEGIN
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede modificar costos de alquiler.';
    END IF;
    IF p_monto < 0 THEN
        RAISE EXCEPTION 'El monto no puede ser negativo.';
    END IF;

    SELECT codigo_puesto, tipo_espacio INTO v_cod, v_tipo
    FROM public.puestos
    WHERE id = p_puesto_id AND deleted_at IS NULL;

    IF v_cod IS NULL THEN
        RAISE EXCEPTION 'Puesto id=% no encontrado.', p_puesto_id;
    END IF;
    IF v_tipo <> 'Almacen' THEN
        RAISE EXCEPTION 'El puesto "%" no es un Almacén (tipo=%).', v_cod, v_tipo;
    END IF;

    -- Actualizar tarifa base
    UPDATE public.puestos
    SET costo_alquiler = p_monto, updated_at = now()
    WHERE id = p_puesto_id;

    -- Actualizar contrato vigente si existe
    UPDATE public.ocupaciones_almacenes
    SET costo_alquiler = p_monto, updated_at = now()
    WHERE puesto_id = p_puesto_id AND fecha_fin IS NULL;

    RETURN jsonb_build_object(
        'puesto_id',      p_puesto_id,
        'codigo_puesto',  v_cod,
        'nuevo_costo',    p_monto
    );
END;
$$;

COMMENT ON FUNCTION public.rpc_modificar_costo_almacen IS
    'Actualiza la tarifa base (puestos) y el contrato vigente (ocupaciones_almacenes) '
    'de un Almacén. Solo Administrador. (00072)';

GRANT EXECUTE ON FUNCTION public.rpc_modificar_costo_almacen TO authenticated;

-- =============================================================================
-- 6. generar_alquiler_almacenes_mes
--    Facturación masiva idempotente de alquiler de almacenes.
-- =============================================================================

CREATE OR REPLACE FUNCTION public.generar_alquiler_almacenes_mes(
    p_anio    smallint,
    p_mes     smallint,
    p_usuario uuid
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_concepto_id      bigint;
    v_total_activos    int := 0;
    v_insertados       int := 0;
    v_total_monto      numeric(12,2) := 0.00;
BEGIN
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede generar cobros de alquiler.';
    END IF;
    IF p_anio NOT BETWEEN 2000 AND 2100 THEN
        RAISE EXCEPTION 'Año inválido: %', p_anio;
    END IF;
    IF p_mes NOT BETWEEN 1 AND 12 THEN
        RAISE EXCEPTION 'Mes inválido: %', p_mes;
    END IF;

    SELECT id INTO v_concepto_id
    FROM public.conceptos
    WHERE nombre = 'Alquiler de almacén' AND deleted_at IS NULL
    LIMIT 1;

    IF v_concepto_id IS NULL THEN
        RAISE EXCEPTION 'Concepto "Alquiler de almacén" no encontrado. Ejecute la migración 00072.';
    END IF;

    -- Conteo de almacenes activos con ocupante
    SELECT count(*) INTO v_total_activos
    FROM public.ocupaciones_almacenes oa
    JOIN public.puestos p ON p.id = oa.puesto_id
    WHERE oa.fecha_fin IS NULL
      AND p.estado = 'Activo'
      AND p.deleted_at IS NULL;

    -- Suma total proyectada
    SELECT coalesce(sum(oa.costo_alquiler), 0) INTO v_total_monto
    FROM public.ocupaciones_almacenes oa
    JOIN public.puestos p ON p.id = oa.puesto_id
    WHERE oa.fecha_fin IS NULL
      AND p.estado = 'Activo'
      AND p.deleted_at IS NULL;

    -- Inserción idempotente
    INSERT INTO public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes,
         monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    SELECT
        oa.puesto_id,
        v_concepto_id,
        p_anio,
        p_mes,
        oa.costo_alquiler,
        'Pendiente',
        'Fijo',
        current_date,
        'Cobro mensual alquiler de almacén ' || p.codigo_puesto,
        p_usuario
    FROM public.ocupaciones_almacenes oa
    JOIN public.puestos p ON p.id = oa.puesto_id
    WHERE oa.fecha_fin IS NULL
      AND p.estado = 'Activo'
      AND p.deleted_at IS NULL
    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
        WHERE deleted_at IS NULL AND puesto_id IS NOT NULL DO NOTHING;

    GET DIAGNOSTICS v_insertados = ROW_COUNT;

    RETURN jsonb_build_object(
        'periodo',              jsonb_build_object('anio', p_anio, 'mes', p_mes),
        'almacenes_procesados', v_total_activos,
        'cargos_generados',     v_insertados,
        'total_monto',          v_total_monto
    );
END;
$$;

COMMENT ON FUNCTION public.generar_alquiler_almacenes_mes IS
    'Genera los cargos mensuales de alquiler para todos los almacenes con ocupación activa. '
    'Idempotente: ON CONFLICT DO NOTHING. Solo Administrador. (00072)';

GRANT EXECUTE ON FUNCTION public.generar_alquiler_almacenes_mes TO authenticated;

-- =============================================================================
-- 7. rpc_cc_listar_personas — incluye deudas de almacenes del titular/arrendatario
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
            AND  (
              mc.puesto_id = p.id
              OR mc.socio_id = s.id
              OR mc.puesto_id IN (
                SELECT oa.puesto_id
                FROM   public.ocupaciones_almacenes oa
                WHERE  oa.socio_id = s.id AND oa.fecha_fin IS NULL
              )
            )
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
            AND  (
              mc.puesto_id = p.id
              OR mc.puesto_id IN (
                SELECT oa.puesto_id
                FROM   public.ocupaciones_almacenes oa
                WHERE  oa.inquilino_id = i.id AND oa.fecha_fin IS NULL
              )
            )
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
  'Cuenta Corriente: listado unificado de socios e inquilinos con deuda_pendiente (saldo neto) '
  'incluyendo deudas de almacenes asignados. (00072)';

GRANT EXECUTE ON FUNCTION public.rpc_cc_listar_personas() TO authenticated;

-- =============================================================================
-- 8. rpc_cc_detalle_persona — incluye deudas de almacenes
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

    v_puesto_id := (v_persona->>'puesto_id')::bigint;

    SELECT coalesce(json_agg(d ORDER BY d.periodo_anio, d.periodo_mes), '[]'::json)
    INTO v_deudas
    FROM (
      SELECT
        mc.id,
        coalesce(c.nombre, 'Sin concepto')   AS concepto,
        mc.periodo_anio,
        mc.periodo_mes,
        mc.monto,
        mc.estado,
        mc.fecha_generacion,
        mc.observacion,
        coalesce(
          (
            SELECT sum(dp.monto_aplicado)
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
        AND (
          mc.puesto_id = v_puesto_id
          OR mc.socio_id = p_id
          OR mc.puesto_id IN (
            SELECT oa.puesto_id
            FROM   public.ocupaciones_almacenes oa
            WHERE  oa.socio_id = p_id AND oa.fecha_fin IS NULL
          )
        )
    ) d;

  ELSE
    -- inquilino
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

    v_puesto_id := (v_persona->>'puesto_id')::bigint;

    SELECT coalesce(json_agg(d ORDER BY d.periodo_anio, d.periodo_mes), '[]'::json)
    INTO v_deudas
    FROM (
      SELECT
        mc.id,
        coalesce(c.nombre, 'Sin concepto') AS concepto,
        mc.periodo_anio,
        mc.periodo_mes,
        mc.monto,
        mc.estado,
        mc.fecha_generacion,
        mc.observacion,
        coalesce(
          (
            SELECT sum(dp.monto_aplicado)
            FROM   public.detalle_pagos dp
            JOIN   public.pagos pg ON pg.id = dp.pago_id
            WHERE  dp.monto_id   = mc.id
              AND  dp.deleted_at IS NULL
              AND  pg.deleted_at IS NULL
          ), 0
        )                                  AS ya_pagado
      FROM public.montos_por_cobrar mc
      JOIN public.conceptos c ON c.id = mc.concepto_id
      WHERE mc.deleted_at IS NULL
        AND mc.estado     != 'Cancelado'
        AND (
          mc.puesto_id = v_puesto_id
          OR mc.puesto_id IN (
            SELECT oa.puesto_id
            FROM   public.ocupaciones_almacenes oa
            WHERE  oa.inquilino_id = p_id AND oa.fecha_fin IS NULL
          )
        )
    ) d;
  END IF;

  -- ── Historial de pagos ────────────────────────────────────────────────────
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
  'Cuenta Corriente: dashboard financiero de una persona (deudas + pagos), '
  'incluyendo deudas de almacenes asignados. (00072)';

GRANT EXECUTE ON FUNCTION public.rpc_cc_detalle_persona(text, bigint) TO authenticated;

COMMIT;
