-- =============================================================================
-- Migracion 00038 - Saldos Iniciales al 31-12-2025 (Go-Live 01-01-2026)
-- Cooperativa Primero de Mayo - SistemaCooperativa
-- Generado: 2026-05-18 19:04
-- Personas con saldo: 260
-- Suma total migrada: S/ 116569.87
-- Excluidas (deuda 0): 1 persona(s) - S/ 19.33
-- Huerfanos sin match: 0
-- =============================================================================

BEGIN;

-- --- Concepto 'Saldo Inicial 2025' ----------------------------------------
INSERT INTO public.conceptos (nombre, tipo, aplica_descuento, activo, descripcion)
VALUES (
    'Saldo Inicial 2025',
    'Variable',
    false,
    true,
    'Saldo de apertura al 31-12-2025. Una fila consolidada por puesto. '
    || 'El detalle del concepto que se esta pagando se captura en '
    || 'pagos.observacion al momento del cobro.'
)
ON CONFLICT (nombre) DO NOTHING;

-- --- Saldos iniciales por puesto -------------------------------------------
-- Cada bloque DO es atomico. Puesto no encontrado emite WARNING y continua.

-- [1] SOCIO: AGUIRRE QUISPE WILFREDO GILMER | Puesto 134 | S/ 511.99 (SOCIOS / exact)
DO $b1$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '134' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [AGUIRRE QUISPE WILFREDO GILMER]', '134';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 511.99, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · AGUIRRE QUISPE WILFREDO GILMER')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b1$;

-- [2] SOCIO: ALARCON ANAMPA BETSY JANET | Puesto 63 | S/ 201.81 (SOCIOS / token_subset)
DO $b2$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '63' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ALARCON ANAMPA BETSY JANET]', '63';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 201.81, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ALARCON ANAMPA BETSY JANET')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b2$;

-- [3] SOCIO: ALARCON ANAMPA NANCY GUISELA | Puesto 59 | S/ 171.05 (SOCIOS / exact)
DO $b3$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '59' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ALARCON ANAMPA NANCY GUISELA]', '59';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 171.05, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ALARCON ANAMPA NANCY GUISELA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b3$;

-- [4] SOCIO: ALHUAY PALOMINO DE ALHUAY JUANA | Puesto 181 | S/ 183.18 (SOCIOS / exact)
DO $b4$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '181' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ALHUAY PALOMINO DE ALHUAY JUANA]', '181';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 183.18, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ALHUAY PALOMINO DE ALHUAY JUANA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b4$;

-- [5] SOCIO: ALVAREZ CAMPOS ROLANDO | Puesto 73 | S/ 314.86 (SOCIOS / exact)
DO $b5$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '73' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ALVAREZ CAMPOS ROLANDO]', '73';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 314.86, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ALVAREZ CAMPOS ROLANDO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b5$;

-- [6] SOCIO: ALVAREZ CAMPOS VICTOR ADRIANO | Puesto 155 | S/ 42.06 (SOCIOS / token_subset)
DO $b6$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '155' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ALVAREZ CAMPOS VICTOR ADRIANO]', '155';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 42.06, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ALVAREZ CAMPOS VICTOR ADRIANO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b6$;

-- [7] SOCIO: ALVAREZ MARIN MARIANELA | Puesto 80 | S/ 160.19 (SOCIOS / exact)
DO $b7$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '80' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ALVAREZ MARIN MARIANELA]', '80';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 160.19, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ALVAREZ MARIN MARIANELA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b7$;

-- [8] SOCIO: ANAMPA CORAHUA CLEMENCIA MIGDONIA | Puesto 60 | S/ 224.43 (SOCIOS / exact)
DO $b8$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '60' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ANAMPA CORAHUA CLEMENCIA MIGDONIA]', '60';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 224.43, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ANAMPA CORAHUA CLEMENCIA MIGDONIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b8$;

-- [9] SOCIO: ANCCO LEON VALENTINA | Puesto 48 | S/ 195.01 (SOCIOS / exact)
DO $b9$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '48' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ANCCO LEON VALENTINA]', '48';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 195.01, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ANCCO LEON VALENTINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b9$;

-- [10] SOCIO: ATANASIO ORTEGA MAXIMILIANA | Puesto 179 | S/ 94.35 (SOCIOS / exact)
DO $b10$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '179' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ATANASIO ORTEGA MAXIMILIANA]', '179';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 94.35, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ATANASIO ORTEGA MAXIMILIANA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b10$;

-- [11] SOCIO: AYALA HUASHUAYO NORMA GLADYS | Puesto 12 | S/ 157.09 (SOCIOS / exact)
DO $b11$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '12' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [AYALA HUASHUAYO NORMA GLADYS]', '12';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 157.09, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · AYALA HUASHUAYO NORMA GLADYS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b11$;

-- [12] SOCIO: AYALA TABOADA ELISEO | Puesto 10 | S/ 457.09 (SOCIOS / exact)
DO $b12$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '10' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [AYALA TABOADA ELISEO]', '10';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 457.09, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · AYALA TABOADA ELISEO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b12$;

-- [13] SOCIO: BASTIDAS MEDINA DINA | Puesto 74 | S/ 220.16 (SOCIOS / exact)
DO $b13$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '74' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [BASTIDAS MEDINA DINA]', '74';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 220.16, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · BASTIDAS MEDINA DINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b13$;

-- [14] SOCIO: BASTIDAS MEDINA HERMENEGILDO | Puesto 104 | S/ 65.96 (SOCIOS / exact)
DO $b14$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '104' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [BASTIDAS MEDINA HERMENEGILDO]', '104';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 65.96, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · BASTIDAS MEDINA HERMENEGILDO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b14$;

-- [15] SOCIO: BERNAOLA CARHUAZ DE PRADO FLORENCIA | Puesto 166 | S/ 456.04 (SOCIOS / token_subset)
DO $b15$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '166' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [BERNAOLA CARHUAZ DE PRADO FLORENCIA]', '166';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 456.04, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · BERNAOLA CARHUAZ DE PRADO FLORENCIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b15$;

-- [16] SOCIO: BRAVO HEREDIA ANA MARITZA | Puesto 64 | S/ 374.75 (SOCIOS / exact)
DO $b16$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '64' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [BRAVO HEREDIA ANA MARITZA]', '64';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 374.75, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · BRAVO HEREDIA ANA MARITZA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b16$;

-- [17] SOCIO: BURGA CARRASCO ELIDA | Puesto 15 | S/ 407.33 (SOCIOS / exact)
DO $b17$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '15' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [BURGA CARRASCO ELIDA]', '15';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 407.33, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · BURGA CARRASCO ELIDA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b17$;

-- [18] SOCIO: CABALLERO CALZADO GLADYS VICTORIA | Puesto 108 | S/ 25.04 (SOCIOS / exact)
DO $b18$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '108' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CABALLERO CALZADO GLADYS VICTORIA]', '108';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 25.04, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CABALLERO CALZADO GLADYS VICTORIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b18$;

-- [19] SOCIO: CABERO MENDOZA GLORIA LUCINDA | Puesto 37 | S/ 161.82 (SOCIOS / token_subset)
DO $b19$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '37' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CABERO MENDOZA GLORIA LUCINDA]', '37';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 161.82, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CABERO MENDOZA GLORIA LUCINDA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b19$;

-- [20] SOCIO: CAHUANA VDA DE DAVILA VICENTINA | Puesto 159 | S/ 438.56 (SOCIOS / exact)
DO $b20$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '159' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CAHUANA VDA DE DAVILA VICENTINA]', '159';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 438.56, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CAHUANA VDA DE DAVILA VICENTINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b20$;

-- [21] SOCIO: CAJALEON CARRASCO LUIS ENRIQUE | Puesto 76 | S/ 241.35 (SOCIOS / exact)
DO $b21$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '76' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CAJALEON CARRASCO LUIS ENRIQUE]', '76';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 241.35, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CAJALEON CARRASCO LUIS ENRIQUE')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b21$;

-- [22] SOCIO: CALDERON TORRES BERTHA ESTELA | Puesto 58 | S/ 320.67 (SOCIOS / token_subset)
DO $b22$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '58' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CALDERON TORRES BERTHA ESTELA]', '58';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 320.67, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CALDERON TORRES BERTHA ESTELA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b22$;

-- [23] SOCIO: CALDERON VERA SEGUNDO ALCIDES | Puesto 184 | S/ 607.53 (SOCIOS / exact)
DO $b23$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '184' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CALDERON VERA SEGUNDO ALCIDES]', '184';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 607.53, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CALDERON VERA SEGUNDO ALCIDES')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b23$;

-- [24] SOCIO: CALLE ALVAREZ MARCO ANTONIO | Puesto 149 | S/ 234.65 (SOCIOS / exact)
DO $b24$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '149' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CALLE ALVAREZ MARCO ANTONIO]', '149';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 234.65, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CALLE ALVAREZ MARCO ANTONIO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b24$;

-- [25] SOCIO: CALLE CALLE FIDEL | Puesto 56 | S/ 160.18 (SOCIOS / exact)
DO $b25$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '56' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CALLE CALLE FIDEL]', '56';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 160.18, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CALLE CALLE FIDEL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b25$;

-- [26] SOCIO: CAMPUZANO CABELLO VICENTA DONATILA | Puesto 101 | S/ 43.63 (SOCIOS / exact)
DO $b26$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '101' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CAMPUZANO CABELLO VICENTA DONATILA]', '101';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 43.63, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CAMPUZANO CABELLO VICENTA DONATILA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b26$;

-- [27] SOCIO: CARDEÑA VILLAFUERTE ALEJANDRINA | Puesto 13 | S/ 87.00 (SOCIOS / exact)
DO $b27$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '13' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CARDEÑA VILLAFUERTE ALEJANDRINA]', '13';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 87.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CARDEÑA VILLAFUERTE ALEJANDRINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b27$;

-- [28] SOCIO: CARPIO VASQUEZ TEOFILA | Puesto 183 | S/ 783.00 (SOCIOS / exact)
DO $b28$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '183' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CARPIO VASQUEZ TEOFILA]', '183';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 783.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CARPIO VASQUEZ TEOFILA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b28$;

-- [29] SOCIO: CARRASCO SALVATIERRA FELICITA | Puesto 75 | S/ 467.59 (SOCIOS / exact)
DO $b29$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '75' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CARRASCO SALVATIERRA FELICITA]', '75';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 467.59, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CARRASCO SALVATIERRA FELICITA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b29$;

-- [30] SOCIO: CARTAGENA MAMANI BENJAMIN D | Puesto 165 | S/ 36.92 (SOCIOS / fuzzy)
DO $b30$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '165' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CARTAGENA MAMANI BENJAMIN D]', '165';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 36.92, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CARTAGENA MAMANI BENJAMIN D')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b30$;

-- [31] SOCIO: CARTAGENA PALOMINO ALVARO BENJAMIN | Puesto 89 | S/ 155.92 (SOCIOS / fuzzy)
DO $b31$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '89' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CARTAGENA PALOMINO ALVARO BENJAMIN]', '89';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 155.92, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CARTAGENA PALOMINO ALVARO BENJAMIN')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b31$;

