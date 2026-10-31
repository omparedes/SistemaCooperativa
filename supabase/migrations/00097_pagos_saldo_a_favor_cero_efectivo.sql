-- =============================================================================
-- Migración 00097 — Pagos cubiertos 100 % con Saldo a Favor (Efectivo S/ 0.00)
-- ERP Mercado Cooperativo Primero de Mayo
-- -----------------------------------------------------------------------------
-- Objetivo:
--   1. Permitir pagos con monto_total = 0.00 cuando se utiliza saldo_a_favor
--      acumulado (p. ej. mediante Recaudación con Tarjeta), modificando el
--      constraint pagos_monto_total_check a CHECK (monto_total >= 0).
--   2. Ajustar rpc_procesar_pago para validar:
--        - p_monto_total >= 0 y p_saldo_utilizado >= 0
--        - (p_monto_total + p_saldo_utilizado) > 0
--        - si p_monto_total = 0, debe aplicarse saldo al menos a una deuda
--        - bloqueo FOR UPDATE del pagador y de las deudas para evitar descuentos
--          duplicados por doble clic o transacciones concurrentes
--        - soporte de titularidad y almacenes activos del pagador
--   3. Blindar anular_pago con bloqueo FOR UPDATE para evitar reversiones
--      duplicadas de saldo_a_favor ante clics concurrentes.
--   4. Ajustar rpc_cc_detalle_persona, rpc_reporte_resumen y
--      rpc_reporte_detalle_concepto para reflejar adecuadamente los pagos con
--      monto_total = 0.
-- =============================================================================

BEGIN;

-- -----------------------------------------------------------------------------
-- 1. Tabla public.pagos: permitir monto_total >= 0
-- -----------------------------------------------------------------------------
ALTER TABLE public.pagos
  DROP CONSTRAINT IF EXISTS pagos_monto_total_check;

ALTER TABLE public.pagos
  ADD CONSTRAINT pagos_monto_total_check CHECK (monto_total >= (0)::numeric);

