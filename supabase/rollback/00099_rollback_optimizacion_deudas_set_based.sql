-- =============================================================================
-- ROLLBACK de la migración 00099 — Fase 3 (optimización set-based de deudas)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Restaura EXACTAMENTE las cuatro definiciones originales auditadas en
-- producción el 2026-11-03 (PostgreSQL 17.6), obtenidas con
-- pg_get_functiondef() y verificadas por hash md5(prosrc):
--   rpc_cc_listar_personas      462ae0983a791a44e0e4a2c21698b30f
--   rpc_reporte_resumen_deudas  0561e8a22bffa97a35642858d60df01d
--   rpc_asambleas_padron        8fc4e89e9964a249073f0655243ebe03
--   rpc_dashboard_ejecutivo     d43bbee61a2d5ed515a2eeef50490782
--
-- Los cuerpos se escriben como literales E'...' con \r y \n explícitos para
-- que el hash resultante sea idéntico al original con independencia de la
-- conversión de finales de línea de git (core.autocrlf) o del sistema
-- operativo desde el que se ejecute el script.
--
-- Propiedades conservadas: firma, RETURNS json, LANGUAGE plpgsql, VOLATILE,
-- SECURITY DEFINER, search_path=public, propietario y ACL (CREATE OR REPLACE
-- no altera propietario ni permisos).
--
-- La función auxiliar public.fn_resumen_deudas_por_pagador() se elimina SOLO
-- después de restaurar las cuatro RPC y SOLO si ninguna otra función o vista
-- depende de ella; en caso contrario se aborta TODO el rollback (transacción
-- única) y la base queda exactamente como estaba antes de ejecutarlo.
--
-- Es idempotente: puede ejecutarse aunque la 00099 no se haya aplicado.
-- =============================================================================

BEGIN;

SET LOCAL lock_timeout = '5s';
SET LOCAL statement_timeout = '60s';

-- -----------------------------------------------------------------------------
-- 1. public.rpc_cc_listar_personas()  — md5(prosrc) esperado 462ae0983a791a44e0e4a2c21698b30f
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.rpc_cc_listar_personas()
 RETURNS json
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS
E'\r\n'
 'DECLARE\r\n'
 '  result json;\r\n'
 'BEGIN\r\n'
 '  IF public.get_my_rol() NOT IN (\'Administrador\', \'Caja\') THEN\r\n'
 '    RAISE EXCEPTION \'Acceso denegado.\';\r\n'
 '  END IF;\r\n'
 '\r\n'
 '  SELECT coalesce(json_agg(t ORDER BY t.tipo, t.nombre), \'[]\'::json)\r\n'
 '  INTO result\r\n'
 '  FROM (\r\n'
 '\r\n'
 '    -- ── SOCIOS ────────────────────────────────────────────────────────────────\r\n'
 '    SELECT\r\n'
 '      \'socio\'::text                   AS tipo,\r\n'
 '      s.id,\r\n'
 '      s.apellidos                     AS nombre,\r\n'
 '      s.dni,\r\n'
 '      s.estado,\r\n'
 '      s.habilitado,\r\n'
 '      s.saldo_a_favor,\r\n'
 '      p.codigo_puesto,\r\n'
 '      p.id                            AS puesto_id,\r\n'
 '      coalesce(\r\n'
 '        (\r\n'
 '          SELECT sum(d.saldo_pendiente)\r\n'
 '          FROM   public.fn_deudas_pagador(\'socio\', s.id) d\r\n'
 '          WHERE  d.saldo_pendiente > 0\r\n'
 '        ), 0\r\n'
 '      )                               AS deuda_pendiente\r\n'
 '    FROM public.socios s\r\n'
 '    LEFT JOIN public.historial_titularidad ht\r\n'
 '           ON ht.socio_id = s.id AND ht.fecha_fin IS NULL\r\n'
 '    LEFT JOIN public.puestos p ON p.id = ht.puesto_id\r\n'
 '    WHERE s.deleted_at IS NULL\r\n'
 '\r\n'
 '    UNION ALL\r\n'
 '\r\n'
 '    -- ── INQUILINOS ────────────────────────────────────────────────────────────\r\n'
 '    SELECT\r\n'
 '      \'inquilino\'::text               AS tipo,\r\n'
 '      i.id,\r\n'
 '      i.apellidos                     AS nombre,\r\n'
 '      i.dni,\r\n'
 '      \'Activo\'::text                  AS estado,\r\n'
 '      NULL::boolean                   AS habilitado,\r\n'
 '      i.saldo_a_favor,\r\n'
 '      p.codigo_puesto,\r\n'
 '      p.id                            AS puesto_id,\r\n'
 '      coalesce(\r\n'
 '        (\r\n'
 '          SELECT sum(d.saldo_pendiente)\r\n'
 '          FROM   public.fn_deudas_pagador(\'inquilino\', i.id) d\r\n'
 '          WHERE  d.saldo_pendiente > 0\r\n'
 '        ), 0\r\n'
 '      )                               AS deuda_pendiente\r\n'
 '    FROM public.inquilinos i\r\n'
 '    LEFT JOIN public.historial_arriendos ha\r\n'
 '           ON ha.inquilino_id = i.id AND ha.fecha_fin IS NULL\r\n'
 '    LEFT JOIN public.puestos p ON p.id = ha.puesto_id\r\n'
 '    WHERE i.deleted_at IS NULL\r\n'
 '\r\n'
 '  ) t;\r\n'
 '\r\n'
 '  RETURN result;\r\n'
 'END;\r\n';

