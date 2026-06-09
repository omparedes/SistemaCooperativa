BEGIN;

-- =============================================================================
-- Migración 00070 — Insertar deudas pendientes para socios que no tenían match
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- =============================================================================

DO $migration$
DECLARE
    v_user_uuid uuid;
BEGIN
    -- Obtener UUID de un administrador activo para auditoría
    SELECT id INTO v_user_uuid FROM public.perfiles WHERE rol = 'Administrador' AND activo = true LIMIT 1;
    IF v_user_uuid IS NULL THEN v_user_uuid := '00000000-0000-0000-0000-000000000000'; END IF;
    PERFORM set_config('request.jwt.claims', json_build_object('sub', v_user_uuid::text, 'role', 'authenticated')::text, true);

    -- 1. PRADO LLANCARI ZOSIMA (ID 121, Puesto ID 118)
    -- Total Excel: S/ 226.00
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES 
      (118, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-30', 'Migración de deudas 2026 - G. ADM · PRADO LLANCARI ZOSIMA', v_user_uuid),
      (118, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-30', 'Migración de deudas 2026 - P. SOCIAL · PRADO LLANCARI ZOSIMA', v_user_uuid),
      (118, 6, 2025, 11, 48.00, 'Pendiente', 'Manual', '2025-11-30', 'Migración de deudas 2026 - MULTA 27/11/25 · PRADO LLANCARI ZOSIMA', v_user_uuid),
      (118, 6, 2026, 3, 113.00, 'Pendiente', 'Manual', '2026-03-31', 'Migración de deudas 2026 - MULTA 26/03/26 · PRADO LLANCARI ZOSIMA', v_user_uuid);

    -- 2. VARA CASTRO DELIA ERNESTINA F (ID 176, Puesto ID 216)
    -- Total Excel: S/ 459.00
    -- (a) Actualizar deudas de G. ADM que ya existen como pagadas parcialmente y cambiarlas a Pendiente con monto original de 60.00
    UPDATE public.montos_por_cobrar
       SET monto = 60.00,
           estado = 'Pendiente',
           observacion = 'Migración de deudas 2026 - G. ADM (Alineado) · VARA CASTRO DELIA ERNESTINA F',
           updated_at = now()
     WHERE puesto_id = 216 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 3;

    UPDATE public.montos_por_cobrar
       SET monto = 60.00,
           estado = 'Pendiente',
           observacion = 'Migración de deudas 2026 - G. ADM (Alineado) · VARA CASTRO DELIA ERNESTINA F',
           updated_at = now()
     WHERE puesto_id = 216 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4;

    -- (b) Insertar las otras 10 deudas pendientes
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES 
      (216, 6, 2025, 11, 113.00, 'Pendiente', 'Manual', '2025-11-30', 'Migración de deudas 2026 - MULTA 27/11/25 · VARA CASTRO DELIA ERNESTINA F', v_user_uuid),
      (216, 1, 2026, 2, 29.00, 'Pendiente', 'Manual', '2026-02-28', 'Migración de deudas 2026 - LUZ · VARA CASTRO DELIA ERNESTINA F', v_user_uuid),
      (216, 2, 2026, 2, 14.00, 'Pendiente', 'Manual', '2026-02-28', 'Migración de deudas 2026 - AGUA · VARA CASTRO DELIA ERNESTINA F', v_user_uuid),
      (216, 1, 2026, 3, 30.00, 'Pendiente', 'Manual', '2026-03-31', 'Migración de deudas 2026 - LUZ · VARA CASTRO DELIA ERNESTINA F', v_user_uuid),
      (216, 2, 2026, 3, 21.00, 'Pendiente', 'Manual', '2026-03-31', 'Migración de deudas 2026 - AGUA · VARA CASTRO DELIA ERNESTINA F', v_user_uuid),
      (216, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-31', 'Migración de deudas 2026 - P. SOCIAL · VARA CASTRO DELIA ERNESTINA F', v_user_uuid),
      (216, 6, 2026, 3, 113.00, 'Pendiente', 'Manual', '2026-03-31', 'Migración de deudas 2026 - MULTA 26/03/2026 · VARA CASTRO DELIA ERNESTINA F', v_user_uuid),
      (216, 1, 2026, 4, 28.00, 'Pendiente', 'Manual', '2026-04-30', 'Migración de deudas 2026 - LUZ · VARA CASTRO DELIA ERNESTINA F', v_user_uuid),
      (216, 2, 2026, 4, 21.00, 'Pendiente', 'Manual', '2026-04-30', 'Migración de deudas 2026 - AGUA · VARA CASTRO DELIA ERNESTINA F', v_user_uuid),
      (216, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-30', 'Migración de deudas 2026 - P. SOCIAL · VARA CASTRO DELIA ERNESTINA F', v_user_uuid);

END $migration$;

COMMIT;