-- -----------------------------------------------------------------------------
-- 2. RPC public.rpc_procesar_pago
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.rpc_procesar_pago(
  p_puesto_id       bigint,
  p_socio_id        bigint,
  p_inquilino_id    bigint,
  p_monto_total     numeric,
  p_metodo_pago     text,
  p_comprobante     text,
  p_observacion     text,
  p_usuario_id      uuid,
  p_distribucion    jsonb,
  p_saldo_utilizado numeric                  DEFAULT 0,
  p_fecha_pago      timestamp with time zone DEFAULT now()
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path TO 'public'
AS $function$
DECLARE
  v_pago_id          bigint;
  v_codigo           text;
  v_n                integer;
  v_idx              integer;
  v_linea            jsonb;
  v_monto            record;
  v_monto_id         bigint;
  v_monto_aplicado   numeric;
  v_monto_disponible numeric;
  v_total_aplicado   numeric := 0;
  v_saldo_persona    numeric;
  v_ya_pagado        numeric;
  v_saldo_deuda      numeric;
  v_saldo_restante   numeric;
  v_excedente        numeric;
  v_ids_vistos       bigint[] := '{}'::bigint[];
BEGIN
  IF public.get_my_rol() NOT IN ('Administrador', 'Caja') THEN
    RAISE EXCEPTION 'Acceso denegado: solo Administrador o Caja puede procesar pagos.';
  END IF;

  IF p_usuario_id IS NULL THEN
    RAISE EXCEPTION 'El usuario de auditoría es obligatorio.';
  END IF;

  IF (p_socio_id IS NULL) = (p_inquilino_id IS NULL) THEN
    RAISE EXCEPTION 'Debe especificar exactamente uno de: p_socio_id, p_inquilino_id.';
  END IF;

  IF p_socio_id IS NOT NULL AND p_puesto_id IS NULL THEN
    RAISE EXCEPTION 'Los pagos de socios requieren p_puesto_id.';
  END IF;

  IF p_puesto_id IS NOT NULL AND NOT EXISTS (
    SELECT 1
    FROM public.puestos p
    WHERE p.id = p_puesto_id AND p.deleted_at IS NULL
  ) THEN
    RAISE EXCEPTION 'Puesto % inexistente o anulado.', p_puesto_id;
  END IF;

  IF p_monto_total IS NULL OR p_monto_total < 0 THEN
    RAISE EXCEPTION 'El monto recibido no puede ser negativo.';
  END IF;

  IF p_metodo_pago NOT IN ('Efectivo', 'Transferencia') THEN
    RAISE EXCEPTION 'Método de pago inválido: %.', p_metodo_pago;
  END IF;

  IF coalesce(p_saldo_utilizado, 0) < 0 THEN
    RAISE EXCEPTION 'El saldo utilizado no puede ser negativo.';
  END IF;

  v_monto_disponible := p_monto_total + coalesce(p_saldo_utilizado, 0);
  IF v_monto_disponible <= 0 THEN
    RAISE EXCEPTION 'El monto disponible (efectivo más saldo a favor) debe ser mayor a cero.';
  END IF;

  IF p_distribucion IS NULL OR jsonb_typeof(p_distribucion) <> 'array' THEN
    RAISE EXCEPTION 'La distribución debe ser un arreglo JSON.';
  END IF;

  -- Bloqueo pesimista del pagador para evitar descuentos duplicados por doble clic
  IF p_socio_id IS NOT NULL THEN
    SELECT s.saldo_a_favor
    INTO v_saldo_persona
    FROM public.socios s
    WHERE s.id = p_socio_id AND s.deleted_at IS NULL
    FOR UPDATE;
  ELSE
    SELECT i.saldo_a_favor
    INTO v_saldo_persona
    FROM public.inquilinos i
    WHERE i.id = p_inquilino_id AND i.deleted_at IS NULL
    FOR UPDATE;
  END IF;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'El pagador no existe o está anulado.';
  END IF;

  IF coalesce(p_saldo_utilizado, 0) > coalesce(v_saldo_persona, 0) THEN
    RAISE EXCEPTION 'Saldo a favor insuficiente: disponible %, solicitado %.',
      coalesce(v_saldo_persona, 0), coalesce(p_saldo_utilizado, 0);
  END IF;

  v_n := jsonb_array_length(p_distribucion);

  -- Valida y bloquea todas las deudas antes de crear la cabecera del pago.
  IF v_n > 0 THEN
    FOR v_idx IN 0 .. v_n - 1 LOOP
      v_linea := p_distribucion -> v_idx;
      v_monto_id := nullif(v_linea ->> 'monto_id', '')::bigint;
      v_monto_aplicado := nullif(v_linea ->> 'monto_aplicado', '')::numeric;

      IF v_monto_id IS NULL OR v_monto_aplicado IS NULL OR v_monto_aplicado <= 0 THEN
        RAISE EXCEPTION 'Línea de distribución inválida en posición %.', v_idx;
      END IF;

      IF v_monto_id = ANY(v_ids_vistos) THEN
        RAISE EXCEPTION 'La deuda % está repetida en la distribución.', v_monto_id;
      END IF;
      v_ids_vistos := array_append(v_ids_vistos, v_monto_id);

      SELECT m.*
      INTO v_monto
      FROM public.montos_por_cobrar m
      WHERE m.id = v_monto_id AND m.deleted_at IS NULL
      FOR UPDATE;

      IF NOT FOUND OR v_monto.estado = 'Cancelado' THEN
        RAISE EXCEPTION 'Deuda % inexistente, anulada o cancelada.', v_monto_id;
      END IF;

      IF p_socio_id IS NOT NULL THEN
        IF NOT (
          v_monto.socio_id = p_socio_id
          OR (v_monto.puesto_id IS NOT NULL AND v_monto.puesto_id = p_puesto_id)
          OR (v_monto.puesto_id IS NOT NULL AND EXISTS (
            SELECT 1 FROM public.historial_titularidad ht
            WHERE ht.socio_id = p_socio_id AND ht.puesto_id = v_monto.puesto_id AND ht.fecha_fin IS NULL
          ))
          OR (v_monto.puesto_id IS NOT NULL AND EXISTS (
            SELECT 1 FROM public.ocupaciones_almacenes oa
            WHERE oa.socio_id = p_socio_id AND oa.puesto_id = v_monto.puesto_id AND oa.fecha_fin IS NULL
          ))
        ) THEN
          RAISE EXCEPTION 'La deuda % no pertenece al socio ni a su puesto contextual.', v_monto_id;
        END IF;
      ELSE
        IF NOT (
          v_monto.inquilino_id = p_inquilino_id
          OR (
            p_puesto_id IS NOT NULL
            AND v_monto.puesto_id IS NOT NULL
            AND v_monto.puesto_id = p_puesto_id
          )
          OR (v_monto.puesto_id IS NOT NULL AND EXISTS (
            SELECT 1 FROM public.historial_arriendos ha
            WHERE ha.inquilino_id = p_inquilino_id AND ha.puesto_id = v_monto.puesto_id AND ha.fecha_fin IS NULL
          ))
          OR (v_monto.puesto_id IS NOT NULL AND EXISTS (
            SELECT 1 FROM public.ocupaciones_almacenes oa
            WHERE oa.inquilino_id = p_inquilino_id AND oa.puesto_id = v_monto.puesto_id AND oa.fecha_fin IS NULL
          ))
        ) THEN
          RAISE EXCEPTION 'La deuda % no pertenece al inquilino ni a su puesto contextual.', v_monto_id;
        END IF;
      END IF;

      SELECT coalesce(sum(dp.monto_aplicado), 0)
      INTO v_ya_pagado
      FROM public.detalle_pagos dp
      WHERE dp.monto_id = v_monto_id AND dp.deleted_at IS NULL;

      v_saldo_deuda := round(v_monto.monto - v_ya_pagado, 2);
      IF v_saldo_deuda <= 0 THEN
        RAISE EXCEPTION 'La deuda % no tiene saldo pendiente.', v_monto_id;
      END IF;

      IF v_monto_aplicado > v_saldo_deuda THEN
        RAISE EXCEPTION 'La aplicación % excede el saldo % de la deuda %.',
          v_monto_aplicado, v_saldo_deuda, v_monto_id;
      END IF;

      v_total_aplicado := v_total_aplicado + v_monto_aplicado;
    END LOOP;
  END IF;

  IF p_monto_total = 0 AND v_total_aplicado <= 0 THEN
    RAISE EXCEPTION 'Para registrar un pago con saldo a favor debe aplicar el importe al menos a una deuda.';
  END IF;

  IF v_total_aplicado > v_monto_disponible THEN
    RAISE EXCEPTION 'La distribución % excede el monto disponible %.',
      v_total_aplicado, v_monto_disponible;
  END IF;

  INSERT INTO public.pagos (
    puesto_id,
    socio_id,
    inquilino_id,
    monto_total,
    metodo_pago,
    comprobante,
    observacion,
    created_by,
    fecha_pago
  ) VALUES (
    p_puesto_id,
    p_socio_id,
    p_inquilino_id,
    p_monto_total,
    p_metodo_pago,
    nullif(trim(p_comprobante), ''),
    nullif(trim(p_observacion), ''),
    p_usuario_id,
    coalesce(p_fecha_pago, now())
  )
  RETURNING id, codigo_transaccion INTO v_pago_id, v_codigo;

  IF v_n > 0 THEN
    FOR v_idx IN 0 .. v_n - 1 LOOP
      v_linea := p_distribucion -> v_idx;
      v_monto_id := (v_linea ->> 'monto_id')::bigint;
      v_monto_aplicado := (v_linea ->> 'monto_aplicado')::numeric;

      INSERT INTO public.detalle_pagos (
        pago_id,
        monto_id,
        monto_aplicado,
        created_by
      ) VALUES (
        v_pago_id,
        v_monto_id,
        v_monto_aplicado,
        p_usuario_id
      );

      SELECT round(
        m.monto - coalesce(sum(dp.monto_aplicado) FILTER (WHERE dp.deleted_at IS NULL), 0),
        2
      )
      INTO v_saldo_restante
      FROM public.montos_por_cobrar m
      LEFT JOIN public.detalle_pagos dp ON dp.monto_id = m.id
      WHERE m.id = v_monto_id
      GROUP BY m.monto;

      UPDATE public.montos_por_cobrar
      SET estado = CASE
        WHEN v_saldo_restante <= 0.005 THEN 'Pagado'
        ELSE 'Pendiente'
      END
      WHERE id = v_monto_id AND deleted_at IS NULL;
    END LOOP;
  END IF;

  v_excedente := v_monto_disponible - v_total_aplicado;

  IF p_socio_id IS NOT NULL THEN
    UPDATE public.socios
    SET saldo_a_favor = saldo_a_favor
      - coalesce(p_saldo_utilizado, 0)
      + v_excedente
    WHERE id = p_socio_id;
  ELSE
    UPDATE public.inquilinos
    SET saldo_a_favor = saldo_a_favor
      - coalesce(p_saldo_utilizado, 0)
      + v_excedente
    WHERE id = p_inquilino_id;
  END IF;

  RETURN json_build_object(
    'pago_id', v_pago_id,
    'codigo_transaccion', v_codigo,
    'monto_aplicado', v_total_aplicado,
    'excedente', v_excedente
  );
END;
$function$;

-- -----------------------------------------------------------------------------
-- 3. RPC public.anular_pago (con bloqueo FOR UPDATE contra doble clic)
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.anular_pago(
  p_pago_id    bigint,
  p_motivo     text,
  p_usuario_id uuid
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path TO 'public'
AS $function$
DECLARE
  v_pago             record;
  v_detalle          record;
  v_ya_pagado        numeric(12,2);
  v_nuevo_estado     text;
  v_sum_aplicado     numeric(12,2) := 0;
  v_tabla_auditoria  boolean := false;
BEGIN
  IF p_motivo IS NULL OR trim(p_motivo) = '' THEN
    RAISE EXCEPTION 'El motivo de anulación no puede estar vacío.';
  END IF;

  SELECT * INTO v_pago
  FROM public.pagos
  WHERE id = p_pago_id
  FOR UPDATE;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Pago % no encontrado.', p_pago_id;
  END IF;
  IF v_pago.deleted_at IS NOT NULL THEN
    RAISE EXCEPTION 'El pago % ya está anulado.', p_pago_id;
  END IF;

  -- ── 1. Soft-delete del pago ───────────────────────────────────────────────
  UPDATE public.pagos
  SET
    deleted_at       = now(),
    anulado_por      = p_usuario_id,
    motivo_anulacion = p_motivo
  WHERE id = p_pago_id;

  -- ── 2. Soft-delete de detalles + restauración de estados de montos ─────────
  FOR v_detalle IN
    SELECT id, monto_id, monto_aplicado
    FROM   public.detalle_pagos
    WHERE  pago_id    = p_pago_id
      AND  deleted_at IS NULL
  LOOP
    UPDATE public.detalle_pagos
    SET
      deleted_at       = now(),
      anulado_por      = p_usuario_id,
      motivo_anulacion = p_motivo
    WHERE id = v_detalle.id;

    v_sum_aplicado := v_sum_aplicado + v_detalle.monto_aplicado;

    SELECT coalesce(sum(dp.monto_aplicado), 0)
    INTO   v_ya_pagado
    FROM   public.detalle_pagos dp
    WHERE  dp.monto_id   = v_detalle.monto_id
      AND  dp.deleted_at IS NULL;

    SELECT CASE WHEN v_ya_pagado >= m.monto THEN 'Pagado' ELSE 'Pendiente' END
    INTO   v_nuevo_estado
    FROM   public.montos_por_cobrar m
    WHERE  m.id = v_detalle.monto_id;

    UPDATE public.montos_por_cobrar
    SET    estado = v_nuevo_estado
    WHERE  id         = v_detalle.monto_id
      AND  estado    != 'Cancelado'
      AND  deleted_at IS NULL;
  END LOOP;

  -- ── 3. Revertir saldo_a_favor ─────────────────────────────────────────────
  -- saldo_delta_original = monto_total − v_sum_aplicado
  -- Para revertir: saldo_a_favor += v_sum_aplicado - monto_total
  IF v_pago.socio_id IS NOT NULL THEN
    UPDATE public.socios
    SET saldo_a_favor = saldo_a_favor + v_sum_aplicado - v_pago.monto_total
    WHERE id = v_pago.socio_id;
  ELSIF v_pago.inquilino_id IS NOT NULL THEN
    UPDATE public.inquilinos
    SET saldo_a_favor = saldo_a_favor + v_sum_aplicado - v_pago.monto_total
    WHERE id = v_pago.inquilino_id;
  END IF;

  -- ── 4. Auditoría ──────────────────────────────────────────────────────────
  SELECT EXISTS (
    SELECT 1 FROM information_schema.tables
    WHERE table_schema = 'public' AND table_name = 'auditoria'
  ) INTO v_tabla_auditoria;

  IF v_tabla_auditoria THEN
    BEGIN
      EXECUTE
        'INSERT INTO public.auditoria
           (tabla_afectada, registro_id, accion, valor_anterior, valor_nuevo, usuario_id)
         VALUES ($1, $2, $3, $4, $5, $6)'
      USING
        'pagos', p_pago_id::text, 'Anular',
        '{"deleted_at":null,"motivo_anulacion":null}'::jsonb,
        jsonb_build_object(
          'deleted_at',       now(),
          'motivo_anulacion', p_motivo,
          'anulado_por',      p_usuario_id::text,
          'saldo_revertido',  v_sum_aplicado - v_pago.monto_total
        ),
        p_usuario_id;
    EXCEPTION WHEN OTHERS THEN
      RAISE WARNING 'anular_pago: no se pudo insertar en auditoría: %', sqlerrm;
    END;
  END IF;

  RETURN jsonb_build_object(
    'ok',              true,
    'pago_id',         p_pago_id,
    'saldo_revertido', v_sum_aplicado - v_pago.monto_total,
    'mensaje',         'Pago anulado correctamente. Saldo a favor actualizado.'
  );
END;
$function$;

-- -----------------------------------------------------------------------------
-- 4. RPC public.rpc_cc_detalle_persona: conservar detalle en pagos anulados
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.rpc_cc_detalle_persona(
  p_tipo text,
  p_id   bigint
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path TO 'public'
AS $function$
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
                AND  (p.deleted_at IS NOT NULL OR dp2.deleted_at IS NULL)
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
$function$;

-- -----------------------------------------------------------------------------
-- 5. RPCs de Central de Reportes: excluir recibos S/ 0.00 del conteo de caja
--    e identificar "Saldo a favor" en el drill-down por concepto
-- -----------------------------------------------------------------------------
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
            count(*)         FILTER (WHERE deleted_at IS NULL AND monto_total > 0)           AS cnt,
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

    -- ── KPIs de banco ─────────────────────────────────────────────────────────
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

    -- ── Desglose por concepto ─────────────────────────────────────────────────
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

            SELECT
                coalesce(c.nombre, 'Sin concepto'), i.monto, 1, 0, 0
            FROM public.ingresos_internos i
            LEFT JOIN public.conceptos c ON c.id = i.concepto_id
            WHERE i.deleted_at IS NULL
              AND i.fecha_ingreso >= v_ts_ini AND i.fecha_ingreso < v_ts_fin
              AND p_tipo_pagador = 'todos'

            UNION ALL

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
            CASE
              WHEN p.monto_total = 0 THEN 'Saldo a favor'
              ELSE p.metodo_pago
            END                                                      AS metodo_pago,
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

COMMIT;
