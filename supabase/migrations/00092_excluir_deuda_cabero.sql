BEGIN;

-- =============================================================================
-- Migración 00092 — Excluir deudas de Gloria Cabero por decisión de consejo
-- =============================================================================

DO $$
DECLARE
    v_user_uuid uuid;
BEGIN
    -- Obtener UUID de un administrador activo para auditoría
    SELECT id INTO v_user_uuid FROM public.perfiles WHERE rol = 'Administrador' AND activo = true LIMIT 1;
    IF v_user_uuid IS NULL THEN v_user_uuid := '00000000-0000-0000-0000-000000000000'; END IF;
    PERFORM set_config('request.jwt.claims', json_build_object('sub', v_user_uuid::text, 'role', 'authenticated')::text, true);

    -- Socio: CABERO MENDOZA GLORIA LUCINDA (ID: 19)
    -- Acción solicitada: Borrar físicamente las deudas pendientes para la presentación
    DELETE FROM public.montos_por_cobrar
     WHERE (socio_id = 19 OR puesto_id IN (
               SELECT puesto_id FROM public.historial_titularidad WHERE socio_id = 19
           ))
       AND estado IN ('Pendiente', 'Pagado Parcial');

END $$;

COMMIT;
