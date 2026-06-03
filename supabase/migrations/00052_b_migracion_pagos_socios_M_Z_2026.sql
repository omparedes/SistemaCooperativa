-- =============================================================================
-- Migración 00052_b — Carga de Pagos Detallados 2026 (Lista Socios M-Z)
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
    -- SOCIO: ROJAS IGNACIO LIONILA JULIA (Puesto: 41, ID: 140)
    -- =========================================================================
    DECLARE
        v_socio_140 bigint := 140;
        v_puesto_140 bigint := 116;
        v_m_id_140_0 bigint;
        v_m_id_140_1 bigint;
        v_m_id_140_2 bigint;
        v_m_id_140_3 bigint;
        v_m_id_140_4 bigint;
        v_m_id_140_5 bigint;
        v_m_id_140_6 bigint;
        v_m_id_140_7 bigint;
        v_m_id_140_8 bigint;
        v_m_id_140_9 bigint;
        v_m_id_140_10 bigint;
        v_m_id_140_11 bigint;
        v_m_id_140_12 bigint;
        v_m_id_140_13 bigint;
        v_m_id_140_14 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_140 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_140 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_140;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_140 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_140;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_140, 18, 2026, 8, 15.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - TALONARIO SANTA ROSA', v_user_uuid)
        RETURNING id INTO v_m_id_140_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_140, 1, 2025, 11, 68.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_140_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_140, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_140_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_140, 1, 2025, 12, 69.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_140_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_140, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_140_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_140, 1, 2026, 1, 67.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_140_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_140, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_140_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_140, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_140_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_140, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_140_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_140, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_140_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_140, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_140_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_140, 1, 2026, 2, 66.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_140_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_140, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_140_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_140, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_140_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_140, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_140_14;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_140,
            v_socio_140,
            NULL,
            91.50,
            'Efectivo',
            '32828',
            'Pago histórico recibo N° 32828',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_140_0, 'monto_aplicado', 15.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_140_11, 'monto_aplicado', 66.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_140_12, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_140,
            v_socio_140,
            NULL,
            200.00,
            'Efectivo',
            '32527',
            'Pago histórico recibo N° 32527',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_140_1, 'monto_aplicado', 68.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_140_2, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_140_3, 'monto_aplicado', 69.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_140_4, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_140_5, 'monto_aplicado', 50.00, 'cubierto_completo', false)),
            0.00,
            '2026-02-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_140,
            v_socio_140,
            NULL,
            22.50,
            'Efectivo',
            '32528',
            'Pago histórico recibo N° 32528',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_140_5, 'monto_aplicado', 17.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_140_6, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_140,
            v_socio_140,
            NULL,
            191.00,
            'Efectivo',
            '32664',
            'Pago histórico recibo N° 32664',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_140_7, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_140_8, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_140_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_140_10, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_140_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_140_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-12 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-12 12:00:00-05', created_at = '2026-03-12 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-12 12:00:00-05', created_at = '2026-03-12 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ROMERO NINAHUAMAN JAVIER JOHNNY (Puesto: 3, ID: 142)
    -- =========================================================================
    DECLARE
        v_socio_142 bigint := 142;
        v_puesto_142 bigint := 15;
        v_m_id_142_0 bigint;
        v_m_id_142_1 bigint;
        v_m_id_142_2 bigint;
        v_m_id_142_3 bigint;
        v_m_id_142_4 bigint;
        v_m_id_142_5 bigint;
        v_m_id_142_6 bigint;
        v_m_id_142_7 bigint;
        v_m_id_142_8 bigint;
        v_m_id_142_9 bigint;
        v_m_id_142_10 bigint;
        v_m_id_142_11 bigint;
        v_m_id_142_12 bigint;
        v_m_id_142_13 bigint;
        v_m_id_142_14 bigint;
        v_m_id_142_15 bigint;
        v_m_id_142_16 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_142 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_142 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_142;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_142 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_142;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_142, 1, 2025, 11, 60.40, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_142_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_142, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_142_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_142, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_142_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_142, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_142_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_142, 1, 2025, 12, 61.30, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_142_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_142, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_142_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_142, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_142_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_142, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_142_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_142, 1, 2026, 1, 59.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_142_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_142, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_142_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_142, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_142_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_142, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_142_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_142, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_142_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_142, 1, 2026, 2, 58.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_142_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_142, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_142_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_142, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_142_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_142, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_142_16;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_142,
            v_socio_142,
            NULL,
            198.30,
            'Efectivo',
            '32518',
            'Pago histórico recibo N° 32518',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_142_0, 'monto_aplicado', 60.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_142_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_142_4, 'monto_aplicado', 61.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_142_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_142_8, 'monto_aplicado', 59.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_142_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-17 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-17 12:00:00-05', created_at = '2026-02-17 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-17 12:00:00-05', created_at = '2026-02-17 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_142,
            v_socio_142,
            NULL,
            353.00,
            'Efectivo',
            '32797',
            'Pago histórico recibo N° 32797',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_142_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_142_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_142_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_142_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_142_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_142_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_142_12, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_142_13, 'monto_aplicado', 58.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_142_14, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_142_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_142_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ROMERO YSLA ESTEBAN LIDIO (Puesto: 156, ID: 143)
    -- =========================================================================
    DECLARE
        v_socio_143 bigint := 143;
        v_puesto_143 bigint := 251;
        v_m_id_143_0 bigint;
        v_m_id_143_1 bigint;
        v_m_id_143_2 bigint;
        v_m_id_143_3 bigint;
        v_m_id_143_4 bigint;
        v_m_id_143_5 bigint;
        v_m_id_143_6 bigint;
        v_m_id_143_7 bigint;
        v_m_id_143_8 bigint;
        v_m_id_143_9 bigint;
        v_m_id_143_10 bigint;
        v_m_id_143_11 bigint;
        v_m_id_143_12 bigint;
        v_m_id_143_13 bigint;
        v_m_id_143_14 bigint;
        v_m_id_143_15 bigint;
        v_m_id_143_16 bigint;
        v_m_id_143_17 bigint;
        v_m_id_143_18 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_143 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_143 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_143;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_143 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_143;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 1, 2025, 11, 299.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_143_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 2, 2025, 11, 29.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_143_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 1, 2025, 12, 314.80, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_143_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 2, 2025, 12, 28.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_143_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_143_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_143_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 1, 2026, 1, 322.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_143_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 2, 2026, 1, 34.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_143_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_143_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_143_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_143_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 1, 2026, 2, 300.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_143_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 2, 2026, 2, 27.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_143_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_143_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_143_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 1, 2026, 3, 281.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_143_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 2, 2026, 3, 30.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_143_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_143_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_143, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_143_18;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_143,
            v_socio_143,
            NULL,
            328.70,
            'Efectivo',
            '32306',
            'Pago histórico recibo N° 32306',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_143_0, 'monto_aplicado', 299.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_143_1, 'monto_aplicado', 29.60, 'cubierto_completo', true)),
            0.00,
            '2026-01-12 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-12 12:00:00-05', created_at = '2026-01-12 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-12 12:00:00-05', created_at = '2026-01-12 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_143,
            v_socio_143,
            NULL,
            343.40,
            'Efectivo',
            '32490',
            'Pago histórico recibo N° 32490',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_143_2, 'monto_aplicado', 314.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_143_3, 'monto_aplicado', 28.60, 'cubierto_completo', true)),
            0.00,
            '2026-02-10 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-10 12:00:00-05', created_at = '2026-02-10 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-10 12:00:00-05', created_at = '2026-02-10 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_143,
            v_socio_143,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_143_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_143_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_143,
            v_socio_143,
            NULL,
            694.60,
            'Efectivo',
            '32752',
            'Pago histórico recibo N° 32752',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_143_6, 'monto_aplicado', 322.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_143_7, 'monto_aplicado', 34.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_143_8, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_143_11, 'monto_aplicado', 300.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_143_12, 'monto_aplicado', 27.20, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_143,
            v_socio_143,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_143_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_143_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_143,
            v_socio_143,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_143_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_143_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_143,
            v_socio_143,
            NULL,
            311.30,
            'Efectivo',
            '33025',
            'Pago histórico recibo N° 33025',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_143_15, 'monto_aplicado', 281.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_143_16, 'monto_aplicado', 30.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_143,
            v_socio_143,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_143_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_143_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: SAAVEDRA CURIPUMA LUIS HUMBERTO (Puesto: 43, ID: 144)
    -- =========================================================================
    DECLARE
        v_socio_144 bigint := 144;
        v_puesto_144 bigint := 120;
        v_m_id_144_0 bigint;
        v_m_id_144_1 bigint;
        v_m_id_144_2 bigint;
        v_m_id_144_3 bigint;
        v_m_id_144_4 bigint;
        v_m_id_144_5 bigint;
        v_m_id_144_6 bigint;
        v_m_id_144_7 bigint;
        v_m_id_144_8 bigint;
        v_m_id_144_9 bigint;
        v_m_id_144_10 bigint;
        v_m_id_144_11 bigint;
        v_m_id_144_12 bigint;
        v_m_id_144_13 bigint;
        v_m_id_144_14 bigint;
        v_m_id_144_15 bigint;
        v_m_id_144_16 bigint;
        v_m_id_144_17 bigint;
        v_m_id_144_18 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_144 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_144 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_144;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_144 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_144;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 18, 2026, 8, 15.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - TALONARIO SANTA ROSA', v_user_uuid)
        RETURNING id INTO v_m_id_144_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 1, 2025, 11, 49.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_144_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_144_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 3, 2025, 11, 52.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_144_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_144_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 3, 2025, 12, 52.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_144_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_144_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 1, 2025, 12, 50.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_144_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_144_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 3, 2026, 1, 108.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_144_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 1, 2026, 1, 97.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_144_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 2, 2026, 1, 15.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_144_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 4, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_144_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 3, 2026, 2, 8.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_144_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_144_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 1, 2026, 3, 50.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_144_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_144_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_144_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_144, 3, 2026, 4, 8.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_144_18;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_144,
            v_socio_144,
            NULL,
            184.90,
            'Efectivo',
            '32290',
            'Pago histórico recibo N° 32290',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_144_0, 'monto_aplicado', 15.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_144_1, 'monto_aplicado', 49.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_144_2, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_144_3, 'monto_aplicado', 52.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_144_4, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_144_5, 'monto_aplicado', 52.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_144_6, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-06 12:00:00-05', created_at = '2026-01-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-06 12:00:00-05', created_at = '2026-01-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_144,
            v_socio_144,
            NULL,
            218.80,
            'Efectivo',
            '32652',
            'Pago histórico recibo N° 32652',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_144_7, 'monto_aplicado', 50.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_144_8, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_144_10, 'monto_aplicado', 49.20, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_144_11, 'monto_aplicado', 5.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_144_9, 'monto_aplicado', 50.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_144_12, 'monto_aplicado', 5.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_144_9, 'monto_aplicado', 48.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_144_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_144,
            v_socio_144,
            NULL,
            10.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_144_9, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_144,
            v_socio_144,
            NULL,
            8.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_144_13, 'monto_aplicado', 8.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_144,
            v_socio_144,
            NULL,
            58.50,
            'Efectivo',
            '32833',
            'Pago histórico recibo N° 32833',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_144_10, 'monto_aplicado', 48.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_144_11, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_144,
            v_socio_144,
            NULL,
            8.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_144_14, 'monto_aplicado', 8.00, 'cubierto_completo', false)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_144,
            v_socio_144,
            NULL,
            113.50,
            'Efectivo',
            '32985',
            'Pago histórico recibo N° 32985',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_144_15, 'monto_aplicado', 50.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_144_16, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_144_14, 'monto_aplicado', 52.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_144_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-29 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_144,
            v_socio_144,
            NULL,
            8.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_144_18, 'monto_aplicado', 8.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: SALAS MONTALVO RUTH YOVANNA (Puesto: 6, ID: 146)
    -- =========================================================================
    DECLARE
        v_socio_146 bigint := 146;
        v_puesto_146 bigint := 36;
        v_m_id_146_0 bigint;
        v_m_id_146_1 bigint;
        v_m_id_146_2 bigint;
        v_m_id_146_3 bigint;
        v_m_id_146_4 bigint;
        v_m_id_146_5 bigint;
        v_m_id_146_6 bigint;
        v_m_id_146_7 bigint;
        v_m_id_146_8 bigint;
        v_m_id_146_9 bigint;
        v_m_id_146_10 bigint;
        v_m_id_146_11 bigint;
        v_m_id_146_12 bigint;
        v_m_id_146_13 bigint;
        v_m_id_146_14 bigint;
        v_m_id_146_15 bigint;
        v_m_id_146_16 bigint;
        v_m_id_146_17 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_146 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_146 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_146;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_146 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_146;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 1, 2025, 11, 66.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_146_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_146_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_146_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_146_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 1, 2025, 12, 67.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_146_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_146_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_146_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_146_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 1, 2026, 1, 65.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_146_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_146_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_146_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_146_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_146_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_146_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 1, 2026, 2, 64.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_146_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_146_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_146_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_146, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_146_17;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_146,
            v_socio_146,
            NULL,
            216.60,
            'Efectivo',
            '32519',
            'Pago histórico recibo N° 32519',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_146_0, 'monto_aplicado', 66.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_146_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_146_4, 'monto_aplicado', 67.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_146_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_146_8, 'monto_aplicado', 65.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_146_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-17 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-17 12:00:00-05', created_at = '2026-02-17 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-17 12:00:00-05', created_at = '2026-02-17 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_146,
            v_socio_146,
            NULL,
            330.60,
            'Efectivo',
            '32794',
            'Pago histórico recibo N° 32794',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_146_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_146_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_146_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_146_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_146_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_146_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_146_14, 'monto_aplicado', 64.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_146_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_146_16, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_146_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_146,
            v_socio_146,
            NULL,
            10.00,
            'Efectivo',
            '32566',
            'Pago histórico recibo N° 32566',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_146_10, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-24 12:00:00-05', created_at = '2026-02-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-24 12:00:00-05', created_at = '2026-02-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_146,
            v_socio_146,
            NULL,
            28.30,
            'Efectivo',
            '32901',
            'Pago histórico recibo N° 32901',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_146_13, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: SALAZAR CONCEPCION VICTORIA (Puesto: 102, ID: 147)
    -- =========================================================================
    DECLARE
        v_socio_147 bigint := 147;
        v_puesto_147 bigint := 197;
        v_m_id_147_0 bigint;
        v_m_id_147_1 bigint;
        v_m_id_147_2 bigint;
        v_m_id_147_3 bigint;
        v_m_id_147_4 bigint;
        v_m_id_147_5 bigint;
        v_m_id_147_6 bigint;
        v_m_id_147_7 bigint;
        v_m_id_147_8 bigint;
        v_m_id_147_9 bigint;
        v_m_id_147_10 bigint;
        v_m_id_147_11 bigint;
        v_m_id_147_12 bigint;
        v_m_id_147_13 bigint;
        v_m_id_147_14 bigint;
        v_m_id_147_15 bigint;
        v_m_id_147_16 bigint;
        v_m_id_147_17 bigint;
        v_m_id_147_18 bigint;
        v_m_id_147_19 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_147 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_147 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_147;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_147 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_147;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 1, 2025, 11, 16.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_147_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_147_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_147_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_147_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 1, 2025, 12, 14.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_147_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_147_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_147_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_147_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 1, 2026, 1, 13.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_147_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_147_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_147_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_147_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 1, 2026, 2, 12.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_147_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_147_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_147_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_147_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 1, 2026, 3, 11.90, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_147_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_147_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_147_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_147, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_147_19;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_147,
            v_socio_147,
            NULL,
            22.60,
            'Efectivo',
            '32311',
            'Pago histórico recibo N° 32311',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_147_0, 'monto_aplicado', 16.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_147_1, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-12 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-12 12:00:00-05', created_at = '2026-01-12 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-12 12:00:00-05', created_at = '2026-01-12 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_147,
            v_socio_147,
            NULL,
            65.00,
            'Efectivo',
            '32312',
            'Pago histórico recibo N° 32312',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_147_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_147_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-12 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-12 12:00:00-05', created_at = '2026-01-12 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-12 12:00:00-05', created_at = '2026-01-12 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_147,
            v_socio_147,
            NULL,
            20.60,
            'Efectivo',
            '32507',
            'Pago histórico recibo N° 32507',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_147_4, 'monto_aplicado', 14.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_147_5, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_147,
            v_socio_147,
            NULL,
            65.00,
            'Efectivo',
            '32508',
            'Pago histórico recibo N° 32508',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_147_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_147_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_147,
            v_socio_147,
            NULL,
            18.90,
            'Efectivo',
            '32666',
            'Pago histórico recibo N° 32666',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_147_8, 'monto_aplicado', 13.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_147_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-12 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-12 12:00:00-05', created_at = '2026-03-12 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-12 12:00:00-05', created_at = '2026-03-12 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_147,
            v_socio_147,
            NULL,
            61.00,
            'Efectivo',
            '32667',
            'Pago histórico recibo N° 32667',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_147_10, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_147_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-12 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-12 12:00:00-05', created_at = '2026-03-12 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-12 12:00:00-05', created_at = '2026-03-12 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_147,
            v_socio_147,
            NULL,
            22.30,
            'Efectivo',
            '32723',
            'Pago histórico recibo N° 32723',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_147_12, 'monto_aplicado', 12.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_147_13, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_147,
            v_socio_147,
            NULL,
            65.00,
            'Efectivo',
            '32945',
            'Pago histórico recibo N° 32945',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_147_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_147_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-16 12:00:00-05', created_at = '2026-04-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-16 12:00:00-05', created_at = '2026-04-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_147,
            v_socio_147,
            NULL,
            17.90,
            'Efectivo',
            '33010',
            'Pago histórico recibo N° 33010',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_147_16, 'monto_aplicado', 11.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_147_17, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_147,
            v_socio_147,
            NULL,
            65.00,
            'Efectivo',
            '33011',
            'Pago histórico recibo N° 33011',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_147_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_147_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: SALVATIERRA OQUENDO ALLISON ADRIANA (Puesto: 148, ID: 148)
    -- =========================================================================
    DECLARE
        v_socio_148 bigint := 148;
        v_puesto_148 bigint := 243;
        v_m_id_148_0 bigint;
        v_m_id_148_1 bigint;
        v_m_id_148_2 bigint;
        v_m_id_148_3 bigint;
        v_m_id_148_4 bigint;
        v_m_id_148_5 bigint;
        v_m_id_148_6 bigint;
        v_m_id_148_7 bigint;
        v_m_id_148_8 bigint;
        v_m_id_148_9 bigint;
        v_m_id_148_10 bigint;
        v_m_id_148_11 bigint;
        v_m_id_148_12 bigint;
        v_m_id_148_13 bigint;
        v_m_id_148_14 bigint;
        v_m_id_148_15 bigint;
        v_m_id_148_16 bigint;
        v_m_id_148_17 bigint;
        v_m_id_148_18 bigint;
        v_m_id_148_19 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_148 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_148 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_148;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_148 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_148;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 1, 2025, 11, 78.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_148_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 2, 2025, 11, 173.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_148_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 1, 2025, 12, 77.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_148_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 2, 2025, 12, 155.30, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_148_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_148_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_148_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 1, 2026, 1, 77.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_148_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 2, 2026, 1, 201.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_148_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_148_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_148_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_148_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_148_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 1, 2026, 2, 76.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_148_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 2, 2026, 2, 224.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_148_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_148_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_148_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 1, 2026, 3, 72.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_148_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 2, 2026, 3, 238.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_148_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_148_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_148, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_148_19;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_148,
            v_socio_148,
            NULL,
            484.90,
            'Efectivo',
            '32409',
            'Pago histórico recibo N° 32409',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_148_0, 'monto_aplicado', 78.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_148_1, 'monto_aplicado', 173.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_148_2, 'monto_aplicado', 77.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_148_3, 'monto_aplicado', 155.30, 'cubierto_completo', true)),
            0.00,
            '2026-01-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_148,
            v_socio_148,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_148_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_148_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_148,
            v_socio_148,
            NULL,
            307.40,
            'Efectivo',
            '32549',
            'Pago histórico recibo N° 32549',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_148_6, 'monto_aplicado', 77.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_148_7, 'monto_aplicado', 201.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_148_8, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-02-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_148,
            v_socio_148,
            NULL,
            311.60,
            'Efectivo',
            '32868',
            'Pago histórico recibo N° 32868',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_148_9, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_148_12, 'monto_aplicado', 76.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_148_13, 'monto_aplicado', 224.90, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_148,
            v_socio_148,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_148_10, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_148_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_148,
            v_socio_148,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_148_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_148_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_148,
            v_socio_148,
            NULL,
            310.10,
            'Efectivo',
            '33056',
            'Pago histórico recibo N° 33056',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_148_16, 'monto_aplicado', 72.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_148_17, 'monto_aplicado', 238.10, 'cubierto_completo', true)),
            0.00,
            '2026-05-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_148,
            v_socio_148,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_148_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_148_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: SANCHEZ RODRIGUEZ JUDITH IRIS (Puesto: 190, ID: 150)
    -- =========================================================================
    DECLARE
        v_socio_150 bigint := 150;
        v_puesto_150 bigint := 284;
        v_m_id_150_0 bigint;
        v_m_id_150_1 bigint;
        v_m_id_150_2 bigint;
        v_m_id_150_3 bigint;
        v_m_id_150_4 bigint;
        v_m_id_150_5 bigint;
        v_m_id_150_6 bigint;
        v_m_id_150_7 bigint;
        v_m_id_150_8 bigint;
        v_m_id_150_9 bigint;
        v_m_id_150_10 bigint;
        v_m_id_150_11 bigint;
        v_m_id_150_12 bigint;
        v_m_id_150_13 bigint;
        v_m_id_150_14 bigint;
        v_m_id_150_15 bigint;
        v_m_id_150_16 bigint;
        v_m_id_150_17 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_150 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_150 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_150;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_150 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_150;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 1, 2025, 11, 53.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_150_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 2, 2025, 11, 11.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_150_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_150_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_150_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 1, 2025, 12, 18.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_150_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 2, 2025, 12, 70.10, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_150_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_150_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_150_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 1, 2026, 1, 42.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_150_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 2, 2026, 1, 48.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_150_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_150_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_150_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_150_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_150_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_150_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_150_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 1, 2026, 2, 87.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_150_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_150, 2, 2026, 2, 48.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_150_17;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_150,
            v_socio_150,
            NULL,
            387.10,
            'Efectivo',
            '32562',
            'Pago histórico recibo N° 32562',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_150_0, 'monto_aplicado', 53.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_150_1, 'monto_aplicado', 11.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_150_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_150_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_150_4, 'monto_aplicado', 18.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_150_5, 'monto_aplicado', 70.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_150_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_150_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_150_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_150_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_150_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_150_13, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-02-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-24 12:00:00-05', created_at = '2026-02-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-24 12:00:00-05', created_at = '2026-02-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_150,
            v_socio_150,
            NULL,
            90.90,
            'Efectivo',
            '32546',
            'Pago histórico recibo N° 32546',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_150_8, 'monto_aplicado', 42.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_150_9, 'monto_aplicado', 48.60, 'cubierto_completo', true)),
            0.00,
            '2026-02-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-21 12:00:00-05', created_at = '2026-02-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-21 12:00:00-05', created_at = '2026-02-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_150,
            v_socio_150,
            NULL,
            61.00,
            'Efectivo',
            '32717',
            'Pago histórico recibo N° 32717',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_150_14, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_150_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_150,
            v_socio_150,
            NULL,
            135.60,
            'Efectivo',
            '32745',
            'Pago histórico recibo N° 32745',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_150_16, 'monto_aplicado', 87.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_150_17, 'monto_aplicado', 48.50, 'cubierto_completo', true)),
            0.00,
            '2026-03-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: SANCHEZ ASTO DE TORRES YOLANDA SOFIA TERESA (Puesto: 36, ID: 149)
    -- =========================================================================
    DECLARE
        v_socio_149 bigint := 149;
        v_puesto_149 bigint := 107;
        v_m_id_149_0 bigint;
        v_m_id_149_1 bigint;
        v_m_id_149_2 bigint;
        v_m_id_149_3 bigint;
        v_m_id_149_4 bigint;
        v_m_id_149_5 bigint;
        v_m_id_149_6 bigint;
        v_m_id_149_7 bigint;
        v_m_id_149_8 bigint;
        v_m_id_149_9 bigint;
        v_m_id_149_10 bigint;
        v_m_id_149_11 bigint;
        v_m_id_149_12 bigint;
        v_m_id_149_13 bigint;
        v_m_id_149_14 bigint;
        v_m_id_149_15 bigint;
        v_m_id_149_16 bigint;
        v_m_id_149_17 bigint;
        v_m_id_149_18 bigint;
        v_m_id_149_19 bigint;
        v_m_id_149_20 bigint;
        v_m_id_149_21 bigint;
        v_m_id_149_22 bigint;
        v_m_id_149_23 bigint;
        v_m_id_149_24 bigint;
        v_m_id_149_25 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_149 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_149 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_149;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_149 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_149;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 1, 2025, 11, 55.40, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_149_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_149_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_149_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_149_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 1, 2025, 12, 56.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_149_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_149_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_149_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_149_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 1, 2026, 1, 54.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_149_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_149_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_149_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_149_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_149_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_149_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 1, 2026, 2, 53.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_149_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_149_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_149_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_149_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 1, 2026, 3, 56.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_149_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_149_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_149_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_149_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 1, 2026, 4, 51.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_149_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_149_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_149_24;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_149, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_149_25;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_149,
            v_socio_149,
            NULL,
            253.60,
            'Efectivo',
            '32346',
            'Pago histórico recibo N° 32346',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_149_0, 'monto_aplicado', 55.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_4, 'monto_aplicado', 56.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-15 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_149,
            v_socio_149,
            NULL,
            163.00,
            'Efectivo',
            '32618',
            'Pago histórico recibo N° 32618',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_149_8, 'monto_aplicado', 54.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_13, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_149,
            v_socio_149,
            NULL,
            124.90,
            'Efectivo',
            '32765',
            'Pago histórico recibo N° 32765',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_149_14, 'monto_aplicado', 53.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_16, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_149,
            v_socio_149,
            NULL,
            127.10,
            'Efectivo',
            '33043',
            'Pago histórico recibo N° 33043',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_149_18, 'monto_aplicado', 56.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_19, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_149,
            v_socio_149,
            NULL,
            122.00,
            'Efectivo',
            '33125',
            'Pago histórico recibo N° 33125',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_149_22, 'monto_aplicado', 51.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_23, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_24, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_149_25, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: SANCHEZ SOTO LUCIA YRENE (Puesto: 65, ID: 151)
    -- =========================================================================
    DECLARE
        v_socio_151 bigint := 151;
        v_puesto_151 bigint := 162;
        v_m_id_151_0 bigint;
        v_m_id_151_1 bigint;
        v_m_id_151_2 bigint;
        v_m_id_151_3 bigint;
        v_m_id_151_4 bigint;
        v_m_id_151_5 bigint;
        v_m_id_151_6 bigint;
        v_m_id_151_7 bigint;
        v_m_id_151_8 bigint;
        v_m_id_151_9 bigint;
        v_m_id_151_10 bigint;
        v_m_id_151_11 bigint;
        v_m_id_151_12 bigint;
        v_m_id_151_13 bigint;
        v_m_id_151_14 bigint;
        v_m_id_151_15 bigint;
        v_m_id_151_16 bigint;
        v_m_id_151_17 bigint;
        v_m_id_151_18 bigint;
        v_m_id_151_19 bigint;
        v_m_id_151_20 bigint;
        v_m_id_151_21 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_151 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_151 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_151;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_151 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_151;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 18, 2026, 8, 15.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - TALONARIO SANTA ROSA', v_user_uuid)
        RETURNING id INTO v_m_id_151_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 1, 2025, 11, 25.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_151_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_151_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_151_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_151_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 1, 2025, 12, 25.30, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_151_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_151_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_151_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_151_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 1, 2026, 1, 24.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_151_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_151_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_151_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_151_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_151_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 1, 2026, 2, 24.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_151_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_151_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_151_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_151_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 1, 2026, 3, 25.60, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_151_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_151_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_151_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_151, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_151_21;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_151,
            v_socio_151,
            NULL,
            214.80,
            'Efectivo',
            '32839',
            'Pago histórico recibo N° 32839',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_151_0, 'monto_aplicado', 15.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_9, 'monto_aplicado', 24.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_10, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_13, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_14, 'monto_aplicado', 24.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_16, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_151,
            v_socio_151,
            NULL,
            192.30,
            'Efectivo',
            '32488',
            'Pago histórico recibo N° 32488',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_151_1, 'monto_aplicado', 25.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_2, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_3, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_4, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_5, 'monto_aplicado', 25.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_6, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_7, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_8, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-10 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-10 12:00:00-05', created_at = '2026-02-10 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-10 12:00:00-05', created_at = '2026-02-10 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_151,
            v_socio_151,
            NULL,
            96.60,
            'Efectivo',
            '32987',
            'Pago histórico recibo N° 32987',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_151_18, 'monto_aplicado', 25.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_19, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_151_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-29 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: SANTILLAN MESIA ZOILA MARIBEL (Puesto: 124, ID: 152)
    -- =========================================================================
    DECLARE
        v_socio_152 bigint := 152;
        v_puesto_152 bigint := 219;
        v_m_id_152_0 bigint;
        v_m_id_152_1 bigint;
        v_m_id_152_2 bigint;
        v_m_id_152_3 bigint;
        v_m_id_152_4 bigint;
        v_m_id_152_5 bigint;
        v_m_id_152_6 bigint;
        v_m_id_152_7 bigint;
        v_m_id_152_8 bigint;
        v_m_id_152_9 bigint;
        v_m_id_152_10 bigint;
        v_m_id_152_11 bigint;
        v_m_id_152_12 bigint;
        v_m_id_152_13 bigint;
        v_m_id_152_14 bigint;
        v_m_id_152_15 bigint;
        v_m_id_152_16 bigint;
        v_m_id_152_17 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_152 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_152 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_152;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_152 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_152;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 1, 2025, 11, 33.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_152_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_152_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 3, 2025, 11, 50.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_152_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_152_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 1, 2025, 12, 34.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_152_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_152_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 3, 2025, 12, 25.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_152_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_152_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_152_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_152_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 1, 2026, 1, 46.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_152_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_152_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_152_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_152_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 1, 2026, 2, 52.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_152_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_152_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 3, 2026, 3, 20.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_152_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_152, 3, 2026, 4, 35.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_152_17;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_152,
            v_socio_152,
            NULL,
            80.50,
            'Efectivo',
            '32529',
            'Pago histórico recibo N° 32529',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_152_0, 'monto_aplicado', 33.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_152_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_152_4, 'monto_aplicado', 34.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_152_5, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_152,
            v_socio_152,
            NULL,
            141.00,
            'Efectivo',
            '32720',
            'Pago histórico recibo N° 32720',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_152_2, 'monto_aplicado', 50.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_152_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_152_6, 'monto_aplicado', 25.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_152_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_152_8, 'monto_aplicado', 20.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_152_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_152_12, 'monto_aplicado', 26.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_152_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_152,
            v_socio_152,
            NULL,
            40.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_152_8, 'monto_aplicado', 40.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_152,
            v_socio_152,
            NULL,
            114.00,
            'Efectivo',
            '32817',
            'Pago histórico recibo N° 32817',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_152_10, 'monto_aplicado', 46.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_152_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_152_14, 'monto_aplicado', 52.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_152_15, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_152,
            v_socio_152,
            NULL,
            30.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_152_12, 'monto_aplicado', 30.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_152,
            v_socio_152,
            NULL,
            20.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_152_16, 'monto_aplicado', 20.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_152,
            v_socio_152,
            NULL,
            35.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_152_17, 'monto_aplicado', 35.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: SEGOVIA VILLAFUERTE DE PONCE JUSTINA (Puesto: 34, ID: 153)
    -- =========================================================================
    DECLARE
        v_socio_153 bigint := 153;
        v_puesto_153 bigint := 104;
        v_m_id_153_0 bigint;
        v_m_id_153_1 bigint;
        v_m_id_153_2 bigint;
        v_m_id_153_3 bigint;
        v_m_id_153_4 bigint;
        v_m_id_153_5 bigint;
        v_m_id_153_6 bigint;
        v_m_id_153_7 bigint;
        v_m_id_153_8 bigint;
        v_m_id_153_9 bigint;
        v_m_id_153_10 bigint;
        v_m_id_153_11 bigint;
        v_m_id_153_12 bigint;
        v_m_id_153_13 bigint;
        v_m_id_153_14 bigint;
        v_m_id_153_15 bigint;
        v_m_id_153_16 bigint;
        v_m_id_153_17 bigint;
        v_m_id_153_18 bigint;
        v_m_id_153_19 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_153 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_153 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_153;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_153 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_153;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 1, 2025, 11, 29.40, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_153_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_153_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_153_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_153_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 1, 2025, 12, 29.80, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_153_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_153_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_153_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_153_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_153_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 1, 2026, 1, 29.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_153_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_153_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_153_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 1, 2026, 2, 28.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_153_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_153_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_153_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_153_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_153_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_153_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_153_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_153, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_153_19;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_153,
            v_socio_153,
            NULL,
            210.00,
            'Efectivo',
            '32858',
            'Pago histórico recibo N° 32858',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_153_0, 'monto_aplicado', 29.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_153_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_153_4, 'monto_aplicado', 29.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_153_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_153_9, 'monto_aplicado', 29.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_153_10, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_153_11, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_153_12, 'monto_aplicado', 28.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_153_13, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_153_14, 'monto_aplicado', 38.00, 'cubierto_completo', false)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_153,
            v_socio_153,
            NULL,
            65.00,
            'Efectivo',
            '32324',
            'Pago histórico recibo N° 32324',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_153_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_153_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_153,
            v_socio_153,
            NULL,
            75.00,
            'Efectivo',
            '32477',
            'Pago histórico recibo N° 32477',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_153_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_153_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_153_8, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-06 12:00:00-05', created_at = '2026-02-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-06 12:00:00-05', created_at = '2026-02-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_153,
            v_socio_153,
            NULL,
            23.00,
            'Efectivo',
            '32859',
            'Pago histórico recibo N° 32859',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_153_14, 'monto_aplicado', 18.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_153_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_153,
            v_socio_153,
            NULL,
            130.00,
            'Efectivo',
            '33055',
            'Pago histórico recibo N° 33055',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_153_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_153_17, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_153_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_153_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: SERMENO GUTIERREZ JAVIER YGNACIO (Puesto: 20, ID: 154)
    -- =========================================================================
    DECLARE
        v_socio_154 bigint := 154;
        v_puesto_154 bigint := 76;
        v_m_id_154_0 bigint;
        v_m_id_154_1 bigint;
        v_m_id_154_2 bigint;
        v_m_id_154_3 bigint;
        v_m_id_154_4 bigint;
        v_m_id_154_5 bigint;
        v_m_id_154_6 bigint;
        v_m_id_154_7 bigint;
        v_m_id_154_8 bigint;
        v_m_id_154_9 bigint;
        v_m_id_154_10 bigint;
        v_m_id_154_11 bigint;
        v_m_id_154_12 bigint;
        v_m_id_154_13 bigint;
        v_m_id_154_14 bigint;
        v_m_id_154_15 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_154 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_154 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_154;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_154 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_154;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_154, 1, 2025, 12, 299.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_154_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_154, 2, 2025, 12, 15.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_154_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_154, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_154_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_154, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_154_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_154, 1, 2026, 1, 291.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_154_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_154, 2, 2026, 1, 13.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_154_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_154, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_154_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_154, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_154_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_154, 1, 2026, 2, 287.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_154_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_154, 2, 2026, 2, 13.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_154_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_154, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_154_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_154, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_154_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_154, 1, 2026, 3, 296.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_154_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_154, 2, 2026, 3, 15.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_154_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_154, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_154_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_154, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_154_15;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_154,
            v_socio_154,
            NULL,
            314.90,
            'Efectivo',
            '32505',
            'Pago histórico recibo N° 32505',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_154_0, 'monto_aplicado', 299.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_154_1, 'monto_aplicado', 15.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_154,
            v_socio_154,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_154_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_154_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_154,
            v_socio_154,
            NULL,
            304.50,
            'Efectivo',
            '32674',
            'Pago histórico recibo N° 32674',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_154_4, 'monto_aplicado', 291.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_154_5, 'monto_aplicado', 13.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-16 12:00:00-05', created_at = '2026-03-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-16 12:00:00-05', created_at = '2026-03-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_154,
            v_socio_154,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_154_6, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_154_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_154,
            v_socio_154,
            NULL,
            300.20,
            'Efectivo',
            '32746',
            'Pago histórico recibo N° 32746',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_154_8, 'monto_aplicado', 287.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_154_9, 'monto_aplicado', 13.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_154,
            v_socio_154,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_154_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_154_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_154,
            v_socio_154,
            NULL,
            311.30,
            'Efectivo',
            '33083',
            'Pago histórico recibo N° 33083',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_154_12, 'monto_aplicado', 296.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_154_13, 'monto_aplicado', 15.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-18 12:00:00-05', created_at = '2026-05-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-18 12:00:00-05', created_at = '2026-05-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_154,
            v_socio_154,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_154_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_154_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: SORIA TAPIA EDITH CATALINA (Puesto: 68, ID: 155)
    -- =========================================================================
    DECLARE
        v_socio_155 bigint := 155;
        v_puesto_155 bigint := 165;
        v_m_id_155_0 bigint;
        v_m_id_155_1 bigint;
        v_m_id_155_2 bigint;
        v_m_id_155_3 bigint;
        v_m_id_155_4 bigint;
        v_m_id_155_5 bigint;
        v_m_id_155_6 bigint;
        v_m_id_155_7 bigint;
        v_m_id_155_8 bigint;
        v_m_id_155_9 bigint;
        v_m_id_155_10 bigint;
        v_m_id_155_11 bigint;
        v_m_id_155_12 bigint;
        v_m_id_155_13 bigint;
        v_m_id_155_14 bigint;
        v_m_id_155_15 bigint;
        v_m_id_155_16 bigint;
        v_m_id_155_17 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_155 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_155 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_155;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_155 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_155;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 1, 2025, 12, 32.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_155_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_155_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_155_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_155_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 1, 2026, 1, 32.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_155_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_155_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_155_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_155_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_155_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_155_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 1, 2026, 2, 31.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_155_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_155_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_155_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_155_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 1, 2026, 3, 33.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_155_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_155_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_155_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_155, 4, 2026, 3, 0.90, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_155_17;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_155,
            v_socio_155,
            NULL,
            205.90,
            'Efectivo',
            '32522',
            'Pago histórico recibo N° 32522',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_155_0, 'monto_aplicado', 32.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_155_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_155_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_155_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_155_4, 'monto_aplicado', 32.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_155_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_155_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_155_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-17 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-17 12:00:00-05', created_at = '2026-02-17 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-17 12:00:00-05', created_at = '2026-02-17 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_155,
            v_socio_155,
            NULL,
            10.00,
            'Efectivo',
            '32537',
            'Pago histórico recibo N° 32537',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_155_8, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_155,
            v_socio_155,
            NULL,
            130.80,
            'Efectivo',
            '32844',
            'Pago histórico recibo N° 32844',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_155_9, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_155_10, 'monto_aplicado', 31.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_155_11, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_155_12, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_155_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_155,
            v_socio_155,
            NULL,
            100.00,
            'Efectivo',
            '33138',
            'Pago histórico recibo N° 33138',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_155_14, 'monto_aplicado', 33.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_155_15, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_155_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_155_17, 'monto_aplicado', 0.90, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: SOSA VALDIVIA JUANA ISABEL (Puesto: 4, ID: 156)
    -- =========================================================================
    DECLARE
        v_socio_156 bigint := 156;
        v_puesto_156 bigint := 22;
        v_m_id_156_0 bigint;
        v_m_id_156_1 bigint;
        v_m_id_156_2 bigint;
        v_m_id_156_3 bigint;
        v_m_id_156_4 bigint;
        v_m_id_156_5 bigint;
        v_m_id_156_6 bigint;
        v_m_id_156_7 bigint;
        v_m_id_156_8 bigint;
        v_m_id_156_9 bigint;
        v_m_id_156_10 bigint;
        v_m_id_156_11 bigint;
        v_m_id_156_12 bigint;
        v_m_id_156_13 bigint;
        v_m_id_156_14 bigint;
        v_m_id_156_15 bigint;
        v_m_id_156_16 bigint;
        v_m_id_156_17 bigint;
        v_m_id_156_18 bigint;
        v_m_id_156_19 bigint;
        v_m_id_156_20 bigint;
        v_m_id_156_21 bigint;
        v_m_id_156_22 bigint;
        v_m_id_156_23 bigint;
        v_m_id_156_24 bigint;
        v_m_id_156_25 bigint;
        v_m_id_156_26 bigint;
        v_m_id_156_27 bigint;
        v_m_id_156_28 bigint;
        v_m_id_156_29 bigint;
        v_m_id_156_30 bigint;
        v_m_id_156_31 bigint;
        v_m_id_156_32 bigint;
        v_m_id_156_33 bigint;
        v_m_id_156_34 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_156 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_156 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_156;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_156 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_156;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 2, 2026, 6, 4.00, 'Pendiente', 'Manual', '2026-06-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_156_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 1, 2026, 7, 57.70, 'Pendiente', 'Manual', '2026-07-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_156_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 2, 2026, 7, 4.00, 'Pendiente', 'Manual', '2026-07-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_156_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 1, 2026, 8, 57.70, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_156_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 2, 2026, 8, 8.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_156_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 1, 2026, 9, 53.50, 'Pendiente', 'Manual', '2026-09-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_156_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 2, 2026, 9, 4.00, 'Pendiente', 'Manual', '2026-09-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_156_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 1, 2026, 10, 52.70, 'Pendiente', 'Manual', '2026-10-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_156_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 2, 2026, 10, 7.00, 'Pendiente', 'Manual', '2026-10-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_156_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 1, 2025, 11, 51.80, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_156_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_156_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 1, 2025, 12, 37.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_156_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_156_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_156_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_156_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_156_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 1, 2026, 1, 36.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_156_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_156_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 18, 2026, 1, 35.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - CORTE DE LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_156_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_156_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_156_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 1, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_156_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_156_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_156_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_156_24;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 1, 2026, 3, 5.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_156_25;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_156_26;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 6, 2026, 3, 56.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - MULTA 26/03/26', v_user_uuid)
        RETURNING id INTO v_m_id_156_27;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_156_28;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_156_29;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', '2026-05-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_156_30;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', '2026-05-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_156_31;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 18, 2026, 5, 35.00, 'Pendiente', 'Manual', '2026-05-01', 'Migración de pagos 2026 - RECONEXION DE LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_156_32;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 3, 2026, 6, 60.00, 'Pendiente', 'Manual', '2026-06-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_156_33;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_156, 4, 2026, 6, 5.00, 'Pendiente', 'Manual', '2026-06-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_156_34;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_156,
            v_socio_156,
            NULL,
            323.00,
            'Efectivo',
            '33086',
            'Pago histórico recibo N° 33086',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_156_0, 'monto_aplicado', 4.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_1, 'monto_aplicado', 57.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_2, 'monto_aplicado', 4.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_3, 'monto_aplicado', 57.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_4, 'monto_aplicado', 8.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_5, 'monto_aplicado', 53.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_6, 'monto_aplicado', 4.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_7, 'monto_aplicado', 52.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_8, 'monto_aplicado', 7.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_9, 'monto_aplicado', 51.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_10, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_11, 'monto_aplicado', 16.60, 'cubierto_completo', false)),
            0.00,
            '2026-05-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-18 12:00:00-05', created_at = '2026-05-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-18 12:00:00-05', created_at = '2026-05-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_156,
            v_socio_156,
            NULL,
            95.00,
            'Efectivo',
            '33087',
            'Pago histórico recibo N° 33087',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_156_11, 'monto_aplicado', 20.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_12, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_16, 'monto_aplicado', 36.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_17, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_21, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_22, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_25, 'monto_aplicado', 5.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_26, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-18 12:00:00-05', created_at = '2026-05-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-18 12:00:00-05', created_at = '2026-05-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_156,
            v_socio_156,
            NULL,
            266.00,
            'Efectivo',
            '32940',
            'Pago histórico recibo N° 32940',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_156_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_14, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_19, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_20, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_23, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_24, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_28, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_29, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-10 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-10 12:00:00-05', created_at = '2026-04-10 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-10 12:00:00-05', created_at = '2026-04-10 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_156,
            v_socio_156,
            NULL,
            70.00,
            'Efectivo',
            '33107',
            'Pago histórico recibo N° 33107',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_156_18, 'monto_aplicado', 35.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_32, 'monto_aplicado', 35.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_156,
            v_socio_156,
            NULL,
            56.50,
            'Efectivo',
            '33141',
            'Pago histórico recibo N° 33141',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_156_27, 'monto_aplicado', 56.50, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_156,
            v_socio_156,
            NULL,
            130.00,
            'Efectivo',
            '32941',
            'Pago histórico recibo N° 32941',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_156_30, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_31, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_33, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_156_34, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-10 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-10 12:00:00-05', created_at = '2026-04-10 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-10 12:00:00-05', created_at = '2026-04-10 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: SOTO GALLEGO DE VALERO SOFIA (Puesto: 85, ID: 157)
    -- =========================================================================
    DECLARE
        v_socio_157 bigint := 157;
        v_puesto_157 bigint := 181;
        v_m_id_157_0 bigint;
        v_m_id_157_1 bigint;
        v_m_id_157_2 bigint;
        v_m_id_157_3 bigint;
        v_m_id_157_4 bigint;
        v_m_id_157_5 bigint;
        v_m_id_157_6 bigint;
        v_m_id_157_7 bigint;
        v_m_id_157_8 bigint;
        v_m_id_157_9 bigint;
        v_m_id_157_10 bigint;
        v_m_id_157_11 bigint;
        v_m_id_157_12 bigint;
        v_m_id_157_13 bigint;
        v_m_id_157_14 bigint;
        v_m_id_157_15 bigint;
        v_m_id_157_16 bigint;
        v_m_id_157_17 bigint;
        v_m_id_157_18 bigint;
        v_m_id_157_19 bigint;
        v_m_id_157_20 bigint;
        v_m_id_157_21 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_157 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_157 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_157;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_157 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_157;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 1, 2025, 11, 4.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_157_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_157_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_157_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_157_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_157_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_157_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 1, 2025, 12, 4.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_157_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_157_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_157_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_157_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 1, 2026, 1, 36.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_157_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_157_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_157_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_157_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 1, 2026, 2, 30.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_157_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_157_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_157_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_157_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 1, 2026, 3, 31.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_157_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_157_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_157_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_157, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_157_21;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_157,
            v_socio_157,
            NULL,
            140.30,
            'Efectivo',
            '32326',
            'Pago histórico recibo N° 32326',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_157_0, 'monto_aplicado', 4.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_157_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_157_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_157_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_157_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_157_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_157,
            v_socio_157,
            NULL,
            10.00,
            'Efectivo',
            '32343',
            'Pago histórico recibo N° 32343',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_157_6, 'monto_aplicado', 4.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_157_7, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-15 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_157,
            v_socio_157,
            NULL,
            38.30,
            'Efectivo',
            '32810',
            'Pago histórico recibo N° 32810',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_157_8, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_157_9, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_157,
            v_socio_157,
            NULL,
            208.20,
            'Efectivo',
            '32863',
            'Pago histórico recibo N° 32863',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_157_10, 'monto_aplicado', 36.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_157_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_157_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_157_13, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_157_14, 'monto_aplicado', 30.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_157_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_157_16, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_157_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_157,
            v_socio_157,
            NULL,
            102.40,
            'Efectivo',
            '33012',
            'Pago histórico recibo N° 33012',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_157_18, 'monto_aplicado', 31.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_157_19, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_157_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_157_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: SOTO VARGAS DE FLORES MARIA DEL CARMEN (Puesto: 98, ID: 158)
    -- =========================================================================
    DECLARE
        v_socio_158 bigint := 158;
        v_puesto_158 bigint := 193;
        v_m_id_158_0 bigint;
        v_m_id_158_1 bigint;
        v_m_id_158_2 bigint;
        v_m_id_158_3 bigint;
        v_m_id_158_4 bigint;
        v_m_id_158_5 bigint;
        v_m_id_158_6 bigint;
        v_m_id_158_7 bigint;
        v_m_id_158_8 bigint;
        v_m_id_158_9 bigint;
        v_m_id_158_10 bigint;
        v_m_id_158_11 bigint;
        v_m_id_158_12 bigint;
        v_m_id_158_13 bigint;
        v_m_id_158_14 bigint;
        v_m_id_158_15 bigint;
        v_m_id_158_16 bigint;
        v_m_id_158_17 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_158 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_158 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_158;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_158 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_158;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 1, 2025, 11, 7.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_158_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_158_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 1, 2025, 12, 7.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_158_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_158_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 3, 2025, 12, 2.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_158_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_158_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_158_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_158_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 1, 2026, 1, 7.80, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_158_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_158_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_158_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 1, 2026, 2, 7.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_158_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_158_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_158_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_158_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_158_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_158_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_158, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_158_17;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_158,
            v_socio_158,
            NULL,
            34.40,
            'Efectivo',
            '32398',
            'Pago histórico recibo N° 32398',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_158_0, 'monto_aplicado', 7.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_158_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_158_2, 'monto_aplicado', 7.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_158_3, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_158_4, 'monto_aplicado', 2.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_158_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_158,
            v_socio_158,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_158_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_158_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_158,
            v_socio_158,
            NULL,
            51.50,
            'Efectivo',
            '32857',
            'Pago histórico recibo N° 32857',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_158_8, 'monto_aplicado', 7.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_158_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_158_11, 'monto_aplicado', 7.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_158_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_158_10, 'monto_aplicado', 16.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_158_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_158,
            v_socio_158,
            NULL,
            40.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_158_10, 'monto_aplicado', 40.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_158,
            v_socio_158,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_158_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_158_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_158,
            v_socio_158,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_158_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_158_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ORDONEZ NICHO AZUL CARILE (Puesto: 182, ID: 107)
    -- =========================================================================
    DECLARE
        v_socio_107 bigint := 107;
        v_puesto_107 bigint := 276;
        v_m_id_107_0 bigint;
        v_m_id_107_1 bigint;
        v_m_id_107_2 bigint;
        v_m_id_107_3 bigint;
        v_m_id_107_4 bigint;
        v_m_id_107_5 bigint;
        v_m_id_107_6 bigint;
        v_m_id_107_7 bigint;
        v_m_id_107_8 bigint;
        v_m_id_107_9 bigint;
        v_m_id_107_10 bigint;
        v_m_id_107_11 bigint;
        v_m_id_107_12 bigint;
        v_m_id_107_13 bigint;
        v_m_id_107_14 bigint;
        v_m_id_107_15 bigint;
        v_m_id_107_16 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_107 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_107 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_107;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_107 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_107;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_107, 1, 2025, 11, 105.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_107_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_107, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_107_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_107, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_107_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_107, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_107_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_107, 1, 2025, 12, 105.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_107_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_107, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_107_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_107, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_107_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_107, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_107_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_107, 1, 2026, 1, 113.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_107_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_107, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_107_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_107, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_107_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_107, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_107_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_107, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_107_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_107, 1, 2026, 2, 112.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_107_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_107, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_107_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_107, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_107_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_107, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_107_16;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_107,
            v_socio_107,
            NULL,
            353.10,
            'Efectivo',
            '32358',
            'Pago histórico recibo N° 32358',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_107_0, 'monto_aplicado', 105.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_107_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_107_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_107_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_107_4, 'monto_aplicado', 105.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_107_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_107_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_107_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_107,
            v_socio_107,
            NULL,
            377.10,
            'Efectivo',
            '32835',
            'Pago histórico recibo N° 32835',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_107_8, 'monto_aplicado', 113.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_107_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_107_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_107_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_107_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_107_13, 'monto_aplicado', 112.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_107_14, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_107_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_107_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: TAIPE OQUENDO EUGENIO JOEL (Puesto: 26, ID: 159)
    -- =========================================================================
    DECLARE
        v_socio_159 bigint := 159;
        v_puesto_159 bigint := 88;
        v_m_id_159_0 bigint;
        v_m_id_159_1 bigint;
        v_m_id_159_2 bigint;
        v_m_id_159_3 bigint;
        v_m_id_159_4 bigint;
        v_m_id_159_5 bigint;
        v_m_id_159_6 bigint;
        v_m_id_159_7 bigint;
        v_m_id_159_8 bigint;
        v_m_id_159_9 bigint;
        v_m_id_159_10 bigint;
        v_m_id_159_11 bigint;
        v_m_id_159_12 bigint;
        v_m_id_159_13 bigint;
        v_m_id_159_14 bigint;
        v_m_id_159_15 bigint;
        v_m_id_159_16 bigint;
        v_m_id_159_17 bigint;
        v_m_id_159_18 bigint;
        v_m_id_159_19 bigint;
        v_m_id_159_20 bigint;
        v_m_id_159_21 bigint;
        v_m_id_159_22 bigint;
        v_m_id_159_23 bigint;
        v_m_id_159_24 bigint;
        v_m_id_159_25 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_159 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_159 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_159;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_159 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_159;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 1, 2025, 11, 61.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_159_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_159_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_159_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_159_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 1, 2025, 12, 61.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_159_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_159_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_159_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_159_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 1, 2026, 1, 60.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_159_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_159_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_159_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_159_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_159_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_159_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 1, 2026, 2, 59.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_159_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_159_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_159_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_159_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 1, 2026, 3, 61.60, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_159_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_159_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_159_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_159_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 1, 2026, 4, 47.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_159_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_159_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_159_24;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_159, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_159_25;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_159,
            v_socio_159,
            NULL,
            264.90,
            'Efectivo',
            '32347',
            'Pago histórico recibo N° 32347',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_159_0, 'monto_aplicado', 61.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_4, 'monto_aplicado', 61.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-15 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_159,
            v_socio_159,
            NULL,
            168.40,
            'Efectivo',
            '32619',
            'Pago histórico recibo N° 32619',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_159_8, 'monto_aplicado', 60.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_13, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_159,
            v_socio_159,
            NULL,
            130.20,
            'Efectivo',
            '32766',
            'Pago histórico recibo N° 32766',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_159_14, 'monto_aplicado', 59.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_16, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_159,
            v_socio_159,
            NULL,
            132.60,
            'Efectivo',
            '33042',
            'Pago histórico recibo N° 33042',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_159_18, 'monto_aplicado', 61.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_19, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_159,
            v_socio_159,
            NULL,
            118.00,
            'Efectivo',
            '33122',
            'Pago histórico recibo N° 33122',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_159_22, 'monto_aplicado', 47.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_23, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_24, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_159_25, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: TELLO ALVAREZ MARINO (Puesto: 44, ID: 160)
    -- =========================================================================
    DECLARE
        v_socio_160 bigint := 160;
        v_puesto_160 bigint := 122;
        v_m_id_160_0 bigint;
        v_m_id_160_1 bigint;
        v_m_id_160_2 bigint;
        v_m_id_160_3 bigint;
        v_m_id_160_4 bigint;
        v_m_id_160_5 bigint;
        v_m_id_160_6 bigint;
        v_m_id_160_7 bigint;
        v_m_id_160_8 bigint;
        v_m_id_160_9 bigint;
        v_m_id_160_10 bigint;
        v_m_id_160_11 bigint;
        v_m_id_160_12 bigint;
        v_m_id_160_13 bigint;
        v_m_id_160_14 bigint;
        v_m_id_160_15 bigint;
        v_m_id_160_16 bigint;
        v_m_id_160_17 bigint;
        v_m_id_160_18 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_160 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_160 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_160;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_160 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_160;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 1, 2025, 11, 93.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_160_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_160_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 3, 2025, 11, 55.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_160_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_160_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 1, 2025, 12, 99.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_160_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_160_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_160_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_160_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_160_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 1, 2026, 1, 96.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_160_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_160_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_160_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_160_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_160_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 1, 2026, 2, 95.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_160_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_160_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_160_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 1, 2026, 3, 98.80, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_160_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_160, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_160_18;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_160,
            v_socio_160,
            NULL,
            159.10,
            'Efectivo',
            '32337',
            'Pago histórico recibo N° 32337',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_160_0, 'monto_aplicado', 93.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_160_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_160_2, 'monto_aplicado', 55.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_160_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_160,
            v_socio_160,
            NULL,
            40.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_160_4, 'monto_aplicado', 20.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_160_8, 'monto_aplicado', 20.00, 'cubierto_completo', false)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_160,
            v_socio_160,
            NULL,
            40.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_160_4, 'monto_aplicado', 20.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_160_13, 'monto_aplicado', 20.00, 'cubierto_completo', false)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_160,
            v_socio_160,
            NULL,
            287.20,
            'Efectivo',
            '32892',
            'Pago histórico recibo N° 32892',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_160_4, 'monto_aplicado', 59.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_160_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_160_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_160_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_160_9, 'monto_aplicado', 96.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_160_10, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_160_8, 'monto_aplicado', 40.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_160_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_160_12, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_160,
            v_socio_160,
            NULL,
            146.80,
            'Efectivo',
            '32893',
            'Pago histórico recibo N° 32893',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_160_14, 'monto_aplicado', 95.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_160_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_160_13, 'monto_aplicado', 36.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_160_16, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_160_17, 'monto_aplicado', 0.50, 'cubierto_completo', false)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_160,
            v_socio_160,
            NULL,
            104.30,
            'Efectivo',
            '33101',
            'Pago histórico recibo N° 33101',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_160_17, 'monto_aplicado', 98.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_160_18, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-21 12:00:00-05', created_at = '2026-05-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-21 12:00:00-05', created_at = '2026-05-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: TELLO QUINTANA EDGAR ERASMO (Puesto: 86, ID: 161)
    -- =========================================================================
    DECLARE
        v_socio_161 bigint := 161;
        v_puesto_161 bigint := 182;
        v_m_id_161_0 bigint;
        v_m_id_161_1 bigint;
        v_m_id_161_2 bigint;
        v_m_id_161_3 bigint;
        v_m_id_161_4 bigint;
        v_m_id_161_5 bigint;
        v_m_id_161_6 bigint;
        v_m_id_161_7 bigint;
        v_m_id_161_8 bigint;
        v_m_id_161_9 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_161 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_161 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_161;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_161 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_161;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_161, 1, 2025, 12, 47.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_161_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_161, 2, 2025, 12, 218.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_161_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_161, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_161_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_161, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_161_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_161, 1, 2026, 1, 54.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_161_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_161, 2, 2026, 1, 250.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_161_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_161, 1, 2026, 2, 150.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_161_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_161, 2, 2026, 2, 207.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_161_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_161, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_161_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_161, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_161_9;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_161,
            v_socio_161,
            NULL,
            331.30,
            'Efectivo',
            '32535',
            'Pago histórico recibo N° 32535',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_161_0, 'monto_aplicado', 47.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_161_1, 'monto_aplicado', 218.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_161_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_161_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_161,
            v_socio_161,
            NULL,
            724.60,
            'Efectivo',
            '32856',
            'Pago histórico recibo N° 32856',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_161_4, 'monto_aplicado', 54.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_161_5, 'monto_aplicado', 250.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_161_6, 'monto_aplicado', 150.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_161_7, 'monto_aplicado', 207.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_161_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_161_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: TINEO CABRERA SONIA (Puesto: 112, ID: 162)
    -- =========================================================================
    DECLARE
        v_socio_162 bigint := 162;
        v_puesto_162 bigint := 207;
        v_m_id_162_0 bigint;
        v_m_id_162_1 bigint;
        v_m_id_162_2 bigint;
        v_m_id_162_3 bigint;
        v_m_id_162_4 bigint;
        v_m_id_162_5 bigint;
        v_m_id_162_6 bigint;
        v_m_id_162_7 bigint;
        v_m_id_162_8 bigint;
        v_m_id_162_9 bigint;
        v_m_id_162_10 bigint;
        v_m_id_162_11 bigint;
        v_m_id_162_12 bigint;
        v_m_id_162_13 bigint;
        v_m_id_162_14 bigint;
        v_m_id_162_15 bigint;
        v_m_id_162_16 bigint;
        v_m_id_162_17 bigint;
        v_m_id_162_18 bigint;
        v_m_id_162_19 bigint;
        v_m_id_162_20 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_162 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_162 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_162;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_162 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_162;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 1, 2025, 11, 35.40, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_162_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 2, 2025, 11, 24.20, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_162_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 1, 2025, 12, 31.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_162_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 2, 2025, 12, 24.30, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_162_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 3, 2025, 12, 10.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_162_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_162_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_162_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_162_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 1, 2026, 1, 32.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_162_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 2, 2026, 1, 21.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_162_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_162_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_162_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_162_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 1, 2026, 2, 35.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_162_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 2, 2026, 2, 26.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_162_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_162_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_162_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 1, 2026, 3, 33.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_162_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 2, 2026, 3, 28.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_162_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_162_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_162, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_162_20;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_162,
            v_socio_162,
            NULL,
            59.60,
            'Efectivo',
            '32356',
            'Pago histórico recibo N° 32356',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_162_0, 'monto_aplicado', 35.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_162_1, 'monto_aplicado', 24.20, 'cubierto_completo', true)),
            0.00,
            '2026-01-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_162,
            v_socio_162,
            NULL,
            70.80,
            'Efectivo',
            '32686',
            'Pago histórico recibo N° 32686',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_162_2, 'monto_aplicado', 31.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_162_3, 'monto_aplicado', 24.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_162_4, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_162_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_162,
            v_socio_162,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_162_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_162_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_162,
            v_socio_162,
            NULL,
            64.20,
            'Efectivo',
            '32703',
            'Pago histórico recibo N° 32703',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_162_8, 'monto_aplicado', 32.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_162_9, 'monto_aplicado', 21.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_162_10, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_162,
            v_socio_162,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_162_11, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_162_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_162,
            v_socio_162,
            NULL,
            61.20,
            'Efectivo',
            '32873',
            'Pago histórico recibo N° 32873',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_162_13, 'monto_aplicado', 35.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_162_14, 'monto_aplicado', 26.20, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_162,
            v_socio_162,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_162_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_162_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_162,
            v_socio_162,
            NULL,
            61.40,
            'Efectivo',
            '33046',
            'Pago histórico recibo N° 33046',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_162_17, 'monto_aplicado', 33.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_162_18, 'monto_aplicado', 28.40, 'cubierto_completo', true)),
            0.00,
            '2026-05-09 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-09 12:00:00-05', created_at = '2026-05-09 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-09 12:00:00-05', created_at = '2026-05-09 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_162,
            v_socio_162,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_162_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_162_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: TINTAYA CAHUANA PATRICIA HERMENEGILDA (Puesto: 72, ID: 163)
    -- =========================================================================
    DECLARE
        v_socio_163 bigint := 163;
        v_puesto_163 bigint := 169;
        v_m_id_163_0 bigint;
        v_m_id_163_1 bigint;
        v_m_id_163_2 bigint;
        v_m_id_163_3 bigint;
        v_m_id_163_4 bigint;
        v_m_id_163_5 bigint;
        v_m_id_163_6 bigint;
        v_m_id_163_7 bigint;
        v_m_id_163_8 bigint;
        v_m_id_163_9 bigint;
        v_m_id_163_10 bigint;
        v_m_id_163_11 bigint;
        v_m_id_163_12 bigint;
        v_m_id_163_13 bigint;
        v_m_id_163_14 bigint;
        v_m_id_163_15 bigint;
        v_m_id_163_16 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_163 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_163 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_163;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_163 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_163;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_163, 1, 2025, 11, 46.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_163_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_163, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_163_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_163, 1, 2025, 12, 47.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_163_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_163, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_163_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_163, 3, 2025, 12, 40.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_163_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_163, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_163_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_163, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_163_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_163, 1, 2026, 1, 45.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_163_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_163, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_163_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_163, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_163_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_163, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_163_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_163, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_163_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_163, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_163_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_163, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_163_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_163, 1, 2026, 2, 45.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_163_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_163, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_163_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_163, 3, 2026, 3, 10.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_163_16;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_163,
            v_socio_163,
            NULL,
            100.00,
            'Efectivo',
            '32568',
            'Pago histórico recibo N° 32568',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_163_0, 'monto_aplicado', 46.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_163_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_163_2, 'monto_aplicado', 47.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_163_3, 'monto_aplicado', 0.70, 'cubierto_completo', false)),
            0.00,
            '2026-02-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-25 12:00:00-05', created_at = '2026-02-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-25 12:00:00-05', created_at = '2026-02-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_163,
            v_socio_163,
            NULL,
            164.20,
            'Efectivo',
            '32612',
            'Pago histórico recibo N° 32612',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_163_3, 'monto_aplicado', 5.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_163_4, 'monto_aplicado', 40.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_163_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_163_7, 'monto_aplicado', 45.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_163_8, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_163_6, 'monto_aplicado', 20.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_163_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_163_10, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_163_11, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_163,
            v_socio_163,
            NULL,
            40.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_163_6, 'monto_aplicado', 40.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_163,
            v_socio_163,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_163_12, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_163_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_163,
            v_socio_163,
            NULL,
            55.00,
            'Efectivo',
            '32713',
            'Pago histórico recibo N° 32713',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_163_14, 'monto_aplicado', 45.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_163_15, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_163,
            v_socio_163,
            NULL,
            10.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_163_16, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: TITO FALCON JESUSA RICARDINA (Puesto: 105, ID: 164)
    -- =========================================================================
    DECLARE
        v_socio_164 bigint := 164;
        v_puesto_164 bigint := 200;
        v_m_id_164_0 bigint;
        v_m_id_164_1 bigint;
        v_m_id_164_2 bigint;
        v_m_id_164_3 bigint;
        v_m_id_164_4 bigint;
        v_m_id_164_5 bigint;
        v_m_id_164_6 bigint;
        v_m_id_164_7 bigint;
        v_m_id_164_8 bigint;
        v_m_id_164_9 bigint;
        v_m_id_164_10 bigint;
        v_m_id_164_11 bigint;
        v_m_id_164_12 bigint;
        v_m_id_164_13 bigint;
        v_m_id_164_14 bigint;
        v_m_id_164_15 bigint;
        v_m_id_164_16 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_164 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_164 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_164;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_164 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_164;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_164, 1, 2025, 12, 247.80, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_164_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_164, 2, 2025, 12, 65.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_164_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_164, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_164_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_164, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_164_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_164, 1, 2026, 1, 284.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_164_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_164, 2, 2026, 1, 71.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_164_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_164, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_164_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_164, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_164_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_164, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_164_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_164, 1, 2026, 2, 276.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_164_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_164, 2, 2026, 2, 65.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_164_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_164, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_164_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_164, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_164_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_164, 1, 2026, 3, 252.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_164_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_164, 2, 2026, 3, 77.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_164_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_164, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_164_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_164, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_164_16;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_164,
            v_socio_164,
            NULL,
            313.00,
            'Efectivo',
            '32441',
            'Pago histórico recibo N° 32441',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_164_0, 'monto_aplicado', 247.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_164_1, 'monto_aplicado', 65.20, 'cubierto_completo', true)),
            0.00,
            '2026-01-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-30 12:00:00-05', created_at = '2026-01-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-30 12:00:00-05', created_at = '2026-01-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_164,
            v_socio_164,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_164_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_164_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_164,
            v_socio_164,
            NULL,
            355.60,
            'Efectivo',
            '32603',
            'Pago histórico recibo N° 32603',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_164_4, 'monto_aplicado', 284.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_164_5, 'monto_aplicado', 71.20, 'cubierto_completo', true)),
            0.00,
            '2026-03-03 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_164,
            v_socio_164,
            NULL,
            10.00,
            'Efectivo',
            '32604',
            'Pago histórico recibo N° 32604',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_164_6, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-03 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_164,
            v_socio_164,
            NULL,
            40.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_164_7, 'monto_aplicado', 40.00, 'cubierto_completo', false)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_164,
            v_socio_164,
            NULL,
            21.00,
            'Efectivo',
            '32605',
            'Pago histórico recibo N° 32605',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_164_7, 'monto_aplicado', 16.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_164_8, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-03 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_164,
            v_socio_164,
            NULL,
            342.60,
            'Efectivo',
            '32755',
            'Pago histórico recibo N° 32755',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_164_9, 'monto_aplicado', 276.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_164_10, 'monto_aplicado', 65.80, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_164,
            v_socio_164,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_164_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_164_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_164,
            v_socio_164,
            NULL,
            329.90,
            'Efectivo',
            '33006',
            'Pago histórico recibo N° 33006',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_164_13, 'monto_aplicado', 252.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_164_14, 'monto_aplicado', 77.20, 'cubierto_completo', true)),
            0.00,
            '2026-05-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_164,
            v_socio_164,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_164_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_164_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: TORRES ANYOSA MARCELINO (Puesto: 70, ID: 165)
    -- =========================================================================
    DECLARE
        v_socio_165 bigint := 165;
        v_puesto_165 bigint := 167;
        v_m_id_165_0 bigint;
        v_m_id_165_1 bigint;
        v_m_id_165_2 bigint;
        v_m_id_165_3 bigint;
        v_m_id_165_4 bigint;
        v_m_id_165_5 bigint;
        v_m_id_165_6 bigint;
        v_m_id_165_7 bigint;
        v_m_id_165_8 bigint;
        v_m_id_165_9 bigint;
        v_m_id_165_10 bigint;
        v_m_id_165_11 bigint;
        v_m_id_165_12 bigint;
        v_m_id_165_13 bigint;
        v_m_id_165_14 bigint;
        v_m_id_165_15 bigint;
        v_m_id_165_16 bigint;
        v_m_id_165_17 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_165 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_165 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_165;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_165 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_165;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 1, 2026, 5, 16.40, 'Pendiente', 'Manual', '2026-05-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_165_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 2, 2026, 5, 5.00, 'Pendiente', 'Manual', '2026-05-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_165_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 1, 2026, 6, 17.90, 'Pendiente', 'Manual', '2026-06-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_165_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 2, 2026, 6, 4.00, 'Pendiente', 'Manual', '2026-06-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_165_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 1, 2026, 7, 17.90, 'Pendiente', 'Manual', '2026-07-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_165_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 2, 2026, 7, 4.00, 'Pendiente', 'Manual', '2026-07-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_165_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 1, 2026, 8, 17.90, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_165_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 2, 2026, 8, 8.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_165_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 1, 2026, 9, 17.20, 'Pendiente', 'Manual', '2026-09-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_165_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 2, 2026, 9, 4.00, 'Pendiente', 'Manual', '2026-09-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_165_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 1, 2026, 10, 17.00, 'Pendiente', 'Manual', '2026-10-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_165_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 2, 2026, 10, 7.00, 'Pendiente', 'Manual', '2026-10-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_165_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 1, 2025, 11, 16.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_165_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_165_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 1, 2025, 12, 16.30, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_165_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_165_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 1, 2026, 1, 15.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_165_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_165, 2, 2026, 1, 3.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_165_17;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_165,
            v_socio_165,
            NULL,
            136.30,
            'Efectivo',
            '33017',
            'Pago histórico recibo N° 33017',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_165_0, 'monto_aplicado', 16.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_165_1, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_165_2, 'monto_aplicado', 17.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_165_3, 'monto_aplicado', 4.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_165_4, 'monto_aplicado', 17.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_165_5, 'monto_aplicado', 4.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_165_6, 'monto_aplicado', 17.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_165_7, 'monto_aplicado', 8.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_165_8, 'monto_aplicado', 17.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_165_9, 'monto_aplicado', 4.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_165_10, 'monto_aplicado', 17.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_165_11, 'monto_aplicado', 7.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_165,
            v_socio_165,
            NULL,
            63.70,
            'Efectivo',
            '33018',
            'Pago histórico recibo N° 33018',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_165_12, 'monto_aplicado', 16.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_165_13, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_165_14, 'monto_aplicado', 16.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_165_15, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_165_16, 'monto_aplicado', 15.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_165_17, 'monto_aplicado', 3.40, 'cubierto_completo', true)),
            0.00,
            '2026-05-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: TORRES ASTO FRANCISCO CONTESOR (Puesto: 189, ID: 166)
    -- =========================================================================
    DECLARE
        v_socio_166 bigint := 166;
        v_puesto_166 bigint := 283;
        v_m_id_166_0 bigint;
        v_m_id_166_1 bigint;
        v_m_id_166_2 bigint;
        v_m_id_166_3 bigint;
        v_m_id_166_4 bigint;
        v_m_id_166_5 bigint;
        v_m_id_166_6 bigint;
        v_m_id_166_7 bigint;
        v_m_id_166_8 bigint;
        v_m_id_166_9 bigint;
        v_m_id_166_10 bigint;
        v_m_id_166_11 bigint;
        v_m_id_166_12 bigint;
        v_m_id_166_13 bigint;
        v_m_id_166_14 bigint;
        v_m_id_166_15 bigint;
        v_m_id_166_16 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_166 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_166 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_166;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_166 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_166;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_166, 1, 2025, 12, 47.80, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_166_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_166, 2, 2025, 12, 76.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_166_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_166, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_166_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_166, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_166_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_166, 1, 2026, 1, 53.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_166_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_166, 2, 2026, 1, 65.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_166_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_166, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_166_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_166, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_166_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_166, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_166_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_166, 1, 2026, 2, 53.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_166_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_166, 2, 2026, 2, 65.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_166_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_166, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_166_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_166, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_166_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_166, 1, 2026, 3, 52.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_166_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_166, 2, 2026, 3, 75.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_166_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_166, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_166_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_166, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_166_16;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_166,
            v_socio_166,
            NULL,
            188.80,
            'Efectivo',
            '32394',
            'Pago histórico recibo N° 32394',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_166_0, 'monto_aplicado', 47.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_166_1, 'monto_aplicado', 76.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_166_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_166_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-24 12:00:00-05', created_at = '2026-01-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-24 12:00:00-05', created_at = '2026-01-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_166,
            v_socio_166,
            NULL,
            189.00,
            'Efectivo',
            '32547',
            'Pago histórico recibo N° 32547',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_166_4, 'monto_aplicado', 53.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_166_5, 'monto_aplicado', 65.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_166_6, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_166_7, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_166_8, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_166,
            v_socio_166,
            NULL,
            183.50,
            'Efectivo',
            '32767',
            'Pago histórico recibo N° 32767',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_166_9, 'monto_aplicado', 53.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_166_10, 'monto_aplicado', 65.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_166_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_166_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_166,
            v_socio_166,
            NULL,
            192.40,
            'Efectivo',
            '32955',
            'Pago histórico recibo N° 32955',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_166_13, 'monto_aplicado', 52.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_166_14, 'monto_aplicado', 75.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_166_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_166_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-23 12:00:00-05', created_at = '2026-04-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-23 12:00:00-05', created_at = '2026-04-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: TORRES ASTO SANTOS NERY F (Puesto: 137, ID: 167)
    -- =========================================================================
    DECLARE
        v_socio_167 bigint := 167;
        v_puesto_167 bigint := 232;
        v_m_id_167_0 bigint;
        v_m_id_167_1 bigint;
        v_m_id_167_2 bigint;
        v_m_id_167_3 bigint;
        v_m_id_167_4 bigint;
        v_m_id_167_5 bigint;
        v_m_id_167_6 bigint;
        v_m_id_167_7 bigint;
        v_m_id_167_8 bigint;
        v_m_id_167_9 bigint;
        v_m_id_167_10 bigint;
        v_m_id_167_11 bigint;
        v_m_id_167_12 bigint;
        v_m_id_167_13 bigint;
        v_m_id_167_14 bigint;
        v_m_id_167_15 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_167 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_167 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_167;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_167 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_167;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_167, 1, 2025, 11, 5.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_167_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_167, 2, 2025, 11, 24.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_167_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_167, 1, 2025, 12, 6.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_167_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_167, 2, 2025, 12, 22.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_167_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_167, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_167_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_167, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_167_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_167, 1, 2026, 1, 5.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_167_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_167, 2, 2026, 1, 30.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_167_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_167, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_167_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_167, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_167_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_167, 1, 2026, 2, 7.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_167_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_167, 2, 2026, 2, 32.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_167_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_167, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_167_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_167, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_167_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_167, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_167_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_167, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_167_15;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_167,
            v_socio_167,
            NULL,
            96.30,
            'Efectivo',
            '32557',
            'Pago histórico recibo N° 32557',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_167_0, 'monto_aplicado', 5.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_167_1, 'monto_aplicado', 24.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_167_2, 'monto_aplicado', 6.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_167_3, 'monto_aplicado', 22.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_167_6, 'monto_aplicado', 5.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_167_7, 'monto_aplicado', 30.40, 'cubierto_completo', true)),
            0.00,
            '2026-02-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_167,
            v_socio_167,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_167_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_167_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_167,
            v_socio_167,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_167_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_167_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_167,
            v_socio_167,
            NULL,
            40.00,
            'Efectivo',
            '32907',
            'Pago histórico recibo N° 32907',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_167_10, 'monto_aplicado', 7.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_167_11, 'monto_aplicado', 32.80, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_167,
            v_socio_167,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_167_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_167_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_167,
            v_socio_167,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_167_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_167_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: TORRES ASTO VDA DE CALDERON JUANA FRONILDA (Puesto: 82, ID: 168)
    -- =========================================================================
    DECLARE
        v_socio_168 bigint := 168;
        v_puesto_168 bigint := 178;
        v_m_id_168_0 bigint;
        v_m_id_168_1 bigint;
        v_m_id_168_2 bigint;
        v_m_id_168_3 bigint;
        v_m_id_168_4 bigint;
        v_m_id_168_5 bigint;
        v_m_id_168_6 bigint;
        v_m_id_168_7 bigint;
        v_m_id_168_8 bigint;
        v_m_id_168_9 bigint;
        v_m_id_168_10 bigint;
        v_m_id_168_11 bigint;
        v_m_id_168_12 bigint;
        v_m_id_168_13 bigint;
        v_m_id_168_14 bigint;
        v_m_id_168_15 bigint;
        v_m_id_168_16 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_168 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_168 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_168;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_168 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_168;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_168, 3, 2026, 1, 120.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_168_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_168, 1, 2025, 11, 15.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_168_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_168, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_168_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_168, 1, 2025, 12, 27.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_168_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_168, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_168_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_168, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_168_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_168, 1, 2026, 1, 18.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_168_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_168, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_168_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_168, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_168_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_168, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_168_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_168, 1, 2026, 2, 14.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_168_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_168, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_168_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_168, 3, 2026, 3, 42.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_168_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_168, 1, 2026, 3, 20.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_168_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_168, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_168_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_168, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_168_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_168, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_168_16;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_168,
            v_socio_168,
            NULL,
            60.00,
            'Efectivo',
            '32676',
            'Pago histórico recibo N° 32676',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_168_0, 'monto_aplicado', 60.00, 'cubierto_completo', false)),
            0.00,
            '2026-03-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-16 12:00:00-05', created_at = '2026-03-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-16 12:00:00-05', created_at = '2026-03-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_168,
            v_socio_168,
            NULL,
            122.30,
            'Efectivo',
            '33073',
            'Pago histórico recibo N° 33073',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_168_1, 'monto_aplicado', 15.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_168_2, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_168_3, 'monto_aplicado', 27.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_168_6, 'monto_aplicado', 18.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_168_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_168_10, 'monto_aplicado', 14.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_168_11, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_168_13, 'monto_aplicado', 20.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_168_14, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-14 12:00:00-05', created_at = '2026-05-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-14 12:00:00-05', created_at = '2026-05-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_168,
            v_socio_168,
            NULL,
            6.00,
            'Efectivo',
            '',
            'Pago histórico recibo N° ',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_168_4, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-14 12:00:00-05', created_at = '2026-05-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-14 12:00:00-05', created_at = '2026-05-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_168,
            v_socio_168,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_168_0, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_168_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_168,
            v_socio_168,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_168_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_168_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_168,
            v_socio_168,
            NULL,
            42.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_168_12, 'monto_aplicado', 42.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_168,
            v_socio_168,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABRIL',
            'Pago mensual vía banco - TARJETA-ABRIL',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_168_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_168_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: URETA CRUZ EMILIA (Puesto: 8, ID: 169)
    -- =========================================================================
    DECLARE
        v_socio_169 bigint := 169;
        v_puesto_169 bigint := 48;
        v_m_id_169_0 bigint;
        v_m_id_169_1 bigint;
        v_m_id_169_2 bigint;
        v_m_id_169_3 bigint;
        v_m_id_169_4 bigint;
        v_m_id_169_5 bigint;
        v_m_id_169_6 bigint;
        v_m_id_169_7 bigint;
        v_m_id_169_8 bigint;
        v_m_id_169_9 bigint;
        v_m_id_169_10 bigint;
        v_m_id_169_11 bigint;
        v_m_id_169_12 bigint;
        v_m_id_169_13 bigint;
        v_m_id_169_14 bigint;
        v_m_id_169_15 bigint;
        v_m_id_169_16 bigint;
        v_m_id_169_17 bigint;
        v_m_id_169_18 bigint;
        v_m_id_169_19 bigint;
        v_m_id_169_20 bigint;
        v_m_id_169_21 bigint;
        v_m_id_169_22 bigint;
        v_m_id_169_23 bigint;
        v_m_id_169_24 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_169 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_169 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_169;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_169 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_169;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 18, 2026, 8, 15.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - TALONARIO SANTA ROSA', v_user_uuid)
        RETURNING id INTO v_m_id_169_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 1, 2025, 11, 88.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_169_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 2, 2025, 11, 21.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_169_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_169_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_169_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_169_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_169_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 1, 2025, 12, 89.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_169_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 2, 2025, 12, 23.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_169_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 1, 2026, 1, 87.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_169_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 2, 2026, 1, 26.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_169_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_169_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_169_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_169_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_169_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 1, 2026, 2, 86.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_169_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 2, 2026, 2, 28.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_169_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_169_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_169_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 1, 2026, 3, 89.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_169_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 2, 2026, 3, 28.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_169_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_169_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_169_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_169_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_169, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_169_24;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_169,
            v_socio_169,
            NULL,
            15.00,
            'Efectivo',
            '32281',
            'Pago histórico recibo N° 32281',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_169_0, 'monto_aplicado', 15.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_169,
            v_socio_169,
            NULL,
            175.60,
            'Efectivo',
            '32282',
            'Pago histórico recibo N° 32282',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_169_1, 'monto_aplicado', 88.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_2, 'monto_aplicado', 21.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_3, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_4, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_169,
            v_socio_169,
            NULL,
            65.00,
            'Efectivo',
            '32283',
            'Pago histórico recibo N° 32283',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_169_5, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_6, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_169,
            v_socio_169,
            NULL,
            113.30,
            'Efectivo',
            '32483',
            'Pago histórico recibo N° 32483',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_169_7, 'monto_aplicado', 89.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_8, 'monto_aplicado', 23.40, 'cubierto_completo', true)),
            0.00,
            '2026-02-09 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-09 12:00:00-05', created_at = '2026-02-09 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-09 12:00:00-05', created_at = '2026-02-09 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_169,
            v_socio_169,
            NULL,
            217.60,
            'Efectivo',
            '32637',
            'Pago histórico recibo N° 32637',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_169_9, 'monto_aplicado', 87.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_10, 'monto_aplicado', 26.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_13, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_14, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-09 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-09 12:00:00-05', created_at = '2026-03-09 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-09 12:00:00-05', created_at = '2026-03-09 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_169,
            v_socio_169,
            NULL,
            175.40,
            'Efectivo',
            '32827',
            'Pago histórico recibo N° 32827',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_169_15, 'monto_aplicado', 86.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_16, 'monto_aplicado', 28.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_17, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_169,
            v_socio_169,
            NULL,
            247.50,
            'Efectivo',
            '33033',
            'Pago histórico recibo N° 33033',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_169_19, 'monto_aplicado', 89.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_20, 'monto_aplicado', 28.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_21, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_22, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_23, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_169_24, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: VALENCIA TOMAS VICENTE DORIS (Puesto: 116, ID: 170)
    -- =========================================================================
    DECLARE
        v_socio_170 bigint := 170;
        v_puesto_170 bigint := 211;
        v_m_id_170_0 bigint;
        v_m_id_170_1 bigint;
        v_m_id_170_2 bigint;
        v_m_id_170_3 bigint;
        v_m_id_170_4 bigint;
        v_m_id_170_5 bigint;
        v_m_id_170_6 bigint;
        v_m_id_170_7 bigint;
        v_m_id_170_8 bigint;
        v_m_id_170_9 bigint;
        v_m_id_170_10 bigint;
        v_m_id_170_11 bigint;
        v_m_id_170_12 bigint;
        v_m_id_170_13 bigint;
        v_m_id_170_14 bigint;
        v_m_id_170_15 bigint;
        v_m_id_170_16 bigint;
        v_m_id_170_17 bigint;
        v_m_id_170_18 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_170 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_170 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_170;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_170 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_170;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 18, 2026, 8, 15.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - TALONARIO SANTA ROSA', v_user_uuid)
        RETURNING id INTO v_m_id_170_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 1, 2025, 11, 461.80, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_170_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 2, 2025, 11, 10.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_170_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 1, 2025, 12, 503.30, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_170_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 2, 2025, 12, 9.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_170_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_170_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_170_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 1, 2026, 1, 541.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_170_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 2, 2026, 1, 9.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_170_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_170_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_170_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 1, 2026, 2, 576.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_170_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 2, 2026, 2, 11.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_170_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_170_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_170_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 1, 2026, 3, 560.60, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_170_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 2, 2026, 3, 11.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_170_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_170_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_170, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_170_18;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_170,
            v_socio_170,
            NULL,
            486.80,
            'Efectivo',
            '32354',
            'Pago histórico recibo N° 32354',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_170_0, 'monto_aplicado', 15.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_170_1, 'monto_aplicado', 461.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_170_2, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_170,
            v_socio_170,
            NULL,
            503.30,
            'Efectivo',
            '32511',
            'Pago histórico recibo N° 32511',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_170_3, 'monto_aplicado', 503.30, 'cubierto_completo', true)),
            0.00,
            '2026-02-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_170,
            v_socio_170,
            NULL,
            9.20,
            'Efectivo',
            '25511',
            'Pago histórico recibo N° 25511',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_170_4, 'monto_aplicado', 9.20, 'cubierto_completo', true)),
            0.00,
            '2026-02-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_170,
            v_socio_170,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_170_5, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_170_6, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_170,
            v_socio_170,
            NULL,
            551.30,
            'Efectivo',
            '32598',
            'Pago histórico recibo N° 32598',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_170_7, 'monto_aplicado', 541.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_170_8, 'monto_aplicado', 9.90, 'cubierto_completo', true)),
            0.00,
            '2026-03-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_170,
            v_socio_170,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_170_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_170_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_170,
            v_socio_170,
            NULL,
            587.00,
            'Efectivo',
            '32724',
            'Pago histórico recibo N° 32724',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_170_11, 'monto_aplicado', 576.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_170_12, 'monto_aplicado', 11.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_170,
            v_socio_170,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_170_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_170_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_170,
            v_socio_170,
            NULL,
            571.80,
            'Efectivo',
            '33019',
            'Pago histórico recibo N° 33019',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_170_15, 'monto_aplicado', 560.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_170_16, 'monto_aplicado', 11.20, 'cubierto_completo', true)),
            0.00,
            '2026-05-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_170,
            v_socio_170,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABRIL',
            'Pago mensual vía banco - TARJETA-ABRIL',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_170_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_170_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: VALERO PARIONA MAXIMO ALBINO (Puesto: 21, ID: 171)
    -- =========================================================================
    DECLARE
        v_socio_171 bigint := 171;
        v_puesto_171 bigint := 78;
        v_m_id_171_0 bigint;
        v_m_id_171_1 bigint;
        v_m_id_171_2 bigint;
        v_m_id_171_3 bigint;
        v_m_id_171_4 bigint;
        v_m_id_171_5 bigint;
        v_m_id_171_6 bigint;
        v_m_id_171_7 bigint;
        v_m_id_171_8 bigint;
        v_m_id_171_9 bigint;
        v_m_id_171_10 bigint;
        v_m_id_171_11 bigint;
        v_m_id_171_12 bigint;
        v_m_id_171_13 bigint;
        v_m_id_171_14 bigint;
        v_m_id_171_15 bigint;
        v_m_id_171_16 bigint;
        v_m_id_171_17 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_171 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_171 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_171;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_171 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_171;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 2, 2026, 1, 7.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_171_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 1, 2025, 12, 147.10, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_171_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_171_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_171_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_171_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 1, 2026, 1, 144.80, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_171_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_171_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_171_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_171_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_171_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 1, 2026, 2, 142.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_171_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_171_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_171_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_171_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 1, 2026, 3, 147.60, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_171_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 2, 2026, 3, 2.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_171_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_171_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_171, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_171_17;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_171,
            v_socio_171,
            NULL,
            215.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_171_0, 'monto_aplicado', 2.90, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_171_1, 'monto_aplicado', 147.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_171_3, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_171_4, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_171,
            v_socio_171,
            NULL,
            199.10,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_171_2, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_171_5, 'monto_aplicado', 132.10, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_171_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_171_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_171,
            v_socio_171,
            NULL,
            93.70,
            'Efectivo',
            '32780',
            'Pago histórico recibo N° 32780',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_171_5, 'monto_aplicado', 12.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_171_0, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_171_6, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_171_10, 'monto_aplicado', 37.70, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_171_11, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_171,
            v_socio_171,
            NULL,
            10.00,
            'Efectivo',
            '32811',
            'Pago histórico recibo N° 32811',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_171_7, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_171,
            v_socio_171,
            NULL,
            170.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_171_10, 'monto_aplicado', 105.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_171_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_171_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_171,
            v_socio_171,
            NULL,
            215.00,
            'Transferencia',
            'TARJETA-ABRIL',
            'Pago mensual vía banco - TARJETA-ABRIL',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_171_14, 'monto_aplicado', 147.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_171_15, 'monto_aplicado', 2.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_171_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_171_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: VALERO SOTO MAXIMO ELIAS (Puesto: 153, ID: 172)
    -- =========================================================================
    DECLARE
        v_socio_172 bigint := 172;
        v_puesto_172 bigint := 248;
        v_m_id_172_0 bigint;
        v_m_id_172_1 bigint;
        v_m_id_172_2 bigint;
        v_m_id_172_3 bigint;
        v_m_id_172_4 bigint;
        v_m_id_172_5 bigint;
        v_m_id_172_6 bigint;
        v_m_id_172_7 bigint;
        v_m_id_172_8 bigint;
        v_m_id_172_9 bigint;
        v_m_id_172_10 bigint;
        v_m_id_172_11 bigint;
        v_m_id_172_12 bigint;
        v_m_id_172_13 bigint;
        v_m_id_172_14 bigint;
        v_m_id_172_15 bigint;
        v_m_id_172_16 bigint;
        v_m_id_172_17 bigint;
        v_m_id_172_18 bigint;
        v_m_id_172_19 bigint;
        v_m_id_172_20 bigint;
        v_m_id_172_21 bigint;
        v_m_id_172_22 bigint;
        v_m_id_172_23 bigint;
        v_m_id_172_24 bigint;
        v_m_id_172_25 bigint;
        v_m_id_172_26 bigint;
        v_m_id_172_27 bigint;
        v_m_id_172_28 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_172 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_172 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_172;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_172 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_172;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 6, 2026, 7, 107.80, 'Pendiente', 'Manual', '2026-07-01', 'Migración de pagos 2026 - MULTA 11/07/24', v_user_uuid)
        RETURNING id INTO v_m_id_172_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 6, 2026, 3, 113.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - MULTA 27/03/25', v_user_uuid)
        RETURNING id INTO v_m_id_172_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 1, 2025, 11, 55.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_172_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_172_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_172_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_172_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 6, 2025, 11, 56.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - MULTA 27-11-2025', v_user_uuid)
        RETURNING id INTO v_m_id_172_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 1, 2025, 12, 35.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_172_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_172_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_172_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_172_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_172_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_172_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 1, 2026, 1, 26.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_172_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_172_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_172_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_172_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_172_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_172_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 1, 2026, 2, 20.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_172_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_172_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_172_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_172_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 1, 2026, 3, 21.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_172_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_172_24;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_172_25;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_172_26;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 1, 2026, 4, 22.90, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_172_27;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_172, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_172_28;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_172,
            v_socio_172,
            NULL,
            277.30,
            'Efectivo',
            '33104',
            'Pago histórico recibo N° 33104',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_172_0, 'monto_aplicado', 51.30, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_172_1, 'monto_aplicado', 56.50, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_172_0, 'monto_aplicado', 56.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_6, 'monto_aplicado', 56.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_1, 'monto_aplicado', 56.50, 'cubierto_completo', true)),
            0.00,
            '2026-05-22 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-22 12:00:00-05', created_at = '2026-05-22 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-22 12:00:00-05', created_at = '2026-05-22 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_172,
            v_socio_172,
            NULL,
            102.30,
            'Efectivo',
            '32406',
            'Pago histórico recibo N° 32406',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_172_2, 'monto_aplicado', 55.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_3, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_7, 'monto_aplicado', 35.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_8, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_172,
            v_socio_172,
            NULL,
            256.00,
            'Efectivo',
            '32781',
            'Pago histórico recibo N° 32781',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_172_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_9, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_10, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_17, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_172,
            v_socio_172,
            NULL,
            62.10,
            'Efectivo',
            '32791',
            'Pago histórico recibo N° 32791',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_172_13, 'monto_aplicado', 26.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_14, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_19, 'monto_aplicado', 20.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_20, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_172,
            v_socio_172,
            NULL,
            168.30,
            'Efectivo',
            '33105',
            'Pago histórico recibo N° 33105',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_172_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_16, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_21, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_22, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_25, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_26, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-22 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-22 12:00:00-05', created_at = '2026-05-22 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-22 12:00:00-05', created_at = '2026-05-22 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_172,
            v_socio_172,
            NULL,
            56.00,
            'Efectivo',
            '33112',
            'Pago histórico recibo N° 33112',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_172_23, 'monto_aplicado', 21.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_24, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_27, 'monto_aplicado', 22.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_172_28, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: VALERO SOTO WILLY PERSEO (Puesto: 22, ID: 173)
    -- =========================================================================
    DECLARE
        v_socio_173 bigint := 173;
        v_puesto_173 bigint := 80;
        v_m_id_173_0 bigint;
        v_m_id_173_1 bigint;
        v_m_id_173_2 bigint;
        v_m_id_173_3 bigint;
        v_m_id_173_4 bigint;
        v_m_id_173_5 bigint;
        v_m_id_173_6 bigint;
        v_m_id_173_7 bigint;
        v_m_id_173_8 bigint;
        v_m_id_173_9 bigint;
        v_m_id_173_10 bigint;
        v_m_id_173_11 bigint;
        v_m_id_173_12 bigint;
        v_m_id_173_13 bigint;
        v_m_id_173_14 bigint;
        v_m_id_173_15 bigint;
        v_m_id_173_16 bigint;
        v_m_id_173_17 bigint;
        v_m_id_173_18 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_173 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_173 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_173;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_173 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_173;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 1, 2025, 11, 84.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_173_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_173_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 1, 2025, 12, 146.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_173_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_173_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_173_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_173_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 1, 2026, 1, 142.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_173_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 18, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AG', v_user_uuid)
        RETURNING id INTO v_m_id_173_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_173_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_173_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_173_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_173_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 1, 2026, 2, 140.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_173_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_173_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_173_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_173_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 1, 2026, 3, 102.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_173_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_173_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_173, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_173_18;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_173,
            v_socio_173,
            NULL,
            242.30,
            'Efectivo',
            '32407',
            'Pago histórico recibo N° 32407',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_173_0, 'monto_aplicado', 84.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_173_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_173_2, 'monto_aplicado', 146.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_173_3, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_173,
            v_socio_173,
            NULL,
            125.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_173_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_173_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_173_6, 'monto_aplicado', 60.00, 'cubierto_completo', false)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_173,
            v_socio_173,
            NULL,
            117.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_173_6, 'monto_aplicado', 56.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_173_10, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_173_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_173,
            v_socio_173,
            NULL,
            219.40,
            'Efectivo',
            '32809',
            'Pago histórico recibo N° 32809',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_173_6, 'monto_aplicado', 26.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_173_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_173_8, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_173_9, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_173_12, 'monto_aplicado', 140.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_173_13, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_173,
            v_socio_173,
            NULL,
            107.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_173_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_173_15, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_173_16, 'monto_aplicado', 42.00, 'cubierto_completo', false)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_173,
            v_socio_173,
            NULL,
            125.00,
            'Transferencia',
            'TARJETA-ABRIL',
            'Pago mensual vía banco - TARJETA-ABRIL',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_173_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_173_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_173_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: VALLEJOS HUAMAN MARIA ANA (Puesto: 129, ID: 174)
    -- =========================================================================
    DECLARE
        v_socio_174 bigint := 174;
        v_puesto_174 bigint := 224;
        v_m_id_174_0 bigint;
        v_m_id_174_1 bigint;
        v_m_id_174_2 bigint;
        v_m_id_174_3 bigint;
        v_m_id_174_4 bigint;
        v_m_id_174_5 bigint;
        v_m_id_174_6 bigint;
        v_m_id_174_7 bigint;
        v_m_id_174_8 bigint;
        v_m_id_174_9 bigint;
        v_m_id_174_10 bigint;
        v_m_id_174_11 bigint;
        v_m_id_174_12 bigint;
        v_m_id_174_13 bigint;
        v_m_id_174_14 bigint;
        v_m_id_174_15 bigint;
        v_m_id_174_16 bigint;
        v_m_id_174_17 bigint;
        v_m_id_174_18 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_174 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_174 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_174;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_174 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_174;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 2, 2025, 11, 27.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_174_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 1, 2025, 12, 79.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_174_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 2, 2025, 12, 44.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_174_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_174_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_174_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 1, 2026, 1, 75.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_174_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 2, 2026, 1, 45.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_174_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_174_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_174_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 1, 2026, 2, 73.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_174_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 2, 2026, 2, 45.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_174_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_174_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_174_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 1, 2026, 3, 71.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_174_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 2, 2026, 3, 68.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_174_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_174_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_174_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 1, 2026, 4, 84.30, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_174_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_174, 2, 2026, 4, 68.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_174_18;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_174,
            v_socio_174,
            NULL,
            150.90,
            'Efectivo',
            '32365',
            'Pago histórico recibo N° 32365',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_174_0, 'monto_aplicado', 27.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_174_1, 'monto_aplicado', 79.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_174_2, 'monto_aplicado', 44.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_174,
            v_socio_174,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_174_3, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_174_4, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_174,
            v_socio_174,
            NULL,
            120.50,
            'Efectivo',
            '32572',
            'Pago histórico recibo N° 32572',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_174_5, 'monto_aplicado', 75.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_174_6, 'monto_aplicado', 45.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-26 12:00:00-05', created_at = '2026-02-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-26 12:00:00-05', created_at = '2026-02-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_174,
            v_socio_174,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_174_7, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_174_8, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_174,
            v_socio_174,
            NULL,
            118.70,
            'Efectivo',
            '32727',
            'Pago histórico recibo N° 32727',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_174_9, 'monto_aplicado', 73.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_174_10, 'monto_aplicado', 45.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_174,
            v_socio_174,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_174_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_174_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_174,
            v_socio_174,
            NULL,
            291.80,
            'Efectivo',
            '33119',
            'Pago histórico recibo N° 33119',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_174_13, 'monto_aplicado', 71.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_174_14, 'monto_aplicado', 68.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_174_17, 'monto_aplicado', 84.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_174_18, 'monto_aplicado', 68.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-26 12:00:00-05', created_at = '2026-05-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-26 12:00:00-05', created_at = '2026-05-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_174,
            v_socio_174,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía banco - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_174_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_174_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: VARA CASTRO DELIA ERNESTINA F (Puesto: 121, ID: 176)
    -- =========================================================================
    DECLARE
        v_socio_176 bigint := 176;
        v_puesto_176 bigint := 216;
        v_m_id_176_0 bigint;
        v_m_id_176_1 bigint;
        v_m_id_176_2 bigint;
        v_m_id_176_3 bigint;
        v_m_id_176_4 bigint;
        v_m_id_176_5 bigint;
        v_m_id_176_6 bigint;
        v_m_id_176_7 bigint;
        v_m_id_176_8 bigint;
        v_m_id_176_9 bigint;
        v_m_id_176_10 bigint;
        v_m_id_176_11 bigint;
        v_m_id_176_12 bigint;
        v_m_id_176_13 bigint;
        v_m_id_176_14 bigint;
        v_m_id_176_15 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_176 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_176 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_176;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_176 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_176;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_176, 1, 2025, 11, 23.20, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_176_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_176, 2, 2025, 11, 11.80, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_176_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_176, 1, 2025, 12, 27.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_176_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_176, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_176_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_176, 3, 2025, 12, 10.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_176_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_176, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_176_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_176, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_176_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_176, 1, 2026, 1, 21.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_176_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_176, 2, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_176_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_176, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_176_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_176, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_176_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_176, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_176_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_176, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_176_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_176, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_176_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_176, 3, 2026, 3, 10.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_176_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_176, 3, 2026, 4, 30.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_176_15;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_176,
            v_socio_176,
            NULL,
            170.10,
            'Efectivo',
            '32655',
            'Pago histórico recibo N° 32655',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_176_0, 'monto_aplicado', 23.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_176_1, 'monto_aplicado', 11.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_176_2, 'monto_aplicado', 27.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_176_3, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_176_4, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_176_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_176_7, 'monto_aplicado', 21.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_176_8, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_176_6, 'monto_aplicado', 50.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_176_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_176,
            v_socio_176,
            NULL,
            10.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_176_6, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_176,
            v_socio_176,
            NULL,
            89.30,
            'Efectivo',
            '32656',
            'Pago histórico recibo N° 32656',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_176_10, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_176_11, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_176_12, 'monto_aplicado', 46.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_176_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_176,
            v_socio_176,
            NULL,
            10.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_176_12, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_176,
            v_socio_176,
            NULL,
            10.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_176_14, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_176,
            v_socio_176,
            NULL,
            30.00,
            'Transferencia',
            'TARJETA-ABRIL',
            'Pago mensual vía banco - TARJETA-ABRIL',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_176_15, 'monto_aplicado', 30.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: VARA DE ROSAS ALICIA VALENTINA (Puesto: 118, ID: 177)
    -- =========================================================================
    DECLARE
        v_socio_177 bigint := 177;
        v_puesto_177 bigint := 213;
        v_m_id_177_0 bigint;
        v_m_id_177_1 bigint;
        v_m_id_177_2 bigint;
        v_m_id_177_3 bigint;
        v_m_id_177_4 bigint;
        v_m_id_177_5 bigint;
        v_m_id_177_6 bigint;
        v_m_id_177_7 bigint;
        v_m_id_177_8 bigint;
        v_m_id_177_9 bigint;
        v_m_id_177_10 bigint;
        v_m_id_177_11 bigint;
        v_m_id_177_12 bigint;
        v_m_id_177_13 bigint;
        v_m_id_177_14 bigint;
        v_m_id_177_15 bigint;
        v_m_id_177_16 bigint;
        v_m_id_177_17 bigint;
        v_m_id_177_18 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_177 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_177 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_177;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_177 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_177;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 1, 2025, 11, 179.80, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_177_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 2, 2025, 11, 56.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_177_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 1, 2025, 12, 176.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_177_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 2, 2025, 12, 69.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_177_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_177_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_177_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 1, 2026, 1, 185.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_177_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 2, 2026, 1, 78.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_177_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_177_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_177_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_177_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 1, 2026, 2, 183.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_177_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 2, 2026, 2, 72.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_177_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_177_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_177_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 1, 2026, 3, 175.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_177_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 2, 2026, 3, 89.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_177_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_177_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_177, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_177_18;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_177,
            v_socio_177,
            NULL,
            235.90,
            'Efectivo',
            '32318',
            'Pago histórico recibo N° 32318',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_177_0, 'monto_aplicado', 179.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_177_1, 'monto_aplicado', 56.10, 'cubierto_completo', true)),
            0.00,
            '2026-01-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_177,
            v_socio_177,
            NULL,
            245.60,
            'Efectivo',
            '32438',
            'Pago histórico recibo N° 32438',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_177_2, 'monto_aplicado', 176.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_177_3, 'monto_aplicado', 69.20, 'cubierto_completo', true)),
            0.00,
            '2026-01-29 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-29 12:00:00-05', created_at = '2026-01-29 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-29 12:00:00-05', created_at = '2026-01-29 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_177,
            v_socio_177,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_177_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_177_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_177,
            v_socio_177,
            NULL,
            273.70,
            'Efectivo',
            '32636',
            'Pago histórico recibo N° 32636',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_177_6, 'monto_aplicado', 185.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_177_7, 'monto_aplicado', 78.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_177_8, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-09 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-09 12:00:00-05', created_at = '2026-03-09 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-09 12:00:00-05', created_at = '2026-03-09 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_177,
            v_socio_177,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_177_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_177_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_177,
            v_socio_177,
            NULL,
            256.00,
            'Efectivo',
            '32756',
            'Pago histórico recibo N° 32756',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_177_11, 'monto_aplicado', 183.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_177_12, 'monto_aplicado', 72.20, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_177,
            v_socio_177,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_177_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_177_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_177,
            v_socio_177,
            NULL,
            264.10,
            'Efectivo',
            '33078',
            'Pago histórico recibo N° 33078',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_177_15, 'monto_aplicado', 175.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_177_16, 'monto_aplicado', 89.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-15 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-15 12:00:00-05', created_at = '2026-05-15 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-15 12:00:00-05', created_at = '2026-05-15 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_177,
            v_socio_177,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABRIL',
            'Pago mensual vía banco - TARJETA-ABRIL',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_177_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_177_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: VICENTE CALIXTO JOSE ALBERTO (Puesto: 160, ID: 178)
    -- =========================================================================
    DECLARE
        v_socio_178 bigint := 178;
        v_puesto_178 bigint := 255;
        v_m_id_178_0 bigint;
        v_m_id_178_1 bigint;
        v_m_id_178_2 bigint;
        v_m_id_178_3 bigint;
        v_m_id_178_4 bigint;
        v_m_id_178_5 bigint;
        v_m_id_178_6 bigint;
        v_m_id_178_7 bigint;
        v_m_id_178_8 bigint;
        v_m_id_178_9 bigint;
        v_m_id_178_10 bigint;
        v_m_id_178_11 bigint;
        v_m_id_178_12 bigint;
        v_m_id_178_13 bigint;
        v_m_id_178_14 bigint;
        v_m_id_178_15 bigint;
        v_m_id_178_16 bigint;
        v_m_id_178_17 bigint;
        v_m_id_178_18 bigint;
        v_m_id_178_19 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_178 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_178 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_178;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_178 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_178;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 18, 2026, 8, 15.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - TALONARIO SANTA ROSA', v_user_uuid)
        RETURNING id INTO v_m_id_178_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 1, 2025, 11, 22.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_178_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_178_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 3, 2025, 11, 40.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_178_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_178_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 16, 2025, 11, 200.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - DEPOSITO N° 5', v_user_uuid)
        RETURNING id INTO v_m_id_178_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 1, 2025, 12, 20.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_178_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_178_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 16, 2025, 12, 200.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - DEPOSITO N° 5', v_user_uuid)
        RETURNING id INTO v_m_id_178_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_178_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_178_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 16, 2026, 1, 200.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - DEPOSITO N° 5', v_user_uuid)
        RETURNING id INTO v_m_id_178_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 1, 2026, 1, 20.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_178_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_178_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_178_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_178_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_178_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 16, 2026, 2, 200.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO N° 5', v_user_uuid)
        RETURNING id INTO v_m_id_178_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 1, 2026, 2, 19.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_178_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_178, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_178_19;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_178,
            v_socio_178,
            NULL,
            120.00,
            'Efectivo',
            '32574',
            'Pago histórico recibo N° 32574',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_178_0, 'monto_aplicado', 15.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_178_1, 'monto_aplicado', 22.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_178_2, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_178_3, 'monto_aplicado', 40.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_178_4, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_178_5, 'monto_aplicado', 31.70, 'cubierto_completo', false)),
            0.00,
            '2026-02-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-26 12:00:00-05', created_at = '2026-02-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-26 12:00:00-05', created_at = '2026-02-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_178,
            v_socio_178,
            NULL,
            200.00,
            'Efectivo',
            '32629',
            'Pago histórico recibo N° 32629',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_178_5, 'monto_aplicado', 168.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_178_6, 'monto_aplicado', 20.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_178_7, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_178_8, 'monto_aplicado', 5.30, 'cubierto_completo', false)),
            0.00,
            '2026-03-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-05 12:00:00-05', created_at = '2026-03-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-05 12:00:00-05', created_at = '2026-03-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_178,
            v_socio_178,
            NULL,
            400.00,
            'Efectivo',
            '32712',
            'Pago histórico recibo N° 32712',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_178_8, 'monto_aplicado', 194.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_178_11, 'monto_aplicado', 200.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_178_17, 'monto_aplicado', 5.30, 'cubierto_completo', false)),
            0.00,
            '2026-03-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_178,
            v_socio_178,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_178_9, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_178_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_178,
            v_socio_178,
            NULL,
            260.00,
            'Efectivo',
            '32869',
            'Pago histórico recibo N° 32869',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_178_12, 'monto_aplicado', 20.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_178_13, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_178_14, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_178_18, 'monto_aplicado', 19.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_178_19, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_178_17, 'monto_aplicado', 194.70, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_178,
            v_socio_178,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_178_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_178_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: VILCHEZ GUTARRA LOURDES FANNY (Puesto: 91, ID: 179)
    -- =========================================================================
    DECLARE
        v_socio_179 bigint := 179;
        v_puesto_179 bigint := 187;
        v_m_id_179_0 bigint;
        v_m_id_179_1 bigint;
        v_m_id_179_2 bigint;
        v_m_id_179_3 bigint;
        v_m_id_179_4 bigint;
        v_m_id_179_5 bigint;
        v_m_id_179_6 bigint;
        v_m_id_179_7 bigint;
        v_m_id_179_8 bigint;
        v_m_id_179_9 bigint;
        v_m_id_179_10 bigint;
        v_m_id_179_11 bigint;
        v_m_id_179_12 bigint;
        v_m_id_179_13 bigint;
        v_m_id_179_14 bigint;
        v_m_id_179_15 bigint;
        v_m_id_179_16 bigint;
        v_m_id_179_17 bigint;
        v_m_id_179_18 bigint;
        v_m_id_179_19 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_179 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_179 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_179;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_179 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_179;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 1, 2025, 12, 660.30, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_179_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 2, 2025, 12, 57.10, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_179_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 16, 2025, 12, 200.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - DEPOSITO N° 5', v_user_uuid)
        RETURNING id INTO v_m_id_179_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_179_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_179_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 1, 2026, 1, 727.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_179_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 2, 2026, 1, 69.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_179_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 16, 2026, 1, 200.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - DEPOSITO N° 5', v_user_uuid)
        RETURNING id INTO v_m_id_179_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_179_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_179_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 1, 2026, 2, 729.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_179_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 2, 2026, 2, 72.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_179_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 16, 2026, 2, 200.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO N° 5', v_user_uuid)
        RETURNING id INTO v_m_id_179_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_179_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_179_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 1, 2026, 3, 766.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_179_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 2, 2026, 3, 76.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_179_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 16, 2026, 3, 200.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - DEPOSITO N° 5', v_user_uuid)
        RETURNING id INTO v_m_id_179_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_179_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_179, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_179_19;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_179,
            v_socio_179,
            NULL,
            1913.90,
            'Efectivo',
            '32585',
            'Pago histórico recibo N° 32585',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_179_0, 'monto_aplicado', 660.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_179_1, 'monto_aplicado', 57.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_179_2, 'monto_aplicado', 200.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_179_5, 'monto_aplicado', 727.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_179_6, 'monto_aplicado', 69.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_179_7, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_179,
            v_socio_179,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_179_3, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_179_4, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_179,
            v_socio_179,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_179_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_179_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_179,
            v_socio_179,
            NULL,
            700.00,
            'Efectivo',
            '32694',
            'Pago histórico recibo N° 32694',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_179_10, 'monto_aplicado', 700.00, 'cubierto_completo', false)),
            0.00,
            '2026-03-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_179,
            v_socio_179,
            NULL,
            301.90,
            'Efectivo',
            '32695',
            'Pago histórico recibo N° 32695',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_179_10, 'monto_aplicado', 29.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_179_11, 'monto_aplicado', 72.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_179_12, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_179,
            v_socio_179,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_179_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_179_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_179,
            v_socio_179,
            NULL,
            1042.50,
            'Efectivo',
            '32950',
            'Pago histórico recibo N° 32950',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_179_15, 'monto_aplicado', 766.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_179_16, 'monto_aplicado', 76.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_179_17, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-21 12:00:00-05', created_at = '2026-04-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-21 12:00:00-05', created_at = '2026-04-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_179,
            v_socio_179,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABRIL',
            'Pago mensual vía banco - TARJETA-ABRIL',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_179_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_179_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: VILLANUEVA INGA DE VASQUEZ ROSA PRIMITIVA (Puesto: 168, ID: 180)
    -- =========================================================================
    DECLARE
        v_socio_180 bigint := 180;
        v_puesto_180 bigint := 263;
        v_m_id_180_0 bigint;
        v_m_id_180_1 bigint;
        v_m_id_180_2 bigint;
        v_m_id_180_3 bigint;
        v_m_id_180_4 bigint;
        v_m_id_180_5 bigint;
        v_m_id_180_6 bigint;
        v_m_id_180_7 bigint;
        v_m_id_180_8 bigint;
        v_m_id_180_9 bigint;
        v_m_id_180_10 bigint;
        v_m_id_180_11 bigint;
        v_m_id_180_12 bigint;
        v_m_id_180_13 bigint;
        v_m_id_180_14 bigint;
        v_m_id_180_15 bigint;
        v_m_id_180_16 bigint;
        v_m_id_180_17 bigint;
        v_m_id_180_18 bigint;
        v_m_id_180_19 bigint;
        v_m_id_180_20 bigint;
        v_m_id_180_21 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_180 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_180 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_180;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_180 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_180;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 1, 2025, 11, 35.80, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_180_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_180_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 16, 2025, 11, 200.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - DEPOSITO N° 5', v_user_uuid)
        RETURNING id INTO v_m_id_180_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 1, 2025, 12, 35.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_180_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_180_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 16, 2025, 12, 200.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - DEPOSITO N° 5', v_user_uuid)
        RETURNING id INTO v_m_id_180_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 3, 2026, 1, 260.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_180_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 4, 2026, 1, 15.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_180_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 1, 2026, 1, 34.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_180_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_180_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_180_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_180_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 16, 2026, 2, 200.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO N° 5', v_user_uuid)
        RETURNING id INTO v_m_id_180_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 1, 2026, 2, 33.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_180_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_180_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_180_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_180_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 1, 2026, 3, 34.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_180_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_180_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 16, 2026, 3, 200.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - DEPOSITO N° 5', v_user_uuid)
        RETURNING id INTO v_m_id_180_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_180_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_180, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_180_21;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_180,
            v_socio_180,
            NULL,
            483.70,
            'Efectivo',
            '32434',
            'Pago histórico recibo N° 32434',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_180_0, 'monto_aplicado', 35.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_180_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_180_2, 'monto_aplicado', 200.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_180_3, 'monto_aplicado', 35.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_180_4, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_180_5, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_180,
            v_socio_180,
            NULL,
            19.00,
            'Efectivo',
            '32443',
            'Pago histórico recibo N° 32443',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_180_6, 'monto_aplicado', 14.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_180_7, 'monto_aplicado', 5.00, 'cubierto_completo', false)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_180,
            v_socio_180,
            NULL,
            46.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_180_6, 'monto_aplicado', 46.00, 'cubierto_completo', false)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_180,
            v_socio_180,
            NULL,
            449.90,
            'Efectivo',
            '32639',
            'Pago histórico recibo N° 32639',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_180_8, 'monto_aplicado', 34.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_180_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_180_6, 'monto_aplicado', 200.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_180_7, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_180_12, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-09 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-09 12:00:00-05', created_at = '2026-03-09 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-09 12:00:00-05', created_at = '2026-03-09 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_180,
            v_socio_180,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_180_10, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_180_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_180,
            v_socio_180,
            NULL,
            43.00,
            'Efectivo',
            '32716',
            'Pago histórico recibo N° 32716',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_180_13, 'monto_aplicado', 33.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_180_14, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_180,
            v_socio_180,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_180_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_180_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_180,
            v_socio_180,
            NULL,
            240.20,
            'Efectivo',
            '32981',
            'Pago histórico recibo N° 32981',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_180_17, 'monto_aplicado', 34.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_180_18, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_180_19, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-29 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_180,
            v_socio_180,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABRIL',
            'Pago mensual vía banco - TARJETA-ABRIL',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_180_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_180_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: YAURIMUCHA RIMACHI MARCOS (Puesto: 23, ID: 181)
    -- =========================================================================
    DECLARE
        v_socio_181 bigint := 181;
        v_puesto_181 bigint := 82;
        v_m_id_181_0 bigint;
        v_m_id_181_1 bigint;
        v_m_id_181_2 bigint;
        v_m_id_181_3 bigint;
        v_m_id_181_4 bigint;
        v_m_id_181_5 bigint;
        v_m_id_181_6 bigint;
        v_m_id_181_7 bigint;
        v_m_id_181_8 bigint;
        v_m_id_181_9 bigint;
        v_m_id_181_10 bigint;
        v_m_id_181_11 bigint;
        v_m_id_181_12 bigint;
        v_m_id_181_13 bigint;
        v_m_id_181_14 bigint;
        v_m_id_181_15 bigint;
        v_m_id_181_16 bigint;
        v_m_id_181_17 bigint;
        v_m_id_181_18 bigint;
        v_m_id_181_19 bigint;
        v_m_id_181_20 bigint;
        v_m_id_181_21 bigint;
        v_m_id_181_22 bigint;
        v_m_id_181_23 bigint;
        v_m_id_181_24 bigint;
        v_m_id_181_25 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_181 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_181 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_181;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_181 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_181;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 1, 2025, 11, 69.20, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_181_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_181_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_181_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_181_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 1, 2025, 12, 70.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_181_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_181_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_181_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_181_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 1, 2026, 1, 68.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_181_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_181_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_181_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_181_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_181_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_181_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 1, 2026, 2, 67.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_181_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_181_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_181_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_181_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 1, 2026, 3, 69.90, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_181_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_181_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_181_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_181_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 1, 2026, 4, 57.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_181_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_181_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_181_24;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_181, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_181_25;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_181,
            v_socio_181,
            NULL,
            281.40,
            'Efectivo',
            '32344',
            'Pago histórico recibo N° 32344',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_181_0, 'monto_aplicado', 69.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_4, 'monto_aplicado', 70.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-15 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_181,
            v_socio_181,
            NULL,
            176.50,
            'Efectivo',
            '32616',
            'Pago histórico recibo N° 32616',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_181_8, 'monto_aplicado', 68.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_13, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_181,
            v_socio_181,
            NULL,
            138.20,
            'Efectivo',
            '32764',
            'Pago histórico recibo N° 32764',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_181_14, 'monto_aplicado', 67.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_16, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_181,
            v_socio_181,
            NULL,
            140.90,
            'Efectivo',
            '33040',
            'Pago histórico recibo N° 33040',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_181_18, 'monto_aplicado', 69.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_19, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_181,
            v_socio_181,
            NULL,
            128.00,
            'Efectivo',
            '33123',
            'Pago histórico recibo N° 33123',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_181_22, 'monto_aplicado', 57.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_23, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_24, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_181_25, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: YRUPAILLA FALCON NILDA ADELINA (Puesto: 66, ID: 183)
    -- =========================================================================
    DECLARE
        v_socio_183 bigint := 183;
        v_puesto_183 bigint := 163;
        v_m_id_183_0 bigint;
        v_m_id_183_1 bigint;
        v_m_id_183_2 bigint;
        v_m_id_183_3 bigint;
        v_m_id_183_4 bigint;
        v_m_id_183_5 bigint;
        v_m_id_183_6 bigint;
        v_m_id_183_7 bigint;
        v_m_id_183_8 bigint;
        v_m_id_183_9 bigint;
        v_m_id_183_10 bigint;
        v_m_id_183_11 bigint;
        v_m_id_183_12 bigint;
        v_m_id_183_13 bigint;
        v_m_id_183_14 bigint;
        v_m_id_183_15 bigint;
        v_m_id_183_16 bigint;
        v_m_id_183_17 bigint;
        v_m_id_183_18 bigint;
        v_m_id_183_19 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_183 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_183 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_183;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_183 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_183;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 1, 2025, 11, 43.20, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_183_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_183_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_183_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_183_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 1, 2025, 12, 43.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_183_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_183_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_183_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_183_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 1, 2026, 1, 42.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_183_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_183_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_183_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_183_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_183_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 1, 2026, 2, 42.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_183_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_183_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_183_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_183_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_183_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_183_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_183, 1, 2026, 3, 15.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_183_19;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_183,
            v_socio_183,
            NULL,
            150.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_183_0, 'monto_aplicado', 43.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_4, 'monto_aplicado', 35.80, 'cubierto_completo', false)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_183,
            v_socio_183,
            NULL,
            124.80,
            'Efectivo',
            '32789',
            'Pago histórico recibo N° 32789',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_183_4, 'monto_aplicado', 8.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_8, 'monto_aplicado', 42.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_9, 'monto_aplicado', 3.10, 'cubierto_completo', false)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_183,
            v_socio_183,
            NULL,
            189.90,
            'Efectivo',
            '32790',
            'Pago histórico recibo N° 32790',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_183_9, 'monto_aplicado', 1.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_13, 'monto_aplicado', 42.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_14, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_183,
            v_socio_183,
            NULL,
            80.00,
            'Transferencia',
            'TARJETA-ABRIL',
            'Pago mensual vía banco - TARJETA-ABRIL',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_183_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_18, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_183_19, 'monto_aplicado', 15.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: YRUPAILLA ANAMPA ISIDRO BELISARIO (Puesto: 111, ID: 182)
    -- =========================================================================
    DECLARE
        v_socio_182 bigint := 182;
        v_puesto_182 bigint := 206;
        v_m_id_182_0 bigint;
        v_m_id_182_1 bigint;
        v_m_id_182_2 bigint;
        v_m_id_182_3 bigint;
        v_m_id_182_4 bigint;
        v_m_id_182_5 bigint;
        v_m_id_182_6 bigint;
        v_m_id_182_7 bigint;
        v_m_id_182_8 bigint;
        v_m_id_182_9 bigint;
        v_m_id_182_10 bigint;
        v_m_id_182_11 bigint;
        v_m_id_182_12 bigint;
        v_m_id_182_13 bigint;
        v_m_id_182_14 bigint;
        v_m_id_182_15 bigint;
        v_m_id_182_16 bigint;
        v_m_id_182_17 bigint;
        v_m_id_182_18 bigint;
        v_m_id_182_19 bigint;
        v_m_id_182_20 bigint;
        v_m_id_182_21 bigint;
        v_m_id_182_22 bigint;
        v_m_id_182_23 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_182 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_182 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_182;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_182 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_182;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 1, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_182_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_182_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_182_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_182_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_182_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_182_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 1, 2025, 12, 34.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_182_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 2, 2025, 12, 24.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_182_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_182_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_182_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_182_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 1, 2026, 1, 87.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_182_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 2, 2026, 1, 40.80, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_182_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_182_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_182_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 1, 2026, 2, 23.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_182_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 2, 2026, 2, 20.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_182_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 18, 2026, 3, 300.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - CAMBIO DE GIRO PROVISIONAL', v_user_uuid)
        RETURNING id INTO v_m_id_182_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_182_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_182_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 1, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_182_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 18, 2026, 4, 305.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - CAMBIO DE GIRO PROVISIONAL', v_user_uuid)
        RETURNING id INTO v_m_id_182_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_182_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_182, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_182_23;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_182,
            v_socio_182,
            NULL,
            76.00,
            'Efectivo',
            '32276',
            'Pago histórico recibo N° 32276',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_182_0, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_182_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_182_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_182_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-02 12:00:00-05', created_at = '2026-01-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-02 12:00:00-05', created_at = '2026-01-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_182,
            v_socio_182,
            NULL,
            140.00,
            'Efectivo',
            '32450',
            'Pago histórico recibo N° 32450',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_182_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_182_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_182_8, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_182_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_182_10, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-03 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-03 12:00:00-05', created_at = '2026-02-03 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-03 12:00:00-05', created_at = '2026-02-03 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_182,
            v_socio_182,
            NULL,
            224.10,
            'Efectivo',
            '32687',
            'Pago histórico recibo N° 32687',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_182_6, 'monto_aplicado', 34.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_182_7, 'monto_aplicado', 24.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_182_11, 'monto_aplicado', 87.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_182_12, 'monto_aplicado', 34.80, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_182_15, 'monto_aplicado', 23.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_182_16, 'monto_aplicado', 20.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_182,
            v_socio_182,
            NULL,
            61.00,
            'Efectivo',
            '32635',
            'Pago histórico recibo N° 32635',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_182_13, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_182_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-09 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-09 12:00:00-05', created_at = '2026-03-09 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-09 12:00:00-05', created_at = '2026-03-09 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_182,
            v_socio_182,
            NULL,
            300.00,
            'Efectivo',
            '32673',
            'Pago histórico recibo N° 32673',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_182_17, 'monto_aplicado', 300.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-16 12:00:00-05', created_at = '2026-03-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-16 12:00:00-05', created_at = '2026-03-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_182,
            v_socio_182,
            NULL,
            65.00,
            'Efectivo',
            '32948',
            'Pago histórico recibo N° 32948',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_182_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_182_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-17 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-17 12:00:00-05', created_at = '2026-04-17 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-17 12:00:00-05', created_at = '2026-04-17 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_182,
            v_socio_182,
            NULL,
            81.00,
            'Efectivo',
            '33085',
            'Pago histórico recibo N° 33085',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_182_20, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_182_12, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_182_22, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_182_23, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_182_21, 'monto_aplicado', 5.00, 'cubierto_completo', false)),
            0.00,
            '2026-05-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-18 12:00:00-05', created_at = '2026-05-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-18 12:00:00-05', created_at = '2026-05-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_182,
            v_socio_182,
            NULL,
            300.00,
            'Efectivo',
            '33077',
            'Pago histórico recibo N° 33077',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_182_21, 'monto_aplicado', 300.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-15 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-15 12:00:00-05', created_at = '2026-05-15 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-15 12:00:00-05', created_at = '2026-05-15 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ZAPATA VELIT VICTORIANO (Puesto: 145, ID: 185)
    -- =========================================================================
    DECLARE
        v_socio_185 bigint := 185;
        v_puesto_185 bigint := 240;
        v_m_id_185_0 bigint;
        v_m_id_185_1 bigint;
        v_m_id_185_2 bigint;
        v_m_id_185_3 bigint;
        v_m_id_185_4 bigint;
        v_m_id_185_5 bigint;
        v_m_id_185_6 bigint;
        v_m_id_185_7 bigint;
        v_m_id_185_8 bigint;
        v_m_id_185_9 bigint;
        v_m_id_185_10 bigint;
        v_m_id_185_11 bigint;
        v_m_id_185_12 bigint;
        v_m_id_185_13 bigint;
        v_m_id_185_14 bigint;
        v_m_id_185_15 bigint;
        v_m_id_185_16 bigint;
        v_m_id_185_17 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_185 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_185 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_185;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_185 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_185;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 2, 2026, 1, 39.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_185_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 1, 2025, 12, 410.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_185_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 2, 2025, 12, 19.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_185_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_185_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_185_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 1, 2026, 1, 592.80, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_185_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_185_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_185_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_185_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 1, 2026, 2, 443.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_185_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 2, 2026, 2, 14.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_185_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_185_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_185_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 1, 2026, 3, 40.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_185_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 2, 2026, 3, 20.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_185_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_185_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_185_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_185, 1, 2026, 4, 213.70, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_185_17;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_185,
            v_socio_185,
            NULL,
            494.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía banco - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_185_0, 'monto_aplicado', 19.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_185_1, 'monto_aplicado', 410.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_185_3, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_185_4, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_185,
            v_socio_185,
            NULL,
            310.50,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía banco - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_185_2, 'monto_aplicado', 19.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_185_5, 'monto_aplicado', 230.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_185_7, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_185_8, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_185,
            v_socio_185,
            NULL,
            10.00,
            'Efectivo',
            '32668',
            'Pago histórico recibo N° 32668',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_185_6, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-13 12:00:00-05', created_at = '2026-03-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-13 12:00:00-05', created_at = '2026-03-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_185,
            v_socio_185,
            NULL,
            638.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía banco - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_185_5, 'monto_aplicado', 362.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_185_0, 'monto_aplicado', 20.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_185_9, 'monto_aplicado', 150.20, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_185_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_185_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_185_13, 'monto_aplicado', 40.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_185,
            v_socio_185,
            NULL,
            307.40,
            'Efectivo',
            '32807',
            'Pago histórico recibo N° 32807',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_185_9, 'monto_aplicado', 293.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_185_10, 'monto_aplicado', 14.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_185,
            v_socio_185,
            NULL,
            298.70,
            'Transferencia',
            'TARJETA-ABRIL',
            'Pago mensual vía banco - TARJETA-ABRIL',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_185_14, 'monto_aplicado', 20.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_185_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_185_16, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_185_17, 'monto_aplicado', 213.70, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ZAPATA RIVERA ROSANA (Puesto: 141, ID: 184)
    -- =========================================================================
    DECLARE
        v_socio_184 bigint := 184;
        v_puesto_184 bigint := 236;
        v_m_id_184_0 bigint;
        v_m_id_184_1 bigint;
        v_m_id_184_2 bigint;
        v_m_id_184_3 bigint;
        v_m_id_184_4 bigint;
        v_m_id_184_5 bigint;
        v_m_id_184_6 bigint;
        v_m_id_184_7 bigint;
        v_m_id_184_8 bigint;
        v_m_id_184_9 bigint;
        v_m_id_184_10 bigint;
        v_m_id_184_11 bigint;
        v_m_id_184_12 bigint;
        v_m_id_184_13 bigint;
        v_m_id_184_14 bigint;
        v_m_id_184_15 bigint;
        v_m_id_184_16 bigint;
        v_m_id_184_17 bigint;
        v_m_id_184_18 bigint;
        v_m_id_184_19 bigint;
        v_m_id_184_20 bigint;
        v_m_id_184_21 bigint;
        v_m_id_184_22 bigint;
        v_m_id_184_23 bigint;
        v_m_id_184_24 bigint;
    BEGIN
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_184 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_184 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_184;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_184 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_184;

        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_184_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_184_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 1, 2025, 11, 86.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_184_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 2, 2025, 11, 147.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_184_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_184_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_184_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 1, 2025, 12, 84.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_184_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 2, 2025, 12, 146.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_184_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_184_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_184_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 1, 2026, 1, 86.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_184_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 2, 2026, 1, 158.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_184_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_184_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_184_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_184_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_184_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 1, 2026, 2, 74.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_184_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 2, 2026, 2, 121.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_184_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_184_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_184_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 1, 2026, 3, 80.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_184_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 2, 2026, 3, 193.90, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_184_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_184_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_184_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_184, 18, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - FUMIGACION', v_user_uuid)
        RETURNING id INTO v_m_id_184_24;
        v_cant_deudas := v_cant_deudas + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_184,
            v_socio_184,
            NULL,
            65.00,
            'Efectivo',
            '32274',
            'Pago histórico recibo N° 32274',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_184_0, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_184_1, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-02 12:00:00-05', created_at = '2026-01-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-02 12:00:00-05', created_at = '2026-01-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_184,
            v_socio_184,
            NULL,
            233.90,
            'Efectivo',
            '32410',
            'Pago histórico recibo N° 32410',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_184_2, 'monto_aplicado', 86.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_184_3, 'monto_aplicado', 147.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_184,
            v_socio_184,
            NULL,
            130.00,
            'Efectivo',
            '32418',
            'Pago histórico recibo N° 32418',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_184_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_184_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_184_8, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_184_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_184,
            v_socio_184,
            NULL,
            230.00,
            'Efectivo',
            '32563',
            'Pago histórico recibo N° 32563',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_184_6, 'monto_aplicado', 84.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_184_7, 'monto_aplicado', 146.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-24 12:00:00-05', created_at = '2026-02-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-24 12:00:00-05', created_at = '2026-02-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_184,
            v_socio_184,
            NULL,
            0.60,
            'Efectivo',
            '32564',
            'Pago histórico recibo N° 32564',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_184_6, 'monto_aplicado', 0.60, 'cubierto_completo', true)),
            0.00,
            '2026-02-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-24 12:00:00-05', created_at = '2026-02-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-24 12:00:00-05', created_at = '2026-02-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_184,
            v_socio_184,
            NULL,
            244.90,
            'Efectivo',
            '32633',
            'Pago histórico recibo N° 32633',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_184_10, 'monto_aplicado', 86.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_184_11, 'monto_aplicado', 158.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-09 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-09 12:00:00-05', created_at = '2026-03-09 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-09 12:00:00-05', created_at = '2026-03-09 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_184,
            v_socio_184,
            NULL,
            10.00,
            'Efectivo',
            '32669',
            'Pago histórico recibo N° 32669',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_184_12, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-13 12:00:00-05', created_at = '2026-03-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-13 12:00:00-05', created_at = '2026-03-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_184,
            v_socio_184,
            NULL,
            28.30,
            'Efectivo',
            '32678',
            'Pago histórico recibo N° 32678',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_184_13, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-17 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-17 12:00:00-05', created_at = '2026-03-17 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-17 12:00:00-05', created_at = '2026-03-17 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_184,
            v_socio_184,
            NULL,
            61.00,
            'Efectivo',
            '32634',
            'Pago histórico recibo N° 32634',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_184_14, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_184_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-09 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-09 12:00:00-05', created_at = '2026-03-09 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-09 12:00:00-05', created_at = '2026-03-09 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_184,
            v_socio_184,
            NULL,
            196.50,
            'Efectivo',
            '32749',
            'Pago histórico recibo N° 32749',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_184_16, 'monto_aplicado', 74.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_184_17, 'monto_aplicado', 121.90, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_184,
            v_socio_184,
            NULL,
            65.00,
            'Efectivo',
            '32967',
            'Pago histórico recibo N° 32967',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_184_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_184_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-27 12:00:00-05', created_at = '2026-04-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-27 12:00:00-05', created_at = '2026-04-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_184,
            v_socio_184,
            NULL,
            279.60,
            'Efectivo',
            '33095',
            'Pago histórico recibo N° 33095',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_184_20, 'monto_aplicado', 80.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_184_21, 'monto_aplicado', 193.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_184_24, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-20 12:00:00-05', created_at = '2026-05-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-20 12:00:00-05', created_at = '2026-05-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_184,
            v_socio_184,
            NULL,
            65.00,
            'Efectivo',
            '33080',
            'Pago histórico recibo N° 33080',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_184_22, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_184_23, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-16 12:00:00-05', created_at = '2026-05-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-16 12:00:00-05', created_at = '2026-05-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    RAISE NOTICE '==================================================';
    RAISE NOTICE 'MIGRACIÓN DE SOCIOS EN ESTE BLOQUE COMPLETADA';
    RAISE NOTICE '  Deudas individuales creadas: %', v_cant_deudas;
    RAISE NOTICE '  Pagos agrupados procesados:  %', v_cant_pagos;
    RAISE NOTICE '==================================================';
END $$;