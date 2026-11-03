-- =============================================================================
-- Migración 00099 — Fase 3: Optimización set-based del cálculo masivo de deudas
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Objetivo
--   Eliminar el patrón N+1 (una ejecución de fn_deudas_pagador por persona)
--   en las cuatro RPC de listado masivo:
--     1. public.rpc_cc_listar_personas()       (Cuenta Corriente)
--     2. public.rpc_reporte_resumen_deudas()   (Resumen de Deudas)
--     3. public.rpc_asambleas_padron()         (Padrón de Asambleas)
--     4. public.rpc_dashboard_ejecutivo()      (Dashboard: morosidad/conceptos)
--
-- Garantías de diseño
--   * public.fn_deudas_pagador(p_tipo, p_id) NO se modifica (Caja, Portal
--     Público y detalle individual de Cuenta Corriente siguen usándola).
--   * La nueva función auxiliar public.fn_resumen_deudas_por_pagador()
--     replica exactamente las reglas de fn_deudas_pagador:
--       - mc.deleted_at IS NULL, mc.estado <> 'Cancelado'
--       - INNER JOIN conceptos (igual que fn_deudas_pagador)
--       - pagos activos (dp.deleted_at IS NULL)
--       - saldo = round(monto - pagado, 2) > 0
--       - vínculo socio: socio_id | titularidad vigente | almacén vigente
--       - vínculo inquilino: inquilino_id | arriendo vigente | almacén vigente
--     Conserva el comportamiento actual de los casos especiales conocidos
--     (cargos del puesto 34-E sin pagador vigente y cargos del puesto 58
--     visibles para socio titular e inquilino); esas incidencias se tratan
--     por separado y NO se corrigen en esta migración.
--   * Las cuatro RPC conservan firma, tipo de retorno, LANGUAGE plpgsql,
--     volatilidad (VOLATILE), SECURITY DEFINER, search_path, propietario,
--     permisos EXECUTE (CREATE OR REPLACE preserva owner y ACL), control de
--     rol mediante get_my_rol() y estructura JSON de salida.
--   * La función auxiliar es SECURITY INVOKER y se revoca EXECUTE a PUBLIC,
--     anon y authenticated (los privilegios por defecto del esquema public
--     en Supabase la concederían automáticamente).
--
-- Reversión: supabase/rollback/00099_rollback_optimizacion_deudas_set_based.sql
-- =============================================================================

BEGIN;

SET LOCAL lock_timeout = '5s';
SET LOCAL statement_timeout = '60s';

-- -----------------------------------------------------------------------------
-- 0. Verificación previa: las definiciones vigentes deben ser las auditadas.
--    Si alguna función cambió desde la auditoría, se aborta sin aplicar nada.
-- -----------------------------------------------------------------------------
DO $pre$
DECLARE
    v_esperado jsonb := jsonb_build_object(
        'rpc_cc_listar_personas',     '462ae0983a791a44e0e4a2c21698b30f',
        'rpc_reporte_resumen_deudas', '0561e8a22bffa97a35642858d60df01d',
        'rpc_asambleas_padron',       '8fc4e89e9964a249073f0655243ebe03',
        'rpc_dashboard_ejecutivo',    'd43bbee61a2d5ed515a2eeef50490782',
        'fn_deudas_pagador',          '6b06ff5f71940165bce36d2b424d1465'
    );
    v_nombre text;
    v_hash   text;
BEGIN
    FOR v_nombre IN SELECT jsonb_object_keys(v_esperado) LOOP
        SELECT md5(p.prosrc) INTO v_hash
        FROM pg_proc p JOIN pg_namespace n ON n.oid = p.pronamespace
        WHERE n.nspname = 'public' AND p.proname = v_nombre;
        IF v_hash IS DISTINCT FROM v_esperado ->> v_nombre THEN
            RAISE EXCEPTION '00099 abortada: public.% no coincide con la definición auditada (hash %, esperado %).',
                v_nombre, coalesce(v_hash, 'inexistente'), v_esperado ->> v_nombre;
        END IF;
    END LOOP;

    IF EXISTS (
        SELECT 1 FROM pg_proc p JOIN pg_namespace n ON n.oid = p.pronamespace
        WHERE n.nspname = 'public' AND p.proname = 'fn_resumen_deudas_por_pagador'
    ) THEN
        RAISE EXCEPTION '00099 abortada: public.fn_resumen_deudas_por_pagador ya existe.';
    END IF;
END
$pre$;

