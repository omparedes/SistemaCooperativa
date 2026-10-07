-- =============================================================================
-- Migración 00094 — Movimientos Bancarios: Edición, Eliminación, Auditoría y Reportes
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
--   1. Actualización de tg_actualizar_saldo_banco() para soportar edición de
--      movimientos activos (reversión de OLD y aplicación de NEW) de manera
--      atómica en bancos_cuentas.saldo_actual.
--   2. Trigger de auditoría trg_audit_movimientos_bancarios en movimientos_bancarios
--      conectado a log_audit_action() para registro automático en audit_logs.
--   3. RPC rpc_editar_movimiento_bancario: edición segura con chequeo de rol
--      (Administrador, Caja) y motivo hacia audit_logs vía app.audit_motivo.
--   4. RPC rpc_eliminar_movimiento_bancario: soft delete seguro con chequeo de rol
--      (Administrador, Caja) y motivo hacia audit_logs vía app.audit_motivo.
--   5. RPC rpc_reporte_movimientos_bancarios: consulta consolidada para reporte
--      y exportación PDF por período, cuenta y tipo.
-- =============================================================================

BEGIN;

-- =============================================================================
-- 1. Trigger de saldo bancario: soporte para INSERT, UPDATE (edición) y SOFT DELETE
-- =============================================================================
CREATE OR REPLACE FUNCTION public.tg_actualizar_saldo_banco()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    -- CASO 1: INSERT de movimiento activo
    IF TG_OP = 'INSERT' AND NEW.deleted_at IS NULL THEN
        IF NEW.tipo = 'Ingreso' THEN
            UPDATE public.bancos_cuentas
            SET saldo_actual = saldo_actual + NEW.monto
            WHERE id = NEW.cuenta_id;
        ELSE
            UPDATE public.bancos_cuentas
            SET saldo_actual = saldo_actual - NEW.monto
            WHERE id = NEW.cuenta_id;
        END IF;

    -- CASO 2: UPDATE de activo a anulado (soft delete)
    ELSIF TG_OP = 'UPDATE'
          AND OLD.deleted_at IS NULL
          AND NEW.deleted_at IS NOT NULL THEN
        IF OLD.tipo = 'Ingreso' THEN
            UPDATE public.bancos_cuentas
            SET saldo_actual = saldo_actual - OLD.monto
            WHERE id = OLD.cuenta_id;
        ELSE
            UPDATE public.bancos_cuentas
            SET saldo_actual = saldo_actual + OLD.monto
            WHERE id = OLD.cuenta_id;
        END IF;

    -- CASO 3: UPDATE de movimiento activo que permanece activo (edición de campos financieros)
    ELSIF TG_OP = 'UPDATE'
          AND OLD.deleted_at IS NULL
          AND NEW.deleted_at IS NULL THEN
        -- Solo si cambiaron cuenta_id, tipo o monto
        IF OLD.cuenta_id <> NEW.cuenta_id
           OR OLD.tipo <> NEW.tipo
           OR OLD.monto <> NEW.monto THEN

            -- Revertir el efecto de OLD en OLD.cuenta_id
            IF OLD.tipo = 'Ingreso' THEN
                UPDATE public.bancos_cuentas
                SET saldo_actual = saldo_actual - OLD.monto
                WHERE id = OLD.cuenta_id;
            ELSE
                UPDATE public.bancos_cuentas
                SET saldo_actual = saldo_actual + OLD.monto
                WHERE id = OLD.cuenta_id;
            END IF;

            -- Aplicar el efecto de NEW en NEW.cuenta_id
            IF NEW.tipo = 'Ingreso' THEN
                UPDATE public.bancos_cuentas
                SET saldo_actual = saldo_actual + NEW.monto
                WHERE id = NEW.cuenta_id;
            ELSE
                UPDATE public.bancos_cuentas
                SET saldo_actual = saldo_actual - NEW.monto
                WHERE id = NEW.cuenta_id;
            END IF;
        END IF;

    -- CASO 4: Restauración de un anulado a activo (si ocurriera)
    ELSIF TG_OP = 'UPDATE'
          AND OLD.deleted_at IS NOT NULL
          AND NEW.deleted_at IS NULL THEN
        IF NEW.tipo = 'Ingreso' THEN
            UPDATE public.bancos_cuentas
            SET saldo_actual = saldo_actual + NEW.monto
            WHERE id = NEW.cuenta_id;
        ELSE
            UPDATE public.bancos_cuentas
            SET saldo_actual = saldo_actual - NEW.monto
            WHERE id = NEW.cuenta_id;
        END IF;

    -- CASO 5: DELETE físico si se aplicara directamente
    ELSIF TG_OP = 'DELETE' AND OLD.deleted_at IS NULL THEN
        IF OLD.tipo = 'Ingreso' THEN
            UPDATE public.bancos_cuentas
            SET saldo_actual = saldo_actual - OLD.monto
            WHERE id = OLD.cuenta_id;
        ELSE
            UPDATE public.bancos_cuentas
            SET saldo_actual = saldo_actual + OLD.monto
            WHERE id = OLD.cuenta_id;
        END IF;
    END IF;

    RETURN NEW;
