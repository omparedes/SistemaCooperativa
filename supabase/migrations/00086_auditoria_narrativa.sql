-- =============================================================================
-- Migración 00086 — Auditoría Narrativa (Timeline ERP)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
--   1. audit_logs.motivo — justificación de acciones críticas.
--   2. log_audit_action() v2 — captura el motivo desde la variable de sesión
--      transaccional app.audit_motivo (set_config(..., true) se autolimpia).
--   3. Triggers nuevos: ocupaciones_almacenes, gastos, caja_ajustes.
--   4. rpc_actualizar_con_motivo — ediciones del padrón con whitelist dura de
--      columnas, para que el motivo viaje en un UPDATE directo.
--   5. rpc_cc_editar_pago v2 — misma firma + p_motivo; elimina el bloque
--      muerto que insertaba en la tabla inexistente `auditoria`.
--   6. rpc_auditoria_timeline — narrativa resuelta server-side: actor + rol,
--      entidad legible, deltas campo a campo, acción semántica y motivo
--      (incluye motivos históricos vía motivo_anulacion / motivo_cierre).
--
-- No se auditan montos_por_cobrar / detalle_pagos a propósito: la facturación
-- mensual generaría ~1,700 filas de ruido por ciclo; esos movimientos quedan
-- narrados a través del evento del pago.
-- =============================================================================

BEGIN;

-- =============================================================================
-- 1. Columna motivo (nullable — los logs históricos siguen siendo válidos)
-- =============================================================================
ALTER TABLE public.audit_logs
  ADD COLUMN IF NOT EXISTS motivo text;

COMMENT ON COLUMN public.audit_logs.motivo IS
  'Justificación de la acción, capturada desde la variable transaccional '
  'app.audit_motivo por log_audit_action(). NULL en operaciones sin motivo. (00086)';

-- =============================================================================
-- 2. log_audit_action() v2 — lee app.audit_motivo (local a la transacción)
-- =============================================================================
CREATE OR REPLACE FUNCTION public.log_audit_action()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    INSERT INTO public.audit_logs (table_name, record_id, action, old_data, new_data, changed_by, motivo)
    VALUES (
        tg_table_name,
        CASE tg_op
            WHEN 'DELETE' THEN to_jsonb(old) ->> 'id'
            ELSE               to_jsonb(new) ->> 'id'
        END,
        tg_op,
        CASE tg_op WHEN 'INSERT' THEN NULL ELSE to_jsonb(old) END,
        CASE tg_op WHEN 'DELETE' THEN NULL ELSE to_jsonb(new) END,
        auth.uid(),
        nullif(trim(coalesce(current_setting('app.audit_motivo', true), '')), '')
    );
    RETURN NULL;
END;
$$;

COMMENT ON FUNCTION public.log_audit_action() IS
    'Trigger AFTER INSERT|UPDATE|DELETE genérico. Inserta en audit_logs con SECURITY DEFINER. '
    'Captura usuario (auth.uid()) y motivo (variable transaccional app.audit_motivo). (00016 → 00086)';

-- =============================================================================
-- 3. Triggers nuevos: almacenes, gastos y ajustes de caja
-- =============================================================================
DROP TRIGGER IF EXISTS trg_audit_ocupaciones_almacenes ON public.ocupaciones_almacenes;
CREATE TRIGGER trg_audit_ocupaciones_almacenes
    AFTER INSERT OR UPDATE OR DELETE ON public.ocupaciones_almacenes
    FOR EACH ROW EXECUTE FUNCTION public.log_audit_action();

DROP TRIGGER IF EXISTS trg_audit_gastos ON public.gastos;
CREATE TRIGGER trg_audit_gastos
    AFTER INSERT OR UPDATE OR DELETE ON public.gastos
    FOR EACH ROW EXECUTE FUNCTION public.log_audit_action();

DROP TRIGGER IF EXISTS trg_audit_caja_ajustes ON public.caja_ajustes;
CREATE TRIGGER trg_audit_caja_ajustes
    AFTER INSERT OR UPDATE OR DELETE ON public.caja_ajustes
    FOR EACH ROW EXECUTE FUNCTION public.log_audit_action();