-- [32] SOCIO: CASTRO ALEJANDRO HORTENCIA LUCILA | Puesto 79 | S/ 211.30 (SOCIOS / exact)
DO $b32$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '79' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CASTRO ALEJANDRO HORTENCIA LUCILA]', '79';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 211.30, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CASTRO ALEJANDRO HORTENCIA LUCILA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b32$;

-- [33] SOCIO: CASTRO GUTIERREZ AQUILA LUCRECIA | Puesto 18 | S/ 60.03 (SOCIOS / exact)
DO $b33$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '18' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CASTRO GUTIERREZ AQUILA LUCRECIA]', '18';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 60.03, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CASTRO GUTIERREZ AQUILA LUCRECIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b33$;

-- [34] SOCIO: CCOYLLO CHINCHAY DANIEL MASIA | Puesto 62 | S/ 20.06 (SOCIOS / exact)
DO $b34$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '62' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CCOYLLO CHINCHAY DANIEL MASIA]', '62';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 20.06, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CCOYLLO CHINCHAY DANIEL MASIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b34$;

-- [35] SOCIO: CCOYLLO CHINCHAY JUDITH NATY | Puesto 55 | S/ 48.64 (SOCIOS / exact)
DO $b35$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '55' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CCOYLLO CHINCHAY JUDITH NATY]', '55';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 48.64, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CCOYLLO CHINCHAY JUDITH NATY')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b35$;

-- [36] SOCIO: CCOYLLO POLANCO DANIEL | Puesto 117 | S/ 961.87 (SOCIOS / exact)
DO $b36$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '117' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CCOYLLO POLANCO DANIEL]', '117';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 961.87, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CCOYLLO POLANCO DANIEL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b36$;

-- [37] SOCIO: CCOYLLO MAYHUASCA ALEXIS | Puesto 110 | S/ 76.47 (SOCIOS / exact)
DO $b37$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '110' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CCOYLLO MAYHUASCA ALEXIS]', '110';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 76.47, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CCOYLLO MAYHUASCA ALEXIS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b37$;

-- [38] SOCIO: CCOYLLO POLANCO GERMAN | Puesto 49 | S/ 83.37 (SOCIOS / exact)
DO $b38$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '49' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CCOYLLO POLANCO GERMAN]', '49';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 83.37, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CCOYLLO POLANCO GERMAN')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b38$;

-- [39] SOCIO: CERDA YUPANQUI CARMEN ROSA | Puesto 103 | S/ 494.99 (SOCIOS / exact)
DO $b39$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '103' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CERDA YUPANQUI CARMEN ROSA]', '103';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 494.99, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CERDA YUPANQUI CARMEN ROSA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b39$;

-- [40] SOCIO: CHALLCO CRUZ DE PALOMINO NICOLAZA | Puesto 194 | S/ 1545.82 (SOCIOS / token_subset)
DO $b40$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '194' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CHALLCO CRUZ DE PALOMINO NICOLAZA]', '194';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1545.82, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CHALLCO CRUZ DE PALOMINO NICOLAZA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b40$;

-- [41] SOCIO: CHIRINOS CABRACANCHA MARIA LOURDES | Puesto 78 | S/ 279.33 (SOCIOS / exact)
DO $b41$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '78' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CHIRINOS CABRACANCHA MARIA LOURDES]', '78';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 279.33, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CHIRINOS CABRACANCHA MARIA LOURDES')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b41$;

-- [42] SOCIO: CCOYLLO BUSTILLOS DEYSI KAREN | Puesto 17 | S/ 354.14 (SOCIOS / token_subset)
DO $b42$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '17' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CCOYLLO BUSTILLOS DEYSI KAREN]', '17';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 354.14, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CCOYLLO BUSTILLOS DEYSI KAREN')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b42$;

-- [43] SOCIO: CHOQUEHUAMANI FELIX CEFERINO | Puesto 93 | S/ 174.14 (SOCIOS / fuzzy)
DO $b43$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '93' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CHOQUEHUAMANI FELIX CEFERINO]', '93';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 174.14, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CHOQUEHUAMANI FELIX CEFERINO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b43$;

-- [44] SOCIO: CHUCHULLO HACHA JOSE PEDRO | Puesto 67 | S/ 186.93 (SOCIOS / exact)
DO $b44$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '67' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CHUCHULLO HACHA JOSE PEDRO]', '67';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 186.93, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CHUCHULLO HACHA JOSE PEDRO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b44$;

-- [45] SOCIO: CLEMENTE ALLER CIRILA | Puesto 27 | S/ 486.49 (SOCIOS / exact)
DO $b45$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '27' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CLEMENTE ALLER CIRILA]', '27';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 486.49, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CLEMENTE ALLER CIRILA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b45$;

-- [46] SOCIO: CORDOVA PEREZ MARCO ANTONIO | Puesto 94 | S/ 517.35 (SOCIOS / exact)
DO $b46$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '94' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CORDOVA PEREZ MARCO ANTONIO]', '94';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 517.35, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CORDOVA PEREZ MARCO ANTONIO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b46$;

-- [47] SOCIO: CORNEJO DONATO DE CORDOVA ESTELA PILAR | Puesto 128 | S/ 138.88 (SOCIOS / exact)
DO $b47$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '128' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CORNEJO DONATO DE CORDOVA ESTELA PILAR]', '128';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 138.88, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CORNEJO DONATO DE CORDOVA ESTELA PILAR')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b47$;

-- [48] SOCIO: CRUZ JARAMILLO LUIS | Puesto 167 | S/ 31.77 (SOCIOS / exact)
DO $b48$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '167' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CRUZ JARAMILLO LUIS]', '167';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 31.77, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CRUZ JARAMILLO LUIS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b48$;

-- [49] SOCIO: CUCHO DE LA CRUZ SAUL PEDRO | Puesto 177 | S/ 32.27 (SOCIOS / token_subset)
DO $b49$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '177' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CUCHO DE LA CRUZ SAUL PEDRO]', '177';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 32.27, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CUCHO DE LA CRUZ SAUL PEDRO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b49$;

-- [50] SOCIO: CUEVAS MAYO ENRIQUE | Puesto 71 | S/ 45.36 (SOCIOS / exact)
DO $b50$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '71' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CUEVAS MAYO ENRIQUE]', '71';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 45.36, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CUEVAS MAYO ENRIQUE')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b50$;

-- [51] SOCIO: CULE CARRASCO HAYDEE MONICA | Puesto 171 | S/ 60.79 (SOCIOS / exact)
DO $b51$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '171' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CULE CARRASCO HAYDEE MONICA]', '171';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 60.79, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CULE CARRASCO HAYDEE MONICA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b51$;

-- [52] SOCIO: CUSI LAURA SONIA | Puesto 154 | S/ 57.58 (SOCIOS / exact)
DO $b52$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '154' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CUSI LAURA SONIA]', '154';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 57.58, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CUSI LAURA SONIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b52$;

-- [53] SOCIO: CUYA SANCHEZ ALBERTO | Puesto 16 | S/ 531.55 (SOCIOS / exact)
DO $b53$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '16' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CUYA SANCHEZ ALBERTO]', '16';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 531.55, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CUYA SANCHEZ ALBERTO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b53$;

-- [54] SOCIO: DAVILA CAHUANA DE PAZ MARISOL | Puesto 57 | S/ 243.67 (SOCIOS / token_subset)
DO $b54$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '57' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [DAVILA CAHUANA DE PAZ MARISOL]', '57';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 243.67, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · DAVILA CAHUANA DE PAZ MARISOL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b54$;

-- [55] SOCIO: DE LA CRUZ ESTEBAN JOSE LUIS | Puesto 125 | S/ 59.79 (SOCIOS / fuzzy)
DO $b55$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '125' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [DE LA CRUZ ESTEBAN JOSE LUIS]', '125';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 59.79, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · DE LA CRUZ ESTEBAN JOSE LUIS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b55$;

-- [56] SOCIO: ESPEJO URBANO ROSA FLORENCIA | Puesto 35 | S/ 173.62 (SOCIOS / exact)
DO $b56$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '35' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ESPEJO URBANO ROSA FLORENCIA]', '35';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 173.62, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ESPEJO URBANO ROSA FLORENCIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b56$;

-- [57] SOCIO: ESTELA SUAREZ ELVIA | Puesto 95 | S/ 718.35 (SOCIOS / exact)
DO $b57$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '95' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ESTELA SUAREZ ELVIA]', '95';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 718.35, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ESTELA SUAREZ ELVIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b57$;

-- [58] SOCIO: ESTRADA CHACON OSCAR ALFREDO | Puesto 162 | S/ 334.45 (SOCIOS / token_subset)
DO $b58$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '162' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ESTRADA CHACON OSCAR ALFREDO]', '162';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 334.45, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ESTRADA CHACON OSCAR ALFREDO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b58$;

-- [59] SOCIO: FALCON CHIARA HECTOR MARCIAL | Puesto 14 | S/ 110.91 (SOCIOS / exact)
DO $b59$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '14' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [FALCON CHIARA HECTOR MARCIAL]', '14';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 110.91, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · FALCON CHIARA HECTOR MARCIAL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b59$;

-- [60] SOCIO: FLORES FLORES IRENE BERTILIA | Puesto 152 | S/ 483.19 (SOCIOS / exact)
DO $b60$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '152' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [FLORES FLORES IRENE BERTILIA]', '152';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 483.19, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · FLORES FLORES IRENE BERTILIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b60$;

-- [61] SOCIO: FLORES FLORES UMBELINA DORA | Puesto 163 | S/ 673.74 (SOCIOS / exact)
DO $b61$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '163' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [FLORES FLORES UMBELINA DORA]', '163';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 673.74, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · FLORES FLORES UMBELINA DORA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b61$;

-- [62] SOCIO: FLORES YATO FRANCISCA DOLORES | Puesto 24 | S/ 318.45 (SOCIOS / exact)
DO $b62$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '24' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [FLORES YATO FRANCISCA DOLORES]', '24';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 318.45, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · FLORES YATO FRANCISCA DOLORES')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b62$;

-- [63] SOCIO: GAVILAN MOSQUERA NORMA LUZ | Puesto 107 | S/ 343.97 (SOCIOS / token_subset)
DO $b63$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '107' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [GAVILAN MOSQUERA NORMA LUZ]', '107';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 343.97, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · GAVILAN MOSQUERA NORMA LUZ')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b63$;

-- [64] SOCIO: GELDRES REVILLA MIGUEL ANGEL | Puesto 109 | S/ 207.03 (SOCIOS / token_subset)
DO $b64$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '109' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [GELDRES REVILLA MIGUEL ANGEL]', '109';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 207.03, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · GELDRES REVILLA MIGUEL ANGEL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b64$;

-- [65] SOCIO: GUTIERREZ CASTRO JORGE RICARDO | Puesto 170 | S/ 192.03 (SOCIOS / fuzzy)
DO $b65$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '170' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [GUTIERREZ CASTRO JORGE RICARDO]', '170';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 192.03, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · GUTIERREZ CASTRO JORGE RICARDO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b65$;

