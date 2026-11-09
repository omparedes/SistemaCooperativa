-- =============================================================================
-- Migración 00100 — Seguridad, Auditoría y RPCs para Gestión de Tarjeta
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
--   1. TABLA: Agregar columna updated_at a public.recaudacion_abonos si no existe.
--   2. RLS: Bloqueo de UPDATE directo desde el cliente sobre recaudacion_abonos.
--      Toda modificación o anulación debe pasar obligatoriamente por RPCs.
--   3. TRIGGER: Conexión de recaudacion_abonos con el motor de auditoría central
--      (public.audit_logs vía public.log_audit_action()).
--   4. RPC rpc_editar_recaudacion_abono:
--      * Valida rol exclusivo Administrador.
--      * Bloqueo pesimista de fila (recaudacion_abonos) y de socio (socios).
--      * Control de concurrencia optimista obligatorio (p_updated_at).
--      * Inmutabilidad de created_at y created_by.
--      * Ajuste financiero atómico de saldo_a_favor (protege contra saldos negativos).
--      * Captura de justificación (app.audit_motivo) en audit_logs.
--   5. RPC rpc_anular_recaudacion_abono:
--      * Valida rol exclusivo Administrador.
--      * Bloqueo pesimista de fila y de socio.
--      * Control de concurrencia optimista obligatorio (p_updated_at).
--      * Reversión de saldo_a_favor (bloquea si el saldo ya fue consumido).
--      * Soft-delete consistente (chk_abonos_anulacion_consistente).
--      * Captura de motivo de anulación en audit_logs.
-- =============================================================================

BEGIN;

-- =============================================================================
-- 1. Columna updated_at para control de concurrencia
-- =============================================================================
ALTER TABLE public.recaudacion_abonos
    ADD COLUMN IF NOT EXISTS updated_at timestamptz NOT NULL DEFAULT now();

COMMENT ON COLUMN public.recaudacion_abonos.updated_at IS
    'Marca de tiempo de última actualización. Utilizada para control de concurrencia optimista (OCC).';


-- =============================================================================
-- 2. RLS: Bloquear UPDATE directo desde clientes
--    Las modificaciones se canalizan exclusivamente por RPCs SECURITY DEFINER.
-- =============================================================================
DROP POLICY IF EXISTS pol_rec_abonos_update ON public.recaudacion_abonos;

CREATE POLICY pol_rec_abonos_update ON public.recaudacion_abonos
    FOR UPDATE TO authenticated
    USING (false)
    WITH CHECK (false);

COMMENT ON POLICY pol_rec_abonos_update ON public.recaudacion_abonos IS
    'Bloquea updates directos vía PostgREST. Toda edición o anulación debe ejecutarse vía RPC rpc_editar_recaudacion_abono o rpc_anular_recaudacion_abono.';


-- =============================================================================
-- 3. TRIGGER de Auditoría en recaudacion_abonos
--    Guarda quién, cuándo, campos modificados y motivo en audit_logs.
-- =============================================================================
DROP TRIGGER IF EXISTS trg_audit_recaudacion_abonos ON public.recaudacion_abonos;

CREATE TRIGGER trg_audit_recaudacion_abonos
    AFTER INSERT OR UPDATE OR DELETE ON public.recaudacion_abonos
    FOR EACH ROW EXECUTE FUNCTION public.log_audit_action();


