-- =============================================================================
-- Migración 00074: Carga de pagos consolidados de Junio 2026
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- Generado: 2026-06-18 desde scripts/generar_migracion_pagos_junio.js
-- Fuente: migracion_coop/junio/SOCIOS - CONSOLIDADO PAGOS JUNIO 2026.xlsx (hoja "Pagos detalle junio")
-- Recibos: 97 | Líneas: 327 | Monto total: S/ 20384.90
-- GARCIA LUCIA excluida explícitamente.
-- Las deudas se resuelven dinámicamente: si no existen al momento de aplicar este
-- archivo se crean en Pendiente (requiere que la migración 00073 ya se haya aplicado
-- para los cargos de Mayo 2026, dado el orden secuencial de migraciones).
-- =============================================================================

BEGIN;

DO $$
DECLARE
    v_user_uuid uuid;
BEGIN
    SELECT id INTO v_user_uuid FROM public.perfiles WHERE rol = 'Administrador' AND activo = true LIMIT 1;
    IF v_user_uuid IS NULL THEN
        v_user_uuid := '00000000-0000-0000-0000-000000000000';
    END IF;
    PERFORM set_config('request.jwt.claims', json_build_object('sub', v_user_uuid::text, 'role', 'authenticated')::text, true);

    -- ===== Recibo 33158 — TITO JESUSA (2026-06-01 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33158' AND puesto_id = 200 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (164, 200, '2026-06-01 12:00:00-05', 294.10, 'Efectivo', '33158', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33158' AND puesto_id = 200 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33158 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 229.20
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 200 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (200, 1, 2026, 4, 229.20, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 229.20, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 64.90
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 200 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (200, 2, 2026, 4, 64.90, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 64.90, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33160 — PALOMINO EUSEBIO (2026-06-01 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33160' AND puesto_id = 242 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (112, 242, '2026-06-01 12:00:00-05', 652.10, 'Efectivo', '33160', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33160' AND puesto_id = 242 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33160 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 614.80
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 242 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (242, 1, 2026, 4, 614.80, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 614.80, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 37.30
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 242 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (242, 2, 2026, 4, 37.30, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 37.30, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33161 — MAYTA VIOLETA (2026-06-01 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33161' AND puesto_id = 253 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (93, 253, '2026-06-01 12:00:00-05', 44.30, 'Efectivo', '33161', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33161' AND puesto_id = 253 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33161 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 28.50
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 253 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (253, 1, 2026, 4, 28.50, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 28.50, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 15.80
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 253 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (253, 2, 2026, 4, 15.80, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 15.80, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33162 — CALLE ALVAREZ MARCO (2026-06-01 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33162' AND puesto_id = 244 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (24, 244, '2026-06-01 12:00:00-05', 200.00, 'Efectivo', '33162', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33162' AND puesto_id = 244 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33162 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- DEPOSITO (Deposito) periodo 4/2026 — S/ 200.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 56 AND concepto_id = 16 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (56, 16, 2026, 4, 200.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (DEPOSITO)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 200.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33163 — SALAS JUDITH (2026-06-01 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33163' AND puesto_id = 110 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (145, 110, '2026-06-01 12:00:00-05', 5.00, 'Efectivo', '33163', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33163' AND puesto_id = 110 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33163 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- FUMIGACION (Otros) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 110 AND concepto_id = 18 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (110, 18, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (FUMIGACION)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33159 — ATANASIO MAXIMILIANA (2026-06-02 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33159' AND puesto_id = 273 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (10, 273, '2026-06-02 12:00:00-05', 107.90, 'Efectivo', '33159', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33159' AND puesto_id = 273 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33159 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 30.70
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 273 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (273, 1, 2026, 3, 30.70, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 30.70, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 15.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 273 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (273, 2, 2026, 3, 15.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 15.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 4/2026 — S/ 47.20
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 273 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (273, 1, 2026, 4, 47.20, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 47.20, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 15.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 273 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (273, 2, 2026, 4, 15.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 15.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33164 — SERMEÑO JAVIER (2026-06-02 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33164' AND puesto_id = 76 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (154, 76, '2026-06-02 12:00:00-05', 405.00, 'Efectivo', '33164', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33164' AND puesto_id = 76 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33164 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 390.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 76 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (76, 1, 2026, 4, 390.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 390.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 15.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 76 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (76, 2, 2026, 4, 15.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 15.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33166 — VICENTE JOSE (2026-06-02 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33166' AND puesto_id = 255 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (178, 255, '2026-06-02 12:00:00-05', 91.40, 'Efectivo', '33166', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33166' AND puesto_id = 255 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33166 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 20.40
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 255 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (255, 1, 2026, 3, 20.40, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 20.40, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 255 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (255, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 3/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 255 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (255, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 3/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 255 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (255, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33167 — LAGOS ZAIDA (2026-06-02 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33167' AND puesto_id = 86 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (80, 86, '2026-06-02 12:00:00-05', 87.00, 'Efectivo', '33167', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33167' AND puesto_id = 86 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33167 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 45.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 86 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (86, 1, 2026, 3, 45.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 45.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 86 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (86, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 4/2026 — S/ 30.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 86 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (86, 1, 2026, 4, 30.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 30.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 86 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (86, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33168 — CERDA CARMEN (2026-06-02 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33168' AND puesto_id = 198 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (40, 198, '2026-06-02 12:00:00-05', 31.50, 'Efectivo', '33168', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33168' AND puesto_id = 198 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33168 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 25.50
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 198 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (198, 1, 2026, 4, 25.50, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 25.50, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 198 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (198, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33169 — ALVAREZ CAMPOS ROLANDO (2026-06-02 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33169' AND puesto_id = 170 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (5, 170, '2026-06-02 12:00:00-05', 200.00, 'Efectivo', '33169', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33169' AND puesto_id = 170 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33169 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 26.60
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 170 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (170, 1, 2026, 3, 26.60, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 26.60, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 170 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (170, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- DEPOSITO (Deposito) periodo 3/2026 — S/ 100.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 17 AND concepto_id = 16 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (17, 16, 2026, 3, 100.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (DEPOSITO)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 100.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 4/2026 — S/ 40.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 170 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (170, 1, 2026, 4, 40.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 40.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 170 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (170, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 21.40
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 170 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (170, 3, 2026, 4, 21.40, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 21.40, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33171 — CARPIO TEOFILA (2026-06-02 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33171' AND puesto_id = 277 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (28, 277, '2026-06-02 12:00:00-05', 10.00, 'Efectivo', '33171', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33171' AND puesto_id = 277 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33171 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 5/2026 — S/ 10.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 277 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (277, 1, 2026, 5, 20.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 10.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33173 — ROJAS LIONILA (2026-06-03 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33173' AND puesto_id = 116 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (140, 116, '2026-06-03 12:00:00-05', 75.10, 'Efectivo', '33173', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33173' AND puesto_id = 116 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33173 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 69.10
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 116 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (116, 1, 2026, 3, 69.10, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 69.10, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 116 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (116, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33174 — SALVATIERRA ALLISON (2026-06-03 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33174' AND puesto_id = 243 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (148, 243, '2026-06-03 12:00:00-05', 341.00, 'Efectivo', '33174', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33174' AND puesto_id = 243 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33174 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 76.90
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 243 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (243, 1, 2026, 4, 76.90, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 76.90, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 264.10
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 243 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (243, 2, 2026, 4, 264.10, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 264.10, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33175 — HUAMAN YNCA VISITACION (2026-06-03 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33175' AND puesto_id = 235 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (71, 235, '2026-06-03 12:00:00-05', 100.00, 'Efectivo', '33175', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33175' AND puesto_id = 235 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33175 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 19.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 235 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (235, 1, 2026, 3, 19.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 19.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 235 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (235, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 3/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 235 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (235, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 3/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 235 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (235, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 4/2026 — S/ 10.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 235 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (235, 1, 2026, 4, 10.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 10.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33176 — ANAMPA CLEMENCIA (2026-06-03 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33176' AND puesto_id = 154 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (8, 154, '2026-06-03 12:00:00-05', 79.80, 'Efectivo', '33176', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33176' AND puesto_id = 154 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33176 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 73.80
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 154 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (154, 1, 2026, 3, 73.80, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 73.80, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 154 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (154, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33177 — SALAS JUDITH (2026-06-03 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33177' AND puesto_id = 110 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (145, 110, '2026-06-03 12:00:00-05', 95.00, 'Efectivo', '33177', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33177' AND puesto_id = 110 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33177 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 95.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 110 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (110, 1, 2026, 4, 95.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 95.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33178 — QUISPE COPAYO ELIO (2026-06-03 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33178' AND puesto_id = 209 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (125, 209, '2026-06-03 12:00:00-05', 1040.80, 'Efectivo', '33178', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33178' AND puesto_id = 209 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33178 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 1011.70
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 209 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (209, 1, 2026, 4, 1011.70, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 1011.70, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 29.10
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 209 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (209, 2, 2026, 4, 29.10, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 29.10, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33179 — REYES MILENA (2026-06-03 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33179' AND puesto_id = 215 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (132, 215, '2026-06-03 12:00:00-05', 1406.90, 'Efectivo', '33179', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33179' AND puesto_id = 215 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33179 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 1256.20
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 215 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (215, 1, 2026, 4, 1256.20, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 1256.20, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 20.70
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 215 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (215, 2, 2026, 4, 20.70, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 20.70, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 215 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (215, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 215 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (215, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 215 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (215, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 215 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (215, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33180 — PEREZ EPIFANIA (2026-06-03 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33180' AND puesto_id = 114 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (117, 114, '2026-06-03 12:00:00-05', 84.50, 'Efectivo', '33180', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33180' AND puesto_id = 114 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33180 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 39.50
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 114 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (114, 1, 2026, 3, 39.50, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 39.50, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 114 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (114, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 4/2026 — S/ 33.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 114 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (114, 1, 2026, 4, 33.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 33.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 114 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (114, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33181 — PEREZ EPIFANIA (2026-06-03 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33181' AND puesto_id = 114 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (117, 114, '2026-06-03 12:00:00-05', 65.00, 'Efectivo', '33181', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33181' AND puesto_id = 114 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33181 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- G. ADM (Gastos administrativos) periodo 3/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 114 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (114, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 3/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 114 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (114, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33182 — BRAVO ANA (2026-06-03 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33182' AND puesto_id = 161 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (16, 161, '2026-06-03 12:00:00-05', 259.00, 'Efectivo', '33182', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33182' AND puesto_id = 161 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33182 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 118.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 161 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (161, 1, 2026, 4, 118.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 118.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 161 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (161, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 161 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (161, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 161 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (161, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- FUMIGACION (Otros) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 161 AND concepto_id = 18 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (161, 18, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (FUMIGACION)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 161 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (161, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 161 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (161, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33183 — ANCCO VALENTINA (2026-06-03 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33183' AND puesto_id = 130 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (9, 130, '2026-06-03 12:00:00-05', 196.00, 'Efectivo', '33183', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33183' AND puesto_id = 130 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33183 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 27.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 130 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (130, 1, 2026, 3, 27.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 27.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 130 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (130, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 3/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 130 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (130, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 3/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 130 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (130, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 4/2026 — S/ 27.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 130 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (130, 1, 2026, 4, 27.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 27.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 130 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (130, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 130 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (130, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 130 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (130, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33184 — HEREDIA MARIA (2026-06-03 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33184' AND puesto_id = 245 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (70, 245, '2026-06-03 12:00:00-05', 98.70, 'Efectivo', '33184', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33184' AND puesto_id = 245 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33184 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 8.10
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 245 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (245, 1, 2026, 3, 8.10, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 8.10, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 245 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (245, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 4/2026 — S/ 8.60
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 245 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (245, 1, 2026, 4, 8.60, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 8.60, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 245 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (245, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 16.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 245 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (245, 3, 2026, 4, 16.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 16.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 245 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (245, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 44.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 245 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (245, 3, 2026, 5, 44.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 44.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 245 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (245, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33185 — BURGA ELIDA (2026-06-03 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33185' AND puesto_id = 66 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (17, 66, '2026-06-03 12:00:00-05', 146.50, 'Efectivo', '33185', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33185' AND puesto_id = 66 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33185 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 2/2026 — S/ 33.90
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 66 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 2 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (66, 1, 2026, 2, 33.90, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 33.90, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 2/2026 — S/ 10.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 66 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 2 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (66, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 10.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 3/2026 — S/ 35.60
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 66 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (66, 1, 2026, 3, 35.60, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 35.60, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 66 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (66, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 4/2026 — S/ 55.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 66 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (66, 1, 2026, 4, 55.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 55.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 66 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (66, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33186 — DAVILA MARISOL (2026-06-03 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33186' AND puesto_id = 148 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (54, 148, '2026-06-03 12:00:00-05', 200.00, 'Efectivo', '33186', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33186' AND puesto_id = 148 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33186 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- DEPOSITO N° 7 (Alquiler) periodo 5/2026 — S/ 200.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 44 AND concepto_id = 11 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (44, 11, 2026, 5, 200.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (DEPOSITO N° 7)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 200.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33187 — BERNAOLA FLORENCIA (2026-06-03 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33187' AND puesto_id = 261 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (15, 261, '2026-06-03 12:00:00-05', 239.10, 'Efectivo', '33187', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33187' AND puesto_id = 261 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33187 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 140.40
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 261 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (261, 1, 2026, 4, 140.40, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 140.40, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 98.70
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 261 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (261, 2, 2026, 4, 98.70, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 98.70, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33188 — CAJALEON LUIS (2026-06-03 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33188' AND puesto_id = 173 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (21, 173, '2026-06-03 12:00:00-05', 100.00, 'Efectivo', '33188', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33188' AND puesto_id = 173 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33188 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 50.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 173 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (173, 1, 2026, 3, 50.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 50.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 173 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (173, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 3/2026 — S/ 44.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 173 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (173, 3, 2026, 3, 44.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 44.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33189 — SALAZAR VICTORIA (2026-06-04 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33189' AND puesto_id = 197 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (147, 197, '2026-06-04 12:00:00-05', 19.00, 'Efectivo', '33189', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33189' AND puesto_id = 197 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33189 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 13.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 197 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (197, 1, 2026, 4, 13.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 13.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 197 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (197, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33190 — SALAZAR VICTORIA (2026-06-04 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33190' AND puesto_id = 197 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (147, 197, '2026-06-04 12:00:00-05', 65.00, 'Efectivo', '33190', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33190' AND puesto_id = 197 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33190 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 197 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (197, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 197 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (197, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33191 — BERNAOLA FLORENCIA (2026-06-04 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33191' AND puesto_id = 261 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (15, 261, '2026-06-04 12:00:00-05', 65.00, 'Efectivo', '33191', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33191' AND puesto_id = 261 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33191 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 261 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (261, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 261 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (261, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33193 — ORDOÑEZ AZUL (2026-06-04 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33193' AND puesto_id = 276 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (107, 276, '2026-06-04 12:00:00-05', 433.00, 'Efectivo', '33193', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33193' AND puesto_id = 276 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33193 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 108.40
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 276 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (276, 1, 2026, 3, 108.40, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 108.40, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 276 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (276, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 3/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 276 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (276, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 3/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 276 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (276, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 4/2026 — S/ 117.60
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 276 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (276, 1, 2026, 4, 117.60, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 117.60, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 276 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (276, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 276 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (276, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 276 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (276, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 276 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (276, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 276 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (276, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33194 — CARPIO TEOFILA (2026-06-04 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33194' AND puesto_id = 277 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (28, 277, '2026-06-04 12:00:00-05', 10.00, 'Efectivo', '33194', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33194' AND puesto_id = 277 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33194 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 5/2026 — S/ 10.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 277 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (277, 1, 2026, 5, 20.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 10.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33195 — CCOYLLO POLANCO DANIEL (2026-06-04 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33195' AND puesto_id = 212 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (38, 212, '2026-06-04 12:00:00-05', 459.40, 'Efectivo', '33195', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33195' AND puesto_id = 212 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33195 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 388.40
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 212 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (212, 1, 2026, 4, 388.40, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 388.40, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 212 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (212, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 212 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (212, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 212 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (212, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33196 — REYES NANCY (2026-06-04 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33196' AND puesto_id = 222 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (131, 222, '2026-06-04 12:00:00-05', 255.50, 'Efectivo', '33196', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33196' AND puesto_id = 222 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33196 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 235.50
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 222 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (222, 1, 2026, 4, 235.50, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 235.50, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 15.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 222 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (222, 2, 2026, 4, 15.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 15.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- FUMIGACION (Otros) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 222 AND concepto_id = 18 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (222, 18, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (FUMIGACION)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33197 — PITTMAN NELLY (2026-06-04 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33197' AND puesto_id = 102 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (118, 102, '2026-06-04 12:00:00-05', 51.00, 'Efectivo', '33197', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33197' AND puesto_id = 102 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33197 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 45.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 102 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (102, 1, 2026, 4, 45.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 45.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 102 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (102, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33198 — VARA ERNESTINA(F) (2026-06-04 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33198' AND puesto_id = 216 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (176, 216, '2026-06-04 12:00:00-05', 200.00, 'Efectivo', '33198', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33198' AND puesto_id = 216 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33198 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 2/2026 — S/ 29.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 216 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 2 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (216, 1, 2026, 2, 29.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 29.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 2/2026 — S/ 14.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 216 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 2 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (216, 2, 2026, 2, 14.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 14.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 3/2026 — S/ 30.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 216 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (216, 1, 2026, 3, 30.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 30.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 21.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 216 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (216, 2, 2026, 3, 21.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 21.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 3/2026 — S/ 50.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 216 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (216, 3, 2026, 3, 50.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 50.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 3/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 216 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (216, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 4/2026 — S/ 28.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 216 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (216, 1, 2026, 4, 28.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 28.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 21.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 216 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (216, 2, 2026, 4, 21.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 21.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 2.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 216 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (216, 3, 2026, 4, 2.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 2.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33199 — MORENO FREDY (2026-06-04 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33199' AND puesto_id = 179 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (100, 179, '2026-06-04 12:00:00-05', 118.80, 'Efectivo', '33199', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33199' AND puesto_id = 179 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33199 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 47.80
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 179 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (179, 1, 2026, 4, 47.80, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 47.80, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 179 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (179, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 179 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (179, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 179 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (179, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33200 — HUAYHUALLA DONATILA (2026-06-04 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33200' AND puesto_id = 208 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (74, 208, '2026-06-04 12:00:00-05', 219.60, 'Efectivo', '33200', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33200' AND puesto_id = 208 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33200 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 149.10
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 208 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (208, 1, 2026, 4, 149.10, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 149.10, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 70.50
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 208 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (208, 2, 2026, 4, 70.50, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 70.50, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33201 — TORRES JUANA (2026-06-05 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33201' AND puesto_id = 178 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (168, 178, '2026-06-05 12:00:00-05', 219.70, 'Efectivo', '33201', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33201' AND puesto_id = 178 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33201 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- G. ADM (Gastos administrativos) periodo 2/2026 — S/ 56.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 178 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 2 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (178, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 56.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 3/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 178 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (178, 3, 2026, 3, 78.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 9/2025 — S/ 16.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 178 AND concepto_id = 3 AND periodo_anio = 2025 AND periodo_mes = 9 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (178, 3, 2025, 9, 16.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 16.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 9/2025 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 178 AND concepto_id = 4 AND periodo_anio = 2025 AND periodo_mes = 9 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (178, 4, 2025, 9, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 10/2025 — S/ 12.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 178 AND concepto_id = 3 AND periodo_anio = 2025 AND periodo_mes = 10 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (178, 3, 2025, 10, 12.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 12.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 10/2025 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 178 AND concepto_id = 4 AND periodo_anio = 2025 AND periodo_mes = 10 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (178, 4, 2025, 10, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 11/2025 — S/ 12.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 178 AND concepto_id = 3 AND periodo_anio = 2025 AND periodo_mes = 11 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (178, 3, 2025, 11, 12.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 12.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 11/2025 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 178 AND concepto_id = 4 AND periodo_anio = 2025 AND periodo_mes = 11 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (178, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 3/2026 — S/ 18.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 178 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (178, 3, 2026, 3, 78.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 18.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 3/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 178 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (178, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 4/2026 — S/ 19.70
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 178 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (178, 1, 2026, 4, 19.70, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 19.70, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 178 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (178, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33202 — DELA CRUZ JOSE (2026-06-05 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33202' AND puesto_id = 220 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (55, 220, '2026-06-05 12:00:00-05', 104.30, 'Efectivo', '33202', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33202' AND puesto_id = 220 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33202 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 80.60
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 220 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (220, 1, 2026, 4, 80.60, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 80.60, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 23.70
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 220 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (220, 2, 2026, 4, 23.70, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 23.70, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33203 — CUSI SONIA (2026-06-05 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33203' AND puesto_id = 249 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (52, 249, '2026-06-05 12:00:00-05', 52.30, 'Efectivo', '33203', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33203' AND puesto_id = 249 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33203 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 16.90
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 249 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (249, 1, 2026, 3, 16.90, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 16.90, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 249 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (249, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 4/2026 — S/ 23.40
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 249 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (249, 1, 2026, 4, 23.40, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 23.40, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 249 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (249, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33204 — VALENCIA VICENTE (2026-06-05 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33204' AND puesto_id = 211 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (170, 211, '2026-06-05 12:00:00-05', 534.60, 'Efectivo', '33204', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33204' AND puesto_id = 211 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33204 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 524.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 211 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (211, 1, 2026, 4, 524.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 524.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 10.60
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 211 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (211, 2, 2026, 4, 10.60, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 10.60, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33205 — REYES NANCY (2026-06-05 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33205' AND puesto_id = 222 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (131, 222, '2026-06-05 12:00:00-05', 65.00, 'Efectivo', '33205', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33205' AND puesto_id = 222 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33205 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 222 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (222, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 222 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (222, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33206 — OJEDA EDSON (2026-06-08 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33206' AND puesto_id = 228 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (103, 228, '2026-06-08 12:00:00-05', 746.50, 'Efectivo', '33206', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33206' AND puesto_id = 228 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33206 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 717.20
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 228 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (228, 1, 2026, 4, 717.20, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 717.20, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 29.30
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 228 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (228, 2, 2026, 4, 29.30, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 29.30, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33207 — FLORES FLORES IRENE (2026-06-08 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33207' AND puesto_id = 247 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (60, 247, '2026-06-08 12:00:00-05', 746.80, 'Efectivo', '33207', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33207' AND puesto_id = 247 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33207 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 577.50
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 247 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (247, 1, 2026, 4, 577.50, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 577.50, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 104.30
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 247 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (247, 2, 2026, 4, 104.30, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 104.30, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 247 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (247, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 247 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (247, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33208 — TELLO EDGAR (2026-06-08 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33208' AND puesto_id = 182 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (161, 182, '2026-06-08 12:00:00-05', 392.90, 'Efectivo', '33208', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33208' AND puesto_id = 182 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33208 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 154.20
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 182 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (182, 1, 2026, 3, 154.20, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 154.20, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 173.70
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 182 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (182, 2, 2026, 3, 173.70, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 173.70, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 3/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 182 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (182, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 3/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 182 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (182, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33209 — CASTRO AQUILA (2026-06-08 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33209' AND puesto_id = 72 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (33, 72, '2026-06-08 12:00:00-05', 294.00, 'Efectivo', '33209', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33209' AND puesto_id = 72 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33209 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 280.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 72 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (72, 1, 2026, 4, 280.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 280.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 14.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 72 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (72, 2, 2026, 4, 14.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 14.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33210 — ESPEJO ROSA (2026-06-08 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33210' AND puesto_id = 106 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (56, 106, '2026-06-08 12:00:00-05', 235.00, 'Efectivo', '33210', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33210' AND puesto_id = 106 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33210 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 99.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 106 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (106, 1, 2026, 4, 99.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 99.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 106 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (106, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 106 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (106, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 106 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (106, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 106 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (106, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 106 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (106, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33211 — PAREDES FLORES OSCAR (2026-06-08 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33211' AND puesto_id = 140 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (113, 140, '2026-06-08 12:00:00-05', 155.00, 'Efectivo', '33211', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33211' AND puesto_id = 140 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33211 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 149.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 140 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (140, 1, 2026, 3, 149.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 149.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 140 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (140, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33212 — AYALA ELISEO (2026-06-08 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33212' AND puesto_id = 55 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (12, 55, '2026-06-08 12:00:00-05', 246.00, 'Efectivo', '33212', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33212' AND puesto_id = 55 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33212 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 25.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 55 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (55, 1, 2026, 4, 25.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 25.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 55 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (55, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 55 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (55, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 55 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (55, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- DEPOSITO N° 1 3PISO (Alquiler) periodo 5/2026 — S/ 150.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 4 AND concepto_id = 11 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (4, 11, 2026, 5, 150.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (DEPOSITO N° 1 3PISO)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 150.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33213 — AYALA HUASHUAYO NORMA (2026-06-08 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33213' AND puesto_id = 60 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (11, 60, '2026-06-08 12:00:00-05', 91.00, 'Efectivo', '33213', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33213' AND puesto_id = 60 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33213 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 20.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 60 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (60, 1, 2026, 4, 20.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 20.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 60 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (60, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 60 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (60, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 60 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (60, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33214 — HUASHUAYO EUDOSIA (2026-06-08 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33214' AND puesto_id = 52 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (73, 52, '2026-06-08 12:00:00-05', 350.00, 'Efectivo', '33214', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33214' AND puesto_id = 52 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33214 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 79.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 52 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (52, 1, 2026, 4, 79.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 79.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 52 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (52, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 52 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (52, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 52 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (52, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- DEPOSITO N° 2 (Alquiler) periodo 5/2026 — S/ 200.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 10 AND concepto_id = 11 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (10, 11, 2026, 5, 200.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (DEPOSITO N° 2)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 200.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33215 — BERNAOLA FLORENCIA (2026-06-09 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33215' AND puesto_id = 261 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (15, 261, '2026-06-09 12:00:00-05', 65.00, 'Efectivo', '33215', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33215' AND puesto_id = 261 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33215 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 261 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (261, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 261 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (261, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33216 — RICSE TERESA (2026-06-09 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33216' AND puesto_id = 231 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (133, 231, '2026-06-09 12:00:00-05', 63.00, 'Efectivo', '33216', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33216' AND puesto_id = 231 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33216 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 49.20
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 231 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (231, 1, 2026, 4, 49.20, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 49.20, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 8.90
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 231 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (231, 2, 2026, 4, 8.90, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 8.90, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- FUMIGACION (Otros) periodo 4/2026 — S/ 4.90
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 231 AND concepto_id = 18 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (231, 18, 2026, 4, 4.90, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (FUMIGACION)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 4.90, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33217 — DAVILA MARISOL (2026-06-09 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33217' AND puesto_id = 148 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (54, 148, '2026-06-09 12:00:00-05', 130.00, 'Efectivo', '33217', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33217' AND puesto_id = 148 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33217 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- G. ADM (Gastos administrativos) periodo 3/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 148 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (148, 3, 2026, 3, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 3/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 148 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (148, 4, 2026, 3, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 148 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (148, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 148 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (148, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33218 — SANCHEZ JUDITH (2026-06-09 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33218' AND puesto_id = 284 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (150, 284, '2026-06-09 12:00:00-05', 94.80, 'Efectivo', '33218', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33218' AND puesto_id = 284 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33218 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 47.10
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 284 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (284, 1, 2026, 3, 47.10, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 47.10, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 47.70
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 284 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (284, 2, 2026, 3, 47.70, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 47.70, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33219 — VICENTE JOSE (2026-06-10 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33219' AND puesto_id = 255 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (178, 255, '2026-06-10 12:00:00-05', 96.40, 'Efectivo', '33219', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33219' AND puesto_id = 255 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33219 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 25.40
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 255 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (255, 1, 2026, 4, 25.40, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 25.40, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 255 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (255, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 255 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (255, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 255 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (255, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33220 — ZAPATA ROSANA (2026-06-10 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33220' AND puesto_id = 236 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (184, 236, '2026-06-10 12:00:00-05', 65.00, 'Efectivo', '33220', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33220' AND puesto_id = 236 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33220 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 236 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (236, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 236 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (236, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33221 — NICHO  ESTHEPANY (2026-06-10 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33221' AND puesto_id = 239 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (101, 239, '2026-06-10 12:00:00-05', 566.10, 'Efectivo', '33221', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33221' AND puesto_id = 239 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33221 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 433.30
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 239 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (239, 1, 2026, 4, 433.30, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 433.30, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 67.80
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 239 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (239, 2, 2026, 4, 67.80, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 67.80, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 239 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (239, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 239 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (239, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33222 — PAREDES FLORES OSCAR (2026-06-10 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33222' AND puesto_id = 140 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (113, 140, '2026-06-10 12:00:00-05', 65.00, 'Efectivo', '33222', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33222' AND puesto_id = 140 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33222 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 140 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (140, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 140 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (140, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33223 — PACOMPIA GIOVANNI (2026-06-10 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33223' AND puesto_id = 94 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (109, 94, '2026-06-10 12:00:00-05', 65.00, 'Efectivo', '33223', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33223' AND puesto_id = 94 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33223 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 94 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (94, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 94 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (94, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33224 — CARDEÑA ALEJANDRINA (2026-06-10 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33224' AND puesto_id = 62 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (27, 62, '2026-06-10 12:00:00-05', 65.00, 'Efectivo', '33224', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33224' AND puesto_id = 62 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33224 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 62 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (62, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 62 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (62, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33225 — CARDEÑA ALEJANDRINA (2026-06-10 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33225' AND puesto_id = 62 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (27, 62, '2026-06-10 12:00:00-05', 11.00, 'Efectivo', '33225', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33225' AND puesto_id = 62 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33225 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 62 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (62, 1, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 62 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (62, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33226 — SALAS JUDITH (2026-06-10 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33226' AND puesto_id = 110 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (145, 110, '2026-06-10 12:00:00-05', 231.20, 'Efectivo', '33226', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33226' AND puesto_id = 110 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33226 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- AGUA (Agua) periodo 4/2026 — S/ 231.20
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 110 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (110, 2, 2026, 4, 231.20, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 231.20, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33227 — JUAREZ LEONOR (2026-06-10 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33227' AND puesto_id = 128 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (79, 128, '2026-06-10 12:00:00-05', 396.80, 'Efectivo', '33227', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33227' AND puesto_id = 128 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33227 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 135.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 128 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (128, 1, 2026, 4, 135.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 135.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 196.80
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 128 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (128, 2, 2026, 4, 196.80, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 196.80, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 128 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (128, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 128 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (128, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33228 — GUTIERREZ ROGER (2026-06-10 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33228' AND puesto_id = 112 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (68, 112, '2026-06-10 12:00:00-05', 427.40, 'Efectivo', '33228', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33228' AND puesto_id = 112 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33228 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 117.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 112 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (112, 1, 2026, 4, 117.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 117.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 180.40
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 112 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (112, 2, 2026, 4, 180.40, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 180.40, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 112 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (112, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 112 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (112, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 112 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (112, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 112 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (112, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33229 — ALARCON NANCY (2026-06-10 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33229' AND puesto_id = 152 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (3, 152, '2026-06-10 12:00:00-05', 58.30, 'Efectivo', '33229', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33229' AND puesto_id = 152 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33229 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 47.30
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 152 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (152, 1, 2026, 3, 47.30, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 47.30, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 152 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (152, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- FUMIGACION (Otros) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 152 AND concepto_id = 18 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (152, 18, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (FUMIGACION)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33230 — FALCON HECTOR (2026-06-10 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33230' AND puesto_id = 64 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (59, 64, '2026-06-10 12:00:00-05', 276.70, 'Efectivo', '33230', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33230' AND puesto_id = 64 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33230 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 1/2026 — S/ 49.20
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 64 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 1 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (64, 1, 2026, 1, 49.20, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 49.20, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 1/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 64 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 1 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (64, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 2/2026 — S/ 48.50
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 64 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 2 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (64, 1, 2026, 2, 48.50, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 48.50, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 2/2026 — S/ 10.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 64 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 2 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (64, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 10.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 3/2026 — S/ 50.50
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 64 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (64, 1, 2026, 3, 50.50, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 50.50, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 64 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (64, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- MULTA 26/03/2026 (Multa) periodo 3/2026 — S/ 56.50
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE socio_id = 59 AND concepto_id = 6 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (59, 6, 2026, 3, 56.50, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (MULTA 26/03/2026)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 56.50, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 4/2026 — S/ 45.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 64 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (64, 1, 2026, 4, 45.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 45.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 64 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (64, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33231 — BURGA ELIDA (2026-06-10 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33231' AND puesto_id = 66 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (17, 66, '2026-06-10 12:00:00-05', 107.00, 'Efectivo', '33231', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33231' AND puesto_id = 66 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33231 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- G. ADM (Gastos administrativos) periodo 11/2025 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 66 AND concepto_id = 3 AND periodo_anio = 2025 AND periodo_mes = 11 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (66, 3, 2025, 11, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 11/2025 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 66 AND concepto_id = 4 AND periodo_anio = 2025 AND periodo_mes = 11 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (66, 4, 2025, 11, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 12/2025 — S/ 42.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 66 AND concepto_id = 3 AND periodo_anio = 2025 AND periodo_mes = 12 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (66, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 42.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33232 — BURGA ELIDA (2026-06-10 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33232' AND puesto_id = 66 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (17, 66, '2026-06-10 12:00:00-05', 84.00, 'Efectivo', '33232', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33232' AND puesto_id = 66 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33232 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- G. ADM (Gastos administrativos) periodo 12/2025 — S/ 18.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 66 AND concepto_id = 3 AND periodo_anio = 2025 AND periodo_mes = 12 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (66, 3, 2025, 12, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 18.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 12/2025 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 66 AND concepto_id = 4 AND periodo_anio = 2025 AND periodo_mes = 12 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (66, 4, 2025, 12, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 2/2026 — S/ 56.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 66 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 2 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (66, 3, 2026, 2, 56.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 56.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 2/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 66 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 2 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (66, 4, 2026, 2, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33233 — CABERO GLORIA (2026-06-10 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33233' AND puesto_id = 108 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (19, 108, '2026-06-10 12:00:00-05', 120.00, 'Efectivo', '33233', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33233' AND puesto_id = 108 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33233 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 28.40
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 108 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (108, 1, 2026, 3, 28.40, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 28.40, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 108 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (108, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- DEPOSITO N° 8 (Alquiler) periodo 3/2026 — S/ 49.60
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 49 AND concepto_id = 11 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (49, 11, 2026, 3, 49.60, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (DEPOSITO N° 8)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 49.60, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 4/2026 — S/ 30.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 108 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (108, 1, 2026, 4, 30.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 30.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 108 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (108, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33234 — MEDINA JUAN CARLOS (2026-06-11 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33234' AND puesto_id = 238 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (97, 238, '2026-06-11 12:00:00-05', 130.00, 'Efectivo', '33234', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33234' AND puesto_id = 238 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33234 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 238 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (238, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 238 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (238, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 238 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (238, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 238 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (238, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33235 — PLAZA ROSA (2026-06-11 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33235' AND puesto_id = 233 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (119, 233, '2026-06-11 12:00:00-05', 146.00, 'Efectivo', '33235', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33235' AND puesto_id = 233 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33235 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 233 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (233, 1, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 233 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (233, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 233 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (233, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 233 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (233, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- FUMIGACION (Otros) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 233 AND concepto_id = 18 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (233, 18, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (FUMIGACION)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 233 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (233, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 233 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (233, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33236 — SAAVEDRA LUIS (2026-06-11 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33236' AND puesto_id = 120 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (144, 120, '2026-06-11 12:00:00-05', 40.00, 'Efectivo', '33236', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33236' AND puesto_id = 120 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33236 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 35.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 120 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (120, 1, 2026, 4, 35.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 35.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 120 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (120, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33237 — SAAVEDRA LUIS (2026-06-11 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33237' AND puesto_id = 120 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (144, 120, '2026-06-11 12:00:00-05', 115.00, 'Efectivo', '33237', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33237' AND puesto_id = 120 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33237 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- AGUA (Agua) periodo 4/2026 — S/ 1.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 120 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (120, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 1.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 52.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 120 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (120, 3, 2026, 4, 52.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 52.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 120 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (120, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 52.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 120 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (120, 3, 2026, 5, 52.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 52.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 120 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (120, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33239 — TORRES JUANA (2026-06-11 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33239' AND puesto_id = 178 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (168, 178, '2026-06-11 12:00:00-05', 90.00, 'Efectivo', '33239', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33239' AND puesto_id = 178 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33239 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- PAGO EXTRAORDINARIO PARA ARBITRIOS MUNICIPALES (Aporte extraordinario) periodo 7/2025 — S/ 90.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE socio_id = 168 AND concepto_id = 7 AND periodo_anio = 2025 AND periodo_mes = 7 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (168, 7, 2025, 7, 250.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (PAGO EXTRAORDINARIO PARA ARBITRIOS MUNICIPALES)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 90.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33240 — TORRES JUANA (2026-06-11 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33240' AND puesto_id = 178 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (168, 178, '2026-06-11 12:00:00-05', 160.00, 'Efectivo', '33240', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33240' AND puesto_id = 178 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33240 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- PAGO EXTRAORDINARIO PARA ARBITRIOS MUNICIPALES (Aporte extraordinario) periodo 7/2025 — S/ 160.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE socio_id = 168 AND concepto_id = 7 AND periodo_anio = 2025 AND periodo_mes = 7 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (168, 7, 2025, 7, 250.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (PAGO EXTRAORDINARIO PARA ARBITRIOS MUNICIPALES)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 160.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33241 — FLORES FLORES UMBELINA (2026-06-11 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33241' AND puesto_id = 258 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (61, 258, '2026-06-11 12:00:00-05', 250.50, 'Efectivo', '33241', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33241' AND puesto_id = 258 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33241 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 250.50
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 258 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (258, 1, 2026, 4, 258.90, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 250.50, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33242 — VILCHEZ LOURDES (2026-06-11 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33242' AND puesto_id = 187 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (179, 187, '2026-06-11 12:00:00-05', 1079.60, 'Efectivo', '33242', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33242' AND puesto_id = 187 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33242 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 799.40
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 187 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (187, 1, 2026, 4, 799.40, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 799.40, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 80.20
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 187 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (187, 2, 2026, 4, 80.20, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 80.20, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- DEPOSITO N° 5 (Alquiler) periodo 4/2026 — S/ 200.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 43 AND concepto_id = 11 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (43, 11, 2026, 4, 200.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (DEPOSITO N° 5)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 200.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33243 — TORRES JUANA (2026-06-11 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33243' AND puesto_id = 178 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (168, 178, '2026-06-11 12:00:00-05', 10.00, 'Efectivo', '33243', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33243' AND puesto_id = 178 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33243 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- P.S X FALL. MANUEL RIOS (Fallecimiento de socio) periodo 9/2025 — S/ 10.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE socio_id = 168 AND concepto_id = 19 AND periodo_anio = 2025 AND periodo_mes = 9 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (168, 19, 2025, 9, 10.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P.S X FALL. MANUEL RIOS)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 10.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33244 — VALERO WILLY (2026-06-12 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33244' AND puesto_id = 80 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (173, 80, '2026-06-12 12:00:00-05', 142.80, 'Efectivo', '33244', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33244' AND puesto_id = 80 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33244 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 136.80
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 80 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (80, 1, 2026, 4, 136.80, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 136.80, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 80 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (80, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33246 — TORRES NERY(F) (2026-06-12 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33246' AND puesto_id = 232 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (167, 232, '2026-06-12 12:00:00-05', 45.10, 'Efectivo', '33246', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33246' AND puesto_id = 232 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33246 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 3/2026 — S/ 9.50
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 232 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (232, 1, 2026, 3, 9.50, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 9.50, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 35.60
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 232 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (232, 2, 2026, 3, 35.60, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 35.60, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33247 — CHUCHULLO JOSE (2026-06-12 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33247' AND puesto_id = 164 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (44, 164, '2026-06-12 12:00:00-05', 189.00, 'Efectivo', '33247', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33247' AND puesto_id = 164 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33247 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 33.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 164 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (164, 1, 2026, 4, 33.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 33.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 164 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (164, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- DEPOSITO N° 2 3PISO (Alquiler) periodo 4/2026 — S/ 150.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 11 AND concepto_id = 11 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (11, 11, 2026, 4, 150.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (DEPOSITO N° 2 3PISO)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 150.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33248 — CUEVAS ENRIQUE (2026-06-12 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33248' AND puesto_id = 168 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (50, 168, '2026-06-12 12:00:00-05', 185.00, 'Efectivo', '33248', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33248' AND puesto_id = 168 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33248 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 49.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 168 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (168, 1, 2026, 4, 49.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 49.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 168 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (168, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 168 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (168, 3, 2026, 4, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 168 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (168, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 168 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (168, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 168 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (168, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33249 — URETA EMILIA (2026-06-12 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33249' AND puesto_id = 48 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (169, 48, '2026-06-12 12:00:00-05', 179.80, 'Efectivo', '33249', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33249' AND puesto_id = 48 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33249 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 85.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 48 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (48, 1, 2026, 4, 85.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 85.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 29.80
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 48 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (48, 2, 2026, 4, 29.80, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 29.80, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 48 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (48, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 48 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (48, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33250 — QUISPE ROSA (2026-06-12 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33250' AND puesto_id = 269 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (128, 269, '2026-06-12 12:00:00-05', 494.70, 'Efectivo', '33250', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33250' AND puesto_id = 269 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33250 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 484.70
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 269 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (269, 1, 2026, 4, 484.70, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 484.70, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 10.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 269 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (269, 2, 2026, 4, 10.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 10.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33251 — ALHUAY JUANA (2026-06-12 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33251' AND puesto_id = 275 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (4, 275, '2026-06-12 12:00:00-05', 65.00, 'Efectivo', '33251', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33251' AND puesto_id = 275 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33251 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 60.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 275 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (275, 3, 2026, 5, 60.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 60.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 275 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (275, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33252 — TINEO CABRERA SONIA (2026-06-12 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33252' AND puesto_id = 207 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (162, 207, '2026-06-12 12:00:00-05', 49.80, 'Efectivo', '33252', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33252' AND puesto_id = 207 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33252 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 33.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 207 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (207, 1, 2026, 4, 33.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 33.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 16.80
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 207 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (207, 2, 2026, 4, 16.80, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 16.80, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33253 — HUAMANI DOMITILA (2026-06-15 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33253' AND puesto_id = 1 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (72, 1, '2026-06-15 12:00:00-05', 94.50, 'Efectivo', '33253', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33253' AND puesto_id = 1 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33253 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 94.50
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 1 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (1, 1, 2026, 4, 189.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 94.50, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33254 — HUAMANI DOMITILA (2026-06-15 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33254' AND puesto_id = 1 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (72, 1, '2026-06-15 12:00:00-05', 100.50, 'Efectivo', '33254', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33254' AND puesto_id = 1 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33254 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 94.50
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 1 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (1, 1, 2026, 4, 189.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 94.50, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 1 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (1, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33255 — CALLE FIDEL (2026-06-15 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33255' AND puesto_id = 146 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (25, 146, '2026-06-15 12:00:00-05', 35.00, 'Efectivo', '33255', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33255' AND puesto_id = 146 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33255 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 29.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 146 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (146, 1, 2026, 4, 29.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 29.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 146 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (146, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33257 — ESTRADA  OSCAR (2026-06-15 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33257' AND puesto_id = 257 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (58, 257, '2026-06-15 12:00:00-05', 251.20, 'Efectivo', '33257', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33257' AND puesto_id = 257 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33257 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 18.50
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 257 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (257, 1, 2026, 4, 18.50, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 18.50, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 114.70
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 257 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (257, 2, 2026, 4, 114.70, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 114.70, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 54.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 257 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (257, 3, 2026, 4, 54.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 54.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 257 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (257, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 54.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 257 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (257, 3, 2026, 5, 54.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 54.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 257 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (257, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33258 — FLORES FLORES UMBELINA (2026-06-15 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33258' AND puesto_id = 258 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (61, 258, '2026-06-15 12:00:00-05', 236.10, 'Efectivo', '33258', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33258' AND puesto_id = 258 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33258 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 8.40
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 258 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (258, 1, 2026, 4, 258.90, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 8.40, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 109.70
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 258 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (258, 2, 2026, 4, 109.70, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 109.70, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 4/2026 — S/ 54.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 258 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (258, 3, 2026, 4, 54.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 54.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 4/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 258 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (258, 4, 2026, 4, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- G. ADM (Gastos administrativos) periodo 5/2026 — S/ 54.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 258 AND concepto_id = 3 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (258, 3, 2026, 5, 54.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (G. ADM)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 54.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- P. SOCIAL (Previsión social) periodo 5/2026 — S/ 5.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 258 AND concepto_id = 4 AND periodo_anio = 2026 AND periodo_mes = 5 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (258, 4, 2026, 5, 5.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (P. SOCIAL)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 5.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33259 — MAYTA MATOS HERMELINDA (2026-06-15 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33259' AND puesto_id = 184 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (94, 184, '2026-06-15 12:00:00-05', 100.00, 'Efectivo', '33259', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33259' AND puesto_id = 184 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33259 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- AGUA (Agua) periodo 4/2026 — S/ 100.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 184 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (184, 2, 2026, 4, 100.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 100.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33260 — GUTIERREZ CASTILLO JORGE (2026-06-15 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33260' AND puesto_id = 285 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (65, 285, '2026-06-15 12:00:00-05', 295.20, 'Efectivo', '33260', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33260' AND puesto_id = 285 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33260 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- LUZ (Luz) periodo 4/2026 — S/ 54.20
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 285 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (285, 1, 2026, 4, 54.20, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 54.20, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 241.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 285 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (285, 2, 2026, 4, 241.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 241.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

    -- ===== Recibo 33261 — CCOYLLO CHINCHAY DANIEL (2026-06-15 12:00:00-05) =====
    DECLARE
        v_pago_id bigint;
        v_monto_id bigint;
        v_monto numeric;
        v_estado text;
        v_aplicado numeric;
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = '33261' AND puesto_id = 158 AND deleted_at IS NULL) THEN
            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)
            VALUES (35, 158, '2026-06-15 12:00:00-05', 127.30, 'Efectivo', '33261', 'Migración de pagos Junio 2026', v_user_uuid)
            RETURNING id INTO v_pago_id;
        ELSE
            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = '33261' AND puesto_id = 158 AND deleted_at IS NULL LIMIT 1;
            RAISE NOTICE 'Recibo 33261 ya existía como pago id %, reutilizando', v_pago_id;
        END IF;

        -- MULTA X CAPACITACION (Multa) periodo 1/2026 — S/ 28.30
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE socio_id = 35 AND concepto_id = 6 AND periodo_anio = 2026 AND periodo_mes = 1 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (35, 6, 2026, 1, 28.30, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (MULTA X CAPACITACION)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 28.30, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 3/2026 — S/ 14.50
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 158 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (158, 1, 2026, 3, 14.50, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 14.50, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 3/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 158 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (158, 2, 2026, 3, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- MULTA 26/03/2026 (Multa) periodo 3/2026 — S/ 56.50
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE socio_id = 35 AND concepto_id = 6 AND periodo_anio = 2026 AND periodo_mes = 3 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (35, 6, 2026, 3, 56.50, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (MULTA 26/03/2026)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 56.50, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- LUZ (Luz) periodo 4/2026 — S/ 16.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 158 AND concepto_id = 1 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (158, 1, 2026, 4, 16.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (LUZ)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 16.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

        -- AGUA (Agua) periodo 4/2026 — S/ 6.00
        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE puesto_id = 158 AND concepto_id = 2 AND periodo_anio = 2026 AND periodo_mes = 4 AND deleted_at IS NULL;
        IF v_monto_id IS NULL THEN
            INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)
            VALUES (158, 2, 2026, 4, 6.00, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (AGUA)', v_user_uuid)
            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;
        END IF;
        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN
            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, 6.00, v_user_uuid);
        END IF;
        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;
        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;

    END;

END $$;

COMMIT;