-- [66] SOCIO: GUTIERREZ CASTILLO JORGE JAIME | Puesto 191 | S/ 520.33 (SOCIOS / token_subset)
DO $b66$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '191' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [GUTIERREZ CASTILLO JORGE JAIME]', '191';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 520.33, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · GUTIERREZ CASTILLO JORGE JAIME')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b66$;

-- [67] SOCIO: GUTIERREZ CASTILLO TERESA JESUS | Puesto 84 | S/ 165.18 (SOCIOS / fuzzy)
DO $b67$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '84' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [GUTIERREZ CASTILLO TERESA JESUS]', '84';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 165.18, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · GUTIERREZ CASTILLO TERESA JESUS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b67$;

-- [68] SOCIO: GUTIERREZ FLORES ROGER REYNAN | Puesto 39 | S/ 518.26 (SOCIOS / exact)
DO $b68$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '39' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [GUTIERREZ FLORES ROGER REYNAN]', '39';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 518.26, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · GUTIERREZ FLORES ROGER REYNAN')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b68$;

-- [69] SOCIO: HALIRE YUCRA JOSUE JAASIEL | Puesto 100 | S/ 63.69 (SOCIOS / fuzzy)
DO $b69$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '100' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [HALIRE YUCRA JOSUE JAASIEL]', '100';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 63.69, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · HALIRE YUCRA JOSUE JAASIEL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b69$;

-- [70] SOCIO: HEREDIA MUÑOZ DE BRAVO MARIA | Puesto 150 | S/ 14.31 (SOCIOS / exact)
DO $b70$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '150' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [HEREDIA MUÑOZ DE BRAVO MARIA]', '150';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 14.31, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · HEREDIA MUÑOZ DE BRAVO MARIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b70$;

-- [71] SOCIO: HUAMANI ROMERO DOMITILA CLEOFE | Puesto 1 | S/ 410.06 (SOCIOS / token_subset)
DO $b71$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '1' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [HUAMANI ROMERO DOMITILA CLEOFE]', '1';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 410.06, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · HUAMANI ROMERO DOMITILA CLEOFE')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b71$;

-- [72] SOCIO: HUASHUAYO GOMEZ EUDOSIA | Puesto 9 | S/ 631.59 (SOCIOS / exact)
DO $b72$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '9' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [HUASHUAYO GOMEZ EUDOSIA]', '9';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 631.59, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · HUASHUAYO GOMEZ EUDOSIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b72$;

-- [73] SOCIO: HUAYHUALLA DE LOPEZ DONATILA | Puesto 113 | S/ 345.45 (SOCIOS / exact)
DO $b73$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '113' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [HUAYHUALLA DE LOPEZ DONATILA]', '113';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 345.45, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · HUAYHUALLA DE LOPEZ DONATILA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b73$;

-- [74] SOCIO: JARA ALVARES CRISTALINA | Puesto 161 | S/ 29.79 (SOCIOS / exact)
DO $b74$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '161' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [JARA ALVARES CRISTALINA]', '161';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 29.79, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · JARA ALVARES CRISTALINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b74$;

-- [75] SOCIO: JARA ALVAREZ MARIA CENAIDA | Puesto 50 | S/ 148.78 (SOCIOS / exact)
DO $b75$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '50' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [JARA ALVAREZ MARIA CENAIDA]', '50';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 148.78, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · JARA ALVAREZ MARIA CENAIDA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b75$;

-- [76] SOCIO: JARA ALVAREZ SANTOS PEDRO | Puesto 87 | S/ 170.52 (SOCIOS / exact)
DO $b76$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '87' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [JARA ALVAREZ SANTOS PEDRO]', '87';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 170.52, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · JARA ALVAREZ SANTOS PEDRO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b76$;

-- [77] SOCIO: JUAREZ CUELLAR LEONOR | Puesto 47 | S/ 525.42 (SOCIOS / exact)
DO $b77$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '47' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [JUAREZ CUELLAR LEONOR]', '47';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 525.42, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · JUAREZ CUELLAR LEONOR')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b77$;

-- [78] SOCIO: LAGOS LUNA  DE LEYVA ZAIDA LUISA | Puesto 25 | S/ 50.90 (SOCIOS / fuzzy)
DO $b78$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '25' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [LAGOS LUNA  DE LEYVA ZAIDA LUISA]', '25';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 50.90, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · LAGOS LUNA  DE LEYVA ZAIDA LUISA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b78$;

-- [79] SOCIO: LIMAS VARGAS CARMEN ROSA | Puesto 2 | S/ 587.20 (SOCIOS / exact)
DO $b79$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '2' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [LIMAS VARGAS CARMEN ROSA]', '2';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 587.20, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · LIMAS VARGAS CARMEN ROSA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b79$;

-- [80] SOCIO: LOPEZ HUAYHUALLA NELLY NATIVIDAD | Puesto 169 | S/ 37.75 (SOCIOS / exact)
DO $b80$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '169' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [LOPEZ HUAYHUALLA NELLY NATIVIDAD]', '169';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 37.75, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · LOPEZ HUAYHUALLA NELLY NATIVIDAD')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b80$;

-- [81] SOCIO: LUJAN GONZALES MARINO JUAN | Puesto 178 | S/ 376.14 (SOCIOS / exact)
DO $b81$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '178' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [LUJAN GONZALES MARINO JUAN]', '178';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 376.14, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · LUJAN GONZALES MARINO JUAN')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b81$;

-- [82] SOCIO: MALLQUI JULCA ALEJANDRINO TEODORO | Puesto 192 | S/ 117.77 (SOCIOS / exact)
DO $b82$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '192' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MALLQUI JULCA ALEJANDRINO TEODORO]', '192';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 117.77, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MALLQUI JULCA ALEJANDRINO TEODORO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b82$;

-- [83] SOCIO: MALLQUI LOPEZ LIZBETH NATIVIDAD | Puesto 130 | S/ 242.80 (SOCIOS / token_subset)
DO $b83$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '130' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MALLQUI LOPEZ LIZBETH NATIVIDAD]', '130';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 242.80, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MALLQUI LOPEZ LIZBETH NATIVIDAD')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b83$;

-- [84] SOCIO: MAYTA MATOS HERMELINDA | Puesto 88 | S/ 408.93 (SOCIOS / exact)
DO $b84$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '88' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MAYTA MATOS HERMELINDA]', '88';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 408.93, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MAYTA MATOS HERMELINDA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b84$;

-- [85] SOCIO: MORENO CHAVEZ RAFAEL FREDY | Puesto 83 | S/ 248.31 (SOCIOS / exact)
DO $b85$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '83' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MORENO CHAVEZ RAFAEL FREDY]', '83';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 248.31, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MORENO CHAVEZ RAFAEL FREDY')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b85$;

-- [86] SOCIO: MARIN HUAMAN DE SALAMANCA MARIA YNES | Puesto 31 | S/ 287.10 (SOCIOS / exact)
DO $b86$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '31' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MARIN HUAMAN DE SALAMANCA MARIA YNES]', '31';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 287.10, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MARIN HUAMAN DE SALAMANCA MARIA YNES')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b86$;

-- [87] SOCIO: HUAMAN YNCA VISITACION | Puesto 140 | S/ 196.38 (SOCIOS / exact)
DO $b87$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '140' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [HUAMAN YNCA VISITACION]', '140';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 196.38, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · HUAMAN YNCA VISITACION')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b87$;

-- [88] SOCIO: ISIDRO MARIN CARLOS DANIEL | Puesto 96 | S/ 378.92 (SOCIOS / alias)
DO $b88$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '96' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ISIDRO MARIN CARLOS DANIEL]', '96';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 378.92, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ISIDRO MARIN CARLOS DANIEL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b88$;

-- [89] SOCIO: MARIN LONDOÑE EDUARDO SANTIAGO | Puesto 176 | S/ 84.84 (SOCIOS / exact)
DO $b89$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '176' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MARIN LONDOÑE EDUARDO SANTIAGO]', '176';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 84.84, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MARIN LONDOÑE EDUARDO SANTIAGO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b89$;

-- [90] SOCIO: MARIN LONDOÑE MARIA LUZ | Puesto 81 | S/ 572.43 (SOCIOS / exact)
DO $b90$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '81' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MARIN LONDOÑE MARIA LUZ]', '81';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 572.43, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MARIN LONDOÑE MARIA LUZ')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b90$;

-- [91] SOCIO: MEDINA GUTIERREZ HONORATA | Puesto 174 | S/ 147.99 (SOCIOS / exact)
DO $b91$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '174' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MEDINA GUTIERREZ HONORATA]', '174';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 147.99, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MEDINA GUTIERREZ HONORATA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b91$;

-- [92] SOCIO: MAYHUASCA BASTIDAS MARILU | Puesto 186 | S/ 714.63 (SOCIOS / fuzzy)
DO $b92$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '186' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MAYHUASCA BASTIDAS MARILU]', '186';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 714.63, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MAYHUASCA BASTIDAS MARILU')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b92$;

-- [93] SOCIO: MAYHUASCA BASTIDAS MARILU | Puesto 186 | S/ 506.49 (SOCIOS / exact)
DO $b93$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '186' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MAYHUASCA BASTIDAS MARILU]', '186';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 506.49, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MAYHUASCA BASTIDAS MARILU')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b93$;

-- [94] SOCIO: MAYHUASCA BASTIDAS ULISES | Puesto 188 | S/ 84.18 (SOCIOS / exact)
DO $b94$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '188' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MAYHUASCA BASTIDAS ULISES]', '188';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 84.18, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MAYHUASCA BASTIDAS ULISES')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b94$;

-- [95] SOCIO: MAYTA COLQUI VIOLETA | Puesto 158 | S/ 157.48 (SOCIOS / exact)
DO $b95$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '158' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MAYTA COLQUI VIOLETA]', '158';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 157.48, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MAYTA COLQUI VIOLETA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b95$;

-- [96] SOCIO: MEDINA JOTA DE CACERES VICENTA | Puesto 5 | S/ 1123.18 (SOCIOS / exact)
DO $b96$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '5' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MEDINA JOTA DE CACERES VICENTA]', '5';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1123.18, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MEDINA JOTA DE CACERES VICENTA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b96$;

-- [97] SOCIO: MEDINA MEDRANO JUAN CARLOS | Puesto 143 | S/ 159.85 (SOCIOS / token_subset)
DO $b97$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '143' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MEDINA MEDRANO JUAN CARLOS]', '143';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 159.85, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MEDINA MEDRANO JUAN CARLOS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b97$;

-- [98] SOCIO: REYES SANCHEZ MILENA GERALDINE | Puesto 120 | S/ 2593.57 (SOCIOS / token_subset)
DO $b98$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '120' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [REYES SANCHEZ MILENA GERALDINE]', '120';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 2593.57, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · REYES SANCHEZ MILENA GERALDINE')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b98$;

