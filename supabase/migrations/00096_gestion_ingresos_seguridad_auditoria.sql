-- =============================================================================
-- Migración 00096 — Seguridad, Auditoría y RPCs para Gestión de Ingresos Internos
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
--   1. RLS: Bloqueo de UPDATE directo desde el cliente sobre ingresos_internos.
--      Toda modificación o anulación debe pasar obligatoriamente por RPCs.
--   2. TRIGGER: Conexión de ingresos_internos con el motor de auditoría central
--      (public.audit_logs vía public.log_audit_action()).
--   3. RPC rpc_editar_ingreso_interno:
--      * Valida rol exclusivo Administrador.
--      * Bloqueo de fila vía SELECT FOR UPDATE.
--      * Control de concurrencia optimista obligatorio (p_updated_at).
--      * Inmutabilidad de created_at.
--      * Captura de justificación (app.audit_motivo) en audit_logs.
--   4. RPC rpc_anular_ingreso_interno:
--      * Valida rol exclusivo Administrador.
--      * Bloqueo de fila vía SELECT FOR UPDATE.
--      * Control de concurrencia optimista obligatorio (p_updated_at).
--      * Soft-delete consistente (chk_ingresos_internos_anulacion_consistente).
--      * Captura de motivo de anulación en audit_logs.
-- =============================================================================

BEGIN;

-- =============================================================================
-- 1. RLS: Bloquear UPDATE directo desde clientes
--    Las modificaciones se canalizan exclusivamente por RPCs SECURITY DEFINER.
-- =============================================================================
DROP POLICY IF EXISTS pol_ingresos_internos_update ON public.ingresos_internos;

CREATE POLICY pol_ingresos_internos_update ON public.ingresos_internos
    FOR UPDATE TO authenticated
    USING (false)
    WITH CHECK (false);

COMMENT ON POLICY pol_ingresos_internos_update ON public.ingresos_internos IS
    'Bloquea updates directos vía PostgREST. Toda edición o anulación debe ejecutarse vía RPC rpc_editar_ingreso_interno o rpc_anular_ingreso_interno.';


-- =============================================================================
-- 2. TRIGGER de Auditoría en ingresos_internos
--    Guarda quién, cuándo, campos modificados (deltas) y motivo en audit_logs.
-- =============================================================================
DROP TRIGGER IF EXISTS trg_audit_ingresos_internos ON public.ingresos_internos;

CREATE TRIGGER trg_audit_ingresos_internos
    AFTER INSERT OR UPDATE OR DELETE ON public.ingresos_internos
    FOR EACH ROW EXECUTE FUNCTION public.log_audit_action();