-- -----------------------------------------------------------------------------
-- 2. public.rpc_reporte_resumen_deudas()  — md5(prosrc) esperado 0561e8a22bffa97a35642858d60df01d
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.rpc_reporte_resumen_deudas()
 RETURNS json
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS
E'\r\n'
 'DECLARE\r\n'
 '  v_rol    text;\r\n'
 '  v_result json;\r\n'
 'BEGIN\r\n'
 '  v_rol := public.get_my_rol();\r\n'
 '  IF v_rol NOT IN (\'Administrador\', \'Caja\') THEN\r\n'
 '    RAISE EXCEPTION \'Acceso denegado: solo Administrador o Caja puede consultar el resumen de deudas.\';\r\n'
 '  END IF;\r\n'
 '\r\n'
 '  SELECT coalesce(json_agg(t ORDER BY t.tipo, t.nombre), \'[]\'::json)\r\n'
 '  INTO v_result\r\n'
 '  FROM (\r\n'
 '    -- ── SOCIOS ────────────────────────────────────────────────────────────────\r\n'
 '    SELECT\r\n'
 '      \'socio\'::text                   AS tipo,\r\n'
 '      s.id,\r\n'
 '      s.apellidos                     AS nombre,\r\n'
 '      s.dni,\r\n'
 '      s.estado,\r\n'
 '      s.habilitado,\r\n'
 '      coalesce(s.saldo_a_favor, 0)   AS saldo_a_favor,\r\n'
 '      p.codigo_puesto,\r\n'
 '      p.id                            AS puesto_id,\r\n'
 '      coalesce(deu.total, 0)::numeric AS deuda_pendiente,\r\n'
 '      coalesce(deu.cant, 0)::int      AS cant_pendientes\r\n'
 '    FROM public.socios s\r\n'
 '    LEFT JOIN public.historial_titularidad ht\r\n'
 '           ON ht.socio_id = s.id AND ht.fecha_fin IS NULL\r\n'
 '    LEFT JOIN public.puestos p ON p.id = ht.puesto_id\r\n'
 '    CROSS JOIN LATERAL (\r\n'
 '      SELECT\r\n'
 '        coalesce(sum(d.saldo_pendiente), 0)::numeric AS total,\r\n'
 '        count(*)::int                                 AS cant\r\n'
 '      FROM public.fn_deudas_pagador(\'socio\', s.id) d\r\n'
 '      WHERE d.saldo_pendiente > 0\r\n'
 '    ) deu\r\n'
 '    WHERE s.deleted_at IS NULL\r\n'
 '\r\n'
 '    UNION ALL\r\n'
 '\r\n'
 '    -- ── INQUILINOS ────────────────────────────────────────────────────────────\r\n'
 '    SELECT\r\n'
 '      \'inquilino\'::text               AS tipo,\r\n'
 '      i.id,\r\n'
 '      i.apellidos                     AS nombre,\r\n'
 '      i.dni,\r\n'
 '      \'Activo\'::text                  AS estado,\r\n'
 '      NULL::boolean                   AS habilitado,\r\n'
 '      coalesce(i.saldo_a_favor, 0)   AS saldo_a_favor,\r\n'
 '      p.codigo_puesto,\r\n'
 '      p.id                            AS puesto_id,\r\n'
 '      coalesce(deu.total, 0)::numeric AS deuda_pendiente,\r\n'
 '      coalesce(deu.cant, 0)::int      AS cant_pendientes\r\n'
 '    FROM public.inquilinos i\r\n'
 '    LEFT JOIN public.historial_arriendos ha\r\n'
 '           ON ha.inquilino_id = i.id AND ha.fecha_fin IS NULL\r\n'
 '    LEFT JOIN public.puestos p ON p.id = ha.puesto_id\r\n'
 '    CROSS JOIN LATERAL (\r\n'
 '      SELECT\r\n'
 '        coalesce(sum(d.saldo_pendiente), 0)::numeric AS total,\r\n'
 '        count(*)::int                                 AS cant\r\n'
 '      FROM public.fn_deudas_pagador(\'inquilino\', i.id) d\r\n'
 '      WHERE d.saldo_pendiente > 0\r\n'
 '    ) deu\r\n'
 '    WHERE i.deleted_at IS NULL\r\n'
 '  ) t;\r\n'
 '\r\n'
 '  RETURN v_result;\r\n'
 'END;\r\n';

