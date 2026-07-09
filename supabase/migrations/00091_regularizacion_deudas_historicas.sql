BEGIN;

-- =============================================================================
-- Migración 00091 — Regularización de Saldos Históricos vs Excel de Julio
-- =============================================================================

DO $$
DECLARE
    v_user_uuid uuid;
BEGIN
    SELECT id INTO v_user_uuid FROM public.perfiles WHERE rol = 'Administrador' AND activo = true LIMIT 1;
    IF v_user_uuid IS NULL THEN v_user_uuid := '00000000-0000-0000-0000-000000000000'; END IF;
    PERFORM set_config('request.jwt.claims', json_build_object('sub', v_user_uuid::text, 'role', 'authenticated')::text, true);

    -- SOCIO: ALVAREZ MARIANELA (ID: 7) | Hueco histórico: S/250.5
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (176, 7, 9, 2026, 6, 250.5, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: AYALA HUASHUAYO NORMA (ID: 11) | Hueco histórico: S/130.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (60, 11, 9, 2026, 6, 130.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: AYALA ELISEO (ID: 12) | Hueco histórico: S/430.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (55, 12, 9, 2026, 6, 430.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: BRAVO ANA (ID: 16) | Hueco histórico: S/199.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (161, 16, 9, 2026, 6, 199.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: CABERO GLORIA (ID: 19) | Hueco histórico: S/650.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (108, 19, 9, 2026, 6, 650.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: CALDERON ESTELA (ID: 22) | Hueco histórico: S/195.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (150, 22, 9, 2026, 6, 195.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: CASTRO ALEJANDRO HORTENCIA (ID: 32) | Hueco histórico: S/195.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (175, 32, 9, 2026, 6, 195.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: CCOYLLO CHINCHAY JUDITH (ID: 36) | Hueco histórico: S/120.7
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (144, 36, 9, 2026, 6, 120.7, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: CCOYLLO POLANCO DANIEL (ID: 38) | Hueco histórico: S/65.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (212, 38, 9, 2026, 6, 65.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: CRUZ LUIS (ID: 48) | Hueco histórico: S/41.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (262, 48, 9, 2026, 6, 41.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: ESTRADA OSCAR (ID: 58) | Hueco histórico: S/194.1
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (257, 58, 9, 2026, 6, 194.1, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: FLORES FLORES UMBELINA (ID: 61) | Hueco histórico: S/460.6
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (258, 61, 9, 2026, 6, 460.6, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: GUTIERRES CASTRO JORGE (ID: 67) | Hueco histórico: S/245.7
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (265, 67, 9, 2026, 6, 245.7, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: HALIRE YUCRA JOSUE (ID: 69) | Hueco histórico: S/200.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (195, 69, 9, 2026, 6, 200.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: HUASHUAYO EUDOSIA (ID: 73) | Hueco histórico: S/530.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (52, 73, 9, 2026, 6, 530.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: HUAMAN YNCA VISITACION (ID: 71) | Hueco histórico: S/250.6
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (235, 71, 9, 2026, 6, 250.6, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: MARIN LONDOÑE MARIA LUZ (ID: 88) | Hueco histórico: S/643.9
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (177, 88, 9, 2026, 6, 643.9, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: MARIN ROCHA ESTEFANY (ID: 89) | Hueco histórico: S/124.7
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (221, 89, 9, 2026, 6, 124.7, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: MAYHUASCA ULISES (ID: 92) | Hueco histórico: S/65.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (282, 92, 9, 2026, 6, 65.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: MEDINA JUAN CARLOS (ID: 97) | Hueco histórico: S/116.5
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (238, 97, 9, 2026, 6, 116.5, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: NICHO ESTHEPANY (ID: 101) | Hueco histórico: S/65.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (239, 101, 9, 2026, 6, 65.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: ORTIZ WELINTONH (ID: 108) | Hueco histórico: S/171.9
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (279, 108, 9, 2026, 6, 171.9, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: PLAZA ROSA (ID: 119) | Hueco histórico: S/76.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (233, 119, 9, 2026, 6, 76.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: PORRAS OLIMPIA (ID: 120) | Hueco histórico: S/236.8
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (218, 120, 9, 2026, 6, 236.8, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: QUISPE COPAYO ELIO (ID: 125) | Hueco histórico: S/1493.6
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (209, 125, 9, 2026, 6, 1493.6, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: REYES MILENA (ID: 132) | Hueco histórico: S/1222.3
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (215, 132, 9, 2026, 6, 1222.3, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: RICSE TERESA (ID: 133) | Hueco histórico: S/0.7
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (231, 133, 9, 2026, 6, 0.7, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: RODRIGUEZ NORA (ID: 138) | Hueco histórico: S/65.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (274, 138, 9, 2026, 6, 65.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: ROJAS LIONILA (ID: 140) | Hueco histórico: S/195.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (116, 140, 9, 2026, 6, 195.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: SANCHEZ LUCIA (ID: 151) | Hueco histórico: S/65.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (162, 151, 9, 2026, 6, 65.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: SOTO SOFIA (ID: 157) | Hueco histórico: S/65.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (181, 157, 9, 2026, 6, 65.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: TORRES MARCELINO (ID: 165) | Hueco histórico: S/5358.2
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (167, 165, 9, 2026, 6, 5358.2, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: TORRES JUANA (ID: 168) | Hueco histórico: S/2498.1
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (178, 168, 9, 2026, 6, 2498.1, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: VALVERDE JUAN (ID: 175) | Hueco histórico: S/5027.1
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (142, 175, 9, 2026, 6, 5027.1, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: VILCHEZ LOURDES (ID: 179) | Hueco histórico: S/200.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (187, 179, 9, 2026, 6, 200.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

    -- SOCIO: YRUPAILLA ISIDRO (ID: 182) | Hueco histórico: S/65.0
    INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
    VALUES (206, 182, 9, 2026, 6, 65.0, 'Pendiente', 'Manual', '2026-06-30', 'Regularización de Saldo Histórico (Outlier)', v_user_uuid);

END $$;
COMMIT;