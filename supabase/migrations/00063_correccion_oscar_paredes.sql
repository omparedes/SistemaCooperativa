-- =============================================================================
-- Migración 00063 — Corrección de deudas cruzadas: Oscar Alfredo vs. Oscar Martin
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- =============================================================================

BEGIN;

DO $correccion_paredes$
DECLARE
    v_user_uuid uuid;
    v_puesto_alfredo bigint := 140; -- Puesto 53
    v_puesto_martin bigint := 92;   -- Puesto 92
BEGIN
    SELECT id INTO v_user_uuid FROM public.perfiles WHERE rol = 'Administrador' AND activo = true LIMIT 1;
    IF v_user_uuid IS NULL THEN v_user_uuid := '00000000-0000-0000-0000-000000000000'; END IF;
    PERFORM set_config('request.jwt.claims', json_build_object('sub', v_user_uuid::text, 'role', 'authenticated')::text, true);

    -- 1. CORREGIR DEUDAS EN PUESTO 53 (OSCAR ALFREDO PAREDES FLORES)
    -- Reducir Luz de Abril 2026 (ID 8835) de S/ 227.00 a S/ 145.00
    UPDATE public.montos_por_cobrar
    SET monto = 145.00,
        observacion = 'Migración de deudas 2026 - LUZ (Corregido: separado de Oscar Martin)'
    WHERE id = 8835 AND puesto_id = v_puesto_alfredo;

    -- Reducir Agua de Abril 2026 (ID 8836) de S/ 12.00 a S/ 6.00
    UPDATE public.montos_por_cobrar
    SET monto = 6.00,
        observacion = 'Migración de deudas 2026 - AGUA (Corregido: separado de Oscar Martin)'
    WHERE id = 8836 AND puesto_id = v_puesto_alfredo;

    -- Reducir Gastos Adm. de Marzo 2026 (ID 8829) de S/ 120.00 a S/ 60.00 y marcar como Pagado
    UPDATE public.montos_por_cobrar
    SET monto = 60.00,
        estado = 'Pagado',
        observacion = 'Migración de deudas 2026 - G. ADM (Corregido: separado de Oscar Martin)'
    WHERE id = 8829 AND puesto_id = v_puesto_alfredo;

    -- Reducir Previsión Social de Marzo 2026 (ID 8830) de S/ 10.00 a S/ 5.00 y marcar como Pagado
    UPDATE public.montos_por_cobrar
    SET monto = 5.00,
        estado = 'Pagado',
        observacion = 'Migración de deudas 2026 - P. SOCIAL (Corregido: separado de Oscar Martin)'
    WHERE id = 8830 AND puesto_id = v_puesto_alfredo;

    -- Reducir Gastos Adm. de Abril 2026 (ID 8831) de S/ 120.00 a S/ 60.00 y marcar como Pagado
    UPDATE public.montos_por_cobrar
    SET monto = 60.00,
        estado = 'Pagado',
        observacion = 'Migración de deudas 2026 - G. ADM (Corregido: separado de Oscar Martin)'
    WHERE id = 8831 AND puesto_id = v_puesto_alfredo;

    -- Reducir Previsión Social de Abril 2026 (ID 8832) de S/ 10.00 a S/ 5.00 y marcar como Pagado
    UPDATE public.montos_por_cobrar
    SET monto = 5.00,
        estado = 'Pagado',
        observacion = 'Migración de deudas 2026 - P. SOCIAL (Corregido: separado de Oscar Martin)'
    WHERE id = 8832 AND puesto_id = v_puesto_alfredo;


    -- 2. INSERTAR DEUDAS PENDIENTES CORRECTAS EN PUESTO 92 (OSCAR MARTIN PAREDES MORALES)
    -- March 2026 G. ADM: S/ 60.00
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (v_puesto_martin, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de deudas 2026 - G. ADM (Reasignado desde Oscar Alfredo)', v_user_uuid);

    -- March 2026 P. SOCIAL: S/ 5.00
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (v_puesto_martin, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de deudas 2026 - P. SOCIAL (Reasignado desde Oscar Alfredo)', v_user_uuid);

    -- April 2026 LUZ: S/ 82.00
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (v_puesto_martin, 1, 2026, 4, 82.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de deudas 2026 - LUZ (Reasignado desde Oscar Alfredo)', v_user_uuid);

    -- April 2026 AGUA: S/ 6.00
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (v_puesto_martin, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de deudas 2026 - AGUA (Reasignado desde Oscar Alfredo)', v_user_uuid);

    -- April 2026 G. ADM: S/ 60.00
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (v_puesto_martin, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de deudas 2026 - G. ADM (Reasignado desde Oscar Alfredo)', v_user_uuid);

    -- April 2026 P. SOCIAL: S/ 5.00
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (v_puesto_martin, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de deudas 2026 - P. SOCIAL (Reasignado desde Oscar Alfredo)', v_user_uuid);

    RAISE NOTICE 'Corregida duplicación para Oscar Alfredo (140) y reasignadas deudas correctas a Oscar Martin (92).';
END;
$correccion_paredes$;

COMMIT;
