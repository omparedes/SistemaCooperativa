DO $$
DECLARE
    v_user_uuid         uuid;
    v_pago_res          json;
    v_pago_id           bigint;
    
    -- Variables para María del Carmen Soto Vargas de Flores (Socio 158, Puesto 193)
    v_soto_socio_id     bigint := 158;
    v_soto_puesto_id    bigint := 193;
    v_soto_si           bigint;
    v_soto_jan_adm      bigint; v_soto_jan_ps bigint; v_soto_jan_luz bigint; v_soto_jan_ag bigint;
    v_soto_feb_adm      bigint; v_soto_feb_ps bigint; v_soto_feb_luz bigint; v_soto_feb_ag bigint;
    v_soto_mar_adm      bigint; v_soto_mar_ps bigint;

    -- Variables para Esthepany Caricia Nicho Lopez (Socio 101, Puesto 239)
    v_nicho_socio_id    bigint := 101;
    v_nicho_puesto_id   bigint := 239;
    v_nicho_si          bigint;
    v_nicho_jan_adm     bigint; v_nicho_jan_ps bigint; v_nicho_jan_luz bigint; v_nicho_jan_ag bigint; v_nicho_jan_fall bigint;
    v_nicho_feb_adm     bigint; v_nicho_feb_ps bigint; v_nicho_feb_luz bigint; v_nicho_feb_ag bigint;
    v_nicho_mar_adm     bigint; v_nicho_mar_ps bigint;

    -- Variables para Oscar Alfredo Paredes Flores (Socio 113, Puesto 140)
    v_paredes_socio_id  bigint := 113;
    v_paredes_puesto_id bigint := 140;
    v_paredes_si         bigint;
    v_paredes_jan_adm   bigint; v_paredes_jan_ps bigint; v_paredes_jan_luz bigint; v_paredes_jan_ag bigint;
    v_paredes_feb_adm   bigint; v_paredes_feb_ps bigint; v_paredes_feb_luz bigint; v_paredes_feb_ag bigint;
    v_paredes_mar_adm   bigint; v_paredes_mar_ps bigint; v_paredes_mar_luz bigint; v_paredes_mar_ag bigint;