-- [99] SOCIO: MELO BACA MARINA | Puesto 122 | S/ 1497.59 (SOCIOS / exact)
DO $b99$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '122' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MELO BACA MARINA]', '122';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1497.59, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MELO BACA MARINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b99$;

-- [100] SOCIO: MESIA CRUZ GLADYS | Puesto 106 | S/ 288.74 (SOCIOS / fuzzy)
DO $b100$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '106' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MESIA CRUZ GLADYS]', '106';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 288.74, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MESIA CRUZ GLADYS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b100$;

-- [101] SOCIO: SALAS MONTALVO JUDITH MAGALI | Puesto 38 | S/ 652.56 (SOCIOS / alias)
DO $b101$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '38' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SALAS MONTALVO JUDITH MAGALI]', '38';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 652.56, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SALAS MONTALVO JUDITH MAGALI')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b101$;

-- [102] SOCIO: ÑAHUI RUIZ AURELIO | Puesto 61 | S/ 50.42 (SOCIOS / exact)
DO $b102$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '61' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ÑAHUI RUIZ AURELIO]', '61';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 50.42, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ÑAHUI RUIZ AURELIO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b102$;

-- [103] SOCIO: NICHO LOPEZ ESTHEPANY CARICIA | Puesto 144 | S/ 1097.07 (SOCIOS / exact)
DO $b103$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '144' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [NICHO LOPEZ ESTHEPANY CARICIA]', '144';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1097.07, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · NICHO LOPEZ ESTHEPANY CARICIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b103$;

-- [104] SOCIO: OJEDA CAMPOS EDSON JUNIOR | Puesto 133 | S/ 1064.54 (SOCIOS / token_subset)
DO $b104$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '133' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [OJEDA CAMPOS EDSON JUNIOR]', '133';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1064.54, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · OJEDA CAMPOS EDSON JUNIOR')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b104$;

-- [105] SOCIO: OQUENDO ARISACA MELESIA ROSARIO | Puesto 119 | S/ 293.55 (SOCIOS / exact)
DO $b105$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '119' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [OQUENDO ARISACA MELESIA ROSARIO]', '119';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 293.55, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · OQUENDO ARISACA MELESIA ROSARIO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b105$;

-- [106] SOCIO: OQUENDO QUISPE MIGUEL EUFRACIO | Puesto 146 | S/ 323.38 (SOCIOS / fuzzy)
DO $b106$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '146' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [OQUENDO QUISPE MIGUEL EUFRACIO]', '146';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 323.38, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · OQUENDO QUISPE MIGUEL EUFRACIO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b106$;

-- [107] SOCIO: OQUENDO QUISPE JESSICA | Puesto 172 | S/ 561.96 (SOCIOS / exact)
DO $b107$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '172' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [OQUENDO QUISPE JESSICA]', '172';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 561.96, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · OQUENDO QUISPE JESSICA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b107$;

-- [108] SOCIO: ORTIZ ÑAUPA WELINTONH | Puesto 185 | S/ 296.71 (SOCIOS / exact)
DO $b108$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '185' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ORTIZ ÑAUPA WELINTONH]', '185';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 296.71, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ORTIZ ÑAUPA WELINTONH')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b108$;

-- [109] SOCIO: PACOMPIA CARDEÑA GIOVANNI | Puesto 29 | S/ 94.90 (SOCIOS / exact)
DO $b109$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '29' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PACOMPIA CARDEÑA GIOVANNI]', '29';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 94.90, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PACOMPIA CARDEÑA GIOVANNI')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b109$;

-- [110] SOCIO: PALOMINO HANCCO CECILIA | Puesto 164 | S/ 751.11 (SOCIOS / exact)
DO $b110$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '164' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PALOMINO HANCCO CECILIA]', '164';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 751.11, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PALOMINO HANCCO CECILIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b110$;

-- [111] SOCIO: PALOMINO TENORIO SILVIO EDUARDO | Puesto 195 | S/ 37.95 (SOCIOS / exact)
DO $b111$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '195' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PALOMINO TENORIO SILVIO EDUARDO]', '195';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 37.95, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PALOMINO TENORIO SILVIO EDUARDO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b111$;

-- [112] SOCIO: PALOMINO VELASQUEZ EUSEBIO | Puesto 147 | S/ 546.97 (SOCIOS / exact)
DO $b112$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '147' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PALOMINO VELASQUEZ EUSEBIO]', '147';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 546.97, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PALOMINO VELASQUEZ EUSEBIO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b112$;

-- [113] SOCIO: PAREDES FLORES OSCAR ALFREDO | Puesto 53 | S/ 156.42 (SOCIOS / exact)
DO $b113$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '53' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PAREDES FLORES OSCAR ALFREDO]', '53';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 156.42, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PAREDES FLORES OSCAR ALFREDO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b113$;

-- [114] SOCIO: PAREDES MORALES DIANA VONNETH | Puesto 19 | S/ 275.98 (SOCIOS / fuzzy)
DO $b114$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '19' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PAREDES MORALES DIANA VONNETH]', '19';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 275.98, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PAREDES MORALES DIANA VONNETH')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b114$;

-- [115] SOCIO: PAREDES MORALES OSCAR MARTIN | Puesto 28 | S/ 275.98 (SOCIOS / exact)
DO $b115$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '28' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PAREDES MORALES OSCAR MARTIN]', '28';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 275.98, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PAREDES MORALES OSCAR MARTIN')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b115$;

-- [116] SOCIO: PEREZ PONCE DE ROMERO SATURNINA MARGARITA | Puesto 187 | S/ 194.71 (SOCIOS / token_subset)
DO $b116$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '187' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PEREZ PONCE DE ROMERO SATURNINA MARGARITA]', '187';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 194.71, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PEREZ PONCE DE ROMERO SATURNINA MARGARITA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b116$;

-- [117] SOCIO: PEREZ QUISPE EPIFANIA RICARDINA | Puesto 40 | S/ 235.16 (SOCIOS / exact)
DO $b117$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '40' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PEREZ QUISPE EPIFANIA RICARDINA]', '40';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 235.16, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PEREZ QUISPE EPIFANIA RICARDINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b117$;

-- [118] SOCIO: PITTMAN CONCEPCION NELLY MARIA | Puesto 33 | S/ 235.16 (SOCIOS / exact)
DO $b118$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '33' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PITTMAN CONCEPCION NELLY MARIA]', '33';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 235.16, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PITTMAN CONCEPCION NELLY MARIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b118$;

-- [119] SOCIO: PORRAS URCURANGA DE OROYA OLIMPIA | Puesto 123 | S/ 167.72 (SOCIOS / token_subset)
DO $b119$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '123' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PORRAS URCURANGA DE OROYA OLIMPIA]', '123';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 167.72, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PORRAS URCURANGA DE OROYA OLIMPIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b119$;

-- [120] SOCIO: PRADO LLANCARI ZOSIMA | Puesto 42 | S/ 233.32 (SOCIOS / fuzzy)
DO $b120$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '42' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PRADO LLANCARI ZOSIMA]', '42';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 233.32, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PRADO LLANCARI ZOSIMA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b120$;

-- [121] SOCIO: QUINTANA VIDAL GLICERIO | Puesto 97 | S/ 138.77 (SOCIOS / exact)
DO $b121$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '97' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [QUINTANA VIDAL GLICERIO]', '97';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 138.77, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · QUINTANA VIDAL GLICERIO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b121$;

-- [122] SOCIO: QUISPE CONSA MIGUEL | Puesto 115 | S/ 632.62 (SOCIOS / exact)
DO $b122$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '115' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [QUISPE CONSA MIGUEL]', '115';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 632.62, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · QUISPE CONSA MIGUEL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b122$;

-- [123] SOCIO: QUISPE CONSA VIDAL | Puesto 90 | S/ 1097.81 (SOCIOS / fuzzy)
DO $b123$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '90' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [QUISPE CONSA VIDAL]', '90';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1097.81, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · QUISPE CONSA VIDAL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b123$;

-- [124] SOCIO: QUISPE COPAYO  ELIO CARLOS | Puesto 114 | S/ 1919.16 (SOCIOS / exact)
DO $b124$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '114' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [QUISPE COPAYO  ELIO CARLOS]', '114';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1919.16, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · QUISPE COPAYO  ELIO CARLOS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b124$;

-- [125] SOCIO: QUISPE AGUILAR DE PALOMINO DOROTEA | Puesto 132 | S/ 620.00 (SOCIOS / token_subset)
DO $b125$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '132' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [QUISPE AGUILAR DE PALOMINO DOROTEA]', '132';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 620.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · QUISPE AGUILAR DE PALOMINO DOROTEA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b125$;

-- [126] SOCIO: QUISPE DURAN ADRIANA | Puesto 157 | S/ 1434.00 (SOCIOS / exact)
DO $b126$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '157' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [QUISPE DURAN ADRIANA]', '157';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1434.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · QUISPE DURAN ADRIANA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b126$;

-- [127] SOCIO: QUISPE ORTEGA ROSA CARMEN | Puesto 175 | S/ 836.07 (SOCIOS / exact)
DO $b127$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '175' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [QUISPE ORTEGA ROSA CARMEN]', '175';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 836.07, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · QUISPE ORTEGA ROSA CARMEN')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b127$;

-- [128] SOCIO: QUISPE URIBE LUCIANO | Puesto 30 | S/ 45.36 (SOCIOS / exact)
DO $b128$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '30' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [QUISPE URIBE LUCIANO]', '30';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 45.36, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · QUISPE URIBE LUCIANO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b128$;

-- [129] SOCIO: RAMOS CUEVA PEDRO RAUL | Puesto 131 | S/ 405.60 (SOCIOS / token_subset)
DO $b129$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '131' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [RAMOS CUEVA PEDRO RAUL]', '131';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 405.60, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · RAMOS CUEVA PEDRO RAUL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b129$;

-- [130] SOCIO: REYES PEREZ DE VALENCIA NANCY VICTORIA | Puesto 127 | S/ 512.82 (SOCIOS / token_subset)
DO $b130$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '127' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [REYES PEREZ DE VALENCIA NANCY VICTORIA]', '127';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 512.82, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · REYES PEREZ DE VALENCIA NANCY VICTORIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b130$;

-- [131] SOCIO: RICSE SAYES TERESA REINA | Puesto 136 | S/ 151.62 (SOCIOS / fuzzy)
DO $b131$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '136' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [RICSE SAYES TERESA REINA]', '136';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 151.62, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · RICSE SAYES TERESA REINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b131$;

-- [132] SOCIO: PLAZA COSQUILLO ROSA ESTELA | Puesto 138 | S/ 75.54 (SOCIOS / alias)
DO $b132$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '138' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PLAZA COSQUILLO ROSA ESTELA]', '138';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 75.54, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PLAZA COSQUILLO ROSA ESTELA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b132$;

-- [133] SOCIO: RIVERA CALLPA JUANA REGIS | Puesto 69 | S/ 75.07 (SOCIOS / token_subset)
DO $b133$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '69' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [RIVERA CALLPA JUANA REGIS]', '69';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 75.07, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · RIVERA CALLPA JUANA REGIS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b133$;

