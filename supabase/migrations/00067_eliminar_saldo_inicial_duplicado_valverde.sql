-- =============================================================================
-- Migración 00067 — Eliminar Saldo Inicial 2025 duplicado de Juan Marcelino Valverde
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- =============================================================================

DO $$
DECLARE
    v_admin_uuid uuid;
BEGIN
    -- Obtener UUID de administrador activo para auditoría
    SELECT id INTO v_admin_uuid 
    FROM public.perfiles 
    WHERE rol = 'Administrador' AND activo = true 
    LIMIT 1;
    
    IF v_admin_uuid IS NULL THEN 
        v_admin_uuid := '00000000-0000-0000-0000-000000000000'; 
    END IF;

    -- Soft-delete del saldo inicial duplicado
    UPDATE public.montos_por_cobrar
    SET deleted_at = now(),
        anulado_por = v_admin_uuid,
        motivo_anulacion = 'Duplicado por migración de detalle de deudas históricas'
    WHERE id = 175;
END;
$$;
