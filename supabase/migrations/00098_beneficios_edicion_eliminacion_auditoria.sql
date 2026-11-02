-- =============================================================================
-- Migración 00098 — Dietas y Provisión Social: Edición, Eliminación Lógica y Auditoría
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
--   1. Añade columnas de trazabilidad de edición (updated_at, updated_by) a
--      public.beneficios_socios.
--   2. Endurece políticas RLS de UPDATE y DELETE en public.beneficios_socios
--      para restringirlas exclusivamente al rol 'Administrador'.
--   3. Conecta public.beneficios_socios al sistema de auditoría inmutable
--      (public.audit_logs) mediante el trigger trg_audit_beneficios_socios.
--   4. Crea RPC public.rpc_editar_beneficio_socio (SECURITY DEFINER) con
--      validación de rol Administrador, bloqueo FOR UPDATE, validaciones de
--      integridad (monto > 0, fecha y concepto/motivo obligatorios, socio_id
--      inmutable) y registro en audit_logs.
--   5. Crea RPC public.rpc_eliminar_beneficio_socio (SECURITY DEFINER) para
--      eliminación lógica (soft-delete vía deleted_at y deleted_by) exclusiva
--      para Administrador y con trazabilidad en audit_logs.
--   6. Enriquecimiento de public.rpc_auditoria_timeline para presentar eventos
--      de beneficios_socios de forma legible.
-- =============================================================================

BEGIN;

-- =============================================================================
-- 1. Columnas de auditoría de edición en public.beneficios_socios
-- =============================================================================
ALTER TABLE public.beneficios_socios
    ADD COLUMN IF NOT EXISTS updated_at timestamp with time zone,
    ADD COLUMN IF NOT EXISTS updated_by uuid REFERENCES auth.users(id);

-- =============================================================================
-- 2. Endurecimiento de Políticas RLS (UPDATE y DELETE exclusivos de Administrador)
-- =============================================================================
DROP POLICY IF EXISTS "Administradores y Caja pueden actualizar beneficios" ON public.beneficios_socios;
DROP POLICY IF EXISTS "Solo Administradores pueden actualizar beneficios" ON public.beneficios_socios;

CREATE POLICY "Solo Administradores pueden actualizar beneficios"
    ON public.beneficios_socios
    FOR UPDATE
    USING (public.get_my_rol() = 'Administrador')
    WITH CHECK (public.get_my_rol() = 'Administrador');

DROP POLICY IF EXISTS "Administradores y Caja pueden eliminar (soft delete)" ON public.beneficios_socios;
DROP POLICY IF EXISTS "Solo Administradores pueden eliminar beneficios" ON public.beneficios_socios;

CREATE POLICY "Solo Administradores pueden eliminar beneficios"
    ON public.beneficios_socios
    FOR DELETE
    USING (public.get_my_rol() = 'Administrador');

-- =============================================================================
-- 3. Trigger de Auditoría en public.beneficios_socios -> public.audit_logs
-- =============================================================================
DROP TRIGGER IF EXISTS trg_audit_beneficios_socios ON public.beneficios_socios;
CREATE TRIGGER trg_audit_beneficios_socios
    AFTER INSERT OR UPDATE OR DELETE ON public.beneficios_socios
    FOR EACH ROW EXECUTE FUNCTION public.log_audit_action();

COMMENT ON TRIGGER trg_audit_beneficios_socios ON public.beneficios_socios IS
    'Captura inserciones, ediciones y eliminaciones lógicas de Dietas y Provisión Social en audit_logs. (00098)';