-- [134] SOCIO: RIVERA FERNANDEZ MARINA MAXILIANA | Puesto 142 | S/ 157.50 (SOCIOS / exact)
DO $b134$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '142' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [RIVERA FERNANDEZ MARINA MAXILIANA]', '142';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 157.50, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · RIVERA FERNANDEZ MARINA MAXILIANA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b134$;

-- [135] SOCIO: MARIN ROCHA ESTEFANY JULISSA | Puesto 126 | S/ 339.47 (SOCIOS / token_subset)
DO $b135$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '126' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MARIN ROCHA ESTEFANY JULISSA]', '126';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 339.47, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MARIN ROCHA ESTEFANY JULISSA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b135$;

-- [136] SOCIO: RODRIGUEZ ARQUIÑEGO IDILIO FELIX | Puesto 51 | S/ 51.08 (SOCIOS / exact)
DO $b136$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '51' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [RODRIGUEZ ARQUIÑEGO IDILIO FELIX]', '51';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 51.08, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · RODRIGUEZ ARQUIÑEGO IDILIO FELIX')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b136$;

-- [137] SOCIO: RODRIGUEZ CORDOVA MARCOS | Puesto 139 | S/ 136.07 (SOCIOS / exact)
DO $b137$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '139' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [RODRIGUEZ CORDOVA MARCOS]', '139';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 136.07, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · RODRIGUEZ CORDOVA MARCOS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b137$;

-- [138] SOCIO: RODRIGUEZ MORENO NORA | Puesto 180 | S/ 1303.36 (SOCIOS / exact)
DO $b138$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '180' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [RODRIGUEZ MORENO NORA]', '180';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1303.36, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · RODRIGUEZ MORENO NORA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b138$;

-- [139] SOCIO: ROJAS CORNEJO ERICK JOHN | Puesto 99 | S/ 150.78 (SOCIOS / token_subset)
DO $b139$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '99' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ROJAS CORNEJO ERICK JOHN]', '99';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 150.78, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ROJAS CORNEJO ERICK JOHN')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b139$;

-- [140] SOCIO: ROMERO FLORES EDDNA | Puesto 151 | S/ 627.49 (SOCIOS / exact)
DO $b140$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '151' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ROMERO FLORES EDDNA]', '151';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 627.49, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ROMERO FLORES EDDNA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b140$;

-- [141] SOCIO: ROJAS IGNACIO LIONILA JULIA | Puesto 41 | S/ 164.95 (SOCIOS / token_subset)
DO $b141$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '41' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ROJAS IGNACIO LIONILA JULIA]', '41';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 164.95, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ROJAS IGNACIO LIONILA JULIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b141$;

-- [142] SOCIO: ROMERO NINAHUAMAN JAVIER JOHNNY | Puesto 3 | S/ 263.69 (SOCIOS / token_subset)
DO $b142$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '3' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ROMERO NINAHUAMAN JAVIER JOHNNY]', '3';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 263.69, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ROMERO NINAHUAMAN JAVIER JOHNNY')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b142$;

-- [143] SOCIO: ROMERO YSLA ESTEBAN LIDIO | Puesto 156 | S/ 672.07 (SOCIOS / fuzzy)
DO $b143$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '156' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ROMERO YSLA ESTEBAN LIDIO]', '156';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 672.07, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ROMERO YSLA ESTEBAN LIDIO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b143$;

-- [144] SOCIO: SANCHEZ RODRIGUEZ JUDITH IRIS | Puesto 190 | S/ 283.86 (SOCIOS / token_subset)
DO $b144$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '190' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SANCHEZ RODRIGUEZ JUDITH IRIS]', '190';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 283.86, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SANCHEZ RODRIGUEZ JUDITH IRIS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b144$;

-- [145] SOCIO: SAAVEDRA CURIPUMA LUIS HUMBERTO | Puesto 43 | S/ 241.51 (SOCIOS / exact)
DO $b145$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '43' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SAAVEDRA CURIPUMA LUIS HUMBERTO]', '43';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 241.51, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SAAVEDRA CURIPUMA LUIS HUMBERTO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b145$;

-- [146] SOCIO: SALAS MONTALVO RUTH YOVANNA | Puesto 6 | S/ 275.98 (SOCIOS / token_subset)
DO $b146$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '6' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SALAS MONTALVO RUTH YOVANNA]', '6';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 275.98, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SALAS MONTALVO RUTH YOVANNA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b146$;

-- [147] SOCIO: SALAZAR CONCEPCION VICTORIA | Puesto 102 | S/ 108.23 (SOCIOS / exact)
DO $b147$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '102' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SALAZAR CONCEPCION VICTORIA]', '102';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 108.23, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SALAZAR CONCEPCION VICTORIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b147$;

-- [148] SOCIO: SALVATIERRA OQUENDO ALLISON ADRIANA | Puesto 148 | S/ 484.99 (SOCIOS / exact)
DO $b148$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '148' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SALVATIERRA OQUENDO ALLISON ADRIANA]', '148';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 484.99, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SALVATIERRA OQUENDO ALLISON ADRIANA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b148$;

-- [149] SOCIO: SANCHEZ ASTO DE TORRES YOLANDA SOFIA TERESA | Puesto 36 | S/ 253.63 (SOCIOS / token_subset)
DO $b149$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '36' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SANCHEZ ASTO DE TORRES YOLANDA SOFIA TERESA]', '36';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 253.63, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SANCHEZ ASTO DE TORRES YOLANDA SOFIA TERESA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b149$;

-- [150] SOCIO: SANCHEZ SOTO LUCIA YRENE | Puesto 65 | S/ 207.30 (SOCIOS / fuzzy)
DO $b150$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '65' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SANCHEZ SOTO LUCIA YRENE]', '65';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 207.30, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SANCHEZ SOTO LUCIA YRENE')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b150$;

-- [151] SOCIO: SANTILLAN MESIA ZOILA MARIBEL | Puesto 124 | S/ 165.46 (SOCIOS / token_subset)
DO $b151$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '124' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SANTILLAN MESIA ZOILA MARIBEL]', '124';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 165.46, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SANTILLAN MESIA ZOILA MARIBEL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b151$;

-- [152] SOCIO: SEGOVIA VILLAFUERTE DE PONCE JUSTINA | Puesto 34 | S/ 136.20 (SOCIOS / fuzzy)
DO $b152$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '34' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SEGOVIA VILLAFUERTE DE PONCE JUSTINA]', '34';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 136.20, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SEGOVIA VILLAFUERTE DE PONCE JUSTINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b152$;

-- [153] SOCIO: SERMEÑO GUTIERREZ JAVIER YGNACIO | Puesto 20 | S/ 314.90 (SOCIOS / exact)
DO $b153$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '20' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SERMEÑO GUTIERREZ JAVIER YGNACIO]', '20';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 314.90, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SERMEÑO GUTIERREZ JAVIER YGNACIO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b153$;

-- [154] SOCIO: SORIA TAPIA EDITH CATALINA | Puesto 68 | S/ 103.90 (SOCIOS / token_subset)
DO $b154$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '68' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SORIA TAPIA EDITH CATALINA]', '68';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 103.90, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SORIA TAPIA EDITH CATALINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b154$;

-- [155] SOCIO: SOSA VALDIVIA JUANA ISABEL | Puesto 4 | S/ 516.79 (SOCIOS / token_subset)
DO $b155$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '4' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SOSA VALDIVIA JUANA ISABEL]', '4';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 516.79, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SOSA VALDIVIA JUANA ISABEL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b155$;

-- [156] SOCIO: SOTO GALLEGO DE VALERO SOFIA | Puesto 85 | S/ 148.71 (SOCIOS / token_subset)
DO $b156$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '85' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SOTO GALLEGO DE VALERO SOFIA]', '85';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 148.71, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SOTO GALLEGO DE VALERO SOFIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b156$;

-- [157] SOCIO: SOTO VARGAS DE FLORES MARIA DEL CARMEN | Puesto 98 | S/ 34.36 (SOCIOS / exact)
DO $b157$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '98' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SOTO VARGAS DE FLORES MARIA DEL CARMEN]', '98';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 34.36, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SOTO VARGAS DE FLORES MARIA DEL CARMEN')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b157$;

-- [158] SOCIO: ORDOÑEZ NICHO AZUL CARILE | Puesto 182 | S/ 353.11 (SOCIOS / exact)
DO $b158$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '182' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ORDOÑEZ NICHO AZUL CARILE]', '182';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 353.11, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ORDOÑEZ NICHO AZUL CARILE')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b158$;

-- [159] SOCIO: TAIPE OQUENDO EUGENIO JOEL | Puesto 26 | S/ 264.86 (SOCIOS / fuzzy)
DO $b159$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '26' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [TAIPE OQUENDO EUGENIO JOEL]', '26';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 264.86, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · TAIPE OQUENDO EUGENIO JOEL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b159$;

-- [160] SOCIO: TELLO ALVAREZ MARINO | Puesto 44 | S/ 329.63 (SOCIOS / exact)
DO $b160$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '44' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [TELLO ALVAREZ MARINO]', '44';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 329.63, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · TELLO ALVAREZ MARINO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b160$;

-- [161] SOCIO: TELLO QUINTANA EDGAR ERASMO | Puesto 86 | S/ 379.51 (SOCIOS / token_subset)
DO $b161$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '86' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [TELLO QUINTANA EDGAR ERASMO]', '86';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 379.51, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · TELLO QUINTANA EDGAR ERASMO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b161$;

-- [162] SOCIO: TINEO CABRERA SONIA | Puesto 112 | S/ 148.42 (SOCIOS / exact)
DO $b162$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '112' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [TINEO CABRERA SONIA]', '112';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 148.42, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · TINEO CABRERA SONIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b162$;

-- [163] SOCIO: TINTAYA CAHUANA PATRICIA HERMENEGILDA | Puesto 72 | S/ 150.25 (SOCIOS / alias)
DO $b163$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '72' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [TINTAYA CAHUANA PATRICIA HERMENEGILDA]', '72';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 150.25, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · TINTAYA CAHUANA PATRICIA HERMENEGILDA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b163$;

-- [164] SOCIO: TITO FALCON JESUSA RICARDINA | Puesto 105 | S/ 313.02 (SOCIOS / exact)
DO $b164$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '105' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [TITO FALCON JESUSA RICARDINA]', '105';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 313.02, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · TITO FALCON JESUSA RICARDINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b164$;

-- [165] SOCIO: TORRES ANYOSA MARCELINO | Puesto 70 | S/ 1039.71 (SOCIOS / exact)
DO $b165$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '70' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [TORRES ANYOSA MARCELINO]', '70';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1039.71, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · TORRES ANYOSA MARCELINO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b165$;

-- [166] SOCIO: TORRES ASTO FRANCISCO CONTESOR | Puesto 189 | S/ 117.75 (SOCIOS / token_subset)
DO $b166$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '189' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [TORRES ASTO FRANCISCO CONTESOR]', '189';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 117.75, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · TORRES ASTO FRANCISCO CONTESOR')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b166$;