-- -----------------------------------------------------------------------------
-- 3. public.rpc_asambleas_padron()  — md5(prosrc) esperado 8fc4e89e9964a249073f0655243ebe03
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.rpc_asambleas_padron()
 RETURNS json
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS
E'\r\n'
 'DECLARE\r\n'
 '    v_habiles       json;\r\n'
 '    v_inhabilitados json;\r\n'
 'BEGIN\r\n'
 '    IF public.get_my_rol() NOT IN (\'Administrador\', \'Caja\') THEN\r\n'
 '        RAISE EXCEPTION \'Acceso denegado.\';\r\n'
 '    END IF;\r\n'
 '\r\n'
 '    CREATE TEMP TABLE tmp_padron_electoral ON COMMIT DROP AS\r\n'
 '    SELECT\r\n'
 '        s.id,\r\n'
 '        s.dni,\r\n'
 '        s.nombres,\r\n'
 '        s.apellidos,\r\n'
 '        p.codigo_puesto,\r\n'
 '        coalesce(\r\n'
 '            (SELECT sum(d.saldo_pendiente)\r\n'
 '             FROM public.fn_deudas_pagador(\'socio\', s.id) d\r\n'
 '             WHERE d.saldo_pendiente > 0),\r\n'
 '            0\r\n'
 '        )::numeric(12,2) AS deuda_total\r\n'
 '    FROM public.socios s\r\n'
 '    LEFT JOIN public.historial_titularidad ht\r\n'
 '           ON ht.socio_id = s.id AND ht.fecha_fin IS NULL\r\n'
 '    LEFT JOIN public.puestos p ON p.id = ht.puesto_id\r\n'
 '    WHERE s.deleted_at IS NULL\r\n'
 '      AND s.estado = \'Activo\';\r\n'
 '\r\n'
 '    SELECT coalesce(json_agg(json_build_object(\r\n'
 '        \'id\',            t.id,\r\n'
 '        \'dni\',           t.dni,\r\n'
 '        \'nombres\',       t.nombres,\r\n'
 '        \'apellidos\',     t.apellidos,\r\n'
 '        \'codigo_puesto\', t.codigo_puesto\r\n'
 '    ) ORDER BY t.apellidos, t.nombres), \'[]\'::json)\r\n'
 '    INTO v_habiles\r\n'
 '    FROM tmp_padron_electoral t\r\n'
 '    WHERE t.deuda_total = 0;\r\n'
 '\r\n'
 '    SELECT coalesce(json_agg(json_build_object(\r\n'
 '        \'id\',            t.id,\r\n'
 '        \'dni\',           t.dni,\r\n'
 '        \'nombres\',       t.nombres,\r\n'
 '        \'apellidos\',     t.apellidos,\r\n'
 '        \'codigo_puesto\', t.codigo_puesto,\r\n'
 '        \'deuda_total\',   t.deuda_total\r\n'
 '    ) ORDER BY t.deuda_total DESC, t.apellidos), \'[]\'::json)\r\n'
 '    INTO v_inhabilitados\r\n'
 '    FROM tmp_padron_electoral t\r\n'
 '    WHERE t.deuda_total > 0;\r\n'
 '\r\n'
 '    RETURN json_build_object(\r\n'
 '        \'generado_en\',   (now() AT TIME ZONE \'America/Lima\'),\r\n'
 '        \'total_activos\', (SELECT count(*) FROM tmp_padron_electoral),\r\n'
 '        \'habiles\',       v_habiles,\r\n'
 '        \'inhabilitados\', v_inhabilitados\r\n'
 '    );\r\n'
 'END;\r\n';