-- -----------------------------------------------------------------------------
-- 1. Función auxiliar set-based (una sola pasada para todos los pagadores)
-- -----------------------------------------------------------------------------
CREATE FUNCTION public.fn_resumen_deudas_por_pagador()
RETURNS TABLE (
    tipo            text,
    persona_id      bigint,
    deuda_pendiente numeric,
    cant_pendientes integer
)
LANGUAGE sql
STABLE
SECURITY INVOKER
SET search_path TO 'public'
AS $function$
    WITH pagos_por_monto AS (
        SELECT dp.monto_id,
               coalesce(sum(dp.monto_aplicado), 0)::numeric AS ya_pagado
        FROM public.detalle_pagos dp
        WHERE dp.deleted_at IS NULL
        GROUP BY dp.monto_id
    ),
    montos_pendientes AS (
        SELECT mc.id AS monto_id,
               mc.socio_id,
               mc.inquilino_id,
               mc.puesto_id,
               round(mc.monto - coalesce(pm.ya_pagado, 0), 2) AS saldo_pendiente
        FROM public.montos_por_cobrar mc
        JOIN public.conceptos c ON c.id = mc.concepto_id
        LEFT JOIN pagos_por_monto pm ON pm.monto_id = mc.id
        WHERE mc.deleted_at IS NULL
          AND mc.estado <> 'Cancelado'
          AND round(mc.monto - coalesce(pm.ya_pagado, 0), 2) > 0
    ),
    deudas_socio AS (
        SELECT mp.socio_id AS persona_id, mp.monto_id, mp.saldo_pendiente
        FROM montos_pendientes mp
        WHERE mp.socio_id IS NOT NULL
        UNION
        SELECT ht.socio_id, mp.monto_id, mp.saldo_pendiente
        FROM montos_pendientes mp
        JOIN public.historial_titularidad ht
          ON ht.puesto_id = mp.puesto_id AND ht.fecha_fin IS NULL
        UNION
        SELECT oa.socio_id, mp.monto_id, mp.saldo_pendiente
        FROM montos_pendientes mp
        JOIN public.ocupaciones_almacenes oa
          ON oa.puesto_id = mp.puesto_id AND oa.fecha_fin IS NULL
        WHERE oa.socio_id IS NOT NULL
    ),
    deudas_inquilino AS (
        SELECT mp.inquilino_id AS persona_id, mp.monto_id, mp.saldo_pendiente
        FROM montos_pendientes mp
        WHERE mp.inquilino_id IS NOT NULL
        UNION
        SELECT ha.inquilino_id, mp.monto_id, mp.saldo_pendiente
        FROM montos_pendientes mp
        JOIN public.historial_arriendos ha
          ON ha.puesto_id = mp.puesto_id AND ha.fecha_fin IS NULL
        UNION
        SELECT oa.inquilino_id, mp.monto_id, mp.saldo_pendiente
        FROM montos_pendientes mp
        JOIN public.ocupaciones_almacenes oa
          ON oa.puesto_id = mp.puesto_id AND oa.fecha_fin IS NULL
        WHERE oa.inquilino_id IS NOT NULL
    )
    SELECT 'socio'::text, ds.persona_id,
           sum(ds.saldo_pendiente)::numeric, count(*)::integer
    FROM deudas_socio ds
    GROUP BY ds.persona_id
    UNION ALL
    SELECT 'inquilino'::text, di.persona_id,
           sum(di.saldo_pendiente)::numeric, count(*)::integer
    FROM deudas_inquilino di
    GROUP BY di.persona_id;
$function$;

COMMENT ON FUNCTION public.fn_resumen_deudas_por_pagador() IS
'Fase 3 (00099): resumen set-based de deuda pendiente por socio/inquilino. Equivalente a sumar fn_deudas_pagador(tipo,id) con saldo_pendiente > 0. Uso interno exclusivo de RPC SECURITY DEFINER.';

REVOKE ALL ON FUNCTION public.fn_resumen_deudas_por_pagador() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.fn_resumen_deudas_por_pagador() FROM anon;
REVOKE ALL ON FUNCTION public.fn_resumen_deudas_por_pagador() FROM authenticated;
GRANT EXECUTE ON FUNCTION public.fn_resumen_deudas_por_pagador() TO service_role;