-- [167] SOCIO: TORRES ASTO SANTOS NERY (F) | Puesto 137 | S/ 70.41 (SOCIOS / token_subset)
DO $b167$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '137' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [TORRES ASTO SANTOS NERY (F)]', '137';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 70.41, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · TORRES ASTO SANTOS NERY (F)')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b167$;

-- [168] SOCIO: TORRES ASTO VDA DE CALDERON JUANA FRONILDA | Puesto 82 | S/ 2849.39 (SOCIOS / token_subset)
DO $b168$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '82' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [TORRES ASTO VDA DE CALDERON JUANA FRONILDA]', '82';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 2849.39, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · TORRES ASTO VDA DE CALDERON JUANA FRONILDA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b168$;

-- [169] SOCIO: URETA CRUZ EMILIA | Puesto 8 | S/ 368.93 (SOCIOS / exact)
DO $b169$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '8' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [URETA CRUZ EMILIA]', '8';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 368.93, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · URETA CRUZ EMILIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b169$;

-- [170] SOCIO: VALLEJOS HUAMAN MARIA ANA | Puesto 129 | S/ 150.87 (SOCIOS / token_subset)
DO $b170$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '129' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [VALLEJOS HUAMAN MARIA ANA]', '129';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 150.87, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · VALLEJOS HUAMAN MARIA ANA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b170$;

-- [171] SOCIO: VALENCIA TOMAS VICENTE DORIS | Puesto 116 | S/ 999.34 (SOCIOS / token_subset)
DO $b171$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '116' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [VALENCIA TOMAS VICENTE DORIS]', '116';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 999.34, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · VALENCIA TOMAS VICENTE DORIS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b171$;

-- [172] SOCIO: VALERO PARIONA MAXIMO ALBINO | Puesto 21 | S/ 157.91 (SOCIOS / token_subset)
DO $b172$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '21' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [VALERO PARIONA MAXIMO ALBINO]', '21';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 157.91, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · VALERO PARIONA MAXIMO ALBINO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b172$;

-- [173] SOCIO: VALERO SOTO  MAXIMO ELIAS | Puesto 153 | S/ 560.80 (SOCIOS / exact)
DO $b173$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '153' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [VALERO SOTO  MAXIMO ELIAS]', '153';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 560.80, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · VALERO SOTO  MAXIMO ELIAS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b173$;

-- [174] SOCIO: VALERO SOTO WILLY PERSEO | Puesto 22 | S/ 242.30 (SOCIOS / exact)
DO $b174$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '22' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [VALERO SOTO WILLY PERSEO]', '22';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 242.30, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · VALERO SOTO WILLY PERSEO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b174$;

-- [175] SOCIO: VALVERDE ROSAS JUAN MARCELINO | Puesto 54 | S/ 4592.80 (SOCIOS / exact)
DO $b175$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '54' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [VALVERDE ROSAS JUAN MARCELINO]', '54';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 4592.80, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · VALVERDE ROSAS JUAN MARCELINO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b175$;

-- [176] SOCIO: VARA CASTRO DELIA ERNESTINA (F) | Puesto 121 | S/ 83.62 (SOCIOS / token_subset)
DO $b176$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '121' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [VARA CASTRO DELIA ERNESTINA (F)]', '121';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 83.62, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · VARA CASTRO DELIA ERNESTINA (F)')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b176$;

-- [177] SOCIO: VARA DE ROSAS ALICIA VALENTINA | Puesto 118 | S/ 481.55 (SOCIOS / exact)
DO $b177$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '118' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [VARA DE ROSAS ALICIA VALENTINA]', '118';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 481.55, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · VARA DE ROSAS ALICIA VALENTINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b177$;

-- [178] SOCIO: VICENTE CALIXTO JOSE ALBERTO | Puesto 160 | S/ 314.68 (SOCIOS / exact)
DO $b178$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '160' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [VICENTE CALIXTO JOSE ALBERTO]', '160';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 314.68, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · VICENTE CALIXTO JOSE ALBERTO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b178$;

-- [179] SOCIO: VILCHEZ GUTARRA LOURDES FANNY | Puesto 91 | S/ 917.44 (SOCIOS / fuzzy)
DO $b179$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '91' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [VILCHEZ GUTARRA LOURDES FANNY]', '91';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 917.44, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · VILCHEZ GUTARRA LOURDES FANNY')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b179$;

-- [180] SOCIO: VILLANUEVA INGA DE VASQUEZ ROSA PRIMITIVA | Puesto 168 | S/ 283.73 (SOCIOS / token_subset)
DO $b180$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '168' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [VILLANUEVA INGA DE VASQUEZ ROSA PRIMITIVA]', '168';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 283.73, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · VILLANUEVA INGA DE VASQUEZ ROSA PRIMITIVA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b180$;

-- [181] SOCIO: YAURIMUCHA RIMACHI MARCOS | Puesto 23 | S/ 281.40 (SOCIOS / exact)
DO $b181$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '23' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [YAURIMUCHA RIMACHI MARCOS]', '23';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 281.40, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · YAURIMUCHA RIMACHI MARCOS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b181$;

-- [182] SOCIO: YRUPAILLA FALCON NILDA ADELINA | Puesto 66 | S/ 229.06 (SOCIOS / exact)
DO $b182$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '66' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [YRUPAILLA FALCON NILDA ADELINA]', '66';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 229.06, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · YRUPAILLA FALCON NILDA ADELINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b182$;

-- [183] SOCIO: YRUPAILLA ANAMPA ISIDRO BELISARIO | Puesto 111 | S/ 199.69 (SOCIOS / fuzzy)
DO $b183$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '111' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [YRUPAILLA ANAMPA ISIDRO BELISARIO]', '111';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 199.69, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · YRUPAILLA ANAMPA ISIDRO BELISARIO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b183$;

-- [184] SOCIO: ZAPATA VELIT VICTORIANO | Puesto 145 | S/ 681.27 (SOCIOS / exact)
DO $b184$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '145' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ZAPATA VELIT VICTORIANO]', '145';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 681.27, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ZAPATA VELIT VICTORIANO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b184$;

-- [185] SOCIO: ZAPATA RIVERA ROSANA | Puesto 141 | S/ 594.55 (SOCIOS / exact)
DO $b185$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '141' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ZAPATA RIVERA ROSANA]', '141';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 594.55, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ZAPATA RIVERA ROSANA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b185$;

-- [186] INQUILINO: AIRE MALPARTIDA  HECTOR | Puesto 31-E | S/ 236.90 (INQUILINOS / exact)
DO $b186$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '31-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [AIRE MALPARTIDA  HECTOR]', '31-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 236.90, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · AIRE MALPARTIDA  HECTOR')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b186$;

-- [187] INQUILINO: ALARCON ESPINOZA MARTHA ESPERANZA | Puesto 1-SP | S/ 606.00 (INQUILINOS / token_subset)
DO $b187$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ALARCON ESPINOZA MARTHA ESPERANZA]', '1-SP';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 606.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ALARCON ESPINOZA MARTHA ESPERANZA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b187$;

-- [188] INQUILINO: ALVAREZ CHIARA EDGAR  SALVADOR | Puesto 51-E | S/ 514.15 (INQUILINOS / exact)
DO $b188$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '51-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ALVAREZ CHIARA EDGAR  SALVADOR]', '51-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 514.15, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ALVAREZ CHIARA EDGAR  SALVADOR')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b188$;

-- [189] INQUILINO: ANCHAYA HUAMAN ABEL | Puesto 2-E | S/ 1999.95 (INQUILINOS / exact)
DO $b189$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '2-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ANCHAYA HUAMAN ABEL]', '2-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1999.95, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ANCHAYA HUAMAN ABEL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b189$;

-- [190] INQUILINO: ARMESTAR GODOS JUANA JACKELYNE | Puesto 29-E | S/ 241.55 (INQUILINOS / fuzzy)
DO $b190$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '29-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ARMESTAR GODOS JUANA JACKELYNE]', '29-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 241.55, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ARMESTAR GODOS JUANA JACKELYNE')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b190$;

-- [191] INQUILINO: ARREDONDO GARCIA GLADYS | Puesto 16-E | S/ 875.00 (INQUILINOS / exact)
DO $b191$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '16-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ARREDONDO GARCIA GLADYS]', '16-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 875.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ARREDONDO GARCIA GLADYS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b191$;

-- [192] INQUILINO: AVILA CHAVEZ ROSA MARINA | Puesto 40-E | S/ 55.00 (INQUILINOS / token_subset)
DO $b192$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '40-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [AVILA CHAVEZ ROSA MARINA]', '40-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 55.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · AVILA CHAVEZ ROSA MARINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b192$;

-- [193] INQUILINO: AYALA HUASHUAYO MARLENE ESTHER | Puesto 3-E | S/ 135.62 (INQUILINOS / token_subset)
DO $b193$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '3-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [AYALA HUASHUAYO MARLENE ESTHER]', '3-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 135.62, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · AYALA HUASHUAYO MARLENE ESTHER')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b193$;

-- [194] INQUILINO: BENITES TRIBIÑOS ERIKA | Puesto 12-E | S/ 515.00 (INQUILINOS / token_subset)
DO $b194$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '12-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [BENITES TRIBIÑOS ERIKA]', '12-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 515.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · BENITES TRIBIÑOS ERIKA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b194$;

-- [195] INQUILINO: BELLIDO DE LA TORRE DE CHUQUITAIPE ZENAIDA | Puesto 4-E | S/ 50.93 (INQUILINOS / exact)
DO $b195$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '4-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [BELLIDO DE LA TORRE DE CHUQUITAIPE ZENAIDA]', '4-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 50.93, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · BELLIDO DE LA TORRE DE CHUQUITAIPE ZENAIDA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b195$;

-- [196] INQUILINO: BURGA CARRASCO ELMER | Puesto 8-E | S/ 595.00 (INQUILINOS / exact)
DO $b196$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '8-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [BURGA CARRASCO ELMER]', '8-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 595.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · BURGA CARRASCO ELMER')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b196$;

-- [197] INQUILINO: BUSTAMANTE CHILON GRACIELA | Puesto 52-E | S/ 1026.00 (INQUILINOS / exact)
DO $b197$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '52-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [BUSTAMANTE CHILON GRACIELA]', '52-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1026.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · BUSTAMANTE CHILON GRACIELA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b197$;

-- [198] INQUILINO: CAHUANA PUCURIMAY ALEX ENRIQUE | Puesto 30-E | S/ 1311.08 (INQUILINOS / token_subset)
DO $b198$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '30-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CAHUANA PUCURIMAY ALEX ENRIQUE]', '30-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1311.08, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CAHUANA PUCURIMAY ALEX ENRIQUE')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b198$;

-- [199] INQUILINO: CCENCHO CARRASCO DAVID VICENTE | Puesto 23-E | S/ 530.00 (INQUILINOS / exact)
DO $b199$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '23-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CCENCHO CARRASCO DAVID VICENTE]', '23-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 530.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CCENCHO CARRASCO DAVID VICENTE')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b199$;

