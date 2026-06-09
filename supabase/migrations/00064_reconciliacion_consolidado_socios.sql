-- =============================================================================
-- Migración 00064 — Reconciliación de deudas de socios contra consolidado revisado
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- Generado automáticamente: 2026-06-08
-- Fuente: migracion_coop/2026/SOCIOS - CONSOLIDADO POR COBRAR REVISADO.xlsx (Detalle por cobrar)
-- MÉTODO: UPDATE para deudas con pagos aplicados (preserva detalle_pagos),
--         INSERT para deudas nuevas, soft-delete (deleted_at) para huérfanos sin pagos.
-- =============================================================================

DO $reconciliacion_socios$
DECLARE
    v_user_uuid uuid := '9cf2712a-3e6b-4634-84f0-eb40aa840f87';
BEGIN
    PERFORM set_config('request.jwt.claims', json_build_object('sub', v_user_uuid::text, 'role', 'authenticated')::text, true);

    -- ── Actualizaciones (registros con pagos aplicados u monto/estado desalineado) ──
    UPDATE public.montos_por_cobrar
       SET monto = 86.00,
           estado = 'Pendiente',
           observacion = 'Reconciliación 2026 (consolidado revisado) - LUZ (Actualizado)',
           updated_at = now()
     WHERE id = 7334 AND deleted_at IS NULL;
    UPDATE public.montos_por_cobrar
       SET monto = 12.00,
           estado = 'Pendiente',
           observacion = 'Reconciliación 2026 (consolidado revisado) - AGUA (Actualizado)',
           updated_at = now()
     WHERE id = 7335 AND deleted_at IS NULL;
    UPDATE public.montos_por_cobrar
       SET monto = 120.00,
           estado = 'Pendiente',
           observacion = 'Reconciliación 2026 (consolidado revisado) - GASTOS ADMINISTRATIVOS (Actualizado)',
           updated_at = now()
     WHERE id = 7332 AND deleted_at IS NULL;
    UPDATE public.montos_por_cobrar
       SET monto = 10.00,
           estado = 'Pendiente',
           observacion = 'Reconciliación 2026 (consolidado revisado) - PREVISIÓN SOCIAL (Actualizado)',
           updated_at = now()
     WHERE id = 7333 AND deleted_at IS NULL;
    UPDATE public.montos_por_cobrar
       SET monto = 8.10,
           estado = 'Pendiente',
           observacion = 'Reconciliación 2026 (consolidado revisado) - LUZ (Actualizado)',
           updated_at = now()
     WHERE id = 7338 AND deleted_at IS NULL;
    UPDATE public.montos_por_cobrar
       SET monto = 120.00,
           estado = 'Pendiente',
           observacion = 'Reconciliación 2026 (consolidado revisado) - GASTOS ADMINISTRATIVOS (Actualizado)',
           updated_at = now()
     WHERE id = 7336 AND deleted_at IS NULL;
    UPDATE public.montos_por_cobrar
       SET monto = 10.00,
           estado = 'Pendiente',
           observacion = 'Reconciliación 2026 (consolidado revisado) - PREVISIÓN SOCIAL (Actualizado)',
           updated_at = now()
     WHERE id = 7337 AND deleted_at IS NULL;
    UPDATE public.montos_por_cobrar
       SET monto = 32.50,
           estado = 'Pendiente',
           observacion = 'Reconciliación 2026 (consolidado revisado) - LUZ (Actualizado)',
           updated_at = now()
     WHERE id = 6533 AND deleted_at IS NULL;
    UPDATE public.montos_por_cobrar
       SET monto = 6.00,
           estado = 'Pendiente',
           observacion = 'Reconciliación 2026 (consolidado revisado) - AGUA (Actualizado)',
           updated_at = now()
     WHERE id = 6534 AND deleted_at IS NULL;
    UPDATE public.montos_por_cobrar
       SET monto = 73.90,
           estado = 'Pendiente',
           observacion = 'Reconciliación 2026 (consolidado revisado) - LUZ (Actualizado)',
           updated_at = now()
     WHERE id = 9397 AND deleted_at IS NULL;
    UPDATE public.montos_por_cobrar
       SET monto = 195.40,
           estado = 'Pendiente',
           observacion = 'Reconciliación 2026 (consolidado revisado) - AGUA (Actualizado)',
           updated_at = now()
     WHERE id = 9398 AND deleted_at IS NULL;
    UPDATE public.montos_por_cobrar
       SET monto = 120.00,
           estado = 'Pendiente',
           observacion = 'Reconciliación 2026 (consolidado revisado) - GASTOS ADMINISTRATIVOS (Actualizado)',
           updated_at = now()
     WHERE id = 9392 AND deleted_at IS NULL;
    UPDATE public.montos_por_cobrar
       SET monto = 10.00,
           estado = 'Pendiente',
           observacion = 'Reconciliación 2026 (consolidado revisado) - PREVISIÓN SOCIAL (Actualizado)',
           updated_at = now()
     WHERE id = 9399 AND deleted_at IS NULL;

    -- ── Inserciones (deudas presentes en el consolidado pero ausentes en BD) ──
    INSERT INTO public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (171, 1, 2026, 4, 39.00, 'Pendiente', 'Manual', '2026-04-01', 'Reconciliación 2026 (consolidado revisado) - LUZ', v_user_uuid)
    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes) WHERE deleted_at IS NULL AND puesto_id IS NOT NULL DO NOTHING;
    INSERT INTO public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (171, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Reconciliación 2026 (consolidado revisado) - AGUA', v_user_uuid)
    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes) WHERE deleted_at IS NULL AND puesto_id IS NOT NULL DO NOTHING;

END $reconciliacion_socios$;

-- Verificación rápida posterior:
-- SELECT count(*) AS pendientes, round(sum(monto)::numeric,2) AS suma
--   FROM public.montos_por_cobrar WHERE estado = 'Pendiente' AND deleted_at IS NULL;
