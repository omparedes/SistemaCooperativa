-- =============================================================================
-- Migración 00050 — Carga de Pagos Detallados 2026 (Lista Socios C-Q)
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
    -- SOCIO: CORNEJO DONATO DE CORDOVA ESTELA PILAR (Puesto: 128, ID: 47)
    -- =========================================================================
    DECLARE
        v_socio_47 bigint := 47;
        v_puesto_47 bigint := 223;
        v_m_id_47_0 bigint;
        v_m_id_47_1 bigint;
        v_m_id_47_2 bigint;
        v_m_id_47_3 bigint;
        v_m_id_47_4 bigint;
        v_m_id_47_5 bigint;
        v_m_id_47_6 bigint;
        v_m_id_47_7 bigint;
        v_m_id_47_8 bigint;
        v_m_id_47_9 bigint;
        v_m_id_47_10 bigint;
        v_m_id_47_11 bigint;
        v_m_id_47_12 bigint;
        v_m_id_47_13 bigint;
        v_m_id_47_14 bigint;
        v_m_id_47_15 bigint;
        v_m_id_47_16 bigint;
        v_m_id_47_17 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_47 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_47 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_47;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_47 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_47;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 1, 2025, 11, 19.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_47_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_47_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 3, 2025, 11, 50.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_47_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_47_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 1, 2025, 12, 22.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_47_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_47_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 3, 2025, 12, 25.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_47_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_47_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_47_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 1, 2026, 1, 20.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_47_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_47_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_47_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_47_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 1, 2026, 2, 16.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_47_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_47_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_47_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 3, 2026, 3, 20.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_47_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_47, 3, 2026, 4, 35.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_47_17;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_47,
            v_socio_47,
            NULL,
            189.60,
            'Efectivo',
            '32718',
            'Pago histórico recibo N° 32718',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_47_0, 'monto_aplicado', 19.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_47_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_47_2, 'monto_aplicado', 50.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_47_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_47_4, 'monto_aplicado', 22.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_47_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_47_6, 'monto_aplicado', 25.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_47_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_47_9, 'monto_aplicado', 20.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_47_10, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_47_8, 'monto_aplicado', 20.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_47_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_47,
            v_socio_47,
            NULL,
            40.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_47_8, 'monto_aplicado', 40.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_47,
            v_socio_47,
            NULL,
            30.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_47_12, 'monto_aplicado', 30.00, 'cubierto_completo', false)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_47,
            v_socio_47,
            NULL,
            57.60,
            'Efectivo',
            '32719',
            'Pago histórico recibo N° 32719',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_47_13, 'monto_aplicado', 16.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_47_14, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_47_12, 'monto_aplicado', 26.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_47_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_47,
            v_socio_47,
            NULL,
            20.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_47_16, 'monto_aplicado', 20.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_47,
            v_socio_47,
            NULL,
            35.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_47_17, 'monto_aplicado', 35.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CRUZ JARAMILLO LUIS (Puesto: 167, ID: 48)
    -- =========================================================================
    DECLARE
        v_socio_48 bigint := 48;
        v_puesto_48 bigint := 262;
        v_m_id_48_0 bigint;
        v_m_id_48_1 bigint;
        v_m_id_48_2 bigint;
        v_m_id_48_3 bigint;
        v_m_id_48_4 bigint;
        v_m_id_48_5 bigint;
        v_m_id_48_6 bigint;
        v_m_id_48_7 bigint;
        v_m_id_48_8 bigint;
        v_m_id_48_9 bigint;
        v_m_id_48_10 bigint;
        v_m_id_48_11 bigint;
        v_m_id_48_12 bigint;
        v_m_id_48_13 bigint;
        v_m_id_48_14 bigint;
        v_m_id_48_15 bigint;
        v_m_id_48_16 bigint;
        v_m_id_48_17 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_48 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_48 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_48;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_48 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_48;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 1, 2025, 12, 25.80, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_48_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_48_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 4, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_48_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 1, 2026, 1, 15.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_48_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 2, 2026, 1, 21.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_48_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 19, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_48_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_48_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_48_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 1, 2026, 2, 21.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_48_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_48_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_48_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_48_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 1, 2026, 3, 23.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_48_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_48_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_48_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_48_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 1, 2026, 4, 22.70, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_48_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_48, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_48_17;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_48,
            v_socio_48,
            NULL,
            31.80,
            'Efectivo',
            '32359',
            'Pago histórico recibo N° 32359',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_48_0, 'monto_aplicado', 25.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_48_1, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-19 12:00:00-05', created_at = '2026-01-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-19 12:00:00-05', created_at = '2026-01-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_48,
            v_socio_48,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_48_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_48_3, 'monto_aplicado', 5.00, 'cubierto_completo', false)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_48,
            v_socio_48,
            NULL,
            36.40,
            'Efectivo',
            '32542',
            'Pago histórico recibo N° 32542',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_48_4, 'monto_aplicado', 21.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_48_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_48_3, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-20 12:00:00-05', created_at = '2026-02-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-20 12:00:00-05', created_at = '2026-02-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_48,
            v_socio_48,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_48_6, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_48_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_48,
            v_socio_48,
            NULL,
            31.10,
            'Efectivo',
            '32715',
            'Pago histórico recibo N° 32715',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_48_8, 'monto_aplicado', 21.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_48_9, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_48,
            v_socio_48,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_48_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_48_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_48,
            v_socio_48,
            NULL,
            23.30,
            'Efectivo',
            '32962',
            'Pago histórico recibo N° 32962',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_48_12, 'monto_aplicado', 23.30, 'cubierto_completo', true)),
            0.00,
            '2026-04-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-24 12:00:00-05', created_at = '2026-04-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-24 12:00:00-05', created_at = '2026-04-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_48,
            v_socio_48,
            NULL,
            6.00,
            'Efectivo',
            '32960',
            'Pago histórico recibo N° 32960',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_48_13, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-24 12:00:00-05', created_at = '2026-04-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-24 12:00:00-05', created_at = '2026-04-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_48,
            v_socio_48,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_48_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_48_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_48,
            v_socio_48,
            NULL,
            28.70,
            'Efectivo',
            '33109',
            'Pago histórico recibo N° 33109',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_48_16, 'monto_aplicado', 22.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_48_17, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CUCHO DE LA CRUZ SAUL PEDRO (Puesto: 177, ID: 49)
    -- =========================================================================
    DECLARE
        v_socio_49 bigint := 49;
        v_puesto_49 bigint := 271;
        v_m_id_49_0 bigint;
        v_m_id_49_1 bigint;
        v_m_id_49_2 bigint;
        v_m_id_49_3 bigint;
        v_m_id_49_4 bigint;
        v_m_id_49_5 bigint;
        v_m_id_49_6 bigint;
        v_m_id_49_7 bigint;
        v_m_id_49_8 bigint;
        v_m_id_49_9 bigint;
        v_m_id_49_10 bigint;
        v_m_id_49_11 bigint;
        v_m_id_49_12 bigint;
        v_m_id_49_13 bigint;
        v_m_id_49_14 bigint;
        v_m_id_49_15 bigint;
        v_m_id_49_16 bigint;
        v_m_id_49_17 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_49 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_49 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_49;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_49 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_49;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 1, 2025, 11, 9.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_49_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_49_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 1, 2025, 12, 10.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_49_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_49_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_49_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_49_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 1, 2026, 1, 9.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_49_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_49_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_49_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_49_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_49_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_49_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 1, 2026, 2, 9.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_49_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_49_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_49_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_49_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_49_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_49, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_49_17;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_49,
            v_socio_49,
            NULL,
            105.00,
            'Efectivo',
            '32772',
            'Pago histórico recibo N° 32772',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_49_0, 'monto_aplicado', 9.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_49_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_49_2, 'monto_aplicado', 10.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_49_3, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_49_6, 'monto_aplicado', 9.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_49_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_49_8, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_49_9, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_49_12, 'monto_aplicado', 9.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_49_13, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_49,
            v_socio_49,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_49_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_49_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_49,
            v_socio_49,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_49_10, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_49_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_49,
            v_socio_49,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_49_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_49_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_49,
            v_socio_49,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_49_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_49_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CUEVAS MAYO ENRIQUE (Puesto: 71, ID: 50)
    -- =========================================================================
    DECLARE
        v_socio_50 bigint := 50;
        v_puesto_50 bigint := 168;
        v_m_id_50_0 bigint;
        v_m_id_50_1 bigint;
        v_m_id_50_2 bigint;
        v_m_id_50_3 bigint;
        v_m_id_50_4 bigint;
        v_m_id_50_5 bigint;
        v_m_id_50_6 bigint;
        v_m_id_50_7 bigint;
        v_m_id_50_8 bigint;
        v_m_id_50_9 bigint;
        v_m_id_50_10 bigint;
        v_m_id_50_11 bigint;
        v_m_id_50_12 bigint;
        v_m_id_50_13 bigint;
        v_m_id_50_14 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_50 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_50 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_50;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_50 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_50;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_50, 1, 2025, 12, 39.40, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_50_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_50, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_50_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_50, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_50_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_50, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_50_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_50, 1, 2026, 1, 38.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_50_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_50, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_50_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_50, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_50_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_50, 1, 2026, 2, 37.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_50_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_50, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_50_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_50, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_50_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_50, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_50_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_50, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_50_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_50, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_50_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_50, 1, 2026, 3, 39.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_50_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_50, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_50_14;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_50,
            v_socio_50,
            NULL,
            110.40,
            'Efectivo',
            '32436',
            'Pago histórico recibo N° 32436',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_50_0, 'monto_aplicado', 39.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_50_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_50_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_50_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-29 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-29 12:00:00-05', created_at = '2026-01-29 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-29 12:00:00-05', created_at = '2026-01-29 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_50,
            v_socio_50,
            NULL,
            180.30,
            'Efectivo',
            '32904',
            'Pago histórico recibo N° 32904',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_50_4, 'monto_aplicado', 38.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_50_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_50_6, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_50_7, 'monto_aplicado', 37.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_50_8, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_50_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_50_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_50,
            v_socio_50,
            NULL,
            65.00,
            'Efectivo',
            '32933',
            'Pago histórico recibo N° 32933',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_50_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_50_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-09 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-09 12:00:00-05', created_at = '2026-04-09 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-09 12:00:00-05', created_at = '2026-04-09 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_50,
            v_socio_50,
            NULL,
            45.50,
            'Efectivo',
            '32975',
            'Pago histórico recibo N° 32975',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_50_13, 'monto_aplicado', 39.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_50_14, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-28 12:00:00-05', created_at = '2026-04-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CULE CARRASCO HAYDEE MONICA (Puesto: 171, ID: 51)
    -- =========================================================================
    DECLARE
        v_socio_51 bigint := 51;
        v_puesto_51 bigint := 266;
        v_m_id_51_0 bigint;
        v_m_id_51_1 bigint;
        v_m_id_51_2 bigint;
        v_m_id_51_3 bigint;
        v_m_id_51_4 bigint;
        v_m_id_51_5 bigint;
        v_m_id_51_6 bigint;
        v_m_id_51_7 bigint;
        v_m_id_51_8 bigint;
        v_m_id_51_9 bigint;
        v_m_id_51_10 bigint;
        v_m_id_51_11 bigint;
        v_m_id_51_12 bigint;
        v_m_id_51_13 bigint;
        v_m_id_51_14 bigint;
        v_m_id_51_15 bigint;
        v_m_id_51_16 bigint;
        v_m_id_51_17 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_51 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_51 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_51;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_51 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_51;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 1, 2025, 12, 12.30, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_51_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 2, 2025, 12, 42.10, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_51_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_51_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_51_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 1, 2026, 1, 22.80, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_51_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 2, 2026, 1, 52.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_51_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_51_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_51_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_51_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 1, 2026, 2, 23.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_51_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 2, 2026, 2, 53.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_51_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_51_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_51_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 1, 2026, 3, 21.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_51_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 2, 2026, 3, 75.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_51_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 1, 2026, 4, 103.70, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_51_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_51_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_51, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_51_17;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_51,
            v_socio_51,
            NULL,
            80.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_51_0, 'monto_aplicado', 12.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_51_1, 'monto_aplicado', 6.70, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_51_7, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_51_8, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_51,
            v_socio_51,
            NULL,
            197.60,
            'Efectivo',
            '32714',
            'Pago histórico recibo N° 32714',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_51_1, 'monto_aplicado', 35.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_51_4, 'monto_aplicado', 22.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_51_5, 'monto_aplicado', 52.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_51_6, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_51_9, 'monto_aplicado', 23.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_51_10, 'monto_aplicado', 53.60, 'cubierto_completo', true)),
            0.00,
            '2026-03-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_51,
            v_socio_51,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_51_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_51_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_51,
            v_socio_51,
            NULL,
            180.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_51_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_51_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_51_13, 'monto_aplicado', 21.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_51_14, 'monto_aplicado', 75.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_51_15, 'monto_aplicado', 18.70, 'cubierto_completo', false)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_51,
            v_socio_51,
            NULL,
            150.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_51_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_51_17, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_51_15, 'monto_aplicado', 85.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CUSI LAURA SONIA (Puesto: 154, ID: 52)
    -- =========================================================================
    DECLARE
        v_socio_52 bigint := 52;
        v_puesto_52 bigint := 249;
        v_m_id_52_0 bigint;
        v_m_id_52_1 bigint;
        v_m_id_52_2 bigint;
        v_m_id_52_3 bigint;
        v_m_id_52_4 bigint;
        v_m_id_52_5 bigint;
        v_m_id_52_6 bigint;
        v_m_id_52_7 bigint;
        v_m_id_52_8 bigint;
        v_m_id_52_9 bigint;
        v_m_id_52_10 bigint;
        v_m_id_52_11 bigint;
        v_m_id_52_12 bigint;
        v_m_id_52_13 bigint;
        v_m_id_52_14 bigint;
        v_m_id_52_15 bigint;
        v_m_id_52_16 bigint;
        v_m_id_52_17 bigint;
        v_m_id_52_18 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_52 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_52 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_52;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_52 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_52;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 1, 2025, 11, 27.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_52_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_52_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 1, 2025, 12, 17.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_52_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_52_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 3, 2025, 12, 22.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_52_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_52_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_52_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_52_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 1, 2026, 1, 14.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_52_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_52_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_52_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_52_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_52_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 1, 2026, 2, 12.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_52_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_52_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_52_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_52_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_52_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_52, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_52_18;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_52,
            v_socio_52,
            NULL,
            84.60,
            'Efectivo',
            '32479',
            'Pago histórico recibo N° 32479',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_52_0, 'monto_aplicado', 27.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_52_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_52_2, 'monto_aplicado', 17.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_52_3, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_52_4, 'monto_aplicado', 22.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_52_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-06 12:00:00-05', created_at = '2026-02-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-06 12:00:00-05', created_at = '2026-02-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_52,
            v_socio_52,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_52_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_52_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_52,
            v_socio_52,
            NULL,
            52.00,
            'Efectivo',
            '32898',
            'Pago histórico recibo N° 32898',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_52_8, 'monto_aplicado', 14.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_52_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_52_10, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_52_13, 'monto_aplicado', 12.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_52_14, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_52,
            v_socio_52,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_52_11, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_52_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_52,
            v_socio_52,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_52_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_52_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_52,
            v_socio_52,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_52_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_52_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: CUYA SANCHEZ ALBERTO (Puesto: 16, ID: 53)
    -- =========================================================================
    DECLARE
        v_socio_53 bigint := 53;
        v_puesto_53 bigint := 68;
        v_m_id_53_0 bigint;
        v_m_id_53_1 bigint;
        v_m_id_53_2 bigint;
        v_m_id_53_3 bigint;
        v_m_id_53_4 bigint;
        v_m_id_53_5 bigint;
        v_m_id_53_6 bigint;
        v_m_id_53_7 bigint;
        v_m_id_53_8 bigint;
        v_m_id_53_9 bigint;
        v_m_id_53_10 bigint;
        v_m_id_53_11 bigint;
        v_m_id_53_12 bigint;
        v_m_id_53_13 bigint;
        v_m_id_53_14 bigint;
        v_m_id_53_15 bigint;
        v_m_id_53_16 bigint;
        v_m_id_53_17 bigint;
        v_m_id_53_18 bigint;
        v_m_id_53_19 bigint;
        v_m_id_53_20 bigint;
        v_m_id_53_21 bigint;
        v_m_id_53_22 bigint;
        v_m_id_53_23 bigint;
        v_m_id_53_24 bigint;
        v_m_id_53_25 bigint;
        v_m_id_53_26 bigint;
        v_m_id_53_27 bigint;
        v_m_id_53_28 bigint;
        v_m_id_53_29 bigint;
        v_m_id_53_30 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_53 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_53 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_53;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_53 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_53;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 18, 2026, 7, 56.50, 'Pendiente', 'Manual', '2026-07-01', 'Migración de pagos 2026 - MULTA 17/07/25', v_user_uuid)
        RETURNING id INTO v_m_id_53_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 3, 2026, 8, 60.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_53_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 4, 2026, 8, 5.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_53_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 3, 2026, 9, 60.00, 'Pendiente', 'Manual', '2026-09-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_53_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 4, 2026, 9, 5.00, 'Pendiente', 'Manual', '2026-09-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_53_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 3, 2026, 10, 60.00, 'Pendiente', 'Manual', '2026-10-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_53_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 4, 2026, 10, 5.00, 'Pendiente', 'Manual', '2026-10-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_53_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 1, 2025, 11, 40.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_53_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_53_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_53_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_53_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 18, 2025, 11, 56.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - MULTA 27/11/25', v_user_uuid)
        RETURNING id INTO v_m_id_53_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 1, 2025, 12, 41.10, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_53_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_53_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_53_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_53_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 1, 2026, 1, 39.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_53_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_53_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_53_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_53_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 1, 2026, 2, 39.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_53_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_53_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_53_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_53_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 1, 2026, 3, 41.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_53_24;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_53_25;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_53_26;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_53_27;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 18, 2026, 3, 56.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - MULTA 26/03/26', v_user_uuid)
        RETURNING id INTO v_m_id_53_28;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_53_29;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_53, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_53_30;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_53,
            v_socio_53,
            NULL,
            169.50,
            'Efectivo',
            '33102',
            'Pago histórico recibo N° 33102',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_53_0, 'monto_aplicado', 56.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_11, 'monto_aplicado', 56.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_28, 'monto_aplicado', 56.50, 'cubierto_completo', true)),
            0.00,
            '2026-05-22 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-22 12:00:00-05', created_at = '2026-05-22 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-22 12:00:00-05', created_at = '2026-05-22 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_53,
            v_socio_53,
            NULL,
            65.00,
            'Efectivo',
            '32297',
            'Pago histórico recibo N° 32297',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_53_1, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_2, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_53,
            v_socio_53,
            NULL,
            65.00,
            'Efectivo',
            '32454',
            'Pago histórico recibo N° 32454',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_53_3, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_4, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_53,
            v_socio_53,
            NULL,
            65.00,
            'Efectivo',
            '32022',
            'Pago histórico recibo N° 32022',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_53_5, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_6, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_53,
            v_socio_53,
            NULL,
            46.50,
            'Efectivo',
            '32421',
            'Pago histórico recibo N° 32421',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_53_7, 'monto_aplicado', 40.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_8, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_53,
            v_socio_53,
            NULL,
            305.30,
            'Efectivo',
            '33074',
            'Pago histórico recibo N° 33074',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_53_9, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_10, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_15, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_19, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_20, 'monto_aplicado', 39.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_21, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_22, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_23, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-14 12:00:00-05', created_at = '2026-05-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-14 12:00:00-05', created_at = '2026-05-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_53,
            v_socio_53,
            NULL,
            47.10,
            'Efectivo',
            '32532',
            'Pago histórico recibo N° 32532',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_53_12, 'monto_aplicado', 41.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_13, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_53,
            v_socio_53,
            NULL,
            44.40,
            'Efectivo',
            '32951',
            'Pago histórico recibo N° 32951',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_53_16, 'monto_aplicado', 39.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-22 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-22 12:00:00-05', created_at = '2026-04-22 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-22 12:00:00-05', created_at = '2026-04-22 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_53,
            v_socio_53,
            NULL,
            177.10,
            'Efectivo',
            '33075',
            'Pago histórico recibo N° 33075',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_53_24, 'monto_aplicado', 41.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_25, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_26, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_27, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_29, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_53_30, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-14 12:00:00-05', created_at = '2026-05-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-14 12:00:00-05', created_at = '2026-05-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: DAVILA CAHUANA DE PAZ MARISOL (Puesto: 57, ID: 54)
    -- =========================================================================
    DECLARE
        v_socio_54 bigint := 54;
        v_puesto_54 bigint := 148;
        v_m_id_54_0 bigint;
        v_m_id_54_1 bigint;
        v_m_id_54_2 bigint;
        v_m_id_54_3 bigint;
        v_m_id_54_4 bigint;
        v_m_id_54_5 bigint;
        v_m_id_54_6 bigint;
        v_m_id_54_7 bigint;
        v_m_id_54_8 bigint;
        v_m_id_54_9 bigint;
        v_m_id_54_10 bigint;
        v_m_id_54_11 bigint;
        v_m_id_54_12 bigint;
        v_m_id_54_13 bigint;
        v_m_id_54_14 bigint;
        v_m_id_54_15 bigint;
        v_m_id_54_16 bigint;
        v_m_id_54_17 bigint;
        v_m_id_54_18 bigint;
        v_m_id_54_19 bigint;
        v_m_id_54_20 bigint;
        v_m_id_54_21 bigint;
        v_m_id_54_22 bigint;
        v_m_id_54_23 bigint;
        v_m_id_54_24 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_54 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_54 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_54;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_54 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_54;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_54_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_54_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 18, 2025, 11, 200.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - DEPOSITO N° 7', v_user_uuid)
        RETURNING id INTO v_m_id_54_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 1, 2025, 11, 50.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_54_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_54_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_54_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_54_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 18, 2025, 12, 200.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - DEPOSITO N° 7', v_user_uuid)
        RETURNING id INTO v_m_id_54_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 1, 2025, 12, 51.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_54_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_54_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 18, 2026, 1, 200.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - DEPOSITO N° 7', v_user_uuid)
        RETURNING id INTO v_m_id_54_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 1, 2026, 1, 49.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_54_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_54_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_54_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_54_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - p.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_54_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 18, 2026, 2, 200.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO N° 7', v_user_uuid)
        RETURNING id INTO v_m_id_54_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_54_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_54_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 1, 2026, 2, 49.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_54_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_54_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 18, 2026, 3, 200.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - DEPOSITO N° 7', v_user_uuid)
        RETURNING id INTO v_m_id_54_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 1, 2026, 3, 51.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_54_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_54_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_54, 18, 2026, 4, 200.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - DEPOSITO N° 7', v_user_uuid)
        RETURNING id INTO v_m_id_54_24;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_54,
            v_socio_54,
            NULL,
            130.00,
            'Efectivo',
            '32340',
            'Pago histórico recibo N° 32340',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_54_0, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_54_1, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_54_5, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_54_6, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-15 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_54,
            v_socio_54,
            NULL,
            200.00,
            'Efectivo',
            '32373',
            'Pago histórico recibo N° 32373',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_54_2, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_54,
            v_socio_54,
            NULL,
            113.70,
            'Efectivo',
            '32448',
            'Pago histórico recibo N° 32448',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_54_3, 'monto_aplicado', 50.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_54_4, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_54_8, 'monto_aplicado', 51.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_54_9, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-02 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-02 12:00:00-05', created_at = '2026-02-02 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-02 12:00:00-05', created_at = '2026-02-02 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_54,
            v_socio_54,
            NULL,
            200.00,
            'Efectivo',
            '32413',
            'Pago histórico recibo N° 32413',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_54_7, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_54,
            v_socio_54,
            NULL,
            200.00,
            'Efectivo',
            '32611',
            'Pago histórico recibo N° 32611',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_54_10, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_54,
            v_socio_54,
            NULL,
            150.00,
            'Efectivo',
            '32644',
            'Pago histórico recibo N° 32644',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_54_11, 'monto_aplicado', 49.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_54_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_54_16, 'monto_aplicado', 95.30, 'cubierto_completo', false)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_54,
            v_socio_54,
            NULL,
            136.00,
            'Efectivo',
            '32813',
            'Pago histórico recibo N° 32813',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_54_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_54_14, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_54_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_54_17, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_54_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_54,
            v_socio_54,
            NULL,
            104.70,
            'Efectivo',
            '32645',
            'Pago histórico recibo N° 32645',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_54_16, 'monto_aplicado', 104.70, 'cubierto_completo', true)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_54,
            v_socio_54,
            NULL,
            59.00,
            'Efectivo',
            '32860',
            'Pago histórico recibo N° 32860',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_54_19, 'monto_aplicado', 49.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_54_20, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_54,
            v_socio_54,
            NULL,
            200.00,
            'Efectivo',
            '33027',
            'Pago histórico recibo N° 33027',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_54_21, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_54,
            v_socio_54,
            NULL,
            57.10,
            'Efectivo',
            '33145',
            'Pago histórico recibo N° 33145',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_54_22, 'monto_aplicado', 51.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_54_23, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-28 12:00:00-05', created_at = '2026-05-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-28 12:00:00-05', created_at = '2026-05-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_54,
            v_socio_54,
            NULL,
            200.00,
            'Efectivo',
            '33069',
            'Pago histórico recibo N° 33069',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_54_24, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: DE LA CRUZ ESTEBAN JOSE LUIS (Puesto: 125, ID: 55)
    -- =========================================================================
    DECLARE
        v_socio_55 bigint := 55;
        v_puesto_55 bigint := 220;
        v_m_id_55_0 bigint;
        v_m_id_55_1 bigint;
        v_m_id_55_2 bigint;
        v_m_id_55_3 bigint;
        v_m_id_55_4 bigint;
        v_m_id_55_5 bigint;
        v_m_id_55_6 bigint;
        v_m_id_55_7 bigint;
        v_m_id_55_8 bigint;
        v_m_id_55_9 bigint;
        v_m_id_55_10 bigint;
        v_m_id_55_11 bigint;
        v_m_id_55_12 bigint;
        v_m_id_55_13 bigint;
        v_m_id_55_14 bigint;
        v_m_id_55_15 bigint;
        v_m_id_55_16 bigint;
        v_m_id_55_17 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_55 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_55 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_55;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_55 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_55;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 1, 2025, 12, 43.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_55_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 2, 2025, 12, 16.10, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_55_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_55_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_55_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_55_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 1, 2026, 1, 72.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_55_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 2, 2026, 1, 26.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_55_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_55_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_55_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_55_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 1, 2026, 2, 77.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_55_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 2, 2026, 2, 26.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_55_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_55_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_55_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 1, 2026, 3, 74.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_55_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 2, 2026, 3, 28.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_55_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_55_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_55, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_55_17;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_55,
            v_socio_55,
            NULL,
            59.80,
            'Efectivo',
            '32433',
            'Pago histórico recibo N° 32433',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_55_0, 'monto_aplicado', 43.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_55_1, 'monto_aplicado', 16.10, 'cubierto_completo', true)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_55,
            v_socio_55,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_55_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_55_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_55,
            v_socio_55,
            NULL,
            10.00,
            'Efectivo',
            '32561',
            'Pago histórico recibo N° 32561',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_55_4, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-24 12:00:00-05', created_at = '2026-02-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-24 12:00:00-05', created_at = '2026-02-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_55,
            v_socio_55,
            NULL,
            98.50,
            'Efectivo',
            '32650',
            'Pago histórico recibo N° 32650',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_55_5, 'monto_aplicado', 72.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_55_6, 'monto_aplicado', 26.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_55,
            v_socio_55,
            NULL,
            131.90,
            'Efectivo',
            '32751',
            'Pago histórico recibo N° 32751',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_55_7, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_55_10, 'monto_aplicado', 77.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_55_11, 'monto_aplicado', 26.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_55,
            v_socio_55,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_55_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_55_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_55,
            v_socio_55,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_55_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_55_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_55,
            v_socio_55,
            NULL,
            102.40,
            'Efectivo',
            '32964',
            'Pago histórico recibo N° 32964',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_55_14, 'monto_aplicado', 74.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_55_15, 'monto_aplicado', 28.40, 'cubierto_completo', true)),
            0.00,
            '2026-04-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-27 12:00:00-05', created_at = '2026-04-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-27 12:00:00-05', created_at = '2026-04-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_55,
            v_socio_55,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_55_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_55_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ESPEJO URBANO ROSA FLORENCIA (Puesto: 35, ID: 56)
    -- =========================================================================
    DECLARE
        v_socio_56 bigint := 56;
        v_puesto_56 bigint := 106;
        v_m_id_56_0 bigint;
        v_m_id_56_1 bigint;
        v_m_id_56_2 bigint;
        v_m_id_56_3 bigint;
        v_m_id_56_4 bigint;
        v_m_id_56_5 bigint;
        v_m_id_56_6 bigint;
        v_m_id_56_7 bigint;
        v_m_id_56_8 bigint;
        v_m_id_56_9 bigint;
        v_m_id_56_10 bigint;
        v_m_id_56_11 bigint;
        v_m_id_56_12 bigint;
        v_m_id_56_13 bigint;
        v_m_id_56_14 bigint;
        v_m_id_56_15 bigint;
        v_m_id_56_16 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_56 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_56 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_56;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_56 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_56;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_56, 1, 2025, 12, 102.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_56_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_56, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_56_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_56, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_56_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_56, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_56_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_56, 1, 2026, 1, 99.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_56_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_56, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_56_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_56, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_56_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_56, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_56_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_56, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_56_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_56, 1, 2026, 2, 98.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_56_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_56, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_56_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_56, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_56_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_56, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_56_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_56, 1, 2026, 3, 101.80, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_56_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_56, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_56_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_56, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_56_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_56, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_56_16;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_56,
            v_socio_56,
            NULL,
            371.60,
            'Efectivo',
            '32545',
            'Pago histórico recibo N° 32545',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_56_0, 'monto_aplicado', 102.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_56_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_56_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_56_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_56_4, 'monto_aplicado', 99.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_56_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_56_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_56_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_56_8, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-02-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-21 12:00:00-05', created_at = '2026-02-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-21 12:00:00-05', created_at = '2026-02-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_56,
            v_socio_56,
            NULL,
            169.30,
            'Efectivo',
            '32725',
            'Pago histórico recibo N° 32725',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_56_9, 'monto_aplicado', 98.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_56_10, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_56_11, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_56_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_56,
            v_socio_56,
            NULL,
            172.80,
            'Efectivo',
            '32962',
            'Pago histórico recibo N° 32962',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_56_13, 'monto_aplicado', 101.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_56_14, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_56_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_56_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-25 12:00:00-05', created_at = '2026-04-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-25 12:00:00-05', created_at = '2026-04-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ESTELA SUAREZ ELVIA (Puesto: 95, ID: 57)
    -- =========================================================================
    DECLARE
        v_socio_57 bigint := 57;
        v_puesto_57 bigint := 190;
        v_m_id_57_0 bigint;
        v_m_id_57_1 bigint;
        v_m_id_57_2 bigint;
        v_m_id_57_3 bigint;
        v_m_id_57_4 bigint;
        v_m_id_57_5 bigint;
        v_m_id_57_6 bigint;
        v_m_id_57_7 bigint;
        v_m_id_57_8 bigint;
        v_m_id_57_9 bigint;
        v_m_id_57_10 bigint;
        v_m_id_57_11 bigint;
        v_m_id_57_12 bigint;
        v_m_id_57_13 bigint;
        v_m_id_57_14 bigint;
        v_m_id_57_15 bigint;
        v_m_id_57_16 bigint;
        v_m_id_57_17 bigint;
        v_m_id_57_18 bigint;
        v_m_id_57_19 bigint;
        v_m_id_57_20 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_57 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_57 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_57;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_57 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_57;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 1, 2025, 11, 236.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_57_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 2, 2025, 11, 45.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_57_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_57_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_57_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 1, 2025, 12, 263.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_57_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 2, 2025, 12, 43.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_57_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_57_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_57_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 1, 2026, 1, 255.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_57_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 2, 2026, 1, 50.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_57_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_57_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_57_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_57_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 1, 2026, 2, 246.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_57_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 2, 2026, 2, 57.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_57_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_57_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_57_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 1, 2026, 3, 232.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_57_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 2, 2026, 3, 70.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_57_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_57_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_57, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_57_20;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_57,
            v_socio_57,
            NULL,
            346.60,
            'Efectivo',
            '32317',
            'Pago histórico recibo N° 32317',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_57_0, 'monto_aplicado', 236.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_57_1, 'monto_aplicado', 45.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_57_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_57_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_57,
            v_socio_57,
            NULL,
            371.80,
            'Efectivo',
            '32476',
            'Pago histórico recibo N° 32476',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_57_4, 'monto_aplicado', 263.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_57_5, 'monto_aplicado', 43.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_57_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_57_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-06 12:00:00-05', created_at = '2026-02-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-06 12:00:00-05', created_at = '2026-02-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_57,
            v_socio_57,
            NULL,
            398.60,
            'Efectivo',
            '32641',
            'Pago histórico recibo N° 32641',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_57_8, 'monto_aplicado', 255.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_57_9, 'monto_aplicado', 50.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_57_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_57_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_57_12, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-10 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-10 12:00:00-05', created_at = '2026-03-10 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-10 12:00:00-05', created_at = '2026-03-10 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_57,
            v_socio_57,
            NULL,
            365.20,
            'Efectivo',
            '32759',
            'Pago histórico recibo N° 32759',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_57_13, 'monto_aplicado', 246.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_57_14, 'monto_aplicado', 57.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_57_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_57_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_57,
            v_socio_57,
            NULL,
            367.80,
            'Efectivo',
            '32958',
            'Pago histórico recibo N° 32958',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_57_17, 'monto_aplicado', 232.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_57_18, 'monto_aplicado', 70.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_57_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_57_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-23 12:00:00-05', created_at = '2026-04-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-23 12:00:00-05', created_at = '2026-04-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ESTRADA CHACON OSCAR ALFREDO (Puesto: 162, ID: 58)
    -- =========================================================================
    DECLARE
        v_socio_58 bigint := 58;
        v_puesto_58 bigint := 257;
        v_m_id_58_0 bigint;
        v_m_id_58_1 bigint;
        v_m_id_58_2 bigint;
        v_m_id_58_3 bigint;
        v_m_id_58_4 bigint;
        v_m_id_58_5 bigint;
        v_m_id_58_6 bigint;
        v_m_id_58_7 bigint;
        v_m_id_58_8 bigint;
        v_m_id_58_9 bigint;
        v_m_id_58_10 bigint;
        v_m_id_58_11 bigint;
        v_m_id_58_12 bigint;
        v_m_id_58_13 bigint;
        v_m_id_58_14 bigint;
        v_m_id_58_15 bigint;
        v_m_id_58_16 bigint;
        v_m_id_58_17 bigint;
        v_m_id_58_18 bigint;
        v_m_id_58_19 bigint;
        v_m_id_58_20 bigint;
        v_m_id_58_21 bigint;
        v_m_id_58_22 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_58 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_58 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_58;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_58 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_58;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 1, 2025, 11, 20.20, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_58_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 2, 2025, 11, 87.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_58_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 3, 2025, 11, 52.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_58_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_58_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 3, 2025, 12, 54.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_58_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_58_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 1, 2025, 12, 19.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_58_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 2, 2025, 12, 91.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_58_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_58_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_58_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_58_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_58_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 1, 2026, 1, 18.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_58_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 2, 2026, 1, 85.80, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_58_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_58_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 1, 2026, 2, 18.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_58_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 2, 2026, 2, 97.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_58_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_58_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 3, 2026, 3, 8.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_58_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 1, 2026, 3, 17.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_58_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 2, 2026, 3, 96.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_58_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 4, 2026, 3, 57.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_58_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_58, 3, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_58_22;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_58,
            v_socio_58,
            NULL,
            223.50,
            'Efectivo',
            '32308',
            'Pago histórico recibo N° 32308',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_58_0, 'monto_aplicado', 20.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_58_1, 'monto_aplicado', 87.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_58_2, 'monto_aplicado', 52.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_58_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_58_4, 'monto_aplicado', 54.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_58_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-12 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-12 12:00:00-05', created_at = '2026-01-12 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-12 12:00:00-05', created_at = '2026-01-12 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_58,
            v_socio_58,
            NULL,
            210.20,
            'Efectivo',
            '32484',
            'Pago histórico recibo N° 32484',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_58_6, 'monto_aplicado', 19.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_58_7, 'monto_aplicado', 91.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_58_8, 'monto_aplicado', 56.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_58_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_58_10, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_58_11, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-02-09 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-09 12:00:00-05', created_at = '2026-02-09 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-09 12:00:00-05', created_at = '2026-02-09 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_58,
            v_socio_58,
            NULL,
            4.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_58_8, 'monto_aplicado', 4.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_58,
            v_socio_58,
            NULL,
            272.90,
            'Efectivo',
            '32786',
            'Pago histórico recibo N° 32786',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_58_12, 'monto_aplicado', 18.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_58_13, 'monto_aplicado', 85.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_58_15, 'monto_aplicado', 18.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_58_16, 'monto_aplicado', 97.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_58_14, 'monto_aplicado', 48.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_58_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_58,
            v_socio_58,
            NULL,
            8.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_58_14, 'monto_aplicado', 8.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_58,
            v_socio_58,
            NULL,
            8.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_58_18, 'monto_aplicado', 8.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_58,
            v_socio_58,
            NULL,
            170.70,
            'Efectivo',
            '32999',
            'Pago histórico recibo N° 32999',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_58_19, 'monto_aplicado', 17.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_58_20, 'monto_aplicado', 96.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_58_21, 'monto_aplicado', 52.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_58_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-04 12:00:00-05', created_at = '2026-05-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-04 12:00:00-05', created_at = '2026-05-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_58,
            v_socio_58,
            NULL,
            6.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_58_22, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: FALCON CHIARA HECTOR MARCIAL (Puesto: 14, ID: 59)
    -- =========================================================================
    DECLARE
        v_socio_59 bigint := 59;
        v_puesto_59 bigint := 64;
        v_m_id_59_0 bigint;
        v_m_id_59_1 bigint;
        v_m_id_59_2 bigint;
        v_m_id_59_3 bigint;
        v_m_id_59_4 bigint;
        v_m_id_59_5 bigint;
        v_m_id_59_6 bigint;
        v_m_id_59_7 bigint;
        v_m_id_59_8 bigint;
        v_m_id_59_9 bigint;
        v_m_id_59_10 bigint;
        v_m_id_59_11 bigint;
        v_m_id_59_12 bigint;
        v_m_id_59_13 bigint;
        v_m_id_59_14 bigint;
        v_m_id_59_15 bigint;
        v_m_id_59_16 bigint;
        v_m_id_59_17 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_59 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_59 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_59;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_59 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_59;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 18, 2026, 8, 15.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - TALONARIO SANTA ROSA', v_user_uuid)
        RETURNING id INTO v_m_id_59_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 1, 2025, 11, 33.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_59_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_59_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 1, 2025, 12, 50.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_59_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_59_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_59_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_59_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_59_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_59_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_59_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_59_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_59_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_59_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_59_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', '2026-05-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_59_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', '2026-05-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_59_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 3, 2026, 6, 60.00, 'Pendiente', 'Manual', '2026-06-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_59_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_59, 4, 2026, 6, 5.00, 'Pendiente', 'Manual', '2026-06-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_59_17;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_59,
            v_socio_59,
            NULL,
            281.00,
            'Efectivo',
            '32938',
            'Pago histórico recibo N° 32938',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_59_0, 'monto_aplicado', 15.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_59_5, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_59_6, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_59_7, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_59_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_59_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_59_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_59_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_59_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_59_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-10 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-10 12:00:00-05', created_at = '2026-04-10 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-10 12:00:00-05', created_at = '2026-04-10 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_59,
            v_socio_59,
            NULL,
            39.30,
            'Efectivo',
            '32531',
            'Pago histórico recibo N° 32531',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_59_1, 'monto_aplicado', 33.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_59_2, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_59,
            v_socio_59,
            NULL,
            56.60,
            'Efectivo',
            '33024',
            'Pago histórico recibo N° 33024',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_59_3, 'monto_aplicado', 50.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_59_4, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_59,
            v_socio_59,
            NULL,
            130.00,
            'Efectivo',
            '32939',
            'Pago histórico recibo N° 32939',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_59_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_59_15, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_59_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_59_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-10 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-10 12:00:00-05', created_at = '2026-04-10 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-10 12:00:00-05', created_at = '2026-04-10 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: FLORES FLORES IRENE BERTILIA (Puesto: 152, ID: 60)
    -- =========================================================================
    DECLARE
        v_socio_60 bigint := 60;
        v_puesto_60 bigint := 247;
        v_m_id_60_0 bigint;
        v_m_id_60_1 bigint;
        v_m_id_60_2 bigint;
        v_m_id_60_3 bigint;
        v_m_id_60_4 bigint;
        v_m_id_60_5 bigint;
        v_m_id_60_6 bigint;
        v_m_id_60_7 bigint;
        v_m_id_60_8 bigint;
        v_m_id_60_9 bigint;
        v_m_id_60_10 bigint;
        v_m_id_60_11 bigint;
        v_m_id_60_12 bigint;
        v_m_id_60_13 bigint;
        v_m_id_60_14 bigint;
        v_m_id_60_15 bigint;
        v_m_id_60_16 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_60 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_60 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_60;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_60 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_60;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_60, 1, 2025, 12, 314.30, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_60_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_60, 2, 2025, 12, 103.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_60_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_60, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_60_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_60, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_60_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_60, 1, 2026, 1, 504.80, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_60_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_60, 2, 2026, 1, 97.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_60_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_60, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_60_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_60, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_60_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_60, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_60_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_60, 1, 2026, 2, 549.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_60_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_60, 2, 2026, 2, 115.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_60_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_60, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_60_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_60, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_60_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_60, 1, 2026, 3, 552.80, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_60_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_60, 2, 2026, 3, 118.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_60_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_60, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_60_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_60, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_60_16;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_60,
            v_socio_60,
            NULL,
            483.20,
            'Efectivo',
            '32349',
            'Pago histórico recibo N° 32349',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_60_0, 'monto_aplicado', 314.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_60_1, 'monto_aplicado', 103.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_60_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_60_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-15 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_60,
            v_socio_60,
            NULL,
            677.10,
            'Efectivo',
            '32554',
            'Pago histórico recibo N° 32554',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_60_4, 'monto_aplicado', 504.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_60_5, 'monto_aplicado', 97.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_60_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_60_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_60_8, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-23 12:00:00-05', created_at = '2026-02-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_60,
            v_socio_60,
            NULL,
            725.90,
            'Efectivo',
            '32843',
            'Pago histórico recibo N° 32843',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_60_9, 'monto_aplicado', 549.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_60_10, 'monto_aplicado', 115.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_60_11, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_60_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_60,
            v_socio_60,
            NULL,
            736.20,
            'Efectivo',
            '32949',
            'Pago histórico recibo N° 32949',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_60_13, 'monto_aplicado', 552.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_60_14, 'monto_aplicado', 118.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_60_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_60_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-20 12:00:00-05', created_at = '2026-04-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-20 12:00:00-05', created_at = '2026-04-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: FLORES FLORES UMBELINA DORA (Puesto: 163, ID: 61)
    -- =========================================================================
    DECLARE
        v_socio_61 bigint := 61;
        v_puesto_61 bigint := 258;
        v_m_id_61_0 bigint;
        v_m_id_61_1 bigint;
        v_m_id_61_2 bigint;
        v_m_id_61_3 bigint;
        v_m_id_61_4 bigint;
        v_m_id_61_5 bigint;
        v_m_id_61_6 bigint;
        v_m_id_61_7 bigint;
        v_m_id_61_8 bigint;
        v_m_id_61_9 bigint;
        v_m_id_61_10 bigint;
        v_m_id_61_11 bigint;
        v_m_id_61_12 bigint;
        v_m_id_61_13 bigint;
        v_m_id_61_14 bigint;
        v_m_id_61_15 bigint;
        v_m_id_61_16 bigint;
        v_m_id_61_17 bigint;
        v_m_id_61_18 bigint;
        v_m_id_61_19 bigint;
        v_m_id_61_20 bigint;
        v_m_id_61_21 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_61 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_61 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_61;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_61 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_61;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 1, 2025, 11, 169.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_61_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 2, 2025, 11, 92.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_61_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 3, 2025, 11, 52.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_61_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_61_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 3, 2025, 12, 54.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_61_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_61_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 1, 2025, 12, 234.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_61_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 2, 2025, 12, 61.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_61_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_61_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 1, 2026, 1, 253.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_61_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 2, 2026, 1, 98.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_61_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_61_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_61_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_61_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 1, 2026, 2, 258.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_61_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 2, 2026, 2, 92.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_61_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_61_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_61_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 1, 2026, 3, 250.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_61_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 2, 2026, 3, 90.80, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_61_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_61_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_61, 3, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_61_21;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_61,
            v_socio_61,
            NULL,
            377.50,
            'Efectivo',
            '32307',
            'Pago histórico recibo N° 32307',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_61_0, 'monto_aplicado', 169.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_61_1, 'monto_aplicado', 92.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_61_2, 'monto_aplicado', 52.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_61_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_61_4, 'monto_aplicado', 54.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_61_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-12 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-12 12:00:00-05', created_at = '2026-01-12 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-12 12:00:00-05', created_at = '2026-01-12 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_61,
            v_socio_61,
            NULL,
            296.30,
            'Efectivo',
            '32411',
            'Pago histórico recibo N° 32411',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_61_6, 'monto_aplicado', 234.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_61_7, 'monto_aplicado', 61.60, 'cubierto_completo', true)),
            0.00,
            '2026-01-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_61,
            v_socio_61,
            NULL,
            36.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_61_8, 'monto_aplicado', 4.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_61_9, 'monto_aplicado', 32.00, 'cubierto_completo', false)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_61,
            v_socio_61,
            NULL,
            404.50,
            'Efectivo',
            '32567',
            'Pago histórico recibo N° 32567',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_61_9, 'monto_aplicado', 221.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_61_10, 'monto_aplicado', 98.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_61_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_61_12, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-02-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-24 12:00:00-05', created_at = '2026-02-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-24 12:00:00-05', created_at = '2026-02-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_61,
            v_socio_61,
            NULL,
            5.00,
            'Efectivo',
            '23567',
            'Pago histórico recibo N° 23567',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_61_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-24 12:00:00-05', created_at = '2026-02-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-24 12:00:00-05', created_at = '2026-02-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_61,
            v_socio_61,
            NULL,
            40.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_61_13, 'monto_aplicado', 8.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_61_14, 'monto_aplicado', 32.00, 'cubierto_completo', false)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_61,
            v_socio_61,
            NULL,
            372.00,
            'Efectivo',
            '32785',
            'Pago histórico recibo N° 32785',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_61_14, 'monto_aplicado', 226.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_61_15, 'monto_aplicado', 92.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_61_13, 'monto_aplicado', 48.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_61_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_61,
            v_socio_61,
            NULL,
            24.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_61_17, 'monto_aplicado', 8.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_61_18, 'monto_aplicado', 16.00, 'cubierto_completo', false)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_61,
            v_socio_61,
            NULL,
            382.30,
            'Efectivo',
            '33000',
            'Pago histórico recibo N° 33000',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_61_18, 'monto_aplicado', 234.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_61_19, 'monto_aplicado', 90.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_61_17, 'monto_aplicado', 52.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_61_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-04 12:00:00-05', created_at = '2026-05-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-04 12:00:00-05', created_at = '2026-05-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_61,
            v_socio_61,
            NULL,
            6.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_61_21, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: FLORES YATO FRANCISCA DOLORES (Puesto: 24, ID: 62)
    -- =========================================================================
    DECLARE
        v_socio_62 bigint := 62;
        v_puesto_62 bigint := 84;
        v_m_id_62_0 bigint;
        v_m_id_62_1 bigint;
        v_m_id_62_2 bigint;
        v_m_id_62_3 bigint;
        v_m_id_62_4 bigint;
        v_m_id_62_5 bigint;
        v_m_id_62_6 bigint;
        v_m_id_62_7 bigint;
        v_m_id_62_8 bigint;
        v_m_id_62_9 bigint;
        v_m_id_62_10 bigint;
        v_m_id_62_11 bigint;
        v_m_id_62_12 bigint;
        v_m_id_62_13 bigint;
        v_m_id_62_14 bigint;
        v_m_id_62_15 bigint;
        v_m_id_62_16 bigint;
        v_m_id_62_17 bigint;
        v_m_id_62_18 bigint;
        v_m_id_62_19 bigint;
        v_m_id_62_20 bigint;
        v_m_id_62_21 bigint;
        v_m_id_62_22 bigint;
        v_m_id_62_23 bigint;
        v_m_id_62_24 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_62 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_62 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_62;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_62 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_62;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 1, 2025, 11, 87.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_62_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_62_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_62_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_62_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 1, 2025, 12, 88.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_62_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_62_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_62_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_62_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 1, 2026, 1, 86.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_62_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_62_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_62_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_62_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_62_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 1, 2026, 2, 85.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_62_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_62_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_62_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_62_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 1, 2026, 3, 88.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_62_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_62_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_62_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_62_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 1, 2026, 4, 55.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_62_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_62_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_62_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_62, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_62_24;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_62,
            v_socio_62,
            NULL,
            318.50,
            'Efectivo',
            '32345',
            'Pago histórico recibo N° 32345',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_62_0, 'monto_aplicado', 87.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_4, 'monto_aplicado', 88.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-15 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_62,
            v_socio_62,
            NULL,
            166.30,
            'Efectivo',
            '32620',
            'Pago histórico recibo N° 32620',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_62_8, 'monto_aplicado', 86.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_12, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_62,
            v_socio_62,
            NULL,
            156.10,
            'Efectivo',
            '32763',
            'Pago histórico recibo N° 32763',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_62_13, 'monto_aplicado', 85.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_14, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_62,
            v_socio_62,
            NULL,
            159.20,
            'Efectivo',
            '33044',
            'Pago histórico recibo N° 33044',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_62_17, 'monto_aplicado', 88.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_18, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_62,
            v_socio_62,
            NULL,
            126.00,
            'Efectivo',
            '33126',
            'Pago histórico recibo N° 33126',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_62_21, 'monto_aplicado', 55.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_22, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_23, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_62_24, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: GAVILAN MOSQUERA NORMA LUZ (Puesto: 107, ID: 63)
    -- =========================================================================
    DECLARE
        v_socio_63 bigint := 63;
        v_puesto_63 bigint := 202;
        v_m_id_63_0 bigint;
        v_m_id_63_1 bigint;
        v_m_id_63_2 bigint;
        v_m_id_63_3 bigint;
        v_m_id_63_4 bigint;
        v_m_id_63_5 bigint;
        v_m_id_63_6 bigint;
        v_m_id_63_7 bigint;
        v_m_id_63_8 bigint;
        v_m_id_63_9 bigint;
        v_m_id_63_10 bigint;
        v_m_id_63_11 bigint;
        v_m_id_63_12 bigint;
        v_m_id_63_13 bigint;
        v_m_id_63_14 bigint;
        v_m_id_63_15 bigint;
        v_m_id_63_16 bigint;
        v_m_id_63_17 bigint;
        v_m_id_63_18 bigint;
        v_m_id_63_19 bigint;
        v_m_id_63_20 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_63 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_63 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_63;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_63 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_63;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 1, 2025, 11, 28.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_63_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 2, 2025, 11, 80.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_63_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_63_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 18, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P', v_user_uuid)
        RETURNING id INTO v_m_id_63_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 1, 2025, 12, 23.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_63_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 2, 2025, 12, 81.30, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_63_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_63_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 18, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P', v_user_uuid)
        RETURNING id INTO v_m_id_63_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 1, 2026, 1, 25.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_63_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 2, 2026, 1, 108.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_63_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_63_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_63_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_63_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 1, 2026, 2, 14.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_63_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 2, 2026, 2, 40.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_63_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_63_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_63_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 1, 2026, 3, 23.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_63_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 2, 2026, 3, 25.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_63_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 1, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_63_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_63, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_63_20;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_63,
            v_socio_63,
            NULL,
            109.00,
            'Efectivo',
            '32325',
            'Pago histórico recibo N° 32325',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_63_0, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_63_1, 'monto_aplicado', 80.70, 'cubierto_completo', true)),
            0.00,
            '2026-01-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_63,
            v_socio_63,
            NULL,
            321.60,
            'Efectivo',
            '32918',
            'Pago histórico recibo N° 32918',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_63_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_63_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_63_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_63_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_63_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_63_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_63_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_63_13, 'monto_aplicado', 14.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_63_14, 'monto_aplicado', 40.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_63_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_63_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_63,
            v_socio_63,
            NULL,
            104.90,
            'Efectivo',
            '32350',
            'Pago histórico recibo N° 32350',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_63_4, 'monto_aplicado', 23.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_63_5, 'monto_aplicado', 81.30, 'cubierto_completo', true)),
            0.00,
            '2026-01-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-16 12:00:00-05', created_at = '2026-01-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_63,
            v_socio_63,
            NULL,
            134.10,
            'Efectivo',
            '32521',
            'Pago histórico recibo N° 32521',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_63_8, 'monto_aplicado', 25.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_63_9, 'monto_aplicado', 108.40, 'cubierto_completo', true)),
            0.00,
            '2026-02-17 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-17 12:00:00-05', created_at = '2026-02-17 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-17 12:00:00-05', created_at = '2026-02-17 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_63,
            v_socio_63,
            NULL,
            59.60,
            'Efectivo',
            '33144',
            'Pago histórico recibo N° 33144',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_63_17, 'monto_aplicado', 23.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_63_18, 'monto_aplicado', 25.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_63_19, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_63_20, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: GELDRES REVILLA MIGUEL ANGEL (Puesto: 109, ID: 64)
    -- =========================================================================
    DECLARE
        v_socio_64 bigint := 64;
        v_puesto_64 bigint := 204;
        v_m_id_64_0 bigint;
        v_m_id_64_1 bigint;
        v_m_id_64_2 bigint;
        v_m_id_64_3 bigint;
        v_m_id_64_4 bigint;
        v_m_id_64_5 bigint;
        v_m_id_64_6 bigint;
        v_m_id_64_7 bigint;
        v_m_id_64_8 bigint;
        v_m_id_64_9 bigint;
        v_m_id_64_10 bigint;
        v_m_id_64_11 bigint;
        v_m_id_64_12 bigint;
        v_m_id_64_13 bigint;
        v_m_id_64_14 bigint;
        v_m_id_64_15 bigint;
        v_m_id_64_16 bigint;
        v_m_id_64_17 bigint;
        v_m_id_64_18 bigint;
        v_m_id_64_19 bigint;
        v_m_id_64_20 bigint;
        v_m_id_64_21 bigint;
        v_m_id_64_22 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_64 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_64 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_64;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_64 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_64;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 1, 2025, 11, 24.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_64_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_64_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_64_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_64_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_64_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_64_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 1, 2025, 12, 31.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_64_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 2, 2025, 12, 15.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_64_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 1, 2026, 1, 35.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_64_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 2, 2026, 1, 9.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_64_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_64_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_64_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 1, 2026, 2, 39.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_64_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 2, 2026, 2, 21.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_64_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_64_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_64_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 18, 2026, 3, 10.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - RECONEXION DE LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_64_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 1, 2026, 3, 36.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_64_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 2, 2026, 3, 16.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_64_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_64_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_64_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_64_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_64, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_64_22;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_64,
            v_socio_64,
            NULL,
            160.90,
            'Efectivo',
            '32321',
            'Pago histórico recibo N° 32321',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_64_0, 'monto_aplicado', 24.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_64,
            v_socio_64,
            NULL,
            46.20,
            'Efectivo',
            '32427',
            'Pago histórico recibo N° 32427',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_64_6, 'monto_aplicado', 31.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_7, 'monto_aplicado', 15.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_64,
            v_socio_64,
            NULL,
            232.60,
            'Efectivo',
            '32729',
            'Pago histórico recibo N° 32729',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_64_8, 'monto_aplicado', 35.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_9, 'monto_aplicado', 9.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_12, 'monto_aplicado', 39.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_13, 'monto_aplicado', 21.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_14, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_64,
            v_socio_64,
            NULL,
            10.00,
            'Efectivo',
            '32699',
            'Pago histórico recibo N° 32699',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_64_16, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_64,
            v_socio_64,
            NULL,
            182.50,
            'Efectivo',
            '33064',
            'Pago histórico recibo N° 33064',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_64_17, 'monto_aplicado', 36.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_18, 'monto_aplicado', 16.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_20, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_21, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_64_22, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: GUTIERREZ CASTILLO JORGE JAIME (Puesto: 191, ID: 65)
    -- =========================================================================
    DECLARE
        v_socio_65 bigint := 65;
        v_puesto_65 bigint := 285;
        v_m_id_65_0 bigint;
        v_m_id_65_1 bigint;
        v_m_id_65_2 bigint;
        v_m_id_65_3 bigint;
        v_m_id_65_4 bigint;
        v_m_id_65_5 bigint;
        v_m_id_65_6 bigint;
        v_m_id_65_7 bigint;
        v_m_id_65_8 bigint;
        v_m_id_65_9 bigint;
        v_m_id_65_10 bigint;
        v_m_id_65_11 bigint;
        v_m_id_65_12 bigint;
        v_m_id_65_13 bigint;
        v_m_id_65_14 bigint;
        v_m_id_65_15 bigint;
        v_m_id_65_16 bigint;
        v_m_id_65_17 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_65 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_65 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_65;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_65 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_65;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 1, 2025, 11, 45.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_65_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 2, 2025, 11, 209.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_65_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 1, 2025, 12, 47.80, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_65_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 2, 2025, 12, 216.80, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_65_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_65_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_65_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 1, 2026, 1, 50.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_65_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 2, 2026, 1, 223.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_65_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_65_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_65_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 1, 2026, 2, 49.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_65_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 2, 2026, 2, 246.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_65_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_65_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 1, 2026, 3, 46.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_65_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 2, 2026, 3, 281.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_65_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_65_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_65_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_65, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_65_17;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_65,
            v_socio_65,
            NULL,
            255.80,
            'Efectivo',
            '32320',
            'Pago histórico recibo N° 32320',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_65_0, 'monto_aplicado', 45.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_65_1, 'monto_aplicado', 209.90, 'cubierto_completo', true)),
            0.00,
            '2026-01-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_65,
            v_socio_65,
            NULL,
            264.60,
            'Efectivo',
            '32416',
            'Pago histórico recibo N° 32416',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_65_2, 'monto_aplicado', 47.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_65_3, 'monto_aplicado', 216.80, 'cubierto_completo', true)),
            0.00,
            '2026-01-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-27 12:00:00-05', created_at = '2026-01-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_65,
            v_socio_65,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_65_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_65_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_65,
            v_socio_65,
            NULL,
            570.10,
            'Efectivo',
            '32711',
            'Pago histórico recibo N° 32711',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_65_6, 'monto_aplicado', 50.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_65_7, 'monto_aplicado', 223.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_65_10, 'monto_aplicado', 49.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_65_11, 'monto_aplicado', 246.10, 'cubierto_completo', true)),
            0.00,
            '2026-03-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_65,
            v_socio_65,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_65_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_65_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_65,
            v_socio_65,
            NULL,
            30.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_65_12, 'monto_aplicado', 30.00, 'cubierto_completo', false)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_65,
            v_socio_65,
            NULL,
            397.40,
            'Efectivo',
            '33065',
            'Pago histórico recibo N° 33065',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_65_13, 'monto_aplicado', 46.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_65_14, 'monto_aplicado', 281.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_65_12, 'monto_aplicado', 30.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_65_15, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_65_16, 'monto_aplicado', 30.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_65_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_65,
            v_socio_65,
            NULL,
            30.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_65_16, 'monto_aplicado', 30.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: GUTIERREZ CASTILLO TERESA JESUS (Puesto: 84, ID: 66)
    -- =========================================================================
    DECLARE
        v_socio_66 bigint := 66;
        v_puesto_66 bigint := 180;
        v_m_id_66_0 bigint;
        v_m_id_66_1 bigint;
        v_m_id_66_2 bigint;
        v_m_id_66_3 bigint;
        v_m_id_66_4 bigint;
        v_m_id_66_5 bigint;
        v_m_id_66_6 bigint;
        v_m_id_66_7 bigint;
        v_m_id_66_8 bigint;
        v_m_id_66_9 bigint;
        v_m_id_66_10 bigint;
        v_m_id_66_11 bigint;
        v_m_id_66_12 bigint;
        v_m_id_66_13 bigint;
        v_m_id_66_14 bigint;
        v_m_id_66_15 bigint;
        v_m_id_66_16 bigint;
        v_m_id_66_17 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_66 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_66 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_66;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_66 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_66;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 1, 2025, 11, 14.30, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_66_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_66_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_66_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_66_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 1, 2025, 12, 8.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_66_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_66_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_66_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_66_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 1, 2026, 1, 6.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_66_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_66_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_66_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_66_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_66_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_66_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 1, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_66_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_66_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_66_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_66, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_66_17;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_66,
            v_socio_66,
            NULL,
            241.90,
            'Efectivo',
            '32804',
            'Pago histórico recibo N° 32804',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_66_0, 'monto_aplicado', 14.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_66_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_66_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_66_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_66_4, 'monto_aplicado', 8.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_66_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_66_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_66_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_66_8, 'monto_aplicado', 6.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_66_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_66_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_66_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_66,
            v_socio_66,
            NULL,
            114.30,
            'Efectivo',
            '32805',
            'Pago histórico recibo N° 32805',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_66_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_66_13, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_66_14, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_66_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_66_16, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_66_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: GUTIERREZ CASTRO JORGE RICARDO (Puesto: 170, ID: 67)
    -- =========================================================================
    DECLARE
        v_socio_67 bigint := 67;
        v_puesto_67 bigint := 265;
        v_m_id_67_0 bigint;
        v_m_id_67_1 bigint;
        v_m_id_67_2 bigint;
        v_m_id_67_3 bigint;
        v_m_id_67_4 bigint;
        v_m_id_67_5 bigint;
        v_m_id_67_6 bigint;
        v_m_id_67_7 bigint;
        v_m_id_67_8 bigint;
        v_m_id_67_9 bigint;
        v_m_id_67_10 bigint;
        v_m_id_67_11 bigint;
        v_m_id_67_12 bigint;
        v_m_id_67_13 bigint;
        v_m_id_67_14 bigint;
        v_m_id_67_15 bigint;
        v_m_id_67_16 bigint;
        v_m_id_67_17 bigint;
        v_m_id_67_18 bigint;
        v_m_id_67_19 bigint;
        v_m_id_67_20 bigint;
        v_m_id_67_21 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_67 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_67 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_67;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_67 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_67;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 18, 2026, 8, 15.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - TALONARIO SANTA ROSA', v_user_uuid)
        RETURNING id INTO v_m_id_67_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 1, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_67_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_67_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_67_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_67_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_67_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_67_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 1, 2025, 12, 30.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_67_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_67_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 1, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_67_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_67_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_67_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_67_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_67_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 1, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_67_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_67_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_67_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_67_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 1, 2026, 3, 11.90, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_67_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_67_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_67_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_67, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_67_21;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_67,
            v_socio_67,
            NULL,
            212.00,
            'Efectivo',
            '32911',
            'Pago histórico recibo N° 32911',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_67_0, 'monto_aplicado', 15.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_7, 'monto_aplicado', 30.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_8, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_10, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_13, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_14, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_16, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_67,
            v_socio_67,
            NULL,
            76.00,
            'Efectivo',
            '32278',
            'Pago histórico recibo N° 32278',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_67_1, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_2, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_3, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_4, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_67,
            v_socio_67,
            NULL,
            65.00,
            'Efectivo',
            '62278',
            'Pago histórico recibo N° 62278',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_67_5, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_6, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_67,
            v_socio_67,
            NULL,
            82.90,
            'Efectivo',
            '32991',
            'Pago histórico recibo N° 32991',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_67_18, 'monto_aplicado', 11.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_19, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_67_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-29 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: GUTIERREZ FLORES ROGER REYNAN (Puesto: 39, ID: 68)
    -- =========================================================================
    DECLARE
        v_socio_68 bigint := 68;
        v_puesto_68 bigint := 112;
        v_m_id_68_0 bigint;
        v_m_id_68_1 bigint;
        v_m_id_68_2 bigint;
        v_m_id_68_3 bigint;
        v_m_id_68_4 bigint;
        v_m_id_68_5 bigint;
        v_m_id_68_6 bigint;
        v_m_id_68_7 bigint;
        v_m_id_68_8 bigint;
        v_m_id_68_9 bigint;
        v_m_id_68_10 bigint;
        v_m_id_68_11 bigint;
        v_m_id_68_12 bigint;
        v_m_id_68_13 bigint;
        v_m_id_68_14 bigint;
        v_m_id_68_15 bigint;
        v_m_id_68_16 bigint;
        v_m_id_68_17 bigint;
        v_m_id_68_18 bigint;
        v_m_id_68_19 bigint;
        v_m_id_68_20 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_68 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_68 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_68;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_68 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_68;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 1, 2025, 11, 80.40, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_68_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 2, 2025, 11, 107.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_68_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_68_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_68_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_68_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_68_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 1, 2025, 12, 81.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_68_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 2, 2025, 12, 119.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_68_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_68_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_68_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 1, 2026, 1, 79.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_68_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 2, 2026, 1, 136.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_68_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_68_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 1, 2026, 2, 78.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_68_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 2, 2026, 2, 168.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_68_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_68_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_68_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 1, 2026, 3, 81.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_68_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 2, 2026, 3, 187.60, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_68_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_68_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_68, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_68_20;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_68,
            v_socio_68,
            NULL,
            317.50,
            'Efectivo',
            '32314',
            'Pago histórico recibo N° 32314',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_68_0, 'monto_aplicado', 80.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_68_1, 'monto_aplicado', 107.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_68_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_68_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_68_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_68_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_68,
            v_socio_68,
            NULL,
            265.80,
            'Efectivo',
            '32462',
            'Pago histórico recibo N° 32462',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_68_6, 'monto_aplicado', 81.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_68_7, 'monto_aplicado', 119.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_68_8, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_68_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_68,
            v_socio_68,
            NULL,
            534.10,
            'Efectivo',
            '32818',
            'Pago histórico recibo N° 32818',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_68_10, 'monto_aplicado', 79.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_68_11, 'monto_aplicado', 136.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_68_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_68_13, 'monto_aplicado', 78.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_68_14, 'monto_aplicado', 168.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_68_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_68_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_68,
            v_socio_68,
            NULL,
            333.60,
            'Efectivo',
            '32980',
            'Pago histórico recibo N° 32980',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_68_17, 'monto_aplicado', 81.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_68_18, 'monto_aplicado', 187.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_68_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_68_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-29 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: HALIRE YUCRA JOSUE JAASIEL (Puesto: 100, ID: 69)
    -- =========================================================================
    DECLARE
        v_socio_69 bigint := 69;
        v_puesto_69 bigint := 195;
        v_m_id_69_0 bigint;
        v_m_id_69_1 bigint;
        v_m_id_69_2 bigint;
        v_m_id_69_3 bigint;
        v_m_id_69_4 bigint;
        v_m_id_69_5 bigint;
        v_m_id_69_6 bigint;
        v_m_id_69_7 bigint;
        v_m_id_69_8 bigint;
        v_m_id_69_9 bigint;
        v_m_id_69_10 bigint;
        v_m_id_69_11 bigint;
        v_m_id_69_12 bigint;
        v_m_id_69_13 bigint;
        v_m_id_69_14 bigint;
        v_m_id_69_15 bigint;
        v_m_id_69_16 bigint;
        v_m_id_69_17 bigint;
        v_m_id_69_18 bigint;
        v_m_id_69_19 bigint;
        v_m_id_69_20 bigint;
        v_m_id_69_21 bigint;
        v_m_id_69_22 bigint;
        v_m_id_69_23 bigint;
        v_m_id_69_24 bigint;
        v_m_id_69_25 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_69 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_69 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_69;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_69 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_69;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 1, 2025, 11, 24.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_69_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 2, 2025, 11, 7.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_69_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 7, 2025, 11, 200.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_69_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 1, 2025, 12, 25.80, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_69_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 2, 2025, 12, 6.10, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_69_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 7, 2025, 12, 200.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_69_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_69_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_69_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 1, 2026, 1, 28.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_69_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 2, 2026, 1, 8.10, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_69_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_69_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 7, 2026, 1, 200.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_69_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_69_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_69_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 7, 2026, 2, 200.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_69_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 1, 2026, 2, 27.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_69_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 2, 2026, 2, 13.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_69_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_69_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_69_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 1, 2026, 3, 28.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_69_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 2, 2026, 3, 17.80, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_69_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 7, 2026, 3, 200.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - DEPOSITO', v_user_uuid)
        RETURNING id INTO v_m_id_69_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_69_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 1, 2026, 4, 28.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_69_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 2, 2026, 4, 16.70, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_69_24;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_69, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_69_25;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_69,
            v_socio_69,
            NULL,
            510.00,
            'Efectivo',
            '32513',
            'Pago histórico recibo N° 32513',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_69_0, 'monto_aplicado', 24.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_69_1, 'monto_aplicado', 7.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_69_2, 'monto_aplicado', 200.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_69_3, 'monto_aplicado', 25.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_69_4, 'monto_aplicado', 6.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_69_5, 'monto_aplicado', 200.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_69_8, 'monto_aplicado', 28.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_69_9, 'monto_aplicado', 8.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_69_10, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-16 12:00:00-05', created_at = '2026-02-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-16 12:00:00-05', created_at = '2026-02-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_69,
            v_socio_69,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_69_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_69_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_69,
            v_socio_69,
            NULL,
            0.10,
            'Efectivo',
            '32514',
            'Pago histórico recibo N° 32514',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_69_9, 'monto_aplicado', 0.10, 'cubierto_completo', true)),
            0.00,
            '2026-02-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-16 12:00:00-05', created_at = '2026-02-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-16 12:00:00-05', created_at = '2026-02-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_69,
            v_socio_69,
            NULL,
            400.00,
            'Efectivo',
            '32670',
            'Pago histórico recibo N° 32670',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_69_11, 'monto_aplicado', 200.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_69_14, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-13 12:00:00-05', created_at = '2026-03-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-13 12:00:00-05', created_at = '2026-03-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_69,
            v_socio_69,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_69_12, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_69_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_69,
            v_socio_69,
            NULL,
            40.60,
            'Efectivo',
            '32705',
            'Pago histórico recibo N° 32705',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_69_15, 'monto_aplicado', 27.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_69_16, 'monto_aplicado', 13.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_69,
            v_socio_69,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MARZO',
            'Pago mensual vía tarjeta - TARJETA-MARZO',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_69_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_69_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_69,
            v_socio_69,
            NULL,
            307.50,
            'Efectivo',
            '33116',
            'Pago histórico recibo N° 33116',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_69_19, 'monto_aplicado', 28.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_69_20, 'monto_aplicado', 17.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_69_21, 'monto_aplicado', 200.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_69_23, 'monto_aplicado', 28.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_69_24, 'monto_aplicado', 16.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_69_22, 'monto_aplicado', 12.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_69_25, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_69,
            v_socio_69,
            NULL,
            48.00,
            'Transferencia',
            'TARJETA-ABRIL',
            'Pago mensual vía tarjeta - TARJETA-ABRIL',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_69_22, 'monto_aplicado', 48.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: HEREDIA MUNOZ DE BRAVO MARIA (Puesto: 150, ID: 70)
    -- =========================================================================
    DECLARE
        v_socio_70 bigint := 70;
        v_puesto_70 bigint := 245;
        v_m_id_70_0 bigint;
        v_m_id_70_1 bigint;
        v_m_id_70_2 bigint;
        v_m_id_70_3 bigint;
        v_m_id_70_4 bigint;
        v_m_id_70_5 bigint;
        v_m_id_70_6 bigint;
        v_m_id_70_7 bigint;
        v_m_id_70_8 bigint;
        v_m_id_70_9 bigint;
        v_m_id_70_10 bigint;
        v_m_id_70_11 bigint;
        v_m_id_70_12 bigint;
        v_m_id_70_13 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_70 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_70 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_70;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_70 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_70;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_70, 1, 2025, 12, 8.30, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_70_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_70, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_70_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_70, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_70_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_70, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_70_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_70, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_70_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_70, 1, 2026, 1, 9.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_70_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_70, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_70_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_70, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_70_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_70, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_70_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_70, 1, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_70_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_70, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_70_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_70, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_70_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_70, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_70_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_70, 3, 2026, 4, 44.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_70_13;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_70,
            v_socio_70,
            NULL,
            14.30,
            'Efectivo',
            '32473',
            'Pago histórico recibo N° 32473',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_70_0, 'monto_aplicado', 8.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_70_1, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-06 12:00:00-05', created_at = '2026-02-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-06 12:00:00-05', created_at = '2026-02-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_70,
            v_socio_70,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_70_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_70_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_70,
            v_socio_70,
            NULL,
            10.00,
            'Efectivo',
            '32654',
            'Pago histórico recibo N° 32654',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_70_4, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_70,
            v_socio_70,
            NULL,
            14.00,
            'Efectivo',
            '32685',
            'Pago histórico recibo N° 32685',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_70_5, 'monto_aplicado', 9.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_70_6, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-17 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-17 12:00:00-05', created_at = '2026-03-17 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-17 12:00:00-05', created_at = '2026-03-17 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_70,
            v_socio_70,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_70_7, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_70_8, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_70,
            v_socio_70,
            NULL,
            15.00,
            'Efectivo',
            '32891',
            'Pago histórico recibo N° 32891',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_70_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_70_10, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_70,
            v_socio_70,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_70_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_70_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_70,
            v_socio_70,
            NULL,
            44.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_70_13, 'monto_aplicado', 44.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: HUAMANI ROMERO DOMITILA CLEOFE (Puesto: 1, ID: 72)
    -- =========================================================================
    DECLARE
        v_socio_72 bigint := 72;
        v_puesto_72 bigint := 1;
        v_m_id_72_0 bigint;
        v_m_id_72_1 bigint;
        v_m_id_72_2 bigint;
        v_m_id_72_3 bigint;
        v_m_id_72_4 bigint;
        v_m_id_72_5 bigint;
        v_m_id_72_6 bigint;
        v_m_id_72_7 bigint;
        v_m_id_72_8 bigint;
        v_m_id_72_9 bigint;
        v_m_id_72_10 bigint;
        v_m_id_72_11 bigint;
        v_m_id_72_12 bigint;
        v_m_id_72_13 bigint;
        v_m_id_72_14 bigint;
        v_m_id_72_15 bigint;
        v_m_id_72_16 bigint;
        v_m_id_72_17 bigint;
        v_m_id_72_18 bigint;
        v_m_id_72_19 bigint;
        v_m_id_72_20 bigint;
        v_m_id_72_21 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_72 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_72 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_72;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_72 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_72;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 1, 2025, 11, 133.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_72_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_72_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_72_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_72_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_72_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_72_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 1, 2025, 12, 134.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_72_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_72_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 1, 2026, 1, 131.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_72_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_72_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_72_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_72_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_72_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_72_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 1, 2026, 2, 129.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_72_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_72_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 1, 2026, 3, 133.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_72_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_72_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_72_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_72_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_72_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_72, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_72_21;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_72,
            v_socio_72,
            NULL,
            269.10,
            'Efectivo',
            '32286',
            'Pago histórico recibo N° 32286',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_72_0, 'monto_aplicado', 133.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_72_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_72_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_72_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_72_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_72_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_72,
            v_socio_72,
            NULL,
            140.90,
            'Efectivo',
            '32388',
            'Pago histórico recibo N° 32388',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_72_6, 'monto_aplicado', 134.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_72_7, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_72,
            v_socio_72,
            NULL,
            136.20,
            'Efectivo',
            '32607',
            'Pago histórico recibo N° 32607',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_72_8, 'monto_aplicado', 131.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_72_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-03 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_72,
            v_socio_72,
            NULL,
            126.00,
            'Efectivo',
            '32608',
            'Pago histórico recibo N° 32608',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_72_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_72_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_72_12, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_72_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-03 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_72,
            v_socio_72,
            NULL,
            139.30,
            'Efectivo',
            '32909',
            'Pago histórico recibo N° 32909',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_72_14, 'monto_aplicado', 129.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_72_15, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_72,
            v_socio_72,
            NULL,
            204.70,
            'Efectivo',
            '33014',
            'Pago histórico recibo N° 33014',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_72_16, 'monto_aplicado', 133.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_72_17, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_72_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_72_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_72,
            v_socio_72,
            NULL,
            65.00,
            'Efectivo',
            '33015',
            'Pago histórico recibo N° 33015',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_72_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_72_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: HUASHUAYO GOMEZ EUDOSIA (Puesto: 9, ID: 73)
    -- =========================================================================
    DECLARE
        v_socio_73 bigint := 73;
        v_puesto_73 bigint := 52;
        v_m_id_73_0 bigint;
        v_m_id_73_1 bigint;
        v_m_id_73_2 bigint;
        v_m_id_73_3 bigint;
        v_m_id_73_4 bigint;
        v_m_id_73_5 bigint;
        v_m_id_73_6 bigint;
        v_m_id_73_7 bigint;
        v_m_id_73_8 bigint;
        v_m_id_73_9 bigint;
        v_m_id_73_10 bigint;
        v_m_id_73_11 bigint;
        v_m_id_73_12 bigint;
        v_m_id_73_13 bigint;
        v_m_id_73_14 bigint;
        v_m_id_73_15 bigint;
        v_m_id_73_16 bigint;
        v_m_id_73_17 bigint;
        v_m_id_73_18 bigint;
        v_m_id_73_19 bigint;
        v_m_id_73_20 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_73 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_73 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_73;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_73 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_73;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 1, 2025, 12, 95.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_73_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_73_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_73_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_73_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 18, 2026, 1, 200.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - DEPOSITO N° 2', v_user_uuid)
        RETURNING id INTO v_m_id_73_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 1, 2026, 1, 92.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_73_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_73_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_73_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_73_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_73_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 18, 2026, 2, 200.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO N° 2', v_user_uuid)
        RETURNING id INTO v_m_id_73_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 1, 2026, 2, 91.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_73_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_73_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_73_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_73_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 18, 2026, 3, 200.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - DEPOSITO N° 2', v_user_uuid)
        RETURNING id INTO v_m_id_73_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 1, 2026, 3, 94.90, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_73_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_73_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_73_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_73_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_73, 18, 2026, 4, 200.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - DEPOSITO N° 2', v_user_uuid)
        RETURNING id INTO v_m_id_73_20;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_73,
            v_socio_73,
            NULL,
            366.60,
            'Efectivo',
            '32472',
            'Pago histórico recibo N° 32472',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_73_0, 'monto_aplicado', 95.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_73_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_73_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_73_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_73_4, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-05 12:00:00-05', created_at = '2026-02-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-05 12:00:00-05', created_at = '2026-02-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_73,
            v_socio_73,
            NULL,
            358.90,
            'Efectivo',
            '32626',
            'Pago histórico recibo N° 32626',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_73_5, 'monto_aplicado', 92.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_73_6, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_73_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_73_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_73_10, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-05 12:00:00-05', created_at = '2026-03-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-05 12:00:00-05', created_at = '2026-03-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_73,
            v_socio_73,
            NULL,
            129.90,
            'Efectivo',
            '32897',
            'Pago histórico recibo N° 32897',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_73_7, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_73_11, 'monto_aplicado', 91.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_73_12, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_73,
            v_socio_73,
            NULL,
            265.00,
            'Efectivo',
            '32932',
            'Pago histórico recibo N° 32932',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_73_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_73_14, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_73_15, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-08 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-08 12:00:00-05', created_at = '2026-04-08 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-08 12:00:00-05', created_at = '2026-04-08 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_73,
            v_socio_73,
            NULL,
            365.90,
            'Efectivo',
            '33039',
            'Pago histórico recibo N° 33039',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_73_16, 'monto_aplicado', 94.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_73_17, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_73_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_73_19, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_73_20, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-07 12:00:00-05', created_at = '2026-05-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: HUAYHUALLA DE LOPEZ DONATILA (Puesto: 113, ID: 74)
    -- =========================================================================
    DECLARE
        v_socio_74 bigint := 74;
        v_puesto_74 bigint := 208;
        v_m_id_74_0 bigint;
        v_m_id_74_1 bigint;
        v_m_id_74_2 bigint;
        v_m_id_74_3 bigint;
        v_m_id_74_4 bigint;
        v_m_id_74_5 bigint;
        v_m_id_74_6 bigint;
        v_m_id_74_7 bigint;
        v_m_id_74_8 bigint;
        v_m_id_74_9 bigint;
        v_m_id_74_10 bigint;
        v_m_id_74_11 bigint;
        v_m_id_74_12 bigint;
        v_m_id_74_13 bigint;
        v_m_id_74_14 bigint;
        v_m_id_74_15 bigint;
        v_m_id_74_16 bigint;
        v_m_id_74_17 bigint;
        v_m_id_74_18 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_74 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_74 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_74;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_74 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_74;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 1, 2025, 11, 96.80, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_74_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 2, 2025, 11, 60.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_74_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 1, 2025, 12, 128.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_74_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 2, 2025, 12, 60.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_74_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_74_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_74_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 1, 2026, 1, 149.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_74_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 2, 2026, 1, 76.80, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_74_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_74_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_74_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_74_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 1, 2026, 2, 147.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_74_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 2, 2026, 2, 75.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_74_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_74_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_74_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 1, 2026, 3, 141.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_74_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 2, 2026, 3, 78.80, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_74_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_74_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_74, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_74_18;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_74,
            v_socio_74,
            NULL,
            156.90,
            'Efectivo',
            '32279',
            'Pago histórico recibo N° 32279',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_74_0, 'monto_aplicado', 96.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_74_1, 'monto_aplicado', 60.10, 'cubierto_completo', true)),
            0.00,
            '2026-01-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-05 12:00:00-05', created_at = '2026-01-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_74,
            v_socio_74,
            NULL,
            188.50,
            'Efectivo',
            '32437',
            'Pago histórico recibo N° 32437',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_74_2, 'monto_aplicado', 128.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_74_3, 'monto_aplicado', 60.50, 'cubierto_completo', true)),
            0.00,
            '2026-01-29 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-29 12:00:00-05', created_at = '2026-01-29 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-29 12:00:00-05', created_at = '2026-01-29 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_74,
            v_socio_74,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_74_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_74_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_74,
            v_socio_74,
            NULL,
            236.70,
            'Efectivo',
            '32614',
            'Pago histórico recibo N° 32614',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_74_6, 'monto_aplicado', 149.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_74_7, 'monto_aplicado', 76.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_74_8, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-04 12:00:00-05', created_at = '2026-03-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_74,
            v_socio_74,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_74_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_74_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_74,
            v_socio_74,
            NULL,
            222.90,
            'Efectivo',
            '32777',
            'Pago histórico recibo N° 32777',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_74_11, 'monto_aplicado', 147.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_74_12, 'monto_aplicado', 75.70, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_74,
            v_socio_74,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_74_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_74_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_74,
            v_socio_74,
            NULL,
            220.50,
            'Efectivo',
            '33005',
            'Pago histórico recibo N° 33005',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_74_15, 'monto_aplicado', 141.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_74_16, 'monto_aplicado', 78.80, 'cubierto_completo', true)),
            0.00,
            '2026-05-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_74,
            v_socio_74,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_74_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_74_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: JARA ALVARES CRISTALINA (Puesto: 161, ID: 76)
    -- =========================================================================
    DECLARE
        v_socio_76 bigint := 76;
        v_puesto_76 bigint := 256;
        v_m_id_76_0 bigint;
        v_m_id_76_1 bigint;
        v_m_id_76_2 bigint;
        v_m_id_76_3 bigint;
        v_m_id_76_4 bigint;
        v_m_id_76_5 bigint;
        v_m_id_76_6 bigint;
        v_m_id_76_7 bigint;
        v_m_id_76_8 bigint;
        v_m_id_76_9 bigint;
        v_m_id_76_10 bigint;
        v_m_id_76_11 bigint;
        v_m_id_76_12 bigint;
        v_m_id_76_13 bigint;
        v_m_id_76_14 bigint;
        v_m_id_76_15 bigint;
        v_m_id_76_16 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_76 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_76 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_76;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_76 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_76;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_76, 3, 2025, 12, 16.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_76_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_76, 1, 2026, 1, 17.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_76_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_76, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_76_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_76, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_76_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_76, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - p. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_76_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_76, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - p.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_76_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_76, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_76_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_76, 1, 2026, 2, 15.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_76_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_76, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_76_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_76, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_76_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_76, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_76_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_76, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_76_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_76, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_76_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_76, 1, 2026, 3, 20.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_76_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_76, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_76_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_76, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_76_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_76, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_76_16;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_76,
            v_socio_76,
            NULL,
            30.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_76_0, 'monto_aplicado', 16.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_76_1, 'monto_aplicado', 13.50, 'cubierto_completo', false)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_76,
            v_socio_76,
            NULL,
            10.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_76_1, 'monto_aplicado', 4.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_76_2, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_76_7, 'monto_aplicado', 1.00, 'cubierto_completo', false)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_76,
            v_socio_76,
            NULL,
            201.00,
            'Efectivo',
            '32688',
            'Pago histórico recibo N° 32688',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_76_3, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_76_4, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_76_5, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_76_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_76_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_76_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_76_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_76,
            v_socio_76,
            NULL,
            52.70,
            'Efectivo',
            '32890',
            'Pago histórico recibo N° 32890',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_76_6, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_76_7, 'monto_aplicado', 14.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_76_10, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_76,
            v_socio_76,
            NULL,
            50.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_76_13, 'monto_aplicado', 20.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_76_14, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_76_15, 'monto_aplicado', 23.60, 'cubierto_completo', false)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_76,
            v_socio_76,
            NULL,
            20.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_76_15, 'monto_aplicado', 20.00, 'cubierto_completo', false)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_76,
            v_socio_76,
            NULL,
            21.40,
            'Efectivo',
            '33016',
            'Pago histórico recibo N° 33016',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_76_15, 'monto_aplicado', 16.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_76_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-06 12:00:00-05', created_at = '2026-05-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: JARA ALVAREZ MARIA CENAIDA (Puesto: 50, ID: 77)
    -- =========================================================================
    DECLARE
        v_socio_77 bigint := 77;
        v_puesto_77 bigint := 134;
        v_m_id_77_0 bigint;
        v_m_id_77_1 bigint;
        v_m_id_77_2 bigint;
        v_m_id_77_3 bigint;
        v_m_id_77_4 bigint;
        v_m_id_77_5 bigint;
        v_m_id_77_6 bigint;
        v_m_id_77_7 bigint;
        v_m_id_77_8 bigint;
        v_m_id_77_9 bigint;
        v_m_id_77_10 bigint;
        v_m_id_77_11 bigint;
        v_m_id_77_12 bigint;
        v_m_id_77_13 bigint;
        v_m_id_77_14 bigint;
        v_m_id_77_15 bigint;
        v_m_id_77_16 bigint;
        v_m_id_77_17 bigint;
        v_m_id_77_18 bigint;
        v_m_id_77_19 bigint;
        v_m_id_77_20 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_77 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_77 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_77;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_77 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_77;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 1, 2025, 11, 67.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_77_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_77_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 1, 2025, 12, 68.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_77_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_77_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 1, 2026, 1, 66.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_77_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_77_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_77_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_77_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_77_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_77_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 1, 2026, 2, 66.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_77_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_77_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_77_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_77_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_77_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_77_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 1, 2026, 3, 68.60, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_77_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_77_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 3, 2026, 4, 7.20, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_77_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 1, 2026, 4, 99.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_77_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_77, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_77_20;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_77,
            v_socio_77,
            NULL,
            148.80,
            'Efectivo',
            '32492',
            'Pago histórico recibo N° 32492',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_77_0, 'monto_aplicado', 67.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_77_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_77_2, 'monto_aplicado', 68.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_77_3, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_77,
            v_socio_77,
            NULL,
            147.90,
            'Efectivo',
            '32773',
            'Pago histórico recibo N° 32773',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_77_4, 'monto_aplicado', 66.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_77_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_77_10, 'monto_aplicado', 66.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_77_11, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_77,
            v_socio_77,
            NULL,
            236.50,
            'Efectivo',
            '32803',
            'Pago histórico recibo N° 32803',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_77_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_77_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_77_8, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_77_9, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_77_12, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_77_13, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_77_14, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_77_15, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_77_18, 'monto_aplicado', 7.20, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_77,
            v_socio_77,
            NULL,
            179.60,
            'Efectivo',
            '33134',
            'Pago histórico recibo N° 33134',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_77_16, 'monto_aplicado', 68.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_77_17, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_77_19, 'monto_aplicado', 99.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_77_20, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: JARA ALVAREZ SANTOS PEDRO (Puesto: 87, ID: 78)
    -- =========================================================================
    DECLARE
        v_socio_78 bigint := 78;
        v_puesto_78 bigint := 183;
        v_m_id_78_0 bigint;
        v_m_id_78_1 bigint;
        v_m_id_78_2 bigint;
        v_m_id_78_3 bigint;
        v_m_id_78_4 bigint;
        v_m_id_78_5 bigint;
        v_m_id_78_6 bigint;
        v_m_id_78_7 bigint;
        v_m_id_78_8 bigint;
        v_m_id_78_9 bigint;
        v_m_id_78_10 bigint;
        v_m_id_78_11 bigint;
        v_m_id_78_12 bigint;
        v_m_id_78_13 bigint;
        v_m_id_78_14 bigint;
        v_m_id_78_15 bigint;
        v_m_id_78_16 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_78 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_78 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_78;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_78 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_78;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_78, 1, 2025, 12, 28.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_78_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_78, 2, 2025, 12, 12.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_78_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_78, 3, 2025, 12, 120.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_78_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_78, 4, 2025, 12, 10.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_78_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_78, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_78_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_78, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_78_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_78, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_78_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_78, 1, 2026, 1, 14.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_78_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_78, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_78_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_78, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_78_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_78, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_78_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_78, 1, 2026, 2, 15.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_78_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_78, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_78_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_78, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_78_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_78, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_78_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_78, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_78_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_78, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_78_16;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_78,
            v_socio_78,
            NULL,
            30.00,
            'Efectivo',
            '32464',
            'Pago histórico recibo N° 32464',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_78_0, 'monto_aplicado', 12.40, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_78_1, 'monto_aplicado', 6.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_78_0, 'monto_aplicado', 11.60, 'cubierto_completo', false)),
            0.00,
            '2026-02-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_78,
            v_socio_78,
            NULL,
            205.00,
            'Efectivo',
            '32491',
            'Pago histórico recibo N° 32491',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_78_2, 'monto_aplicado', 60.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_78_3, 'monto_aplicado', 5.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_78_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_78_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_78_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_78_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_78_6, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_78,
            v_socio_78,
            NULL,
            10.50,
            'Efectivo',
            '32465',
            'Pago histórico recibo N° 32465',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_78_0, 'monto_aplicado', 4.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_78_1, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_78,
            v_socio_78,
            NULL,
            44.90,
            'Efectivo',
            '32884',
            'Pago histórico recibo N° 32884',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_78_7, 'monto_aplicado', 14.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_78_8, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_78_11, 'monto_aplicado', 15.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_78_12, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_78,
            v_socio_78,
            NULL,
            61.00,
            'Efectivo',
            '32774',
            'Pago histórico recibo N° 32774',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_78_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_78_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_78,
            v_socio_78,
            NULL,
            130.00,
            'Efectivo',
            '33136',
            'Pago histórico recibo N° 33136',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_78_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_78_14, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_78_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_78_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: JUAREZ CUELLAR LEONOR (Puesto: 47, ID: 79)
    -- =========================================================================
    DECLARE
        v_socio_79 bigint := 79;
        v_puesto_79 bigint := 128;
        v_m_id_79_0 bigint;
        v_m_id_79_1 bigint;
        v_m_id_79_2 bigint;
        v_m_id_79_3 bigint;
        v_m_id_79_4 bigint;
        v_m_id_79_5 bigint;
        v_m_id_79_6 bigint;
        v_m_id_79_7 bigint;
        v_m_id_79_8 bigint;
        v_m_id_79_9 bigint;
        v_m_id_79_10 bigint;
        v_m_id_79_11 bigint;
        v_m_id_79_12 bigint;
        v_m_id_79_13 bigint;
        v_m_id_79_14 bigint;
        v_m_id_79_15 bigint;
        v_m_id_79_16 bigint;
        v_m_id_79_17 bigint;
        v_m_id_79_18 bigint;
        v_m_id_79_19 bigint;
        v_m_id_79_20 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_79 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_79 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_79;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_79 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_79;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 1, 2025, 11, 113.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_79_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 2, 2025, 11, 113.90, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_79_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_79_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_79_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 1, 2025, 12, 115.30, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_79_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 2, 2025, 12, 117.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_79_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_79_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_79_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_79_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 1, 2026, 1, 112.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_79_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 2, 2026, 1, 125.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_79_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_79_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_79_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 1, 2026, 2, 110.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_79_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 2, 2026, 2, 166.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_79_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 1, 2026, 3, 114.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_79_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 2, 2026, 3, 211.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_79_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_79_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_79_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_79_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_79, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_79_20;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_79,
            v_socio_79,
            NULL,
            292.60,
            'Efectivo',
            '32315',
            'Pago histórico recibo N° 32315',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_79_0, 'monto_aplicado', 113.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_79_1, 'monto_aplicado', 113.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_79_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_79_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-13 12:00:00-05', created_at = '2026-01-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_79,
            v_socio_79,
            NULL,
            297.80,
            'Efectivo',
            '32461',
            'Pago histórico recibo N° 32461',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_79_4, 'monto_aplicado', 115.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_79_5, 'monto_aplicado', 117.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_79_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_79_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_79,
            v_socio_79,
            NULL,
            71.00,
            'Efectivo',
            '32681',
            'Pago histórico recibo N° 32681',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_79_8, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_79_11, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_79_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-17 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-17 12:00:00-05', created_at = '2026-03-17 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-17 12:00:00-05', created_at = '2026-03-17 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_79,
            v_socio_79,
            NULL,
            514.60,
            'Efectivo',
            '32819',
            'Pago histórico recibo N° 32819',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_79_9, 'monto_aplicado', 112.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_79_10, 'monto_aplicado', 125.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_79_13, 'monto_aplicado', 110.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_79_14, 'monto_aplicado', 166.50, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_79,
            v_socio_79,
            NULL,
            390.70,
            'Efectivo',
            '32979',
            'Pago histórico recibo N° 32979',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_79_15, 'monto_aplicado', 114.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_79_16, 'monto_aplicado', 211.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_79_17, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_79_18, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-29 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-29 12:00:00-05', created_at = '2026-04-29 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_79,
            v_socio_79,
            NULL,
            65.00,
            'Efectivo',
            '33047',
            'Pago histórico recibo N° 33047',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_79_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_79_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-11 12:00:00-05', created_at = '2026-05-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: LAGOS LUNA DE LEYVA ZAIDA LUISA (Puesto: 25, ID: 80)
    -- =========================================================================
    DECLARE
        v_socio_80 bigint := 80;
        v_puesto_80 bigint := 86;
        v_m_id_80_0 bigint;
        v_m_id_80_1 bigint;
        v_m_id_80_2 bigint;
        v_m_id_80_3 bigint;
        v_m_id_80_4 bigint;
        v_m_id_80_5 bigint;
        v_m_id_80_6 bigint;
        v_m_id_80_7 bigint;
        v_m_id_80_8 bigint;
        v_m_id_80_9 bigint;
        v_m_id_80_10 bigint;
        v_m_id_80_11 bigint;
        v_m_id_80_12 bigint;
        v_m_id_80_13 bigint;
        v_m_id_80_14 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_80 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_80 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_80;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_80 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_80;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_80, 1, 2025, 12, 45.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_80_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_80, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_80_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_80, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_80_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_80, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_80_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_80, 1, 2026, 1, 44.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_80_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_80, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_80_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_80, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_80_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_80, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_80_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_80, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_80_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_80, 1, 2026, 2, 43.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_80_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_80, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_80_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_80, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_80_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_80, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_80_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_80, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_80_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_80, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_80_14;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_80,
            v_socio_80,
            NULL,
            72.00,
            'Efectivo',
            '32435',
            'Pago histórico recibo N° 32435',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_80_0, 'monto_aplicado', 45.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_80_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_80_2, 'monto_aplicado', 16.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_80_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_80,
            v_socio_80,
            NULL,
            44.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_80_2, 'monto_aplicado', 44.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_80,
            v_socio_80,
            NULL,
            59.00,
            'Efectivo',
            '32606',
            'Pago histórico recibo N° 32606',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_80_4, 'monto_aplicado', 44.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_80_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_80_6, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-03 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-03 12:00:00-05', created_at = '2026-03-03 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_80,
            v_socio_80,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_80_7, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_80_8, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_80,
            v_socio_80,
            NULL,
            53.10,
            'Efectivo',
            '32722',
            'Pago histórico recibo N° 32722',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_80_9, 'monto_aplicado', 43.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_80_10, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_80,
            v_socio_80,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_80_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_80_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_80,
            v_socio_80,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_80_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_80_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: LIMAS VARGAS CARMEN ROSA (Puesto: 2, ID: 81)
    -- =========================================================================
    DECLARE
        v_socio_81 bigint := 81;
        v_puesto_81 bigint := 8;
        v_m_id_81_0 bigint;
        v_m_id_81_1 bigint;
        v_m_id_81_2 bigint;
        v_m_id_81_3 bigint;
        v_m_id_81_4 bigint;
        v_m_id_81_5 bigint;
        v_m_id_81_6 bigint;
        v_m_id_81_7 bigint;
        v_m_id_81_8 bigint;
        v_m_id_81_9 bigint;
        v_m_id_81_10 bigint;
        v_m_id_81_11 bigint;
        v_m_id_81_12 bigint;
        v_m_id_81_13 bigint;
        v_m_id_81_14 bigint;
        v_m_id_81_15 bigint;
        v_m_id_81_16 bigint;
        v_m_id_81_17 bigint;
        v_m_id_81_18 bigint;
        v_m_id_81_19 bigint;
        v_m_id_81_20 bigint;
        v_m_id_81_21 bigint;
        v_m_id_81_22 bigint;
        v_m_id_81_23 bigint;
        v_m_id_81_24 bigint;
        v_m_id_81_25 bigint;
        v_m_id_81_26 bigint;
        v_m_id_81_27 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_81 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_81 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_81;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_81 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_81;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_81_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_81_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 18, 2025, 11, 150.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - DEPOSITO N° 7 3PSIO', v_user_uuid)
        RETURNING id INTO v_m_id_81_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 1, 2026, 1, 170.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_81_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 1, 2025, 11, 36.05, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_81_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_81_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_81_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_81_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 18, 2025, 12, 150.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - DEPOSITO N° 7 3PSIO', v_user_uuid)
        RETURNING id INTO v_m_id_81_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 1, 2025, 12, 36.55, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_81_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_81_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_81_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_81_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 18, 2026, 1, 150.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - DEPOSITO N° 7 3PSIO', v_user_uuid)
        RETURNING id INTO v_m_id_81_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_81_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_81_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_81_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 18, 2026, 2, 150.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO N° 7 3PSIO', v_user_uuid)
        RETURNING id INTO v_m_id_81_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 1, 2026, 2, 32.30, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_81_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_81_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 1, 2026, 3, 67.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_81_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_81_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_81_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_81_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 18, 2026, 3, 150.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - DEPOSITO N° 7 3PSIO', v_user_uuid)
        RETURNING id INTO v_m_id_81_24;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_81_25;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_81_26;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_81, 18, 2026, 4, 150.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - DEPOSITO N° 7 3PSIO', v_user_uuid)
        RETURNING id INTO v_m_id_81_27;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_81,
            v_socio_81,
            NULL,
            856.00,
            'Efectivo',
            '32709',
            'Pago histórico recibo N° 32709',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_81_0, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_1, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_2, 'monto_aplicado', 150.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_8, 'monto_aplicado', 150.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_13, 'monto_aplicado', 150.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_16, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_17, 'monto_aplicado', 150.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_81,
            v_socio_81,
            NULL,
            137.70,
            'Efectivo',
            'EXONERACION',
            'Pago histórico recibo N° EXONERACION',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_81_3, 'monto_aplicado', 36.05, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_81_3, 'monto_aplicado', 36.55, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_81_3, 'monto_aplicado', 32.80, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_81_3, 'monto_aplicado', 32.30, 'cubierto_completo', false)),
            0.00,
            '2026-03-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_81,
            v_socio_81,
            NULL,
            137.70,
            'Efectivo',
            '32740',
            'Pago histórico recibo N° 32740',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_81_4, 'monto_aplicado', 36.05, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_9, 'monto_aplicado', 36.55, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_3, 'monto_aplicado', 32.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_18, 'monto_aplicado', 32.30, 'cubierto_completo', true)),
            0.00,
            '2026-03-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_81,
            v_socio_81,
            NULL,
            27.00,
            'Efectivo',
            '32741',
            'Pago histórico recibo N° 32741',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_81_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_10, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_14, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_19, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_81,
            v_socio_81,
            NULL,
            503.20,
            'Efectivo',
            '33094',
            'Pago histórico recibo N° 33094',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_81_20, 'monto_aplicado', 67.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_21, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_22, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_23, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_24, 'monto_aplicado', 150.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_25, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_26, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_81_27, 'monto_aplicado', 150.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-20 12:00:00-05', created_at = '2026-05-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-20 12:00:00-05', created_at = '2026-05-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: LOPEZ HUAYHUALLA NELLY NATIVIDAD (Puesto: 169, ID: 82)
    -- =========================================================================
    DECLARE
        v_socio_82 bigint := 82;
        v_puesto_82 bigint := 264;
        v_m_id_82_0 bigint;
        v_m_id_82_1 bigint;
        v_m_id_82_2 bigint;
        v_m_id_82_3 bigint;
        v_m_id_82_4 bigint;
        v_m_id_82_5 bigint;
        v_m_id_82_6 bigint;
        v_m_id_82_7 bigint;
        v_m_id_82_8 bigint;
        v_m_id_82_9 bigint;
        v_m_id_82_10 bigint;
        v_m_id_82_11 bigint;
        v_m_id_82_12 bigint;
        v_m_id_82_13 bigint;
        v_m_id_82_14 bigint;
        v_m_id_82_15 bigint;
        v_m_id_82_16 bigint;
        v_m_id_82_17 bigint;
        v_m_id_82_18 bigint;
        v_m_id_82_19 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_82 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_82 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_82;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_82 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_82;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 1, 2025, 11, 15.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_82_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_82_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 1, 2025, 12, 10.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_82_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_82_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_82_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_82_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 1, 2026, 1, 8.20, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_82_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 2, 2026, 1, 8.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_82_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_82_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_82_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 1, 2026, 2, 11.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_82_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 2, 2026, 2, 15.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_82_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_82_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_82_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 1, 2026, 3, 13.20, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_82_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 2, 2026, 3, 15.90, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_82_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_82_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_82_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 2, 2026, 4, 15.90, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_82_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_82, 1, 2026, 4, 17.20, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_82_19;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_82,
            v_socio_82,
            NULL,
            37.80,
            'Efectivo',
            '32392',
            'Pago histórico recibo N° 32392',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_82_0, 'monto_aplicado', 15.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_82_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_82_2, 'monto_aplicado', 10.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_82_3, 'monto_aplicado', 6.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-22 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-22 12:00:00-05', created_at = '2026-01-22 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-22 12:00:00-05', created_at = '2026-01-22 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_82,
            v_socio_82,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_82_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_82_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_82,
            v_socio_82,
            NULL,
            42.60,
            'Efectivo',
            '32700',
            'Pago histórico recibo N° 32700',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_82_6, 'monto_aplicado', 8.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_82_7, 'monto_aplicado', 8.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_82_10, 'monto_aplicado', 11.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_82_11, 'monto_aplicado', 15.40, 'cubierto_completo', true)),
            0.00,
            '2026-03-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_82,
            v_socio_82,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_82_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_82_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_82,
            v_socio_82,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_82_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_82_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_82,
            v_socio_82,
            NULL,
            62.20,
            'Efectivo',
            '33129',
            'Pago histórico recibo N° 33129',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_82_14, 'monto_aplicado', 13.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_82_15, 'monto_aplicado', 15.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_82_18, 'monto_aplicado', 15.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_82_19, 'monto_aplicado', 17.20, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_82,
            v_socio_82,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_82_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_82_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: LUJAN GONZALES MARINO JUAN (Puesto: 178, ID: 83)
    -- =========================================================================
    DECLARE
        v_socio_83 bigint := 83;
        v_puesto_83 bigint := 272;
        v_m_id_83_0 bigint;
        v_m_id_83_1 bigint;
        v_m_id_83_2 bigint;
        v_m_id_83_3 bigint;
        v_m_id_83_4 bigint;
        v_m_id_83_5 bigint;
        v_m_id_83_6 bigint;
        v_m_id_83_7 bigint;
        v_m_id_83_8 bigint;
        v_m_id_83_9 bigint;
        v_m_id_83_10 bigint;
        v_m_id_83_11 bigint;
        v_m_id_83_12 bigint;
        v_m_id_83_13 bigint;
        v_m_id_83_14 bigint;
        v_m_id_83_15 bigint;
        v_m_id_83_16 bigint;
        v_m_id_83_17 bigint;
        v_m_id_83_18 bigint;
        v_m_id_83_19 bigint;
        v_m_id_83_20 bigint;
        v_m_id_83_21 bigint;
        v_m_id_83_22 bigint;
        v_m_id_83_23 bigint;
        v_m_id_83_24 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_83 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_83 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_83;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_83 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_83;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 1, 2025, 11, 105.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_83_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 2, 2025, 11, 19.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_83_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_83_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_83_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_83_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_83_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 1, 2025, 12, 100.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_83_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 2, 2025, 12, 20.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_83_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_83_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_83_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_83_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 1, 2026, 1, 96.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_83_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 2, 2026, 1, 22.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_83_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_83_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 1, 2026, 2, 96.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_83_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 2, 2026, 2, 21.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_83_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_83_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_83_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_83_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_83_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 1, 2026, 3, 117.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_83_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 2, 2026, 3, 32.80, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_83_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_83_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_83_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_83, 18, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - FUMIGACION', v_user_uuid)
        RETURNING id INTO v_m_id_83_24;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_83,
            v_socio_83,
            NULL,
            124.60,
            'Efectivo',
            '32332',
            'Pago histórico recibo N° 32332',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_83_0, 'monto_aplicado', 105.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_1, 'monto_aplicado', 19.50, 'cubierto_completo', true)),
            0.00,
            '2026-01-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-14 12:00:00-05', created_at = '2026-01-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_83,
            v_socio_83,
            NULL,
            205.00,
            'Efectivo',
            '32457',
            'Pago histórico recibo N° 32457',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_83_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_5, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_8, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_10, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-04 12:00:00-05', created_at = '2026-02-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_83,
            v_socio_83,
            NULL,
            269.40,
            'Efectivo',
            '32577',
            'Pago histórico recibo N° 32577',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_83_6, 'monto_aplicado', 100.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_7, 'monto_aplicado', 20.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_11, 'monto_aplicado', 96.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_12, 'monto_aplicado', 22.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_13, 'monto_aplicado', 28.30, 'cubierto_completo', true)),
            0.00,
            '2026-02-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_83,
            v_socio_83,
            NULL,
            117.90,
            'Efectivo',
            '32934',
            'Pago histórico recibo N° 32934',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_83_14, 'monto_aplicado', 96.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_15, 'monto_aplicado', 21.40, 'cubierto_completo', true)),
            0.00,
            '2026-04-09 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-09 12:00:00-05', created_at = '2026-04-09 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-09 12:00:00-05', created_at = '2026-04-09 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_83,
            v_socio_83,
            NULL,
            126.00,
            'Efectivo',
            '32936',
            'Pago histórico recibo N° 32936',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_83_16, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_17, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-10 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-10 12:00:00-05', created_at = '2026-04-10 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-10 12:00:00-05', created_at = '2026-04-10 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_83,
            v_socio_83,
            NULL,
            219.90,
            'Efectivo',
            '33098',
            'Pago histórico recibo N° 33098',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_83_20, 'monto_aplicado', 117.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_21, 'monto_aplicado', 32.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_22, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_23, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_83_24, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-21 12:00:00-05', created_at = '2026-05-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-21 12:00:00-05', created_at = '2026-05-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: MALLQUI JULCA ALEJANDRINO TEODORO (Puesto: 192, ID: 84)
    -- =========================================================================
    DECLARE
        v_socio_84 bigint := 84;
        v_puesto_84 bigint := 286;
        v_m_id_84_0 bigint;
        v_m_id_84_1 bigint;
        v_m_id_84_2 bigint;
        v_m_id_84_3 bigint;
        v_m_id_84_4 bigint;
        v_m_id_84_5 bigint;
        v_m_id_84_6 bigint;
        v_m_id_84_7 bigint;
        v_m_id_84_8 bigint;
        v_m_id_84_9 bigint;
        v_m_id_84_10 bigint;
        v_m_id_84_11 bigint;
        v_m_id_84_12 bigint;
        v_m_id_84_13 bigint;
        v_m_id_84_14 bigint;
        v_m_id_84_15 bigint;
        v_m_id_84_16 bigint;
        v_m_id_84_17 bigint;
        v_m_id_84_18 bigint;
        v_m_id_84_19 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_84 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_84 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_84;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_84 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_84;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 1, 2025, 11, 31.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_84_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 2, 2025, 11, 27.50, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_84_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 1, 2025, 12, 30.70, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_84_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 2, 2025, 12, 28.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_84_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_84_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_84_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 1, 2026, 1, 26.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_84_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 2, 2026, 1, 28.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_84_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_84_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_84_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 1, 2026, 2, 23.90, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_84_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 2, 2026, 2, 28.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_84_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_84_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_84_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 1, 2026, 3, 22.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_84_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 2, 2026, 3, 31.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_84_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_84_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_84_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 1, 2026, 4, 23.60, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_84_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_84, 2, 2026, 4, 31.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_84_19;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_84,
            v_socio_84,
            NULL,
            117.80,
            'Efectivo',
            '32391',
            'Pago histórico recibo N° 32391',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_84_0, 'monto_aplicado', 31.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_84_1, 'monto_aplicado', 27.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_84_2, 'monto_aplicado', 30.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_84_3, 'monto_aplicado', 28.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-22 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-22 12:00:00-05', created_at = '2026-01-22 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-22 12:00:00-05', created_at = '2026-01-22 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_84,
            v_socio_84,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_84_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_84_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_84,
            v_socio_84,
            NULL,
            106.90,
            'Efectivo',
            '32701',
            'Pago histórico recibo N° 32701',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_84_6, 'monto_aplicado', 26.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_84_7, 'monto_aplicado', 28.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_84_10, 'monto_aplicado', 23.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_84_11, 'monto_aplicado', 28.50, 'cubierto_completo', true)),
            0.00,
            '2026-03-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_84,
            v_socio_84,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_84_8, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_84_9, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_84,
            v_socio_84,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_84_12, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_84_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_84,
            v_socio_84,
            NULL,
            108.30,
            'Efectivo',
            '33130',
            'Pago histórico recibo N° 33130',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_84_14, 'monto_aplicado', 22.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_84_15, 'monto_aplicado', 31.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_84_18, 'monto_aplicado', 23.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_84_19, 'monto_aplicado', 31.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_84,
            v_socio_84,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_84_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_84_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: MALLQUI LOPEZ LIZBETH NATIVIDAD (Puesto: 130, ID: 85)
    -- =========================================================================
    DECLARE
        v_socio_85 bigint := 85;
        v_puesto_85 bigint := 225;
        v_m_id_85_0 bigint;
        v_m_id_85_1 bigint;
        v_m_id_85_2 bigint;
        v_m_id_85_3 bigint;
        v_m_id_85_4 bigint;
        v_m_id_85_5 bigint;
        v_m_id_85_6 bigint;
        v_m_id_85_7 bigint;
        v_m_id_85_8 bigint;
        v_m_id_85_9 bigint;
        v_m_id_85_10 bigint;
        v_m_id_85_11 bigint;
        v_m_id_85_12 bigint;
        v_m_id_85_13 bigint;
        v_m_id_85_14 bigint;
        v_m_id_85_15 bigint;
        v_m_id_85_16 bigint;
        v_m_id_85_17 bigint;
        v_m_id_85_18 bigint;
        v_m_id_85_19 bigint;
        v_m_id_85_20 bigint;
        v_m_id_85_21 bigint;
        v_m_id_85_22 bigint;
        v_m_id_85_23 bigint;
        v_m_id_85_24 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_85 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_85 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_85;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_85 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_85;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 1, 2025, 11, 27.80, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_85_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 2, 2025, 11, 28.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_85_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_85_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_85_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 1, 2025, 12, 28.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_85_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 2, 2025, 12, 28.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_85_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_85_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_85_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 1, 2026, 1, 25.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_85_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 2, 2026, 1, 37.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_85_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_85_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_85_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 1, 2026, 2, 37.80, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_85_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 2, 2026, 2, 47.50, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_85_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_85_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_85_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 1, 2026, 3, 34.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_85_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 2, 2026, 3, 38.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_85_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_85_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_85_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 1, 2026, 4, 29.70, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_85_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 2, 2026, 4, 39.90, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_85_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_85_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_85_23;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_85, 18, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - FUMIGACION', v_user_uuid)
        RETURNING id INTO v_m_id_85_24;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_85,
            v_socio_85,
            NULL,
            242.80,
            'Efectivo',
            '32393',
            'Pago histórico recibo N° 32393',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_85_0, 'monto_aplicado', 27.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_1, 'monto_aplicado', 28.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_4, 'monto_aplicado', 28.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_5, 'monto_aplicado', 28.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-22 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-22 12:00:00-05', created_at = '2026-01-22 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-22 12:00:00-05', created_at = '2026-01-22 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_85,
            v_socio_85,
            NULL,
            273.70,
            'Efectivo',
            '32702',
            'Pago histórico recibo N° 32702',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_85_8, 'monto_aplicado', 25.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_9, 'monto_aplicado', 37.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_12, 'monto_aplicado', 37.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_13, 'monto_aplicado', 47.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_14, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-19 12:00:00-05', created_at = '2026-03-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_85,
            v_socio_85,
            NULL,
            276.70,
            'Efectivo',
            '33131',
            'Pago histórico recibo N° 33131',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_85_16, 'monto_aplicado', 34.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_17, 'monto_aplicado', 38.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_19, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_20, 'monto_aplicado', 29.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_21, 'monto_aplicado', 39.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_22, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_23, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_85_24, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-27 12:00:00-05', created_at = '2026-05-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: MAYTA MATOS HERMELINDA (Puesto: 88, ID: 94)
    -- =========================================================================
    DECLARE
        v_socio_94 bigint := 94;
        v_puesto_94 bigint := 184;
        v_m_id_94_0 bigint;
        v_m_id_94_1 bigint;
        v_m_id_94_2 bigint;
        v_m_id_94_3 bigint;
        v_m_id_94_4 bigint;
        v_m_id_94_5 bigint;
        v_m_id_94_6 bigint;
        v_m_id_94_7 bigint;
        v_m_id_94_8 bigint;
        v_m_id_94_9 bigint;
        v_m_id_94_10 bigint;
        v_m_id_94_11 bigint;
        v_m_id_94_12 bigint;
        v_m_id_94_13 bigint;
        v_m_id_94_14 bigint;
        v_m_id_94_15 bigint;
        v_m_id_94_16 bigint;
        v_m_id_94_17 bigint;
        v_m_id_94_18 bigint;
        v_m_id_94_19 bigint;
        v_m_id_94_20 bigint;
        v_m_id_94_21 bigint;
        v_m_id_94_22 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_94 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_94 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_94;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_94 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_94;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 1, 2025, 11, 47.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_94_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 2, 2025, 11, 101.60, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_94_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 3, 2025, 11, 58.20, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_94_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 1, 2025, 12, 50.60, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_94_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 2, 2025, 12, 86.50, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_94_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_94_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_94_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 1, 2026, 1, 44.70, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_94_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 2, 2026, 1, 93.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_94_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_94_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_94_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_94_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 1, 2026, 2, 45.10, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_94_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 2, 2026, 2, 109.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_94_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_94_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_94_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 1, 2026, 3, 49.40, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_94_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 2, 2026, 3, 123.50, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_94_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_94_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_94_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_94_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_94_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_94, 18, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - FUMIGACION', v_user_uuid)
        RETURNING id INTO v_m_id_94_22;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_94,
            v_socio_94,
            NULL,
            100.00,
            'Efectivo',
            '32341',
            'Pago histórico recibo N° 32341',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_94_0, 'monto_aplicado', 47.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_1, 'monto_aplicado', 53.00, 'cubierto_completo', false)),
            0.00,
            '2026-01-15 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-15 12:00:00-05', created_at = '2026-01-15 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_94,
            v_socio_94,
            NULL,
            100.00,
            'Efectivo',
            '32366',
            'Pago histórico recibo N° 32366',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_94_1, 'monto_aplicado', 41.80, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_94_2, 'monto_aplicado', 58.20, 'cubierto_completo', true)),
            0.00,
            '2026-01-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-20 12:00:00-05', created_at = '2026-01-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_94,
            v_socio_94,
            NULL,
            100.00,
            'Efectivo',
            '32382',
            'Pago histórico recibo N° 32382',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_94_1, 'monto_aplicado', 6.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_3, 'monto_aplicado', 50.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_4, 'monto_aplicado', 42.60, 'cubierto_completo', false)),
            0.00,
            '2026-01-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_94,
            v_socio_94,
            NULL,
            108.90,
            'Efectivo',
            '32533',
            'Pago histórico recibo N° 32533',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_94_4, 'monto_aplicado', 43.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_5, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_6, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-18 12:00:00-05', created_at = '2026-02-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_94,
            v_socio_94,
            NULL,
            200.00,
            'Efectivo',
            '32782',
            'Pago histórico recibo N° 32782',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_94_7, 'monto_aplicado', 44.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_8, 'monto_aplicado', 93.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_9, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_10, 'monto_aplicado', 2.30, 'cubierto_completo', false)),
            0.00,
            '2026-03-23 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_94,
            v_socio_94,
            NULL,
            228.00,
            'Efectivo',
            '32841',
            'Pago histórico recibo N° 32841',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_94_10, 'monto_aplicado', 2.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_11, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_12, 'monto_aplicado', 45.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_13, 'monto_aplicado', 109.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_14, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_94,
            v_socio_94,
            NULL,
            150.00,
            'Efectivo',
            '33009',
            'Pago histórico recibo N° 33009',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_94_16, 'monto_aplicado', 49.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_17, 'monto_aplicado', 100.60, 'cubierto_completo', false)),
            0.00,
            '2026-05-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_94,
            v_socio_94,
            NULL,
            157.90,
            'Efectivo',
            '33059',
            'Pago histórico recibo N° 33059',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_94_17, 'monto_aplicado', 22.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_19, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_21, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_94_22, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-12 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-12 12:00:00-05', created_at = '2026-05-12 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-12 12:00:00-05', created_at = '2026-05-12 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: MORENO CHAVEZ RAFAEL FREDY (Puesto: 83, ID: 100)
    -- =========================================================================
    DECLARE
        v_socio_100 bigint := 100;
        v_puesto_100 bigint := 179;
        v_m_id_100_0 bigint;
        v_m_id_100_1 bigint;
        v_m_id_100_2 bigint;
        v_m_id_100_3 bigint;
        v_m_id_100_4 bigint;
        v_m_id_100_5 bigint;
        v_m_id_100_6 bigint;
        v_m_id_100_7 bigint;
        v_m_id_100_8 bigint;
        v_m_id_100_9 bigint;
        v_m_id_100_10 bigint;
        v_m_id_100_11 bigint;
        v_m_id_100_12 bigint;
        v_m_id_100_13 bigint;
        v_m_id_100_14 bigint;
        v_m_id_100_15 bigint;
        v_m_id_100_16 bigint;
        v_m_id_100_17 bigint;
        v_m_id_100_18 bigint;
        v_m_id_100_19 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_100 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_100 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_100;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_100 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_100;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 1, 2025, 11, 56.40, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_100_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_100_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_100_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_100_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 1, 2025, 12, 49.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_100_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_100_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_100_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_100_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 1, 2026, 1, 48.60, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_100_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_100_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_100_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_100_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_100_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_100_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 1, 2026, 2, 47.60, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_100_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_100_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 1, 2026, 3, 46.10, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_100_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_100_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_100_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_100, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_100_19;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_100,
            v_socio_100,
            NULL,
            127.40,
            'Efectivo',
            '32304',
            'Pago histórico recibo N° 32304',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_100_0, 'monto_aplicado', 56.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_100_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_100_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_100_3, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-08 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-08 12:00:00-05', created_at = '2026-01-08 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-08 12:00:00-05', created_at = '2026-01-08 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_100,
            v_socio_100,
            NULL,
            120.90,
            'Efectivo',
            '32495',
            'Pago histórico recibo N° 32495',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_100_4, 'monto_aplicado', 49.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_100_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_100_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_100_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-11 12:00:00-05', created_at = '2026-02-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_100,
            v_socio_100,
            NULL,
            179.60,
            'Efectivo',
            '32691',
            'Pago histórico recibo N° 32691',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_100_8, 'monto_aplicado', 48.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_100_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_100_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_100_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_100_12, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_100_13, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-18 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-18 12:00:00-05', created_at = '2026-03-18 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_100,
            v_socio_100,
            NULL,
            57.60,
            'Efectivo',
            '32739',
            'Pago histórico recibo N° 32739',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_100_14, 'monto_aplicado', 47.60, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_100_15, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-21 12:00:00-05', created_at = '2026-03-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_100,
            v_socio_100,
            NULL,
            117.10,
            'Efectivo',
            '33003',
            'Pago histórico recibo N° 33003',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_100_16, 'monto_aplicado', 46.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_100_17, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_100_18, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_100_19, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-04 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-04 12:00:00-05', created_at = '2026-05-04 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-04 12:00:00-05', created_at = '2026-05-04 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: MARIN HUAMAN DE SALAMANCA MARIA YNES (Puesto: 31, ID: 86)
    -- =========================================================================
    DECLARE
        v_socio_86 bigint := 86;
        v_puesto_86 bigint := 98;
        v_m_id_86_0 bigint;
        v_m_id_86_1 bigint;
        v_m_id_86_2 bigint;
        v_m_id_86_3 bigint;
        v_m_id_86_4 bigint;
        v_m_id_86_5 bigint;
        v_m_id_86_6 bigint;
        v_m_id_86_7 bigint;
        v_m_id_86_8 bigint;
        v_m_id_86_9 bigint;
        v_m_id_86_10 bigint;
        v_m_id_86_11 bigint;
        v_m_id_86_12 bigint;
        v_m_id_86_13 bigint;
        v_m_id_86_14 bigint;
        v_m_id_86_15 bigint;
        v_m_id_86_16 bigint;
        v_m_id_86_17 bigint;
        v_m_id_86_18 bigint;
        v_m_id_86_19 bigint;
        v_m_id_86_20 bigint;
        v_m_id_86_21 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_86 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_86 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_86;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_86 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_86;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 1, 2025, 11, 72.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_86_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_86_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_86_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_86_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 1, 2025, 12, 73.10, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_86_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_86_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_86_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_86_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 1, 2026, 1, 76.50, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_86_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_86_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_86_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_86_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 1, 2026, 2, 75.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_86_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_86_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_86_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_86_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_86_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_86_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 1, 2026, 3, 78.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_86_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_86_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_86_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_86, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_86_21;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_86,
            v_socio_86,
            NULL,
            287.10,
            'Efectivo',
            '32363',
            'Pago histórico recibo N° 32363',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_86_0, 'monto_aplicado', 72.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_86_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_86_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_86_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_86_4, 'monto_aplicado', 73.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_86_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_86_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_86_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-19 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-19 12:00:00-05', created_at = '2026-01-19 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-19 12:00:00-05', created_at = '2026-01-19 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_86,
            v_socio_86,
            NULL,
            146.50,
            'Efectivo',
            '32580',
            'Pago histórico recibo N° 32580',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_86_8, 'monto_aplicado', 76.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_86_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_86_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_86_11, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-27 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_86,
            v_socio_86,
            NULL,
            96.40,
            'Efectivo',
            '32866',
            'Pago histórico recibo N° 32866',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_86_12, 'monto_aplicado', 75.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_86_13, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_86_14, 'monto_aplicado', 6.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_86_15, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_86,
            v_socio_86,
            NULL,
            50.00,
            'Efectivo',
            '32867',
            'Pago histórico recibo N° 32867',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_86_14, 'monto_aplicado', 50.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_86,
            v_socio_86,
            NULL,
            65.00,
            'Efectivo',
            '32943',
            'Pago histórico recibo N° 32943',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_86_16, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_86_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-14 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-14 12:00:00-05', created_at = '2026-04-14 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-14 12:00:00-05', created_at = '2026-04-14 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_86,
            v_socio_86,
            NULL,
            149.30,
            'Efectivo',
            '33008',
            'Pago histórico recibo N° 33008',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_86_18, 'monto_aplicado', 78.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_86_19, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_86_20, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_86_21, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-05 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-05 12:00:00-05', created_at = '2026-05-05 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: HUAMAN YNCA VISITACION (Puesto: 140, ID: 71)
    -- =========================================================================
    DECLARE
        v_socio_71 bigint := 71;
        v_puesto_71 bigint := 235;
        v_m_id_71_0 bigint;
        v_m_id_71_1 bigint;
        v_m_id_71_2 bigint;
        v_m_id_71_3 bigint;
        v_m_id_71_4 bigint;
        v_m_id_71_5 bigint;
        v_m_id_71_6 bigint;
        v_m_id_71_7 bigint;
        v_m_id_71_8 bigint;
        v_m_id_71_9 bigint;
        v_m_id_71_10 bigint;
        v_m_id_71_11 bigint;
        v_m_id_71_12 bigint;
        v_m_id_71_13 bigint;
        v_m_id_71_14 bigint;
        v_m_id_71_15 bigint;
        v_m_id_71_16 bigint;
        v_m_id_71_17 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_71 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_71 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_71;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_71 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_71;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 1, 2025, 11, 30.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_71_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_71_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_71_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_71_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 1, 2025, 12, 24.30, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_71_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_71_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_71_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_71_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 1, 2026, 1, 19.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_71_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_71_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_71_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_71_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_71_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - MULTA X CAPACITACION', v_user_uuid)
        RETURNING id INTO v_m_id_71_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 1, 2026, 2, 20.70, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_71_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_71_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_71_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_71, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_71_17;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_71,
            v_socio_71,
            NULL,
            100.00,
            'Efectivo',
            '32383',
            'Pago histórico recibo N° 32383',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_71_0, 'monto_aplicado', 30.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_71_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_71_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_71_3, 'monto_aplicado', 3.90, 'cubierto_completo', false)),
            0.00,
            '2026-01-21 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-21 12:00:00-05', created_at = '2026-01-21 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_71,
            v_socio_71,
            NULL,
            100.00,
            'Efectivo',
            '32662',
            'Pago histórico recibo N° 32662',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_71_3, 'monto_aplicado', 1.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_71_4, 'monto_aplicado', 24.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_71_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_71_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_71_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_71_8, 'monto_aplicado', 3.60, 'cubierto_completo', false)),
            0.00,
            '2026-03-11 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_71,
            v_socio_71,
            NULL,
            15.40,
            'Efectivo',
            '32847',
            'Pago histórico recibo N° 32847',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_71_8, 'monto_aplicado', 15.40, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_71,
            v_socio_71,
            NULL,
            200.00,
            'Efectivo',
            '32846',
            'Pago histórico recibo N° 32846',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_71_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_71_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_71_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_71_12, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_71_13, 'monto_aplicado', 28.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_71_14, 'monto_aplicado', 20.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_71_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_71_16, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_71_17, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: ISIDRO MARIN CARLOS DANIEL (Puesto: 96, ID: 75)
    -- =========================================================================
    DECLARE
        v_socio_75 bigint := 75;
        v_puesto_75 bigint := 191;
        v_m_id_75_0 bigint;
        v_m_id_75_1 bigint;
        v_m_id_75_2 bigint;
        v_m_id_75_3 bigint;
        v_m_id_75_4 bigint;
        v_m_id_75_5 bigint;
        v_m_id_75_6 bigint;
        v_m_id_75_7 bigint;
        v_m_id_75_8 bigint;
        v_m_id_75_9 bigint;
        v_m_id_75_10 bigint;
        v_m_id_75_11 bigint;
        v_m_id_75_12 bigint;
        v_m_id_75_13 bigint;
        v_m_id_75_14 bigint;
        v_m_id_75_15 bigint;
        v_m_id_75_16 bigint;
        v_m_id_75_17 bigint;
        v_m_id_75_18 bigint;
        v_m_id_75_19 bigint;
        v_m_id_75_20 bigint;
        v_m_id_75_21 bigint;
        v_m_id_75_22 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_75 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_75 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_75;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_75 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_75;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 18, 2026, 8, 15.00, 'Pendiente', 'Manual', '2026-08-01', 'Migración de pagos 2026 - TALONARIO SANTA ROSA', v_user_uuid)
        RETURNING id INTO v_m_id_75_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 1, 2025, 11, 74.10, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_75_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 2, 2025, 11, 120.80, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_75_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 18, 2025, 12, 107.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - PROCESOS LEGALES', v_user_uuid)
        RETURNING id INTO v_m_id_75_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 1, 2025, 12, 65.20, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_75_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 2, 2025, 12, 103.80, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_75_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_75_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_75_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 1, 2026, 1, 36.90, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_75_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 2, 2026, 1, 75.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_75_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_75_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_75_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_75_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 1, 2026, 2, 46.20, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_75_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 2, 2026, 2, 151.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_75_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_75_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_75_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 1, 2026, 3, 53.30, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_75_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 2, 2026, 3, 151.70, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_75_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_75_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_75_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 1, 2026, 4, 62.40, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_75_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_75, 2, 2026, 4, 137.70, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_75_22;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_75,
            v_socio_75,
            NULL,
            15.00,
            'Efectivo',
            '32230',
            'Pago histórico recibo N° 32230',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_75_0, 'monto_aplicado', 15.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_75,
            v_socio_75,
            NULL,
            194.90,
            'Efectivo',
            '32300',
            'Pago histórico recibo N° 32300',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_75_1, 'monto_aplicado', 74.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_75_2, 'monto_aplicado', 120.80, 'cubierto_completo', true)),
            0.00,
            '2026-01-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_75,
            v_socio_75,
            NULL,
            107.00,
            'Efectivo',
            '32301',
            'Pago histórico recibo N° 32301',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_75_3, 'monto_aplicado', 107.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-07 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_75,
            v_socio_75,
            NULL,
            290.90,
            'Efectivo',
            '32642',
            'Pago histórico recibo N° 32642',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_75_4, 'monto_aplicado', 65.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_75_5, 'monto_aplicado', 103.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_75_8, 'monto_aplicado', 36.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_75_9, 'monto_aplicado', 75.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_75_10, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-10 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-10 12:00:00-05', created_at = '2026-03-10 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-10 12:00:00-05', created_at = '2026-03-10 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_75,
            v_socio_75,
            NULL,
            32.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_75_6, 'monto_aplicado', 32.00, 'cubierto_completo', false)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_75,
            v_socio_75,
            NULL,
            33.00,
            'Efectivo',
            '32478',
            'Pago histórico recibo N° 32478',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_75_6, 'monto_aplicado', 28.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_75_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-06 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-06 12:00:00-05', created_at = '2026-02-06 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-06 12:00:00-05', created_at = '2026-02-06 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_75,
            v_socio_75,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_75_11, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_75_12, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_75,
            v_socio_75,
            NULL,
            197.60,
            'Efectivo',
            '32728',
            'Pago histórico recibo N° 32728',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_75_13, 'monto_aplicado', 46.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_75_14, 'monto_aplicado', 151.40, 'cubierto_completo', true)),
            0.00,
            '2026-03-20 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-20 12:00:00-05', created_at = '2026-03-20 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_75,
            v_socio_75,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_75_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_75_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_75,
            v_socio_75,
            NULL,
            405.10,
            'Efectivo',
            '33110',
            'Pago histórico recibo N° 33110',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_75_17, 'monto_aplicado', 53.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_75_18, 'monto_aplicado', 151.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_75_21, 'monto_aplicado', 62.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_75_22, 'monto_aplicado', 137.70, 'cubierto_completo', true)),
            0.00,
            '2026-05-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-25 12:00:00-05', created_at = '2026-05-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_75,
            v_socio_75,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_75_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_75_20, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: MARIN LONDONE EDUARDO SANTIAGO (Puesto: 176, ID: 87)
    -- =========================================================================
    DECLARE
        v_socio_87 bigint := 87;
        v_puesto_87 bigint := 270;
        v_m_id_87_0 bigint;
        v_m_id_87_1 bigint;
        v_m_id_87_2 bigint;
        v_m_id_87_3 bigint;
        v_m_id_87_4 bigint;
        v_m_id_87_5 bigint;
        v_m_id_87_6 bigint;
        v_m_id_87_7 bigint;
        v_m_id_87_8 bigint;
        v_m_id_87_9 bigint;
        v_m_id_87_10 bigint;
        v_m_id_87_11 bigint;
        v_m_id_87_12 bigint;
        v_m_id_87_13 bigint;
        v_m_id_87_14 bigint;
        v_m_id_87_15 bigint;
        v_m_id_87_16 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_87 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_87 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_87;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_87 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_87;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_87, 1, 2025, 11, 34.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_87_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_87, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_87_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_87, 1, 2025, 12, 38.80, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_87_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_87, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_87_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_87, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_87_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_87, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_87_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_87, 1, 2026, 1, 38.40, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_87_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_87, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_87_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_87, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_87_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_87, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_87_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_87, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_87_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_87, 1, 2026, 2, 25.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_87_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_87, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_87_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_87, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_87_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_87, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_87_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_87, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_87_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_87, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_87_16;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_87,
            v_socio_87,
            NULL,
            138.20,
            'Efectivo',
            '32638',
            'Pago histórico recibo N° 32638',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_87_0, 'monto_aplicado', 34.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_87_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_87_2, 'monto_aplicado', 38.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_87_3, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_87_6, 'monto_aplicado', 38.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_87_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_87_8, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-09 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-09 12:00:00-05', created_at = '2026-03-09 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-09 12:00:00-05', created_at = '2026-03-09 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_87,
            v_socio_87,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ENE',
            'Pago mensual vía tarjeta - TARJETA-ENE',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_87_4, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_87_5, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_87,
            v_socio_87,
            NULL,
            61.00,
            'Transferencia',
            'TARJETA-FEB',
            'Pago mensual vía tarjeta - TARJETA-FEB',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_87_9, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_87_10, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_87,
            v_socio_87,
            NULL,
            35.40,
            'Efectivo',
            '32915',
            'Pago histórico recibo N° 32915',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_87_11, 'monto_aplicado', 25.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_87_12, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-25 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_87,
            v_socio_87,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-MAR',
            'Pago mensual vía tarjeta - TARJETA-MAR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_87_13, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_87_14, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-31 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-31 12:00:00-05', created_at = '2026-03-31 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_87,
            v_socio_87,
            NULL,
            65.00,
            'Transferencia',
            'TARJETA-ABR',
            'Pago mensual vía tarjeta - TARJETA-ABR',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_87_15, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_87_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-30 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-30 12:00:00-05', created_at = '2026-04-30 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: MARIN LONDONE MARIA LUZ (Puesto: 81, ID: 88)
    -- =========================================================================
    DECLARE
        v_socio_88 bigint := 88;
        v_puesto_88 bigint := 177;
        v_m_id_88_0 bigint;
        v_m_id_88_1 bigint;
        v_m_id_88_2 bigint;
        v_m_id_88_3 bigint;
        v_m_id_88_4 bigint;
        v_m_id_88_5 bigint;
        v_m_id_88_6 bigint;
        v_m_id_88_7 bigint;
        v_m_id_88_8 bigint;
        v_m_id_88_9 bigint;
        v_m_id_88_10 bigint;
        v_m_id_88_11 bigint;
        v_m_id_88_12 bigint;
        v_m_id_88_13 bigint;
        v_m_id_88_14 bigint;
        v_m_id_88_15 bigint;
        v_m_id_88_16 bigint;
        v_m_id_88_17 bigint;
        v_m_id_88_18 bigint;
        v_m_id_88_19 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_88 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_88 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_88;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_88 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_88;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 18, 2025, 11, 200.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - DEPOSITO N° 8 Y 9 1PISO', v_user_uuid)
        RETURNING id INTO v_m_id_88_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 1, 2025, 11, 44.80, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_88_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 2, 2025, 11, 11.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_88_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 3, 2025, 11, 41.70, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_88_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 1, 2025, 12, 23.90, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_88_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_88_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 3, 2025, 12, 40.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_88_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_88_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 18, 2025, 12, 200.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - DEPOSITO N° 8 Y 9 1PISO', v_user_uuid)
        RETURNING id INTO v_m_id_88_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 1, 2026, 1, 19.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_88_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_88_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_88_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_88_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 18, 2026, 1, 210.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - DEPOSITO N° 8 Y 9 1PISO', v_user_uuid)
        RETURNING id INTO v_m_id_88_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 1, 2026, 2, 22.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_88_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_88_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_88_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_88_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 18, 2026, 2, 200.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - DEPOSITO N° 8 Y 9 1PISO', v_user_uuid)
        RETURNING id INTO v_m_id_88_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_88, 18, 2026, 3, 100.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - DEPOSITO N° 8 Y 9 1PISO', v_user_uuid)
        RETURNING id INTO v_m_id_88_19;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_88,
            v_socio_88,
            NULL,
            100.00,
            'Efectivo',
            '32429',
            'Pago histórico recibo N° 32429',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_88_0, 'monto_aplicado', 100.00, 'cubierto_completo', false)),
            0.00,
            '2026-01-28 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-28 12:00:00-05', created_at = '2026-01-28 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_88,
            v_socio_88,
            NULL,
            74.20,
            'Efectivo',
            '32861',
            'Pago histórico recibo N° 32861',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_88_1, 'monto_aplicado', 26.50, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_88_2, 'monto_aplicado', 6.00, 'cubierto_completo', false), jsonb_build_object('monto_id', v_m_id_88_3, 'monto_aplicado', 41.70, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_88,
            v_socio_88,
            NULL,
            300.00,
            'Efectivo',
            '32923',
            'Pago histórico recibo N° 32923',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_88_1, 'monto_aplicado', 18.30, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_88_2, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_88_0, 'monto_aplicado', 100.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_88_4, 'monto_aplicado', 23.90, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_88_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_88_6, 'monto_aplicado', 40.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_88_7, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_88_8, 'monto_aplicado', 101.80, 'cubierto_completo', false)),
            0.00,
            '2026-03-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-26 12:00:00-05', created_at = '2026-03-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-26 12:00:00-05', created_at = '2026-03-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_88,
            v_socio_88,
            NULL,
            300.00,
            'Efectivo',
            '32924',
            'Pago histórico recibo N° 32924',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_88_8, 'monto_aplicado', 98.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_88_9, 'monto_aplicado', 19.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_88_10, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_88_11, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_88_12, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_88_13, 'monto_aplicado', 112.80, 'cubierto_completo', false)),
            0.00,
            '2026-03-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-26 12:00:00-05', created_at = '2026-03-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-26 12:00:00-05', created_at = '2026-03-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_88,
            v_socio_88,
            NULL,
            390.20,
            'Efectivo',
            '32944',
            'Pago histórico recibo N° 32944',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_88_13, 'monto_aplicado', 97.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_88_14, 'monto_aplicado', 22.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_88_15, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_88_16, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_88_17, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_88_18, 'monto_aplicado', 200.00, 'cubierto_completo', true)),
            0.00,
            '2026-04-16 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-04-16 12:00:00-05', created_at = '2026-04-16 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-04-16 12:00:00-05', created_at = '2026-04-16 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_88,
            v_socio_88,
            NULL,
            100.00,
            'Efectivo',
            '33071',
            'Pago histórico recibo N° 33071',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_88_19, 'monto_aplicado', 100.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    -- =========================================================================
    -- SOCIO: MEDINA GUTIERREZ HONORATA (Puesto: 174, ID: 95)
    -- =========================================================================
    DECLARE
        v_socio_95 bigint := 95;
        v_puesto_95 bigint := 268;
        v_m_id_95_0 bigint;
        v_m_id_95_1 bigint;
        v_m_id_95_2 bigint;
        v_m_id_95_3 bigint;
        v_m_id_95_4 bigint;
        v_m_id_95_5 bigint;
        v_m_id_95_6 bigint;
        v_m_id_95_7 bigint;
        v_m_id_95_8 bigint;
        v_m_id_95_9 bigint;
        v_m_id_95_10 bigint;
        v_m_id_95_11 bigint;
        v_m_id_95_12 bigint;
        v_m_id_95_13 bigint;
        v_m_id_95_14 bigint;
        v_m_id_95_15 bigint;
        v_m_id_95_16 bigint;
        v_m_id_95_17 bigint;
        v_m_id_95_18 bigint;
        v_m_id_95_19 bigint;
        v_m_id_95_20 bigint;
        v_m_id_95_21 bigint;
        v_m_id_95_22 bigint;
        v_m_id_95_23 bigint;
    BEGIN
        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades
        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = v_puesto_95 AND concepto_id = 32 AND deleted_at IS NULL;
        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_95 AND periodo_anio >= 2025);
        DELETE FROM public.pagos WHERE puesto_id = v_puesto_95;
        DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_95 AND periodo_anio >= 2025;
        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_95;

        -- 2. Generar deudas agrupadas únicas
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 1, 2025, 11, 4.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_95_0;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 2, 2025, 11, 6.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_95_1;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_95_2;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', '2025-11-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_95_3;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 1, 2025, 12, 4.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_95_4;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 2, 2025, 12, 6.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_95_5;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_95_6;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', '2025-12-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_95_7;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 1, 2026, 1, 4.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_95_8;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_95_9;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 3, 2026, 1, 60.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_95_10;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 4, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_95_11;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-01', 'Migración de pagos 2026 - P.S X FALL. FLORES FLORES UMBELINA', v_user_uuid)
        RETURNING id INTO v_m_id_95_12;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 1, 2026, 2, 5.40, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_95_13;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_95_14;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_95_15;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', '2026-02-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_95_16;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 1, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - LUZ', v_user_uuid)
        RETURNING id INTO v_m_id_95_17;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - AGUA', v_user_uuid)
        RETURNING id INTO v_m_id_95_18;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_95_19;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_95_20;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - G. ADM', v_user_uuid)
        RETURNING id INTO v_m_id_95_21;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - P. SOCIAL', v_user_uuid)
        RETURNING id INTO v_m_id_95_22;
        v_cant_deudas := v_cant_deudas + 1;
        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES (v_puesto_95, 18, 2026, 4, 5.00, 'Pendiente', 'Manual', '2026-04-01', 'Migración de pagos 2026 - FUMIGACION', v_user_uuid)
        RETURNING id INTO v_m_id_95_23;
        v_cant_deudas := v_cant_deudas + 1;

        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
        v_pago_res := public.rpc_procesar_pago(
            v_puesto_95,
            v_socio_95,
            NULL,
            150.00,
            'Efectivo',
            '32403',
            'Pago histórico recibo N° 32403',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_95_0, 'monto_aplicado', 4.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_1, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_2, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_3, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_4, 'monto_aplicado', 4.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_5, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_6, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_7, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-01-26 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_95,
            v_socio_95,
            NULL,
            84.00,
            'Efectivo',
            '32520',
            'Pago histórico recibo N° 32520',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_95_8, 'monto_aplicado', 4.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_9, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_10, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_11, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_12, 'monto_aplicado', 10.00, 'cubierto_completo', true)),
            0.00,
            '2026-02-17 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-02-17 12:00:00-05', created_at = '2026-02-17 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-17 12:00:00-05', created_at = '2026-02-17 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_95,
            v_socio_95,
            NULL,
            76.40,
            'Efectivo',
            '32880',
            'Pago histórico recibo N° 32880',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_95_13, 'monto_aplicado', 5.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_14, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_15, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_16, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-03-24 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

        v_pago_res := public.rpc_procesar_pago(
            v_puesto_95,
            v_socio_95,
            NULL,
            146.00,
            'Efectivo',
            '33068',
            'Pago histórico recibo N° 33068',
            v_user_uuid,
            jsonb_build_array(jsonb_build_object('monto_id', v_m_id_95_17, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_18, 'monto_aplicado', 6.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_19, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_20, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_21, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_22, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_m_id_95_23, 'monto_aplicado', 5.00, 'cubierto_completo', true)),
            0.00,
            '2026-05-13 12:00:00-05'
        );
        v_pago_id := (v_pago_res->>'pago_id')::bigint;
        UPDATE public.pagos SET fecha_pago = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE id = v_pago_id;
        UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-05-13 12:00:00-05', created_at = '2026-05-13 12:00:00-05' WHERE pago_id = v_pago_id;
        v_cant_pagos := v_cant_pagos + 1;

    END;

    RAISE NOTICE '==================================================';
    RAISE NOTICE 'PROCESO DE MIGRACIÓN C-Q 2026 COMPLETADO CON ÉXITO';
    RAISE NOTICE '  Deudas individuales creadas: %', v_cant_deudas;
    RAISE NOTICE '  Pagos agrupados procesados:  %', v_cant_pagos;
    RAISE NOTICE '==================================================';
END $$;