-- =============================================================================
-- 4. RPC: public.rpc_editar_beneficio_socio
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_editar_beneficio_socio(
    p_id          bigint,
    p_socio_id    bigint,
    p_fecha       date,
    p_monto       numeric,
    p_motivo      text,
    p_observacion text DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_row    public.beneficios_socios%ROWTYPE;
    v_motivo text;
    v_obs    text;
BEGIN
    -- 1. Validar autorización exclusiva de Administrador
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede editar registros de Dietas y Provisión Social.';
    END IF;

    -- 2. Bloquear y verificar existencia del registro
    SELECT * INTO v_row
    FROM public.beneficios_socios
    WHERE id = p_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'El registro #% no existe.', p_id;
    END IF;

    IF v_row.deleted_at IS NOT NULL THEN
        RAISE EXCEPTION 'El registro #% se encuentra eliminado y no puede editarse.', p_id;
    END IF;

    -- 3. Garantizar que no se altere la relación con el socio original
    IF p_socio_id IS NOT NULL AND v_row.socio_id <> p_socio_id THEN
        RAISE EXCEPTION 'Inconsistencia de datos: el registro no pertenece al socio indicado.';
    END IF;

    -- 4. Validaciones de negocio
    IF p_fecha IS NULL THEN
        RAISE EXCEPTION 'La fecha es obligatoria.';
    END IF;

    IF p_monto IS NULL OR p_monto <= 0 THEN
        RAISE EXCEPTION 'El monto debe ser mayor a cero (S/ 0.00).';
    END IF;

    v_motivo := nullif(trim(coalesce(p_motivo, '')), '');
    IF v_motivo IS NULL THEN
        IF v_row.tipo = 'dieta' THEN
            RAISE EXCEPTION 'El concepto o descripción de la dieta es obligatorio.';
        ELSE
            RAISE EXCEPTION 'El motivo de la provisión social es obligatorio.';
        END IF;
    END IF;

    v_obs := nullif(trim(coalesce(p_observacion, '')), '');

    -- 5. Registrar contexto de auditoría para trg_audit_beneficios_socios
    PERFORM set_config(
        'app.audit_motivo',
        CASE
            WHEN v_row.tipo = 'dieta' THEN 'Edición de registro de Dieta'
            ELSE 'Edición de registro de Provisión Social'
        END,
        true
    );

    -- 6. Actualizar el registro preservando id, socio_id y tipo
    UPDATE public.beneficios_socios
    SET
        fecha       = p_fecha,
        monto       = round(p_monto, 2),
        motivo      = v_motivo,
        observacion = v_obs,
        updated_at  = timezone('utc'::text, now()),
        updated_by  = auth.uid()
    WHERE id = p_id;

    RETURN jsonb_build_object(
        'ok',      true,
        'id',      p_id,
        'mensaje', CASE
            WHEN v_row.tipo = 'dieta' THEN 'Dieta actualizada correctamente.'
            ELSE 'Provisión social actualizada correctamente.'
        END
    );
END;
$$;

COMMENT ON FUNCTION public.rpc_editar_beneficio_socio IS
    'Edición segura de un registro de Dieta o Provisión Social exclusiva para Administrador con trazabilidad en audit_logs. (00098)';

GRANT EXECUTE ON FUNCTION public.rpc_editar_beneficio_socio TO authenticated;

-- =============================================================================
-- 5. RPC: public.rpc_eliminar_beneficio_socio
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_eliminar_beneficio_socio(
    p_id       bigint,
    p_socio_id bigint DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_row public.beneficios_socios%ROWTYPE;
BEGIN
    -- 1. Validar autorización exclusiva de Administrador
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede eliminar registros de Dietas y Provisión Social.';
    END IF;

    -- 2. Bloquear y verificar existencia del registro
    SELECT * INTO v_row
    FROM public.beneficios_socios
    WHERE id = p_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'El registro #% no existe.', p_id;
    END IF;

    IF v_row.deleted_at IS NOT NULL THEN
        RAISE EXCEPTION 'El registro #% ya fue eliminado anteriormente.', p_id;
    END IF;

    IF p_socio_id IS NOT NULL AND v_row.socio_id <> p_socio_id THEN
        RAISE EXCEPTION 'Inconsistencia de datos: el registro no pertenece al socio indicado.';
    END IF;

    -- 3. Registrar contexto de auditoría para trg_audit_beneficios_socios
    PERFORM set_config(
        'app.audit_motivo',
        CASE
            WHEN v_row.tipo = 'dieta' THEN 'Eliminación de registro de Dieta'
            ELSE 'Eliminación de registro de Provisión Social'
        END,
        true
    );

    -- 4. Aplicar eliminación lógica (soft-delete)
    UPDATE public.beneficios_socios
    SET
        deleted_at = timezone('utc'::text, now()),
        deleted_by = auth.uid(),
        updated_at = timezone('utc'::text, now()),
        updated_by = auth.uid()
    WHERE id = p_id;

    RETURN jsonb_build_object(
        'ok',      true,
        'id',      p_id,
        'mensaje', CASE
            WHEN v_row.tipo = 'dieta' THEN 'Dieta eliminada correctamente.'
            ELSE 'Provisión social eliminada correctamente.'
        END
    );
END;
$$;

COMMENT ON FUNCTION public.rpc_eliminar_beneficio_socio IS
    'Eliminación lógica (soft-delete) de un registro de Dieta o Provisión Social exclusiva para Administrador con trazabilidad en audit_logs. (00098)';

GRANT EXECUTE ON FUNCTION public.rpc_eliminar_beneficio_socio TO authenticated;

-- =============================================================================
-- 6. Enriquecer rpc_auditoria_timeline para incluir beneficios_socios
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

                CASE
                    WHEN al.action = 'INSERT' THEN 'CREACION'
                    WHEN al.action = 'DELETE' THEN 'ELIMINACION'
                    WHEN al.action = 'UPDATE'
                         AND al.table_name = 'beneficios_socios'
                         AND (al.old_data->>'deleted_at') IS NULL
                         AND (al.new_data->>'deleted_at') IS NOT NULL THEN 'ELIMINACION'
                    WHEN al.action = 'UPDATE'
                         AND (al.old_data->>'deleted_at') IS NULL
                         AND (al.new_data->>'deleted_at') IS NOT NULL THEN 'ANULACION'
                    WHEN al.action = 'UPDATE'
                         AND al.table_name = 'ocupaciones_almacenes'
                         AND (al.old_data->>'fecha_fin') IS NULL
                         AND (al.new_data->>'fecha_fin') IS NOT NULL THEN 'RETIRO'
                    ELSE 'EDICION'
                END AS accion,

                coalesce(pf.nombres, pf.email, 'Sistema')       AS actor_nombre,
                coalesce(pf.rol::text, '—')                     AS actor_rol,

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
                    WHEN 'movimientos_bancarios' THEN
                        concat('Movimiento bancario (', coalesce(d.j->>'tipo', '—'), ') S/ ',
                               coalesce(d.j->>'monto', '0'), ' — ',
                               coalesce(nullif(trim(coalesce(d.j->>'motivo_detalle','')), ''), 'sin detalle'))
                    WHEN 'beneficios_socios' THEN
                        concat(
                            CASE WHEN d.j->>'tipo' = 'dieta' THEN 'Dieta' ELSE 'Provisión Social' END,
                            ' S/ ', coalesce(d.j->>'monto', '0'),
                            ' · ',
                            coalesce(
                                (SELECT trim(both ', ' from concat(s.apellidos, ', ', coalesce(s.nombres, '')))
                                 FROM public.socios s
                                 WHERE s.id = nullif(d.j->>'socio_id','')::bigint),
                                '—'
                            ),
                            CASE WHEN nullif(trim(coalesce(d.j->>'motivo','')), '') IS NOT NULL
                                 THEN concat(' — ', trim(d.j->>'motivo'))
                                 ELSE ''
                            END
                        )
                    ELSE concat(al.table_name, ' #', al.record_id)
                END AS entidad,

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

                CASE WHEN al.action = 'UPDATE' THEN (
                    SELECT json_agg(
                        json_build_object('campo', o.key, 'antes', o.value, 'despues', n.value)
                        ORDER BY o.key
                    )
                    FROM jsonb_each_text(al.old_data) o
                    JOIN jsonb_each_text(al.new_data) n USING (key)
                    WHERE o.value IS DISTINCT FROM n.value
                      AND o.key NOT IN ('updated_at', 'updated_by', 'deleted_at', 'deleted_by', 'anulado_por', 'motivo_anulacion')
                ) END AS cambios,

                coalesce(
                    al.motivo,
                    d.j->>'motivo_anulacion',
                    d.j->>'motivo_cierre'
                ) AS motivo

            FROM public.audit_logs al
            LEFT JOIN public.perfiles pf ON pf.id = al.changed_by
            CROSS JOIN LATERAL (
                SELECT coalesce(al.new_data, al.old_data) AS j
            ) d
            WHERE (p_before IS NULL OR al.created_at < p_before)
              AND (p_tabla  IS NULL OR al.table_name = p_tabla)
              AND (
                  p_accion IS NULL
                  OR (p_accion = 'CREACION'    AND al.action = 'INSERT')
                  OR (p_accion = 'ELIMINACION' AND (
                      al.action = 'DELETE'
                      OR (al.action = 'UPDATE' AND al.table_name = 'beneficios_socios' AND (al.old_data->>'deleted_at') IS NULL AND (al.new_data->>'deleted_at') IS NOT NULL)
                  ))
                  OR (p_accion = 'ANULACION'   AND al.action = 'UPDATE' AND al.table_name <> 'beneficios_socios' AND (al.old_data->>'deleted_at') IS NULL AND (al.new_data->>'deleted_at') IS NOT NULL)
                  OR (p_accion = 'EDICION'     AND al.action = 'UPDATE' AND NOT ((al.old_data->>'deleted_at') IS NULL AND (al.new_data->>'deleted_at') IS NOT NULL))
              )
              AND (
                  p_busqueda IS NULL
                  OR al.record_id ILIKE '%' || p_busqueda || '%'
                  OR al.table_name ILIKE '%' || p_busqueda || '%'
                  OR pf.nombres ILIKE '%' || p_busqueda || '%'
                  OR pf.email ILIKE '%' || p_busqueda || '%'
                  OR al.motivo ILIKE '%' || p_busqueda || '%'
                  OR (d.j::text) ILIKE '%' || p_busqueda || '%'
              )
            ORDER BY al.created_at DESC
            LIMIT p_limit
        ) b
    ) e;

    RETURN v_result;
END;
$$;

COMMENT ON FUNCTION public.rpc_auditoria_timeline IS
    'Timeline narrativo de auditoría con soporte para movimientos bancarios y beneficios_socios (Dietas / Provisión Social). (00086 → 00098)';

GRANT EXECUTE ON FUNCTION public.rpc_auditoria_timeline TO authenticated;

COMMIT;