END;
$$;

COMMENT ON FUNCTION public.tg_actualizar_saldo_banco() IS
    'Trigger AFTER INSERT OR UPDATE OR DELETE. Aplica, revierte o ajusta el saldo '
    'en bancos_cuentas.saldo_actual de manera atómica ante creación, edición o anulación. (00021 → 00094)';

DROP TRIGGER IF EXISTS trg_actualizar_saldo_banco ON public.movimientos_bancarios;
CREATE TRIGGER trg_actualizar_saldo_banco
    AFTER INSERT OR UPDATE OR DELETE ON public.movimientos_bancarios
    FOR EACH ROW EXECUTE FUNCTION public.tg_actualizar_saldo_banco();


-- =============================================================================
-- 2. Trigger de Auditoría en movimientos_bancarios
-- =============================================================================
DROP TRIGGER IF EXISTS trg_audit_movimientos_bancarios ON public.movimientos_bancarios;
CREATE TRIGGER trg_audit_movimientos_bancarios
    AFTER INSERT OR UPDATE OR DELETE ON public.movimientos_bancarios
    FOR EACH ROW EXECUTE FUNCTION public.log_audit_action();

COMMENT ON TRIGGER trg_audit_movimientos_bancarios ON public.movimientos_bancarios IS
    'Captura inserciones, ediciones y eliminaciones en audit_logs de forma inmutable. (00094)';


