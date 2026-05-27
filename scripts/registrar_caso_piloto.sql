DO $$
DECLARE
    v_puesto_id         bigint := 193; -- Puesto 98
    v_socio_id          bigint := 158; -- SOTO VARGAS DE FLORES MARIA DEL CARMEN
    v_user_uuid         uuid;
    
    -- IDs de deudas
    v_id_saldo_inicial  bigint;
    v_id_jan_admin      bigint;
    v_id_jan_prev       bigint;
    v_id_jan_luz        bigint;
    v_id_jan_agua       bigint;
    v_id_feb_admin      bigint;
    v_id_feb_prev       bigint;
    v_id_feb_luz        bigint;
    v_id_feb_agua       bigint;
    v_id_mar_admin      bigint;
    v_id_mar_prev       bigint;
    
    -- Variables auxiliares
    v_pago_res          json;
BEGIN
    -- 1. Obtener un UUID de usuario administrador para auditoría
    SELECT id INTO v_user_uuid 
    FROM public.perfiles 
    WHERE rol = 'Administrador' AND activo = true 
    LIMIT 1;
    
    IF v_user_uuid IS NULL THEN
        -- Fallback a un UUID genérico si no hay usuarios en la tabla
        v_user_uuid := '00000000-0000-0000-0000-000000000000';
    END IF;

    -- 2. Simular sesión de Supabase/JWT para que get_my_rol() devuelva 'Administrador'
    --    Esto es crucial para que rpc_procesar_pago no lance "Acceso denegado".
    PERFORM set_config(
        'request.jwt.claims', 
        json_build_object('sub', v_user_uuid::text, 'role', 'authenticated')::text, 
        true
    );

    -- 3. Limpiar datos previos del puesto 193 para que el script sea 100% ejecutable repetidas veces
    DELETE FROM public.detalle_pagos WHERE monto_id IN (
        SELECT id FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_id
    );
    DELETE FROM public.pagos WHERE puesto_id = v_puesto_id;
    DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_id;
    
    UPDATE public.socios 
    SET saldo_a_favor = 0.00 
    WHERE id = v_socio_id;

    -- 4. INSERTAR DEUDAS
    -- Saldo Inicial (Diciembre 2025)
    INSERT INTO public.montos_por_cobrar 
        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES 
        (v_puesto_id, 32, 2025, 12, 34.40, 'Pendiente', 'Manual', '2025-12-31', v_user_uuid)
    RETURNING id INTO v_id_saldo_inicial;

    -- Enero 2026
    INSERT INTO public.montos_por_cobrar 
        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES 
        (v_puesto_id, 3, 2026, 1, 60.00, 'Pendiente', 'Fijo', '2026-01-31', v_user_uuid)
    RETURNING id INTO v_id_jan_admin;

    INSERT INTO public.montos_por_cobrar 
        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES 
        (v_puesto_id, 4, 2026, 1, 5.00, 'Pendiente', 'Fijo', '2026-01-31', v_user_uuid)
    RETURNING id INTO v_id_jan_prev;

    INSERT INTO public.montos_por_cobrar 
        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES 
        (v_puesto_id, 1, 2026, 1, 7.80, 'Pendiente', 'Manual', '2026-01-31', v_user_uuid)
    RETURNING id INTO v_id_jan_luz;

    INSERT INTO public.montos_por_cobrar 
        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES 
        (v_puesto_id, 2, 2026, 1, 5.00, 'Pendiente', 'Manual', '2026-01-31', v_user_uuid)
    RETURNING id INTO v_id_jan_agua;

    -- Febrero 2026
    INSERT INTO public.montos_por_cobrar 
        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES 
        (v_puesto_id, 3, 2026, 2, 56.00, 'Pendiente', 'Fijo', '2026-02-28', v_user_uuid)
    RETURNING id INTO v_id_feb_admin;

    INSERT INTO public.montos_por_cobrar 
        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES 
        (v_puesto_id, 4, 2026, 2, 5.00, 'Pendiente', 'Fijo', '2026-02-28', v_user_uuid)
    RETURNING id INTO v_id_feb_prev;

    INSERT INTO public.montos_por_cobrar 
        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES 
        (v_puesto_id, 1, 2026, 2, 7.70, 'Pendiente', 'Manual', '2026-02-28', v_user_uuid)
    RETURNING id INTO v_id_feb_luz;

    INSERT INTO public.montos_por_cobrar 
        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES 
        (v_puesto_id, 2, 2026, 2, 10.00, 'Pendiente', 'Manual', '2026-02-28', v_user_uuid)
    RETURNING id INTO v_id_feb_agua;

    -- Marzo 2026
    INSERT INTO public.montos_por_cobrar 
        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES 
        (v_puesto_id, 3, 2026, 3, 60.00, 'Pendiente', 'Fijo', '2026-03-31', v_user_uuid)
    RETURNING id INTO v_id_mar_admin;

    INSERT INTO public.montos_por_cobrar 
        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, created_by)
    VALUES 
        (v_puesto_id, 4, 2026, 3, 5.00, 'Pendiente', 'Fijo', '2026-03-31', v_user_uuid)
    RETURNING id INTO v_id_mar_prev;


    -- 5. PROCESAR PAGOS CRONOLÓGICAMENTE

    -- Pago 1: 26/01/2026 (Saldo Inicial 2025)
    -- Recibo: 32398, Monto: S/ 34.40, Método: Efectivo
    v_pago_res := public.rpc_procesar_pago(
        v_puesto_id,
        v_socio_id,
        NULL,
        34.40,
        'Efectivo',
        '32398',
        'Pago Saldo Inicial 2025',
        v_user_uuid,
        jsonb_build_array(
            jsonb_build_object('monto_id', v_id_saldo_inicial, 'monto_aplicado', 34.40, 'cubierto_completo', true)
        ),
        0.00
    );

    -- Pago 2: 31/01/2026 (Enero G. Adm y P. Social)
    -- Recibo: TARJETA-ENE, Monto: S/ 65.00, Método: Transferencia
    v_pago_res := public.rpc_procesar_pago(
        v_puesto_id,
        v_socio_id,
        NULL,
        65.00,
        'Transferencia',
        'TARJETA-ENE',
        'Pago G. ADM y P. SOCIAL Enero 2026',
        v_user_uuid,
        jsonb_build_array(
            jsonb_build_object('monto_id', v_id_jan_admin, 'monto_aplicado', 60.00, 'cubierto_completo', true),
            jsonb_build_object('monto_id', v_id_jan_prev, 'monto_aplicado', 5.00, 'cubierto_completo', true)
        ),
        0.00
    );

    -- Pago 3: 28/02/2026 (Abono parcial Gastos Administrativos Febrero)
    -- Recibo: TARJETA-FEB, Monto: S/ 40.00, Método: Transferencia
    v_pago_res := public.rpc_procesar_pago(
        v_puesto_id,
        v_socio_id,
        NULL,
        40.00,
        'Transferencia',
        'TARJETA-FEB',
        'Pago parcial G. ADM Febrero 2026',
        v_user_uuid,
        jsonb_build_array(
            jsonb_build_object('monto_id', v_id_feb_admin, 'monto_aplicado', 40.00, 'cubierto_completo', false)
        ),
        0.00
    );

    -- Pago 4: 24/03/2026 (Pago Servicios Ene/Feb y Saldo G. Admin Feb)
    -- Recibo: 32857, Monto: S/ 51.50, Método: Efectivo
    v_pago_res := public.rpc_procesar_pago(
        v_puesto_id,
        v_socio_id,
        NULL,
        51.50,
        'Efectivo',
        '32857',
        'Pago Luz/Agua Ene-Feb, P.Social Feb y saldo G.Adm Feb',
        v_user_uuid,
        jsonb_build_array(
            jsonb_build_object('monto_id', v_id_jan_luz, 'monto_aplicado', 7.80, 'cubierto_completo', true),
            jsonb_build_object('monto_id', v_id_jan_agua, 'monto_aplicado', 5.00, 'cubierto_completo', true),
            jsonb_build_object('monto_id', v_id_feb_luz, 'monto_aplicado', 7.70, 'cubierto_completo', true),
            jsonb_build_object('monto_id', v_id_feb_agua, 'monto_aplicado', 10.00, 'cubierto_completo', true),
            jsonb_build_object('monto_id', v_id_feb_prev, 'monto_aplicado', 5.00, 'cubierto_completo', true),
            jsonb_build_object('monto_id', v_id_feb_admin, 'monto_aplicado', 16.00, 'cubierto_completo', true)
        ),
        0.00
    );

    RAISE NOTICE '✓ Caso piloto de María del Carmen Soto Vargas de Flores registrado con éxito.';
END $$;