-- =============================================================================
-- 4. rpc_actualizar_con_motivo — ediciones del padrón con motivo opcional
--    Whitelist dura de tablas y columnas: nada financiero es editable por aquí.
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_actualizar_con_motivo(
    p_tabla  text,
    p_id     bigint,
    p_patch  jsonb,
    p_motivo text DEFAULT NULL
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_permitidas text[];
    v_key        text;
    v_set        text := '';
    v_rows       int;
BEGIN
    IF public.get_my_rol() NOT IN ('Administrador', 'Caja') THEN
        RAISE EXCEPTION 'Acceso denegado.';
    END IF;

    v_permitidas := CASE p_tabla
        WHEN 'socios'     THEN ARRAY['nombres','apellidos','dni','email','telefono','direccion','fecha_ingreso','estado','habilitado']
        WHEN 'inquilinos' THEN ARRAY['nombres','apellidos','dni','email','telefono','direccion']
        ELSE NULL
    END;
    IF v_permitidas IS NULL THEN
        RAISE EXCEPTION 'Tabla no editable por esta vía: %.', p_tabla;
    END IF;

    IF p_patch IS NULL OR p_patch = '{}'::jsonb THEN
        RAISE EXCEPTION 'p_patch vacío: nada que actualizar.';
    END IF;

    FOR v_key IN SELECT jsonb_object_keys(p_patch)
    LOOP
        IF NOT (v_key = ANY (v_permitidas)) THEN
            RAISE EXCEPTION 'Columna "%" no permitida para la tabla %.', v_key, p_tabla;
        END IF;
        v_set := v_set
            || CASE WHEN v_set = '' THEN '' ELSE ', ' END
            || format('%I = %L', v_key, p_patch ->> v_key);
    END LOOP;

    -- El motivo viaja a audit_logs vía el trigger (variable local a la transacción)
    PERFORM set_config('app.audit_motivo', coalesce(p_motivo, ''), true);

    EXECUTE format(
        'UPDATE public.%I SET %s, updated_at = now() WHERE id = %L AND deleted_at IS NULL',
        p_tabla, v_set, p_id
    );

    GET DIAGNOSTICS v_rows = ROW_COUNT;
    IF v_rows = 0 THEN
        RAISE EXCEPTION '% id=% no encontrado o dado de baja.', initcap(p_tabla), p_id;
    END IF;
END;
$$;

COMMENT ON FUNCTION public.rpc_actualizar_con_motivo(text, bigint, jsonb, text) IS
    'Edición del padrón (socios/inquilinos) con whitelist dura de columnas y motivo '
    'opcional que viaja al audit trail vía app.audit_motivo. Rol Admin|Caja. (00086)';

GRANT EXECUTE ON FUNCTION public.rpc_actualizar_con_motivo(text, bigint, jsonb, text) TO authenticated;

-- =============================================================================
-- 5. rpc_cc_editar_pago v2 — p_motivo + limpieza del bloque muerto `auditoria`
--    DROP de la firma anterior (3 args) para no dejar una sobrecarga ambigua.
-- =============================================================================
DROP FUNCTION IF EXISTS public.rpc_cc_editar_pago(bigint, text, timestamptz);

CREATE FUNCTION public.rpc_cc_editar_pago(
    p_pago_id     bigint,
    p_comprobante text,
    p_fecha_pago  timestamptz,
    p_motivo      text DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_pago record;
BEGIN
    IF public.get_my_rol() NOT IN ('Administrador', 'Caja') THEN
        RAISE EXCEPTION 'Acceso denegado: solo Administrador o Caja puede editar pagos.';
    END IF;

    SELECT * INTO v_pago FROM public.pagos WHERE id = p_pago_id;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Pago % no encontrado.', p_pago_id;
    END IF;
    IF v_pago.deleted_at IS NOT NULL THEN
        RAISE EXCEPTION 'El pago % está anulado y no puede editarse.', p_pago_id;
    END IF;

    -- El trigger de pagos captura el UPDATE; el motivo viaja a audit_logs.
    PERFORM set_config('app.audit_motivo', coalesce(p_motivo, ''), true);

    UPDATE public.pagos
    SET
        comprobante = CASE
            WHEN p_comprobante IS NOT NULL THEN nullif(trim(p_comprobante), '')
            ELSE comprobante
        END,
        fecha_pago  = coalesce(p_fecha_pago, fecha_pago),
        updated_at  = now()
    WHERE id = p_pago_id;

    RETURN jsonb_build_object(
        'ok',      true,
        'pago_id', p_pago_id,
        'mensaje', 'Pago actualizado correctamente.'
    );
END;
$$;

COMMENT ON FUNCTION public.rpc_cc_editar_pago(bigint, text, timestamptz, text) IS
    'Edita comprobante y/o fecha_pago de un pago vigente, con motivo opcional hacia '
    'audit_logs. Reemplaza la versión 00031 (eliminado el insert a la tabla '
    'inexistente `auditoria`; el trigger de pagos ya audita el cambio). (00086)';

GRANT EXECUTE ON FUNCTION public.rpc_cc_editar_pago(bigint, text, timestamptz, text) TO authenticated;

-- =============================================================================
-- 6. rpc_auditoria_timeline — narrativa resuelta server-side
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_auditoria_timeline(
    p_limit    int         DEFAULT 50,
    p_before   timestamptz DEFAULT NULL,
    p_tabla    text        DEFAULT NULL,
    p_accion   text        DEFAULT NULL,
    p_busqueda text        DEFAULT NULL
)
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_result json;
BEGIN
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede ver la auditoría.';
    END IF;

    SELECT coalesce(json_agg(e.evento ORDER BY e.created_at DESC), '[]'::json)
    INTO v_result
    FROM (
        SELECT
            b.created_at,
            json_build_object(
                'id',          b.id,
                'fecha',       b.created_at,
                'tabla',       b.table_name,
                'registro_id', b.record_id,
                'accion',      b.accion,
                'actor',       json_build_object('nombre', b.actor_nombre, 'rol', b.actor_rol),
                'entidad',     b.entidad,
                'resumen',     b.resumen,
                'cambios',     coalesce(b.cambios, '[]'::json),
                'motivo',      b.motivo
            ) AS evento
        FROM (
            SELECT
                al.id,
                al.created_at,
                al.table_name,
                al.record_id,

                -- Acción semántica (no el verbo SQL)
                CASE
                    WHEN al.action = 'INSERT' THEN 'CREACION'
                    WHEN al.action = 'DELETE' THEN 'ELIMINACION'
                    WHEN al.action = 'UPDATE'
                         AND (al.old_data->>'deleted_at') IS NULL
                         AND (al.new_data->>'deleted_at') IS NOT NULL THEN 'ANULACION'
                    WHEN al.action = 'UPDATE'
                         AND al.table_name = 'ocupaciones_almacenes'
                         AND (al.old_data->>'fecha_fin') IS NULL
                         AND (al.new_data->>'fecha_fin') IS NOT NULL THEN 'RETIRO'
                    ELSE 'EDICION'
                END AS accion,

                -- Actor + rol
                coalesce(pf.nombres, pf.email, 'Sistema')       AS actor_nombre,
                coalesce(pf.rol::text, '—')                     AS actor_rol,

                -- Entidad resuelta (usa el payload — funciona aunque el registro
                -- haya sido borrado — y JOINs puntuales para nombres relacionados)
                CASE al.table_name
                    WHEN 'socios' THEN
                        concat('Socio: ', coalesce(d.j->>'apellidos', '¿?'), ', ', coalesce(d.j->>'nombres', ''))
                    WHEN 'inquilinos' THEN
                        concat('Inquilino: ', coalesce(d.j->>'apellidos', '¿?'), ', ', coalesce(d.j->>'nombres', ''))
                    WHEN 'puestos' THEN
                        concat(CASE WHEN d.j->>'tipo_espacio' = 'Almacen' THEN 'Almacén ' ELSE 'Puesto ' END,
                               coalesce(d.j->>'codigo_puesto', al.record_id))
                    WHEN 'pagos' THEN
                        concat('Recibo ', coalesce(d.j->>'codigo_transaccion', al.record_id), ' · ',
                            coalesce(
                                (SELECT concat(s.apellidos, ', ', s.nombres) FROM public.socios s
                                 WHERE s.id = nullif(d.j->>'socio_id','')::bigint),
                                (SELECT concat(i.apellidos, ', ', i.nombres) FROM public.inquilinos i
                                 WHERE i.id = nullif(d.j->>'inquilino_id','')::bigint),
                                '—'))
                    WHEN 'ocupaciones_almacenes' THEN
                        concat('Almacén ',
                            coalesce((SELECT pu.codigo_puesto FROM public.puestos pu
                                      WHERE pu.id = nullif(d.j->>'puesto_id','')::bigint), '—'),
                            ' · ',
                            coalesce(
                                (SELECT concat(s.apellidos, ', ', s.nombres) FROM public.socios s
                                 WHERE s.id = nullif(d.j->>'socio_id','')::bigint),
                                (SELECT concat(i.apellidos, ', ', i.nombres) FROM public.inquilinos i
                                 WHERE i.id = nullif(d.j->>'inquilino_id','')::bigint),
                                d.j->>'tipo_ocupante', '—'))
                    WHEN 'gastos' THEN
                        concat('Gasto S/ ', coalesce(d.j->>'monto', '0'),
                               ' — ', coalesce(nullif(trim(coalesce(d.j->>'descripcion','')), ''), 'sin descripción'))
                    WHEN 'caja_ajustes' THEN
                        concat('Ajuste de caja (', coalesce(d.j->>'tipo', '—'), ') S/ ',
                               coalesce(d.j->>'monto', '0'), ' del ', coalesce(d.j->>'fecha', '—'))
                    WHEN 'distribuciones_mensuales' THEN
                        concat('Distribución mensual ', coalesce(d.j->>'periodo_anio', '¿?'),
                               '/', lpad(coalesce(d.j->>'periodo_mes', '?'), 2, '0'))
                    ELSE concat(al.table_name, ' #', al.record_id)
                END AS entidad,

                -- Resumen extra (solo pagos: monto, método y conceptos del recibo)
                CASE WHEN al.table_name = 'pagos' THEN
                    json_build_object(
                        'monto',  nullif(d.j->>'monto_total','')::numeric,
                        'metodo', d.j->>'metodo_pago',
                        'conceptos', coalesce((
                            SELECT json_agg(DISTINCT c.nombre)
                            FROM public.detalle_pagos dp
                            JOIN public.montos_por_cobrar m ON m.id = dp.monto_id
                            JOIN public.conceptos c ON c.id = m.concepto_id
                            WHERE dp.pago_id = nullif(al.record_id,'')::bigint
                              AND dp.deleted_at IS NULL
                        ), '[]'::json)
                    )
                END AS resumen,

                -- Deltas: solo campos que cambiaron, sin ruido técnico
                CASE WHEN al.action = 'UPDATE' THEN (
                    SELECT json_agg(
                        json_build_object('campo', o.key, 'antes', o.value, 'despues', n.value)
                        ORDER BY o.key
                    )
                    FROM jsonb_each_text(al.old_data) o
                    JOIN jsonb_each_text(al.new_data) n USING (key)
                    WHERE o.value IS DISTINCT FROM n.value
                      AND o.key NOT IN ('updated_at', 'created_at', 'created_by')
                ) END AS cambios,

                -- Motivo: columna nueva, o el motivo persistido en la propia fila
                -- (anulaciones/retiros históricos aparecen retroactivamente)
                coalesce(
                    al.motivo,
                    CASE WHEN al.action = 'UPDATE'
                          AND (al.old_data->>'motivo_anulacion') IS DISTINCT FROM (al.new_data->>'motivo_anulacion')
                         THEN al.new_data->>'motivo_anulacion' END,
                    CASE WHEN al.action = 'UPDATE'
                          AND (al.old_data->>'motivo_cierre') IS DISTINCT FROM (al.new_data->>'motivo_cierre')
                         THEN al.new_data->>'motivo_cierre' END
                ) AS motivo

            FROM public.audit_logs al
            LEFT JOIN public.perfiles pf ON pf.id = al.changed_by
            CROSS JOIN LATERAL (SELECT coalesce(al.new_data, al.old_data) AS j) d
            WHERE (p_before IS NULL OR al.created_at < p_before)
              AND (p_tabla  IS NULL OR al.table_name = p_tabla)
        ) b
        WHERE (p_accion   IS NULL OR b.accion = p_accion)
          AND (p_busqueda IS NULL
               OR b.entidad      ILIKE '%' || p_busqueda || '%'
               OR b.actor_nombre ILIKE '%' || p_busqueda || '%')
        ORDER BY b.created_at DESC
        LIMIT greatest(coalesce(p_limit, 50), 1)
    ) e;

    RETURN v_result;
END;
$$;

COMMENT ON FUNCTION public.rpc_auditoria_timeline(int, timestamptz, text, text, text) IS
    'Auditoría narrativa: eventos de audit_logs resueltos server-side (actor+rol, '
    'entidad legible, acción semántica, deltas campo a campo, motivo). Keyset '
    'pagination con p_before. Solo Administrador. (00086)';

GRANT EXECUTE ON FUNCTION public.rpc_auditoria_timeline(int, timestamptz, text, text, text) TO authenticated;

COMMIT;
