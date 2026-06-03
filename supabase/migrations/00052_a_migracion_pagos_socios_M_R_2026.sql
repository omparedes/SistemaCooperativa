-- =============================================================================
-- Migración 00052_a — Carga de Pagos Detallados 2026 (Lista Socios M-R)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- Generado: 2026-06-01
-- =============================================================================

DO $$
DECLARE
    v_user_uuid         uuid;
    v_pago_res          json;
    v_pago_id           bigint;
    v_monto_id          bigint;
    v_cant_pagos        integer := 0;
    v_cant_deudas       integer := 0;
BEGIN
    -- 1. Obtener un UUID de usuario administrador para auditoría
    SELECT id INTO v_user_uuid FROM public.perfiles WHERE rol = 'Administrador' AND activo = true LIMIT 1;
    IF v_user_uuid IS NULL THEN
        v_user_uuid := '00000000-0000-0000-0000-000000000000';
    END IF;

    -- Simular sesión de Supabase/JWT para pasar validaciones get_my_rol()
    PERFORM set_config('request.jwt.claims', json_build_object('sub', v_user_uuid::text, 'role', 'authenticated')::text, true);

    -- =========================================================================
    -- SOCIO: MARIN ROCHA ESTEFANY JULISSA (Puesto: 126, ID: 89)
    -- =========================================================================
    DECLARE
        v_socio_89 bigint := 89;
        v_puesto_89 bigint := 221;
        v_m_id_89_0 bigint;
        v_m_id_89_1 bigint;
        v_m_id_89_2 bigint;
        v_m_id_89_3 bigint;
        v_m_id_89_4 bigint;
        v_m_id_89_5 bigint;
        v_m_id_89_6 bigint;
        v_m_id_89_7 bigint;
        v_m_id_89_8 bigint;
        v_m_id_89_9 bigint;
        v_m_id_89_10 bigint;
        v_m_id_89_11 bigint;
        v_m_id_89_12 bigint;
        v_m_id_89_13 bigint;
        v_m_id_89_14 bigint;
        v_m_id_89_15 bigint;
        v_m_id_89_16 bigint;
        v_m_id_89_17 bigint;
        v_m_id_89_18 bigint;
        v_m_id_89_19 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_89 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_89 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_89;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_89 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_89;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 1, 2025, 11, 38.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_89_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_89_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_89_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_89_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 1, 2025, 12, 33.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_89_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_89_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_89_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_89_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 1, 2026, 1, 37.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_89_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_89_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_89_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_89_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 1, 2026, 2, 40.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_89_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_89_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_89_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_89_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 1, 2026, 3, 39.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_89_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_89_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_89_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_89, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_89_19;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_89,
            v_socio_89,
            NULL,
            214.80,
            'Efectivo',
            '32430',
            'Pago histórico recibo N° 32430',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_89_0, 'monto_aplicado', 38.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_89_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_89_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_89_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_89_4, 'monto_aplicado', 33.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_89_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_89_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_89_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_89,
            v_socio_89,
            NULL,
            107.50,
            'Efectivo',
            '32829',
            'Pago histórico recibo N° 32829',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_89_8, 'monto_aplicado', 37.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_89_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_89_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_89_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_89,
            v_socio_89,
            NULL,
            111.10,
            'Efectivo',
            '32900',
            'Pago histórico recibo N° 32900',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_89_12, 'monto_aplicado', 40.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_89_13, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_89_14, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_89_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_89,
            v_socio_89,
            NULL,
            110.10,
            'Efectivo',
            '33091',
            'Pago histórico recibo N° 33091',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_89_16, 'monto_aplicado', 39.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_89_17, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_89_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_89_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-19 12:00:00-05', created_at = '2026-05-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-19 12:00:00-05', created_at = '2026-05-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: MAYHUASCA BASTIDAS DE TORRES CLUDDY AYDE (Puesto: 135, ID: 90)
    -- =========================================================================
    DECLARE
        v_socio_90 bigint := 90;
        v_puesto_90 bigint := 230;
        v_m_id_90_0 bigint;
        v_m_id_90_1 bigint;
        v_m_id_90_2 bigint;
        v_m_id_90_3 bigint;
        v_m_id_90_4 bigint;
        v_m_id_90_5 bigint;
        v_m_id_90_6 bigint;
        v_m_id_90_7 bigint;
        v_m_id_90_8 bigint;
        v_m_id_90_9 bigint;
        v_m_id_90_10 bigint;
        v_m_id_90_11 bigint;
        v_m_id_90_12 bigint;
        v_m_id_90_13 bigint;
        v_m_id_90_14 bigint;
        v_m_id_90_15 bigint;
        v_m_id_90_16 bigint;
        v_m_id_90_17 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_90 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_90 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_90;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_90 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_90;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 1, 2025, 11, 328.20, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_90_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 2, 2025, 11, 27.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_90_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 1, 2025, 12, 330.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_90_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 2, 2025, 12, 28.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_90_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_90_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_90_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_90_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 1, 2026, 1, 362.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_90_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 2, 2026, 1, 30.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_90_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_90_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_90_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 1, 2026, 2, 406.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_90_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 2, 2026, 2, 7.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_90_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_90_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_90_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 1, 2026, 3, 358.60, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_90_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 2, 2026, 3, 30.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_90_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_90, 3, 2026, 4, 30.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_90_17;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_90,
            v_socio_90,
            NULL,
            355.70,
            'Efectivo',
            '32285',
            'Pago histórico recibo N° 32285',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_90_0, 'monto_aplicado', 328.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_90_1, 'monto_aplicado', 27.50, 'cubierto_completo', true)),
            0.00,
            '2026-01-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_90,
            v_socio_90,
            NULL,
            368.90,
            'Efectivo',
            '32482',
            'Pago histórico recibo N° 32482',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_90_2, 'monto_aplicado', 330.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_90_3, 'monto_aplicado', 28.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_90_6, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-09 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-09 12:00:00-05', created_at = '2026-02-09 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-09 12:00:00-05', created_at = '2026-02-09 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_90,
            v_socio_90,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_90_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_90_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_90,
            v_socio_90,
            NULL,
            392.00,
            'Efectivo',
            '32565',
            'Pago histórico recibo N° 32565',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_90_7, 'monto_aplicado', 362.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_90_8, 'monto_aplicado', 30.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-24 12:00:00-05', created_at = '2026-02-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-24 12:00:00-05', created_at = '2026-02-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_90,
            v_socio_90,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_90_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_90_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_90,
            v_socio_90,
            NULL,
            413.80,
            'Efectivo',
            '32855',
            'Pago histórico recibo N° 32855',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_90_11, 'monto_aplicado', 406.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_90_12, 'monto_aplicado', 7.70, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_90,
            v_socio_90,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_90_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_90_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_90,
            v_socio_90,
            NULL,
            388.60,
            'Efectivo',
            '32968',
            'Pago histórico recibo N° 32968',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_90_15, 'monto_aplicado', 358.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_90_16, 'monto_aplicado', 30.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-27 12:00:00-05', created_at = '2026-04-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-27 12:00:00-05', created_at = '2026-04-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_90,
            v_socio_90,
            NULL,
            30.00,
            'Transferencia',
            'TARJETA-ABRIL',
            'Pago mensual vía banco - TARJETA-ABRIL',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_90_17, 'monto_aplicado', 30.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: MAYHUASCA BASTIDAS MARILU (Puesto: 186, ID: 91)
    -- =========================================================================
    DECLARE
        v_socio_91 bigint := 91;
        v_puesto_91 bigint := 280;
        v_m_id_91_0 bigint;
        v_m_id_91_1 bigint;
        v_m_id_91_2 bigint;
        v_m_id_91_3 bigint;
        v_m_id_91_4 bigint;
        v_m_id_91_5 bigint;
        v_m_id_91_6 bigint;
        v_m_id_91_7 bigint;
        v_m_id_91_8 bigint;
        v_m_id_91_9 bigint;
        v_m_id_91_10 bigint;
        v_m_id_91_11 bigint;
        v_m_id_91_12 bigint;
        v_m_id_91_13 bigint;
        v_m_id_91_14 bigint;
        v_m_id_91_15 bigint;
        v_m_id_91_16 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_91 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_91 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_91;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_91 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_91;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_91, 1, 2025, 11, 236.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_91_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_91, 2, 2025, 11, 22.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_91_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_91, 1, 2025, 12, 224.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_91_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_91, 2, 2025, 12, 23.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_91_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_91, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_91_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_91, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_91_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_91, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_91_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_91, 1, 2026, 1, 184.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_91_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_91, 2, 2026, 1, 31.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_91_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_91, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_91_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_91, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_91_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_91, 1, 2026, 2, 12.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_91_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_91, 2, 2026, 2, 31.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_91_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_91, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_91_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_91, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_91_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_91, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_91_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_91, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_91_16;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_91,
            v_socio_91,
            NULL,
            258.90,
            'Efectivo',
            '32319',
            'Pago histórico recibo N° 32319',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_91_0, 'monto_aplicado', 236.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_91_1, 'monto_aplicado', 22.60, 'cubierto_completo', true)),
            0.00,
            '2026-01-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_91,
            v_socio_91,
            NULL,
            257.60,
            'Efectivo',
            '32502',
            'Pago histórico recibo N° 32502',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_91_2, 'monto_aplicado', 224.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_91_3, 'monto_aplicado', 23.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_91_6, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_91,
            v_socio_91,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_91_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_91_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_91,
            v_socio_91,
            NULL,
            215.50,
            'Efectivo',
            '32599',
            'Pago histórico recibo N° 32599',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_91_7, 'monto_aplicado', 184.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_91_8, 'monto_aplicado', 31.10, 'cubierto_completo', true)),
            0.00,
            '2026-03-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_91,
            v_socio_91,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_91_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_91_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_91,
            v_socio_91,
            NULL,
            43.60,
            'Efectivo',
            '32721',
            'Pago histórico recibo N° 32721',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_91_11, 'monto_aplicado', 12.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_91_12, 'monto_aplicado', 31.20, 'cubierto_completo', true)),
            0.00,
            '2026-03-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_91,
            v_socio_91,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_91_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_91_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_91,
            v_socio_91,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_91_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_91_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: MAYHUASCA BASTIDAS ULISES (Puesto: 188, ID: 92)
    -- =========================================================================
    DECLARE
        v_socio_92 bigint := 92;
        v_puesto_92 bigint := 282;
        v_m_id_92_0 bigint;
        v_m_id_92_1 bigint;
        v_m_id_92_2 bigint;
        v_m_id_92_3 bigint;
        v_m_id_92_4 bigint;
        v_m_id_92_5 bigint;
        v_m_id_92_6 bigint;
        v_m_id_92_7 bigint;
        v_m_id_92_8 bigint;
        v_m_id_92_9 bigint;
        v_m_id_92_10 bigint;
        v_m_id_92_11 bigint;
        v_m_id_92_12 bigint;
        v_m_id_92_13 bigint;
        v_m_id_92_14 bigint;
        v_m_id_92_15 bigint;
        v_m_id_92_16 bigint;
        v_m_id_92_17 bigint;
        v_m_id_92_18 bigint;
        v_m_id_92_19 bigint;
        v_m_id_92_20 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_92 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_92 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_92;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_92 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_92;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 1, 2025, 11, 38.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_92_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_92_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 1, 2025, 12, 33.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_92_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_92_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_92_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_92_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_92_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 1, 2026, 1, 25.80, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_92_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_92_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 1, 2026, 2, 34.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_92_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_92_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_92_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_92_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 1, 2026, 3, 40.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_92_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_92_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_92_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_92_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 1, 2026, 4, 45.20, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_92_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_92_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_92_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_92, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_92_20;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_92,
            v_socio_92,
            NULL,
            159.20,
            'Efectivo',
            '32489',
            'Pago histórico recibo N° 32489',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_92_0, 'monto_aplicado', 38.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_2, 'monto_aplicado', 33.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_3, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_6, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-10 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-10 12:00:00-05', created_at = '2026-02-10 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-10 12:00:00-05', created_at = '2026-02-10 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_92,
            v_socio_92,
            NULL,
            136.00,
            'Efectivo',
            '32903',
            'Pago histórico recibo N° 32903',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_92_7, 'monto_aplicado', 25.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_8, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_9, 'monto_aplicado', 34.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_10, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_11, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_92,
            v_socio_92,
            NULL,
            227.30,
            'Efectivo',
            '33115',
            'Pago histórico recibo N° 33115',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_92_13, 'monto_aplicado', 40.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_14, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_16, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_17, 'monto_aplicado', 45.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_18, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_92_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: MAYTA COLQUI VIOLETA (Puesto: 158, ID: 93)
    -- =========================================================================
    DECLARE
        v_socio_93 bigint := 93;
        v_puesto_93 bigint := 253;
        v_m_id_93_0 bigint;
        v_m_id_93_1 bigint;
        v_m_id_93_2 bigint;
        v_m_id_93_3 bigint;
        v_m_id_93_4 bigint;
        v_m_id_93_5 bigint;
        v_m_id_93_6 bigint;
        v_m_id_93_7 bigint;
        v_m_id_93_8 bigint;
        v_m_id_93_9 bigint;
        v_m_id_93_10 bigint;
        v_m_id_93_11 bigint;
        v_m_id_93_12 bigint;
        v_m_id_93_13 bigint;
        v_m_id_93_14 bigint;
        v_m_id_93_15 bigint;
        v_m_id_93_16 bigint;
        v_m_id_93_17 bigint;
        v_m_id_93_18 bigint;
        v_m_id_93_19 bigint;
        v_m_id_93_20 bigint;
        v_m_id_93_21 bigint;
        v_m_id_93_22 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_93 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_93 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_93;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_93 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_93;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 1, 2025, 11, 24.20, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_93_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 2, 2025, 11, 13.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_93_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 3, 2025, 11, 46.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_93_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_93_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 1, 2025, 12, 29.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_93_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 2, 2025, 12, 13.80, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_93_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 3, 2025, 12, 20.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_93_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_93_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_93_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 1, 2026, 1, 27.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_93_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 2, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_93_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_93_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_93_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 1, 2026, 2, 14.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_93_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 2, 2026, 2, 13.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_93_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_93_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_93_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 1, 2026, 3, 9.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_93_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 2, 2026, 3, 10.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_93_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_93_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_93_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_93_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_93, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_93_22;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_93,
            v_socio_93,
            NULL,
            157.50,
            'Efectivo',
            '32412',
            'Pago histórico recibo N° 32412',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_93_0, 'monto_aplicado', 24.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_1, 'monto_aplicado', 13.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_2, 'monto_aplicado', 46.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_4, 'monto_aplicado', 29.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_5, 'monto_aplicado', 13.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_6, 'monto_aplicado', 20.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_93,
            v_socio_93,
            NULL,
            32.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_93_8, 'monto_aplicado', 32.00, 'cubierto_completo', false)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_93,
            v_socio_93,
            NULL,
            168.80,
            'Efectivo',
            '32744',
            'Pago histórico recibo N° 32744',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_93_9, 'monto_aplicado', 27.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_10, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_8, 'monto_aplicado', 28.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_13, 'monto_aplicado', 14.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_14, 'monto_aplicado', 13.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_93,
            v_socio_93,
            NULL,
            84.40,
            'Efectivo',
            '33026',
            'Pago histórico recibo N° 33026',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_93_17, 'monto_aplicado', 9.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_18, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_93,
            v_socio_93,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_93_21, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_93_22, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: MEDINA JOTA DE CACERES VICENTA (Puesto: 5, ID: 96)
    -- =========================================================================
    DECLARE
        v_socio_96 bigint := 96;
        v_puesto_96 bigint := 29;
        v_m_id_96_0 bigint;
        v_m_id_96_1 bigint;
        v_m_id_96_2 bigint;
        v_m_id_96_3 bigint;
        v_m_id_96_4 bigint;
        v_m_id_96_5 bigint;
        v_m_id_96_6 bigint;
        v_m_id_96_7 bigint;
        v_m_id_96_8 bigint;
        v_m_id_96_9 bigint;
        v_m_id_96_10 bigint;
        v_m_id_96_11 bigint;
        v_m_id_96_12 bigint;
        v_m_id_96_13 bigint;
        v_m_id_96_14 bigint;
        v_m_id_96_15 bigint;
        v_m_id_96_16 bigint;
        v_m_id_96_17 bigint;
        v_m_id_96_18 bigint;
        v_m_id_96_19 bigint;
        v_m_id_96_20 bigint;
        v_m_id_96_21 bigint;
        v_m_id_96_22 bigint;
        v_m_id_96_23 bigint;
        v_m_id_96_24 bigint;
        v_m_id_96_25 bigint;
        v_m_id_96_26 bigint;
        v_m_id_96_27 bigint;
        v_m_id_96_28 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_96 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_96 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_96;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_96 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_96;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 6, 2026, 3, 215.60, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - MULTA 07/03/24', v_user_uuid)
        RETURNING id INTO v_m_id_96_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 6, 2026, 7, 107.80, 'Pendiente', 'Manual', '2026-07-01', 'Migración de pagos 2026 - MULTA 11/07/24', v_user_uuid)
        RETURNING id INTO v_m_id_96_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 18, 2026, 8, 15.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - TALONARIO SANTA ROSA', v_user_uuid)
        RETURNING id INTO v_m_id_96_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 1, 2026, 10, 146.50, 'Pendiente', 'Manual', '2026-10-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_96_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 2, 2026, 10, 7.00, 'Pendiente', 'Manual', '2026-10-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_96_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_96_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_96_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 1, 2025, 11, 138.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_96_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_96_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 6, 2025, 11, 56.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - MULTA 27/11/25', v_user_uuid)
        RETURNING id INTO v_m_id_96_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_96_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_96_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 1, 2025, 12, 140.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_96_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_96_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_96_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 1, 2026, 1, 136.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_96_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_96_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_96_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_96_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_96_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_96_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 1, 2026, 2, 134.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_96_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_96_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 1, 2026, 3, 139.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_96_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_96_24;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_96_25;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_96_26;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_96_27;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_96, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_96_28;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_96,
            v_socio_96,
            NULL,
            379.90,
            'Efectivo',
            '33140',
            'Pago histórico recibo N° 33140',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_96_0, 'monto_aplicado', 51.30, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_96_0, 'monto_aplicado', 51.30, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_96_1, 'monto_aplicado', 51.30, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_96_0, 'monto_aplicado', 56.50, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_96_1, 'monto_aplicado', 56.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_9, 'monto_aplicado', 56.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_0, 'monto_aplicado', 56.50, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_96,
            v_socio_96,
            NULL,
            161.00,
            'Efectivo',
            '33054',
            'Pago histórico recibo N° 33054',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_96_2, 'monto_aplicado', 15.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_22, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_24, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_25, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_26, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_27, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_28, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_96,
            v_socio_96,
            NULL,
            218.50,
            'Efectivo',
            '32296',
            'Pago histórico recibo N° 32296',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_96_3, 'monto_aplicado', 146.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_4, 'monto_aplicado', 7.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_5, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_6, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_96,
            v_socio_96,
            NULL,
            144.60,
            'Efectivo',
            '32419',
            'Pago histórico recibo N° 32419',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_96_7, 'monto_aplicado', 138.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_8, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_96,
            v_socio_96,
            NULL,
            65.00,
            'Efectivo',
            '32453',
            'Pago histórico recibo N° 32453',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_96_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_96,
            v_socio_96,
            NULL,
            146.60,
            'Efectivo',
            '32530',
            'Pago histórico recibo N° 32530',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_96_12, 'monto_aplicado', 140.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_13, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_96,
            v_socio_96,
            NULL,
            10.00,
            'Efectivo',
            '32922',
            'Pago histórico recibo N° 32922',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_96_14, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-26 12:00:00-05', created_at = '2026-03-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-26 12:00:00-05', created_at = '2026-03-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_96,
            v_socio_96,
            NULL,
            141.60,
            'Efectivo',
            '32926',
            'Pago histórico recibo N° 32926',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_96_15, 'monto_aplicado', 136.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_96,
            v_socio_96,
            NULL,
            126.00,
            'Efectivo',
            '33021',
            'Pago histórico recibo N° 33021',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_96_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_18, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_19, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_96,
            v_socio_96,
            NULL,
            273.90,
            'Efectivo',
            '33052',
            'Pago histórico recibo N° 33052',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_96_21, 'monto_aplicado', 134.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_96_23, 'monto_aplicado', 139.30, 'cubierto_completo', true)),
            0.00,
            '2026-05-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: MEDINA MEDRANO JUAN CARLOS (Puesto: 143, ID: 97)
    -- =========================================================================
    DECLARE
        v_socio_97 bigint := 97;
        v_puesto_97 bigint := 238;
        v_m_id_97_0 bigint;
        v_m_id_97_1 bigint;
        v_m_id_97_2 bigint;
        v_m_id_97_3 bigint;
        v_m_id_97_4 bigint;
        v_m_id_97_5 bigint;
        v_m_id_97_6 bigint;
        v_m_id_97_7 bigint;
        v_m_id_97_8 bigint;
        v_m_id_97_9 bigint;
        v_m_id_97_10 bigint;
        v_m_id_97_11 bigint;
        v_m_id_97_12 bigint;
        v_m_id_97_13 bigint;
        v_m_id_97_14 bigint;
        v_m_id_97_15 bigint;
        v_m_id_97_16 bigint;
        v_m_id_97_17 bigint;
        v_m_id_97_18 bigint;
        v_m_id_97_19 bigint;
        v_m_id_97_20 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_97 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_97 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_97;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_97 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_97;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_97_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_97_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 1, 2025, 11, 9.40, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_97_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_97_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_97_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_97_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 1, 2025, 12, 8.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_97_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_97_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 1, 2026, 1, 8.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_97_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_97_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_97_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_97_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_97_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 1, 2026, 2, 8.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_97_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_97_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_97_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_97_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 1, 2026, 3, 6.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_97_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 2, 2026, 3, 17.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_97_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_97_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_97, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_97_20;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_97,
            v_socio_97,
            NULL,
            130.00,
            'Efectivo',
            '32327',
            'Pago histórico recibo N° 32327',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_97_0, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_97_1, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_97_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_97_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_97,
            v_socio_97,
            NULL,
            118.00,
            'Efectivo',
            '32570',
            'Pago histórico recibo N° 32570',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_97_2, 'monto_aplicado', 9.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_97_3, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_97_6, 'monto_aplicado', 8.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_97_7, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_97_8, 'monto_aplicado', 8.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_97_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_97_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_97_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_97_12, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-25 12:00:00-05', created_at = '2026-02-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-25 12:00:00-05', created_at = '2026-02-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_97,
            v_socio_97,
            NULL,
            79.70,
            'Efectivo',
            '32815',
            'Pago histórico recibo N° 32815',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_97_13, 'monto_aplicado', 8.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_97_14, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_97_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_97_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_97,
            v_socio_97,
            NULL,
            89.40,
            'Efectivo',
            '32998',
            'Pago histórico recibo N° 32998',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_97_17, 'monto_aplicado', 6.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_97_18, 'monto_aplicado', 17.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_97_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_97_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-04 12:00:00-05', created_at = '2026-05-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-04 12:00:00-05', created_at = '2026-05-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: MELO BACA MARINA (Puesto: 122, ID: 98)
    -- =========================================================================
    DECLARE
        v_socio_98 bigint := 98;
        v_puesto_98 bigint := 217;
        v_m_id_98_0 bigint;
        v_m_id_98_1 bigint;
        v_m_id_98_2 bigint;
        v_m_id_98_3 bigint;
        v_m_id_98_4 bigint;
        v_m_id_98_5 bigint;
        v_m_id_98_6 bigint;
        v_m_id_98_7 bigint;
        v_m_id_98_8 bigint;
        v_m_id_98_9 bigint;
        v_m_id_98_10 bigint;
        v_m_id_98_11 bigint;
        v_m_id_98_12 bigint;
        v_m_id_98_13 bigint;
        v_m_id_98_14 bigint;
        v_m_id_98_15 bigint;
        v_m_id_98_16 bigint;
        v_m_id_98_17 bigint;
        v_m_id_98_18 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_98 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_98 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_98;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_98 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_98;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 1, 2025, 11, 831.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_98_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 2, 2025, 11, 20.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_98_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 1, 2025, 12, 621.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_98_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 2, 2025, 12, 24.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_98_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_98_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_98_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 1, 2026, 1, 711.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_98_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 2, 2026, 1, 30.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_98_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_98_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_98_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_98_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 1, 2026, 2, 708.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_98_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 2, 2026, 2, 33.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_98_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_98_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_98_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 1, 2026, 3, 708.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_98_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 2, 2026, 3, 34.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_98_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_98_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_98, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_98_18;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_98,
            v_socio_98,
            NULL,
            851.80,
            'Efectivo',
            '32293',
            'Pago histórico recibo N° 32293',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_98_0, 'monto_aplicado', 831.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_98_1, 'monto_aplicado', 20.10, 'cubierto_completo', true)),
            0.00,
            '2026-01-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_98,
            v_socio_98,
            NULL,
            646.50,
            'Efectivo',
            '32451',
            'Pago histórico recibo N° 32451',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_98_2, 'monto_aplicado', 621.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_98_3, 'monto_aplicado', 24.60, 'cubierto_completo', true)),
            0.00,
            '2026-02-03 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-03 12:00:00-05', created_at = '2026-02-03 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-03 12:00:00-05', created_at = '2026-02-03 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_98,
            v_socio_98,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_98_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_98_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_98,
            v_socio_98,
            NULL,
            769.60,
            'Efectivo',
            '32661',
            'Pago histórico recibo N° 32661',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_98_6, 'monto_aplicado', 711.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_98_7, 'monto_aplicado', 30.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_98_8, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_98,
            v_socio_98,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_98_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_98_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_98,
            v_socio_98,
            NULL,
            742.00,
            'Efectivo',
            '32882',
            'Pago histórico recibo N° 32882',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_98_11, 'monto_aplicado', 708.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_98_12, 'monto_aplicado', 33.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_98,
            v_socio_98,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_98_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_98_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_98,
            v_socio_98,
            NULL,
            742.60,
            'Efectivo',
            '32982',
            'Pago histórico recibo N° 32982',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_98_15, 'monto_aplicado', 708.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_98_16, 'monto_aplicado', 34.40, 'cubierto_completo', true)),
            0.00,
            '2026-04-29 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_98,
            v_socio_98,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_98_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_98_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: MESIA CRUZ GLADYS (Puesto: 106, ID: 99)
    -- =========================================================================
    DECLARE
        v_socio_99 bigint := 99;
        v_puesto_99 bigint := 201;
        v_m_id_99_0 bigint;
        v_m_id_99_1 bigint;
        v_m_id_99_2 bigint;
        v_m_id_99_3 bigint;
        v_m_id_99_4 bigint;
        v_m_id_99_5 bigint;
        v_m_id_99_6 bigint;
        v_m_id_99_7 bigint;
        v_m_id_99_8 bigint;
        v_m_id_99_9 bigint;
        v_m_id_99_10 bigint;
        v_m_id_99_11 bigint;
        v_m_id_99_12 bigint;
        v_m_id_99_13 bigint;
        v_m_id_99_14 bigint;
        v_m_id_99_15 bigint;
        v_m_id_99_16 bigint;
        v_m_id_99_17 bigint;
        v_m_id_99_18 bigint;
        v_m_id_99_19 bigint;
        v_m_id_99_20 bigint;
        v_m_id_99_21 bigint;
        v_m_id_99_22 bigint;
        v_m_id_99_23 bigint;
        v_m_id_99_24 bigint;
        v_m_id_99_25 bigint;
        v_m_id_99_26 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_99 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_99 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_99;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_99 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_99;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 18, 2026, 8, 15.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - TALONARIO SANTA ROSA', v_user_uuid)
        RETURNING id INTO v_m_id_99_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 1, 2025, 11, 98.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_99_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 2, 2025, 11, 10.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_99_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 16, 2025, 11, 200.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_99_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 1, 2025, 12, 94.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_99_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_99_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 16, 2025, 12, 200.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_99_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_99_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_99_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 1, 2026, 1, 99.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_99_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_99_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 16, 2026, 1, 200.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_99_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_99_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_99_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 1, 2026, 2, 102.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_99_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_99_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 16, 2026, 2, 200.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_99_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_99_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_99_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_99_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_99_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 16, 2026, 3, 200.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_99_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 1, 2026, 3, 104.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_99_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_99_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 16, 2026, 4, 200.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_99_24;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_99_25;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_99, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_99_26;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_99,
            v_socio_99,
            NULL,
            15.00,
            'Efectivo',
            '32370',
            'Pago histórico recibo N° 32370',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_99_0, 'monto_aplicado', 15.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_99,
            v_socio_99,
            NULL,
            208.70,
            'Efectivo',
            '32368',
            'Pago histórico recibo N° 32368',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_99_1, 'monto_aplicado', 98.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_99_2, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_99_4, 'monto_aplicado', 94.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_99_5, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_99,
            v_socio_99,
            NULL,
            400.00,
            'Efectivo',
            '32369',
            'Pago histórico recibo N° 32369',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_99_3, 'monto_aplicado', 200.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_99_6, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_99,
            v_socio_99,
            NULL,
            65.00,
            'Efectivo',
            '32371',
            'Pago histórico recibo N° 32371',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_99_7, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_99_8, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_99,
            v_socio_99,
            NULL,
            217.20,
            'Efectivo',
            '32830',
            'Pago histórico recibo N° 32830',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_99_9, 'monto_aplicado', 99.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_99_10, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_99_14, 'monto_aplicado', 102.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_99_15, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_99,
            v_socio_99,
            NULL,
            400.00,
            'Efectivo',
            '32831',
            'Pago histórico recibo N° 32831',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_99_11, 'monto_aplicado', 200.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_99_16, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_99,
            v_socio_99,
            NULL,
            191.00,
            'Efectivo',
            '32832',
            'Pago histórico recibo N° 32832',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_99_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_99_13, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_99_17, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_99_18, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_99_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_99_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_99,
            v_socio_99,
            NULL,
            100.00,
            'Efectivo',
            '32834',
            'Pago histórico recibo N° 32834',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_99_21, 'monto_aplicado', 100.00, 'cubierto_completo', false)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_99,
            v_socio_99,
            NULL,
            110.70,
            'Efectivo',
            '33034',
            'Pago histórico recibo N° 33034',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_99_22, 'monto_aplicado', 104.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_99_23, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_99,
            v_socio_99,
            NULL,
            300.00,
            'Efectivo',
            '33035',
            'Pago histórico recibo N° 33035',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_99_21, 'monto_aplicado', 100.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_99_24, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_99,
            v_socio_99,
            NULL,
            65.00,
            'Efectivo',
            '33036',
            'Pago histórico recibo N° 33036',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_99_25, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_99_26, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: NICHO LOPEZ ESTHEPANY CARICIA (Puesto: 144, ID: 101)
    -- =========================================================================
    DECLARE
        v_socio_101 bigint := 101;
        v_puesto_101 bigint := 239;
        v_m_id_101_0 bigint;
        v_m_id_101_1 bigint;
        v_m_id_101_2 bigint;
        v_m_id_101_3 bigint;
        v_m_id_101_4 bigint;
        v_m_id_101_5 bigint;
        v_m_id_101_6 bigint;
        v_m_id_101_7 bigint;
        v_m_id_101_8 bigint;
        v_m_id_101_9 bigint;
        v_m_id_101_10 bigint;
        v_m_id_101_11 bigint;
        v_m_id_101_12 bigint;
        v_m_id_101_13 bigint;
        v_m_id_101_14 bigint;
        v_m_id_101_15 bigint;
        v_m_id_101_16 bigint;
        v_m_id_101_17 bigint;
        v_m_id_101_18 bigint;
        v_m_id_101_19 bigint;
        v_m_id_101_20 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_101 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_101 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_101;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_101 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_101;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 1, 2025, 11, 404.40, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_101_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 2, 2025, 11, 92.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_101_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_101_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_101_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 1, 2025, 12, 391.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_101_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 2, 2025, 12, 78.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_101_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_101_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_101_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 1, 2026, 1, 443.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_101_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 2, 2026, 1, 114.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_101_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_101_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_101_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_101_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 1, 2026, 2, 503.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_101_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 2, 2026, 2, 121.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_101_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_101_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_101_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 1, 2026, 3, 464.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_101_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 2, 2026, 3, 127.90, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_101_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_101_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_101, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_101_20;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_101,
            v_socio_101,
            NULL,
            562.00,
            'Efectivo',
            '32291',
            'Pago histórico recibo N° 32291',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_101_0, 'monto_aplicado', 404.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_101_1, 'monto_aplicado', 92.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_101_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_101_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_101,
            v_socio_101,
            NULL,
            535.00,
            'Efectivo',
            '32447',
            'Pago histórico recibo N° 32447',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_101_4, 'monto_aplicado', 391.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_101_5, 'monto_aplicado', 78.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_101_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_101_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-02 12:00:00-05', created_at = '2026-02-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-02 12:00:00-05', created_at = '2026-02-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_101,
            v_socio_101,
            NULL,
            632.90,
            'Efectivo',
            '32658',
            'Pago histórico recibo N° 32658',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_101_8, 'monto_aplicado', 443.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_101_9, 'monto_aplicado', 114.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_101_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_101_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_101_12, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_101,
            v_socio_101,
            NULL,
            686.30,
            'Efectivo',
            '32912',
            'Pago histórico recibo N° 32912',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_101_13, 'monto_aplicado', 503.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_101_14, 'monto_aplicado', 121.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_101_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_101_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_101,
            v_socio_101,
            NULL,
            657.40,
            'Efectivo',
            '33088',
            'Pago histórico recibo N° 33088',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_101_17, 'monto_aplicado', 464.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_101_18, 'monto_aplicado', 127.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_101_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_101_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-19 12:00:00-05', created_at = '2026-05-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-19 12:00:00-05', created_at = '2026-05-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: NAHUI RUIZ AURELIO (Puesto: 61, ID: 102)
    -- =========================================================================
    DECLARE
        v_socio_102 bigint := 102;
        v_puesto_102 bigint := 156;
        v_m_id_102_0 bigint;
        v_m_id_102_1 bigint;
        v_m_id_102_2 bigint;
        v_m_id_102_3 bigint;
        v_m_id_102_4 bigint;
        v_m_id_102_5 bigint;
        v_m_id_102_6 bigint;
        v_m_id_102_7 bigint;
        v_m_id_102_8 bigint;
        v_m_id_102_9 bigint;
        v_m_id_102_10 bigint;
        v_m_id_102_11 bigint;
        v_m_id_102_12 bigint;
        v_m_id_102_13 bigint;
        v_m_id_102_14 bigint;
        v_m_id_102_15 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_102 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_102 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_102;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_102 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_102;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_102, 1, 2025, 12, 44.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_102_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_102, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_102_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_102, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_102_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_102, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_102_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_102, 1, 2026, 1, 43.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_102_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_102, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_102_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_102, 1, 2026, 2, 42.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_102_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_102, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_102_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_102, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_102_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_102, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_102_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_102, 1, 2026, 3, 44.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_102_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_102, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_102_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_102, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_102_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_102, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_102_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_102, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_102_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_102, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_102_15;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_102,
            v_socio_102,
            NULL,
            50.40,
            'Efectivo',
            '32351',
            'Pago histórico recibo N° 32351',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_102_0, 'monto_aplicado', 44.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_102_1, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_102,
            v_socio_102,
            NULL,
            65.00,
            'Efectivo',
            '32442',
            'Pago histórico recibo N° 32442',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_102_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_102_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-30 12:00:00-05', created_at = '2026-01-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-30 12:00:00-05', created_at = '2026-01-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_102,
            v_socio_102,
            NULL,
            161.80,
            'Efectivo',
            '32814',
            'Pago histórico recibo N° 32814',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_102_4, 'monto_aplicado', 43.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_102_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_102_6, 'monto_aplicado', 42.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_102_7, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_102_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_102_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_102,
            v_socio_102,
            NULL,
            115.40,
            'Efectivo',
            '33057',
            'Pago histórico recibo N° 33057',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_102_10, 'monto_aplicado', 44.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_102_11, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_102_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_102_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-12 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-12 12:00:00-05', created_at = '2026-05-12 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-12 12:00:00-05', created_at = '2026-05-12 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_102,
            v_socio_102,
            NULL,
            65.00,
            'Efectivo',
            '33057',
            'Pago histórico recibo N° 33057',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_102_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_102_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: OJEDA CAMPOS EDSON JUNIOR (Puesto: 133, ID: 103)
    -- =========================================================================
    DECLARE
        v_socio_103 bigint := 103;
        v_puesto_103 bigint := 228;
        v_m_id_103_0 bigint;
        v_m_id_103_1 bigint;
        v_m_id_103_2 bigint;
        v_m_id_103_3 bigint;
        v_m_id_103_4 bigint;
        v_m_id_103_5 bigint;
        v_m_id_103_6 bigint;
        v_m_id_103_7 bigint;
        v_m_id_103_8 bigint;
        v_m_id_103_9 bigint;
        v_m_id_103_10 bigint;
        v_m_id_103_11 bigint;
        v_m_id_103_12 bigint;
        v_m_id_103_13 bigint;
        v_m_id_103_14 bigint;
        v_m_id_103_15 bigint;
        v_m_id_103_16 bigint;
        v_m_id_103_17 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_103 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_103 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_103;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_103 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_103;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 1, 2025, 11, 509.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_103_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 2, 2025, 11, 21.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_103_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 1, 2025, 12, 510.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_103_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 2, 2025, 12, 23.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_103_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_103_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_103_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 1, 2026, 1, 604.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_103_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 2, 2026, 1, 29.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_103_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_103_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_103_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 1, 2026, 2, 661.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_103_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 2, 2026, 2, 30.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_103_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_103_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_103_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 1, 2026, 3, 640.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_103_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 2, 2026, 3, 33.60, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_103_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_103_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_103, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_103_17;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_103,
            v_socio_103,
            NULL,
            530.60,
            'Efectivo',
            '32280',
            'Pago histórico recibo N° 32280',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_103_0, 'monto_aplicado', 509.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_103_1, 'monto_aplicado', 21.30, 'cubierto_completo', true)),
            0.00,
            '2026-01-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_103,
            v_socio_103,
            NULL,
            533.90,
            'Efectivo',
            '32399',
            'Pago histórico recibo N° 32399',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_103_2, 'monto_aplicado', 510.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_103_3, 'monto_aplicado', 23.20, 'cubierto_completo', true)),
            0.00,
            '2026-01-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_103,
            v_socio_103,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_103_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_103_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_103,
            v_socio_103,
            NULL,
            633.80,
            'Efectivo',
            '32615',
            'Pago histórico recibo N° 32615',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_103_6, 'monto_aplicado', 604.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_103_7, 'monto_aplicado', 29.60, 'cubierto_completo', true)),
            0.00,
            '2026-03-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_103,
            v_socio_103,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_103_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_103_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_103,
            v_socio_103,
            NULL,
            692.70,
            'Efectivo',
            '32894',
            'Pago histórico recibo N° 32894',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_103_10, 'monto_aplicado', 661.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_103_11, 'monto_aplicado', 30.90, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_103,
            v_socio_103,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_103_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_103_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_103,
            v_socio_103,
            NULL,
            673.90,
            'Efectivo',
            '32995',
            'Pago histórico recibo N° 32995',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_103_14, 'monto_aplicado', 640.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_103_15, 'monto_aplicado', 33.60, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_103,
            v_socio_103,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_103_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_103_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: OQUENDO ARISACA MELESIA ROSARIO (Puesto: 119, ID: 104)
    -- =========================================================================
    DECLARE
        v_socio_104 bigint := 104;
        v_puesto_104 bigint := 214;
        v_m_id_104_0 bigint;
        v_m_id_104_1 bigint;
        v_m_id_104_2 bigint;
        v_m_id_104_3 bigint;
        v_m_id_104_4 bigint;
        v_m_id_104_5 bigint;
        v_m_id_104_6 bigint;
        v_m_id_104_7 bigint;
        v_m_id_104_8 bigint;
        v_m_id_104_9 bigint;
        v_m_id_104_10 bigint;
        v_m_id_104_11 bigint;
        v_m_id_104_12 bigint;
        v_m_id_104_13 bigint;
        v_m_id_104_14 bigint;
        v_m_id_104_15 bigint;
        v_m_id_104_16 bigint;
        v_m_id_104_17 bigint;
        v_m_id_104_18 bigint;
        v_m_id_104_19 bigint;
        v_m_id_104_20 bigint;
        v_m_id_104_21 bigint;
        v_m_id_104_22 bigint;
        v_m_id_104_23 bigint;
        v_m_id_104_24 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_104 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_104 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_104;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_104 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_104;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 1, 2025, 11, 75.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_104_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_104_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_104_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_104_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 1, 2025, 12, 76.30, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_104_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_104_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_104_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_104_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 1, 2026, 1, 53.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_104_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_104_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_104_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_104_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_104_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 1, 2026, 2, 41.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_104_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_104_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_104_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_104_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 1, 2026, 3, 42.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_104_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_104_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_104_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_104_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 1, 2026, 4, 33.10, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_104_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_104_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_104_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_104, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_104_24;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_104,
            v_socio_104,
            NULL,
            293.60,
            'Efectivo',
            '32348',
            'Pago histórico recibo N° 32348',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_104_0, 'monto_aplicado', 75.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_4, 'monto_aplicado', 76.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-15 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_104,
            v_socio_104,
            NULL,
            133.90,
            'Efectivo',
            '32617',
            'Pago histórico recibo N° 32617',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_104_8, 'monto_aplicado', 53.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_12, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_104,
            v_socio_104,
            NULL,
            112.40,
            'Efectivo',
            '32762',
            'Pago histórico recibo N° 32762',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_104_13, 'monto_aplicado', 41.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_14, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_104,
            v_socio_104,
            NULL,
            113.10,
            'Efectivo',
            '33041',
            'Pago histórico recibo N° 33041',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_104_17, 'monto_aplicado', 42.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_18, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_104,
            v_socio_104,
            NULL,
            104.10,
            'Efectivo',
            '33124',
            'Pago histórico recibo N° 33124',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_104_21, 'monto_aplicado', 33.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_22, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_23, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_104_24, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: OQUENDO QUISPE JESSICA (Puesto: 172, ID: 105)
    -- =========================================================================
    DECLARE
        v_socio_105 bigint := 105;
        v_puesto_105 bigint := 267;
        v_m_id_105_0 bigint;
        v_m_id_105_1 bigint;
        v_m_id_105_2 bigint;
        v_m_id_105_3 bigint;
        v_m_id_105_4 bigint;
        v_m_id_105_5 bigint;
        v_m_id_105_6 bigint;
        v_m_id_105_7 bigint;
        v_m_id_105_8 bigint;
        v_m_id_105_9 bigint;
        v_m_id_105_10 bigint;
        v_m_id_105_11 bigint;
        v_m_id_105_12 bigint;
        v_m_id_105_13 bigint;
        v_m_id_105_14 bigint;
        v_m_id_105_15 bigint;
        v_m_id_105_16 bigint;
        v_m_id_105_17 bigint;
        v_m_id_105_18 bigint;
        v_m_id_105_19 bigint;
        v_m_id_105_20 bigint;
        v_m_id_105_21 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_105 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_105 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_105;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_105 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_105;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 1, 2025, 11, 77.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_105_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 2, 2025, 11, 203.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_105_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 1, 2025, 12, 76.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_105_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 2, 2025, 12, 191.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_105_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 3, 2025, 12, 8.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_105_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_105_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_105_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_105_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_105_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 1, 2026, 1, 81.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_105_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 2, 2026, 1, 215.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_105_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_105_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_105_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_105_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 1, 2026, 2, 70.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_105_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 2, 2026, 2, 242.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_105_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_105_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_105_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 1, 2026, 3, 67.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_105_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 2, 2026, 3, 250.60, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_105_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_105_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_105, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_105_21;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_105,
            v_socio_105,
            NULL,
            572.00,
            'Efectivo',
            '32503',
            'Pago histórico recibo N° 32503',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_105_0, 'monto_aplicado', 77.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_105_1, 'monto_aplicado', 203.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_105_2, 'monto_aplicado', 76.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_105_3, 'monto_aplicado', 191.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_105_4, 'monto_aplicado', 8.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_105_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_105_8, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_105,
            v_socio_105,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_105_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_105_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_105,
            v_socio_105,
            NULL,
            568.10,
            'Efectivo',
            '32840',
            'Pago histórico recibo N° 32840',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_105_9, 'monto_aplicado', 81.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_105_10, 'monto_aplicado', 215.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_105_11, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_105_15, 'monto_aplicado', 242.20, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_105,
            v_socio_105,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_105_12, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_105_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_105,
            v_socio_105,
            NULL,
            70.50,
            'Efectivo',
            '328840',
            'Pago histórico recibo N° 328840',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_105_14, 'monto_aplicado', 70.50, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_105,
            v_socio_105,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_105_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_105_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_105,
            v_socio_105,
            NULL,
            317.70,
            'Efectivo',
            '33139',
            'Pago histórico recibo N° 33139',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_105_18, 'monto_aplicado', 67.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_105_19, 'monto_aplicado', 250.60, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_105,
            v_socio_105,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_105_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_105_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: OQUENDO QUISPE MIGUEL EUFRACIO (Puesto: 146, ID: 106)
    -- =========================================================================
    DECLARE
        v_socio_106 bigint := 106;
        v_puesto_106 bigint := 241;
        v_m_id_106_0 bigint;
        v_m_id_106_1 bigint;
        v_m_id_106_2 bigint;
        v_m_id_106_3 bigint;
        v_m_id_106_4 bigint;
        v_m_id_106_5 bigint;
        v_m_id_106_6 bigint;
        v_m_id_106_7 bigint;
        v_m_id_106_8 bigint;
        v_m_id_106_9 bigint;
        v_m_id_106_10 bigint;
        v_m_id_106_11 bigint;
        v_m_id_106_12 bigint;
        v_m_id_106_13 bigint;
        v_m_id_106_14 bigint;
        v_m_id_106_15 bigint;
        v_m_id_106_16 bigint;
        v_m_id_106_17 bigint;
        v_m_id_106_18 bigint;
        v_m_id_106_19 bigint;
        v_m_id_106_20 bigint;
        v_m_id_106_21 bigint;
        v_m_id_106_22 bigint;
        v_m_id_106_23 bigint;
        v_m_id_106_24 bigint;
        v_m_id_106_25 bigint;
        v_m_id_106_26 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_106 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_106 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_106;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_106 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_106;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 18, 2026, 8, 15.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - TALONARIO SANTA ROSA', v_user_uuid)
        RETURNING id INTO v_m_id_106_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 1, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_106_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_106_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_106_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_106_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 1, 2025, 12, 161.30, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_106_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_106_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_106_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_106_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_106_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_106_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 1, 2026, 1, 666.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_106_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_106_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_106_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_106_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_106_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 1, 2026, 2, 785.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_106_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_106_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_106_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_106_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 1, 2026, 3, 719.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_106_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_106_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 6, 2026, 3, 56.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - MULTA 26/03/2026', v_user_uuid)
        RETURNING id INTO v_m_id_106_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_106_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_106_24;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 1, 2026, 4, 761.30, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_106_25;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_106, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_106_26;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_106,
            v_socio_106,
            NULL,
            733.60,
            'Efectivo',
            '32801',
            'Pago histórico recibo N° 32801',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_106_0, 'monto_aplicado', 15.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_16, 'monto_aplicado', 708.60, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_106_17, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_106,
            v_socio_106,
            NULL,
            900.00,
            'Efectivo',
            '32556',
            'Pago histórico recibo N° 32556',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_106_1, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_2, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_3, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_4, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_5, 'monto_aplicado', 86.30, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_106_6, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_7, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_8, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_11, 'monto_aplicado', 666.70, 'cubierto_completo', true)),
            0.00,
            '2026-02-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_106,
            v_socio_106,
            NULL,
            140.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_106_5, 'monto_aplicado', 75.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_9, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_106,
            v_socio_106,
            NULL,
            153.10,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_106_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_13, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_14, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_15, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_16, 'monto_aplicado', 77.10, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_106,
            v_socio_106,
            NULL,
            230.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_106_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_19, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_20, 'monto_aplicado', 165.00, 'cubierto_completo', false)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_106,
            v_socio_106,
            NULL,
            554.70,
            'Efectivo',
            '32973',
            'Pago histórico recibo N° 32973',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_106_20, 'monto_aplicado', 554.70, 'cubierto_completo', true)),
            0.00,
            '2026-04-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_106,
            v_socio_106,
            NULL,
            6.00,
            'Efectivo',
            '32978',
            'Pago histórico recibo N° 32978',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_106_21, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_106,
            v_socio_106,
            NULL,
            788.80,
            'Efectivo',
            '33142',
            'Pago histórico recibo N° 33142',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_106_22, 'monto_aplicado', 56.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_25, 'monto_aplicado', 726.30, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_106_26, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_106,
            v_socio_106,
            NULL,
            100.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_106_23, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_24, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_106_25, 'monto_aplicado', 35.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ORTIZ NAUPA WELINTONH (Puesto: 185, ID: 108)
    -- =========================================================================
    DECLARE
        v_socio_108 bigint := 108;
        v_puesto_108 bigint := 279;
        v_m_id_108_0 bigint;
        v_m_id_108_1 bigint;
        v_m_id_108_2 bigint;
        v_m_id_108_3 bigint;
        v_m_id_108_4 bigint;
        v_m_id_108_5 bigint;
        v_m_id_108_6 bigint;
        v_m_id_108_7 bigint;
        v_m_id_108_8 bigint;
        v_m_id_108_9 bigint;
        v_m_id_108_10 bigint;
        v_m_id_108_11 bigint;
        v_m_id_108_12 bigint;
        v_m_id_108_13 bigint;
        v_m_id_108_14 bigint;
        v_m_id_108_15 bigint;
        v_m_id_108_16 bigint;
        v_m_id_108_17 bigint;
        v_m_id_108_18 bigint;
        v_m_id_108_19 bigint;
        v_m_id_108_20 bigint;
        v_m_id_108_21 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_108 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_108 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_108;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_108 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_108;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 1, 2025, 11, 133.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_108_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 2, 2025, 11, 8.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_108_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 6, 2025, 11, 113.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - MULTA 27/11/25', v_user_uuid)
        RETURNING id INTO v_m_id_108_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 1, 2025, 12, 147.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_108_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 2, 2025, 12, 7.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_108_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_108_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_108_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 1, 2026, 1, 159.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_108_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 2, 2026, 1, 14.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_108_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_108_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_108_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_108_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_108_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 1, 2026, 2, 172.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_108_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 2, 2026, 2, 13.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_108_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_108_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_108_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 6, 2026, 3, 113.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - MULTA 26/03/26', v_user_uuid)
        RETURNING id INTO v_m_id_108_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 1, 2026, 3, 140.60, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_108_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 2, 2026, 3, 14.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_108_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_108_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_108, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_108_21;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_108,
            v_socio_108,
            NULL,
            296.70,
            'Efectivo',
            '32381',
            'Pago histórico recibo N° 32381',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_108_0, 'monto_aplicado', 133.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_108_1, 'monto_aplicado', 8.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_108_3, 'monto_aplicado', 147.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_108_4, 'monto_aplicado', 7.90, 'cubierto_completo', true)),
            0.00,
            '2026-01-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_108,
            v_socio_108,
            NULL,
            411.90,
            'Efectivo',
            '32947',
            'Pago histórico recibo N° 32947',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_108_2, 'monto_aplicado', 113.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_108_13, 'monto_aplicado', 172.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_108_14, 'monto_aplicado', 13.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_108_17, 'monto_aplicado', 113.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-17 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-17 12:00:00-05', created_at = '2026-04-17 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-17 12:00:00-05', created_at = '2026-04-17 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_108,
            v_socio_108,
            NULL,
            75.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_108_5, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_108_6, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_108_7, 'monto_aplicado', 10.00, 'cubierto_completo', false)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_108,
            v_socio_108,
            NULL,
            202.10,
            'Efectivo',
            '32621',
            'Pago histórico recibo N° 32621',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_108_7, 'monto_aplicado', 149.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_108_8, 'monto_aplicado', 14.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_108_9, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_108_10, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_108,
            v_socio_108,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_108_11, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_108_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_108,
            v_socio_108,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_108_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_108_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_108,
            v_socio_108,
            NULL,
            154.80,
            'Efectivo',
            '33070',
            'Pago histórico recibo N° 33070',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_108_18, 'monto_aplicado', 140.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_108_19, 'monto_aplicado', 14.20, 'cubierto_completo', true)),
            0.00,
            '2026-05-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_108,
            v_socio_108,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_108_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_108_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: PACOMPIA CARDENA GIOVANNI (Puesto: 29, ID: 109)
    -- =========================================================================
    DECLARE
        v_socio_109 bigint := 109;
        v_puesto_109 bigint := 94;
        v_m_id_109_0 bigint;
        v_m_id_109_1 bigint;
        v_m_id_109_2 bigint;
        v_m_id_109_3 bigint;
        v_m_id_109_4 bigint;
        v_m_id_109_5 bigint;
        v_m_id_109_6 bigint;
        v_m_id_109_7 bigint;
        v_m_id_109_8 bigint;
        v_m_id_109_9 bigint;
        v_m_id_109_10 bigint;
        v_m_id_109_11 bigint;
        v_m_id_109_12 bigint;
        v_m_id_109_13 bigint;
        v_m_id_109_14 bigint;
        v_m_id_109_15 bigint;
        v_m_id_109_16 bigint;
        v_m_id_109_17 bigint;
        v_m_id_109_18 bigint;
        v_m_id_109_19 bigint;
        v_m_id_109_20 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_109 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_109 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_109;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_109 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_109;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_109_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_109_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 1, 2025, 12, 23.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_109_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_109_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_109_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_109_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_109_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 1, 2026, 1, 23.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_109_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_109_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_109_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_109_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 1, 2026, 2, 22.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_109_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_109_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_109_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_109_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 1, 2026, 3, 24.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_109_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_109_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_109_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_109_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 1, 2026, 4, 22.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_109_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_109, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_109_20;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_109,
            v_socio_109,
            NULL,
            65.00,
            'Efectivo',
            '32289',
            'Pago histórico recibo N° 32289',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_109_0, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_109_1, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-06 12:00:00-05', created_at = '2026-01-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-06 12:00:00-05', created_at = '2026-01-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_109,
            v_socio_109,
            NULL,
            58.10,
            'Efectivo',
            '32592',
            'Pago histórico recibo N° 32592',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_109_2, 'monto_aplicado', 23.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_109_3, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_109_7, 'monto_aplicado', 23.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_109_8, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_109,
            v_socio_109,
            NULL,
            75.00,
            'Efectivo',
            '32466',
            'Pago histórico recibo N° 32466',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_109_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_109_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_109_6, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_109,
            v_socio_109,
            NULL,
            61.00,
            'Efectivo',
            '32595',
            'Pago histórico recibo N° 32595',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_109_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_109_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_109,
            v_socio_109,
            NULL,
            32.90,
            'Efectivo',
            '32732',
            'Pago histórico recibo N° 32732',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_109_11, 'monto_aplicado', 22.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_109_12, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_109,
            v_socio_109,
            NULL,
            65.00,
            'Efectivo',
            '32870',
            'Pago histórico recibo N° 32870',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_109_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_109_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_109,
            v_socio_109,
            NULL,
            58.20,
            'Efectivo',
            '33121',
            'Pago histórico recibo N° 33121',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_109_15, 'monto_aplicado', 24.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_109_16, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_109_19, 'monto_aplicado', 22.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_109_20, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-26 12:00:00-05', created_at = '2026-05-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-26 12:00:00-05', created_at = '2026-05-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_109,
            v_socio_109,
            NULL,
            65.00,
            'Efectivo',
            '33030',
            'Pago histórico recibo N° 33030',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_109_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_109_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: PALOMINO HANCCO CECILIA (Puesto: 164, ID: 110)
    -- =========================================================================
    DECLARE
        v_socio_110 bigint := 110;
        v_puesto_110 bigint := 259;
        v_m_id_110_0 bigint;
        v_m_id_110_1 bigint;
        v_m_id_110_2 bigint;
        v_m_id_110_3 bigint;
        v_m_id_110_4 bigint;
        v_m_id_110_5 bigint;
        v_m_id_110_6 bigint;
        v_m_id_110_7 bigint;
        v_m_id_110_8 bigint;
        v_m_id_110_9 bigint;
        v_m_id_110_10 bigint;
        v_m_id_110_11 bigint;
        v_m_id_110_12 bigint;
        v_m_id_110_13 bigint;
        v_m_id_110_14 bigint;
        v_m_id_110_15 bigint;
        v_m_id_110_16 bigint;
        v_m_id_110_17 bigint;
        v_m_id_110_18 bigint;
        v_m_id_110_19 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_110 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_110 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_110;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_110 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_110;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 18, 2026, 8, 15.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - TALONARIO SANTA ROSA', v_user_uuid)
        RETURNING id INTO v_m_id_110_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 1, 2025, 11, 288.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_110_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 2, 2025, 11, 70.20, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_110_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 1, 2025, 12, 308.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_110_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 2, 2025, 12, 68.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_110_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_110_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_110_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 1, 2026, 1, 285.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_110_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 2, 2026, 1, 86.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_110_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_110_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_110_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_110_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 1, 2026, 2, 272.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_110_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 2, 2026, 2, 79.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_110_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_110_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_110_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 1, 2026, 3, 278.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_110_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 2, 2026, 3, 82.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_110_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_110_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_110, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_110_19;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_110,
            v_socio_110,
            NULL,
            392.10,
            'Efectivo',
            '32452',
            'Pago histórico recibo N° 32452',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_110_0, 'monto_aplicado', 15.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_110_3, 'monto_aplicado', 308.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_110_4, 'monto_aplicado', 68.70, 'cubierto_completo', true)),
            0.00,
            '2026-02-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_110,
            v_socio_110,
            NULL,
            359.10,
            'Efectivo',
            '32378',
            'Pago histórico recibo N° 32378',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_110_1, 'monto_aplicado', 288.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_110_2, 'monto_aplicado', 70.20, 'cubierto_completo', true)),
            0.00,
            '2026-01-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_110,
            v_socio_110,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_110_5, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_110_6, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_110,
            v_socio_110,
            NULL,
            751.60,
            'Efectivo',
            '32850',
            'Pago histórico recibo N° 32850',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_110_7, 'monto_aplicado', 285.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_110_8, 'monto_aplicado', 86.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_110_9, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_110_12, 'monto_aplicado', 272.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_110_13, 'monto_aplicado', 79.10, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_110,
            v_socio_110,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_110_10, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_110_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_110,
            v_socio_110,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_110_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_110_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_110,
            v_socio_110,
            NULL,
            360.30,
            'Efectivo',
            '33118',
            'Pago histórico recibo N° 33118',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_110_16, 'monto_aplicado', 278.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_110_17, 'monto_aplicado', 82.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-26 12:00:00-05', created_at = '2026-05-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-26 12:00:00-05', created_at = '2026-05-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_110,
            v_socio_110,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_110_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_110_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: PALOMINO TENORIO SILVIO EDUARDO (Puesto: 195, ID: 111)
    -- =========================================================================
    DECLARE
        v_socio_111 bigint := 111;
        v_puesto_111 bigint := 288;
        v_m_id_111_0 bigint;
        v_m_id_111_1 bigint;
        v_m_id_111_2 bigint;
        v_m_id_111_3 bigint;
        v_m_id_111_4 bigint;
        v_m_id_111_5 bigint;
        v_m_id_111_6 bigint;
        v_m_id_111_7 bigint;
        v_m_id_111_8 bigint;
        v_m_id_111_9 bigint;
        v_m_id_111_10 bigint;
        v_m_id_111_11 bigint;
        v_m_id_111_12 bigint;
        v_m_id_111_13 bigint;
        v_m_id_111_14 bigint;
        v_m_id_111_15 bigint;
        v_m_id_111_16 bigint;
        v_m_id_111_17 bigint;
        v_m_id_111_18 bigint;
        v_m_id_111_19 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_111 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_111 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_111;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_111 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_111;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 1, 2025, 12, 9.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_111_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_111_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_111_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 1, 2026, 1, 27.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_111_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 16, 2026, 1, 180.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - DEPOSITO N° 4', v_user_uuid)
        RETURNING id INTO v_m_id_111_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_111_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_111_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_111_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_111_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_111_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 16, 2026, 2, 200.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO N° 4', v_user_uuid)
        RETURNING id INTO v_m_id_111_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 1, 2026, 2, 28.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_111_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_111_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 3, 2026, 3, 26.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_111_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 1, 2026, 3, 27.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_111_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 16, 2026, 3, 91.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - DEPOSITO N° 4', v_user_uuid)
        RETURNING id INTO v_m_id_111_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_111_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 3, 2026, 4, 48.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_111_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 1, 2026, 4, 3.80, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_111_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_111, 16, 2026, 4, 168.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - DEPOSITO N° 4', v_user_uuid)
        RETURNING id INTO v_m_id_111_19;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_111,
            v_socio_111,
            NULL,
            285.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_111_0, 'monto_aplicado', 9.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_111_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_111_3, 'monto_aplicado', 11.10, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_111_5, 'monto_aplicado', 1.70, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_111_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_111_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_111_10, 'monto_aplicado', 196.00, 'cubierto_completo', false)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_111,
            v_socio_111,
            NULL,
            160.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_111_2, 'monto_aplicado', 32.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_111_3, 'monto_aplicado', 16.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_111_4, 'monto_aplicado', 112.00, 'cubierto_completo', false)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_111,
            v_socio_111,
            NULL,
            175.30,
            'Efectivo',
            '32820',
            'Pago histórico recibo N° 32820',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_111_5, 'monto_aplicado', 3.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_111_2, 'monto_aplicado', 28.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_111_6, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_111_4, 'monto_aplicado', 68.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_111_7, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_111_11, 'monto_aplicado', 28.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_111_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_111_10, 'monto_aplicado', 4.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_111,
            v_socio_111,
            NULL,
            130.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_111_13, 'monto_aplicado', 26.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_111_14, 'monto_aplicado', 13.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_111_15, 'monto_aplicado', 91.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_111,
            v_socio_111,
            NULL,
            240.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_111_14, 'monto_aplicado', 14.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_111_16, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_111_17, 'monto_aplicado', 48.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_111_18, 'monto_aplicado', 3.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_111_19, 'monto_aplicado', 168.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: PALOMINO VELASQUEZ EUSEBIO (Puesto: 147, ID: 112)
    -- =========================================================================
    DECLARE
        v_socio_112 bigint := 112;
        v_puesto_112 bigint := 242;
        v_m_id_112_0 bigint;
        v_m_id_112_1 bigint;
        v_m_id_112_2 bigint;
        v_m_id_112_3 bigint;
        v_m_id_112_4 bigint;
        v_m_id_112_5 bigint;
        v_m_id_112_6 bigint;
        v_m_id_112_7 bigint;
        v_m_id_112_8 bigint;
        v_m_id_112_9 bigint;
        v_m_id_112_10 bigint;
        v_m_id_112_11 bigint;
        v_m_id_112_12 bigint;
        v_m_id_112_13 bigint;
        v_m_id_112_14 bigint;
        v_m_id_112_15 bigint;
        v_m_id_112_16 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_112 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_112 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_112;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_112 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_112;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_112, 1, 2025, 12, 511.10, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_112_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_112, 2, 2025, 12, 35.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_112_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_112, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_112_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_112, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_112_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_112, 1, 2026, 1, 631.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_112_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_112, 2, 2026, 1, 36.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_112_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_112, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_112_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_112, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_112_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_112, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_112_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_112, 1, 2026, 2, 666.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_112_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_112, 2, 2026, 2, 39.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_112_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_112, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_112_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_112, 1, 2026, 3, 615.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_112_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_112, 2, 2026, 3, 40.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_112_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_112, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_112_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_112, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_112_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_112, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_112_16;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_112,
            v_socio_112,
            NULL,
            547.00,
            'Efectivo',
            '32379',
            'Pago histórico recibo N° 32379',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_112_0, 'monto_aplicado', 511.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_112_1, 'monto_aplicado', 35.90, 'cubierto_completo', true)),
            0.00,
            '2026-01-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_112,
            v_socio_112,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_112_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_112_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_112,
            v_socio_112,
            NULL,
            78.00,
            'Efectivo',
            '32552',
            'Pago histórico recibo N° 32552',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_112_4, 'monto_aplicado', 31.40, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_112_5, 'monto_aplicado', 36.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_112_6, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_112,
            v_socio_112,
            NULL,
            600.00,
            'Efectivo',
            '32553',
            'Pago histórico recibo N° 32553',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_112_4, 'monto_aplicado', 600.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_112,
            v_socio_112,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_112_7, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_112_8, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_112,
            v_socio_112,
            NULL,
            706.30,
            'Efectivo',
            '32757',
            'Pago histórico recibo N° 32757',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_112_9, 'monto_aplicado', 666.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_112_10, 'monto_aplicado', 39.50, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_112,
            v_socio_112,
            NULL,
            40.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_112_11, 'monto_aplicado', 40.00, 'cubierto_completo', false)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_112,
            v_socio_112,
            NULL,
            680.70,
            'Efectivo',
            '32970',
            'Pago histórico recibo N° 32970',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_112_12, 'monto_aplicado', 615.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_112_13, 'monto_aplicado', 40.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_112_11, 'monto_aplicado', 20.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_112_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_112,
            v_socio_112,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_112_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_112_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: PAREDES FLORES OSCAR ALFREDO (Puesto: 53, ID: 113)
    -- =========================================================================
    DECLARE
        v_socio_113 bigint := 113;
        v_puesto_113 bigint := 140;
        v_m_id_113_0 bigint;
        v_m_id_113_1 bigint;
        v_m_id_113_2 bigint;
        v_m_id_113_3 bigint;
        v_m_id_113_4 bigint;
        v_m_id_113_5 bigint;
        v_m_id_113_6 bigint;
        v_m_id_113_7 bigint;
        v_m_id_113_8 bigint;
        v_m_id_113_9 bigint;
        v_m_id_113_10 bigint;
        v_m_id_113_11 bigint;
        v_m_id_113_12 bigint;
        v_m_id_113_13 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_113 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_113 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_113;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_113 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_113;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_113, 1, 2025, 12, 150.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_113_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_113, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_113_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_113, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_113_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_113, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_113_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_113, 1, 2026, 1, 146.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_113_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_113, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_113_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_113, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_113_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_113, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_113_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_113, 1, 2026, 2, 144.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_113_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_113, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_113_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_113, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_113_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_113, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_113_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_113, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_113_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_113, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_113_13;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_113,
            v_socio_113,
            NULL,
            156.40,
            'Efectivo',
            '32517',
            'Pago histórico recibo N° 32517',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_113_0, 'monto_aplicado', 150.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_113_1, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-17 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-17 12:00:00-05', created_at = '2026-02-17 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-17 12:00:00-05', created_at = '2026-02-17 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_113,
            v_socio_113,
            NULL,
            126.00,
            'Efectivo',
            '32578',
            'Pago histórico recibo N° 32578',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_113_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_113_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_113_6, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_113_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_113,
            v_socio_113,
            NULL,
            151.20,
            'Efectivo',
            '32796',
            'Pago histórico recibo N° 32796',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_113_4, 'monto_aplicado', 146.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_113_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_113,
            v_socio_113,
            NULL,
            154.10,
            'Efectivo',
            '32902',
            'Pago histórico recibo N° 32902',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_113_8, 'monto_aplicado', 144.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_113_9, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_113,
            v_socio_113,
            NULL,
            65.00,
            'Efectivo',
            '32672',
            'Pago histórico recibo N° 32672',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_113_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_113_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-16 12:00:00-05', created_at = '2026-03-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-16 12:00:00-05', created_at = '2026-03-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_113,
            v_socio_113,
            NULL,
            65.00,
            'Efectivo',
            '33111',
            'Pago histórico recibo N° 33111',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_113_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_113_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: PAREDES MORALES DIANA VONNETH (Puesto: 19, ID: 114)
    -- =========================================================================
    DECLARE
        v_socio_114 bigint := 114;
        v_puesto_114 bigint := 74;
        v_m_id_114_0 bigint;
        v_m_id_114_1 bigint;
        v_m_id_114_2 bigint;
        v_m_id_114_3 bigint;
        v_m_id_114_4 bigint;
        v_m_id_114_5 bigint;
        v_m_id_114_6 bigint;
        v_m_id_114_7 bigint;
        v_m_id_114_8 bigint;
        v_m_id_114_9 bigint;
        v_m_id_114_10 bigint;
        v_m_id_114_11 bigint;
        v_m_id_114_12 bigint;
        v_m_id_114_13 bigint;
        v_m_id_114_14 bigint;
        v_m_id_114_15 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_114 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_114 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_114;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_114 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_114;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_114, 1, 2025, 11, 66.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_114_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_114, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_114_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_114, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_114_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_114, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_114_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_114, 1, 2025, 12, 67.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_114_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_114, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_114_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_114, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_114_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_114, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_114_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_114, 1, 2026, 1, 71.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_114_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_114, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_114_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_114, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_114_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_114, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_114_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_114, 1, 2026, 2, 70.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_114_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_114, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_114_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_114, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_114_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_114, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_114_15;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_114,
            v_socio_114,
            NULL,
            146.00,
            'Efectivo',
            '32526',
            'Pago histórico recibo N° 32526',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_114_0, 'monto_aplicado', 66.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_114_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_114_4, 'monto_aplicado', 67.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_114_5, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_114,
            v_socio_114,
            NULL,
            412.00,
            'Efectivo',
            '32864',
            'Pago histórico recibo N° 32864',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_114_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_114_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_114_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_114_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_114_8, 'monto_aplicado', 71.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_114_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_114_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_114_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_114_12, 'monto_aplicado', 70.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_114_13, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_114_14, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_114_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: PAREDES MORALES OSCAR MARTIN (Puesto: 28, ID: 115)
    -- =========================================================================
    DECLARE
        v_socio_115 bigint := 115;
        v_puesto_115 bigint := 92;
        v_m_id_115_0 bigint;
        v_m_id_115_1 bigint;
        v_m_id_115_2 bigint;
        v_m_id_115_3 bigint;
        v_m_id_115_4 bigint;
        v_m_id_115_5 bigint;
        v_m_id_115_6 bigint;
        v_m_id_115_7 bigint;
        v_m_id_115_8 bigint;
        v_m_id_115_9 bigint;
        v_m_id_115_10 bigint;
        v_m_id_115_11 bigint;
        v_m_id_115_12 bigint;
        v_m_id_115_13 bigint;
        v_m_id_115_14 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_115 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_115 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_115;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_115 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_115;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_115, 1, 2025, 11, 66.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_115_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_115, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_115_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_115, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_115_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_115, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_115_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_115, 1, 2025, 12, 67.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_115_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_115, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_115_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_115, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_115_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_115, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_115_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_115, 1, 2026, 2, 151.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_115_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_115, 2, 2026, 2, 15.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_115_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_115, 3, 2026, 2, 116.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_115_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_115, 4, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_115_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_115, 19, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_115_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_115, 1, 2026, 3, 78.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_115_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_115, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_115_14;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_115,
            v_socio_115,
            NULL,
            137.50,
            'Efectivo',
            '32622',
            'Pago histórico recibo N° 32622',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_115_0, 'monto_aplicado', 66.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_115_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_115_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_115_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_115,
            v_socio_115,
            NULL,
            295.00,
            'Efectivo',
            '32795',
            'Pago histórico recibo N° 32795',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_115_4, 'monto_aplicado', 67.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_115_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_115_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_115_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_115_8, 'monto_aplicado', 76.50, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_115_9, 'monto_aplicado', 5.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_115_10, 'monto_aplicado', 60.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_115_11, 'monto_aplicado', 5.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_115_12, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_115,
            v_socio_115,
            NULL,
            146.40,
            'Efectivo',
            '32906',
            'Pago histórico recibo N° 32906',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_115_8, 'monto_aplicado', 75.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_115_9, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_115_10, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_115_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_115,
            v_socio_115,
            NULL,
            84.30,
            'Efectivo',
            '33132',
            'Pago histórico recibo N° 33132',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_115_13, 'monto_aplicado', 78.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_115_14, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: PEREZ PONCE DE ROMERO SATURNINA MARGARITA (Puesto: 187, ID: 116)
    -- =========================================================================
    DECLARE
        v_socio_116 bigint := 116;
        v_puesto_116 bigint := 281;
        v_m_id_116_0 bigint;
        v_m_id_116_1 bigint;
        v_m_id_116_2 bigint;
        v_m_id_116_3 bigint;
        v_m_id_116_4 bigint;
        v_m_id_116_5 bigint;
        v_m_id_116_6 bigint;
        v_m_id_116_7 bigint;
        v_m_id_116_8 bigint;
        v_m_id_116_9 bigint;
        v_m_id_116_10 bigint;
        v_m_id_116_11 bigint;
        v_m_id_116_12 bigint;
        v_m_id_116_13 bigint;
        v_m_id_116_14 bigint;
        v_m_id_116_15 bigint;
        v_m_id_116_16 bigint;
        v_m_id_116_17 bigint;
        v_m_id_116_18 bigint;
        v_m_id_116_19 bigint;
        v_m_id_116_20 bigint;
        v_m_id_116_21 bigint;
        v_m_id_116_22 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_116 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_116 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_116;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_116 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_116;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 1, 2025, 11, 25.80, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_116_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_116_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_116_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_116_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 1, 2025, 12, 26.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_116_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_116_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_116_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_116_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 1, 2026, 1, 23.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_116_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_116_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_116_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_116_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_116_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 1, 2026, 2, 16.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_116_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_116_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_116_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_116_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 1, 2026, 3, 24.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_116_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_116_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_116_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_116_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_116_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_116, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_116_22;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_116,
            v_socio_116,
            NULL,
            194.70,
            'Efectivo',
            '32402',
            'Pago histórico recibo N° 32402',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_116_0, 'monto_aplicado', 25.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_4, 'monto_aplicado', 26.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_116,
            v_socio_116,
            NULL,
            191.20,
            'Efectivo',
            '32881',
            'Pago histórico recibo N° 32881',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_116_8, 'monto_aplicado', 23.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_13, 'monto_aplicado', 16.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_14, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_116,
            v_socio_116,
            NULL,
            160.30,
            'Efectivo',
            '33067',
            'Pago histórico recibo N° 33067',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_116_17, 'monto_aplicado', 24.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_18, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_20, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_21, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_116_22, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: PEREZ QUISPE EPIFANIA RICARDINA (Puesto: 40, ID: 117)
    -- =========================================================================
    DECLARE
        v_socio_117 bigint := 117;
        v_puesto_117 bigint := 114;
        v_m_id_117_0 bigint;
        v_m_id_117_1 bigint;
        v_m_id_117_2 bigint;
        v_m_id_117_3 bigint;
        v_m_id_117_4 bigint;
        v_m_id_117_5 bigint;
        v_m_id_117_6 bigint;
        v_m_id_117_7 bigint;
        v_m_id_117_8 bigint;
        v_m_id_117_9 bigint;
        v_m_id_117_10 bigint;
        v_m_id_117_11 bigint;
        v_m_id_117_12 bigint;
        v_m_id_117_13 bigint;
        v_m_id_117_14 bigint;
        v_m_id_117_15 bigint;
        v_m_id_117_16 bigint;
        v_m_id_117_17 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_117 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_117 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_117;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_117 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_117;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 18, 2026, 8, 15.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - TALONAIO SANTA ROSA', v_user_uuid)
        RETURNING id INTO v_m_id_117_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 1, 2025, 11, 38.80, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_117_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_117_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_117_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_117_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 1, 2025, 12, 39.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_117_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_117_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_117_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_117_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 1, 2026, 1, 38.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_117_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_117_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_117_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_117_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_117_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 1, 2026, 2, 37.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_117_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_117_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_117_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_117, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_117_17;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_117,
            v_socio_117,
            NULL,
            105.20,
            'Efectivo',
            '32417',
            'Pago histórico recibo N° 32417',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_117_0, 'monto_aplicado', 15.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_117_1, 'monto_aplicado', 38.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_117_2, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_117_5, 'monto_aplicado', 39.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_117_6, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_117,
            v_socio_117,
            NULL,
            130.00,
            'Efectivo',
            '32493',
            'Pago histórico recibo N° 32493',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_117_3, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_117_4, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_117_7, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_117_8, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_117,
            v_socio_117,
            NULL,
            91.00,
            'Efectivo',
            '32736',
            'Pago histórico recibo N° 32736',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_117_9, 'monto_aplicado', 38.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_117_10, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_117_14, 'monto_aplicado', 37.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_117_15, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_117,
            v_socio_117,
            NULL,
            136.00,
            'Efectivo',
            '32737',
            'Pago histórico recibo N° 32737',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_117_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_117_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_117_13, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_117_16, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_117_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: PITTMAN CONCEPCION NELLY MARIA (Puesto: 33, ID: 118)
    -- =========================================================================
    DECLARE
        v_socio_118 bigint := 118;
        v_puesto_118 bigint := 102;
        v_m_id_118_0 bigint;
        v_m_id_118_1 bigint;
        v_m_id_118_2 bigint;
        v_m_id_118_3 bigint;
        v_m_id_118_4 bigint;
        v_m_id_118_5 bigint;
        v_m_id_118_6 bigint;
        v_m_id_118_7 bigint;
        v_m_id_118_8 bigint;
        v_m_id_118_9 bigint;
        v_m_id_118_10 bigint;
        v_m_id_118_11 bigint;
        v_m_id_118_12 bigint;
        v_m_id_118_13 bigint;
        v_m_id_118_14 bigint;
        v_m_id_118_15 bigint;
        v_m_id_118_16 bigint;
        v_m_id_118_17 bigint;
        v_m_id_118_18 bigint;
        v_m_id_118_19 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_118 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_118 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_118;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_118 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_118;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 18, 2026, 8, 15.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - TALONAIO SANTA ROSA', v_user_uuid)
        RETURNING id INTO v_m_id_118_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_118_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_118_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 1, 2025, 11, 38.80, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_118_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_118_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_118_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_118_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 1, 2025, 12, 39.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_118_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_118_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 1, 2026, 1, 38.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_118_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_118_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_118_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_118_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_118_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 1, 2026, 2, 37.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_118_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_118_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_118_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_118_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 1, 2026, 3, 39.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_118_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_118, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_118_19;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_118,
            v_socio_118,
            NULL,
            151.00,
            'Efectivo',
            '32917',
            'Pago histórico recibo N° 32917',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_118_0, 'monto_aplicado', 15.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_118_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_118_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_118_13, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_118_16, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_118_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_118,
            v_socio_118,
            NULL,
            130.00,
            'Efectivo',
            '32357',
            'Pago histórico recibo N° 32357',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_118_1, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_118_2, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_118_5, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_118_6, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_118,
            v_socio_118,
            NULL,
            90.20,
            'Efectivo',
            '32400',
            'Pago histórico recibo N° 32400',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_118_3, 'monto_aplicado', 38.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_118_4, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_118_7, 'monto_aplicado', 39.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_118_8, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_118,
            v_socio_118,
            NULL,
            43.30,
            'Efectivo',
            '32560',
            'Pago histórico recibo N° 32560',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_118_9, 'monto_aplicado', 38.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_118_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_118,
            v_socio_118,
            NULL,
            47.70,
            'Efectivo',
            '32733',
            'Pago histórico recibo N° 32733',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_118_14, 'monto_aplicado', 37.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_118_15, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_118,
            v_socio_118,
            NULL,
            45.50,
            'Efectivo',
            '32976',
            'Pago histórico recibo N° 32976',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_118_18, 'monto_aplicado', 39.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_118_19, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: PORRAS URCURANGA DE OROYA OLIMPIA (Puesto: 123, ID: 120)
    -- =========================================================================
    DECLARE
        v_socio_120 bigint := 120;
        v_puesto_120 bigint := 218;
        v_m_id_120_0 bigint;
        v_m_id_120_1 bigint;
        v_m_id_120_2 bigint;
        v_m_id_120_3 bigint;
        v_m_id_120_4 bigint;
        v_m_id_120_5 bigint;
        v_m_id_120_6 bigint;
        v_m_id_120_7 bigint;
        v_m_id_120_8 bigint;
        v_m_id_120_9 bigint;
        v_m_id_120_10 bigint;
        v_m_id_120_11 bigint;
        v_m_id_120_12 bigint;
        v_m_id_120_13 bigint;
        v_m_id_120_14 bigint;
        v_m_id_120_15 bigint;
        v_m_id_120_16 bigint;
        v_m_id_120_17 bigint;
        v_m_id_120_18 bigint;
        v_m_id_120_19 bigint;
        v_m_id_120_20 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_120 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_120 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_120;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_120 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_120;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 1, 2026, 10, 6.40, 'Pendiente', 'Manual', '2026-10-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_120_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 2, 2026, 10, 7.00, 'Pendiente', 'Manual', '2026-10-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_120_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 1, 2025, 11, 6.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_120_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_120_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_120_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_120_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 1, 2025, 12, 5.80, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_120_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_120_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_120_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_120_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 1, 2026, 1, 6.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_120_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_120_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_120_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_120_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_120_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 1, 2026, 2, 5.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_120_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_120_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_120_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_120_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_120_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_120, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_120_20;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_120,
            v_socio_120,
            NULL,
            167.70,
            'Efectivo',
            '32524',
            'Pago histórico recibo N° 32524',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_120_0, 'monto_aplicado', 6.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_1, 'monto_aplicado', 7.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_2, 'monto_aplicado', 6.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_3, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_6, 'monto_aplicado', 5.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_7, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_8, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_120,
            v_socio_120,
            NULL,
            86.30,
            'Efectivo',
            '32525',
            'Pago histórico recibo N° 32525',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_120_10, 'monto_aplicado', 6.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_13, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_14, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_120,
            v_socio_120,
            NULL,
            141.90,
            'Efectivo',
            '32942',
            'Pago histórico recibo N° 32942',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_120_15, 'monto_aplicado', 5.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_16, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_17, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_18, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_120_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-13 12:00:00-05', created_at = '2026-04-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-13 12:00:00-05', created_at = '2026-04-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: PLAZA COSQUILLO ROSA ESTELA (Puesto: 138, ID: 119)
    -- =========================================================================
    DECLARE
        v_socio_119 bigint := 119;
        v_puesto_119 bigint := 233;
        v_m_id_119_0 bigint;
        v_m_id_119_1 bigint;
        v_m_id_119_2 bigint;
        v_m_id_119_3 bigint;
        v_m_id_119_4 bigint;
        v_m_id_119_5 bigint;
        v_m_id_119_6 bigint;
        v_m_id_119_7 bigint;
        v_m_id_119_8 bigint;
        v_m_id_119_9 bigint;
        v_m_id_119_10 bigint;
        v_m_id_119_11 bigint;
        v_m_id_119_12 bigint;
        v_m_id_119_13 bigint;
        v_m_id_119_14 bigint;
        v_m_id_119_15 bigint;
        v_m_id_119_16 bigint;
        v_m_id_119_17 bigint;
        v_m_id_119_18 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_119 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_119 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_119;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_119 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_119;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 1, 2025, 12, 4.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_119_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_119_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_119_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_119_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_119_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_119_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 18, 2026, 1, 82.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - TRAMITES ADMINISTRATIVOS', v_user_uuid)
        RETURNING id INTO v_m_id_119_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 1, 2026, 1, 13.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_119_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_119_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_119_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_119_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 1, 2026, 2, 9.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_119_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_119_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_119_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_119_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 1, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_119_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_119_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_119_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_119, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_119_18;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_119,
            v_socio_119,
            NULL,
            140.50,
            'Efectivo',
            '32395',
            'Pago histórico recibo N° 32395',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_119_0, 'monto_aplicado', 4.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_119_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_119_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_119_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_119_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_119_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-24 12:00:00-05', created_at = '2026-01-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-24 12:00:00-05', created_at = '2026-01-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_119,
            v_socio_119,
            NULL,
            82.50,
            'Efectivo',
            '32405',
            'Pago histórico recibo N° 32405',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_119_6, 'monto_aplicado', 82.50, 'cubierto_completo', true)),
            0.00,
            '2026-01-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_119,
            v_socio_119,
            NULL,
            137.40,
            'Efectivo',
            '32692',
            'Pago histórico recibo N° 32692',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_119_7, 'monto_aplicado', 13.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_119_8, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_119_9, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_119_10, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_119_11, 'monto_aplicado', 9.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_119_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_119_13, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_119_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_119,
            v_socio_119,
            NULL,
            76.00,
            'Efectivo',
            '32972',
            'Pago histórico recibo N° 32972',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_119_15, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_119_16, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_119_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_119_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: PRADO LLANCARI ZOSIMA (Puesto: 42, ID: 121)
    -- =========================================================================
    DECLARE
        v_socio_121 bigint := 121;
        v_puesto_121 bigint := 118;
        v_m_id_121_0 bigint;
        v_m_id_121_1 bigint;
        v_m_id_121_2 bigint;
        v_m_id_121_3 bigint;
        v_m_id_121_4 bigint;
        v_m_id_121_5 bigint;
        v_m_id_121_6 bigint;
        v_m_id_121_7 bigint;
        v_m_id_121_8 bigint;
        v_m_id_121_9 bigint;
        v_m_id_121_10 bigint;
        v_m_id_121_11 bigint;
        v_m_id_121_12 bigint;
        v_m_id_121_13 bigint;
        v_m_id_121_14 bigint;
        v_m_id_121_15 bigint;
        v_m_id_121_16 bigint;
        v_m_id_121_17 bigint;
        v_m_id_121_18 bigint;
        v_m_id_121_19 bigint;
        v_m_id_121_20 bigint;
        v_m_id_121_21 bigint;
        v_m_id_121_22 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_121 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_121 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_121;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_121 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_121;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 1, 2025, 11, 77.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_121_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_121_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 1, 2025, 12, 78.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_121_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_121_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_121_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_121_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 1, 2026, 1, 76.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_121_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_121_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_121_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_121_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_121_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 1, 2026, 2, 75.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_121_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_121_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_121_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_121_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_121_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_121_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 1, 2026, 3, 78.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_121_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_121_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 1, 2026, 4, 89.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_121_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_121_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_121_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_121, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_121_22;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_121,
            v_socio_121,
            NULL,
            100.00,
            'Efectivo',
            '32361',
            'Pago histórico recibo N° 32361',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_121_0, 'monto_aplicado', 77.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_2, 'monto_aplicado', 16.40, 'cubierto_completo', false)),
            0.00,
            '2026-01-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-19 12:00:00-05', created_at = '2026-01-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-19 12:00:00-05', created_at = '2026-01-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_121,
            v_socio_121,
            NULL,
            133.30,
            'Efectivo',
            '32362',
            'Pago histórico recibo N° 32362',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_121_2, 'monto_aplicado', 62.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_3, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-19 12:00:00-05', created_at = '2026-01-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-19 12:00:00-05', created_at = '2026-01-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_121,
            v_socio_121,
            NULL,
            156.50,
            'Efectivo',
            '32579',
            'Pago histórico recibo N° 32579',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_121_6, 'monto_aplicado', 76.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_8, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_10, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_121,
            v_socio_121,
            NULL,
            146.40,
            'Efectivo',
            '32865',
            'Pago histórico recibo N° 32865',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_121_11, 'monto_aplicado', 75.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_13, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_121,
            v_socio_121,
            NULL,
            65.00,
            'Efectivo',
            '32929',
            'Pago histórico recibo N° 32929',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_121_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-06 12:00:00-05', created_at = '2026-04-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-06 12:00:00-05', created_at = '2026-04-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_121,
            v_socio_121,
            NULL,
            150.00,
            'Efectivo',
            '33113',
            'Pago histórico recibo N° 33113',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_121_17, 'monto_aplicado', 78.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_18, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_19, 'monto_aplicado', 65.70, 'cubierto_completo', false)),
            0.00,
            '2026-05-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_121,
            v_socio_121,
            NULL,
            94.30,
            'Efectivo',
            '33114',
            'Pago histórico recibo N° 33114',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_121_19, 'monto_aplicado', 23.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_20, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_21, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_121_22, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: QUINTANA VIDAL GLICERIO (Puesto: 97, ID: 122)
    -- =========================================================================
    DECLARE
        v_socio_122 bigint := 122;
        v_puesto_122 bigint := 192;
        v_m_id_122_0 bigint;
        v_m_id_122_1 bigint;
        v_m_id_122_2 bigint;
        v_m_id_122_3 bigint;
        v_m_id_122_4 bigint;
        v_m_id_122_5 bigint;
        v_m_id_122_6 bigint;
        v_m_id_122_7 bigint;
        v_m_id_122_8 bigint;
        v_m_id_122_9 bigint;
        v_m_id_122_10 bigint;
        v_m_id_122_11 bigint;
        v_m_id_122_12 bigint;
        v_m_id_122_13 bigint;
        v_m_id_122_14 bigint;
        v_m_id_122_15 bigint;
        v_m_id_122_16 bigint;
        v_m_id_122_17 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_122 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_122 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_122;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_122 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_122;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 1, 2025, 11, 32.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_122_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_122_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 1, 2025, 12, 29.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_122_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_122_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_122_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_122_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_122_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_122_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 1, 2026, 1, 29.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_122_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_122_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_122_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_122_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 1, 2026, 2, 31.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_122_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_122_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_122_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_122_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_122_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_122, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_122_17;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_122,
            v_socio_122,
            NULL,
            73.80,
            'Efectivo',
            '32449',
            'Pago histórico recibo N° 32449',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_122_0, 'monto_aplicado', 32.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_122_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_122_2, 'monto_aplicado', 29.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_122_3, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-02 12:00:00-05', created_at = '2026-02-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-02 12:00:00-05', created_at = '2026-02-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_122,
            v_socio_122,
            NULL,
            130.00,
            'Efectivo',
            '32500',
            'Pago histórico recibo N° 32500',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_122_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_122_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_122_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_122_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_122,
            v_socio_122,
            NULL,
            75.90,
            'Efectivo',
            '32849',
            'Pago histórico recibo N° 32849',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_122_8, 'monto_aplicado', 29.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_122_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_122_12, 'monto_aplicado', 31.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_122_13, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_122,
            v_socio_122,
            NULL,
            61.00,
            'Efectivo',
            '32680',
            'Pago histórico recibo N° 32680',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_122_10, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_122_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-17 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-17 12:00:00-05', created_at = '2026-03-17 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-17 12:00:00-05', created_at = '2026-03-17 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_122,
            v_socio_122,
            NULL,
            65.00,
            'Efectivo',
            '33049',
            'Pago histórico recibo N° 33049',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_122_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_122_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_122,
            v_socio_122,
            NULL,
            65.00,
            'Efectivo',
            '33048',
            'Pago histórico recibo N° 33048',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_122_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_122_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: QUISPE CONSA MIGUEL (Puesto: 115, ID: 123)
    -- =========================================================================
    DECLARE
        v_socio_123 bigint := 123;
        v_puesto_123 bigint := 210;
        v_m_id_123_0 bigint;
        v_m_id_123_1 bigint;
        v_m_id_123_2 bigint;
        v_m_id_123_3 bigint;
        v_m_id_123_4 bigint;
        v_m_id_123_5 bigint;
        v_m_id_123_6 bigint;
        v_m_id_123_7 bigint;
        v_m_id_123_8 bigint;
        v_m_id_123_9 bigint;
        v_m_id_123_10 bigint;
        v_m_id_123_11 bigint;
        v_m_id_123_12 bigint;
        v_m_id_123_13 bigint;
        v_m_id_123_14 bigint;
        v_m_id_123_15 bigint;
        v_m_id_123_16 bigint;
        v_m_id_123_17 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_123 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_123 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_123;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_123 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_123;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 18, 2025, 12, 10.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - RECONEXION DE LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_123_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 1, 2025, 12, 618.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_123_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 2, 2025, 12, 14.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_123_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_123_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_123_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 1, 2026, 1, 676.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_123_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 2, 2026, 1, 15.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_123_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_123_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_123_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_123_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 1, 2026, 2, 691.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_123_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 2, 2026, 2, 15.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_123_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_123_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_123_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 1, 2026, 3, 664.90, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_123_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 2, 2026, 3, 18.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_123_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_123_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_123, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_123_17;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_123,
            v_socio_123,
            NULL,
            10.00,
            'Efectivo',
            '32284',
            'Pago histórico recibo N° 32284',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_123_0, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_123,
            v_socio_123,
            NULL,
            632.60,
            'Efectivo',
            '32446',
            'Pago histórico recibo N° 32446',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_123_1, 'monto_aplicado', 618.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_123_2, 'monto_aplicado', 14.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-02 12:00:00-05', created_at = '2026-02-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-02 12:00:00-05', created_at = '2026-02-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_123,
            v_socio_123,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_123_3, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_123_4, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_123,
            v_socio_123,
            NULL,
            691.70,
            'Efectivo',
            '32623',
            'Pago histórico recibo N° 32623',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_123_5, 'monto_aplicado', 676.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_123_6, 'monto_aplicado', 15.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-05 12:00:00-05', created_at = '2026-03-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-05 12:00:00-05', created_at = '2026-03-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_123,
            v_socio_123,
            NULL,
            734.40,
            'Efectivo',
            '32821',
            'Pago histórico recibo N° 32821',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_123_7, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_123_10, 'monto_aplicado', 691.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_123_11, 'monto_aplicado', 15.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_123,
            v_socio_123,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_123_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_123_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_123,
            v_socio_123,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_123_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_123_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_123,
            v_socio_123,
            NULL,
            682.90,
            'Efectivo',
            '33058',
            'Pago histórico recibo N° 33058',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_123_14, 'monto_aplicado', 664.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_123_15, 'monto_aplicado', 18.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-12 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-12 12:00:00-05', created_at = '2026-05-12 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-12 12:00:00-05', created_at = '2026-05-12 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_123,
            v_socio_123,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_123_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_123_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: QUISPE CONSA VIDAL (Puesto: 90, ID: 124)
    -- =========================================================================
    DECLARE
        v_socio_124 bigint := 124;
        v_puesto_124 bigint := 186;
        v_m_id_124_0 bigint;
        v_m_id_124_1 bigint;
        v_m_id_124_2 bigint;
        v_m_id_124_3 bigint;
        v_m_id_124_4 bigint;
        v_m_id_124_5 bigint;
        v_m_id_124_6 bigint;
        v_m_id_124_7 bigint;
        v_m_id_124_8 bigint;
        v_m_id_124_9 bigint;
        v_m_id_124_10 bigint;
        v_m_id_124_11 bigint;
        v_m_id_124_12 bigint;
        v_m_id_124_13 bigint;
        v_m_id_124_14 bigint;
        v_m_id_124_15 bigint;
        v_m_id_124_16 bigint;
        v_m_id_124_17 bigint;
        v_m_id_124_18 bigint;
        v_m_id_124_19 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_124 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_124 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_124;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_124 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_124;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 1, 2025, 11, 457.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_124_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 2, 2025, 11, 13.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_124_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_124_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_124_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 1, 2025, 12, 488.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_124_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 2, 2025, 12, 13.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_124_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_124_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 1, 2026, 1, 574.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_124_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 2, 2026, 1, 15.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_124_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_124_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_124_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_124_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 1, 2026, 2, 602.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_124_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 2, 2026, 2, 15.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_124_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_124_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_124_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 1, 2026, 3, 586.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_124_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 2, 2026, 3, 17.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_124_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_124_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_124, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_124_19;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_124,
            v_socio_124,
            NULL,
            535.80,
            'Efectivo',
            '32316',
            'Pago histórico recibo N° 32316',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_124_0, 'monto_aplicado', 457.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_124_1, 'monto_aplicado', 13.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_124_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_124_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_124,
            v_socio_124,
            NULL,
            562.00,
            'Efectivo',
            '32475',
            'Pago histórico recibo N° 32475',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_124_4, 'monto_aplicado', 483.60, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_124_5, 'monto_aplicado', 13.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_124_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_124_4, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-06 12:00:00-05', created_at = '2026-02-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-06 12:00:00-05', created_at = '2026-02-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_124,
            v_socio_124,
            NULL,
            682.70,
            'Efectivo',
            '32640',
            'Pago histórico recibo N° 32640',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_124_7, 'monto_aplicado', 574.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_124_8, 'monto_aplicado', 15.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_124_9, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_124_10, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_124_11, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-10 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-10 12:00:00-05', created_at = '2026-03-10 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-10 12:00:00-05', created_at = '2026-03-10 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_124,
            v_socio_124,
            NULL,
            678.50,
            'Efectivo',
            '32758',
            'Pago histórico recibo N° 32758',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_124_12, 'monto_aplicado', 602.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_124_13, 'monto_aplicado', 15.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_124_14, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_124_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_124,
            v_socio_124,
            NULL,
            668.40,
            'Efectivo',
            '32957',
            'Pago histórico recibo N° 32957',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_124_16, 'monto_aplicado', 586.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_124_17, 'monto_aplicado', 17.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_124_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_124_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-23 12:00:00-05', created_at = '2026-04-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-23 12:00:00-05', created_at = '2026-04-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: QUISPE COPAYO ELIO CARLOS (Puesto: 114, ID: 125)
    -- =========================================================================
    DECLARE
        v_socio_125 bigint := 125;
        v_puesto_125 bigint := 209;
        v_m_id_125_0 bigint;
        v_m_id_125_1 bigint;
        v_m_id_125_2 bigint;
        v_m_id_125_3 bigint;
        v_m_id_125_4 bigint;
        v_m_id_125_5 bigint;
        v_m_id_125_6 bigint;
        v_m_id_125_7 bigint;
        v_m_id_125_8 bigint;
        v_m_id_125_9 bigint;
        v_m_id_125_10 bigint;
        v_m_id_125_11 bigint;
        v_m_id_125_12 bigint;
        v_m_id_125_13 bigint;
        v_m_id_125_14 bigint;
        v_m_id_125_15 bigint;
        v_m_id_125_16 bigint;
        v_m_id_125_17 bigint;
        v_m_id_125_18 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_125 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_125 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_125;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_125 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_125;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 1, 2025, 11, 740.20, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_125_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 2, 2025, 11, 13.40, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_125_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 1, 2025, 12, 812.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_125_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 2, 2025, 12, 14.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_125_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 1, 2026, 1, 919.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_125_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 2, 2026, 1, 12.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_125_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_125_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_125_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_125_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 1, 2026, 2, 975.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_125_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 2, 2026, 2, 21.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_125_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_125_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_125_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 1, 2026, 3, 958.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_125_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 2, 2026, 3, 64.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_125_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_125_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_125_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_125_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_125, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_125_18;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_125,
            v_socio_125,
            NULL,
            1580.10,
            'Efectivo',
            '32423',
            'Pago histórico recibo N° 32423',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_125_0, 'monto_aplicado', 740.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_125_1, 'monto_aplicado', 13.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_125_2, 'monto_aplicado', 812.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_125_3, 'monto_aplicado', 14.50, 'cubierto_completo', true)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_125,
            v_socio_125,
            NULL,
            932.30,
            'Efectivo',
            '32596',
            'Pago histórico recibo N° 32596',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_125_4, 'monto_aplicado', 919.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_125_5, 'monto_aplicado', 12.60, 'cubierto_completo', true)),
            0.00,
            '2026-03-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_125,
            v_socio_125,
            NULL,
            136.00,
            'Efectivo',
            '32800',
            'Pago histórico recibo N° 32800',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_125_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_125_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_125_8, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_125_11, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_125_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_125,
            v_socio_125,
            NULL,
            996.10,
            'Efectivo',
            '32754',
            'Pago histórico recibo N° 32754',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_125_9, 'monto_aplicado', 975.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_125_10, 'monto_aplicado', 21.10, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_125,
            v_socio_125,
            NULL,
            1022.40,
            'Efectivo',
            '32953',
            'Pago histórico recibo N° 32953',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_125_13, 'monto_aplicado', 958.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_125_14, 'monto_aplicado', 64.10, 'cubierto_completo', true)),
            0.00,
            '2026-04-22 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-22 12:00:00-05', created_at = '2026-04-22 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-22 12:00:00-05', created_at = '2026-04-22 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_125,
            v_socio_125,
            NULL,
            130.00,
            'Efectivo',
            '33079',
            'Pago histórico recibo N° 33079',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_125_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_125_16, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_125_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_125_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-15 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-15 12:00:00-05', created_at = '2026-05-15 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-15 12:00:00-05', created_at = '2026-05-15 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: QUISPE AGUILAR DE PALOMINO DOROTEA (Puesto: 132, ID: 126)
    -- =========================================================================
    DECLARE
        v_socio_126 bigint := 126;
        v_puesto_126 bigint := 227;
        v_m_id_126_0 bigint;
        v_m_id_126_1 bigint;
        v_m_id_126_2 bigint;
        v_m_id_126_3 bigint;
        v_m_id_126_4 bigint;
        v_m_id_126_5 bigint;
        v_m_id_126_6 bigint;
        v_m_id_126_7 bigint;
        v_m_id_126_8 bigint;
        v_m_id_126_9 bigint;
        v_m_id_126_10 bigint;
        v_m_id_126_11 bigint;
        v_m_id_126_12 bigint;
        v_m_id_126_13 bigint;
        v_m_id_126_14 bigint;
        v_m_id_126_15 bigint;
        v_m_id_126_16 bigint;
        v_m_id_126_17 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_126 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_126 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_126;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_126 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_126;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 1, 2025, 11, 302.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_126_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_126_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 1, 2025, 12, 305.30, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_126_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_126_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_126_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_126_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 1, 2026, 1, 349.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_126_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_126_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_126_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_126_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 1, 2026, 2, 355.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_126_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 2, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_126_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_126_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_126_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 1, 2026, 3, 340.80, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_126_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_126_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_126_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_126, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_126_17;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_126,
            v_socio_126,
            NULL,
            308.70,
            'Efectivo',
            '32376',
            'Pago histórico recibo N° 32376',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_126_0, 'monto_aplicado', 302.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_126_1, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_126,
            v_socio_126,
            NULL,
            311.30,
            'Efectivo',
            '32558',
            'Pago histórico recibo N° 32558',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_126_2, 'monto_aplicado', 305.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_126_3, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_126,
            v_socio_126,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_126_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_126_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_126,
            v_socio_126,
            NULL,
            354.90,
            'Efectivo',
            '32697',
            'Pago histórico recibo N° 32697',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_126_6, 'monto_aplicado', 349.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_126_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_126,
            v_socio_126,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_126_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_126_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_126,
            v_socio_126,
            NULL,
            360.40,
            'Efectivo',
            '32808',
            'Pago histórico recibo N° 32808',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_126_10, 'monto_aplicado', 355.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_126_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_126,
            v_socio_126,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_126_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_126_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_126,
            v_socio_126,
            NULL,
            346.80,
            'Efectivo',
            '33013',
            'Pago histórico recibo N° 33013',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_126_14, 'monto_aplicado', 340.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_126_15, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_126,
            v_socio_126,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_126_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_126_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: QUISPE DURAN ADRIANA (Puesto: 157, ID: 127)
    -- =========================================================================
    DECLARE
        v_socio_127 bigint := 127;
        v_puesto_127 bigint := 252;
        v_m_id_127_0 bigint;
        v_m_id_127_1 bigint;
        v_m_id_127_2 bigint;
        v_m_id_127_3 bigint;
        v_m_id_127_4 bigint;
        v_m_id_127_5 bigint;
        v_m_id_127_6 bigint;
        v_m_id_127_7 bigint;
        v_m_id_127_8 bigint;
        v_m_id_127_9 bigint;
        v_m_id_127_10 bigint;
        v_m_id_127_11 bigint;
        v_m_id_127_12 bigint;
        v_m_id_127_13 bigint;
        v_m_id_127_14 bigint;
        v_m_id_127_15 bigint;
        v_m_id_127_16 bigint;
        v_m_id_127_17 bigint;
        v_m_id_127_18 bigint;
        v_m_id_127_19 bigint;
        v_m_id_127_20 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_127 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_127 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_127;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_127 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_127;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 1, 2025, 11, 564.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_127_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 2, 2025, 11, 54.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_127_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 1, 2025, 12, 761.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_127_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 2, 2025, 12, 54.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_127_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_127_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_127_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 1, 2026, 1, 688.80, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_127_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 2, 2026, 1, 42.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_127_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_127_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_127_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_127_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 1, 2026, 2, 732.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_127_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 2, 2026, 2, 45.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_127_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_127_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_127_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 1, 2026, 3, 711.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_127_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 2, 2026, 3, 59.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_127_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_127_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_127_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 1, 2026, 4, 786.20, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_127_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_127, 2, 2026, 4, 59.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_127_20;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_127,
            v_socio_127,
            NULL,
            1839.80,
            'Efectivo',
            '32555',
            'Pago histórico recibo N° 32555',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_127_0, 'monto_aplicado', 564.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_127_1, 'monto_aplicado', 54.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_127_2, 'monto_aplicado', 426.40, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_127_3, 'monto_aplicado', 54.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_127_6, 'monto_aplicado', 688.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_127_7, 'monto_aplicado', 42.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_127_8, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_127,
            v_socio_127,
            NULL,
            400.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_127_2, 'monto_aplicado', 335.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_127_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_127_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_127,
            v_socio_127,
            NULL,
            400.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_127_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_127_10, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_127_11, 'monto_aplicado', 339.00, 'cubierto_completo', false)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_127,
            v_socio_127,
            NULL,
            438.40,
            'Efectivo',
            '32802',
            'Pago histórico recibo N° 32802',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_127_11, 'monto_aplicado', 393.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_127_12, 'monto_aplicado', 45.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_127,
            v_socio_127,
            NULL,
            400.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_127_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_127_14, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_127_15, 'monto_aplicado', 335.00, 'cubierto_completo', false)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_127,
            v_socio_127,
            NULL,
            435.20,
            'Efectivo',
            '32974',
            'Pago histórico recibo N° 32974',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_127_15, 'monto_aplicado', 376.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_127_16, 'monto_aplicado', 59.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_127,
            v_socio_127,
            NULL,
            590.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_127_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_127_18, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_127_19, 'monto_aplicado', 525.00, 'cubierto_completo', false)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_127,
            v_socio_127,
            NULL,
            320.20,
            'Efectivo',
            '33143',
            'Pago histórico recibo N° 33143',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_127_19, 'monto_aplicado', 261.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_127_20, 'monto_aplicado', 59.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: QUISPE ORTEGA ROSA CARMEN (Puesto: 175, ID: 128)
    -- =========================================================================
    DECLARE
        v_socio_128 bigint := 128;
        v_puesto_128 bigint := 269;
        v_m_id_128_0 bigint;
        v_m_id_128_1 bigint;
        v_m_id_128_2 bigint;
        v_m_id_128_3 bigint;
        v_m_id_128_4 bigint;
        v_m_id_128_5 bigint;
        v_m_id_128_6 bigint;
        v_m_id_128_7 bigint;
        v_m_id_128_8 bigint;
        v_m_id_128_9 bigint;
        v_m_id_128_10 bigint;
        v_m_id_128_11 bigint;
        v_m_id_128_12 bigint;
        v_m_id_128_13 bigint;
        v_m_id_128_14 bigint;
        v_m_id_128_15 bigint;
        v_m_id_128_16 bigint;
        v_m_id_128_17 bigint;
        v_m_id_128_18 bigint;
        v_m_id_128_19 bigint;
        v_m_id_128_20 bigint;
        v_m_id_128_21 bigint;
        v_m_id_128_22 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_128 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_128 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_128;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_128 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_128;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 1, 2025, 11, 371.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_128_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 2, 2025, 11, 9.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_128_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 3, 2025, 11, 20.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_128_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_128_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 1, 2025, 12, 393.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_128_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 2, 2025, 12, 11.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_128_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 3, 2025, 12, 20.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_128_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_128_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_128_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_128_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_128_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 1, 2026, 1, 456.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_128_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 2, 2026, 1, 13.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_128_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_128_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_128_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 1, 2026, 2, 476.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_128_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 2, 2026, 2, 12.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_128_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_128_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 1, 2026, 3, 447.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_128_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 2, 2026, 3, 12.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_128_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_128_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_128_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_128, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_128_22;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_128,
            v_socio_128,
            NULL,
            406.00,
            'Efectivo',
            '32372',
            'Pago histórico recibo N° 32372',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_128_0, 'monto_aplicado', 371.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_128_1, 'monto_aplicado', 9.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_128_2, 'monto_aplicado', 20.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_128_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_128,
            v_socio_128,
            NULL,
            465.00,
            'Efectivo',
            '32463',
            'Pago histórico recibo N° 32463',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_128_4, 'monto_aplicado', 393.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_128_5, 'monto_aplicado', 11.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_128_6, 'monto_aplicado', 20.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_128_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_128_8, 'monto_aplicado', 20.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_128_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_128_10, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_128,
            v_socio_128,
            NULL,
            40.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_128_8, 'monto_aplicado', 40.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_128,
            v_socio_128,
            NULL,
            470.00,
            'Efectivo',
            '32836',
            'Pago histórico recibo N° 32836',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_128_11, 'monto_aplicado', 456.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_128_12, 'monto_aplicado', 13.70, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_128,
            v_socio_128,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_128_13, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_128_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_128,
            v_socio_128,
            NULL,
            488.50,
            'Efectivo',
            '32837',
            'Pago histórico recibo N° 32837',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_128_15, 'monto_aplicado', 476.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_128_16, 'monto_aplicado', 12.40, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_128,
            v_socio_128,
            NULL,
            20.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_128_17, 'monto_aplicado', 20.00, 'cubierto_completo', false)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_128,
            v_socio_128,
            NULL,
            504.60,
            'Efectivo',
            '32993',
            'Pago histórico recibo N° 32993',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_128_18, 'monto_aplicado', 447.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_128_19, 'monto_aplicado', 12.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_128_17, 'monto_aplicado', 40.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_128_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_128,
            v_socio_128,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_128_21, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_128_22, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: QUISPE URIBE LUCIANO (Puesto: 30, ID: 129)
    -- =========================================================================
    DECLARE
        v_socio_129 bigint := 129;
        v_puesto_129 bigint := 96;
        v_m_id_129_0 bigint;
        v_m_id_129_1 bigint;
        v_m_id_129_2 bigint;
        v_m_id_129_3 bigint;
        v_m_id_129_4 bigint;
        v_m_id_129_5 bigint;
        v_m_id_129_6 bigint;
        v_m_id_129_7 bigint;
        v_m_id_129_8 bigint;
        v_m_id_129_9 bigint;
        v_m_id_129_10 bigint;
        v_m_id_129_11 bigint;
        v_m_id_129_12 bigint;
        v_m_id_129_13 bigint;
        v_m_id_129_14 bigint;
        v_m_id_129_15 bigint;
        v_m_id_129_16 bigint;
        v_m_id_129_17 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_129 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_129 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_129;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_129 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_129;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 1, 2025, 12, 39.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_129_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_129_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_129_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_129_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 1, 2026, 1, 38.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_129_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_129_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_129_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_129_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 1, 2026, 2, 37.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_129_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_129_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_129_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_129_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 1, 2026, 3, 39.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_129_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_129_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_129_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_129_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 1, 2026, 4, 39.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_129_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_129, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_129_17;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_129,
            v_socio_129,
            NULL,
            45.40,
            'Efectivo',
            '32408',
            'Pago histórico recibo N° 32408',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_129_0, 'monto_aplicado', 39.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_129_1, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_129,
            v_socio_129,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_129_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_129_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_129,
            v_socio_129,
            NULL,
            43.30,
            'Efectivo',
            '32582',
            'Pago histórico recibo N° 32582',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_129_4, 'monto_aplicado', 38.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_129_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_129,
            v_socio_129,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_129_6, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_129_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_129,
            v_socio_129,
            NULL,
            47.70,
            'Efectivo',
            '32730',
            'Pago histórico recibo N° 32730',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_129_8, 'monto_aplicado', 37.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_129_9, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_129,
            v_socio_129,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_129_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_129_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_129,
            v_socio_129,
            NULL,
            45.50,
            'Efectivo',
            '32978',
            'Pago histórico recibo N° 32978',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_129_12, 'monto_aplicado', 39.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_129_13, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-29 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_129,
            v_socio_129,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_129_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_129_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_129,
            v_socio_129,
            NULL,
            45.00,
            'Efectivo',
            '33147',
            'Pago histórico recibo N° 33147',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_129_16, 'monto_aplicado', 39.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_129_17, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-28 12:00:00-05', created_at = '2026-05-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-28 12:00:00-05', created_at = '2026-05-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: RAMOS CUEVA PEDRO RAUL (Puesto: 131, ID: 130)
    -- =========================================================================
    DECLARE
        v_socio_130 bigint := 130;
        v_puesto_130 bigint := 226;
        v_m_id_130_0 bigint;
        v_m_id_130_1 bigint;
        v_m_id_130_2 bigint;
        v_m_id_130_3 bigint;
        v_m_id_130_4 bigint;
        v_m_id_130_5 bigint;
        v_m_id_130_6 bigint;
        v_m_id_130_7 bigint;
        v_m_id_130_8 bigint;
        v_m_id_130_9 bigint;
        v_m_id_130_10 bigint;
        v_m_id_130_11 bigint;
        v_m_id_130_12 bigint;
        v_m_id_130_13 bigint;
        v_m_id_130_14 bigint;
        v_m_id_130_15 bigint;
        v_m_id_130_16 bigint;
        v_m_id_130_17 bigint;
        v_m_id_130_18 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_130 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_130 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_130;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_130 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_130;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 1, 2025, 11, 24.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_130_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 2, 2025, 11, 110.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_130_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 1, 2025, 12, 23.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_130_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 2, 2025, 12, 86.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_130_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_130_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_130_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_130_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_130_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_130_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 1, 2026, 1, 22.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_130_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 2, 2026, 1, 114.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_130_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 1, 2026, 2, 27.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_130_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 2, 2026, 2, 147.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_130_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_130_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_130_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 1, 2026, 3, 27.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_130_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 2, 2026, 3, 164.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_130_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_130_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_130, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_130_18;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_130,
            v_socio_130,
            NULL,
            134.30,
            'Efectivo',
            '32459',
            'Pago histórico recibo N° 32459',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_130_0, 'monto_aplicado', 24.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_130_1, 'monto_aplicado', 109.70, 'cubierto_completo', false)),
            0.00,
            '2026-02-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_130,
            v_socio_130,
            NULL,
            240.00,
            'Efectivo',
            '32460',
            'Pago histórico recibo N° 32460',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_130_1, 'monto_aplicado', 0.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_130_2, 'monto_aplicado', 23.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_130_3, 'monto_aplicado', 86.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_130_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_130_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_130_7, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_130_8, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_130,
            v_socio_130,
            NULL,
            10.00,
            'Efectivo',
            '32458',
            'Pago histórico recibo N° 32458',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_130_6, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_130,
            v_socio_130,
            NULL,
            250.00,
            'Efectivo',
            '32920',
            'Pago histórico recibo N° 32920',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_130_9, 'monto_aplicado', 22.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_130_10, 'monto_aplicado', 114.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_130_11, 'monto_aplicado', 27.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_130_12, 'monto_aplicado', 86.10, 'cubierto_completo', false)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_130,
            v_socio_130,
            NULL,
            122.40,
            'Efectivo',
            '32921',
            'Pago histórico recibo N° 32921',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_130_12, 'monto_aplicado', 61.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_130_13, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_130_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_130,
            v_socio_130,
            NULL,
            256.40,
            'Efectivo',
            '32996',
            'Pago histórico recibo N° 32996',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_130_15, 'monto_aplicado', 27.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_130_16, 'monto_aplicado', 164.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_130_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_130_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: REYES PEREZ DE VALENCIA NANCY VICTORIA (Puesto: 127, ID: 131)
    -- =========================================================================
    DECLARE
        v_socio_131 bigint := 131;
        v_puesto_131 bigint := 222;
        v_m_id_131_0 bigint;
        v_m_id_131_1 bigint;
        v_m_id_131_2 bigint;
        v_m_id_131_3 bigint;
        v_m_id_131_4 bigint;
        v_m_id_131_5 bigint;
        v_m_id_131_6 bigint;
        v_m_id_131_7 bigint;
        v_m_id_131_8 bigint;
        v_m_id_131_9 bigint;
        v_m_id_131_10 bigint;
        v_m_id_131_11 bigint;
        v_m_id_131_12 bigint;
        v_m_id_131_13 bigint;
        v_m_id_131_14 bigint;
        v_m_id_131_15 bigint;
        v_m_id_131_16 bigint;
        v_m_id_131_17 bigint;
        v_m_id_131_18 bigint;
        v_m_id_131_19 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_131 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_131 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_131;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_131 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_131;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 1, 2025, 11, 221.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_131_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 2, 2025, 11, 7.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_131_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_131_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_131_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 1, 2025, 12, 212.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_131_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 2, 2025, 12, 7.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_131_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_131_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_131_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 1, 2026, 1, 245.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_131_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 2, 2026, 1, 6.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_131_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_131_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_131_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 1, 2026, 2, 238.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_131_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 2, 2026, 2, 12.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_131_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_131_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_131_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 1, 2026, 3, 227.90, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_131_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 2, 2026, 3, 15.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_131_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_131_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_131, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_131_19;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_131,
            v_socio_131,
            NULL,
            228.10,
            'Efectivo',
            '32310',
            'Pago histórico recibo N° 32310',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_131_0, 'monto_aplicado', 221.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_131_1, 'monto_aplicado', 7.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-12 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-12 12:00:00-05', created_at = '2026-01-12 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-12 12:00:00-05', created_at = '2026-01-12 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_131,
            v_socio_131,
            NULL,
            65.00,
            'Efectivo',
            '32355',
            'Pago histórico recibo N° 32355',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_131_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_131_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_131,
            v_socio_131,
            NULL,
            219.70,
            'Efectivo',
            '32425',
            'Pago histórico recibo N° 32425',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_131_4, 'monto_aplicado', 212.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_131_5, 'monto_aplicado', 7.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_131,
            v_socio_131,
            NULL,
            65.00,
            'Efectivo',
            '32510',
            'Pago histórico recibo N° 32510',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_131_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_131_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_131,
            v_socio_131,
            NULL,
            251.70,
            'Efectivo',
            '32516',
            'Pago histórico recibo N° 32516',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_131_8, 'monto_aplicado', 245.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_131_9, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-16 12:00:00-05', created_at = '2026-02-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-16 12:00:00-05', created_at = '2026-02-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_131,
            v_socio_131,
            NULL,
            61.00,
            'Efectivo',
            '32671',
            'Pago histórico recibo N° 32671',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_131_10, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_131_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-13 12:00:00-05', created_at = '2026-03-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-13 12:00:00-05', created_at = '2026-03-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_131,
            v_socio_131,
            NULL,
            250.90,
            'Efectivo',
            '32743',
            'Pago histórico recibo N° 32743',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_131_12, 'monto_aplicado', 238.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_131_13, 'monto_aplicado', 12.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_131,
            v_socio_131,
            NULL,
            65.00,
            'Efectivo',
            '32963',
            'Pago histórico recibo N° 32963',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_131_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_131_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-25 12:00:00-05', created_at = '2026-04-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-25 12:00:00-05', created_at = '2026-04-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_131,
            v_socio_131,
            NULL,
            242.90,
            'Efectivo',
            '32966',
            'Pago histórico recibo N° 32966',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_131_16, 'monto_aplicado', 227.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_131_17, 'monto_aplicado', 15.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-27 12:00:00-05', created_at = '2026-04-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-27 12:00:00-05', created_at = '2026-04-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_131,
            v_socio_131,
            NULL,
            65.00,
            'Efectivo',
            '33020',
            'Pago histórico recibo N° 33020',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_131_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_131_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: REYES SANCHEZ MILENA GERALDINE (Puesto: 120, ID: 132)
    -- =========================================================================
    DECLARE
        v_socio_132 bigint := 132;
        v_puesto_132 bigint := 215;
        v_m_id_132_0 bigint;
        v_m_id_132_1 bigint;
        v_m_id_132_2 bigint;
        v_m_id_132_3 bigint;
        v_m_id_132_4 bigint;
        v_m_id_132_5 bigint;
        v_m_id_132_6 bigint;
        v_m_id_132_7 bigint;
        v_m_id_132_8 bigint;
        v_m_id_132_9 bigint;
        v_m_id_132_10 bigint;
        v_m_id_132_11 bigint;
        v_m_id_132_12 bigint;
        v_m_id_132_13 bigint;
        v_m_id_132_14 bigint;
        v_m_id_132_15 bigint;
        v_m_id_132_16 bigint;
        v_m_id_132_17 bigint;
        v_m_id_132_18 bigint;
        v_m_id_132_19 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_132 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_132 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_132;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_132 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_132;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 1, 2025, 11, 1094.40, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_132_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 2, 2025, 11, 26.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_132_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_132_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_132_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 1, 2025, 12, 1256.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_132_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 2, 2025, 12, 86.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_132_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_132_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_132_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 1, 2026, 1, 994.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_132_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 2, 2026, 1, 23.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_132_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_132_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_132_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_132_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_132_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 1, 2026, 2, 1172.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_132_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 2, 2026, 2, 21.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_132_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_132_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_132_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 1, 2026, 3, 1167.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_132_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_132, 2, 2026, 3, 16.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_132_19;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_132,
            v_socio_132,
            NULL,
            2300.00,
            'Efectivo',
            '32385',
            'Pago histórico recibo N° 32385',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_132_0, 'monto_aplicado', 1094.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_132_1, 'monto_aplicado', 26.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_132_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_132_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_132_4, 'monto_aplicado', 963.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_132_5, 'monto_aplicado', 86.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_132_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_132_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_132,
            v_socio_132,
            NULL,
            293.60,
            'Efectivo',
            '32386',
            'Pago histórico recibo N° 32386',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_132_4, 'monto_aplicado', 293.60, 'cubierto_completo', true)),
            0.00,
            '2026-01-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_132,
            v_socio_132,
            NULL,
            1143.50,
            'Efectivo',
            '32597',
            'Pago histórico recibo N° 32597',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_132_8, 'monto_aplicado', 994.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_132_9, 'monto_aplicado', 23.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_132_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_132_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_132_12, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_132_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_132,
            v_socio_132,
            NULL,
            1259.60,
            'Efectivo',
            '32753',
            'Pago histórico recibo N° 32753',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_132_14, 'monto_aplicado', 1172.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_132_15, 'monto_aplicado', 21.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_132_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_132_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_132,
            v_socio_132,
            NULL,
            1184.20,
            'Efectivo',
            '32954',
            'Pago histórico recibo N° 32954',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_132_18, 'monto_aplicado', 1167.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_132_19, 'monto_aplicado', 16.70, 'cubierto_completo', true)),
            0.00,
            '2026-04-22 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-22 12:00:00-05', created_at = '2026-04-22 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-22 12:00:00-05', created_at = '2026-04-22 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: RICSE SAYES TERESA REINA (Puesto: 136, ID: 133)
    -- =========================================================================
    DECLARE
        v_socio_133 bigint := 133;
        v_puesto_133 bigint := 231;
        v_m_id_133_0 bigint;
        v_m_id_133_1 bigint;
        v_m_id_133_2 bigint;
        v_m_id_133_3 bigint;
        v_m_id_133_4 bigint;
        v_m_id_133_5 bigint;
        v_m_id_133_6 bigint;
        v_m_id_133_7 bigint;
        v_m_id_133_8 bigint;
        v_m_id_133_9 bigint;
        v_m_id_133_10 bigint;
        v_m_id_133_11 bigint;
        v_m_id_133_12 bigint;
        v_m_id_133_13 bigint;
        v_m_id_133_14 bigint;
        v_m_id_133_15 bigint;
        v_m_id_133_16 bigint;
        v_m_id_133_17 bigint;
        v_m_id_133_18 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_133 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_133 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_133;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_133 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_133;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 1, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_133_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_133_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_133_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_133_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 1, 2025, 12, 4.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_133_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_133_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_133_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_133_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 1, 2026, 1, 6.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_133_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_133_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_133_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_133_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_133_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 1, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_133_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_133_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_133_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_133_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 1, 2026, 3, 45.60, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_133_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_133, 2, 2026, 3, 5.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_133_18;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_133,
            v_socio_133,
            NULL,
            12.00,
            'Efectivo',
            '32322',
            'Pago histórico recibo N° 32322',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_133_0, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_133_1, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_133,
            v_socio_133,
            NULL,
            281.00,
            'Efectivo',
            '32883',
            'Pago histórico recibo N° 32883',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_133_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_133_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_133_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_133_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_133_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_133_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_133_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_133_13, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_133_14, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_133_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_133_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_133,
            v_socio_133,
            NULL,
            10.00,
            'Efectivo',
            '32426',
            'Pago histórico recibo N° 32426',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_133_4, 'monto_aplicado', 4.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_133_5, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_133,
            v_socio_133,
            NULL,
            11.30,
            'Efectivo',
            '32877',
            'Pago histórico recibo N° 32877',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_133_8, 'monto_aplicado', 6.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_133_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_133,
            v_socio_133,
            NULL,
            51.00,
            'Efectivo',
            '33146',
            'Pago histórico recibo N° 33146',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_133_17, 'monto_aplicado', 45.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_133_18, 'monto_aplicado', 5.40, 'cubierto_completo', true)),
            0.00,
            '2026-05-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-28 12:00:00-05', created_at = '2026-05-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-28 12:00:00-05', created_at = '2026-05-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: RIVERA CALLPA JUANA REGIS (Puesto: 69, ID: 134)
    -- =========================================================================
    DECLARE
        v_socio_134 bigint := 134;
        v_puesto_134 bigint := 166;
        v_m_id_134_0 bigint;
        v_m_id_134_1 bigint;
        v_m_id_134_2 bigint;
        v_m_id_134_3 bigint;
        v_m_id_134_4 bigint;
        v_m_id_134_5 bigint;
        v_m_id_134_6 bigint;
        v_m_id_134_7 bigint;
        v_m_id_134_8 bigint;
        v_m_id_134_9 bigint;
        v_m_id_134_10 bigint;
        v_m_id_134_11 bigint;
        v_m_id_134_12 bigint;
        v_m_id_134_13 bigint;
        v_m_id_134_14 bigint;
        v_m_id_134_15 bigint;
        v_m_id_134_16 bigint;
        v_m_id_134_17 bigint;
        v_m_id_134_18 bigint;
        v_m_id_134_19 bigint;
        v_m_id_134_20 bigint;
        v_m_id_134_21 bigint;
        v_m_id_134_22 bigint;
        v_m_id_134_23 bigint;
        v_m_id_134_24 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_134 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_134 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_134;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_134 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_134;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 1, 2025, 11, 31.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_134_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_134_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 6, 2025, 11, 56.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - MULTA 27-11-2025', v_user_uuid)
        RETURNING id INTO v_m_id_134_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 1, 2025, 12, 31.80, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_134_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_134_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_134_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_134_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_134_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_134_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 1, 2026, 2, 30.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_134_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 2, 2026, 2, 8.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_134_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_134_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_134_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_134_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_134_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 1, 2026, 3, 32.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_134_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_134_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 6, 2026, 3, 56.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - MULTA 26/03/2026', v_user_uuid)
        RETURNING id INTO v_m_id_134_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 18, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - FUMIGACION', v_user_uuid)
        RETURNING id INTO v_m_id_134_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_134_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_134_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', '2026-05-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_134_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', '2026-05-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_134_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 3, 2026, 6, 60.00, 'Pendiente', 'Manual', '2026-06-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_134_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_134, 4, 2026, 6, 5.00, 'Pendiente', 'Manual', '2026-06-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_134_24;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_134,
            v_socio_134,
            NULL,
            111.00,
            'Efectivo',
            '32512',
            'Pago histórico recibo N° 32512',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_134_0, 'monto_aplicado', 31.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_3, 'monto_aplicado', 31.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_4, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_9, 'monto_aplicado', 30.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_10, 'monto_aplicado', 5.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_134_10, 'monto_aplicado', 0.50, 'cubierto_completo', false)),
            0.00,
            '2026-02-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-16 12:00:00-05', created_at = '2026-02-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-16 12:00:00-05', created_at = '2026-02-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_134,
            v_socio_134,
            NULL,
            113.00,
            'Efectivo',
            '33100',
            'Pago histórico recibo N° 33100',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_134_2, 'monto_aplicado', 56.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_17, 'monto_aplicado', 56.50, 'cubierto_completo', true)),
            0.00,
            '2026-05-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-21 12:00:00-05', created_at = '2026-05-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-21 12:00:00-05', created_at = '2026-05-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_134,
            v_socio_134,
            NULL,
            201.00,
            'Efectivo',
            '32571',
            'Pago histórico recibo N° 32571',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_134_5, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_6, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_7, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_11, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-26 12:00:00-05', created_at = '2026-02-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-26 12:00:00-05', created_at = '2026-02-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_134,
            v_socio_134,
            NULL,
            28.30,
            'Efectivo',
            '33061',
            'Pago histórico recibo N° 33061',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_134_8, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-05-12 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-12 12:00:00-05', created_at = '2026-05-12 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-12 12:00:00-05', created_at = '2026-05-12 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_134,
            v_socio_134,
            NULL,
            2.80,
            'Efectivo',
            '32693',
            'Pago histórico recibo N° 32693',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_134_10, 'monto_aplicado', 2.80, 'cubierto_completo', true)),
            0.00,
            '2026-03-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_134,
            v_socio_134,
            NULL,
            43.00,
            'Efectivo',
            '33060',
            'Pago histórico recibo N° 33060',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_134_15, 'monto_aplicado', 32.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_16, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-12 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-12 12:00:00-05', created_at = '2026-05-12 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-12 12:00:00-05', created_at = '2026-05-12 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_134,
            v_socio_134,
            NULL,
            195.00,
            'Efectivo',
            '33099',
            'Pago histórico recibo N° 33099',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_134_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_20, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_21, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_22, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_23, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_134_24, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-21 12:00:00-05', created_at = '2026-05-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-21 12:00:00-05', created_at = '2026-05-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: RIVERA FERNANDEZ MARINA MAXILIANA (Puesto: 142, ID: 135)
    -- =========================================================================
    DECLARE
        v_socio_135 bigint := 135;
        v_puesto_135 bigint := 237;
        v_m_id_135_0 bigint;
        v_m_id_135_1 bigint;
        v_m_id_135_2 bigint;
        v_m_id_135_3 bigint;
        v_m_id_135_4 bigint;
        v_m_id_135_5 bigint;
        v_m_id_135_6 bigint;
        v_m_id_135_7 bigint;
        v_m_id_135_8 bigint;
        v_m_id_135_9 bigint;
        v_m_id_135_10 bigint;
        v_m_id_135_11 bigint;
        v_m_id_135_12 bigint;
        v_m_id_135_13 bigint;
        v_m_id_135_14 bigint;
        v_m_id_135_15 bigint;
        v_m_id_135_16 bigint;
        v_m_id_135_17 bigint;
        v_m_id_135_18 bigint;
        v_m_id_135_19 bigint;
        v_m_id_135_20 bigint;
        v_m_id_135_21 bigint;
        v_m_id_135_22 bigint;
        v_m_id_135_23 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_135 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_135 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_135;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_135 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_135;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_135_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_135_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_135_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_135_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 1, 2025, 12, 16.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_135_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 2, 2025, 12, 10.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_135_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 1, 2026, 1, 8.80, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_135_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_135_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_135_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_135_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_135_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_135_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_135_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 1, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_135_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_135_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 18, 2026, 3, 600.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - CAMBIO DE GIRO DEFINITIVO', v_user_uuid)
        RETURNING id INTO v_m_id_135_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 1, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_135_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_135_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_135_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_135_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_135_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_135_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 18, 2026, 4, 20.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - FUMIGACION', v_user_uuid)
        RETURNING id INTO v_m_id_135_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_135, 3, 2026, 5, 24.00, 'Pendiente', 'Manual', '2026-05-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_135_23;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_135,
            v_socio_135,
            NULL,
            130.00,
            'Efectivo',
            '32294',
            'Pago histórico recibo N° 32294',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_135_0, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_1, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_135,
            v_socio_135,
            NULL,
            27.50,
            'Efectivo',
            '32342',
            'Pago histórico recibo N° 32342',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_135_4, 'monto_aplicado', 16.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_5, 'monto_aplicado', 10.60, 'cubierto_completo', true)),
            0.00,
            '2026-01-15 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_135,
            v_socio_135,
            NULL,
            149.80,
            'Efectivo',
            '32643',
            'Pago histórico recibo N° 32643',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_135_6, 'monto_aplicado', 8.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_8, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_10, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_11, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_135,
            v_socio_135,
            NULL,
            15.00,
            'Efectivo',
            '32806',
            'Pago histórico recibo N° 32806',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_135_13, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_14, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_135,
            v_socio_135,
            NULL,
            600.00,
            'Efectivo',
            '32613',
            'Pago histórico recibo N° 32613',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_135_15, 'monto_aplicado', 600.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_135,
            v_socio_135,
            NULL,
            185.00,
            'Efectivo',
            '33081',
            'Pago histórico recibo N° 33081',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_135_16, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_17, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_19, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_21, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_22, 'monto_aplicado', 5.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_135_22, 'monto_aplicado', 15.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_135_23, 'monto_aplicado', 24.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-18 12:00:00-05', created_at = '2026-05-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-18 12:00:00-05', created_at = '2026-05-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: RODRIGUEZ ARQUINEGO IDILIO FELIX (Puesto: 51, ID: 136)
    -- =========================================================================
    DECLARE
        v_socio_136 bigint := 136;
        v_puesto_136 bigint := 136;
        v_m_id_136_0 bigint;
        v_m_id_136_1 bigint;
        v_m_id_136_2 bigint;
        v_m_id_136_3 bigint;
        v_m_id_136_4 bigint;
        v_m_id_136_5 bigint;
        v_m_id_136_6 bigint;
        v_m_id_136_7 bigint;
        v_m_id_136_8 bigint;
        v_m_id_136_9 bigint;
        v_m_id_136_10 bigint;
        v_m_id_136_11 bigint;
        v_m_id_136_12 bigint;
        v_m_id_136_13 bigint;
        v_m_id_136_14 bigint;
        v_m_id_136_15 bigint;
        v_m_id_136_16 bigint;
        v_m_id_136_17 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_136 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_136 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_136;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_136 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_136;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 1, 2025, 11, 19.40, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_136_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_136_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 1, 2025, 12, 19.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_136_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_136_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 1, 2026, 1, 19.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_136_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_136_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_136_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_136_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_136_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_136_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 1, 2026, 2, 18.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_136_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_136_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_136_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_136_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 1, 2026, 3, 20.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_136_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_136_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 1, 2026, 4, 22.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_136_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_136, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_136_17;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_136,
            v_socio_136,
            NULL,
            239.50,
            'Efectivo',
            '32778',
            'Pago histórico recibo N° 32778',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_136_0, 'monto_aplicado', 19.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_136_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_136_2, 'monto_aplicado', 19.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_136_3, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_136_4, 'monto_aplicado', 19.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_136_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_136_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_136_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_136_8, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_136_9, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_136_12, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_136_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_136,
            v_socio_136,
            NULL,
            28.90,
            'Efectivo',
            '32775',
            'Pago histórico recibo N° 32775',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_136_10, 'monto_aplicado', 18.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_136_11, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_136,
            v_socio_136,
            NULL,
            54.10,
            'Efectivo',
            '33135',
            'Pago histórico recibo N° 33135',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_136_14, 'monto_aplicado', 20.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_136_15, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_136_16, 'monto_aplicado', 22.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_136_17, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: RODRIGUEZ CORDOVA MARCOS (Puesto: 139, ID: 137)
    -- =========================================================================
    DECLARE
        v_socio_137 bigint := 137;
        v_puesto_137 bigint := 234;
        v_m_id_137_0 bigint;
        v_m_id_137_1 bigint;
        v_m_id_137_2 bigint;
        v_m_id_137_3 bigint;
        v_m_id_137_4 bigint;
        v_m_id_137_5 bigint;
        v_m_id_137_6 bigint;
        v_m_id_137_7 bigint;
        v_m_id_137_8 bigint;
        v_m_id_137_9 bigint;
        v_m_id_137_10 bigint;
        v_m_id_137_11 bigint;
        v_m_id_137_12 bigint;
        v_m_id_137_13 bigint;
        v_m_id_137_14 bigint;
        v_m_id_137_15 bigint;
        v_m_id_137_16 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_137 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_137 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_137;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_137 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_137;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_137, 3, 2025, 11, 31.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_137_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_137, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_137_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_137, 1, 2025, 12, 29.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_137_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_137, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_137_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_137, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_137_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_137, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_137_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_137, 1, 2026, 1, 26.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_137_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_137, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_137_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_137, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_137_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_137, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_137_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_137, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_137_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_137, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_137_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_137, 1, 2026, 2, 25.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_137_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_137, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_137_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_137, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_137_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_137, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_137_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_137, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_137_16;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_137,
            v_socio_137,
            NULL,
            55.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_137_0, 'monto_aplicado', 31.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_137_1, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_137_4, 'monto_aplicado', 18.90, 'cubierto_completo', false)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_137,
            v_socio_137,
            NULL,
            60.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_137_2, 'monto_aplicado', 29.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_137_3, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_137_4, 'monto_aplicado', 25.00, 'cubierto_completo', false)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_137,
            v_socio_137,
            NULL,
            207.20,
            'Efectivo',
            '32848',
            'Pago histórico recibo N° 32848',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_137_4, 'monto_aplicado', 16.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_137_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_137_8, 'monto_aplicado', 46.20, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_137_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_137_10, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_137_11, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_137_12, 'monto_aplicado', 25.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_137_13, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_137_14, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_137_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_137,
            v_socio_137,
            NULL,
            45.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_137_6, 'monto_aplicado', 26.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_137_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_137_8, 'monto_aplicado', 13.80, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_137,
            v_socio_137,
            NULL,
            60.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_137_16, 'monto_aplicado', 60.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: RODRIGUEZ MORENO NORA (Puesto: 180, ID: 138)
    -- =========================================================================
    DECLARE
        v_socio_138 bigint := 138;
        v_puesto_138 bigint := 274;
        v_m_id_138_0 bigint;
        v_m_id_138_1 bigint;
        v_m_id_138_2 bigint;
        v_m_id_138_3 bigint;
        v_m_id_138_4 bigint;
        v_m_id_138_5 bigint;
        v_m_id_138_6 bigint;
        v_m_id_138_7 bigint;
        v_m_id_138_8 bigint;
        v_m_id_138_9 bigint;
        v_m_id_138_10 bigint;
        v_m_id_138_11 bigint;
        v_m_id_138_12 bigint;
        v_m_id_138_13 bigint;
        v_m_id_138_14 bigint;
        v_m_id_138_15 bigint;
        v_m_id_138_16 bigint;
        v_m_id_138_17 bigint;
        v_m_id_138_18 bigint;
        v_m_id_138_19 bigint;
        v_m_id_138_20 bigint;
        v_m_id_138_21 bigint;
        v_m_id_138_22 bigint;
        v_m_id_138_23 bigint;
        v_m_id_138_24 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_138 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_138 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_138;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_138 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_138;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 1, 2025, 11, 589.80, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_138_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 2, 2025, 11, 10.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_138_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 1, 2025, 12, 625.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_138_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 2, 2025, 12, 12.10, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_138_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_138_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_138_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_138_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_138_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 1, 2026, 1, 806.80, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_138_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 2, 2026, 1, 18.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_138_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_138_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_138_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_138_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_138_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 1, 2026, 2, 794.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_138_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 2, 2026, 2, 15.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_138_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_138_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_138_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 1, 2026, 3, 761.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_138_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 2, 2026, 3, 18.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_138_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_138_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_138_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 1, 2026, 4, 840.20, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_138_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 2, 2026, 4, 12.10, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_138_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_138, 18, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - FUMIGACION', v_user_uuid)
        RETURNING id INTO v_m_id_138_24;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_138,
            v_socio_138,
            NULL,
            1300.00,
            'Efectivo',
            '32414',
            'Pago histórico recibo N° 32414',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_138_0, 'monto_aplicado', 589.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_1, 'monto_aplicado', 10.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_2, 'monto_aplicado', 625.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_3, 'monto_aplicado', 12.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_5, 'monto_aplicado', 1.60, 'cubierto_completo', false)),
            0.00,
            '2026-01-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_138,
            v_socio_138,
            NULL,
            3.40,
            'Efectivo',
            '32415',
            'Pago histórico recibo N° 32415',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_138_5, 'monto_aplicado', 3.40, 'cubierto_completo', true)),
            0.00,
            '2026-01-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_138,
            v_socio_138,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_138_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_138,
            v_socio_138,
            NULL,
            1673.70,
            'Efectivo',
            '32731',
            'Pago histórico recibo N° 32731',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_138_8, 'monto_aplicado', 806.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_9, 'monto_aplicado', 18.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_10, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_11, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_14, 'monto_aplicado', 794.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_15, 'monto_aplicado', 15.70, 'cubierto_completo', true)),
            0.00,
            '2026-03-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_138,
            v_socio_138,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_138_12, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_138,
            v_socio_138,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_138_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_138,
            v_socio_138,
            NULL,
            1636.70,
            'Efectivo',
            '33137',
            'Pago histórico recibo N° 33137',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_138_18, 'monto_aplicado', 761.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_19, 'monto_aplicado', 18.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_22, 'monto_aplicado', 840.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_23, 'monto_aplicado', 12.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_24, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_138,
            v_socio_138,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_138_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_138_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ROJAS CORNEJO ERICK JOHN (Puesto: 99, ID: 139)
    -- =========================================================================
    DECLARE
        v_socio_139 bigint := 139;
        v_puesto_139 bigint := 194;
        v_m_id_139_0 bigint;
        v_m_id_139_1 bigint;
        v_m_id_139_2 bigint;
        v_m_id_139_3 bigint;
        v_m_id_139_4 bigint;
        v_m_id_139_5 bigint;
        v_m_id_139_6 bigint;
        v_m_id_139_7 bigint;
        v_m_id_139_8 bigint;
        v_m_id_139_9 bigint;
        v_m_id_139_10 bigint;
        v_m_id_139_11 bigint;
        v_m_id_139_12 bigint;
        v_m_id_139_13 bigint;
        v_m_id_139_14 bigint;
        v_m_id_139_15 bigint;
        v_m_id_139_16 bigint;
        v_m_id_139_17 bigint;
        v_m_id_139_18 bigint;
        v_m_id_139_19 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_139 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_139 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_139;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_139 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_139;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 1, 2025, 11, 35.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_139_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 2, 2025, 11, 9.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_139_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 1, 2025, 12, 95.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_139_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 2, 2025, 12, 10.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_139_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_139_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_139_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 1, 2026, 1, 45.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_139_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 2, 2026, 1, 21.80, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_139_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_139_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_139_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_139_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 1, 2026, 2, 94.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_139_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 2, 2026, 2, 22.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_139_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_139_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_139_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 1, 2026, 3, 73.80, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_139_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 2, 2026, 3, 17.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_139_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_139_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_139_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_139, 18, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - FUMIGACION', v_user_uuid)
        RETURNING id INTO v_m_id_139_19;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_139,
            v_socio_139,
            NULL,
            150.80,
            'Efectivo',
            '32360',
            'Pago histórico recibo N° 32360',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_139_0, 'monto_aplicado', 35.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_139_1, 'monto_aplicado', 9.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_139_2, 'monto_aplicado', 95.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_139_3, 'monto_aplicado', 10.40, 'cubierto_completo', true)),
            0.00,
            '2026-01-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-19 12:00:00-05', created_at = '2026-01-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-19 12:00:00-05', created_at = '2026-01-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_139,
            v_socio_139,
            NULL,
            110.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_139_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_139_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_139_6, 'monto_aplicado', 45.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_139,
            v_socio_139,
            NULL,
            69.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_139_7, 'monto_aplicado', 8.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_139_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_139_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_139,
            v_socio_139,
            NULL,
            23.80,
            'Efectivo',
            '32682',
            'Pago histórico recibo N° 32682',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_139_7, 'monto_aplicado', 13.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_139_8, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-17 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-17 12:00:00-05', created_at = '2026-03-17 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-17 12:00:00-05', created_at = '2026-03-17 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_139,
            v_socio_139,
            NULL,
            80.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_139_11, 'monto_aplicado', 40.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_139_13, 'monto_aplicado', 40.00, 'cubierto_completo', false)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_139,
            v_socio_139,
            NULL,
            77.00,
            'Efectivo',
            '32779',
            'Pago histórico recibo N° 32779',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_139_11, 'monto_aplicado', 54.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_139_12, 'monto_aplicado', 22.20, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_139,
            v_socio_139,
            NULL,
            25.00,
            'Efectivo',
            '32946',
            'Pago histórico recibo N° 32946',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_139_13, 'monto_aplicado', 20.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_139_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-16 12:00:00-05', created_at = '2026-04-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-16 12:00:00-05', created_at = '2026-04-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_139,
            v_socio_139,
            NULL,
            110.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_139_15, 'monto_aplicado', 45.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_139_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_139_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_139,
            v_socio_139,
            NULL,
            51.50,
            'Efectivo',
            '33053',
            'Pago histórico recibo N° 33053',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_139_15, 'monto_aplicado', 28.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_139_16, 'monto_aplicado', 17.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_139_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ROMERO FLORES EDDNA (Puesto: 151, ID: 141)
    -- =========================================================================
    DECLARE
        v_socio_141 bigint := 141;
        v_puesto_141 bigint := 246;
        v_m_id_141_0 bigint;
        v_m_id_141_1 bigint;
        v_m_id_141_2 bigint;
        v_m_id_141_3 bigint;
        v_m_id_141_4 bigint;
        v_m_id_141_5 bigint;
        v_m_id_141_6 bigint;
        v_m_id_141_7 bigint;
        v_m_id_141_8 bigint;
        v_m_id_141_9 bigint;
        v_m_id_141_10 bigint;
        v_m_id_141_11 bigint;
        v_m_id_141_12 bigint;
        v_m_id_141_13 bigint;
        v_m_id_141_14 bigint;
        v_m_id_141_15 bigint;
        v_m_id_141_16 bigint;
        v_m_id_141_17 bigint;
        v_m_id_141_18 bigint;
        v_m_id_141_19 bigint;
        v_m_id_141_20 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_141 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_141 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_141;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_141 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_141;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 1, 2025, 11, 228.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_141_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 2, 2025, 11, 28.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_141_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 3, 2025, 11, 36.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_141_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_141_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 1, 2025, 12, 300.80, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_141_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 2, 2025, 12, 28.30, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_141_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_141_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 1, 2026, 1, 323.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_141_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 2, 2026, 1, 34.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_141_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_141_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_141_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_141_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 1, 2026, 2, 322.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_141_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 2, 2026, 2, 31.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_141_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_141_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 1, 2026, 3, 317.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_141_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 2, 2026, 3, 46.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_141_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_141_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_141_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_141_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_141, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_141_20;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_141,
            v_socio_141,
            NULL,
            350.00,
            'Efectivo',
            '32494',
            'Pago histórico recibo N° 32494',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_141_0, 'monto_aplicado', 228.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_141_1, 'monto_aplicado', 28.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_141_2, 'monto_aplicado', 36.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_141_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_141_4, 'monto_aplicado', 51.60, 'cubierto_completo', false)),
            0.00,
            '2026-02-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_141,
            v_socio_141,
            NULL,
            700.00,
            'Efectivo',
            '32689',
            'Pago histórico recibo N° 32689',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_141_4, 'monto_aplicado', 249.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_141_5, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_141_7, 'monto_aplicado', 323.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_141_8, 'monto_aplicado', 34.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_141_6, 'monto_aplicado', 40.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_141_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_141_10, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_141_12, 'monto_aplicado', 9.40, 'cubierto_completo', false)),
            0.00,
            '2026-03-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_141,
            v_socio_141,
            NULL,
            20.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_141_6, 'monto_aplicado', 20.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_141,
            v_socio_141,
            NULL,
            20.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_141_11, 'monto_aplicado', 20.00, 'cubierto_completo', false)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_141,
            v_socio_141,
            NULL,
            385.80,
            'Efectivo',
            '32738',
            'Pago histórico recibo N° 32738',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_141_12, 'monto_aplicado', 313.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_141_13, 'monto_aplicado', 31.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_141_11, 'monto_aplicado', 36.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_141_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_141,
            v_socio_141,
            NULL,
            280.00,
            'Efectivo',
            '33093',
            'Pago histórico recibo N° 33093',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_141_15, 'monto_aplicado', 280.00, 'cubierto_completo', false)),
            0.00,
            '2026-05-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-20 12:00:00-05', created_at = '2026-05-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-20 12:00:00-05', created_at = '2026-05-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_141,
            v_socio_141,
            NULL,
            148.00,
            'Efectivo',
            '33120',
            'Pago histórico recibo N° 33120',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_141_15, 'monto_aplicado', 37.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_141_16, 'monto_aplicado', 46.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_141_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_141_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-26 12:00:00-05', created_at = '2026-05-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-26 12:00:00-05', created_at = '2026-05-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_141,
            v_socio_141,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_141_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_141_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: SALAS MONTALVO JUDITH MAGALI (Puesto: 38, ID: 145)
    -- =========================================================================
    DECLARE
        v_socio_145 bigint := 145;
        v_puesto_145 bigint := 110;
        v_m_id_145_0 bigint;
        v_m_id_145_1 bigint;
        v_m_id_145_2 bigint;
        v_m_id_145_3 bigint;
        v_m_id_145_4 bigint;
        v_m_id_145_5 bigint;
        v_m_id_145_6 bigint;
        v_m_id_145_7 bigint;
        v_m_id_145_8 bigint;
        v_m_id_145_9 bigint;
        v_m_id_145_10 bigint;
        v_m_id_145_11 bigint;
        v_m_id_145_12 bigint;
        v_m_id_145_13 bigint;
        v_m_id_145_14 bigint;
        v_m_id_145_15 bigint;
        v_m_id_145_16 bigint;
        v_m_id_145_17 bigint;
        v_m_id_145_18 bigint;
        v_m_id_145_19 bigint;
        v_m_id_145_20 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_145 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_145 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_145;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_145 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_145;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 1, 2025, 11, 55.40, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_145_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 2, 2025, 11, 263.40, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_145_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 1, 2025, 12, 56.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_145_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 2, 2025, 12, 277.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_145_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_145_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_145_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 1, 2026, 1, 54.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_145_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 2, 2026, 1, 221.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_145_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_145_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_145_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_145_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 1, 2026, 2, 53.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_145_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 2, 2026, 2, 359.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_145_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_145_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_145_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 1, 2026, 3, 56.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_145_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 2, 2026, 3, 295.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_145_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_145_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_145_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', '2026-05-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_145_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_145, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', '2026-05-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_145_20;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_145,
            v_socio_145,
            NULL,
            318.80,
            'Efectivo',
            '32299',
            'Pago histórico recibo N° 32299',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_145_0, 'monto_aplicado', 55.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_145_1, 'monto_aplicado', 263.40, 'cubierto_completo', true)),
            0.00,
            '2026-01-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_145,
            v_socio_145,
            NULL,
            610.00,
            'Efectivo',
            '32550',
            'Pago histórico recibo N° 32550',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_145_2, 'monto_aplicado', 56.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_145_3, 'monto_aplicado', 277.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_145_6, 'monto_aplicado', 54.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_145_7, 'monto_aplicado', 221.60, 'cubierto_completo', true)),
            0.00,
            '2026-02-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_145,
            v_socio_145,
            NULL,
            65.00,
            'Efectivo',
            '32377',
            'Pago histórico recibo N° 32377',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_145_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_145_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_145,
            v_socio_145,
            NULL,
            71.00,
            'Efectivo',
            '32559',
            'Pago histórico recibo N° 32559',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_145_8, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_145_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_145_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_145,
            v_socio_145,
            NULL,
            53.90,
            'Efectivo',
            '32708',
            'Pago histórico recibo N° 32708',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_145_11, 'monto_aplicado', 53.90, 'cubierto_completo', true)),
            0.00,
            '2026-03-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_145,
            v_socio_145,
            NULL,
            359.80,
            'Efectivo',
            '32734',
            'Pago histórico recibo N° 32734',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_145_12, 'monto_aplicado', 359.80, 'cubierto_completo', true)),
            0.00,
            '2026-03-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_145,
            v_socio_145,
            NULL,
            65.00,
            'Efectivo',
            '32760',
            'Pago histórico recibo N° 32760',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_145_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_145_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_145,
            v_socio_145,
            NULL,
            56.10,
            'Efectivo',
            '32956',
            'Pago histórico recibo N° 32956',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_145_15, 'monto_aplicado', 56.10, 'cubierto_completo', true)),
            0.00,
            '2026-04-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-23 12:00:00-05', created_at = '2026-04-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-23 12:00:00-05', created_at = '2026-04-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_145,
            v_socio_145,
            NULL,
            295.30,
            'Efectivo',
            '32997',
            'Pago histórico recibo N° 32997',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_145_16, 'monto_aplicado', 295.30, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_145,
            v_socio_145,
            NULL,
            65.00,
            'Efectivo',
            '32959',
            'Pago histórico recibo N° 32959',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_145_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_145_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-23 12:00:00-05', created_at = '2026-04-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-23 12:00:00-05', created_at = '2026-04-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_145,
            v_socio_145,
            NULL,
            65.00,
            'Efectivo',
            '33117',
            'Pago histórico recibo N° 33117',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_145_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_145_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-26 12:00:00-05', created_at = '2026-05-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-26 12:00:00-05', created_at = '2026-05-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    RAISE NOTICE '==================================================';
    RAISE NOTICE 'MIGRACIÓN DE SOCIOS EN ESTE BLOQUE COMPLETADA';
    RAISE NOTICE '  Deudas individuales creadas: %', v_cant_deudas;
    RAISE NOTICE '  Pagos agrupados procesados:  %', v_cant_pagos;
    RAISE NOTICE '==================================================';
END $$;