-- =============================================================================
-- 3. RPC: rpc_editar_ingreso_interno
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_editar_ingreso_interno(
    p_id            bigint,
    p_fecha_ingreso timestamptz,
    p_monto         numeric,
    p_metodo_pago   text,
    p_concepto_id   bigint,
    p_observacion   text,
    p_motivo        text,
    p_updated_at    timestamptz
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_actual record;
BEGIN
    -- 1. Control de Rol estricto (solo Administrador)
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede modificar ingresos.';
    END IF;

    -- 2. Validación de parámetros obligatorios
    IF p_updated_at IS NULL THEN
        RAISE EXCEPTION 'El parámetro updated_at es obligatorio para el control de concurrencia.';
    END IF;

    IF p_fecha_ingreso IS NULL THEN
        RAISE EXCEPTION 'La fecha de ingreso es obligatoria.';
    END IF;

    IF p_monto IS NULL OR p_monto <= 0 THEN
        RAISE EXCEPTION 'El monto debe ser un valor numérico positivo mayor a cero.';
    END IF;

    IF p_metodo_pago NOT IN ('Efectivo', 'Transferencia') THEN
        RAISE EXCEPTION 'Método de pago inválido: %.', p_metodo_pago;
    END IF;

    IF nullif(trim(p_motivo), '') IS NULL OR length(trim(p_motivo)) < 5 THEN
        RAISE EXCEPTION 'El motivo de la modificación es obligatorio (mínimo 5 caracteres).';
    END IF;

    -- 3. Bloqueo pesimista de fila (SELECT FOR UPDATE)
    SELECT * INTO v_actual
    FROM public.ingresos_internos
    WHERE id = p_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Ingreso interno #% no encontrado.', p_id;
    END IF;

    IF v_actual.deleted_at IS NOT NULL THEN
        RAISE EXCEPTION 'El ingreso interno #% se encuentra anulado y no puede editarse.', p_id;
    END IF;

    -- 4. Verificación de concurrencia optimista
    IF v_actual.updated_at <> p_updated_at THEN
        RAISE EXCEPTION 'El registro fue modificado por otro operador en este intervalo. Por favor, actualice la vista antes de guardar.';
    END IF;

    -- 5. Validación del concepto
    IF NOT EXISTS (
        SELECT 1 FROM public.conceptos
        WHERE id = p_concepto_id
          AND activo = true
          AND deleted_at IS NULL
          AND grupo IN ('INQUILINOS', 'OTROS')
    ) THEN
        RAISE EXCEPTION 'Concepto #% inválido, inactivo o no permitido para ingresos de caja rápida.', p_concepto_id;
    END IF;

    -- 6. Validación de fecha operativa razonable (no más de 1 día en el futuro)
    IF p_fecha_ingreso > (now() + interval '1 day') THEN
        RAISE EXCEPTION 'La fecha operativa de ingreso no puede ser futura.';
    END IF;

    -- 7. Configuración de variable de sesión para el trigger de auditoría
    PERFORM set_config('app.audit_motivo', trim(p_motivo), true);

    -- 8. Actualización atómica (created_at permanece intacto)
    UPDATE public.ingresos_internos
    SET
        fecha_ingreso = p_fecha_ingreso,
        monto         = p_monto,
        metodo_pago   = p_metodo_pago,
        concepto_id   = p_concepto_id,
        observacion   = nullif(trim(p_observacion), ''),
        updated_at    = now()
    WHERE id = p_id;

    RETURN jsonb_build_object(
        'ok',      true,
        'id',      p_id,
        'mensaje', 'Ingreso interno actualizado correctamente.'
    );
END;
$$;

COMMENT ON FUNCTION public.rpc_editar_ingreso_interno(bigint, timestamptz, numeric, text, bigint, text, text, timestamptz) IS
    'Edición segura y atómica de ingresos internos. Requiere rol Administrador, valida concurrencia (p_updated_at) y audita con motivo.';

GRANT EXECUTE ON FUNCTION public.rpc_editar_ingreso_interno(bigint, timestamptz, numeric, text, bigint, text, text, timestamptz) TO authenticated;


-- =============================================================================
-- 4. RPC: rpc_anular_ingreso_interno
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_anular_ingreso_interno(
    p_id         bigint,
    p_motivo     text,
    p_updated_at timestamptz
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_actual record;
BEGIN
    -- 1. Control de Rol estricto (solo Administrador)
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede anular ingresos.';
    END IF;

    -- 2. Validación de parámetros obligatorios
    IF p_updated_at IS NULL THEN
        RAISE EXCEPTION 'El parámetro updated_at es obligatorio para el control de concurrencia.';
    END IF;

    IF nullif(trim(p_motivo), '') IS NULL OR length(trim(p_motivo)) < 5 THEN
        RAISE EXCEPTION 'El motivo de la anulación es obligatorio (mínimo 5 caracteres).';
    END IF;

    -- 3. Bloqueo pesimista de fila (SELECT FOR UPDATE)
    SELECT * INTO v_actual
    FROM public.ingresos_internos
    WHERE id = p_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Ingreso interno #% no encontrado.', p_id;
    END IF;

    IF v_actual.deleted_at IS NOT NULL THEN
        RAISE EXCEPTION 'El ingreso interno #% ya fue anulado previamente.', p_id;
    END IF;

    -- 4. Verificación de concurrencia optimista
    IF v_actual.updated_at <> p_updated_at THEN
        RAISE EXCEPTION 'El registro fue modificado por otro operador en este intervalo. Por favor, actualice la vista antes de anular.';
    END IF;

    -- 5. Configuración de variable de sesión para el trigger de auditoría
    PERFORM set_config('app.audit_motivo', trim(p_motivo), true);

    -- 6. Anulación lógica consistente (satisface chk_ingresos_internos_anulacion_consistente)
    UPDATE public.ingresos_internos
    SET
        deleted_at       = now(),
        anulado_por      = auth.uid(),
        motivo_anulacion = trim(p_motivo),
        updated_at       = now()
    WHERE id = p_id;

    RETURN jsonb_build_object(
        'ok',      true,
        'id',      p_id,
        'mensaje', 'Ingreso interno anulado correctamente.'
    );
END;
$$;

COMMENT ON FUNCTION public.rpc_anular_ingreso_interno(bigint, text, timestamptz) IS
    'Anulación lógica segura y atómica de ingresos internos. Requiere rol Administrador, valida concurrencia (p_updated_at) y audita con motivo.';

GRANT EXECUTE ON FUNCTION public.rpc_anular_ingreso_interno(bigint, text, timestamptz) TO authenticated;

COMMIT;