-- -----------------------------------------------------------------------------
-- 4. public.rpc_dashboard_ejecutivo()  — md5(prosrc) esperado d43bbee61a2d5ed515a2eeef50490782
-- -----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.rpc_dashboard_ejecutivo()
 RETURNS json
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS
E'\n'
 'DECLARE\n'
 '    v_hoy        date := (now() AT TIME ZONE \'America/Lima\')::date;\n'
 '    v_desde      date := date_trunc(\'month\', (now() AT TIME ZONE \'America/Lima\'))::date;\n'
 '    v_resumen    json;\n'
 '    v_morosidad  json;\n'
 '    v_conceptos  json;\n'
 'BEGIN\n'
 '    IF public.get_my_rol() NOT IN (\'Administrador\', \'Caja\') THEN\n'
 '        RAISE EXCEPTION \'Acceso denegado.\';\n'
 '    END IF;\n'
 '\n'
 '    -- ── Mes en curso: misma fuente que la Central de Reportes (00085) ────────\n'
 '    v_resumen := public.rpc_reporte_resumen(v_desde, v_hoy, \'todos\');\n'
 '\n'
 '    -- ── Morosidad: personas con deuda vencida vs padrón activo ───────────────\n'
 '    SELECT json_build_object(\n'
 '        \'personas_con_deuda\', (SELECT count(*) FROM public.vw_morosos_filtrados),\n'
 '        \'total_personas\',\n'
 '            (SELECT count(*) FROM public.socios\n'
 '             WHERE deleted_at IS NULL AND estado = \'Activo\')\n'
 '          + (SELECT count(*) FROM public.inquilinos WHERE deleted_at IS NULL),\n'
 '        \'deuda_total\', (\n'
 '            SELECT round(coalesce(sum(mc.monto - pag.ya_pagado), 0), 2)\n'
 '            FROM public.montos_por_cobrar mc\n'
 '            CROSS JOIN LATERAL (\n'
 '                SELECT coalesce(sum(dp.monto_aplicado), 0) AS ya_pagado\n'
 '                FROM public.detalle_pagos dp\n'
 '                WHERE dp.monto_id = mc.id AND dp.deleted_at IS NULL\n'
 '            ) pag\n'
 '            WHERE mc.deleted_at IS NULL\n'
 '              AND mc.estado <> \'Cancelado\'\n'
 '              AND mc.monto - pag.ya_pagado > 0\n'
 '        )\n'
 '    ) INTO v_morosidad;\n'
 '\n'
 '    -- ── Ranking: conceptos con mayor deuda pendiente ─────────────────────────\n'
 '    SELECT coalesce(json_agg(t ORDER BY t.monto DESC), \'[]\'::json)\n'
 '    INTO v_conceptos\n'
 '    FROM (\n'
 '        SELECT\n'
 '            coalesce(c.nombre, \'Sin concepto\') AS concepto,\n'
 '            round(sum(mc.monto - pag.ya_pagado), 2) AS monto,\n'
 '            count(*)::int AS cantidad\n'
 '        FROM public.montos_por_cobrar mc\n'
 '        LEFT JOIN public.conceptos c ON c.id = mc.concepto_id\n'
 '        CROSS JOIN LATERAL (\n'
 '            SELECT coalesce(sum(dp.monto_aplicado), 0) AS ya_pagado\n'
 '            FROM public.detalle_pagos dp\n'
 '            WHERE dp.monto_id = mc.id AND dp.deleted_at IS NULL\n'
 '        ) pag\n'
 '        WHERE mc.deleted_at IS NULL\n'
 '          AND mc.estado <> \'Cancelado\'\n'
 '          AND mc.monto - pag.ya_pagado > 0\n'
 '        GROUP BY coalesce(c.nombre, \'Sin concepto\')\n'
 '        ORDER BY 2 DESC\n'
 '        LIMIT 8\n'
 '    ) t;\n'
 '\n'
 '    RETURN json_build_object(\n'
 '        \'mes\', json_build_object(\n'
 '            \'desde\',    v_desde,\n'
 '            \'hasta\',    v_hoy,\n'
 '            \'ingresos\', (v_resumen->\'caja\'->>\'efectivo\')::numeric\n'
 '                      + (v_resumen->\'caja\'->>\'transferencia\')::numeric,\n'
 '            \'egresos\',  (v_resumen->\'caja\'->>\'egresos\')::numeric\n'
 '        ),\n'
 '        \'morosidad\',          v_morosidad,\n'
 '        \'deuda_por_concepto\', v_conceptos\n'
 '    );\n'
 'END;\n';