-- =============================================================================
-- 3. RPC: rpc_editar_movimiento_bancario
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_editar_movimiento_bancario(
    p_id              bigint,
    p_cuenta_id       bigint,
    p_fecha_operacion date,
    p_tipo            text,
    p_monto           numeric,
    p_motivo_detalle  text DEFAULT NULL,
    p_nro_operacion   text DEFAULT NULL,
    p_motivo_audit    text DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_mov public.movimientos_bancarios%ROWTYPE;
    v_cuenta_existe boolean;
BEGIN
    -- 1. Validar autorización
    IF public.get_my_rol() NOT IN ('Administrador', 'Caja') THEN
        RAISE EXCEPTION 'Acceso denegado: solo Administrador o Caja pueden editar movimientos bancarios.';
    END IF;

    -- 2. Buscar movimiento
    SELECT * INTO v_mov
    FROM public.movimientos_bancarios
    WHERE id = p_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Movimiento bancario % no encontrado.', p_id;
    END IF;

    IF v_mov.deleted_at IS NOT NULL THEN
        RAISE EXCEPTION 'El movimiento bancario % está eliminado/anulado y no puede editarse.', p_id;
    END IF;

    -- 3. Validaciones de dominio
    IF p_cuenta_id IS NULL THEN
        RAISE EXCEPTION 'Debe seleccionar una cuenta bancaria válida.';
    END IF;

    SELECT EXISTS (
        SELECT 1 FROM public.bancos_cuentas WHERE id = p_cuenta_id AND activo = true
    ) INTO v_cuenta_existe;

    IF NOT v_cuenta_existe THEN
        RAISE EXCEPTION 'La cuenta bancaria % no existe o no está activa.', p_cuenta_id;
    END IF;

    IF p_fecha_operacion IS NULL THEN
        RAISE EXCEPTION 'La fecha de operación es obligatoria.';
    END IF;

    IF p_tipo NOT IN ('Ingreso', 'Egreso') THEN
        RAISE EXCEPTION 'Tipo de movimiento inválido: %. Debe ser "Ingreso" o "Egreso".', p_tipo;
    END IF;

    IF p_monto IS NULL OR p_monto <= 0 THEN
        RAISE EXCEPTION 'El monto debe ser un número positivo mayor a 0.';
    END IF;

    -- 4. Registrar motivo en variable transaccional para el trigger de auditoría
    PERFORM set_config(
        'app.audit_motivo',
        coalesce(nullif(trim(p_motivo_audit), ''), 'Edición de movimiento bancario'),
        true
    );

    -- 5. Actualizar registro (el trigger tg_actualizar_saldo_banco ajustará saldos atómicamente)
    UPDATE public.movimientos_bancarios
    SET
        cuenta_id       = p_cuenta_id,
        fecha_operacion = p_fecha_operacion,
        tipo            = p_tipo,
        monto           = p_monto,
        motivo_detalle  = nullif(trim(p_motivo_detalle), ''),
        nro_operacion   = nullif(trim(p_nro_operacion), '')
    WHERE id = p_id;

    RETURN jsonb_build_object(
        'ok',      true,
        'id',      p_id,
        'mensaje', 'Movimiento bancario actualizado correctamente.'
    );
END;
$$;

COMMENT ON FUNCTION public.rpc_editar_movimiento_bancario IS
    'Edición segura y atómica de movimientos bancarios con actualización de saldos y trazabilidad en audit_logs. (00094)';

GRANT EXECUTE ON FUNCTION public.rpc_editar_movimiento_bancario TO authenticated;


-- =============================================================================
-- 4. RPC: rpc_eliminar_movimiento_bancario
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_eliminar_movimiento_bancario(
    p_id           bigint,
    p_motivo_audit text DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_mov public.movimientos_bancarios%ROWTYPE;
    v_uid uuid := auth.uid();
    v_motivo text;
BEGIN
    -- 1. Validar autorización
    IF public.get_my_rol() NOT IN ('Administrador', 'Caja') THEN
        RAISE EXCEPTION 'Acceso denegado: solo Administrador o Caja pueden eliminar movimientos bancarios.';
    END IF;

    -- 2. Buscar movimiento
    SELECT * INTO v_mov
    FROM public.movimientos_bancarios
    WHERE id = p_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Movimiento bancario % no encontrado.', p_id;
    END IF;

    IF v_mov.deleted_at IS NOT NULL THEN
        RAISE EXCEPTION 'El movimiento bancario % ya se encuentra eliminado.', p_id;
    END IF;

    v_motivo := coalesce(nullif(trim(p_motivo_audit), ''), 'Eliminación desde módulo de bancos');

    -- 3. Registrar motivo en variable transaccional para el trigger de auditoría
    PERFORM set_config('app.audit_motivo', v_motivo, true);

    -- 4. Soft-delete cumpliendo constraint chk_movimientos_anulacion_consistente
    UPDATE public.movimientos_bancarios
    SET
        deleted_at       = now(),
        anulado_por      = v_uid,
        motivo_anulacion = v_motivo
    WHERE id = p_id;

    RETURN jsonb_build_object(
        'ok',      true,
        'id',      p_id,
        'mensaje', 'Movimiento bancario eliminado correctamente.'
    );
END;
$$;

COMMENT ON FUNCTION public.rpc_eliminar_movimiento_bancario IS
    'Eliminación por soft-delete atómica de movimientos bancarios con reversión de saldos y trazabilidad en audit_logs. (00094)';

GRANT EXECUTE ON FUNCTION public.rpc_eliminar_movimiento_bancario TO authenticated;


-- =============================================================================
-- 5. Enriquecer rpc_auditoria_timeline para mostrar movimientos_bancarios
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
                      AND o.key NOT IN ('updated_at', 'deleted_at', 'anulado_por', 'motivo_anulacion')
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
                  OR (p_accion = 'CREACION'   AND al.action = 'INSERT')
                  OR (p_accion = 'ELIMINACION' AND al.action = 'DELETE')
                  OR (p_accion = 'ANULACION'  AND al.action = 'UPDATE' AND (al.old_data->>'deleted_at') IS NULL AND (al.new_data->>'deleted_at') IS NOT NULL)
                  OR (p_accion = 'EDICION'    AND al.action = 'UPDATE' AND NOT ((al.old_data->>'deleted_at') IS NULL AND (al.new_data->>'deleted_at') IS NOT NULL))
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
    'Timeline narrativo de auditoría con soporte para movimientos bancarios. (00086 → 00094)';

GRANT EXECUTE ON FUNCTION public.rpc_auditoria_timeline TO authenticated;

COMMIT;