-- [200] INQUILINO: CASTILLO ZAPATA ESAEL | Puesto 1-E | S/ 742.05 (INQUILINOS / exact)
DO $b200$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '1-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CASTILLO ZAPATA ESAEL]', '1-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 742.05, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CASTILLO ZAPATA ESAEL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b200$;

-- [201] INQUILINO: CASTRO RODRIGUEZ JANETT CONSUELO | Puesto 37-E | S/ 509.13 (INQUILINOS / fuzzy)
DO $b201$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '37-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CASTRO RODRIGUEZ JANETT CONSUELO]', '37-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 509.13, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CASTRO RODRIGUEZ JANETT CONSUELO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b201$;

-- [202] INQUILINO: CAYO HUAMANI BACILIO ANTONIO | Puesto 1-EP | S/ 315.00 (INQUILINOS / alias)
DO $b202$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '1-EP' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CAYO HUAMANI BACILIO ANTONIO]', '1-EP';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 315.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CAYO HUAMANI BACILIO ANTONIO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b202$;

-- [203] INQUILINO: CERDAN  MUÑOZ MARIA DOMINGA | Puesto 25-E | S/ 15.00 (INQUILINOS / token_subset)
DO $b203$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '25-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CERDAN  MUÑOZ MARIA DOMINGA]', '25-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 15.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CERDAN  MUÑOZ MARIA DOMINGA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b203$;

-- [204] INQUILINO: CERVANTES GARCIA CARLOS ARTURO | Puesto 14-E | S/ 530.00 (INQUILINOS / exact)
DO $b204$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '14-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CERVANTES GARCIA CARLOS ARTURO]', '14-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 530.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CERVANTES GARCIA CARLOS ARTURO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b204$;

-- [205] INQUILINO: CHAMBI APAZA SIMONA | Puesto 38-E | S/ 545.00 (INQUILINOS / exact)
DO $b205$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '38-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CHAMBI APAZA SIMONA]', '38-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 545.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CHAMBI APAZA SIMONA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b205$;

-- [206] INQUILINO: CHOQUEHUANCA HUAMAN DERSE | Puesto 62-E | S/ 377.25 (INQUILINOS / exact)
DO $b206$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '62-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CHOQUEHUANCA HUAMAN DERSE]', '62-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 377.25, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CHOQUEHUANCA HUAMAN DERSE')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b206$;

-- [207] INQUILINO: CONDORI MAMANI LIDIA AGRIPINA | Puesto 43-E | S/ 541.18 (INQUILINOS / token_subset)
DO $b207$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '43-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CONDORI MAMANI LIDIA AGRIPINA]', '43-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 541.18, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CONDORI MAMANI LIDIA AGRIPINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b207$;

-- [208] INQUILINO: CLAROS TORRES SANTOS JESUS | Puesto 54-E | S/ 936.13 (INQUILINOS / token_subset)
DO $b208$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '54-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CLAROS TORRES SANTOS JESUS]', '54-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 936.13, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CLAROS TORRES SANTOS JESUS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b208$;

-- [209] INQUILINO: CUNIAS SANTOS MARIELA | Puesto 49-E | S/ 43.00 (INQUILINOS / token_subset)
DO $b209$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '49-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CUNIAS SANTOS MARIELA]', '49-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 43.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CUNIAS SANTOS MARIELA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b209$;

-- [210] INQUILINO: DAVILA HILARES YESENIA BEATRIZ | Puesto 22-E | S/ 530.00 (INQUILINOS / token_subset)
DO $b210$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '22-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [DAVILA HILARES YESENIA BEATRIZ]', '22-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 530.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · DAVILA HILARES YESENIA BEATRIZ')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b210$;

-- [211] INQUILINO: DURAN CHACON BLANCA NIEVES | Puesto 3-SP | S/ 637.00 (INQUILINOS / token_subset)
DO $b211$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [DURAN CHACON BLANCA NIEVES]', '3-SP';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 637.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · DURAN CHACON BLANCA NIEVES')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b211$;

-- [212] INQUILINO: ESPARTA CARDENAS JULIO HECTOR | Puesto 4-SP | S/ 924.00 (INQUILINOS / exact)
DO $b212$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ESPARTA CARDENAS JULIO HECTOR]', '4-SP';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 924.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ESPARTA CARDENAS JULIO HECTOR')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b212$;

-- [213] INQUILINO: FLORES LAREDO DOMINICIA LUCIANA | Puesto 44-E | S/ 560.50 (INQUILINOS / alias)
DO $b213$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '44-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [FLORES LAREDO DOMINICIA LUCIANA]', '44-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 560.50, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · FLORES LAREDO DOMINICIA LUCIANA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b213$;

-- [214] INQUILINO: GARCIA MEDINA VDA DE MOLINA CLEMENCIA BEATRIZ | Puesto 15-E | S/ 261.00 (INQUILINOS / exact)
DO $b214$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '15-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [GARCIA MEDINA VDA DE MOLINA CLEMENCIA BEATRIZ]', '15-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 261.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · GARCIA MEDINA VDA DE MOLINA CLEMENCIA BEATRIZ')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b214$;

-- [215] INQUILINO: GOMERO DULANTO MARGARITA JUANA | Puesto 60-E | S/ 43.18 (INQUILINOS / token_subset)
DO $b215$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '60-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [GOMERO DULANTO MARGARITA JUANA]', '60-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 43.18, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · GOMERO DULANTO MARGARITA JUANA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b215$;

-- [216] INQUILINO: GOMEZ MITMA MARIBEL | Puesto 48-E | S/ 1287.27 (INQUILINOS / exact)
DO $b216$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '48-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [GOMEZ MITMA MARIBEL]', '48-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1287.27, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · GOMEZ MITMA MARIBEL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b216$;

-- [217] INQUILINO: HERNANDEZ HERNANDEZ LILIBETH MARIA | Puesto 20-E | S/ 405.00 (INQUILINOS / token_subset)
DO $b217$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '20-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [HERNANDEZ HERNANDEZ LILIBETH MARIA]', '20-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 405.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · HERNANDEZ HERNANDEZ LILIBETH MARIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b217$;

-- [218] INQUILINO: AZURZA TRIBIÑOS DAYSI ELIZABETH | Puesto 11-E | S/ 515.00 (INQUILINOS / exact)
DO $b218$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '11-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [AZURZA TRIBIÑOS DAYSI ELIZABETH]', '11-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 515.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · AZURZA TRIBIÑOS DAYSI ELIZABETH')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b218$;

-- [219] INQUILINO: HERRERA PEVES ROMINA DEL CARMEN | Puesto 47-E | S/ 1915.34 (INQUILINOS / token_subset)
DO $b219$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '47-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [HERRERA PEVES ROMINA DEL CARMEN]', '47-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1915.34, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · HERRERA PEVES ROMINA DEL CARMEN')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b219$;

-- [220] INQUILINO: HERRERA CAMPOS ORFELITA | Puesto 50-E | S/ 673.33 (INQUILINOS / token_subset)
DO $b220$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '50-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [HERRERA CAMPOS ORFELITA]', '50-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 673.33, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · HERRERA CAMPOS ORFELITA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b220$;

-- [221] INQUILINO: HUAMANÍ CONTRERAS MAXIMO FLAVIO | Puesto 6-SP | S/ 460.00 (INQUILINOS / token_subset)
DO $b221$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '6-SP' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [HUAMANÍ CONTRERAS MAXIMO FLAVIO]', '6-SP';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 460.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · HUAMANÍ CONTRERAS MAXIMO FLAVIO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b221$;

-- [222] INQUILINO: LA ROSA LOPEZ MARGARITA LILIANA | Puesto 61-E | S/ 727.22 (INQUILINOS / token_subset)
DO $b222$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '61-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [LA ROSA LOPEZ MARGARITA LILIANA]', '61-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 727.22, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · LA ROSA LOPEZ MARGARITA LILIANA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b222$;

-- [223] INQUILINO: LAPAS ZALAZAR ANA MARIA | Puesto 26-E | S/ 30.00 (INQUILINOS / fuzzy)
DO $b223$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '26-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [LAPAS ZALAZAR ANA MARIA]', '26-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 30.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · LAPAS ZALAZAR ANA MARIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b223$;

-- [224] INQUILINO: CARRASCO PICHIHUA MERY RUTH | Puesto 24-E | S/ 530.00 (INQUILINOS / exact)
DO $b224$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '24-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CARRASCO PICHIHUA MERY RUTH]', '24-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 530.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CARRASCO PICHIHUA MERY RUTH')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b224$;

-- [225] INQUILINO: LEON RODRIGUEZ ANGIE MARGARITA | Puesto 33-E | S/ 768.28 (INQUILINOS / exact)
DO $b225$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '33-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [LEON RODRIGUEZ ANGIE MARGARITA]', '33-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 768.28, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · LEON RODRIGUEZ ANGIE MARGARITA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b225$;

-- [226] INQUILINO: LEONARDO AMARILLO ROSANA PILAR | Puesto 56-E | S/ 77.75 (INQUILINOS / exact)
DO $b226$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '56-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [LEONARDO AMARILLO ROSANA PILAR]', '56-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 77.75, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · LEONARDO AMARILLO ROSANA PILAR')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b226$;

-- [227] INQUILINO: LEONARDO AMARILLO FEDERICO MANUEL | Puesto 55-E | S/ 26.25 (INQUILINOS / exact)
DO $b227$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '55-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [LEONARDO AMARILLO FEDERICO MANUEL]', '55-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 26.25, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · LEONARDO AMARILLO FEDERICO MANUEL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b227$;

-- [228] INQUILINO: CERRON GALVAN OBDULIA | Puesto 2-SP | S/ 470.00 (INQUILINOS / exact)
DO $b228$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '2-SP' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CERRON GALVAN OBDULIA]', '2-SP';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 470.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CERRON GALVAN OBDULIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b228$;

-- [229] INQUILINO: KARINA LUZ LUCIANO INGA | Puesto 4-EP | S/ 300.00 (INQUILINOS / exact)
DO $b229$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '4-EP' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [KARINA LUZ LUCIANO INGA]', '4-EP';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 300.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · KARINA LUZ LUCIANO INGA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b229$;

-- [230] INQUILINO: ENCARNACION PAUCARPOMA GLADYS | Puesto 19-E | S/ 1060.00 (INQUILINOS / exact)
DO $b230$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '19-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ENCARNACION PAUCARPOMA GLADYS]', '19-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1060.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ENCARNACION PAUCARPOMA GLADYS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b230$;

-- [231] INQUILINO: COLINA CORREA SIRLEY KARINA | Puesto 32 | S/ 1400.70 (INQUILINOS / exact)
DO $b231$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '32' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [COLINA CORREA SIRLEY KARINA]', '32';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1400.70, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · COLINA CORREA SIRLEY KARINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b231$;

-- [232] INQUILINO: LOPEZ CERRON HAYDEE | Puesto 13-E | S/ 530.00 (INQUILINOS / exact)
DO $b232$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '13-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [LOPEZ CERRON HAYDEE]', '13-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 530.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · LOPEZ CERRON HAYDEE')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b232$;