-- -----------------------------------------------------------------------------
-- 5. Eliminación segura de la función auxiliar
-- -----------------------------------------------------------------------------
DO $guard$
DECLARE
    v_dependientes text;
BEGIN
    SELECT string_agg(n.nspname || '.' || p.proname, ', ')
    INTO v_dependientes
    FROM pg_proc p JOIN pg_namespace n ON n.oid = p.pronamespace
    WHERE p.prosrc ILIKE '%fn_resumen_deudas_por_pagador%'
      AND p.proname <> 'fn_resumen_deudas_por_pagador'
      AND n.nspname NOT IN ('pg_catalog', 'information_schema');

    IF v_dependientes IS NOT NULL THEN
        RAISE EXCEPTION 'Rollback 00099 abortado: aún dependen de fn_resumen_deudas_por_pagador: %', v_dependientes;
    END IF;
END
$guard$;

-- RESTRICT: falla (y revierte todo) si existe una vista u objeto dependiente.
DROP FUNCTION IF EXISTS public.fn_resumen_deudas_por_pagador() RESTRICT;

-- -----------------------------------------------------------------------------
-- 6. Verificación final: si algo no coincide, se revierte todo el rollback.
-- -----------------------------------------------------------------------------
DO $verif$
DECLARE
    v_esperado jsonb := jsonb_build_object(
        'rpc_cc_listar_personas',     '462ae0983a791a44e0e4a2c21698b30f',
        'rpc_reporte_resumen_deudas', '0561e8a22bffa97a35642858d60df01d',
        'rpc_asambleas_padron',       '8fc4e89e9964a249073f0655243ebe03',
        'rpc_dashboard_ejecutivo',    'd43bbee61a2d5ed515a2eeef50490782'
    );
    v_nombre text;
    r record;
BEGIN
    FOR v_nombre IN SELECT jsonb_object_keys(v_esperado) LOOP
        SELECT md5(p.prosrc) AS h, p.prosecdef, p.provolatile, p.proconfig,
               pg_get_userbyid(p.proowner) AS owner, p.proacl::text AS acl,
               pg_get_function_identity_arguments(p.oid) AS args,
               pg_get_function_result(p.oid) AS res
        INTO r
        FROM pg_proc p JOIN pg_namespace n ON n.oid = p.pronamespace
        WHERE n.nspname = 'public' AND p.proname = v_nombre;

        IF r.h IS DISTINCT FROM v_esperado ->> v_nombre THEN
            RAISE EXCEPTION 'Rollback 00099: hash de public.% = %, esperado %', v_nombre, r.h, v_esperado ->> v_nombre;
        END IF;
        IF NOT r.prosecdef OR r.provolatile <> 'v' OR r.owner <> 'postgres'
           OR r.proconfig IS DISTINCT FROM ARRAY['search_path=public']
           OR r.args <> '' OR r.res <> 'json' THEN
            RAISE EXCEPTION 'Rollback 00099: propiedades de public.% no coinciden con el original', v_nombre;
        END IF;
        IF r.acl IS DISTINCT FROM '{=X/postgres,postgres=X/postgres,anon=X/postgres,authenticated=X/postgres,service_role=X/postgres}' THEN
            RAISE EXCEPTION 'Rollback 00099: ACL de public.% = %, esperado {=X/postgres,postgres=X/postgres,anon=X/postgres,authenticated=X/postgres,service_role=X/postgres}', v_nombre, r.acl;
        END IF;
    END LOOP;

    IF to_regprocedure('public.fn_resumen_deudas_por_pagador()') IS NOT NULL THEN
        RAISE EXCEPTION 'Rollback 00099: la función auxiliar sigue existiendo';
    END IF;
END
$verif$;

COMMIT;
