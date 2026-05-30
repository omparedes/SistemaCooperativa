-- =============================================================================
-- Migración 00048 — Carga de Pagos Detallados 2026 (Lista Socios A-C)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- Generado: 2026-05-30
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
    -- SOCIO: AGUIRRE QUISPE WILFREDO GILMER (Puesto: 134, ID: 1)
    -- =========================================================================
    DECLARE
        v_socio_1 bigint := 1;
        v_puesto_1 bigint := 229;
        v_m_id_1_0 bigint;
        v_m_id_1_1 bigint;
        v_m_id_1_2 bigint;
        v_m_id_1_3 bigint;
        v_m_id_1_4 bigint;
        v_m_id_1_5 bigint;
        v_m_id_1_6 bigint;
        v_m_id_1_7 bigint;
        v_m_id_1_8 bigint;
        v_m_id_1_9 bigint;
        v_m_id_1_10 bigint;
        v_m_id_1_11 bigint;
        v_m_id_1_12 bigint;
        v_m_id_1_13 bigint;
        v_m_id_1_14 bigint;
        v_m_id_1_15 bigint;
        v_m_id_1_16 bigint;
        v_m_id_1_17 bigint;
        v_m_id_1_18 bigint;
        v_m_id_1_19 bigint;
        v_m_id_1_20 bigint;
        v_m_id_1_21 bigint;
        v_m_id_1_22 bigint;
        v_m_id_1_23 bigint;
        v_m_id_1_24 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_1 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_1 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_1;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_1 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_1;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 1, 2025, 11, 32.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_1_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_1_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 7, 2025, 11, 200.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_1_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 3, 2025, 12, 30.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_1_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_1_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 7, 2025, 12, 200.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_1_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 1, 2025, 12, 32.10, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_1_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_1_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_1_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_1_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 7, 2026, 1, 200.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_1_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 1, 2026, 1, 20.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_1_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_1_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_1_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_1_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 7, 2026, 2, 200.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_1_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 1, 2026, 2, 22.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_1_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_1_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_1_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_1_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 1, 2026, 3, 31.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_1_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_1_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 7, 2026, 3, 200.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_1_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_1_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_1, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_1_24;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_1,
            v_socio_1,
            NULL,
            473.90,
            'Efectivo',
            '32303',
            'Pago histórico recibo N° 32303',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_1_0, 'monto_aplicado', 32.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_1_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_1_2, 'monto_aplicado', 200.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_1_3, 'monto_aplicado', 30.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_1_4, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_1_5, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-08 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-08 12:00:00-05', created_at = '2026-01-08 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-08 12:00:00-05', created_at = '2026-01-08 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_1,
            v_socio_1,
            NULL,
            238.10,
            'Efectivo',
            '32474',
            'Pago histórico recibo N° 32474',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_1_6, 'monto_aplicado', 32.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_1_7, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_1_10, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-06 12:00:00-05', created_at = '2026-02-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-06 12:00:00-05', created_at = '2026-02-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_1,
            v_socio_1,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_1_8, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_1_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_1,
            v_socio_1,
            NULL,
            257.30,
            'Efectivo',
            '32776',
            'Pago histórico recibo N° 32776',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_1_11, 'monto_aplicado', 20.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_1_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_1_15, 'monto_aplicado', 200.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_1_16, 'monto_aplicado', 22.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_1_17, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_1,
            v_socio_1,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_1_13, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_1_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_1,
            v_socio_1,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_1_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_1_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_1,
            v_socio_1,
            NULL,
            237.40,
            'Efectivo',
            '33072',
            'Pago histórico recibo N° 33072',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_1_20, 'monto_aplicado', 31.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_1_21, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_1_22, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-14 12:00:00-05', created_at = '2026-05-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-14 12:00:00-05', created_at = '2026-05-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_1,
            v_socio_1,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_1_23, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_1_24, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ALARCON ANAMPA BETSY JANET (Puesto: 63, ID: 2)
    -- =========================================================================
    DECLARE
        v_socio_2 bigint := 2;
        v_puesto_2 bigint := 160;
        v_m_id_2_0 bigint;
        v_m_id_2_1 bigint;
        v_m_id_2_2 bigint;
        v_m_id_2_3 bigint;
        v_m_id_2_4 bigint;
        v_m_id_2_5 bigint;
        v_m_id_2_6 bigint;
        v_m_id_2_7 bigint;
        v_m_id_2_8 bigint;
        v_m_id_2_9 bigint;
        v_m_id_2_10 bigint;
        v_m_id_2_11 bigint;
        v_m_id_2_12 bigint;
        v_m_id_2_13 bigint;
        v_m_id_2_14 bigint;
        v_m_id_2_15 bigint;
        v_m_id_2_16 bigint;
        v_m_id_2_17 bigint;
        v_m_id_2_18 bigint;
        v_m_id_2_19 bigint;
        v_m_id_2_20 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_2 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_2 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_2;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_2 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_2;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 1, 2025, 11, 39.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_2_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_2_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 3, 2025, 11, 50.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_2_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_2_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 1, 2025, 12, 40.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_2_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_2_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 3, 2025, 12, 50.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_2_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_2_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 1, 2026, 1, 39.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_2_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_2_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_2_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_2_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_2_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 1, 2026, 2, 38.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_2_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_2_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_2_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_2_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 1, 2026, 3, 40.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_2_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_2_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_2_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_2, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_2_20;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_2,
            v_socio_2,
            NULL,
            91.80,
            'Efectivo',
            '32380',
            'Pago histórico recibo N° 32380',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_2_0, 'monto_aplicado', 39.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_2_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_2_4, 'monto_aplicado', 40.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_2_5, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_2,
            v_socio_2,
            NULL,
            110.00,
            'Efectivo',
            '32396',
            'Pago histórico recibo N° 32396',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_2_2, 'monto_aplicado', 50.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_2_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_2_6, 'monto_aplicado', 50.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_2_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_2,
            v_socio_2,
            NULL,
            229.20,
            'Efectivo',
            '32812',
            'Pago histórico recibo N° 32812',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_2_8, 'monto_aplicado', 39.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_2_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_2_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_2_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_2_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_2_13, 'monto_aplicado', 38.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_2_14, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_2_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_2_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_2,
            v_socio_2,
            NULL,
            70.00,
            'Efectivo',
            '33127',
            'Pago histórico recibo N° 33127',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_2_17, 'monto_aplicado', 40.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_2_18, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_2_19, 'monto_aplicado', 23.70, 'cubierto_completo', false)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_2,
            v_socio_2,
            NULL,
            41.30,
            'Efectivo',
            '33128',
            'Pago histórico recibo N° 33128',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_2_19, 'monto_aplicado', 36.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_2_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ALARCON ANAMPA NANCY GUISELA (Puesto: 59, ID: 3)
    -- =========================================================================
    DECLARE
        v_socio_3 bigint := 3;
        v_puesto_3 bigint := 152;
        v_m_id_3_0 bigint;
        v_m_id_3_1 bigint;
        v_m_id_3_2 bigint;
        v_m_id_3_3 bigint;
        v_m_id_3_4 bigint;
        v_m_id_3_5 bigint;
        v_m_id_3_6 bigint;
        v_m_id_3_7 bigint;
        v_m_id_3_8 bigint;
        v_m_id_3_9 bigint;
        v_m_id_3_10 bigint;
        v_m_id_3_11 bigint;
        v_m_id_3_12 bigint;
        v_m_id_3_13 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_3 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_3 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_3;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_3 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_3;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_3, 1, 2025, 11, 46.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_3_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_3, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_3_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_3, 1, 2025, 12, 47.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_3_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_3, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_3_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_3, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_3_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_3, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_3_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_3, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_3_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_3, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_3_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_3, 1, 2026, 1, 46.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_3_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_3, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_3_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_3, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_3_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_3, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_3_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_3, 1, 2026, 2, 45.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_3_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_3, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_3_13;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_3,
            v_socio_3,
            NULL,
            106.10,
            'Efectivo',
            '32469',
            'Pago histórico recibo N° 32469',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_3_0, 'monto_aplicado', 46.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_3_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_3_2, 'monto_aplicado', 47.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_3_3, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_3,
            v_socio_3,
            NULL,
            130.00,
            'Efectivo',
            '32657',
            'Pago histórico recibo N° 32657',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_3_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_3_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_3_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_3_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_3,
            v_socio_3,
            NULL,
            106.40,
            'Efectivo',
            '32842',
            'Pago histórico recibo N° 32842',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_3_8, 'monto_aplicado', 46.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_3_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_3_12, 'monto_aplicado', 45.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_3_13, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_3,
            v_socio_3,
            NULL,
            61.00,
            'Efectivo',
            '32683',
            'Pago histórico recibo N° 32683',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_3_10, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_3_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-17 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-17 12:00:00-05', created_at = '2026-03-17 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-17 12:00:00-05', created_at = '2026-03-17 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ALHUAY PALOMINO DE ALHUAY JUANA (Puesto: 181, ID: 4)
    -- =========================================================================
    DECLARE
        v_socio_4 bigint := 4;
        v_puesto_4 bigint := 275;
        v_m_id_4_0 bigint;
        v_m_id_4_1 bigint;
        v_m_id_4_2 bigint;
        v_m_id_4_3 bigint;
        v_m_id_4_4 bigint;
        v_m_id_4_5 bigint;
        v_m_id_4_6 bigint;
        v_m_id_4_7 bigint;
        v_m_id_4_8 bigint;
        v_m_id_4_9 bigint;
        v_m_id_4_10 bigint;
        v_m_id_4_11 bigint;
        v_m_id_4_12 bigint;
        v_m_id_4_13 bigint;
        v_m_id_4_14 bigint;
        v_m_id_4_15 bigint;
        v_m_id_4_16 bigint;
        v_m_id_4_17 bigint;
        v_m_id_4_18 bigint;
        v_m_id_4_19 bigint;
        v_m_id_4_20 bigint;
        v_m_id_4_21 bigint;
        v_m_id_4_22 bigint;
        v_m_id_4_23 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_4 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_4 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_4;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_4 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_4;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 1, 2025, 11, 30.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_4_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 2, 2025, 11, 26.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_4_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_4_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_4_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 1, 2025, 12, 30.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_4_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 2, 2025, 12, 31.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_4_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_4_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_4_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 1, 2026, 1, 28.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_4_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 2, 2026, 1, 33.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_4_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_4_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_4_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_4_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_4_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 1, 2026, 2, 27.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_4_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 2, 2026, 2, 37.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_4_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_4_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_4_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 1, 2026, 3, 27.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_4_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 2, 2026, 3, 39.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_4_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_4_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_4_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 1, 2026, 4, 28.70, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_4_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_4, 2, 2026, 4, 32.80, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_4_23;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_4,
            v_socio_4,
            NULL,
            56.80,
            'Efectivo',
            '32277',
            'Pago histórico recibo N° 32277',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_4_0, 'monto_aplicado', 30.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_4_1, 'monto_aplicado', 26.30, 'cubierto_completo', true)),
            0.00,
            '2026-01-03 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-03 12:00:00-05', created_at = '2026-01-03 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-03 12:00:00-05', created_at = '2026-01-03 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_4,
            v_socio_4,
            NULL,
            65.00,
            'Efectivo',
            '32305',
            'Pago histórico recibo N° 32305',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_4_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_4_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-09 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-09 12:00:00-05', created_at = '2026-01-09 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-09 12:00:00-05', created_at = '2026-01-09 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_4,
            v_socio_4,
            NULL,
            61.40,
            'Efectivo',
            '32397',
            'Pago histórico recibo N° 32397',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_4_4, 'monto_aplicado', 30.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_4_5, 'monto_aplicado', 31.40, 'cubierto_completo', true)),
            0.00,
            '2026-01-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_4,
            v_socio_4,
            NULL,
            65.00,
            'Efectivo',
            '32431',
            'Pago histórico recibo N° 32431',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_4_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_4_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_4,
            v_socio_4,
            NULL,
            61.60,
            'Efectivo',
            '32569',
            'Pago histórico recibo N° 32569',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_4_8, 'monto_aplicado', 28.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_4_9, 'monto_aplicado', 33.20, 'cubierto_completo', true)),
            0.00,
            '2026-02-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-25 12:00:00-05', created_at = '2026-02-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-25 12:00:00-05', created_at = '2026-02-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_4,
            v_socio_4,
            NULL,
            10.00,
            'Efectivo',
            '32575',
            'Pago histórico recibo N° 32575',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_4_10, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-26 12:00:00-05', created_at = '2026-02-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-26 12:00:00-05', created_at = '2026-02-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_4,
            v_socio_4,
            NULL,
            92.90,
            'Efectivo',
            '32770',
            'Pago histórico recibo N° 32770',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_4_11, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_4_14, 'monto_aplicado', 27.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_4_15, 'monto_aplicado', 37.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_4,
            v_socio_4,
            NULL,
            61.00,
            'Efectivo',
            '32576',
            'Pago histórico recibo N° 32576',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_4_12, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_4_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-26 12:00:00-05', created_at = '2026-02-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-26 12:00:00-05', created_at = '2026-02-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_4,
            v_socio_4,
            NULL,
            65.00,
            'Efectivo',
            '32925',
            'Pago histórico recibo N° 32925',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_4_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_4_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-27 12:00:00-05', created_at = '2026-03-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-27 12:00:00-05', created_at = '2026-03-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_4,
            v_socio_4,
            NULL,
            66.10,
            'Efectivo',
            '33002',
            'Pago histórico recibo N° 33002',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_4_18, 'monto_aplicado', 27.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_4_19, 'monto_aplicado', 39.10, 'cubierto_completo', true)),
            0.00,
            '2026-05-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-04 12:00:00-05', created_at = '2026-05-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-04 12:00:00-05', created_at = '2026-05-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_4,
            v_socio_4,
            NULL,
            65.00,
            'Efectivo',
            '33045',
            'Pago histórico recibo N° 33045',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_4_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_4_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_4,
            v_socio_4,
            NULL,
            61.50,
            'Efectivo',
            '33108',
            'Pago histórico recibo N° 33108',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_4_22, 'monto_aplicado', 28.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_4_23, 'monto_aplicado', 32.80, 'cubierto_completo', true)),
            0.00,
            '2026-05-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ALVAREZ CAMPOS ROLANDO (Puesto: 73, ID: 5)
    -- =========================================================================
    DECLARE
        v_socio_5 bigint := 5;
        v_puesto_5 bigint := 170;
        v_m_id_5_0 bigint;
        v_m_id_5_1 bigint;
        v_m_id_5_2 bigint;
        v_m_id_5_3 bigint;
        v_m_id_5_4 bigint;
        v_m_id_5_5 bigint;
        v_m_id_5_6 bigint;
        v_m_id_5_7 bigint;
        v_m_id_5_8 bigint;
        v_m_id_5_9 bigint;
        v_m_id_5_10 bigint;
        v_m_id_5_11 bigint;
        v_m_id_5_12 bigint;
        v_m_id_5_13 bigint;
        v_m_id_5_14 bigint;
        v_m_id_5_15 bigint;
        v_m_id_5_16 bigint;
        v_m_id_5_17 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_5 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_5 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_5;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_5 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_5;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 7, 2025, 11, 132.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_5_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 1, 2025, 12, 61.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_5_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_5_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 7, 2025, 12, 115.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_5_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_5_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_5_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 1, 2026, 1, 60.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_5_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 7, 2026, 1, 200.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_5_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_5_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_5_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_5_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 1, 2026, 2, 59.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_5_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_5_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 7, 2026, 2, 200.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_5_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_5_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_5_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 1, 2026, 3, 35.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_5_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_5, 7, 2026, 3, 100.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_5_17;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_5,
            v_socio_5,
            NULL,
            250.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_5_0, 'monto_aplicado', 132.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_5_1, 'monto_aplicado', 53.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_5_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_5_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_5,
            v_socio_5,
            NULL,
            200.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_5_1, 'monto_aplicado', 8.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_5_2, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_5_6, 'monto_aplicado', 24.10, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_5_7, 'monto_aplicado', 100.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_5_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_5_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_5,
            v_socio_5,
            NULL,
            150.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_5_3, 'monto_aplicado', 115.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_5_6, 'monto_aplicado', 35.00, 'cubierto_completo', false)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_5,
            v_socio_5,
            NULL,
            375.20,
            'Efectivo',
            '32787',
            'Pago histórico recibo N° 32787',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_5_6, 'monto_aplicado', 1.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_5_8, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_5_7, 'monto_aplicado', 100.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_5_11, 'monto_aplicado', 59.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_5_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_5_13, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_5,
            v_socio_5,
            NULL,
            200.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_5_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_5_15, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_5_16, 'monto_aplicado', 35.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_5_17, 'monto_aplicado', 100.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ALVAREZ CAMPOS VICTOR ADRIANO (Puesto: 155, ID: 6)
    -- =========================================================================
    DECLARE
        v_socio_6 bigint := 6;
        v_puesto_6 bigint := 250;
        v_m_id_6_0 bigint;
        v_m_id_6_1 bigint;
        v_m_id_6_2 bigint;
        v_m_id_6_3 bigint;
        v_m_id_6_4 bigint;
        v_m_id_6_5 bigint;
        v_m_id_6_6 bigint;
        v_m_id_6_7 bigint;
        v_m_id_6_8 bigint;
        v_m_id_6_9 bigint;
        v_m_id_6_10 bigint;
        v_m_id_6_11 bigint;
        v_m_id_6_12 bigint;
        v_m_id_6_13 bigint;
        v_m_id_6_14 bigint;
        v_m_id_6_15 bigint;
        v_m_id_6_16 bigint;
        v_m_id_6_17 bigint;
        v_m_id_6_18 bigint;
        v_m_id_6_19 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_6 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_6 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_6;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_6 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_6;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 1, 2025, 11, 19.20, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_6_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_6_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 1, 2025, 12, 10.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_6_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_6_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_6_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_6_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_6_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 1, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_6_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_6_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_6_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_6_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_6_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 1, 2026, 2, 16.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_6_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_6_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_6_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_6_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_6_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_6_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', '2026-05-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_6_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_6, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', '2026-05-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_6_19;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_6,
            v_socio_6,
            NULL,
            112.20,
            'Efectivo',
            '32750',
            'Pago histórico recibo N° 32750',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_6_0, 'monto_aplicado', 19.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_6_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_6_2, 'monto_aplicado', 10.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_6_3, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_6_7, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_6_8, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_6_9, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_6_12, 'monto_aplicado', 16.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_6_13, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_6,
            v_socio_6,
            NULL,
            65.00,
            'Efectivo',
            '32390',
            'Pago histórico recibo N° 32390',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_6_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_6_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-22 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-22 12:00:00-05', created_at = '2026-01-22 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-22 12:00:00-05', created_at = '2026-01-22 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_6,
            v_socio_6,
            NULL,
            71.00,
            'Efectivo',
            '32591',
            'Pago histórico recibo N° 32591',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_6_6, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_6_10, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_6_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_6,
            v_socio_6,
            NULL,
            65.00,
            'Efectivo',
            '32679',
            'Pago histórico recibo N° 32679',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_6_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_6_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-17 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-17 12:00:00-05', created_at = '2026-03-17 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-17 12:00:00-05', created_at = '2026-03-17 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_6,
            v_socio_6,
            NULL,
            65.00,
            'Efectivo',
            '32969',
            'Pago histórico recibo N° 32969',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_6_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_6_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_6,
            v_socio_6,
            NULL,
            65.00,
            'Efectivo',
            '33089',
            'Pago histórico recibo N° 33089',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_6_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_6_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-19 12:00:00-05', created_at = '2026-05-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-19 12:00:00-05', created_at = '2026-05-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ALVAREZ MARIN MARIANELA (Puesto: 80, ID: 7)
    -- =========================================================================
    DECLARE
        v_socio_7 bigint := 7;
        v_puesto_7 bigint := 176;
        v_m_id_7_0 bigint;
        v_m_id_7_1 bigint;
        v_m_id_7_2 bigint;
        v_m_id_7_3 bigint;
        v_m_id_7_4 bigint;
        v_m_id_7_5 bigint;
        v_m_id_7_6 bigint;
        v_m_id_7_7 bigint;
        v_m_id_7_8 bigint;
        v_m_id_7_9 bigint;
        v_m_id_7_10 bigint;
        v_m_id_7_11 bigint;
        v_m_id_7_12 bigint;
        v_m_id_7_13 bigint;
        v_m_id_7_14 bigint;
        v_m_id_7_15 bigint;
        v_m_id_7_16 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_7 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_7 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_7;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_7 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_7;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_7, 1, 2025, 11, 9.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_7_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_7, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_7_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_7, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_7_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_7, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_7_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_7, 1, 2025, 12, 9.10, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_7_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_7, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_7_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_7, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_7_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_7, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_7_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_7, 1, 2026, 1, 7.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_7_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_7, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_7_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_7, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_7_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_7, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_7_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_7, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_7_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_7, 1, 2026, 2, 7.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_7_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_7, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_7_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_7, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_7_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_7, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_7_16;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_7,
            v_socio_7,
            NULL,
            237.40,
            'Efectivo',
            '32852',
            'Pago histórico recibo N° 32852',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_7_0, 'monto_aplicado', 9.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_7_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_7_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_7_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_7_4, 'monto_aplicado', 9.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_7_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_7_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_7_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_7_8, 'monto_aplicado', 7.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_7_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_7_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_7_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_7,
            v_socio_7,
            NULL,
            88.40,
            'Efectivo',
            '32853',
            'Pago histórico recibo N° 32853',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_7_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_7_13, 'monto_aplicado', 7.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_7_14, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_7_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_7_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ANAMPA CORAHUA CLEMENCIA MIGDONIA (Puesto: 60, ID: 8)
    -- =========================================================================
    DECLARE
        v_socio_8 bigint := 8;
        v_puesto_8 bigint := 154;
        v_m_id_8_0 bigint;
        v_m_id_8_1 bigint;
        v_m_id_8_2 bigint;
        v_m_id_8_3 bigint;
        v_m_id_8_4 bigint;
        v_m_id_8_5 bigint;
        v_m_id_8_6 bigint;
        v_m_id_8_7 bigint;
        v_m_id_8_8 bigint;
        v_m_id_8_9 bigint;
        v_m_id_8_10 bigint;
        v_m_id_8_11 bigint;
        v_m_id_8_12 bigint;
        v_m_id_8_13 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_8 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_8 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_8;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_8 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_8;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_8, 1, 2025, 11, 73.20, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_8_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_8, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_8_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_8, 1, 2025, 12, 74.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_8_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_8, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_8_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_8, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_8_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_8, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_8_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_8, 1, 2026, 1, 72.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_8_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_8, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_8_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_8, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_8_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_8, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_8_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_8, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_8_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_8, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_8_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_8, 1, 2026, 2, 71.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_8_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_8, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_8_13;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_8,
            v_socio_8,
            NULL,
            159.40,
            'Efectivo',
            '32422',
            'Pago histórico recibo N° 32422',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_8_0, 'monto_aplicado', 73.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_8_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_8_2, 'monto_aplicado', 74.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_8_3, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_8,
            v_socio_8,
            NULL,
            191.00,
            'Efectivo',
            '32684',
            'Pago histórico recibo N° 32684',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_8_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_8_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_8_8, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_8_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_8_10, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_8_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-17 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-17 12:00:00-05', created_at = '2026-03-17 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-17 12:00:00-05', created_at = '2026-03-17 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_8,
            v_socio_8,
            NULL,
            77.10,
            'Efectivo',
            '32660',
            'Pago histórico recibo N° 32660',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_8_6, 'monto_aplicado', 72.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_8_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_8,
            v_socio_8,
            NULL,
            81.10,
            'Efectivo',
            '32878',
            'Pago histórico recibo N° 32878',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_8_12, 'monto_aplicado', 71.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_8_13, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ANCCO LEON VALENTINA (Puesto: 48, ID: 9)
    -- =========================================================================
    DECLARE
        v_socio_9 bigint := 9;
        v_puesto_9 bigint := 130;
        v_m_id_9_0 bigint;
        v_m_id_9_1 bigint;
        v_m_id_9_2 bigint;
        v_m_id_9_3 bigint;
        v_m_id_9_4 bigint;
        v_m_id_9_5 bigint;
        v_m_id_9_6 bigint;
        v_m_id_9_7 bigint;
        v_m_id_9_8 bigint;
        v_m_id_9_9 bigint;
        v_m_id_9_10 bigint;
        v_m_id_9_11 bigint;
        v_m_id_9_12 bigint;
        v_m_id_9_13 bigint;
        v_m_id_9_14 bigint;
        v_m_id_9_15 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_9 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_9 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_9;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_9 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_9;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_9, 1, 2025, 11, 26.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_9_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_9, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_9_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_9, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_9_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_9, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_9_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_9, 1, 2025, 12, 26.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_9_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_9, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_9_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_9, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_9_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_9, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_9_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_9, 1, 2026, 1, 26.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_9_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_9, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_9_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_9, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_9_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_9, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_9_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_9, 1, 2026, 2, 25.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_9_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_9, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_9_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_9, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_9_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_9, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_9_15;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_9,
            v_socio_9,
            NULL,
            195.00,
            'Efectivo',
            '32384',
            'Pago histórico recibo N° 32384',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_9_0, 'monto_aplicado', 26.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_9_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_9_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_9_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_9_4, 'monto_aplicado', 26.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_9_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_9_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_9_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_9,
            v_socio_9,
            NULL,
            192.60,
            'Efectivo',
            '32905',
            'Pago histórico recibo N° 32905',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_9_8, 'monto_aplicado', 26.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_9_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_9_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_9_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_9_12, 'monto_aplicado', 25.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_9_13, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_9_14, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_9_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ATANASIO ORTEGA MAXIMILIANA (Puesto: 179, ID: 10)
    -- =========================================================================
    DECLARE
        v_socio_10 bigint := 10;
        v_puesto_10 bigint := 273;
        v_m_id_10_0 bigint;
        v_m_id_10_1 bigint;
        v_m_id_10_2 bigint;
        v_m_id_10_3 bigint;
        v_m_id_10_4 bigint;
        v_m_id_10_5 bigint;
        v_m_id_10_6 bigint;
        v_m_id_10_7 bigint;
        v_m_id_10_8 bigint;
        v_m_id_10_9 bigint;
        v_m_id_10_10 bigint;
        v_m_id_10_11 bigint;
        v_m_id_10_12 bigint;
        v_m_id_10_13 bigint;
        v_m_id_10_14 bigint;
        v_m_id_10_15 bigint;
        v_m_id_10_16 bigint;
        v_m_id_10_17 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_10 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_10 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_10;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_10 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_10;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 1, 2025, 11, 44.80, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_10_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_10_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_10_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 1, 2025, 12, 27.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_10_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_10_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_10_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_10_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_10_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_10_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 1, 2026, 1, 27.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_10_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_10_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_10_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_10_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_10_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 1, 2026, 2, 26.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_10_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_10_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_10_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_10, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_10_17;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_10,
            v_socio_10,
            NULL,
            84.40,
            'Efectivo',
            '32485',
            'Pago histórico recibo N° 32485',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_10_0, 'monto_aplicado', 44.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_10_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_10_3, 'monto_aplicado', 27.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_10_4, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-10 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-10 12:00:00-05', created_at = '2026-02-10 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-10 12:00:00-05', created_at = '2026-02-10 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_10,
            v_socio_10,
            NULL,
            30.00,
            'Efectivo',
            '32690',
            'Pago histórico recibo N° 32690',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_10_2, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_10_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_10_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_10_8, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_10_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_10,
            v_socio_10,
            NULL,
            60.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_10_6, 'monto_aplicado', 60.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_10,
            v_socio_10,
            NULL,
            97.30,
            'Efectivo',
            '32889',
            'Pago histórico recibo N° 32889',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_10_9, 'monto_aplicado', 27.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_10_10, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_10_11, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_10_14, 'monto_aplicado', 26.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_10_15, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_10,
            v_socio_10,
            NULL,
            56.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_10_12, 'monto_aplicado', 56.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_10,
            v_socio_10,
            NULL,
            60.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_10_16, 'monto_aplicado', 60.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_10,
            v_socio_10,
            NULL,
            60.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_10_17, 'monto_aplicado', 60.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: AYALA HUASHUAYO NORMA GLADYS (Puesto: 12, ID: 11)
    -- =========================================================================
    DECLARE
        v_socio_11 bigint := 11;
        v_puesto_11 bigint := 60;
        v_m_id_11_0 bigint;
        v_m_id_11_1 bigint;
        v_m_id_11_2 bigint;
        v_m_id_11_3 bigint;
        v_m_id_11_4 bigint;
        v_m_id_11_5 bigint;
        v_m_id_11_6 bigint;
        v_m_id_11_7 bigint;
        v_m_id_11_8 bigint;
        v_m_id_11_9 bigint;
        v_m_id_11_10 bigint;
        v_m_id_11_11 bigint;
        v_m_id_11_12 bigint;
        v_m_id_11_13 bigint;
        v_m_id_11_14 bigint;
        v_m_id_11_15 bigint;
        v_m_id_11_16 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_11 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_11 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_11;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_11 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_11;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_11, 1, 2025, 12, 21.10, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_11_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_11, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_11_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_11, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_11_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_11, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_11_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_11, 1, 2026, 1, 20.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_11_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_11, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_11_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_11, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_11_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_11, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_11_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_11, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_11_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_11, 1, 2026, 2, 20.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_11_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_11, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_11_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_11, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_11_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_11, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_11_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_11, 1, 2026, 3, 21.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_11_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_11, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_11_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_11, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_11_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_11, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_11_16;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_11,
            v_socio_11,
            NULL,
            92.10,
            'Efectivo',
            '32471',
            'Pago histórico recibo N° 32471',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_11_0, 'monto_aplicado', 21.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_11_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_11_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_11_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-05 12:00:00-05', created_at = '2026-02-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-05 12:00:00-05', created_at = '2026-02-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_11,
            v_socio_11,
            NULL,
            86.50,
            'Efectivo',
            '32625',
            'Pago histórico recibo N° 32625',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_11_4, 'monto_aplicado', 20.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_11_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_11_7, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_11_8, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-05 12:00:00-05', created_at = '2026-03-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-05 12:00:00-05', created_at = '2026-03-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_11,
            v_socio_11,
            NULL,
            58.50,
            'Efectivo',
            '32896',
            'Pago histórico recibo N° 32896',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_11_6, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_11_9, 'monto_aplicado', 20.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_11_10, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_11,
            v_socio_11,
            NULL,
            65.00,
            'Efectivo',
            '32931',
            'Pago histórico recibo N° 32931',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_11_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_11_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-08 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-08 12:00:00-05', created_at = '2026-04-08 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-08 12:00:00-05', created_at = '2026-04-08 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_11,
            v_socio_11,
            NULL,
            92.40,
            'Efectivo',
            '33037',
            'Pago histórico recibo N° 33037',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_11_13, 'monto_aplicado', 21.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_11_14, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_11_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_11_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: AYALA TABOADA ELISEO (Puesto: 10, ID: 12)
    -- =========================================================================
    DECLARE
        v_socio_12 bigint := 12;
        v_puesto_12 bigint := 55;
        v_m_id_12_0 bigint;
        v_m_id_12_1 bigint;
        v_m_id_12_2 bigint;
        v_m_id_12_3 bigint;
        v_m_id_12_4 bigint;
        v_m_id_12_5 bigint;
        v_m_id_12_6 bigint;
        v_m_id_12_7 bigint;
        v_m_id_12_8 bigint;
        v_m_id_12_9 bigint;
        v_m_id_12_10 bigint;
        v_m_id_12_11 bigint;
        v_m_id_12_12 bigint;
        v_m_id_12_13 bigint;
        v_m_id_12_14 bigint;
        v_m_id_12_15 bigint;
        v_m_id_12_16 bigint;
        v_m_id_12_17 bigint;
        v_m_id_12_18 bigint;
        v_m_id_12_19 bigint;
        v_m_id_12_20 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_12 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_12 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_12;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_12 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_12;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 1, 2025, 12, 21.10, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_12_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_12_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_12_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_12_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 16, 2026, 1, 150.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - DEPOSITO N° 1 3PISO', v_user_uuid)
        RETURNING id INTO v_m_id_12_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 1, 2026, 1, 20.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_12_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_12_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_12_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_12_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_12_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 16, 2026, 2, 150.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO N° 1 3PISO', v_user_uuid)
        RETURNING id INTO v_m_id_12_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 1, 2026, 2, 20.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_12_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_12_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_12_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_12_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 16, 2026, 3, 150.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - DEPOSITO N° 1 3PISO', v_user_uuid)
        RETURNING id INTO v_m_id_12_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 1, 2026, 3, 21.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_12_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_12_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_12_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_12_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_12, 16, 2026, 4, 150.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - DEPOSITO N° 1 3PISO', v_user_uuid)
        RETURNING id INTO v_m_id_12_20;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_12,
            v_socio_12,
            NULL,
            242.10,
            'Efectivo',
            '32470',
            'Pago histórico recibo N° 32470',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_12_0, 'monto_aplicado', 21.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_12_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_12_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_12_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_12_4, 'monto_aplicado', 150.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-05 12:00:00-05', created_at = '2026-02-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-05 12:00:00-05', created_at = '2026-02-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_12,
            v_socio_12,
            NULL,
            236.50,
            'Efectivo',
            '32624',
            'Pago histórico recibo N° 32624',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_12_5, 'monto_aplicado', 20.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_12_6, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_12_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_12_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_12_10, 'monto_aplicado', 150.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-05 12:00:00-05', created_at = '2026-03-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-05 12:00:00-05', created_at = '2026-03-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_12,
            v_socio_12,
            NULL,
            58.50,
            'Efectivo',
            '32895',
            'Pago histórico recibo N° 32895',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_12_7, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_12_11, 'monto_aplicado', 20.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_12_12, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_12,
            v_socio_12,
            NULL,
            215.00,
            'Efectivo',
            '32930',
            'Pago histórico recibo N° 32930',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_12_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_12_14, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_12_15, 'monto_aplicado', 150.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-08 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-08 12:00:00-05', created_at = '2026-04-08 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-08 12:00:00-05', created_at = '2026-04-08 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_12,
            v_socio_12,
            NULL,
            242.40,
            'Efectivo',
            '33038',
            'Pago histórico recibo N° 33038',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_12_16, 'monto_aplicado', 21.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_12_17, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_12_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_12_19, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_12_20, 'monto_aplicado', 150.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: BASTIDAS MEDINA DINA (Puesto: 74, ID: 13)
    -- =========================================================================
    DECLARE
        v_socio_13 bigint := 13;
        v_puesto_13 bigint := 171;
        v_m_id_13_0 bigint;
        v_m_id_13_1 bigint;
        v_m_id_13_2 bigint;
        v_m_id_13_3 bigint;
        v_m_id_13_4 bigint;
        v_m_id_13_5 bigint;
        v_m_id_13_6 bigint;
        v_m_id_13_7 bigint;
        v_m_id_13_8 bigint;
        v_m_id_13_9 bigint;
        v_m_id_13_10 bigint;
        v_m_id_13_11 bigint;
        v_m_id_13_12 bigint;
        v_m_id_13_13 bigint;
        v_m_id_13_14 bigint;
        v_m_id_13_15 bigint;
        v_m_id_13_16 bigint;
        v_m_id_13_17 bigint;
        v_m_id_13_18 bigint;
        v_m_id_13_19 bigint;
        v_m_id_13_20 bigint;
        v_m_id_13_21 bigint;
        v_m_id_13_22 bigint;
        v_m_id_13_23 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_13 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_13 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_13;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_13 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_13;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 1, 2025, 11, 38.80, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_13_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_13_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_13_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_13_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 1, 2025, 12, 39.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_13_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_13_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_13_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_13_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_13_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_13_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 1, 2026, 1, 38.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_13_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_13_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_13_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_13_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_13_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 1, 2026, 2, 37.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_13_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_13_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 1, 2026, 3, 39.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_13_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_13_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_13_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_13_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 18, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - FUMIGACION', v_user_uuid)
        RETURNING id INTO v_m_id_13_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_13_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_13, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_13_23;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_13,
            v_socio_13,
            NULL,
            44.80,
            'Efectivo',
            '32374',
            'Pago histórico recibo N° 32374',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_13_0, 'monto_aplicado', 38.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_13_1, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_13,
            v_socio_13,
            NULL,
            256.00,
            'Efectivo',
            '32600',
            'Pago histórico recibo N° 32600',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_13_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_13_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_13_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_13_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_13_8, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_13_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_13_13, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_13_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_13,
            v_socio_13,
            NULL,
            45.40,
            'Efectivo',
            '32375',
            'Pago histórico recibo N° 32375',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_13_4, 'monto_aplicado', 39.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_13_5, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_13,
            v_socio_13,
            NULL,
            43.30,
            'Efectivo',
            '32601',
            'Pago histórico recibo N° 32601',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_13_10, 'monto_aplicado', 38.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_13_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_13,
            v_socio_13,
            NULL,
            76.00,
            'Efectivo',
            '32914',
            'Pago histórico recibo N° 32914',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_13_12, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_13_15, 'monto_aplicado', 37.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_13_16, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_13,
            v_socio_13,
            NULL,
            50.50,
            'Efectivo',
            '33096',
            'Pago histórico recibo N° 33096',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_13_17, 'monto_aplicado', 39.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_13_18, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_13_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-20 12:00:00-05', created_at = '2026-05-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-20 12:00:00-05', created_at = '2026-05-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_13,
            v_socio_13,
            NULL,
            130.00,
            'Efectivo',
            '33097',
            'Pago histórico recibo N° 33097',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_13_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_13_20, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_13_22, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_13_23, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-20 12:00:00-05', created_at = '2026-05-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-20 12:00:00-05', created_at = '2026-05-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: BASTIDAS MEDINA HERMENEGILDO (Puesto: 104, ID: 14)
    -- =========================================================================
    DECLARE
        v_socio_14 bigint := 14;
        v_puesto_14 bigint := 199;
        v_m_id_14_0 bigint;
        v_m_id_14_1 bigint;
        v_m_id_14_2 bigint;
        v_m_id_14_3 bigint;
        v_m_id_14_4 bigint;
        v_m_id_14_5 bigint;
        v_m_id_14_6 bigint;
        v_m_id_14_7 bigint;
        v_m_id_14_8 bigint;
        v_m_id_14_9 bigint;
        v_m_id_14_10 bigint;
        v_m_id_14_11 bigint;
        v_m_id_14_12 bigint;
        v_m_id_14_13 bigint;
        v_m_id_14_14 bigint;
        v_m_id_14_15 bigint;
        v_m_id_14_16 bigint;
        v_m_id_14_17 bigint;
        v_m_id_14_18 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_14 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_14 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_14;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_14 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_14;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 1, 2025, 11, 26.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_14_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 2, 2025, 11, 8.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_14_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 1, 2025, 12, 23.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_14_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 2, 2025, 12, 8.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_14_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_14_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_14_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_14_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 1, 2026, 1, 22.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_14_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 2, 2026, 1, 7.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_14_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_14_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_14_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 1, 2026, 2, 23.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_14_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 2, 2026, 2, 15.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_14_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_14_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_14_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 1, 2026, 3, 22.80, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_14_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_14_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_14_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_14, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_14_18;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_14,
            v_socio_14,
            NULL,
            76.00,
            'Efectivo',
            '32509',
            'Pago histórico recibo N° 32509',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_14_0, 'monto_aplicado', 26.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_14_1, 'monto_aplicado', 8.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_14_2, 'monto_aplicado', 23.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_14_3, 'monto_aplicado', 8.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_14_6, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_14,
            v_socio_14,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_14_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_14_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_14,
            v_socio_14,
            NULL,
            67.20,
            'Efectivo',
            '32761',
            'Pago histórico recibo N° 32761',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_14_7, 'monto_aplicado', 22.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_14_8, 'monto_aplicado', 7.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_14_11, 'monto_aplicado', 23.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_14_12, 'monto_aplicado', 15.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_14,
            v_socio_14,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_14_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_14_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_14,
            v_socio_14,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_14_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_14_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_14,
            v_socio_14,
            NULL,
            28.80,
            'Efectivo',
            '33082',
            'Pago histórico recibo N° 33082',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_14_15, 'monto_aplicado', 22.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_14_16, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-18 12:00:00-05', created_at = '2026-05-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-18 12:00:00-05', created_at = '2026-05-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_14,
            v_socio_14,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_14_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_14_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: BERNAOLA CARHUAZ DE PRADO FLORENCIA (Puesto: 166, ID: 15)
    -- =========================================================================
    DECLARE
        v_socio_15 bigint := 15;
        v_puesto_15 bigint := 261;
        v_m_id_15_0 bigint;
        v_m_id_15_1 bigint;
        v_m_id_15_2 bigint;
        v_m_id_15_3 bigint;
        v_m_id_15_4 bigint;
        v_m_id_15_5 bigint;
        v_m_id_15_6 bigint;
        v_m_id_15_7 bigint;
        v_m_id_15_8 bigint;
        v_m_id_15_9 bigint;
        v_m_id_15_10 bigint;
        v_m_id_15_11 bigint;
        v_m_id_15_12 bigint;
        v_m_id_15_13 bigint;
        v_m_id_15_14 bigint;
        v_m_id_15_15 bigint;
        v_m_id_15_16 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_15 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_15 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_15;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_15 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_15;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_15, 1, 2025, 11, 130.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_15_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_15, 2, 2025, 11, 101.40, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_15_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_15, 1, 2025, 12, 131.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_15_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_15, 2, 2025, 12, 93.10, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_15_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_15, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_15_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_15, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_15_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_15, 1, 2026, 1, 132.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_15_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_15, 2, 2026, 1, 82.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_15_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_15, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_15_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_15, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_15_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_15, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_15_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_15, 1, 2026, 2, 143.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_15_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_15, 2, 2026, 2, 289.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_15_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_15, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_15_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_15, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_15_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_15, 1, 2026, 3, 145.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_15_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_15, 2, 2026, 3, 125.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_15_16;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_15,
            v_socio_15,
            NULL,
            171.70,
            'Efectivo',
            '32329',
            'Pago histórico recibo N° 32329',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_15_0, 'monto_aplicado', 70.30, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_15_1, 'monto_aplicado', 101.40, 'cubierto_completo', true)),
            0.00,
            '2026-01-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_15,
            v_socio_15,
            NULL,
            190.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_15_0, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_15_2, 'monto_aplicado', 130.00, 'cubierto_completo', false)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_15,
            v_socio_15,
            NULL,
            75.50,
            'Efectivo',
            '32543',
            'Pago histórico recibo N° 32543',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_15_2, 'monto_aplicado', 1.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_15_3, 'monto_aplicado', 74.30, 'cubierto_completo', false)),
            0.00,
            '2026-02-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-20 12:00:00-05', created_at = '2026-02-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-20 12:00:00-05', created_at = '2026-02-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_15,
            v_socio_15,
            NULL,
            100.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_15_3, 'monto_aplicado', 18.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_15_6, 'monto_aplicado', 81.20, 'cubierto_completo', false)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_15,
            v_socio_15,
            NULL,
            65.00,
            'Efectivo',
            '32440',
            'Pago histórico recibo N° 32440',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_15_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_15_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-30 12:00:00-05', created_at = '2026-01-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-30 12:00:00-05', created_at = '2026-01-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_15,
            v_socio_15,
            NULL,
            100.00,
            'Efectivo',
            '32816',
            'Pago histórico recibo N° 32816',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_15_6, 'monto_aplicado', 51.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_15_7, 'monto_aplicado', 48.70, 'cubierto_completo', false)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_15,
            v_socio_15,
            NULL,
            200.00,
            'Efectivo',
            '32862',
            'Pago histórico recibo N° 32862',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_15_7, 'monto_aplicado', 34.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_15_8, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_15_11, 'monto_aplicado', 143.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_15_12, 'monto_aplicado', 12.80, 'cubierto_completo', false)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_15,
            v_socio_15,
            NULL,
            61.00,
            'Efectivo',
            '32587',
            'Pago histórico recibo N° 32587',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_15_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_15_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_15,
            v_socio_15,
            NULL,
            276.40,
            'Efectivo',
            '32916',
            'Pago histórico recibo N° 32916',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_15_12, 'monto_aplicado', 276.40, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_15,
            v_socio_15,
            NULL,
            65.00,
            'Efectivo',
            '32961',
            'Pago histórico recibo N° 32961',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_15_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_15_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-24 12:00:00-05', created_at = '2026-04-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-24 12:00:00-05', created_at = '2026-04-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_15,
            v_socio_15,
            NULL,
            271.40,
            'Efectivo',
            '33063',
            'Pago histórico recibo N° 33063',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_15_15, 'monto_aplicado', 145.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_15_16, 'monto_aplicado', 125.70, 'cubierto_completo', true)),
            0.00,
            '2026-05-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: BRAVO HEREDIA ANA MARITZA (Puesto: 64, ID: 16)
    -- =========================================================================
    DECLARE
        v_socio_16 bigint := 16;
        v_puesto_16 bigint := 161;
        v_m_id_16_0 bigint;
        v_m_id_16_1 bigint;
        v_m_id_16_2 bigint;
        v_m_id_16_3 bigint;
        v_m_id_16_4 bigint;
        v_m_id_16_5 bigint;
        v_m_id_16_6 bigint;
        v_m_id_16_7 bigint;
        v_m_id_16_8 bigint;
        v_m_id_16_9 bigint;
        v_m_id_16_10 bigint;
        v_m_id_16_11 bigint;
        v_m_id_16_12 bigint;
        v_m_id_16_13 bigint;
        v_m_id_16_14 bigint;
        v_m_id_16_15 bigint;
        v_m_id_16_16 bigint;
        v_m_id_16_17 bigint;
        v_m_id_16_18 bigint;
        v_m_id_16_19 bigint;
        v_m_id_16_20 bigint;
        v_m_id_16_21 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_16 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_16 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_16;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_16 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_16;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 18, 2026, 8, 15.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - TALONARIO SANTA ROSA', v_user_uuid)
        RETURNING id INTO v_m_id_16_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 1, 2025, 11, 108.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_16_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_16_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_16_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_16_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_16_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_16_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 1, 2025, 12, 109.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_16_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_16_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_16_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 1, 2026, 1, 106.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_16_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_16_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_16_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_16_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 1, 2026, 2, 105.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_16_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_16_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_16_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_16_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 1, 2026, 3, 108.80, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_16_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_16_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_16_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_16, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_16_21;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_16,
            v_socio_16,
            NULL,
            199.10,
            'Efectivo',
            '32331',
            'Pago histórico recibo N° 32331',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_16_0, 'monto_aplicado', 15.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_16_1, 'monto_aplicado', 108.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_16_2, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_16_3, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_16_4, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_16_6, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_16,
            v_socio_16,
            NULL,
            60.00,
            'Efectivo',
            '323331',
            'Pago histórico recibo N° 323331',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_16_5, 'monto_aplicado', 60.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_16,
            v_socio_16,
            NULL,
            115.70,
            'Efectivo',
            '32487',
            'Pago histórico recibo N° 32487',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_16_7, 'monto_aplicado', 109.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_16_8, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-10 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-10 12:00:00-05', created_at = '2026-02-10 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-10 12:00:00-05', created_at = '2026-02-10 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_16,
            v_socio_16,
            NULL,
            10.00,
            'Efectivo',
            '32653',
            'Pago histórico recibo N° 32653',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_16_9, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_16,
            v_socio_16,
            NULL,
            352.60,
            'Efectivo',
            '32838',
            'Pago histórico recibo N° 32838',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_16_10, 'monto_aplicado', 106.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_16_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_16_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_16_13, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_16_14, 'monto_aplicado', 105.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_16_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_16_16, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_16_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_16,
            v_socio_16,
            NULL,
            179.80,
            'Efectivo',
            '32986',
            'Pago histórico recibo N° 32986',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_16_18, 'monto_aplicado', 108.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_16_19, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_16_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_16_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-29 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: BURGA CARRASCO ELIDA (Puesto: 15, ID: 17)
    -- =========================================================================
    DECLARE
        v_socio_17 bigint := 17;
        v_puesto_17 bigint := 66;
        v_m_id_17_0 bigint;
        v_m_id_17_1 bigint;
        v_m_id_17_2 bigint;
        v_m_id_17_3 bigint;
        v_m_id_17_4 bigint;
        v_m_id_17_5 bigint;
        v_m_id_17_6 bigint;
        v_m_id_17_7 bigint;
        v_m_id_17_8 bigint;
        v_m_id_17_9 bigint;
        v_m_id_17_10 bigint;
        v_m_id_17_11 bigint;
        v_m_id_17_12 bigint;
        v_m_id_17_13 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_17 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_17 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_17;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_17 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_17;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_17, 3, 2026, 8, 60.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_17_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_17, 4, 2026, 8, 5.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_17_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_17, 3, 2026, 9, 60.00, 'Pendiente', 'Manual', '2026-09-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_17_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_17, 4, 2026, 9, 5.00, 'Pendiente', 'Manual', '2026-09-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_17_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_17, 3, 2026, 10, 60.00, 'Pendiente', 'Manual', '2026-10-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_17_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_17, 4, 2026, 10, 5.00, 'Pendiente', 'Manual', '2026-10-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_17_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_17, 1, 2025, 11, 34.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_17_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_17, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_17_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_17, 1, 2025, 12, 35.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_17_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_17, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_17_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_17, 1, 2026, 1, 34.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_17_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_17, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_17_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_17, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_17_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_17, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_17_13;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_17,
            v_socio_17,
            NULL,
            65.00,
            'Efectivo',
            '32298',
            'Pago histórico recibo N° 32298',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_17_0, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_17_1, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_17,
            v_socio_17,
            NULL,
            65.00,
            'Efectivo',
            '32455',
            'Pago histórico recibo N° 32455',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_17_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_17_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_17,
            v_socio_17,
            NULL,
            65.00,
            'Efectivo',
            '33023',
            'Pago histórico recibo N° 33023',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_17_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_17_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_17,
            v_socio_17,
            NULL,
            40.90,
            'Efectivo',
            '32420',
            'Pago histórico recibo N° 32420',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_17_6, 'monto_aplicado', 34.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_17_7, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_17,
            v_socio_17,
            NULL,
            41.40,
            'Efectivo',
            '32927',
            'Pago histórico recibo N° 32927',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_17_8, 'monto_aplicado', 35.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_17_9, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_17,
            v_socio_17,
            NULL,
            104.40,
            'Efectivo',
            '32952',
            'Pago histórico recibo N° 32952',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_17_10, 'monto_aplicado', 34.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_17_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_17_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_17_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-22 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-22 12:00:00-05', created_at = '2026-04-22 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-22 12:00:00-05', created_at = '2026-04-22 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CABALLERO CALZADO GLADYS VICTORIA (Puesto: 108, ID: 18)
    -- =========================================================================
    DECLARE
        v_socio_18 bigint := 18;
        v_puesto_18 bigint := 203;
        v_m_id_18_0 bigint;
        v_m_id_18_1 bigint;
        v_m_id_18_2 bigint;
        v_m_id_18_3 bigint;
        v_m_id_18_4 bigint;
        v_m_id_18_5 bigint;
        v_m_id_18_6 bigint;
        v_m_id_18_7 bigint;
        v_m_id_18_8 bigint;
        v_m_id_18_9 bigint;
        v_m_id_18_10 bigint;
        v_m_id_18_11 bigint;
        v_m_id_18_12 bigint;
        v_m_id_18_13 bigint;
        v_m_id_18_14 bigint;
        v_m_id_18_15 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_18 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_18 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_18;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_18 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_18;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_18, 1, 2025, 11, 8.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_18_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_18, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_18_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_18, 1, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_18_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_18, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_18_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_18, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_18_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_18, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_18_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_18, 1, 2026, 1, 5.80, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_18_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_18, 2, 2026, 1, 5.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_18_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_18, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_18_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_18, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_18_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_18, 1, 2026, 2, 9.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_18_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_18, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_18_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_18, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_18_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_18, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_18_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_18, 1, 2026, 3, 9.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_18_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_18, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_18_15;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_18,
            v_socio_18,
            NULL,
            14.00,
            'Efectivo',
            '32323',
            'Pago histórico recibo N° 32323',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_18_0, 'monto_aplicado', 8.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_18_1, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_18,
            v_socio_18,
            NULL,
            22.50,
            'Efectivo',
            '32544',
            'Pago histórico recibo N° 32544',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_18_2, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_18_3, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_18_6, 'monto_aplicado', 5.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_18_7, 'monto_aplicado', 5.70, 'cubierto_completo', true)),
            0.00,
            '2026-02-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-20 12:00:00-05', created_at = '2026-02-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-20 12:00:00-05', created_at = '2026-02-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_18,
            v_socio_18,
            NULL,
            65.00,
            'Efectivo',
            '32480',
            'Pago histórico recibo N° 32480',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_18_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_18_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-07 12:00:00-05', created_at = '2026-02-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-07 12:00:00-05', created_at = '2026-02-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_18,
            v_socio_18,
            NULL,
            65.00,
            'Efectivo',
            '32481',
            'Pago histórico recibo N° 32481',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_18_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_18_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_18_12, 'monto_aplicado', 4.00, 'cubierto_completo', false)),
            0.00,
            '2026-02-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-07 12:00:00-05', created_at = '2026-02-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-07 12:00:00-05', created_at = '2026-02-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_18,
            v_socio_18,
            NULL,
            19.00,
            'Efectivo',
            '32710',
            'Pago histórico recibo N° 32710',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_18_10, 'monto_aplicado', 9.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_18_11, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_18,
            v_socio_18,
            NULL,
            61.00,
            'Efectivo',
            '32602',
            'Pago histórico recibo N° 32602',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_18_12, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_18_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-03 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_18,
            v_socio_18,
            NULL,
            15.20,
            'Efectivo',
            '33066',
            'Pago histórico recibo N° 33066',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_18_14, 'monto_aplicado', 9.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_18_15, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CABERO MENDOZA GLORIA LUCINDA (Puesto: 37, ID: 19)
    -- =========================================================================
    DECLARE
        v_socio_19 bigint := 19;
        v_puesto_19 bigint := 108;
        v_m_id_19_0 bigint;
        v_m_id_19_1 bigint;
        v_m_id_19_2 bigint;
        v_m_id_19_3 bigint;
        v_m_id_19_4 bigint;
        v_m_id_19_5 bigint;
        v_m_id_19_6 bigint;
        v_m_id_19_7 bigint;
        v_m_id_19_8 bigint;
        v_m_id_19_9 bigint;
        v_m_id_19_10 bigint;
        v_m_id_19_11 bigint;
        v_m_id_19_12 bigint;
        v_m_id_19_13 bigint;
        v_m_id_19_14 bigint;
        v_m_id_19_15 bigint;
        v_m_id_19_16 bigint;
        v_m_id_19_17 bigint;
        v_m_id_19_18 bigint;
        v_m_id_19_19 bigint;
        v_m_id_19_20 bigint;
        v_m_id_19_21 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_19 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_19 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_19;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_19 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_19;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 1, 2025, 11, 27.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_19_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_19_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 16, 2025, 11, 74.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - DEPOSITO N° 8', v_user_uuid)
        RETURNING id INTO v_m_id_19_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 1, 2025, 12, 28.10, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_19_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_19_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 16, 2025, 12, 20.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - DEPOSITO N° 8', v_user_uuid)
        RETURNING id INTO v_m_id_19_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_19_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_19_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 16, 2026, 1, 200.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - DEPOSITO N° 8', v_user_uuid)
        RETURNING id INTO v_m_id_19_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 1, 2026, 1, 27.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_19_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_19_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_19_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_19_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 16, 2026, 2, 200.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO N° 8', v_user_uuid)
        RETURNING id INTO v_m_id_19_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 1, 2026, 2, 26.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_19_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_19_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_19_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_19_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 16, 2026, 3, 100.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - DEPOSITO N° 8', v_user_uuid)
        RETURNING id INTO v_m_id_19_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_19_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_19_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_19, 16, 2026, 4, 180.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - DEPOSITO N° 8', v_user_uuid)
        RETURNING id INTO v_m_id_19_21;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_19,
            v_socio_19,
            NULL,
            229.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_19_0, 'monto_aplicado', 27.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_3, 'monto_aplicado', 8.30, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_19_11, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_13, 'monto_aplicado', 126.00, 'cubierto_completo', false)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_19,
            v_socio_19,
            NULL,
            150.10,
            'Efectivo',
            '32659',
            'Pago histórico recibo N° 32659',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_19_2, 'monto_aplicado', 74.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_3, 'monto_aplicado', 19.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_4, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_5, 'monto_aplicado', 20.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_9, 'monto_aplicado', 27.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_10, 'monto_aplicado', 3.00, 'cubierto_completo', false)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_19,
            v_socio_19,
            NULL,
            245.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_19_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_8, 'monto_aplicado', 180.00, 'cubierto_completo', false)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_19,
            v_socio_19,
            NULL,
            132.90,
            'Efectivo',
            '32919',
            'Pago histórico recibo N° 32919',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_19_10, 'monto_aplicado', 2.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_8, 'monto_aplicado', 20.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_14, 'monto_aplicado', 26.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_13, 'monto_aplicado', 74.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_19,
            v_socio_19,
            NULL,
            165.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_19_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_17, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_18, 'monto_aplicado', 100.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_19,
            v_socio_19,
            NULL,
            245.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_19_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_20, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_19_21, 'monto_aplicado', 180.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CAHUANA VDA DE DAVILA VICENTINA (Puesto: 159, ID: 20)
    -- =========================================================================
    DECLARE
        v_socio_20 bigint := 20;
        v_puesto_20 bigint := 254;
        v_m_id_20_0 bigint;
        v_m_id_20_1 bigint;
        v_m_id_20_2 bigint;
        v_m_id_20_3 bigint;
        v_m_id_20_4 bigint;
        v_m_id_20_5 bigint;
        v_m_id_20_6 bigint;
        v_m_id_20_7 bigint;
        v_m_id_20_8 bigint;
        v_m_id_20_9 bigint;
        v_m_id_20_10 bigint;
        v_m_id_20_11 bigint;
        v_m_id_20_12 bigint;
        v_m_id_20_13 bigint;
        v_m_id_20_14 bigint;
        v_m_id_20_15 bigint;
        v_m_id_20_16 bigint;
        v_m_id_20_17 bigint;
        v_m_id_20_18 bigint;
        v_m_id_20_19 bigint;
        v_m_id_20_20 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_20 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_20 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_20;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_20 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_20;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 1, 2025, 11, 61.40, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_20_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 2, 2025, 11, 140.80, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_20_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 3, 2025, 12, 40.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_20_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_20_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 1, 2025, 12, 54.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_20_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 2, 2025, 12, 136.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_20_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_20_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_20_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 1, 2026, 1, 59.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_20_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 2, 2026, 1, 177.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_20_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_20_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_20_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 1, 2026, 2, 62.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_20_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 2, 2026, 2, 185.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_20_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_20_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_20_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 1, 2026, 3, 55.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_20_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 2, 2026, 3, 130.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_20_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_20_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_20_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_20, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_20_20;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_20,
            v_socio_20,
            NULL,
            61.40,
            'Efectivo',
            '32387',
            'Pago histórico recibo N° 32387',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_20_0, 'monto_aplicado', 61.40, 'cubierto_completo', true)),
            0.00,
            '2026-01-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_20,
            v_socio_20,
            NULL,
            140.80,
            'Efectivo',
            '32428',
            'Pago histórico recibo N° 32428',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_20_1, 'monto_aplicado', 140.80, 'cubierto_completo', true)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_20,
            v_socio_20,
            NULL,
            45.00,
            'Efectivo',
            '32295',
            'Pago histórico recibo N° 32295',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_20_2, 'monto_aplicado', 40.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_20_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_20,
            v_socio_20,
            NULL,
            191.30,
            'Efectivo',
            '32536',
            'Pago histórico recibo N° 32536',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_20_4, 'monto_aplicado', 54.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_20_5, 'monto_aplicado', 136.60, 'cubierto_completo', true)),
            0.00,
            '2026-02-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_20,
            v_socio_20,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_20_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_20_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_20,
            v_socio_20,
            NULL,
            535.80,
            'Efectivo',
            '32788',
            'Pago histórico recibo N° 32788',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_20_8, 'monto_aplicado', 59.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_20_9, 'monto_aplicado', 177.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_20_10, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_20_12, 'monto_aplicado', 62.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_20_13, 'monto_aplicado', 185.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_20_11, 'monto_aplicado', 36.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_20_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_20,
            v_socio_20,
            NULL,
            20.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_20_11, 'monto_aplicado', 20.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_20,
            v_socio_20,
            NULL,
            20.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_20_15, 'monto_aplicado', 20.00, 'cubierto_completo', false)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_20,
            v_socio_20,
            NULL,
            231.40,
            'Efectivo',
            '33090',
            'Pago histórico recibo N° 33090',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_20_16, 'monto_aplicado', 55.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_20_17, 'monto_aplicado', 130.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_20_15, 'monto_aplicado', 40.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_20_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-19 12:00:00-05', created_at = '2026-05-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-19 12:00:00-05', created_at = '2026-05-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_20,
            v_socio_20,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_20_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_20_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CAJALEON CARRASCO LUIS ENRIQUE (Puesto: 76, ID: 21)
    -- =========================================================================
    DECLARE
        v_socio_21 bigint := 21;
        v_puesto_21 bigint := 173;
        v_m_id_21_0 bigint;
        v_m_id_21_1 bigint;
        v_m_id_21_2 bigint;
        v_m_id_21_3 bigint;
        v_m_id_21_4 bigint;
        v_m_id_21_5 bigint;
        v_m_id_21_6 bigint;
        v_m_id_21_7 bigint;
        v_m_id_21_8 bigint;
        v_m_id_21_9 bigint;
        v_m_id_21_10 bigint;
        v_m_id_21_11 bigint;
        v_m_id_21_12 bigint;
        v_m_id_21_13 bigint;
        v_m_id_21_14 bigint;
        v_m_id_21_15 bigint;
        v_m_id_21_16 bigint;
        v_m_id_21_17 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_21 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_21 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_21;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_21 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_21;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 1, 2025, 11, 49.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_21_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_21_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_21_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 18, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P', v_user_uuid)
        RETURNING id INTO v_m_id_21_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 1, 2025, 12, 50.10, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_21_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_21_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_21_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_21_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 1, 2026, 1, 48.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_21_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_21_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_21_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_21_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_21_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 1, 2026, 2, 47.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_21_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_21_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_21_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_21_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_21, 3, 2026, 4, 50.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_21_17;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_21,
            v_socio_21,
            NULL,
            100.00,
            'Efectivo',
            '32497',
            'Pago histórico recibo N° 32497',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_21_0, 'monto_aplicado', 49.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_21_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_21_2, 'monto_aplicado', 44.70, 'cubierto_completo', false)),
            0.00,
            '2026-02-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_21,
            v_socio_21,
            NULL,
            288.30,
            'Efectivo',
            '32887',
            'Pago histórico recibo N° 32887',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_21_2, 'monto_aplicado', 15.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_21_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_21_4, 'monto_aplicado', 50.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_21_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_21_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_21_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_21_8, 'monto_aplicado', 48.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_21_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_21_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_21_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_21_12, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_21,
            v_socio_21,
            NULL,
            118.90,
            'Efectivo',
            '32888',
            'Pago histórico recibo N° 32888',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_21_13, 'monto_aplicado', 47.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_21_14, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_21_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_21_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_21,
            v_socio_21,
            NULL,
            50.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_21_17, 'monto_aplicado', 50.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CALDERON TORRES BERTHA ESTELA (Puesto: 58, ID: 22)
    -- =========================================================================
    DECLARE
        v_socio_22 bigint := 22;
        v_puesto_22 bigint := 150;
        v_m_id_22_0 bigint;
        v_m_id_22_1 bigint;
        v_m_id_22_2 bigint;
        v_m_id_22_3 bigint;
        v_m_id_22_4 bigint;
        v_m_id_22_5 bigint;
        v_m_id_22_6 bigint;
        v_m_id_22_7 bigint;
        v_m_id_22_8 bigint;
        v_m_id_22_9 bigint;
        v_m_id_22_10 bigint;
        v_m_id_22_11 bigint;
        v_m_id_22_12 bigint;
        v_m_id_22_13 bigint;
        v_m_id_22_14 bigint;
        v_m_id_22_15 bigint;
        v_m_id_22_16 bigint;
        v_m_id_22_17 bigint;
        v_m_id_22_18 bigint;
        v_m_id_22_19 bigint;
        v_m_id_22_20 bigint;
        v_m_id_22_21 bigint;
        v_m_id_22_22 bigint;
        v_m_id_22_23 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_22 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_22 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_22;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_22 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_22;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 1, 2025, 11, 88.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_22_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_22_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_22_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_22_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 1, 2025, 12, 89.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_22_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_22_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_22_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_22_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 1, 2026, 1, 87.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_22_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_22_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_22_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_22_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_22_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_22_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 1, 2026, 2, 86.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_22_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_22_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_22_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_22_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 1, 2026, 3, 89.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_22_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_22_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_22_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_22_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_22_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_22, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_22_23;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_22,
            v_socio_22,
            NULL,
            150.00,
            'Efectivo',
            '32333',
            'Pago histórico recibo N° 32333',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_22_0, 'monto_aplicado', 88.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_2, 'monto_aplicado', 55.30, 'cubierto_completo', false)),
            0.00,
            '2026-01-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_22,
            v_socio_22,
            NULL,
            9.70,
            'Efectivo',
            '32334',
            'Pago histórico recibo N° 32334',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_22_2, 'monto_aplicado', 4.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_22,
            v_socio_22,
            NULL,
            328.30,
            'Efectivo',
            '32523',
            'Pago histórico recibo N° 32523',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_22_4, 'monto_aplicado', 89.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_8, 'monto_aplicado', 87.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_12, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-17 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-17 12:00:00-05', created_at = '2026-02-17 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-17 12:00:00-05', created_at = '2026-02-17 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_22,
            v_socio_22,
            NULL,
            185.50,
            'Efectivo',
            '32845',
            'Pago histórico recibo N° 32845',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_22_13, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_14, 'monto_aplicado', 86.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_16, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_22,
            v_socio_22,
            NULL,
            225.40,
            'Efectivo',
            '33062',
            'Pago histórico recibo N° 33062',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_22_18, 'monto_aplicado', 89.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_19, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_21, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_22, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_22_23, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-12 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-12 12:00:00-05', created_at = '2026-05-12 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-12 12:00:00-05', created_at = '2026-05-12 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CALDERON VERA SEGUNDO ALCIDES (Puesto: 184, ID: 23)
    -- =========================================================================
    DECLARE
        v_socio_23 bigint := 23;
        v_puesto_23 bigint := 278;
        v_m_id_23_0 bigint;
        v_m_id_23_1 bigint;
        v_m_id_23_2 bigint;
        v_m_id_23_3 bigint;
        v_m_id_23_4 bigint;
        v_m_id_23_5 bigint;
        v_m_id_23_6 bigint;
        v_m_id_23_7 bigint;
        v_m_id_23_8 bigint;
        v_m_id_23_9 bigint;
        v_m_id_23_10 bigint;
        v_m_id_23_11 bigint;
        v_m_id_23_12 bigint;
        v_m_id_23_13 bigint;
        v_m_id_23_14 bigint;
        v_m_id_23_15 bigint;
        v_m_id_23_16 bigint;
        v_m_id_23_17 bigint;
        v_m_id_23_18 bigint;
        v_m_id_23_19 bigint;
        v_m_id_23_20 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_23 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_23 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_23;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_23 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_23;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 1, 2025, 11, 192.40, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_23_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 2, 2025, 11, 12.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_23_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_23_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_23_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_23_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_23_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 1, 2025, 12, 218.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_23_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 2, 2025, 12, 53.80, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_23_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 1, 2026, 1, 267.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_23_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 2, 2026, 1, 56.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_23_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_23_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_23_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_23_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_23_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_23_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 1, 2026, 2, 256.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_23_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 2, 2026, 2, 63.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_23_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 1, 2026, 3, 199.80, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_23_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 2, 2026, 3, 65.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_23_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_23_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_23, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_23_20;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_23,
            v_socio_23,
            NULL,
            335.30,
            'Efectivo',
            '32292',
            'Pago histórico recibo N° 32292',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_23_0, 'monto_aplicado', 192.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_23_1, 'monto_aplicado', 12.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_23_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_23_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_23_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_23_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_23,
            v_socio_23,
            NULL,
            272.20,
            'Efectivo',
            '32439',
            'Pago histórico recibo N° 32439',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_23_6, 'monto_aplicado', 218.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_23_7, 'monto_aplicado', 53.80, 'cubierto_completo', true)),
            0.00,
            '2026-01-29 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-29 12:00:00-05', created_at = '2026-01-29 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-29 12:00:00-05', created_at = '2026-01-29 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_23,
            v_socio_23,
            NULL,
            459.80,
            'Efectivo',
            '32663',
            'Pago histórico recibo N° 32663',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_23_8, 'monto_aplicado', 267.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_23_9, 'monto_aplicado', 56.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_23_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_23_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_23_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_23_13, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_23_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_23,
            v_socio_23,
            NULL,
            320.00,
            'Efectivo',
            '32826',
            'Pago histórico recibo N° 32826',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_23_15, 'monto_aplicado', 256.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_23_16, 'monto_aplicado', 63.20, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_23,
            v_socio_23,
            NULL,
            329.90,
            'Efectivo',
            '32994',
            'Pago histórico recibo N° 32994',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_23_17, 'monto_aplicado', 199.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_23_18, 'monto_aplicado', 65.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_23_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_23_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CALLE ALVAREZ MARCO ANTONIO (Puesto: 149, ID: 24)
    -- =========================================================================
    DECLARE
        v_socio_24 bigint := 24;
        v_puesto_24 bigint := 244;
        v_m_id_24_0 bigint;
        v_m_id_24_1 bigint;
        v_m_id_24_2 bigint;
        v_m_id_24_3 bigint;
        v_m_id_24_4 bigint;
        v_m_id_24_5 bigint;
        v_m_id_24_6 bigint;
        v_m_id_24_7 bigint;
        v_m_id_24_8 bigint;
        v_m_id_24_9 bigint;
        v_m_id_24_10 bigint;
        v_m_id_24_11 bigint;
        v_m_id_24_12 bigint;
        v_m_id_24_13 bigint;
        v_m_id_24_14 bigint;
        v_m_id_24_15 bigint;
        v_m_id_24_16 bigint;
        v_m_id_24_17 bigint;
        v_m_id_24_18 bigint;
        v_m_id_24_19 bigint;
        v_m_id_24_20 bigint;
        v_m_id_24_21 bigint;
        v_m_id_24_22 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_24 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_24 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_24;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_24 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_24;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 7, 2025, 11, 200.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_24_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 1, 2025, 11, 12.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_24_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_24_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 6, 2025, 11, 113.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - MULTA 27-11-2025', v_user_uuid)
        RETURNING id INTO v_m_id_24_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 7, 2025, 12, 200.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_24_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 1, 2025, 12, 10.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_24_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_24_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_24_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_24_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 1, 2026, 1, 10.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_24_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_24_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_24_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 7, 2026, 1, 200.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_24_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_24_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 1, 2026, 2, 8.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_24_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_24_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_24_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 7, 2026, 2, 200.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_24_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_24_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_24_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 7, 2026, 3, 200.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_24_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_24_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_24, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_24_22;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_24,
            v_socio_24,
            NULL,
            200.00,
            'Efectivo',
            '32302',
            'Pago histórico recibo N° 32302',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_24_0, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-08 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-08 12:00:00-05', created_at = '2026-01-08 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-08 12:00:00-05', created_at = '2026-01-08 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_24,
            v_socio_24,
            NULL,
            18.00,
            'Efectivo',
            '32328',
            'Pago histórico recibo N° 32328',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_24_1, 'monto_aplicado', 12.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_24_2, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_24,
            v_socio_24,
            NULL,
            113.00,
            'Efectivo',
            '32748',
            'Pago histórico recibo N° 32748',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_24_3, 'monto_aplicado', 113.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_24,
            v_socio_24,
            NULL,
            200.00,
            'Efectivo',
            '32534',
            'Pago histórico recibo N° 32534',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_24_4, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_24,
            v_socio_24,
            NULL,
            16.70,
            'Efectivo',
            '32539',
            'Pago histórico recibo N° 32539',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_24_5, 'monto_aplicado', 10.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_24_6, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-19 12:00:00-05', created_at = '2026-02-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-19 12:00:00-05', created_at = '2026-02-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_24,
            v_socio_24,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_24_7, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_24_8, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_24,
            v_socio_24,
            NULL,
            15.70,
            'Efectivo',
            '32540',
            'Pago histórico recibo N° 32540',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_24_9, 'monto_aplicado', 10.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_24_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-19 12:00:00-05', created_at = '2026-02-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-19 12:00:00-05', created_at = '2026-02-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_24,
            v_socio_24,
            NULL,
            10.00,
            'Efectivo',
            '32632',
            'Pago histórico recibo N° 32632',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_24_11, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-09 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-09 12:00:00-05', created_at = '2026-03-09 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-09 12:00:00-05', created_at = '2026-03-09 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_24,
            v_socio_24,
            NULL,
            200.00,
            'Efectivo',
            '32649',
            'Pago histórico recibo N° 32649',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_24_12, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_24,
            v_socio_24,
            NULL,
            40.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_24_13, 'monto_aplicado', 40.00, 'cubierto_completo', false)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_24,
            v_socio_24,
            NULL,
            39.90,
            'Efectivo',
            '32698',
            'Pago histórico recibo N° 32698',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_24_14, 'monto_aplicado', 8.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_24_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_24_13, 'monto_aplicado', 16.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_24_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_24,
            v_socio_24,
            NULL,
            200.00,
            'Efectivo',
            '32707',
            'Pago histórico recibo N° 32707',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_24_17, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_24,
            v_socio_24,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_24_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_24_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_24,
            v_socio_24,
            NULL,
            200.00,
            'Efectivo',
            '32935',
            'Pago histórico recibo N° 32935',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_24_20, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-09 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-09 12:00:00-05', created_at = '2026-04-09 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-09 12:00:00-05', created_at = '2026-04-09 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_24,
            v_socio_24,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_24_21, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_24_22, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CALLE CALLE FIDEL (Puesto: 56, ID: 25)
    -- =========================================================================
    DECLARE
        v_socio_25 bigint := 25;
        v_puesto_25 bigint := 146;
        v_m_id_25_0 bigint;
        v_m_id_25_1 bigint;
        v_m_id_25_2 bigint;
        v_m_id_25_3 bigint;
        v_m_id_25_4 bigint;
        v_m_id_25_5 bigint;
        v_m_id_25_6 bigint;
        v_m_id_25_7 bigint;
        v_m_id_25_8 bigint;
        v_m_id_25_9 bigint;
        v_m_id_25_10 bigint;
        v_m_id_25_11 bigint;
        v_m_id_25_12 bigint;
        v_m_id_25_13 bigint;
        v_m_id_25_14 bigint;
        v_m_id_25_15 bigint;
        v_m_id_25_16 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_25 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_25 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_25;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_25 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_25;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_25, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_25_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_25, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_25_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_25, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_25_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_25, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_25_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_25, 1, 2025, 12, 24.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_25_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_25, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_25_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_25, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_25_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_25, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_25_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_25, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_25_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_25, 1, 2026, 1, 23.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_25_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_25, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_25_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_25, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_25_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_25, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_25_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_25, 1, 2026, 2, 23.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_25_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_25, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_25_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_25, 1, 2026, 3, 24.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_25_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_25, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_25_16;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_25,
            v_socio_25,
            NULL,
            65.00,
            'Efectivo',
            '32335',
            'Pago histórico recibo N° 32335',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_25_0, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_25_1, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_25,
            v_socio_25,
            NULL,
            65.00,
            'Efectivo',
            '32336',
            'Pago histórico recibo N° 32336',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_25_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_25_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_25,
            v_socio_25,
            NULL,
            58.70,
            'Efectivo',
            '32573',
            'Pago histórico recibo N° 32573',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_25_4, 'monto_aplicado', 24.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_25_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_25_9, 'monto_aplicado', 23.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_25_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-26 12:00:00-05', created_at = '2026-02-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-26 12:00:00-05', created_at = '2026-02-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_25,
            v_socio_25,
            NULL,
            75.00,
            'Efectivo',
            '32541',
            'Pago histórico recibo N° 32541',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_25_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_25_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_25_8, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-19 12:00:00-05', created_at = '2026-02-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-19 12:00:00-05', created_at = '2026-02-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_25,
            v_socio_25,
            NULL,
            61.00,
            'Efectivo',
            '32696',
            'Pago histórico recibo N° 32696',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_25_11, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_25_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_25,
            v_socio_25,
            NULL,
            33.20,
            'Efectivo',
            '32706',
            'Pago histórico recibo N° 32706',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_25_13, 'monto_aplicado', 23.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_25_14, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_25,
            v_socio_25,
            NULL,
            30.50,
            'Efectivo',
            '33029',
            'Pago histórico recibo N° 33029',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_25_15, 'monto_aplicado', 24.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_25_16, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CAMPUZANO CABELLO VICENTA DONATILA (Puesto: 101, ID: 26)
    -- =========================================================================
    DECLARE
        v_socio_26 bigint := 26;
        v_puesto_26 bigint := 196;
        v_m_id_26_0 bigint;
        v_m_id_26_1 bigint;
        v_m_id_26_2 bigint;
        v_m_id_26_3 bigint;
        v_m_id_26_4 bigint;
        v_m_id_26_5 bigint;
        v_m_id_26_6 bigint;
        v_m_id_26_7 bigint;
        v_m_id_26_8 bigint;
        v_m_id_26_9 bigint;
        v_m_id_26_10 bigint;
        v_m_id_26_11 bigint;
        v_m_id_26_12 bigint;
        v_m_id_26_13 bigint;
        v_m_id_26_14 bigint;
        v_m_id_26_15 bigint;
        v_m_id_26_16 bigint;
        v_m_id_26_17 bigint;
        v_m_id_26_18 bigint;
        v_m_id_26_19 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_26 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_26 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_26;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_26 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_26;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 1, 2025, 11, 17.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_26_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_26_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 1, 2025, 12, 14.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_26_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_26_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_26_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_26_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 1, 2026, 1, 12.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_26_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_26_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_26_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 1, 2026, 2, 11.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_26_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_26_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_26_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_26_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 1, 2026, 3, 13.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_26_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 2, 2026, 3, 17.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_26_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_26_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_26_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_26_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 1, 2026, 4, 21.20, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_26_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_26, 2, 2026, 4, 17.70, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_26_19;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_26,
            v_socio_26,
            NULL,
            43.60,
            'Efectivo',
            '32504',
            'Pago histórico recibo N° 32504',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_26_0, 'monto_aplicado', 17.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_26_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_26_2, 'monto_aplicado', 14.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_26_3, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_26,
            v_socio_26,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_26_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_26_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_26,
            v_socio_26,
            NULL,
            39.80,
            'Efectivo',
            '32783',
            'Pago histórico recibo N° 32783',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_26_6, 'monto_aplicado', 12.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_26_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_26_9, 'monto_aplicado', 11.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_26_10, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_26,
            v_socio_26,
            NULL,
            40.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_26_8, 'monto_aplicado', 40.00, 'cubierto_completo', false)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_26,
            v_socio_26,
            NULL,
            21.00,
            'Efectivo',
            '32784',
            'Pago histórico recibo N° 32784',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_26_8, 'monto_aplicado', 16.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_26_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_26,
            v_socio_26,
            NULL,
            40.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_26_12, 'monto_aplicado', 40.00, 'cubierto_completo', false)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_26,
            v_socio_26,
            NULL,
            55.70,
            'Efectivo',
            '33051',
            'Pago histórico recibo N° 33051',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_26_13, 'monto_aplicado', 13.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_26_14, 'monto_aplicado', 17.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_26_12, 'monto_aplicado', 20.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_26_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_26,
            v_socio_26,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_26_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_26_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_26,
            v_socio_26,
            NULL,
            38.90,
            'Efectivo',
            '33103',
            'Pago histórico recibo N° 33103',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_26_18, 'monto_aplicado', 21.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_26_19, 'monto_aplicado', 17.70, 'cubierto_completo', true)),
            0.00,
            '2026-05-22 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-22 12:00:00-05', created_at = '2026-05-22 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-22 12:00:00-05', created_at = '2026-05-22 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CARDENA VILLAFUERTE ALEJANDRINA (Puesto: 13, ID: 27)
    -- =========================================================================
    DECLARE
        v_socio_27 bigint := 27;
        v_puesto_27 bigint := 62;
        v_m_id_27_0 bigint;
        v_m_id_27_1 bigint;
        v_m_id_27_2 bigint;
        v_m_id_27_3 bigint;
        v_m_id_27_4 bigint;
        v_m_id_27_5 bigint;
        v_m_id_27_6 bigint;
        v_m_id_27_7 bigint;
        v_m_id_27_8 bigint;
        v_m_id_27_9 bigint;
        v_m_id_27_10 bigint;
        v_m_id_27_11 bigint;
        v_m_id_27_12 bigint;
        v_m_id_27_13 bigint;
        v_m_id_27_14 bigint;
        v_m_id_27_15 bigint;
        v_m_id_27_16 bigint;
        v_m_id_27_17 bigint;
        v_m_id_27_18 bigint;
        v_m_id_27_19 bigint;
        v_m_id_27_20 bigint;
        v_m_id_27_21 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_27 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_27 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_27;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_27 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_27;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 1, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_27_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_27_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_27_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_27_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 1, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_27_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_27_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_27_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_27_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_27_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 1, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_27_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_27_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_27_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_27_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 1, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_27_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_27_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_27_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_27_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 1, 2026, 3, 5.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_27_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_27_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_27_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_27_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_27, 18, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - FUMIGACION', v_user_uuid)
        RETURNING id INTO v_m_id_27_21;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_27,
            v_socio_27,
            NULL,
            11.00,
            'Efectivo',
            '32287',
            'Pago histórico recibo N° 32287',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_27_0, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_27_1, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-06 12:00:00-05', created_at = '2026-01-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-06 12:00:00-05', created_at = '2026-01-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_27,
            v_socio_27,
            NULL,
            65.00,
            'Efectivo',
            '32288',
            'Pago histórico recibo N° 32288',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_27_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_27_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-06 12:00:00-05', created_at = '2026-01-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-06 12:00:00-05', created_at = '2026-01-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_27,
            v_socio_27,
            NULL,
            11.00,
            'Efectivo',
            '32467',
            'Pago histórico recibo N° 32467',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_27_4, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_27_5, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_27,
            v_socio_27,
            NULL,
            75.00,
            'Efectivo',
            '32468',
            'Pago histórico recibo N° 32468',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_27_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_27_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_27_8, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_27,
            v_socio_27,
            NULL,
            10.00,
            'Efectivo',
            '32594',
            'Pago histórico recibo N° 32594',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_27_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_27_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_27,
            v_socio_27,
            NULL,
            61.00,
            'Efectivo',
            '32593',
            'Pago histórico recibo N° 32593',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_27_11, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_27_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-02 12:00:00-05', created_at = '2026-03-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_27,
            v_socio_27,
            NULL,
            15.00,
            'Efectivo',
            '32871',
            'Pago histórico recibo N° 32871',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_27_13, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_27_14, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_27,
            v_socio_27,
            NULL,
            65.00,
            'Efectivo',
            '32872',
            'Pago histórico recibo N° 32872',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_27_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_27_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_27,
            v_socio_27,
            NULL,
            11.70,
            'Efectivo',
            '33031',
            'Pago histórico recibo N° 33031',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_27_17, 'monto_aplicado', 5.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_27_18, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_27,
            v_socio_27,
            NULL,
            70.00,
            'Efectivo',
            '33032',
            'Pago histórico recibo N° 33032',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_27_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_27_20, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_27_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CARPIO VASQUEZ TEOFILA (Puesto: 183, ID: 28)
    -- =========================================================================
    DECLARE
        v_socio_28 bigint := 28;
        v_puesto_28 bigint := 277;
        v_m_id_28_0 bigint;
        v_m_id_28_1 bigint;
        v_m_id_28_2 bigint;
        v_m_id_28_3 bigint;
        v_m_id_28_4 bigint;
        v_m_id_28_5 bigint;
        v_m_id_28_6 bigint;
        v_m_id_28_7 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_28 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_28 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_28;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_28 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_28;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_28, 1, 2025, 11, 45.20, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_28_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_28, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_28_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_28, 1, 2025, 12, 44.80, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_28_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_28, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_28_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_28, 1, 2026, 1, 46.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_28_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_28, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_28_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_28, 1, 2026, 2, 44.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_28_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_28, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_28_7;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_28,
            v_socio_28,
            NULL,
            102.00,
            'Efectivo',
            '32401',
            'Pago histórico recibo N° 32401',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_28_0, 'monto_aplicado', 45.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_28_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_28_2, 'monto_aplicado', 44.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_28_3, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_28,
            v_socio_28,
            NULL,
            105.80,
            'Efectivo',
            '32879',
            'Pago histórico recibo N° 32879',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_28_4, 'monto_aplicado', 46.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_28_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_28_6, 'monto_aplicado', 44.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_28_7, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CARRASCO SALVATIERRA FELICITA (Puesto: 75, ID: 29)
    -- =========================================================================
    DECLARE
        v_socio_29 bigint := 29;
        v_puesto_29 bigint := 172;
        v_m_id_29_0 bigint;
        v_m_id_29_1 bigint;
        v_m_id_29_2 bigint;
        v_m_id_29_3 bigint;
        v_m_id_29_4 bigint;
        v_m_id_29_5 bigint;
        v_m_id_29_6 bigint;
        v_m_id_29_7 bigint;
        v_m_id_29_8 bigint;
        v_m_id_29_9 bigint;
        v_m_id_29_10 bigint;
        v_m_id_29_11 bigint;
        v_m_id_29_12 bigint;
        v_m_id_29_13 bigint;
        v_m_id_29_14 bigint;
        v_m_id_29_15 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_29 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_29 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_29;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_29 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_29;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_29, 1, 2025, 11, 82.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_29_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_29, 2, 2025, 11, 22.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_29_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_29, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_29_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_29, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_29_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_29, 1, 2025, 12, 195.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_29_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_29, 2, 2025, 12, 22.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_29_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_29, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_29_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_29, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_29_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_29, 1, 2026, 1, 127.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_29_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_29, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_29_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_29, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_29_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_29, 1, 2026, 2, 132.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_29_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_29, 2, 2026, 2, 17.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_29_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_29, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_29_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_29, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_29_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_29, 1, 2026, 3, 150.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_29_15;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_29,
            v_socio_29,
            NULL,
            250.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_29_0, 'monto_aplicado', 82.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_29_1, 'monto_aplicado', 22.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_29_4, 'monto_aplicado', 145.10, 'cubierto_completo', false)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_29,
            v_socio_29,
            NULL,
            256.00,
            'Efectivo',
            '32899',
            'Pago histórico recibo N° 32899',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_29_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_29_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_29_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_29_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_29_9, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_29_10, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_29_13, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_29_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_29,
            v_socio_29,
            NULL,
            200.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_29_4, 'monto_aplicado', 50.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_29_5, 'monto_aplicado', 22.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_29_8, 'monto_aplicado', 127.40, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_29,
            v_socio_29,
            NULL,
            149.20,
            'Efectivo',
            '32886',
            'Pago histórico recibo N° 32886',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_29_11, 'monto_aplicado', 132.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_29_12, 'monto_aplicado', 17.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_29,
            v_socio_29,
            NULL,
            150.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_29_15, 'monto_aplicado', 150.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CARTAGENA MAMANI BENJAMIN D (Puesto: 165, ID: 30)
    -- =========================================================================
    DECLARE
        v_socio_30 bigint := 30;
        v_puesto_30 bigint := 260;
        v_m_id_30_0 bigint;
        v_m_id_30_1 bigint;
        v_m_id_30_2 bigint;
        v_m_id_30_3 bigint;
        v_m_id_30_4 bigint;
        v_m_id_30_5 bigint;
        v_m_id_30_6 bigint;
        v_m_id_30_7 bigint;
        v_m_id_30_8 bigint;
        v_m_id_30_9 bigint;
        v_m_id_30_10 bigint;
        v_m_id_30_11 bigint;
        v_m_id_30_12 bigint;
        v_m_id_30_13 bigint;
        v_m_id_30_14 bigint;
        v_m_id_30_15 bigint;
        v_m_id_30_16 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_30 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_30 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_30;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_30 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_30;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_30, 1, 2025, 12, 11.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_30_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_30, 2, 2025, 12, 25.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_30_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_30, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_30_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_30, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_30_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_30, 1, 2026, 1, 11.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_30_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_30, 2, 2026, 1, 23.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_30_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_30, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_30_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_30, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_30_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_30, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_30_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_30, 1, 2026, 2, 11.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_30_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_30, 2, 2026, 2, 21.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_30_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_30, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_30_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_30, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_30_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_30, 1, 2026, 3, 10.90, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_30_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_30, 2, 2026, 3, 24.90, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_30_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_30, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_30_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_30, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_30_16;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_30,
            v_socio_30,
            NULL,
            71.20,
            'Efectivo',
            '32583',
            'Pago histórico recibo N° 32583',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_30_0, 'monto_aplicado', 11.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_30_1, 'monto_aplicado', 25.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_30_4, 'monto_aplicado', 11.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_30_5, 'monto_aplicado', 23.10, 'cubierto_completo', true)),
            0.00,
            '2026-02-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_30,
            v_socio_30,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_30_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_30_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_30,
            v_socio_30,
            NULL,
            60.40,
            'Efectivo',
            '32768',
            'Pago histórico recibo N° 32768',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_30_6, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_30_9, 'monto_aplicado', 11.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_30_10, 'monto_aplicado', 21.10, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_30,
            v_socio_30,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_30_7, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_30_8, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_30,
            v_socio_30,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_30_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_30_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_30,
            v_socio_30,
            NULL,
            35.80,
            'Efectivo',
            '32983',
            'Pago histórico recibo N° 32983',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_30_13, 'monto_aplicado', 10.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_30_14, 'monto_aplicado', 24.90, 'cubierto_completo', true)),
            0.00,
            '2026-04-29 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_30,
            v_socio_30,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_30_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_30_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CARTAGENA PALOMINO ALVARO BENJAMIN (Puesto: 89, ID: 31)
    -- =========================================================================
    DECLARE
        v_socio_31 bigint := 31;
        v_puesto_31 bigint := 185;
        v_m_id_31_0 bigint;
        v_m_id_31_1 bigint;
        v_m_id_31_2 bigint;
        v_m_id_31_3 bigint;
        v_m_id_31_4 bigint;
        v_m_id_31_5 bigint;
        v_m_id_31_6 bigint;
        v_m_id_31_7 bigint;
        v_m_id_31_8 bigint;
        v_m_id_31_9 bigint;
        v_m_id_31_10 bigint;
        v_m_id_31_11 bigint;
        v_m_id_31_12 bigint;
        v_m_id_31_13 bigint;
        v_m_id_31_14 bigint;
        v_m_id_31_15 bigint;
        v_m_id_31_16 bigint;
        v_m_id_31_17 bigint;
        v_m_id_31_18 bigint;
        v_m_id_31_19 bigint;
        v_m_id_31_20 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_31 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_31 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_31;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_31 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_31;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 1, 2025, 11, 5.20, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_31_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 2, 2025, 11, 9.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_31_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_31_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_31_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 7, 2025, 12, 200.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_31_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 1, 2025, 12, 50.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_31_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 2, 2025, 12, 10.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_31_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 3, 2025, 12, 10.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_31_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_31_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_31_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 7, 2026, 1, 200.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_31_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 1, 2026, 1, 52.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_31_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 2, 2026, 1, 11.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_31_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_31_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_31_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 7, 2026, 2, 200.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_31_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 1, 2026, 2, 34.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_31_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_31_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_31_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_31_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_31, 7, 2026, 3, 200.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_31_20;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_31,
            v_socio_31,
            NULL,
            252.90,
            'Efectivo',
            '32874',
            'Pago histórico recibo N° 32874',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_31_0, 'monto_aplicado', 5.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_31_1, 'monto_aplicado', 9.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_31_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_31_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_31_5, 'monto_aplicado', 50.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_31_6, 'monto_aplicado', 10.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_31_7, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_31_8, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_31_11, 'monto_aplicado', 52.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_31_12, 'monto_aplicado', 11.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_31_13, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_31_14, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_31,
            v_socio_31,
            NULL,
            400.00,
            'Efectivo',
            '32584',
            'Pago histórico recibo N° 32584',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_31_4, 'monto_aplicado', 200.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_31_10, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_31,
            v_socio_31,
            NULL,
            60.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_31_9, 'monto_aplicado', 60.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_31,
            v_socio_31,
            NULL,
            200.00,
            'Efectivo',
            '32769',
            'Pago histórico recibo N° 32769',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_31_15, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_31,
            v_socio_31,
            NULL,
            105.70,
            'Efectivo',
            '32875',
            'Pago histórico recibo N° 32875',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_31_16, 'monto_aplicado', 34.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_31_17, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_31_18, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_31_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_31,
            v_socio_31,
            NULL,
            200.00,
            'Efectivo',
            '32984',
            'Pago histórico recibo N° 32984',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_31_20, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-29 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CASTRO ALEJANDRO HORTENCIA LUCILA (Puesto: 79, ID: 32)
    -- =========================================================================
    DECLARE
        v_socio_32 bigint := 32;
        v_puesto_32 bigint := 175;
        v_m_id_32_0 bigint;
        v_m_id_32_1 bigint;
        v_m_id_32_2 bigint;
        v_m_id_32_3 bigint;
        v_m_id_32_4 bigint;
        v_m_id_32_5 bigint;
        v_m_id_32_6 bigint;
        v_m_id_32_7 bigint;
        v_m_id_32_8 bigint;
        v_m_id_32_9 bigint;
        v_m_id_32_10 bigint;
        v_m_id_32_11 bigint;
        v_m_id_32_12 bigint;
        v_m_id_32_13 bigint;
        v_m_id_32_14 bigint;
        v_m_id_32_15 bigint;
        v_m_id_32_16 bigint;
        v_m_id_32_17 bigint;
        v_m_id_32_18 bigint;
        v_m_id_32_19 bigint;
        v_m_id_32_20 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_32 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_32 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_32;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_32 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_32;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 1, 2025, 11, 33.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_32_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_32_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_32_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_32_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 1, 2025, 12, 36.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_32_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_32_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_32_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 18, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P', v_user_uuid)
        RETURNING id INTO v_m_id_32_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 1, 2026, 1, 28.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_32_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_32_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_32_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_32_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_32_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_32_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 1, 2026, 2, 30.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_32_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_32_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_32_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_32_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 1, 2026, 3, 26.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_32_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_32_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_32, 3, 2026, 3, 35.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_32_20;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_32,
            v_socio_32,
            NULL,
            100.00,
            'Efectivo',
            '32432',
            'Pago histórico recibo N° 32432',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_32_0, 'monto_aplicado', 33.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_3, 'monto_aplicado', 0.70, 'cubierto_completo', false)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_32,
            v_socio_32,
            NULL,
            100.00,
            'Efectivo',
            '32501',
            'Pago histórico recibo N° 32501',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_32_3, 'monto_aplicado', 4.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_4, 'monto_aplicado', 36.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_6, 'monto_aplicado', 53.70, 'cubierto_completo', false)),
            0.00,
            '2026-02-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_32,
            v_socio_32,
            NULL,
            249.80,
            'Efectivo',
            '32910',
            'Pago histórico recibo N° 32910',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_32_6, 'monto_aplicado', 6.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_8, 'monto_aplicado', 28.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_13, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_14, 'monto_aplicado', 30.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_16, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_32,
            v_socio_32,
            NULL,
            67.00,
            'Efectivo',
            '33076',
            'Pago histórico recibo N° 33076',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_32_18, 'monto_aplicado', 26.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_19, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_32_20, 'monto_aplicado', 35.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-15 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-15 12:00:00-05', created_at = '2026-05-15 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-15 12:00:00-05', created_at = '2026-05-15 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CASTRO GUTIERREZ AQUILA LUCRECIA (Puesto: 18, ID: 33)
    -- =========================================================================
    DECLARE
        v_socio_33 bigint := 33;
        v_puesto_33 bigint := 72;
        v_m_id_33_0 bigint;
        v_m_id_33_1 bigint;
        v_m_id_33_2 bigint;
        v_m_id_33_3 bigint;
        v_m_id_33_4 bigint;
        v_m_id_33_5 bigint;
        v_m_id_33_6 bigint;
        v_m_id_33_7 bigint;
        v_m_id_33_8 bigint;
        v_m_id_33_9 bigint;
        v_m_id_33_10 bigint;
        v_m_id_33_11 bigint;
        v_m_id_33_12 bigint;
        v_m_id_33_13 bigint;
        v_m_id_33_14 bigint;
        v_m_id_33_15 bigint;
        v_m_id_33_16 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_33 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_33 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_33;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_33 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_33;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_33, 1, 2025, 12, 45.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_33_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_33, 2, 2025, 12, 15.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_33_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_33, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_33_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_33, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_33_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_33, 1, 2026, 1, 49.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_33_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_33, 2, 2026, 1, 19.80, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_33_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_33, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_33_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_33, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_33_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_33, 1, 2026, 2, 48.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_33_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_33, 2, 2026, 2, 12.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_33_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_33, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_33_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_33, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_33_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_33, 6, 2026, 3, 113.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - MULTA 26/03/2026', v_user_uuid)
        RETURNING id INTO v_m_id_33_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_33, 1, 2026, 3, 50.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_33_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_33, 2, 2026, 3, 25.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_33_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_33, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_33_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_33, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_33_16;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_33,
            v_socio_33,
            NULL,
            60.00,
            'Efectivo',
            '32506',
            'Pago histórico recibo N° 32506',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_33_0, 'monto_aplicado', 45.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_33_1, 'monto_aplicado', 15.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-13 12:00:00-05', created_at = '2026-02-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_33,
            v_socio_33,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_33_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_33_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_33,
            v_socio_33,
            NULL,
            69.00,
            'Efectivo',
            '32675',
            'Pago histórico recibo N° 32675',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_33_4, 'monto_aplicado', 49.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_33_5, 'monto_aplicado', 19.80, 'cubierto_completo', true)),
            0.00,
            '2026-03-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-16 12:00:00-05', created_at = '2026-03-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-16 12:00:00-05', created_at = '2026-03-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_33,
            v_socio_33,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_33_6, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_33_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_33,
            v_socio_33,
            NULL,
            61.10,
            'Efectivo',
            '32747',
            'Pago histórico recibo N° 32747',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_33_8, 'monto_aplicado', 48.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_33_9, 'monto_aplicado', 12.60, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_33,
            v_socio_33,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_33_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_33_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_33,
            v_socio_33,
            NULL,
            113.00,
            'Efectivo',
            '32990',
            'Pago histórico recibo N° 32990',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_33_12, 'monto_aplicado', 113.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-29 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_33,
            v_socio_33,
            NULL,
            75.70,
            'Efectivo',
            '33084',
            'Pago histórico recibo N° 33084',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_33_13, 'monto_aplicado', 50.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_33_14, 'monto_aplicado', 25.20, 'cubierto_completo', true)),
            0.00,
            '2026-05-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-18 12:00:00-05', created_at = '2026-05-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-18 12:00:00-05', created_at = '2026-05-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_33,
            v_socio_33,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_33_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_33_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CCOYLLO CHINCHAY DANIEL MASIA (Puesto: 62, ID: 35)
    -- =========================================================================
    DECLARE
        v_socio_35 bigint := 35;
        v_puesto_35 bigint := 158;
        v_m_id_35_0 bigint;
        v_m_id_35_1 bigint;
        v_m_id_35_2 bigint;
        v_m_id_35_3 bigint;
        v_m_id_35_4 bigint;
        v_m_id_35_5 bigint;
        v_m_id_35_6 bigint;
        v_m_id_35_7 bigint;
        v_m_id_35_8 bigint;
        v_m_id_35_9 bigint;
        v_m_id_35_10 bigint;
        v_m_id_35_11 bigint;
        v_m_id_35_12 bigint;
        v_m_id_35_13 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_35 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_35 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_35;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_35 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_35;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_35, 1, 2025, 12, 14.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_35_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_35, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_35_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_35, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_35_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_35, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_35_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_35, 1, 2026, 1, 13.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_35_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_35, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_35_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_35, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_35_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_35, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_35_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_35, 1, 2026, 2, 13.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_35_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_35, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_35_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_35, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_35_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_35, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_35_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_35, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_35_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_35, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_35_13;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_35,
            v_socio_35,
            NULL,
            38.70,
            'Efectivo',
            '32648',
            'Pago histórico recibo N° 32648',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_35_0, 'monto_aplicado', 14.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_35_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_35_4, 'monto_aplicado', 13.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_35_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_35,
            v_socio_35,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_35_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_35_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_35,
            v_socio_35,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_35_6, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_35_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_35,
            v_socio_35,
            NULL,
            23.50,
            'Efectivo',
            '32822',
            'Pago histórico recibo N° 32822',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_35_8, 'monto_aplicado', 13.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_35_9, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_35,
            v_socio_35,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_35_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_35_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_35,
            v_socio_35,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_35_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_35_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CCOYLLO CHINCHAY JUDITH NATY (Puesto: 55, ID: 36)
    -- =========================================================================
    DECLARE
        v_socio_36 bigint := 36;
        v_puesto_36 bigint := 144;
        v_m_id_36_0 bigint;
        v_m_id_36_1 bigint;
        v_m_id_36_2 bigint;
        v_m_id_36_3 bigint;
        v_m_id_36_4 bigint;
        v_m_id_36_5 bigint;
        v_m_id_36_6 bigint;
        v_m_id_36_7 bigint;
        v_m_id_36_8 bigint;
        v_m_id_36_9 bigint;
        v_m_id_36_10 bigint;
        v_m_id_36_11 bigint;
        v_m_id_36_12 bigint;
        v_m_id_36_13 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_36 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_36 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_36;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_36 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_36;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_36, 1, 2025, 12, 42.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_36_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_36, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_36_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_36, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_36_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_36, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_36_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_36, 1, 2026, 1, 41.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_36_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_36, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_36_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_36, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_36_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_36, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_36_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_36, 1, 2026, 2, 40.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_36_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_36, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_36_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_36, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_36_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_36, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_36_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_36, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_36_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_36, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_36_13;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_36,
            v_socio_36,
            NULL,
            95.00,
            'Efectivo',
            '32647',
            'Pago histórico recibo N° 32647',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_36_0, 'monto_aplicado', 42.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_36_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_36_4, 'monto_aplicado', 41.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_36_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_36,
            v_socio_36,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_36_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_36_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_36,
            v_socio_36,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_36_6, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_36_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_36,
            v_socio_36,
            NULL,
            50.80,
            'Efectivo',
            '32823',
            'Pago histórico recibo N° 32823',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_36_8, 'monto_aplicado', 40.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_36_9, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_36,
            v_socio_36,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_36_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_36_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_36,
            v_socio_36,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_36_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_36_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CCOYLLO POLANCO DANIEL (Puesto: 117, ID: 38)
    -- =========================================================================
    DECLARE
        v_socio_38 bigint := 38;
        v_puesto_38 bigint := 212;
        v_m_id_38_0 bigint;
        v_m_id_38_1 bigint;
        v_m_id_38_2 bigint;
        v_m_id_38_3 bigint;
        v_m_id_38_4 bigint;
        v_m_id_38_5 bigint;
        v_m_id_38_6 bigint;
        v_m_id_38_7 bigint;
        v_m_id_38_8 bigint;
        v_m_id_38_9 bigint;
        v_m_id_38_10 bigint;
        v_m_id_38_11 bigint;
        v_m_id_38_12 bigint;
        v_m_id_38_13 bigint;
        v_m_id_38_14 bigint;
        v_m_id_38_15 bigint;
        v_m_id_38_16 bigint;
        v_m_id_38_17 bigint;
        v_m_id_38_18 bigint;
        v_m_id_38_19 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_38 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_38 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_38;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_38 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_38;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 1, 2025, 11, 444.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_38_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_38_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_38_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_38_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_38_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_38_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 1, 2025, 12, 375.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_38_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_38_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 1, 2026, 1, 325.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_38_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_38_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_38_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_38_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 1, 2026, 2, 329.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_38_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_38_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_38_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_38_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 1, 2026, 3, 335.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_38_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_38_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_38_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_38, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_38_19;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_38,
            v_socio_38,
            NULL,
            580.00,
            'Efectivo',
            '32309',
            'Pago histórico recibo N° 32309',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_38_0, 'monto_aplicado', 444.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_38_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_38_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_38_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_38_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_38_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-12 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-12 12:00:00-05', created_at = '2026-01-12 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-12 12:00:00-05', created_at = '2026-01-12 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_38,
            v_socio_38,
            NULL,
            381.90,
            'Efectivo',
            '32424',
            'Pago histórico recibo N° 32424',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_38_6, 'monto_aplicado', 375.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_38_7, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_38,
            v_socio_38,
            NULL,
            395.60,
            'Efectivo',
            '32515',
            'Pago histórico recibo N° 32515',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_38_8, 'monto_aplicado', 325.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_38_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_38_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_38_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-16 12:00:00-05', created_at = '2026-02-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-16 12:00:00-05', created_at = '2026-02-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_38,
            v_socio_38,
            NULL,
            400.20,
            'Efectivo',
            '32742',
            'Pago histórico recibo N° 32742',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_38_12, 'monto_aplicado', 329.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_38_13, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_38_14, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_38_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_38,
            v_socio_38,
            NULL,
            406.20,
            'Efectivo',
            '32965',
            'Pago histórico recibo N° 32965',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_38_16, 'monto_aplicado', 335.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_38_17, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_38_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_38_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-27 12:00:00-05', created_at = '2026-04-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-27 12:00:00-05', created_at = '2026-04-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CCOYLLO MAYHUASCA ALEXIS (Puesto: 110, ID: 37)
    -- =========================================================================
    DECLARE
        v_socio_37 bigint := 37;
        v_puesto_37 bigint := 205;
        v_m_id_37_0 bigint;
        v_m_id_37_1 bigint;
        v_m_id_37_2 bigint;
        v_m_id_37_3 bigint;
        v_m_id_37_4 bigint;
        v_m_id_37_5 bigint;
        v_m_id_37_6 bigint;
        v_m_id_37_7 bigint;
        v_m_id_37_8 bigint;
        v_m_id_37_9 bigint;
        v_m_id_37_10 bigint;
        v_m_id_37_11 bigint;
        v_m_id_37_12 bigint;
        v_m_id_37_13 bigint;
        v_m_id_37_14 bigint;
        v_m_id_37_15 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_37 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_37 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_37;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_37 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_37;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_37, 1, 2025, 12, 4.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_37_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_37, 2, 2025, 12, 7.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_37_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_37, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_37_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_37, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_37_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_37, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_37_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_37, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_37_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_37, 1, 2026, 1, 4.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_37_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_37, 2, 2026, 1, 5.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_37_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_37, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_37_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_37, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_37_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_37, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_37_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_37, 1, 2026, 2, 4.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_37_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_37, 2, 2026, 2, 12.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_37_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_37, 3, 2026, 3, 20.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_37_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_37, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_37_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_37, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_37_15;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_37,
            v_socio_37,
            NULL,
            95.90,
            'Efectivo',
            '32551',
            'Pago histórico recibo N° 32551',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_37_0, 'monto_aplicado', 4.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_37_1, 'monto_aplicado', 7.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_37_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_37_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_37_6, 'monto_aplicado', 4.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_37_7, 'monto_aplicado', 5.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_37_8, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_37,
            v_socio_37,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_37_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_37_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_37,
            v_socio_37,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_37_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_37_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_37,
            v_socio_37,
            NULL,
            16.80,
            'Efectivo',
            '32825',
            'Pago histórico recibo N° 32825',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_37_11, 'monto_aplicado', 4.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_37_12, 'monto_aplicado', 12.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_37,
            v_socio_37,
            NULL,
            20.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_37_13, 'monto_aplicado', 20.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_37,
            v_socio_37,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_37_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_37_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CCOYLLO POLANCO GERMAN (Puesto: 49, ID: 39)
    -- =========================================================================
    DECLARE
        v_socio_39 bigint := 39;
        v_puesto_39 bigint := 132;
        v_m_id_39_0 bigint;
        v_m_id_39_1 bigint;
        v_m_id_39_2 bigint;
        v_m_id_39_3 bigint;
        v_m_id_39_4 bigint;
        v_m_id_39_5 bigint;
        v_m_id_39_6 bigint;
        v_m_id_39_7 bigint;
        v_m_id_39_8 bigint;
        v_m_id_39_9 bigint;
        v_m_id_39_10 bigint;
        v_m_id_39_11 bigint;
        v_m_id_39_12 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_39 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_39 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_39;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_39 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_39;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_39, 1, 2025, 12, 12.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_39_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_39, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_39_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_39, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_39_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_39, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_39_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_39, 1, 2026, 1, 13.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_39_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_39, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_39_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_39, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_39_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_39, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_39_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_39, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_39_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_39, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_39_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_39, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_39_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_39, 1, 2026, 2, 13.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_39_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_39, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_39_12;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_39,
            v_socio_39,
            NULL,
            238.10,
            'Efectivo',
            '32646',
            'Pago histórico recibo N° 32646',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_39_0, 'monto_aplicado', 12.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_39_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_39_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_39_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_39_4, 'monto_aplicado', 13.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_39_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_39_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_39_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_39_8, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_39_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_39_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_39,
            v_socio_39,
            NULL,
            23.50,
            'Efectivo',
            '32824',
            'Pago histórico recibo N° 32824',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_39_11, 'monto_aplicado', 13.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_39_12, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CERDA YUPANQUI CARMEN ROSA (Puesto: 103, ID: 40)
    -- =========================================================================
    DECLARE
        v_socio_40 bigint := 40;
        v_puesto_40 bigint := 198;
        v_m_id_40_0 bigint;
        v_m_id_40_1 bigint;
        v_m_id_40_2 bigint;
        v_m_id_40_3 bigint;
        v_m_id_40_4 bigint;
        v_m_id_40_5 bigint;
        v_m_id_40_6 bigint;
        v_m_id_40_7 bigint;
        v_m_id_40_8 bigint;
        v_m_id_40_9 bigint;
        v_m_id_40_10 bigint;
        v_m_id_40_11 bigint;
        v_m_id_40_12 bigint;
        v_m_id_40_13 bigint;
        v_m_id_40_14 bigint;
        v_m_id_40_15 bigint;
        v_m_id_40_16 bigint;
        v_m_id_40_17 bigint;
        v_m_id_40_18 bigint;
        v_m_id_40_19 bigint;
        v_m_id_40_20 bigint;
        v_m_id_40_21 bigint;
        v_m_id_40_22 bigint;
        v_m_id_40_23 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_40 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_40 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_40;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_40 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_40;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 1, 2025, 11, 16.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_40_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_40_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 16, 2025, 11, 200.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - DEPOSITO N° 2A 1 PISO', v_user_uuid)
        RETURNING id INTO v_m_id_40_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 1, 2025, 12, 4.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_40_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_40_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_40_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_40_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 16, 2025, 12, 200.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - DEPOSITO N° 2A 1 PISO', v_user_uuid)
        RETURNING id INTO v_m_id_40_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_40_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_40_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 16, 2026, 1, 200.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - DEPOSITO N° 2A 1 PISO', v_user_uuid)
        RETURNING id INTO v_m_id_40_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 1, 2026, 1, 39.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_40_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_40_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_40_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_40_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 1, 2026, 2, 28.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_40_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_40_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 16, 2026, 2, 200.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO N° 2A 1 PISO', v_user_uuid)
        RETURNING id INTO v_m_id_40_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_40_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_40_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_40_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 16, 2026, 3, 200.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - DEPOSITO N° 2A 1 PISO', v_user_uuid)
        RETURNING id INTO v_m_id_40_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_40_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_40, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_40_23;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_40,
            v_socio_40,
            NULL,
            697.50,
            'Efectivo',
            '32496',
            'Pago histórico recibo N° 32496',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_40_0, 'monto_aplicado', 16.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_2, 'monto_aplicado', 200.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_3, 'monto_aplicado', 4.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_4, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_5, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_6, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_7, 'monto_aplicado', 200.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_10, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_40,
            v_socio_40,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_40_8, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_40,
            v_socio_40,
            NULL,
            256.10,
            'Efectivo',
            '32792',
            'Pago histórico recibo N° 32792',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_40_11, 'monto_aplicado', 12.90, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_40_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_15, 'monto_aplicado', 28.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_16, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_17, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_40,
            v_socio_40,
            NULL,
            61.00,
            'Efectivo',
            '32586',
            'Pago histórico recibo N° 32586',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_40_13, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_40,
            v_socio_40,
            NULL,
            298.00,
            'Efectivo',
            '33050',
            'Pago histórico recibo N° 33050',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_40_11, 'monto_aplicado', 27.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_18, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_20, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_21, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_40,
            v_socio_40,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_40_22, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_40_23, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CHALLCO CRUZ DE PALOMINO NICOLAZA (Puesto: 194, ID: 41)
    -- =========================================================================
    DECLARE
        v_socio_41 bigint := 41;
        v_puesto_41 bigint := 287;
        v_m_id_41_0 bigint;
        v_m_id_41_1 bigint;
        v_m_id_41_2 bigint;
        v_m_id_41_3 bigint;
        v_m_id_41_4 bigint;
        v_m_id_41_5 bigint;
        v_m_id_41_6 bigint;
        v_m_id_41_7 bigint;
        v_m_id_41_8 bigint;
        v_m_id_41_9 bigint;
        v_m_id_41_10 bigint;
        v_m_id_41_11 bigint;
        v_m_id_41_12 bigint;
        v_m_id_41_13 bigint;
        v_m_id_41_14 bigint;
        v_m_id_41_15 bigint;
        v_m_id_41_16 bigint;
        v_m_id_41_17 bigint;
        v_m_id_41_18 bigint;
        v_m_id_41_19 bigint;
        v_m_id_41_20 bigint;
        v_m_id_41_21 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_41 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_41 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_41;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_41 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_41;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 1, 2025, 11, 694.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_41_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 2, 2025, 11, 26.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_41_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 1, 2025, 12, 749.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_41_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 2, 2025, 12, 30.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_41_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 3, 2025, 12, 40.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_41_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_41_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 1, 2026, 1, 823.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_41_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 2, 2026, 1, 28.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_41_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_41_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_41_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_41_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_41_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_41_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_41_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 1, 2026, 2, 860.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_41_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 2, 2026, 2, 32.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_41_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_41_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_41_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 1, 2026, 3, 829.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_41_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 2, 2026, 3, 40.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_41_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_41_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_41, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_41_21;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_41,
            v_socio_41,
            NULL,
            1545.80,
            'Efectivo',
            '32353',
            'Pago histórico recibo N° 32353',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_41_0, 'monto_aplicado', 694.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_41_1, 'monto_aplicado', 26.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_41_2, 'monto_aplicado', 749.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_41_3, 'monto_aplicado', 30.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_41_4, 'monto_aplicado', 40.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_41_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_41,
            v_socio_41,
            NULL,
            955.00,
            'Efectivo',
            '32548',
            'Pago histórico recibo N° 32548',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_41_6, 'monto_aplicado', 823.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_41_7, 'monto_aplicado', 28.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_41_8, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_41_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_41_10, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_41_11, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-02-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_41,
            v_socio_41,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_41_12, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_41_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_41,
            v_socio_41,
            NULL,
            892.50,
            'Efectivo',
            '32726',
            'Pago histórico recibo N° 32726',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_41_14, 'monto_aplicado', 860.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_41_15, 'monto_aplicado', 32.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_41,
            v_socio_41,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_41_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_41_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_41,
            v_socio_41,
            NULL,
            515.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_41_18, 'monto_aplicado', 450.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_41_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_41_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_41,
            v_socio_41,
            NULL,
            419.70,
            'Efectivo',
            '32992',
            'Pago histórico recibo N° 32992',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_41_18, 'monto_aplicado', 379.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_41_19, 'monto_aplicado', 40.20, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CHIRINOS CABRACANCHA MARIA LOURDES (Puesto: 78, ID: 42)
    -- =========================================================================
    DECLARE
        v_socio_42 bigint := 42;
        v_puesto_42 bigint := 174;
        v_m_id_42_0 bigint;
        v_m_id_42_1 bigint;
        v_m_id_42_2 bigint;
        v_m_id_42_3 bigint;
        v_m_id_42_4 bigint;
        v_m_id_42_5 bigint;
        v_m_id_42_6 bigint;
        v_m_id_42_7 bigint;
        v_m_id_42_8 bigint;
        v_m_id_42_9 bigint;
        v_m_id_42_10 bigint;
        v_m_id_42_11 bigint;
        v_m_id_42_12 bigint;
        v_m_id_42_13 bigint;
        v_m_id_42_14 bigint;
        v_m_id_42_15 bigint;
        v_m_id_42_16 bigint;
        v_m_id_42_17 bigint;
        v_m_id_42_18 bigint;
        v_m_id_42_19 bigint;
        v_m_id_42_20 bigint;
        v_m_id_42_21 bigint;
        v_m_id_42_22 bigint;
        v_m_id_42_23 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_42 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_42 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_42;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_42 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_42;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 1, 2025, 11, 117.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_42_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 2, 2025, 11, 11.80, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_42_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 3, 2025, 11, 14.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_42_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_42_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 1, 2025, 12, 118.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_42_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 2, 2025, 12, 12.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_42_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_42_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_42_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 1, 2026, 1, 115.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_42_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 2, 2026, 1, 16.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_42_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_42_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_42_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_42_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_42_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 1, 2026, 2, 113.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_42_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 2, 2026, 2, 21.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_42_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_42_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_42_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 1, 2026, 3, 117.60, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_42_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 2, 2026, 3, 22.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_42_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_42_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_42_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 1, 2026, 4, 138.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_42_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_42, 2, 2026, 4, 24.80, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_42_23;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_42,
            v_socio_42,
            NULL,
            147.80,
            'Efectivo',
            '32364',
            'Pago histórico recibo N° 32364',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_42_0, 'monto_aplicado', 117.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_42_1, 'monto_aplicado', 11.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_42_2, 'monto_aplicado', 14.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_42_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_42,
            v_socio_42,
            NULL,
            131.60,
            'Efectivo',
            '32588',
            'Pago histórico recibo N° 32588',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_42_4, 'monto_aplicado', 118.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_42_5, 'monto_aplicado', 12.90, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_42,
            v_socio_42,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_42_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_42_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_42,
            v_socio_42,
            NULL,
            132.00,
            'Efectivo',
            '32630',
            'Pago histórico recibo N° 32630',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_42_8, 'monto_aplicado', 115.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_42_9, 'monto_aplicado', 16.70, 'cubierto_completo', true)),
            0.00,
            '2026-03-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-07 12:00:00-05', created_at = '2026-03-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-07 12:00:00-05', created_at = '2026-03-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_42,
            v_socio_42,
            NULL,
            59.30,
            'Efectivo',
            '32631',
            'Pago histórico recibo N° 32631',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_42_10, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_42_11, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_42_12, 'monto_aplicado', 16.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_42_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-07 12:00:00-05', created_at = '2026-03-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-07 12:00:00-05', created_at = '2026-03-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_42,
            v_socio_42,
            NULL,
            40.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_42_12, 'monto_aplicado', 40.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_42,
            v_socio_42,
            NULL,
            134.70,
            'Efectivo',
            '32771',
            'Pago histórico recibo N° 32771',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_42_14, 'monto_aplicado', 113.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_42_15, 'monto_aplicado', 21.10, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_42,
            v_socio_42,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_42_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_42_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_42,
            v_socio_42,
            NULL,
            139.80,
            'Efectivo',
            '32971',
            'Pago histórico recibo N° 32971',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_42_18, 'monto_aplicado', 117.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_42_19, 'monto_aplicado', 22.20, 'cubierto_completo', true)),
            0.00,
            '2026-04-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_42,
            v_socio_42,
            NULL,
            40.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_42_20, 'monto_aplicado', 40.00, 'cubierto_completo', false)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_42,
            v_socio_42,
            NULL,
            25.00,
            'Efectivo',
            '33028',
            'Pago histórico recibo N° 33028',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_42_20, 'monto_aplicado', 20.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_42_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_42,
            v_socio_42,
            NULL,
            162.80,
            'Efectivo',
            '33106',
            'Pago histórico recibo N° 33106',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_42_22, 'monto_aplicado', 138.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_42_23, 'monto_aplicado', 24.80, 'cubierto_completo', true)),
            0.00,
            '2026-05-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-23 12:00:00-05', created_at = '2026-05-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-23 12:00:00-05', created_at = '2026-05-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CCOYLLO BUSTILLOS DEYSI KAREN (Puesto: 17, ID: 34)
    -- =========================================================================
    DECLARE
        v_socio_34 bigint := 34;
        v_puesto_34 bigint := 70;
        v_m_id_34_0 bigint;
        v_m_id_34_1 bigint;
        v_m_id_34_2 bigint;
        v_m_id_34_3 bigint;
        v_m_id_34_4 bigint;
        v_m_id_34_5 bigint;
        v_m_id_34_6 bigint;
        v_m_id_34_7 bigint;
        v_m_id_34_8 bigint;
        v_m_id_34_9 bigint;
        v_m_id_34_10 bigint;
        v_m_id_34_11 bigint;
        v_m_id_34_12 bigint;
        v_m_id_34_13 bigint;
        v_m_id_34_14 bigint;
        v_m_id_34_15 bigint;
        v_m_id_34_16 bigint;
        v_m_id_34_17 bigint;
        v_m_id_34_18 bigint;
        v_m_id_34_19 bigint;
        v_m_id_34_20 bigint;
        v_m_id_34_21 bigint;
        v_m_id_34_22 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_34 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_34 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_34;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_34 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_34;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 1, 2025, 11, 105.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_34_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_34_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_34_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_34_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 6, 2025, 11, 113.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - MULTA 27-11-2025', v_user_uuid)
        RETURNING id INTO v_m_id_34_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_34_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_34_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 1, 2025, 12, 106.80, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_34_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_34_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 1, 2026, 1, 103.80, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_34_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_34_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_34_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_34_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 1, 2026, 2, 102.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_34_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_34_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_34_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_34_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 1, 2026, 3, 106.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_34_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_34_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_34_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_34_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_34_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_34, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_34_22;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_34,
            v_socio_34,
            NULL,
            241.30,
            'Efectivo',
            '32313',
            'Pago histórico recibo N° 32313',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_34_0, 'monto_aplicado', 105.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_5, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_6, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-12 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-12 12:00:00-05', created_at = '2026-01-12 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-12 12:00:00-05', created_at = '2026-01-12 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_34,
            v_socio_34,
            NULL,
            113.00,
            'Efectivo',
            '32610',
            'Pago histórico recibo N° 32610',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_34_4, 'monto_aplicado', 113.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-03 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_34,
            v_socio_34,
            NULL,
            286.60,
            'Efectivo',
            '32609',
            'Pago histórico recibo N° 32609',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_34_7, 'monto_aplicado', 106.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_8, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_9, 'monto_aplicado', 103.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_10, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-03 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_34,
            v_socio_34,
            NULL,
            173.30,
            'Efectivo',
            '32798',
            'Pago histórico recibo N° 32798',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_34_13, 'monto_aplicado', 102.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_14, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_34,
            v_socio_34,
            NULL,
            242.00,
            'Efectivo',
            '33092',
            'Pago histórico recibo N° 33092',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_34_17, 'monto_aplicado', 106.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_18, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_20, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_21, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_34_22, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-20 12:00:00-05', created_at = '2026-05-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-20 12:00:00-05', created_at = '2026-05-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CHOQUEHUAMANI FELIX CEFERINO (Puesto: 93, ID: 43)
    -- =========================================================================
    DECLARE
        v_socio_43 bigint := 43;
        v_puesto_43 bigint := 188;
        v_m_id_43_0 bigint;
        v_m_id_43_1 bigint;
        v_m_id_43_2 bigint;
        v_m_id_43_3 bigint;
        v_m_id_43_4 bigint;
        v_m_id_43_5 bigint;
        v_m_id_43_6 bigint;
        v_m_id_43_7 bigint;
        v_m_id_43_8 bigint;
        v_m_id_43_9 bigint;
        v_m_id_43_10 bigint;
        v_m_id_43_11 bigint;
        v_m_id_43_12 bigint;
        v_m_id_43_13 bigint;
        v_m_id_43_14 bigint;
        v_m_id_43_15 bigint;
        v_m_id_43_16 bigint;
        v_m_id_43_17 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_43 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_43 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_43;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_43 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_43;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 18, 2026, 8, 15.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - TALONARIO SANTA ROSA', v_user_uuid)
        RETURNING id INTO v_m_id_43_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 3, 2025, 11, 44.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_43_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_43_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 1, 2025, 12, 14.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_43_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 2, 2025, 12, 29.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_43_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 3, 2025, 12, 55.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_43_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_43_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_43_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_43_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 1, 2026, 1, 15.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_43_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 2, 2026, 1, 39.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_43_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_43_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 1, 2026, 2, 17.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_43_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 2, 2026, 2, 45.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_43_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_43_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_43_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 3, 2026, 3, 40.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_43_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_43, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_43_17;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_43,
            v_socio_43,
            NULL,
            25.00,
            'Efectivo',
            '32793',
            'Pago histórico recibo N° 32793',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_43_0, 'monto_aplicado', 15.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_43_11, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_43,
            v_socio_43,
            NULL,
            49.70,
            'Efectivo',
            '32275',
            'Pago histórico recibo N° 32275',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_43_1, 'monto_aplicado', 44.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_43_2, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-02 12:00:00-05', created_at = '2026-01-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-02 12:00:00-05', created_at = '2026-01-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_43,
            v_socio_43,
            NULL,
            100.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_43_3, 'monto_aplicado', 14.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_43_4, 'monto_aplicado', 29.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_43_5, 'monto_aplicado', 55.60, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_43,
            v_socio_43,
            NULL,
            75.60,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_43_6, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_43_9, 'monto_aplicado', 15.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_43_10, 'monto_aplicado', 39.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_43_7, 'monto_aplicado', 15.70, 'cubierto_completo', false)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_43,
            v_socio_43,
            NULL,
            49.30,
            'Efectivo',
            '32581',
            'Pago histórico recibo N° 32581',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_43_7, 'monto_aplicado', 44.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_43_8, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_43,
            v_socio_43,
            NULL,
            110.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_43_12, 'monto_aplicado', 17.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_43_13, 'monto_aplicado', 45.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_43_14, 'monto_aplicado', 6.70, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_43_16, 'monto_aplicado', 40.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_43,
            v_socio_43,
            NULL,
            54.30,
            'Efectivo',
            '32851',
            'Pago histórico recibo N° 32851',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_43_14, 'monto_aplicado', 49.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_43_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_43,
            v_socio_43,
            NULL,
            60.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_43_17, 'monto_aplicado', 60.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CHUCHULLO HACHA JOSE PEDRO (Puesto: 67, ID: 44)
    -- =========================================================================
    DECLARE
        v_socio_44 bigint := 44;
        v_puesto_44 bigint := 164;
        v_m_id_44_0 bigint;
        v_m_id_44_1 bigint;
        v_m_id_44_2 bigint;
        v_m_id_44_3 bigint;
        v_m_id_44_4 bigint;
        v_m_id_44_5 bigint;
        v_m_id_44_6 bigint;
        v_m_id_44_7 bigint;
        v_m_id_44_8 bigint;
        v_m_id_44_9 bigint;
        v_m_id_44_10 bigint;
        v_m_id_44_11 bigint;
        v_m_id_44_12 bigint;
        v_m_id_44_13 bigint;
        v_m_id_44_14 bigint;
        v_m_id_44_15 bigint;
        v_m_id_44_16 bigint;
        v_m_id_44_17 bigint;
        v_m_id_44_18 bigint;
        v_m_id_44_19 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_44 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_44 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_44;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_44 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_44;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 1, 2025, 12, 30.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_44_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_44_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 16, 2025, 12, 150.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - DEPOSITO N° 2 3PISO', v_user_uuid)
        RETURNING id INTO v_m_id_44_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_44_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_44_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 1, 2026, 1, 30.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_44_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_44_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 16, 2026, 1, 150.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - DEPOSITO N° 2 3PISO', v_user_uuid)
        RETURNING id INTO v_m_id_44_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_44_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_44_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 1, 2026, 2, 29.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_44_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_44_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 16, 2026, 2, 150.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO N° 2 3PISO', v_user_uuid)
        RETURNING id INTO v_m_id_44_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_44_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_44_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 1, 2026, 3, 31.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_44_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_44_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 16, 2026, 3, 150.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - DEPOSITO N° 2 3PISO', v_user_uuid)
        RETURNING id INTO v_m_id_44_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_44_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_44, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_44_19;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_44,
            v_socio_44,
            NULL,
            186.90,
            'Efectivo',
            '32352',
            'Pago histórico recibo N° 32352',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_44_0, 'monto_aplicado', 30.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_44_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_44_2, 'monto_aplicado', 150.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_44,
            v_socio_44,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_44_3, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_44_4, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_44,
            v_socio_44,
            NULL,
            374.70,
            'Efectivo',
            '32704',
            'Pago histórico recibo N° 32704',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_44_5, 'monto_aplicado', 30.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_44_6, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_44_7, 'monto_aplicado', 150.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_44_10, 'monto_aplicado', 29.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_44_11, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_44_12, 'monto_aplicado', 150.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_44,
            v_socio_44,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_44_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_44_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_44,
            v_socio_44,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_44_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_44_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_44,
            v_socio_44,
            NULL,
            187.10,
            'Efectivo',
            '33004',
            'Pago histórico recibo N° 33004',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_44_15, 'monto_aplicado', 31.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_44_16, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_44_17, 'monto_aplicado', 150.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_44,
            v_socio_44,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_44_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_44_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CLEMENTE ALLER CIRILA (Puesto: 27, ID: 45)
    -- =========================================================================
    DECLARE
        v_socio_45 bigint := 45;
        v_puesto_45 bigint := 90;
        v_m_id_45_0 bigint;
        v_m_id_45_1 bigint;
        v_m_id_45_2 bigint;
        v_m_id_45_3 bigint;
        v_m_id_45_4 bigint;
        v_m_id_45_5 bigint;
        v_m_id_45_6 bigint;
        v_m_id_45_7 bigint;
        v_m_id_45_8 bigint;
        v_m_id_45_9 bigint;
        v_m_id_45_10 bigint;
        v_m_id_45_11 bigint;
        v_m_id_45_12 bigint;
        v_m_id_45_13 bigint;
        v_m_id_45_14 bigint;
        v_m_id_45_15 bigint;
        v_m_id_45_16 bigint;
        v_m_id_45_17 bigint;
        v_m_id_45_18 bigint;
        v_m_id_45_19 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_45 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_45 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_45;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_45 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_45;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 1, 2026, 10, 99.60, 'Pendiente', 'Manual', '2026-10-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_45_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 2, 2026, 10, 7.00, 'Pendiente', 'Manual', '2026-10-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_45_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 1, 2025, 11, 94.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_45_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_45_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_45_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_45_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 6, 2025, 11, 113.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - MULTA 27-11-2025', v_user_uuid)
        RETURNING id INTO v_m_id_45_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 1, 2025, 12, 95.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_45_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_45_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 1, 2026, 1, 92.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_45_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_45_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_45_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_45_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_45_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_45_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_45_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 1, 2026, 2, 91.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_45_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_45_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_45_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_45, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_45_19;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_45,
            v_socio_45,
            NULL,
            271.90,
            'Efectivo',
            '32338',
            'Pago histórico recibo N° 32338',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_45_0, 'monto_aplicado', 99.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_45_1, 'monto_aplicado', 7.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_45_2, 'monto_aplicado', 94.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_45_3, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_45_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_45_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_45,
            v_socio_45,
            NULL,
            214.60,
            'Efectivo',
            '32913',
            'Pago histórico recibo N° 32913',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_45_6, 'monto_aplicado', 113.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_45_16, 'monto_aplicado', 91.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_45_17, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_45,
            v_socio_45,
            NULL,
            101.60,
            'Efectivo',
            '32367',
            'Pago histórico recibo N° 32367',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_45_7, 'monto_aplicado', 95.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_45_8, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_45,
            v_socio_45,
            NULL,
            172.90,
            'Efectivo',
            '32677',
            'Pago histórico recibo N° 32677',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_45_9, 'monto_aplicado', 92.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_45_10, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_45_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_45_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_45_13, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-16 12:00:00-05', created_at = '2026-03-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-16 12:00:00-05', created_at = '2026-03-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_45,
            v_socio_45,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_45_14, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_45_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_45,
            v_socio_45,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_45_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_45_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CORDOVA PEREZ MARCO ANTONIO (Puesto: 94, ID: 46)
    -- =========================================================================
    DECLARE
        v_socio_46 bigint := 46;
        v_puesto_46 bigint := 189;
        v_m_id_46_0 bigint;
        v_m_id_46_1 bigint;
        v_m_id_46_2 bigint;
        v_m_id_46_3 bigint;
        v_m_id_46_4 bigint;
        v_m_id_46_5 bigint;
        v_m_id_46_6 bigint;
        v_m_id_46_7 bigint;
        v_m_id_46_8 bigint;
        v_m_id_46_9 bigint;
        v_m_id_46_10 bigint;
        v_m_id_46_11 bigint;
        v_m_id_46_12 bigint;
        v_m_id_46_13 bigint;
        v_m_id_46_14 bigint;
        v_m_id_46_15 bigint;
        v_m_id_46_16 bigint;
        v_m_id_46_17 bigint;
        v_m_id_46_18 bigint;
        v_m_id_46_19 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_46 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_46 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_46;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_46 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_46;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 1, 2025, 11, 35.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_46_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 2, 2025, 11, 140.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_46_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_46_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_46_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 1, 2025, 12, 35.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_46_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 2, 2025, 12, 176.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_46_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_46_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_46_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 1, 2026, 1, 40.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_46_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 2, 2026, 1, 174.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_46_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_46_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_46_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_46_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_46_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 1, 2026, 2, 50.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_46_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 2, 2026, 2, 198.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_46_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 1, 2026, 3, 47.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_46_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 2, 2026, 3, 192.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_46_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_46_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_46, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_46_19;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_46,
            v_socio_46,
            NULL,
            517.40,
            'Efectivo',
            '32389',
            'Pago histórico recibo N° 32389',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_46_0, 'monto_aplicado', 35.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_46_1, 'monto_aplicado', 140.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_46_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_46_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_46_4, 'monto_aplicado', 35.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_46_5, 'monto_aplicado', 176.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_46_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_46_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_46,
            v_socio_46,
            NULL,
            341.20,
            'Efectivo',
            '32628',
            'Pago histórico recibo N° 32628',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_46_8, 'monto_aplicado', 40.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_46_9, 'monto_aplicado', 174.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_46_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_46_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_46_12, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_46_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-05 12:00:00-05', created_at = '2026-03-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-05 12:00:00-05', created_at = '2026-03-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_46,
            v_socio_46,
            NULL,
            249.10,
            'Efectivo',
            '32799',
            'Pago histórico recibo N° 32799',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_46_14, 'monto_aplicado', 50.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_46_15, 'monto_aplicado', 198.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_46,
            v_socio_46,
            NULL,
            304.50,
            'Efectivo',
            '32977',
            'Pago histórico recibo N° 32977',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_46_16, 'monto_aplicado', 47.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_46_17, 'monto_aplicado', 192.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_46_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_46_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    RAISE NOTICE '==================================================';
    RAISE NOTICE 'PROCESO DE MIGRACIÓN 2026 COMPLETADO CON ÉXITO';
    RAISE NOTICE '  Deudas individuales creadas: %', v_cant_deudas;
    RAISE NOTICE '  Pagos agrupados procesados:  %', v_cant_pagos;
    RAISE NOTICE '==================================================';
END $$;