BEGIN
    -- 1. Obtener un UUID de usuario administrador para auditoría
    SELECT id INTO v_user_uuid 
    FROM public.perfiles 
    WHERE rol = 'Administrador' AND activo = true 
    LIMIT 1;
    
    IF v_user_uuid IS NULL THEN
        v_user_uuid := '00000000-0000-0000-0000-000000000000';
    END IF;

    -- 2. Simular sesión de Supabase/JWT para pasar validaciones get_my_rol()
    PERFORM set_config(
        'request.jwt.claims', 
        json_build_object('sub', v_user_uuid::text, 'role', 'authenticated')::text, 
        true
    );

    -- =========================================================================
    -- CASO 1: MARÍA DEL CARMEN SOTO VARGAS DE FLORES (Socio 158, Puesto 193)
    -- =========================================================================
    
    -- Limpieza previa
    DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_soto_puesto_id);
    DELETE FROM public.pagos WHERE puesto_id = v_soto_puesto_id;
    DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_soto_puesto_id;
    UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_soto_socio_id;

    -- Generar Deudas
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_soto_puesto_id, 32, 2025, 12, 34.40, 'Pendiente', 'Manual', '2025-12-31', v_user_uuid) RETURNING id INTO v_soto_si;

    -- Enero 2026
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_soto_puesto_id, 3, 2026, 1, 60.00, 'Pendiente', 'Fijo', '2026-01-31', v_user_uuid) RETURNING id INTO v_soto_jan_adm;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_soto_puesto_id, 4, 2026, 1, 5.00, 'Pendiente', 'Fijo', '2026-01-31', v_user_uuid) RETURNING id INTO v_soto_jan_ps;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_soto_puesto_id, 1, 2026, 1, 7.80, 'Pendiente', 'Manual', '2026-01-31', v_user_uuid) RETURNING id INTO v_soto_jan_luz;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_soto_puesto_id, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-31', v_user_uuid) RETURNING id INTO v_soto_jan_ag;

    -- Febrero 2026
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_soto_puesto_id, 3, 2026, 2, 56.00, 'Pendiente', 'Fijo', '2026-02-28', v_user_uuid) RETURNING id INTO v_soto_feb_adm;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_soto_puesto_id, 4, 2026, 2, 5.00, 'Pendiente', 'Fijo', '2026-02-28', v_user_uuid) RETURNING id INTO v_soto_feb_ps;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_soto_puesto_id, 1, 2026, 2, 7.70, 'Pendiente', 'Manual', '2026-02-28', v_user_uuid) RETURNING id INTO v_soto_feb_luz;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_soto_puesto_id, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-28', v_user_uuid) RETURNING id INTO v_soto_feb_ag;

    -- Marzo 2026
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_soto_puesto_id, 3, 2026, 3, 60.00, 'Pendiente', 'Fijo', '2026-03-31', v_user_uuid) RETURNING id INTO v_soto_mar_adm;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_soto_puesto_id, 4, 2026, 3, 5.00, 'Pendiente', 'Fijo', '2026-03-31', v_user_uuid) RETURNING id INTO v_soto_mar_ps;

    -- Procesar Pagos
    -- Pago 1: 26/01/2026 (Saldo Inicial 2025) S/ 34.40
    v_pago_res := public.rpc_procesar_pago(v_soto_puesto_id, v_soto_socio_id, NULL, 34.40, 'Efectivo', '32398', 'Pago Saldo Inicial 2025', v_user_uuid, jsonb_build_array(jsonb_build_object('monto_id', v_soto_si, 'monto_aplicado', 34.40, 'cubierto_completo', true)), 0.00);
    v_pago_id := (v_pago_res->>'pago_id')::bigint;
    UPDATE public.pagos SET fecha_pago = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE id = v_pago_id;
    UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-26 12:00:00-05', created_at = '2026-01-26 12:00:00-05' WHERE pago_id = v_pago_id;

    -- Pago 2: 31/01/2026 (Enero G. Adm y P. Social) S/ 65.00
    v_pago_res := public.rpc_procesar_pago(v_soto_puesto_id, v_soto_socio_id, NULL, 65.00, 'Transferencia', 'TARJETA-ENE', 'Pago G. ADM y P. SOCIAL Enero 2026', v_user_uuid, jsonb_build_array(jsonb_build_object('monto_id', v_soto_jan_adm, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_soto_jan_ps, 'monto_aplicado', 5.00, 'cubierto_completo', true)), 0.00);
    v_pago_id := (v_pago_res->>'pago_id')::bigint;
    UPDATE public.pagos SET fecha_pago = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE id = v_pago_id;
    UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-31 12:00:00-05', created_at = '2026-01-31 12:00:00-05' WHERE pago_id = v_pago_id;

    -- Pago 3: 28/02/2026 (Abono parcial Febrero G. Adm) S/ 40.00
    v_pago_res := public.rpc_procesar_pago(v_soto_puesto_id, v_soto_socio_id, NULL, 40.00, 'Transferencia', 'TARJETA-FEB', 'Pago parcial G. ADM Febrero 2026', v_user_uuid, jsonb_build_array(jsonb_build_object('monto_id', v_soto_feb_adm, 'monto_aplicado', 40.00, 'cubierto_completo', false)), 0.00);
    v_pago_id := (v_pago_res->>'pago_id')::bigint;
    UPDATE public.pagos SET fecha_pago = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE id = v_pago_id;
    UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-28 12:00:00-05', created_at = '2026-02-28 12:00:00-05' WHERE pago_id = v_pago_id;

    -- Pago 4: 24/03/2026 (Servicios y saldo G. Adm Febrero) S/ 51.50
    v_pago_res := public.rpc_procesar_pago(v_soto_puesto_id, v_soto_socio_id, NULL, 51.50, 'Efectivo', '32857', 'Pago Luz/Agua Ene-Feb, P.Social Feb y saldo G.Adm Feb', v_user_uuid, jsonb_build_array(jsonb_build_object('monto_id', v_soto_jan_luz, 'monto_aplicado', 7.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_soto_jan_ag, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_soto_feb_luz, 'monto_aplicado', 7.70, 'cubierto_completo', true), jsonb_build_object('monto_id', v_soto_feb_ag, 'monto_aplicado', 10.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_soto_feb_ps, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_soto_feb_adm, 'monto_aplicado', 16.00, 'cubierto_completo', true)), 0.00);
    v_pago_id := (v_pago_res->>'pago_id')::bigint;
    UPDATE public.pagos SET fecha_pago = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE id = v_pago_id;
    UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-24 12:00:00-05', created_at = '2026-03-24 12:00:00-05' WHERE pago_id = v_pago_id;


    -- =========================================================================
    -- CASO 2: ESTHEPANY CARICIA NICHO LOPEZ (Socio 101, Puesto 239)
    -- =========================================================================
    
    -- Limpieza previa
    DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_nicho_puesto_id);
    DELETE FROM public.pagos WHERE puesto_id = v_nicho_puesto_id;
    DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_nicho_puesto_id;
    UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_nicho_socio_id;

    -- Generar Deudas
    -- Saldo Inicial 2025 total = 1097.00
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_nicho_puesto_id, 32, 2025, 12, 1097.00, 'Pendiente', 'Manual', '2025-12-31', v_user_uuid) RETURNING id INTO v_nicho_si;

    -- Enero 2026
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_nicho_puesto_id, 3, 2026, 1, 60.00, 'Pendiente', 'Fijo', '2026-01-31', v_user_uuid) RETURNING id INTO v_nicho_jan_adm;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_nicho_puesto_id, 4, 2026, 1, 5.00, 'Pendiente', 'Fijo', '2026-01-31', v_user_uuid) RETURNING id INTO v_nicho_jan_ps;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_nicho_puesto_id, 1, 2026, 1, 443.40, 'Pendiente', 'Manual', '2026-01-31', v_user_uuid) RETURNING id INTO v_nicho_jan_luz;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_nicho_puesto_id, 2, 2026, 1, 114.50, 'Pendiente', 'Manual', '2026-01-31', v_user_uuid) RETURNING id INTO v_nicho_jan_ag;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_nicho_puesto_id, 19, 2026, 1, 10.00, 'Pendiente', 'Manual', '2026-01-31', v_user_uuid) RETURNING id INTO v_nicho_jan_fall;

    -- Febrero 2026
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_nicho_puesto_id, 3, 2026, 2, 56.00, 'Pendiente', 'Fijo', '2026-02-28', v_user_uuid) RETURNING id INTO v_nicho_feb_adm;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_nicho_puesto_id, 4, 2026, 2, 5.00, 'Pendiente', 'Fijo', '2026-02-28', v_user_uuid) RETURNING id INTO v_nicho_feb_ps;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_nicho_puesto_id, 1, 2026, 2, 503.80, 'Pendiente', 'Manual', '2026-02-28', v_user_uuid) RETURNING id INTO v_nicho_feb_luz;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_nicho_puesto_id, 2, 2026, 2, 121.50, 'Pendiente', 'Manual', '2026-02-28', v_user_uuid) RETURNING id INTO v_nicho_feb_ag;

    -- Marzo 2026
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_nicho_puesto_id, 3, 2026, 3, 60.00, 'Pendiente', 'Fijo', '2026-03-31', v_user_uuid) RETURNING id INTO v_nicho_mar_adm;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_nicho_puesto_id, 4, 2026, 3, 5.00, 'Pendiente', 'Fijo', '2026-03-31', v_user_uuid) RETURNING id INTO v_nicho_mar_ps;

    -- Procesar Pagos
    -- Pago 1: 07/01/2026 (Saldo Inicial abono 1) S/ 562.00
    v_pago_res := public.rpc_procesar_pago(v_nicho_puesto_id, v_nicho_socio_id, NULL, 562.00, 'Efectivo', '32291', 'Pago parcial Saldo Inicial 2025', v_user_uuid, jsonb_build_array(jsonb_build_object('monto_id', v_nicho_si, 'monto_aplicado', 562.00, 'cubierto_completo', false)), 0.00);
    v_pago_id := (v_pago_res->>'pago_id')::bigint;
    UPDATE public.pagos SET fecha_pago = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE id = v_pago_id;
    UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-01-07 12:00:00-05', created_at = '2026-01-07 12:00:00-05' WHERE pago_id = v_pago_id;

    -- Pago 2: 02/02/2026 (Saldo Inicial abono 2 - cancelado) S/ 535.00
    v_pago_res := public.rpc_procesar_pago(v_nicho_puesto_id, v_nicho_socio_id, NULL, 535.00, 'Efectivo', '32447', 'Pago saldo restante Saldo Inicial 2025', v_user_uuid, jsonb_build_array(jsonb_build_object('monto_id', v_nicho_si, 'monto_aplicado', 535.00, 'cubierto_completo', true)), 0.00);
    v_pago_id := (v_pago_res->>'pago_id')::bigint;
    UPDATE public.pagos SET fecha_pago = '2026-02-02 12:00:00-05', created_at = '2026-02-02 12:00:00-05' WHERE id = v_pago_id;
    UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-02 12:00:00-05', created_at = '2026-02-02 12:00:00-05' WHERE pago_id = v_pago_id;

    -- Pago 3: 11/03/2026 (Enero completo) S/ 632.90
    v_pago_res := public.rpc_procesar_pago(v_nicho_puesto_id, v_nicho_socio_id, NULL, 632.90, 'Efectivo', '32658', 'Pago cargos Enero 2026 (Luz, Agua, Fijos, Fall. Flores)', v_user_uuid, jsonb_build_array(jsonb_build_object('monto_id', v_nicho_jan_adm, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_nicho_jan_ps, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_nicho_jan_luz, 'monto_aplicado', 443.40, 'cubierto_completo', true), jsonb_build_object('monto_id', v_nicho_jan_ag, 'monto_aplicado', 114.50, 'cubierto_completo', true), jsonb_build_object('monto_id', v_nicho_jan_fall, 'monto_aplicado', 10.00, 'cubierto_completo', true)), 0.00);
    v_pago_id := (v_pago_res->>'pago_id')::bigint;
    UPDATE public.pagos SET fecha_pago = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE id = v_pago_id;
    UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-11 12:00:00-05', created_at = '2026-03-11 12:00:00-05' WHERE pago_id = v_pago_id;

    -- Pago 4: 25/03/2026 (Febrero completo) S/ 686.30
    v_pago_res := public.rpc_procesar_pago(v_nicho_puesto_id, v_nicho_socio_id, NULL, 686.30, 'Efectivo', '32912', 'Pago cargos Febrero 2026 (Luz, Agua, G. Adm, P. Social)', v_user_uuid, jsonb_build_array(jsonb_build_object('monto_id', v_nicho_feb_adm, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_nicho_feb_ps, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_nicho_feb_luz, 'monto_aplicado', 503.80, 'cubierto_completo', true), jsonb_build_object('monto_id', v_nicho_feb_ag, 'monto_aplicado', 121.50, 'cubierto_completo', true)), 0.00);
    v_pago_id := (v_pago_res->>'pago_id')::bigint;
    UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
    UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;


    -- =========================================================================
    -- CASO 3: OSCAR ALFREDO PAREDES FLORES (Socio 113, Puesto 140)
    -- =========================================================================
    
    -- Limpieza previa
    DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_paredes_puesto_id);
    DELETE FROM public.pagos WHERE puesto_id = v_paredes_puesto_id;
    DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_paredes_puesto_id;
    UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_paredes_socio_id;

    -- Generar Deudas
    -- Saldo Inicial 2025 = 156.40
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_paredes_puesto_id, 32, 2025, 12, 156.40, 'Pendiente', 'Manual', '2025-12-31', v_user_uuid) RETURNING id INTO v_paredes_si;

    -- Enero 2026
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_paredes_puesto_id, 3, 2026, 1, 60.00, 'Pendiente', 'Fijo', '2026-01-31', v_user_uuid) RETURNING id INTO v_paredes_jan_adm;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_paredes_puesto_id, 4, 2026, 1, 5.00, 'Pendiente', 'Fijo', '2026-01-31', v_user_uuid) RETURNING id INTO v_paredes_jan_ps;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_paredes_puesto_id, 1, 2026, 1, 146.20, 'Pendiente', 'Manual', '2026-01-31', v_user_uuid) RETURNING id INTO v_paredes_jan_luz;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_paredes_puesto_id, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-31', v_user_uuid) RETURNING id INTO v_paredes_jan_ag;

    -- Febrero 2026
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_paredes_puesto_id, 3, 2026, 2, 56.00, 'Pendiente', 'Fijo', '2026-02-28', v_user_uuid) RETURNING id INTO v_paredes_feb_adm;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_paredes_puesto_id, 4, 2026, 2, 5.00, 'Pendiente', 'Fijo', '2026-02-28', v_user_uuid) RETURNING id INTO v_paredes_feb_ps;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_paredes_puesto_id, 1, 2026, 2, 144.10, 'Pendiente', 'Manual', '2026-02-28', v_user_uuid) RETURNING id INTO v_paredes_feb_luz;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_paredes_puesto_id, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-28', v_user_uuid) RETURNING id INTO v_paredes_feb_ag;

    -- Marzo 2026
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_paredes_puesto_id, 3, 2026, 3, 60.00, 'Pendiente', 'Fijo', '2026-03-31', v_user_uuid) RETURNING id INTO v_paredes_mar_adm;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_paredes_puesto_id, 4, 2026, 3, 5.00, 'Pendiente', 'Fijo', '2026-03-31', v_user_uuid) RETURNING id INTO v_paredes_mar_ps;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_paredes_puesto_id, 1, 2026, 3, 60.00, 'Pendiente', 'Manual', '2026-03-31', v_user_uuid) RETURNING id INTO v_paredes_mar_luz;
    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES (v_paredes_puesto_id, 2, 2026, 3, 5.00, 'Pendiente', 'Manual', '2026-03-31', v_user_uuid) RETURNING id INTO v_paredes_mar_ag;

    -- Procesar Pagos
    -- Pago 1: 17/02/2026 (Saldo Inicial 2025) S/ 156.40
    v_pago_res := public.rpc_procesar_pago(v_paredes_puesto_id, v_paredes_socio_id, NULL, 156.40, 'Efectivo', '32517', 'Pago Saldo Inicial 2025', v_user_uuid, jsonb_build_array(jsonb_build_object('monto_id', v_paredes_si, 'monto_aplicado', 156.40, 'cubierto_completo', true)), 0.00);
    v_pago_id := (v_pago_res->>'pago_id')::bigint;
    UPDATE public.pagos SET fecha_pago = '2026-02-17 12:00:00-05', created_at = '2026-02-17 12:00:00-05' WHERE id = v_pago_id;
    UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-17 12:00:00-05', created_at = '2026-02-17 12:00:00-05' WHERE pago_id = v_pago_id;

    -- Pago 2: 27/02/2026 (Enero y Febrero Cargos Fijos) S/ 126.00
    v_pago_res := public.rpc_procesar_pago(v_paredes_puesto_id, v_paredes_socio_id, NULL, 126.00, 'Efectivo', '32578', 'Pago Cargos Fijos Ene y Feb 2026', v_user_uuid, jsonb_build_array(jsonb_build_object('monto_id', v_paredes_jan_adm, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_paredes_jan_ps, 'monto_aplicado', 5.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_paredes_feb_adm, 'monto_aplicado', 56.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_paredes_feb_ps, 'monto_aplicado', 5.00, 'cubierto_completo', true)), 0.00);
    v_pago_id := (v_pago_res->>'pago_id')::bigint;
    UPDATE public.pagos SET fecha_pago = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE id = v_pago_id;
    UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-02-27 12:00:00-05', created_at = '2026-02-27 12:00:00-05' WHERE pago_id = v_pago_id;

    -- Pago 3: 16/03/2026 (Marzo Servicios) S/ 65.00
    v_pago_res := public.rpc_procesar_pago(v_paredes_puesto_id, v_paredes_socio_id, NULL, 65.00, 'Efectivo', '32672', 'Pago servicios Luz/Agua Marzo 2026', v_user_uuid, jsonb_build_array(jsonb_build_object('monto_id', v_paredes_mar_luz, 'monto_aplicado', 60.00, 'cubierto_completo', true), jsonb_build_object('monto_id', v_paredes_mar_ag, 'monto_aplicado', 5.00, 'cubierto_completo', true)), 0.00);
    v_pago_id := (v_pago_res->>'pago_id')::bigint;
    UPDATE public.pagos SET fecha_pago = '2026-03-16 12:00:00-05', created_at = '2026-03-16 12:00:00-05' WHERE id = v_pago_id;
    UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-16 12:00:00-05', created_at = '2026-03-16 12:00:00-05' WHERE pago_id = v_pago_id;

    -- Pago 4: 23/03/2026 (Enero Servicios) S/ 151.20
    v_pago_res := public.rpc_procesar_pago(v_paredes_puesto_id, v_paredes_socio_id, NULL, 151.20, 'Efectivo', '32796', 'Pago servicios Luz/Agua Enero 2026', v_user_uuid, jsonb_build_array(jsonb_build_object('monto_id', v_paredes_jan_luz, 'monto_aplicado', 146.20, 'cubierto_completo', true), jsonb_build_object('monto_id', v_paredes_jan_ag, 'monto_aplicado', 5.00, 'cubierto_completo', true)), 0.00);
    v_pago_id := (v_pago_res->>'pago_id')::bigint;
    UPDATE public.pagos SET fecha_pago = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE id = v_pago_id;
    UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-23 12:00:00-05', created_at = '2026-03-23 12:00:00-05' WHERE pago_id = v_pago_id;

    -- Pago 5: 25/03/2026 (Febrero Servicios) S/ 154.10
    v_pago_res := public.rpc_procesar_pago(v_paredes_puesto_id, v_paredes_socio_id, NULL, 154.10, 'Efectivo', '32902', 'Pago servicios Luz/Agua Febrero 2026', v_user_uuid, jsonb_build_array(jsonb_build_object('monto_id', v_paredes_feb_luz, 'monto_aplicado', 144.10, 'cubierto_completo', true), jsonb_build_object('monto_id', v_paredes_feb_ag, 'monto_aplicado', 10.00, 'cubierto_completo', true)), 0.00);
    v_pago_id := (v_pago_res->>'pago_id')::bigint;
    UPDATE public.pagos SET fecha_pago = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE id = v_pago_id;
    UPDATE public.detalle_pagos SET fecha_aplicacion = '2026-03-25 12:00:00-05', created_at = '2026-03-25 12:00:00-05' WHERE pago_id = v_pago_id;

    RAISE NOTICE '✓ Tres casos piloto (María Soto, Esthepany Nicho y Oscar Paredes) registrados con éxito con fechas de transacción correctas.';
END $$;