-- =============================================================================
-- 4. RPC: rpc_editar_recaudacion_abono
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_editar_recaudacion_abono(
    p_id         bigint,
    p_fecha      timestamptz,
    p_monto      numeric,
    p_motivo     text,
    p_updated_at timestamptz
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_actual      record;
    v_saldo_socio numeric;
    v_delta       numeric;
BEGIN
    -- 1. Control de Rol estricto (solo Administrador)
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede modificar recaudaciones por tarjeta.';
    END IF;

    -- 2. Validación de parámetros obligatorios
    IF p_updated_at IS NULL THEN
        RAISE EXCEPTION 'El parámetro updated_at es obligatorio para el control de concurrencia.';
    END IF;

    IF p_fecha IS NULL THEN
        RAISE EXCEPTION 'La fecha de recaudación es obligatoria.';
    END IF;

    IF p_monto IS NULL OR p_monto <= 0 THEN
        RAISE EXCEPTION 'El monto debe ser un valor numérico positivo mayor a cero.';
    END IF;

    IF nullif(trim(p_motivo), '') IS NULL OR length(trim(p_motivo)) < 5 THEN
        RAISE EXCEPTION 'El motivo de la modificación es obligatorio (mínimo 5 caracteres).';
    END IF;

    -- Validación de fecha operativa razonable (no más de 1 día en el futuro)
    IF p_fecha > (now() + interval '1 day') THEN
        RAISE EXCEPTION 'La fecha efectiva de recaudación no puede ser futura.';
    END IF;

    -- 3. Bloqueo pesimista de fila (SELECT FOR UPDATE)
    SELECT * INTO v_actual
    FROM public.recaudacion_abonos
    WHERE id = p_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Recaudación #% no encontrada.', p_id;
    END IF;

    IF v_actual.deleted_at IS NOT NULL THEN
        RAISE EXCEPTION 'La recaudación #% se encuentra anulada y no puede editarse.', p_id;
    END IF;

    -- 4. Verificación de concurrencia optimista
    IF v_actual.updated_at <> p_updated_at THEN
        RAISE EXCEPTION 'El registro fue modificado por otro operador en este intervalo. Por favor, actualice la vista antes de guardar.';
    END IF;

    -- 5. Validación e impacto financiero en saldo_a_favor
    v_delta := p_monto - v_actual.monto;

    IF v_delta <> 0 THEN
        SELECT saldo_a_favor INTO v_saldo_socio
        FROM public.socios
        WHERE id = v_actual.socio_id AND deleted_at IS NULL
        FOR UPDATE;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'El socio #% asociado a la recaudación no existe o está anulado.', v_actual.socio_id;
        END IF;

        -- Si se reduce el monto (v_delta < 0), verificar que el socio tenga saldo suficiente
        IF (coalesce(v_saldo_socio, 0) + v_delta) < 0 THEN
            RAISE EXCEPTION 'No se puede reducir el monto a S/ % (reducción de S/ %): el socio dispone actualmente de solo S/ % de saldo a favor. Parte del saldo ya fue utilizado para amortizar deudas en cuenta corriente.',
                to_char(p_monto, 'FM999,990.00'),
                to_char(abs(v_delta), 'FM999,990.00'),
                to_char(coalesce(v_saldo_socio, 0), 'FM999,990.00');
        END IF;

        -- Ajustar el saldo a favor por la diferencia exacta
        UPDATE public.socios
        SET saldo_a_favor = saldo_a_favor + v_delta
        WHERE id = v_actual.socio_id;
    END IF;

    -- 6. Configuración de variable de sesión para el trigger de auditoría
    PERFORM set_config('app.audit_motivo', trim(p_motivo), true);

    -- 7. Actualización atómica (created_at y created_by permanecen inmutables)
    UPDATE public.recaudacion_abonos
    SET
        fecha      = p_fecha,
        monto      = p_monto,
        updated_at = now()
    WHERE id = p_id;

    RETURN jsonb_build_object(
        'ok',      true,
        'id',      p_id,
        'delta',   v_delta,
        'mensaje', 'Recaudación de tarjeta actualizada correctamente.'
    );
END;
$$;

COMMENT ON FUNCTION public.rpc_editar_recaudacion_abono(bigint, timestamptz, numeric, text, timestamptz) IS
    'Edición atómica y segura de recaudación por tarjeta. Requiere rol Administrador, valida concurrencia (p_updated_at), protege integridad del saldo a favor y audita con motivo.';

GRANT EXECUTE ON FUNCTION public.rpc_editar_recaudacion_abono(bigint, timestamptz, numeric, text, timestamptz) TO authenticated;


-- =============================================================================
-- 5. RPC: rpc_anular_recaudacion_abono
-- =============================================================================
CREATE OR REPLACE FUNCTION public.rpc_anular_recaudacion_abono(
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
    v_actual      record;
    v_saldo_socio numeric;
BEGIN
    -- 1. Control de Rol estricto (solo Administrador)
    IF public.get_my_rol() <> 'Administrador' THEN
        RAISE EXCEPTION 'Acceso denegado: solo el Administrador puede anular recaudaciones por tarjeta.';
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
    FROM public.recaudacion_abonos
    WHERE id = p_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Recaudación #% no encontrada.', p_id;
    END IF;

    IF v_actual.deleted_at IS NOT NULL THEN
        RAISE EXCEPTION 'La recaudación #% ya fue anulada previamente.', p_id;
    END IF;

    -- 4. Verificación de concurrencia optimista
    IF v_actual.updated_at <> p_updated_at THEN
        RAISE EXCEPTION 'El registro fue modificado por otro operador en este intervalo. Por favor, actualice la vista antes de anular.';
    END IF;

    -- 5. Validación e impacto financiero en saldo_a_favor
    SELECT saldo_a_favor INTO v_saldo_socio
    FROM public.socios
    WHERE id = v_actual.socio_id AND deleted_at IS NULL
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'El socio #% asociado a la recaudación no existe o está anulado.', v_actual.socio_id;
    END IF;

    -- Verificar que el socio tenga saldo a favor suficiente para revertir el abono completo
    IF coalesce(v_saldo_socio, 0) < v_actual.monto THEN
        RAISE EXCEPTION 'No se puede anular la recaudación de S/ %: el socio dispone actualmente de solo S/ % de saldo a favor. El saldo recaudado ya fue consumido en pagos o amortizaciones en cuenta corriente.',
            to_char(v_actual.monto, 'FM999,990.00'),
            to_char(coalesce(v_saldo_socio, 0), 'FM999,990.00');
    END IF;

    -- Revertir el saldo a favor restando el monto recaudado
    UPDATE public.socios
    SET saldo_a_favor = saldo_a_favor - v_actual.monto
    WHERE id = v_actual.socio_id;

    -- 6. Configuración de variable de sesión para el trigger de auditoría
    PERFORM set_config('app.audit_motivo', trim(p_motivo), true);

    -- 7. Anulación lógica consistente (satisface chk_abonos_anulacion_consistente)
    UPDATE public.recaudacion_abonos
    SET
        deleted_at       = now(),
        anulado_por      = auth.uid(),
        motivo_anulacion = trim(p_motivo),
        updated_at       = now()
    WHERE id = p_id;

    RETURN jsonb_build_object(
        'ok',      true,
        'id',      p_id,
        'mensaje', 'Recaudación de tarjeta anulada correctamente.'
    );
END;
$$;

COMMENT ON FUNCTION public.rpc_anular_recaudacion_abono(bigint, text, timestamptz) IS
    'Anulación lógica segura y atómica de recaudación por tarjeta. Requiere rol Administrador, valida concurrencia (p_updated_at), revierte saldo_a_favor y audita con motivo.';

GRANT EXECUTE ON FUNCTION public.rpc_anular_recaudacion_abono(bigint, text, timestamptz) TO authenticated;

COMMIT;