-- -----------------------------------------------------------------------------
-- 2. Cuenta Corriente
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.rpc_cc_listar_personas()
 RETURNS json
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  result json;
BEGIN
  IF public.get_my_rol() NOT IN ('Administrador', 'Caja') THEN
    RAISE EXCEPTION 'Acceso denegado.';
  END IF;

  WITH resumen AS (
    SELECT r.tipo, r.persona_id, r.deuda_pendiente
    FROM public.fn_resumen_deudas_por_pagador() r
  )
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
      coalesce(r.deuda_pendiente, 0)  AS deuda_pendiente
    FROM public.socios s
    LEFT JOIN public.historial_titularidad ht
           ON ht.socio_id = s.id AND ht.fecha_fin IS NULL
    LEFT JOIN public.puestos p ON p.id = ht.puesto_id
    LEFT JOIN resumen r ON r.tipo = 'socio' AND r.persona_id = s.id
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
      coalesce(r.deuda_pendiente, 0)  AS deuda_pendiente
    FROM public.inquilinos i
    LEFT JOIN public.historial_arriendos ha
           ON ha.inquilino_id = i.id AND ha.fecha_fin IS NULL
    LEFT JOIN public.puestos p ON p.id = ha.puesto_id
    LEFT JOIN resumen r ON r.tipo = 'inquilino' AND r.persona_id = i.id
    WHERE i.deleted_at IS NULL

  ) t;

  RETURN result;
END;
$function$;

-- -----------------------------------------------------------------------------
-- 3. Resumen de Deudas
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.rpc_reporte_resumen_deudas()
 RETURNS json
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_rol    text;
  v_result json;
BEGIN
  v_rol := public.get_my_rol();
  IF v_rol NOT IN ('Administrador', 'Caja') THEN
    RAISE EXCEPTION 'Acceso denegado: solo Administrador o Caja puede consultar el resumen de deudas.';
  END IF;

  WITH resumen AS (
    SELECT r.tipo, r.persona_id, r.deuda_pendiente, r.cant_pendientes
    FROM public.fn_resumen_deudas_por_pagador() r
  )
  SELECT coalesce(json_agg(t ORDER BY t.tipo, t.nombre), '[]'::json)
  INTO v_result
  FROM (
    -- ── SOCIOS ────────────────────────────────────────────────────────────────
    SELECT
      'socio'::text                   AS tipo,
      s.id,
      s.apellidos                     AS nombre,
      s.dni,
      s.estado,
      s.habilitado,
      coalesce(s.saldo_a_favor, 0)   AS saldo_a_favor,
      p.codigo_puesto,
      p.id                            AS puesto_id,
      coalesce(r.deuda_pendiente, 0)::numeric AS deuda_pendiente,
      coalesce(r.cant_pendientes, 0)::int      AS cant_pendientes
    FROM public.socios s
    LEFT JOIN public.historial_titularidad ht
           ON ht.socio_id = s.id AND ht.fecha_fin IS NULL
    LEFT JOIN public.puestos p ON p.id = ht.puesto_id
    LEFT JOIN resumen r ON r.tipo = 'socio' AND r.persona_id = s.id
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
      coalesce(i.saldo_a_favor, 0)   AS saldo_a_favor,
      p.codigo_puesto,
      p.id                            AS puesto_id,
      coalesce(r.deuda_pendiente, 0)::numeric AS deuda_pendiente,
      coalesce(r.cant_pendientes, 0)::int      AS cant_pendientes
    FROM public.inquilinos i
    LEFT JOIN public.historial_arriendos ha
           ON ha.inquilino_id = i.id AND ha.fecha_fin IS NULL
    LEFT JOIN public.puestos p ON p.id = ha.puesto_id
    LEFT JOIN resumen r ON r.tipo = 'inquilino' AND r.persona_id = i.id
    WHERE i.deleted_at IS NULL
  ) t;

  RETURN v_result;
END;
$function$;

-- -----------------------------------------------------------------------------
-- 4. Padrón de Asambleas
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.rpc_asambleas_padron()
 RETURNS json
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
    v_habiles       json;
    v_inhabilitados json;
BEGIN
    IF public.get_my_rol() NOT IN ('Administrador', 'Caja') THEN
        RAISE EXCEPTION 'Acceso denegado.';
    END IF;

    CREATE TEMP TABLE tmp_padron_electoral ON COMMIT DROP AS
    WITH resumen_socios AS (
        SELECT r.persona_id, r.deuda_pendiente
        FROM public.fn_resumen_deudas_por_pagador() r
        WHERE r.tipo = 'socio'
    )
    SELECT
        s.id,
        s.dni,
        s.nombres,
        s.apellidos,
        p.codigo_puesto,
        coalesce(rs.deuda_pendiente, 0)::numeric(12,2) AS deuda_total
    FROM public.socios s
    LEFT JOIN public.historial_titularidad ht
           ON ht.socio_id = s.id AND ht.fecha_fin IS NULL
    LEFT JOIN public.puestos p ON p.id = ht.puesto_id
    LEFT JOIN resumen_socios rs ON rs.persona_id = s.id
    WHERE s.deleted_at IS NULL
      AND s.estado = 'Activo';

    SELECT coalesce(json_agg(json_build_object(
        'id',            t.id,
        'dni',           t.dni,
        'nombres',       t.nombres,
        'apellidos',     t.apellidos,
        'codigo_puesto', t.codigo_puesto
    ) ORDER BY t.apellidos, t.nombres), '[]'::json)
    INTO v_habiles
    FROM tmp_padron_electoral t
    WHERE t.deuda_total = 0;

    SELECT coalesce(json_agg(json_build_object(
        'id',            t.id,
        'dni',           t.dni,
        'nombres',       t.nombres,
        'apellidos',     t.apellidos,
        'codigo_puesto', t.codigo_puesto,
        'deuda_total',   t.deuda_total
    ) ORDER BY t.deuda_total DESC, t.apellidos), '[]'::json)
    INTO v_inhabilitados
    FROM tmp_padron_electoral t
    WHERE t.deuda_total > 0;

    RETURN json_build_object(
        'generado_en',   (now() AT TIME ZONE 'America/Lima'),
        'total_activos', (SELECT count(*) FROM tmp_padron_electoral),
        'habiles',       v_habiles,
        'inhabilitados', v_inhabilitados
    );