-- [233] INQUILINO: MALLMA CONDORI LISBETH LUCIA | Puesto 58-E | S/ 883.85 (INQUILINOS / fuzzy)
DO $b233$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '58-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MALLMA CONDORI LISBETH LUCIA]', '58-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 883.85, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MALLMA CONDORI LISBETH LUCIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b233$;

-- [234] INQUILINO: MAYHUASCA BASTIDAS DORIS | Puesto 5-E | S/ 42.90 (INQUILINOS / exact)
DO $b234$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '5-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MAYHUASCA BASTIDAS DORIS]', '5-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 42.90, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MAYHUASCA BASTIDAS DORIS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b234$;

-- [235] INQUILINO: MIRANDA CACERES FELICITA | Puesto 27-E | S/ 68.30 (INQUILINOS / exact)
DO $b235$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '27-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MIRANDA CACERES FELICITA]', '27-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 68.30, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MIRANDA CACERES FELICITA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b235$;

-- [236] INQUILINO: MUJICA PALOMINO SANDRA LIZ | Puesto 59-E | S/ 895.78 (INQUILINOS / token_subset)
DO $b236$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '59-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MUJICA PALOMINO SANDRA LIZ]', '59-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 895.78, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MUJICA PALOMINO SANDRA LIZ')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b236$;

-- [237] INQUILINO: OBREGON CASTILLO FERNANDO MARTIN | Puesto 57-E | S/ 91.03 (INQUILINOS / token_subset)
DO $b237$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '57-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [OBREGON CASTILLO FERNANDO MARTIN]', '57-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 91.03, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · OBREGON CASTILLO FERNANDO MARTIN')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b237$;

-- [238] INQUILINO: PALOMINO CUSI  ROSA | Puesto 28-E | S/ 66.98 (INQUILINOS / exact)
DO $b238$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '28-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PALOMINO CUSI  ROSA]', '28-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 66.98, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PALOMINO CUSI  ROSA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b238$;

-- [239] INQUILINO: PEÑA VILLANUEVA ASHLEY MARYORI | Puesto 45 | S/ 30.93 (INQUILINOS / alias)
DO $b239$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '45' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PEÑA VILLANUEVA ASHLEY MARYORI]', '45';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 30.93, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PEÑA VILLANUEVA ASHLEY MARYORI')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b239$;

-- [240] INQUILINO: PEÑA VDA DE VILLANUEVA TERESA | Puesto 17-E | S/ 1236.00 (INQUILINOS / fuzzy)
DO $b240$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '17-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PEÑA VDA DE VILLANUEVA TERESA]', '17-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1236.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PEÑA VDA DE VILLANUEVA TERESA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b240$;

-- [241] INQUILINO: PFUÑO RAMOS VICTOR RAUL | Puesto 10-E | S/ 139.00 (INQUILINOS / token_subset)
DO $b241$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '10-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PFUÑO RAMOS VICTOR RAUL]', '10-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 139.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PFUÑO RAMOS VICTOR RAUL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b241$;

-- [242] INQUILINO: PRADO CATAÑO MIRIAM MILAGROS | Puesto 18-E | S/ 688.00 (INQUILINOS / exact)
DO $b242$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '18-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [PRADO CATAÑO MIRIAM MILAGROS]', '18-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 688.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · PRADO CATAÑO MIRIAM MILAGROS')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b242$;

-- [243] INQUILINO: QUISPE CHAVEZ MARI SOL | Puesto 53-E | S/ 549.00 (INQUILINOS / fuzzy)
DO $b243$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '53-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [QUISPE CHAVEZ MARI SOL]', '53-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 549.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · QUISPE CHAVEZ MARI SOL')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b243$;

-- [244] INQUILINO: QUISPE MAMANI PATRICIA PAOLA | Puesto 39-E | S/ 730.00 (INQUILINOS / exact)
DO $b244$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '39-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [QUISPE MAMANI PATRICIA PAOLA]', '39-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 730.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · QUISPE MAMANI PATRICIA PAOLA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b244$;

-- [245] INQUILINO: REBAZA REBAZA CASILDA CATALINA | Puesto 6-E | S/ 472.88 (INQUILINOS / token_subset)
DO $b245$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '6-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [REBAZA REBAZA CASILDA CATALINA]', '6-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 472.88, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · REBAZA REBAZA CASILDA CATALINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b245$;

-- [246] INQUILINO: SALAZAR VASQUEZ MARIA ROSARIO | Puesto 42-E | S/ 1020.68 (INQUILINOS / exact)
DO $b246$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '42-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SALAZAR VASQUEZ MARIA ROSARIO]', '42-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1020.68, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SALAZAR VASQUEZ MARIA ROSARIO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b246$;

-- [247] INQUILINO: SANCHEZ PRADO DIANA ZENAIDA | Puesto 46 | S/ 1020.46 (INQUILINOS / token_subset)
DO $b247$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '46' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SANCHEZ PRADO DIANA ZENAIDA]', '46';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1020.46, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SANCHEZ PRADO DIANA ZENAIDA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b247$;

-- [248] INQUILINO: YAURIMUCHA RIMACHI URSULA | Puesto 21-E | S/ 15.00 (INQUILINOS / exact)
DO $b248$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '21-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [YAURIMUCHA RIMACHI URSULA]', '21-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 15.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · YAURIMUCHA RIMACHI URSULA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b248$;

-- [249] INQUILINO: YAUYOS MENDIETA MARLENE | Puesto 9-E | S/ 956.00 (INQUILINOS / exact)
DO $b249$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '9-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [YAUYOS MENDIETA MARLENE]', '9-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 956.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · YAUYOS MENDIETA MARLENE')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b249$;

-- [250] INQUILINO: YUPANQUI QUISPE SAYDA | Puesto 41-E | S/ 232.55 (INQUILINOS / exact)
DO $b250$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '41-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [YUPANQUI QUISPE SAYDA]', '41-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 232.55, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · YUPANQUI QUISPE SAYDA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b250$;

-- [251] INQUILINO: ZANABRIA LADERA DE COCHACHI LILIA RUFINA | Puesto 7-E | S/ 33.65 (INQUILINOS / token_subset)
DO $b251$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '7-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ZANABRIA LADERA DE COCHACHI LILIA RUFINA]', '7-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 33.65, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ZANABRIA LADERA DE COCHACHI LILIA RUFINA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b251$;

-- [252] INQUILINO: ACCO NOA VICTOR | Puesto 5-D3 | S/ 300.00 (INQUILINOS / deposito_especial)
DO $b252$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '5-D3' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [ACCO NOA VICTOR]', '5-D3';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 300.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · ACCO NOA VICTOR')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b252$;

-- [253] INQUILINO: BUSTAMANTE JOSE | Puesto 4-D3 | S/ 750.00 (INQUILINOS / deposito_especial)
DO $b253$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [BUSTAMANTE JOSE]', '4-D3';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 750.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · BUSTAMANTE JOSE')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b253$;

-- [254] INQUILINO: SATALAYA TAPULIMA SEGUNDO ELVIS (traspaso a RENTERIA HUANCAS desde may-2026) | Puesto 32-E | S/ 2064.70 (INQUILINOS / hardcode)
DO $b254$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '32-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SATALAYA TAPULIMA SEGUNDO ELVIS (traspaso a RENTERIA HUANCAS desde may-2026)]', '32-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 2064.70, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SATALAYA TAPULIMA SEGUNDO ELVIS (traspaso a RENTERIA HUANCAS desde may-2026)')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b254$;

-- [255] INQUILINO: QUISPE NAPUCHE LISBETH KARITO | Puesto 6-EP | S/ 1220.00 (INQUILINOS / fuzzy)
DO $b255$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [QUISPE NAPUCHE LISBETH KARITO]', '6-EP';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1220.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · QUISPE NAPUCHE LISBETH KARITO')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b255$;

-- [256] INQUILINO: SUAREZ REBAZA LUIS ABRAHAM | Puesto 45-E | S/ 1000.00 (INQUILINOS / token_subset)
DO $b256$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '45-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SUAREZ REBAZA LUIS ABRAHAM]', '45-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1000.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SUAREZ REBAZA LUIS ABRAHAM')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b256$;

-- [257] INQUILINO: IDALINA MONTENEGRO BAUTISTA | Puesto 3-EP | S/ 160.00 (INQUILINOS / token_subset)
DO $b257$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '3-EP' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [IDALINA MONTENEGRO BAUTISTA]', '3-EP';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 160.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · IDALINA MONTENEGRO BAUTISTA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b257$;

-- [258] INQUILINO: MARILIN DEL CARMEN VERA | Puesto 5-EP | S/ 110.00 (INQUILINOS / exact)
DO $b258$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [MARILIN DEL CARMEN VERA]', '5-EP';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 110.00, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · MARILIN DEL CARMEN VERA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b258$;

-- [259] INQUILINO: CHOQUEHUANCA HUAMAN DAVID | Puesto 46-E | S/ 70.95 (INQUILINOS / exact)
DO $b259$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '46-E' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [CHOQUEHUANCA HUAMAN DAVID]', '46-E';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 70.95, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · CHOQUEHUANCA HUAMAN DAVID')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b259$;

-- [260] INQUILINO: SALDAÑA DONAYRE JESSICA PATRICIA | Puesto 52 | S/ 1889.11 (INQUILINOS / exact)
DO $b260$ DECLARE v_puesto bigint; v_concepto bigint; BEGIN
    SELECT id INTO v_puesto   FROM public.puestos   WHERE codigo_puesto = '52' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;
    IF v_puesto IS NULL THEN
        RAISE WARNING 'Puesto % no encontrado, omitiendo [SALDAÑA DONAYRE JESSICA PATRICIA]', '52';
    ELSE
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
        VALUES
            (v_puesto, v_concepto, 2025, 12, 1889.11, 'Pendiente', 'Manual', '2025-12-31'::date,
             'Saldo inicial migrado al 31-12-2025 · SALDAÑA DONAYRE JESSICA PATRICIA')
        ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
            WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
        DO NOTHING;
    END IF;
END $b260$;

-- --- Verificacion post-INSERT ----------------------------------------------
DO $$
DECLARE
    v_count   integer;
    v_suma    numeric;
    v_exp_cnt integer := 260;
    v_exp_sum numeric  := 116569.87;
BEGIN
    SELECT count(*), COALESCE(sum(monto), 0)
    INTO v_count, v_suma
    FROM public.montos_por_cobrar
    WHERE concepto_id = (SELECT id FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025')
      AND deleted_at IS NULL;

    RAISE NOTICE '=================================================';
    RAISE NOTICE '00038 Saldos Iniciales 2025 - Verificacion';
    RAISE NOTICE 'Filas en BD:  %  (esperado: %)',  v_count, v_exp_cnt;
    RAISE NOTICE 'Suma en BD:   S/ %  (esperado: S/ %)', v_suma, v_exp_sum;
    IF v_count <> v_exp_cnt THEN
        RAISE WARNING 'DISCREPANCIA en cantidad de filas';
    END IF;
    RAISE NOTICE '=================================================';
END $$;

COMMIT;