END;
$function$;

-- -----------------------------------------------------------------------------
-- 5. Dashboard ejecutivo (una sola pasada para deuda_total y ranking)
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.rpc_dashboard_ejecutivo()
 RETURNS json
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
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

    -- ── Morosidad y ranking de conceptos: una sola lectura de saldos ─────────
    WITH pagos_por_monto AS (
        SELECT dp.monto_id, coalesce(sum(dp.monto_aplicado), 0) AS ya_pagado
        FROM public.detalle_pagos dp
        WHERE dp.deleted_at IS NULL
        GROUP BY dp.monto_id
    ),
    saldos AS (
        SELECT mc.concepto_id,
               mc.monto - coalesce(pm.ya_pagado, 0) AS saldo
        FROM public.montos_por_cobrar mc
        LEFT JOIN pagos_por_monto pm ON pm.monto_id = mc.id
        WHERE mc.deleted_at IS NULL
          AND mc.estado <> 'Cancelado'
          AND mc.monto - coalesce(pm.ya_pagado, 0) > 0
    )
    SELECT
        json_build_object(
            'personas_con_deuda', (SELECT count(*) FROM public.vw_morosos_filtrados),
            'total_personas',
                (SELECT count(*) FROM public.socios
                 WHERE deleted_at IS NULL AND estado = 'Activo')
              + (SELECT count(*) FROM public.inquilinos WHERE deleted_at IS NULL),
            'deuda_total', (SELECT round(coalesce(sum(s.saldo), 0), 2) FROM saldos s)
        ),
        (
            SELECT coalesce(json_agg(t ORDER BY t.monto DESC), '[]'::json)
            FROM (
                SELECT
                    coalesce(c.nombre, 'Sin concepto') AS concepto,
                    round(sum(s.saldo), 2) AS monto,
                    count(*)::int AS cantidad
                FROM saldos s
                LEFT JOIN public.conceptos c ON c.id = s.concepto_id
                GROUP BY coalesce(c.nombre, 'Sin concepto')
                ORDER BY 2 DESC
                LIMIT 8
            ) t
        )
    INTO v_morosidad, v_conceptos;

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
$function$;

-- -----------------------------------------------------------------------------
-- 6. Verificación posterior (dentro de la misma transacción)
-- -----------------------------------------------------------------------------
DO $post$
DECLARE
    v_oid oid := 'public.fn_resumen_deudas_por_pagador()'::regprocedure;
    v_fn  text;
BEGIN
    IF has_function_privilege('anon', v_oid, 'EXECUTE')
       OR has_function_privilege('authenticated', v_oid, 'EXECUTE') THEN
        RAISE EXCEPTION '00099 abortada: la función auxiliar quedó ejecutable por anon/authenticated.';
    END IF;

    FOREACH v_fn IN ARRAY ARRAY['rpc_cc_listar_personas','rpc_reporte_resumen_deudas',
                                'rpc_asambleas_padron','rpc_dashboard_ejecutivo'] LOOP
        IF NOT EXISTS (
            SELECT 1 FROM pg_proc p JOIN pg_namespace n ON n.oid = p.pronamespace
            WHERE n.nspname = 'public' AND p.proname = v_fn
              AND p.prosecdef AND p.provolatile = 'v'
              AND pg_get_userbyid(p.proowner) = 'postgres'
              AND p.proconfig = ARRAY['search_path=public']
        ) THEN
            RAISE EXCEPTION '00099 abortada: public.% no conserva sus propiedades (SECURITY DEFINER/VOLATILE/owner/search_path).', v_fn;
        END IF;
    END LOOP;
END
$post$;

COMMIT;
