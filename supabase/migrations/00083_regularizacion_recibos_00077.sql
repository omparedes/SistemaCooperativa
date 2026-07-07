-- =============================================================================
-- Migración 00083 — Regularización de recibos migrados sin conceptos (00077)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- Generado: 2026-07-07 desde scripts/generar_regularizacion_00083.cjs
-- -----------------------------------------------------------------------------
-- La migración 00077 insertó 61 recibos con 174 conceptos "SIN DEUDA"
-- (sin fila en detalle_pagos), dejando recibos huérfanos o descuadrados.
-- Esta migración aplica el patrón de 00074: busca o crea la deuda en
-- montos_por_cobrar, inserta el detalle y recalcula el estado. Todo es
-- idempotente y los casos no resolubles se reportan con RAISE NOTICE
-- ("00083 SKIP ...") sin abortar la transacción del bloque.
-- También corrige el bug puntual del monto_id 10894 (dos depósitos del
-- mismo pago aplicados a la misma deuda).
-- Verificación posterior: scripts/deteccion_recibos_huerfanos.sql
-- =============================================================================

BEGIN;

-- =============================================================================
-- 1. Helper temporal (se elimina al final de esta migración)
-- =============================================================================
CREATE FUNCTION public._reg00083_linea(
    p_socio_id         bigint,
    p_fecha            timestamptz,
    p_monto_total      numeric,
    p_observacion      text,
    p_label            text,
    p_concepto_nombre  text,
    p_es_deposito      boolean,
    p_sufijo           text,
    p_puesto_principal bigint,
    p_anio             int,
    p_mes              int,
    p_monto            numeric,
    p_user             uuid
)
RETURNS void
LANGUAGE plpgsql
SET search_path = public
AS $fn$
DECLARE
    v_pago_id     bigint;
    v_concepto_id bigint;
    v_puesto_id   bigint;
    v_monto_id    bigint;
    v_deuda_monto numeric;
    v_estado      text;
    v_aplicado    numeric;
    v_n           int;
BEGIN
    -- 1. Localizar el recibo insertado por 00077
    SELECT id INTO v_pago_id
    FROM public.pagos
    WHERE socio_id    = p_socio_id
      AND fecha_pago  = p_fecha
      AND monto_total = p_monto_total
      AND observacion = p_observacion
      AND deleted_at IS NULL
    ORDER BY id
    LIMIT 1;

    IF v_pago_id IS NULL THEN
        RAISE NOTICE '00083 SKIP [pago no hallado] socio=% fecha=% total=% linea="%"',
            p_socio_id, p_fecha, p_monto_total, p_label;
        RETURN;
    END IF;

    -- 2. Concepto (mismo mapeo que el generador de 00077)
    SELECT id INTO v_concepto_id
    FROM public.conceptos
    WHERE nombre = p_concepto_nombre AND deleted_at IS NULL
    LIMIT 1;
    IF v_concepto_id IS NULL THEN
        RAISE NOTICE '00083 SKIP [concepto "%" no existe] pago=% linea="%"',
            p_concepto_nombre, v_pago_id, p_label;
        RETURN;
    END IF;

    -- 3. Puesto: principal, o almacén del socio para labels DEPOSITO*
    IF p_es_deposito THEN
        SELECT count(*), min(t.puesto_id) INTO v_n, v_puesto_id
        FROM (
            SELECT oa.puesto_id
            FROM public.ocupaciones_almacenes oa
            JOIN public.puestos pu ON pu.id = oa.puesto_id
            WHERE oa.socio_id = p_socio_id AND oa.fecha_fin IS NULL
              AND (p_sufijo IS NULL OR pu.codigo_puesto LIKE '%' || p_sufijo)
            UNION
            SELECT ht.puesto_id
            FROM public.historial_titularidad ht
            JOIN public.puestos pu ON pu.id = ht.puesto_id
            WHERE ht.socio_id = p_socio_id AND ht.fecha_fin IS NULL
              AND pu.tipo_espacio = 'Almacen'
              AND (p_sufijo IS NULL OR pu.codigo_puesto LIKE '%' || p_sufijo)
        ) t;

        IF v_n <> 1 OR v_puesto_id IS NULL THEN
            RAISE NOTICE '00083 SKIP [almacén no resuelto: % candidatos] pago=% socio=% linea="%"',
                v_n, v_pago_id, p_socio_id, p_label;
            RETURN;
        END IF;
    ELSE
        v_puesto_id := p_puesto_principal;
    END IF;

    -- 4. Deuda: buscar por la clave única (puesto, concepto, periodo) o crearla
    SELECT mc.id, mc.monto, mc.estado INTO v_monto_id, v_deuda_monto, v_estado
    FROM public.montos_por_cobrar mc
    WHERE mc.puesto_id = v_puesto_id AND mc.concepto_id = v_concepto_id
      AND mc.periodo_anio = p_anio AND mc.periodo_mes = p_mes
      AND mc.deleted_at IS NULL
    LIMIT 1;

    IF v_monto_id IS NULL THEN
        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado,
             metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES
            (v_puesto_id, v_concepto_id, p_anio, p_mes, p_monto, 'Pendiente',
             'Manual', current_date,
             'Regularización 00083: concepto "' || p_label || '" de recibo migrado en 00077',
             p_user)
        RETURNING id, monto, estado INTO v_monto_id, v_deuda_monto, v_estado;
    ELSE
        IF v_estado = 'Cancelado' THEN
            RAISE NOTICE '00083 SKIP [deuda % ya Cancelada] pago=% linea="%"',
                v_monto_id, v_pago_id, p_label;
            RETURN;
        END IF;
        SELECT coalesce(sum(dp.monto_aplicado), 0) INTO v_aplicado
        FROM public.detalle_pagos dp
        WHERE dp.monto_id = v_monto_id AND dp.deleted_at IS NULL;
        IF v_deuda_monto - v_aplicado <= 0.005 THEN
            RAISE NOTICE '00083 SKIP [deuda % ya saldada] pago=% linea="%"',
                v_monto_id, v_pago_id, p_label;
            RETURN;
        END IF;
    END IF;

    -- 5. Detalle (idempotente por pago+monto)
    IF NOT EXISTS (
        SELECT 1 FROM public.detalle_pagos
        WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL
    ) THEN
        INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by)
        VALUES (v_pago_id, v_monto_id, p_monto, p_user);
    END IF;

    -- 6. Recalcular estado (nunca pisar Cancelado)
    SELECT coalesce(sum(dp.monto_aplicado), 0) INTO v_aplicado
    FROM public.detalle_pagos dp
    WHERE dp.monto_id = v_monto_id AND dp.deleted_at IS NULL;

    UPDATE public.montos_por_cobrar
    SET estado = CASE WHEN v_aplicado >= monto - 0.005 THEN 'Pagado' ELSE 'Pendiente' END
    WHERE id = v_monto_id AND estado <> 'Cancelado';
END;
$fn$;

-- =============================================================================
-- 2. Fix puntual: monto_id 10894 recibió DOS depósitos del mismo pago
--    (00077 líneas 163-169: "DEPOSITO 2026/05" y "DEPOSITO 10 - D2 2026/05",
--    ambas de S/100 sobre una deuda de S/200 — la deuda del segundo almacén
--    no recibió su abono). Se reubica el segundo detalle en la deuda del
--    otro almacén del socio, creándola (S/200, monto del Excel) si no existe.
--    Solo se toca algo si el destino es resoluble; si no, NOTICE y sin cambios.
-- =============================================================================
DO $$
DECLARE
    v_user          uuid;
    v_pago_id       bigint;
    v_socio         bigint;
    v_dup_id        bigint;
    v_dup_monto     numeric;
    v_concepto_dep  bigint;
    v_puesto_10894  bigint;
    v_destino_id    bigint;
    v_puesto_dest   bigint;
    v_n             int;
    v_aplicado      numeric;
BEGIN
    SELECT id INTO v_user FROM public.perfiles WHERE rol = 'Administrador' AND activo = true LIMIT 1;
    IF v_user IS NULL THEN v_user := '00000000-0000-0000-0000-000000000000'; END IF;

    -- Pago con más de un detalle activo sobre 10894
    SELECT dp.pago_id INTO v_pago_id
    FROM public.detalle_pagos dp
    WHERE dp.monto_id = 10894 AND dp.deleted_at IS NULL
    GROUP BY dp.pago_id
    HAVING count(*) > 1
    LIMIT 1;

    IF v_pago_id IS NULL THEN
        RAISE NOTICE '00083: duplicado sobre monto 10894 no encontrado (nada que corregir).';
        RETURN;
    END IF;

    SELECT socio_id INTO v_socio FROM public.pagos WHERE id = v_pago_id;
    SELECT puesto_id INTO v_puesto_10894 FROM public.montos_por_cobrar WHERE id = 10894;
    SELECT id INTO v_concepto_dep FROM public.conceptos WHERE nombre = 'Deposito' AND deleted_at IS NULL LIMIT 1;

    -- Detalle sobrante (el de mayor id = segunda línea del pago en 00077)
    SELECT id, monto_aplicado INTO v_dup_id, v_dup_monto
    FROM public.detalle_pagos
    WHERE pago_id = v_pago_id AND monto_id = 10894 AND deleted_at IS NULL
    ORDER BY id DESC
    LIMIT 1;

    -- Destino: deuda Deposito 2026/05 de OTRO almacén del socio
    SELECT count(*), min(mc.id) INTO v_n, v_destino_id
    FROM public.montos_por_cobrar mc
    WHERE mc.concepto_id = v_concepto_dep
      AND mc.periodo_anio = 2026 AND mc.periodo_mes = 5
      AND mc.id <> 10894 AND mc.deleted_at IS NULL
      AND mc.puesto_id IN (
          SELECT oa.puesto_id FROM public.ocupaciones_almacenes oa
          WHERE oa.socio_id = v_socio AND oa.fecha_fin IS NULL
          UNION
          SELECT ht.puesto_id FROM public.historial_titularidad ht
          JOIN public.puestos pu ON pu.id = ht.puesto_id
          WHERE ht.socio_id = v_socio AND ht.fecha_fin IS NULL AND pu.tipo_espacio = 'Almacen'
      );

    IF v_destino_id IS NULL THEN
        -- No existe: crearla en el almacén del socio que NO es el de 10894
        SELECT count(*), min(t.puesto_id) INTO v_n, v_puesto_dest
        FROM (
            SELECT oa.puesto_id FROM public.ocupaciones_almacenes oa
            WHERE oa.socio_id = v_socio AND oa.fecha_fin IS NULL
            UNION
            SELECT ht.puesto_id FROM public.historial_titularidad ht
            JOIN public.puestos pu ON pu.id = ht.puesto_id
            WHERE ht.socio_id = v_socio AND ht.fecha_fin IS NULL AND pu.tipo_espacio = 'Almacen'
        ) t
        WHERE t.puesto_id <> v_puesto_10894;

        IF v_n <> 1 OR v_puesto_dest IS NULL THEN
            RAISE NOTICE '00083 SKIP [fix 10894: segundo almacén no resoluble, candidatos=%] — sin cambios.', v_n;
            RETURN;
        END IF;

        INSERT INTO public.montos_por_cobrar
            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado,
             metodo_calculo, fecha_generacion, observacion, created_by)
        VALUES
            (v_puesto_dest, v_concepto_dep, 2026, 5, 200.00, 'Pendiente',
             'Manual', current_date,
             'Regularización 00083: deuda "DEPOSITO 10 - D2 2026/05" del recibo de 00077 que fue aplicado por error al monto 10894',
             v_user)
        RETURNING id INTO v_destino_id;
    END IF;

    -- Reubicación: soft-delete del detalle duplicado + detalle correcto
    UPDATE public.detalle_pagos
    SET deleted_at       = now(),
        anulado_por      = v_user,
        motivo_anulacion = 'Regularización 00083: detalle duplicado — 00077 aplicó dos depósitos distintos al mismo monto_id 10894'
    WHERE id = v_dup_id;

    IF NOT EXISTS (
        SELECT 1 FROM public.detalle_pagos
        WHERE pago_id = v_pago_id AND monto_id = v_destino_id AND deleted_at IS NULL
    ) THEN
        INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by)
        VALUES (v_pago_id, v_destino_id, v_dup_monto, v_user);
    END IF;

    -- Recalcular estados de ambas deudas
    SELECT coalesce(sum(monto_aplicado), 0) INTO v_aplicado
    FROM public.detalle_pagos WHERE monto_id = 10894 AND deleted_at IS NULL;
    UPDATE public.montos_por_cobrar
    SET estado = CASE WHEN v_aplicado >= monto - 0.005 THEN 'Pagado' ELSE 'Pendiente' END
    WHERE id = 10894 AND estado <> 'Cancelado';

    SELECT coalesce(sum(monto_aplicado), 0) INTO v_aplicado
    FROM public.detalle_pagos WHERE monto_id = v_destino_id AND deleted_at IS NULL;
    UPDATE public.montos_por_cobrar
    SET estado = CASE WHEN v_aplicado >= monto - 0.005 THEN 'Pagado' ELSE 'Pendiente' END
    WHERE id = v_destino_id AND estado <> 'Cancelado';

    RAISE NOTICE '00083: fix 10894 aplicado — detalle % reubicado a la deuda %.', v_dup_id, v_destino_id;
END $$;

-- =============================================================================
-- 3. Regularización de las 173 líneas "SIN DEUDA" de 00077
-- =============================================================================
DO $$
DECLARE
    v_user uuid;
BEGIN
    SELECT id INTO v_user FROM public.perfiles WHERE rol = 'Administrador' AND activo = true LIMIT 1;
    IF v_user IS NULL THEN v_user := '00000000-0000-0000-0000-000000000000'; END IF;

    -- ── Pago socio=1 · 2026-06-22 · S/ 249.50 ──
    PERFORM public._reg00083_linea(1, '2026-06-22T12:00:00+00:00'::timestamptz, 249.50, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, DEPOSITO 6 - D2 2026/04', 'LUZ', 'Luz', false, NULL, 229, 2026, 4, 43.50, v_user);
    PERFORM public._reg00083_linea(1, '2026-06-22T12:00:00+00:00'::timestamptz, 249.50, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, DEPOSITO 6 - D2 2026/04', 'AGUA', 'Agua', false, NULL, 229, 2026, 4, 6.00, v_user);
    PERFORM public._reg00083_linea(1, '2026-06-22T12:00:00+00:00'::timestamptz, 249.50, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, DEPOSITO 6 - D2 2026/04', 'DEPOSITO 6 - D2', 'Deposito', true, '6-D2', 229, 2026, 4, 200.00, v_user);

    -- ── Pago socio=2 · 2026-06-22 · S/ 140.00 ──
    PERFORM public._reg00083_linea(2, '2026-06-22T12:00:00+00:00'::timestamptz, 140.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05', 'LUZ', 'Luz', false, NULL, 160, 2026, 4, 40.50, v_user);
    PERFORM public._reg00083_linea(2, '2026-06-22T12:00:00+00:00'::timestamptz, 140.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05', 'AGUA', 'Agua', false, NULL, 160, 2026, 4, 6.00, v_user);
    PERFORM public._reg00083_linea(2, '2026-06-22T12:00:00+00:00'::timestamptz, 140.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05', 'G. ADM', 'Gastos administrativos', false, NULL, 160, 2026, 4, 60.00, v_user);
    PERFORM public._reg00083_linea(2, '2026-06-22T12:00:00+00:00'::timestamptz, 140.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05', 'P. SOCIAL', 'Previsión social', false, NULL, 160, 2026, 4, 5.00, v_user);

    -- ── Pago socio=6 · 2026-06-17 · S/ 65.00 ──
    PERFORM public._reg00083_linea(6, '2026-06-17T12:00:00+00:00'::timestamptz, 65.00, 'Pago 16-30 jun 2026: G. ADM 2026/06, P. SOCIAL 2026/06', 'G. ADM', 'Gastos administrativos', false, NULL, 250, 2026, 6, 60.00, v_user);
    PERFORM public._reg00083_linea(6, '2026-06-17T12:00:00+00:00'::timestamptz, 65.00, 'Pago 16-30 jun 2026: G. ADM 2026/06, P. SOCIAL 2026/06', 'P. SOCIAL', 'Previsión social', false, NULL, 250, 2026, 6, 5.00, v_user);

    -- ── Pago socio=7 · 2026-06-25 · S/ 50.00 ──
    PERFORM public._reg00083_linea(7, '2026-06-25T12:00:00+00:00'::timestamptz, 50.00, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03', 'LUZ', 'Luz', false, NULL, 176, 2026, 3, 7.70, v_user);
    PERFORM public._reg00083_linea(7, '2026-06-25T12:00:00+00:00'::timestamptz, 50.00, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03', 'AGUA', 'Agua', false, NULL, 176, 2026, 3, 6.00, v_user);
    PERFORM public._reg00083_linea(7, '2026-06-25T12:00:00+00:00'::timestamptz, 50.00, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03', 'G. ADM', 'Gastos administrativos', false, NULL, 176, 2026, 3, 36.30, v_user);

    -- ── Pago socio=17 · 2026-06-25 · S/ 369.00 ──
    PERFORM public._reg00083_linea(17, '2026-06-25T12:00:00+00:00'::timestamptz, 369.00, 'Pago 16-30 jun 2026: MULTA 27/11/2025 2026/11, G. ADM 2026/03, P. SOCIAL 2026/03, MULTA 27/11/2025 2026/03, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'MULTA 27/11/2025', 'Otros', false, NULL, 66, 2026, 11, 56.50, v_user);
    PERFORM public._reg00083_linea(17, '2026-06-25T12:00:00+00:00'::timestamptz, 369.00, 'Pago 16-30 jun 2026: MULTA 27/11/2025 2026/11, G. ADM 2026/03, P. SOCIAL 2026/03, MULTA 27/11/2025 2026/03, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'MULTA 27/11/2025', 'Otros', false, NULL, 66, 2026, 3, 56.50, v_user);

    -- ── Pago socio=18 · 2026-06-22 · S/ 25.30 ──
    PERFORM public._reg00083_linea(18, '2026-06-22T12:00:00+00:00'::timestamptz, 25.30, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'LUZ', 'Luz', false, NULL, 203, 2026, 4, 8.10, v_user);
    PERFORM public._reg00083_linea(18, '2026-06-22T12:00:00+00:00'::timestamptz, 25.30, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'AGUA', 'Agua', false, NULL, 203, 2026, 4, 6.00, v_user);

    -- ── Pago socio=20 · 2026-06-24 · S/ 190.30 ──
    PERFORM public._reg00083_linea(20, '2026-06-24T12:00:00+00:00'::timestamptz, 190.30, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04', 'LUZ', 'Luz', false, NULL, 254, 2026, 4, 55.90, v_user);
    PERFORM public._reg00083_linea(20, '2026-06-24T12:00:00+00:00'::timestamptz, 190.30, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04', 'AGUA', 'Agua', false, NULL, 254, 2026, 4, 134.40, v_user);

    -- ── Pago socio=31 · 2026-06-25 · S/ 180.20 ──
    PERFORM public._reg00083_linea(31, '2026-06-25T12:00:00+00:00'::timestamptz, 180.20, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'LUZ', 'Luz', false, NULL, 185, 2026, 3, 49.00, v_user);
    PERFORM public._reg00083_linea(31, '2026-06-25T12:00:00+00:00'::timestamptz, 180.20, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'AGUA', 'Agua', false, NULL, 185, 2026, 3, 13.40, v_user);
    PERFORM public._reg00083_linea(31, '2026-06-25T12:00:00+00:00'::timestamptz, 180.20, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'LUZ', 'Luz', false, NULL, 185, 2026, 4, 49.40, v_user);
    PERFORM public._reg00083_linea(31, '2026-06-25T12:00:00+00:00'::timestamptz, 180.20, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'AGUA', 'Agua', false, NULL, 185, 2026, 4, 12.50, v_user);

    -- ── Pago socio=32 · 2026-06-25 · S/ 85.40 ──
    PERFORM public._reg00083_linea(32, '2026-06-25T12:00:00+00:00'::timestamptz, 85.40, 'Pago 16-30 jun 2026: G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05', 'G. ADM', 'Gastos administrativos', false, NULL, 175, 2026, 3, 25.00, v_user);
    PERFORM public._reg00083_linea(32, '2026-06-25T12:00:00+00:00'::timestamptz, 85.40, 'Pago 16-30 jun 2026: G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05', 'P. SOCIAL', 'Previsión social', false, NULL, 175, 2026, 3, 5.00, v_user);
    PERFORM public._reg00083_linea(32, '2026-06-25T12:00:00+00:00'::timestamptz, 85.40, 'Pago 16-30 jun 2026: G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05', 'LUZ', 'Luz', false, NULL, 175, 2026, 4, 21.60, v_user);
    PERFORM public._reg00083_linea(32, '2026-06-25T12:00:00+00:00'::timestamptz, 85.40, 'Pago 16-30 jun 2026: G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05', 'AGUA', 'Agua', false, NULL, 175, 2026, 4, 6.00, v_user);
    PERFORM public._reg00083_linea(32, '2026-06-25T12:00:00+00:00'::timestamptz, 85.40, 'Pago 16-30 jun 2026: G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05', 'FUMIGACION', 'Otros', false, NULL, 175, 2026, 4, 5.00, v_user);

    -- ── Pago socio=34 · 2026-06-17 · S/ 447.00 ──
    PERFORM public._reg00083_linea(34, '2026-06-17T12:00:00+00:00'::timestamptz, 447.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'LUZ', 'Luz', false, NULL, 70, 2026, 4, 185.00, v_user);
    PERFORM public._reg00083_linea(34, '2026-06-17T12:00:00+00:00'::timestamptz, 447.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'AGUA', 'Agua', false, NULL, 70, 2026, 4, 6.00, v_user);

    -- ── Pago socio=37 · 2026-06-16 · S/ 125.80 ──
    PERFORM public._reg00083_linea(37, '2026-06-16T12:00:00+00:00'::timestamptz, 125.80, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04', 'LUZ', 'Luz', false, NULL, 205, 2026, 3, 20.00, v_user);
    PERFORM public._reg00083_linea(37, '2026-06-16T12:00:00+00:00'::timestamptz, 125.80, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04', 'AGUA', 'Agua', false, NULL, 205, 2026, 3, 32.40, v_user);
    PERFORM public._reg00083_linea(37, '2026-06-16T12:00:00+00:00'::timestamptz, 125.80, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04', 'G. ADM', 'Gastos administrativos', false, NULL, 205, 2026, 3, 40.00, v_user);
    PERFORM public._reg00083_linea(37, '2026-06-16T12:00:00+00:00'::timestamptz, 125.80, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04', 'P. SOCIAL', 'Previsión social', false, NULL, 205, 2026, 3, 5.00, v_user);
    PERFORM public._reg00083_linea(37, '2026-06-16T12:00:00+00:00'::timestamptz, 125.80, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04', 'LUZ', 'Luz', false, NULL, 205, 2026, 4, 22.40, v_user);
    PERFORM public._reg00083_linea(37, '2026-06-16T12:00:00+00:00'::timestamptz, 125.80, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04', 'AGUA', 'Agua', false, NULL, 205, 2026, 4, 6.00, v_user);

    -- ── Pago socio=39 · 2026-06-16 · S/ 239.50 ──
    PERFORM public._reg00083_linea(39, '2026-06-16T12:00:00+00:00'::timestamptz, 239.50, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05', 'LUZ', 'Luz', false, NULL, 132, 2026, 3, 14.50, v_user);
    PERFORM public._reg00083_linea(39, '2026-06-16T12:00:00+00:00'::timestamptz, 239.50, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05', 'AGUA', 'Agua', false, NULL, 132, 2026, 3, 6.00, v_user);
    PERFORM public._reg00083_linea(39, '2026-06-16T12:00:00+00:00'::timestamptz, 239.50, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05', 'G. ADM', 'Gastos administrativos', false, NULL, 132, 2026, 3, 60.00, v_user);
    PERFORM public._reg00083_linea(39, '2026-06-16T12:00:00+00:00'::timestamptz, 239.50, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05', 'P. SOCIAL', 'Previsión social', false, NULL, 132, 2026, 3, 5.00, v_user);
    PERFORM public._reg00083_linea(39, '2026-06-16T12:00:00+00:00'::timestamptz, 239.50, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05', 'LUZ', 'Luz', false, NULL, 132, 2026, 4, 18.00, v_user);
    PERFORM public._reg00083_linea(39, '2026-06-16T12:00:00+00:00'::timestamptz, 239.50, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05', 'AGUA', 'Agua', false, NULL, 132, 2026, 4, 6.00, v_user);
    PERFORM public._reg00083_linea(39, '2026-06-16T12:00:00+00:00'::timestamptz, 239.50, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05', 'G. ADM', 'Gastos administrativos', false, NULL, 132, 2026, 4, 60.00, v_user);
    PERFORM public._reg00083_linea(39, '2026-06-16T12:00:00+00:00'::timestamptz, 239.50, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05', 'P. SOCIAL', 'Previsión social', false, NULL, 132, 2026, 4, 5.00, v_user);

    -- ── Pago socio=45 · 2026-06-19 · S/ 216.90 ──
    PERFORM public._reg00083_linea(45, '2026-06-19T12:00:00+00:00'::timestamptz, 216.90, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04', 'LUZ', 'Luz', false, NULL, 90, 2026, 3, 94.90, v_user);
    PERFORM public._reg00083_linea(45, '2026-06-19T12:00:00+00:00'::timestamptz, 216.90, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04', 'AGUA', 'Agua', false, NULL, 90, 2026, 3, 6.00, v_user);
    PERFORM public._reg00083_linea(45, '2026-06-19T12:00:00+00:00'::timestamptz, 216.90, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04', 'LUZ', 'Luz', false, NULL, 90, 2026, 4, 45.00, v_user);
    PERFORM public._reg00083_linea(45, '2026-06-19T12:00:00+00:00'::timestamptz, 216.90, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04', 'AGUA', 'Agua', false, NULL, 90, 2026, 4, 6.00, v_user);
    PERFORM public._reg00083_linea(45, '2026-06-19T12:00:00+00:00'::timestamptz, 216.90, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04', 'G. ADM', 'Gastos administrativos', false, NULL, 90, 2026, 4, 60.00, v_user);
    PERFORM public._reg00083_linea(45, '2026-06-19T12:00:00+00:00'::timestamptz, 216.90, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04', 'P. SOCIAL', 'Previsión social', false, NULL, 90, 2026, 4, 5.00, v_user);

    -- ── Pago socio=57 · 2026-06-16 · S/ 331.80 ──
    PERFORM public._reg00083_linea(57, '2026-06-16T12:00:00+00:00'::timestamptz, 331.80, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04', 'LUZ', 'Luz', false, NULL, 190, 2026, 4, 214.70, v_user);
    PERFORM public._reg00083_linea(57, '2026-06-16T12:00:00+00:00'::timestamptz, 331.80, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04', 'AGUA', 'Agua', false, NULL, 190, 2026, 4, 52.10, v_user);
    PERFORM public._reg00083_linea(57, '2026-06-16T12:00:00+00:00'::timestamptz, 331.80, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04', 'G. ADM', 'Gastos administrativos', false, NULL, 190, 2026, 4, 60.00, v_user);
    PERFORM public._reg00083_linea(57, '2026-06-16T12:00:00+00:00'::timestamptz, 331.80, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04', 'P. SOCIAL', 'Previsión social', false, NULL, 190, 2026, 4, 5.00, v_user);

    -- ── Pago socio=60 · 2026-06-16 · S/ 722.00 ──
    PERFORM public._reg00083_linea(60, '2026-06-16T12:00:00+00:00'::timestamptz, 722.00, 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, LUZ 2026/06', 'LUZ', 'Luz', false, NULL, 247, 2026, 6, 0.70, v_user);

    -- ── Pago socio=64 · 2026-06-22 · S/ 162.00 ──
    PERFORM public._reg00083_linea(64, '2026-06-22T12:00:00+00:00'::timestamptz, 162.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'LUZ', 'Luz', false, NULL, 204, 2026, 4, 37.80, v_user);
    PERFORM public._reg00083_linea(64, '2026-06-22T12:00:00+00:00'::timestamptz, 162.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'AGUA', 'Agua', false, NULL, 204, 2026, 4, 12.90, v_user);

    -- ── Pago socio=66 · 2026-06-24 · S/ 100.00 ──
    PERFORM public._reg00083_linea(66, '2026-06-24T12:00:00+00:00'::timestamptz, 100.00, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04', 'LUZ', 'Luz', false, NULL, 180, 2026, 3, 5.00, v_user);
    PERFORM public._reg00083_linea(66, '2026-06-24T12:00:00+00:00'::timestamptz, 100.00, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04', 'AGUA', 'Agua', false, NULL, 180, 2026, 3, 6.00, v_user);
    PERFORM public._reg00083_linea(66, '2026-06-24T12:00:00+00:00'::timestamptz, 100.00, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04', 'G. ADM', 'Gastos administrativos', false, NULL, 180, 2026, 3, 60.00, v_user);
    PERFORM public._reg00083_linea(66, '2026-06-24T12:00:00+00:00'::timestamptz, 100.00, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04', 'P. SOCIAL', 'Previsión social', false, NULL, 180, 2026, 3, 5.00, v_user);
    PERFORM public._reg00083_linea(66, '2026-06-24T12:00:00+00:00'::timestamptz, 100.00, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04', 'LUZ', 'Luz', false, NULL, 180, 2026, 4, 5.00, v_user);
    PERFORM public._reg00083_linea(66, '2026-06-24T12:00:00+00:00'::timestamptz, 100.00, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04', 'AGUA', 'Agua', false, NULL, 180, 2026, 4, 6.00, v_user);
    PERFORM public._reg00083_linea(66, '2026-06-24T12:00:00+00:00'::timestamptz, 100.00, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04', 'G. ADM', 'Gastos administrativos', false, NULL, 180, 2026, 4, 13.00, v_user);

    -- ── Pago socio=78 · 2026-06-19 · S/ 10.00 ──
    PERFORM public._reg00083_linea(78, '2026-06-19T12:00:00+00:00'::timestamptz, 10.00, 'Pago 16-30 jun 2026: USO DE LUZ 2026/06', 'USO DE LUZ', 'Luz', false, NULL, 183, 2026, 6, 10.00, v_user);

    -- ── Pago socio=78 · 2026-06-24 · S/ 10.00 ──
    PERFORM public._reg00083_linea(78, '2026-06-24T12:00:00+00:00'::timestamptz, 10.00, 'Pago 16-30 jun 2026: USO DE LUZ 2026/06', 'USO DE LUZ', 'Luz', false, NULL, 183, 2026, 6, 10.00, v_user);

    -- ── Pago socio=83 · 2026-06-20 · S/ 146.70 ──
    PERFORM public._reg00083_linea(83, '2026-06-20T12:00:00+00:00'::timestamptz, 146.70, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04', 'LUZ', 'Luz', false, NULL, 272, 2026, 4, 120.00, v_user);
    PERFORM public._reg00083_linea(83, '2026-06-20T12:00:00+00:00'::timestamptz, 146.70, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04', 'AGUA', 'Agua', false, NULL, 272, 2026, 4, 26.70, v_user);

    -- ── Pago socio=87 · 2026-06-22 · S/ 168.90 ──
    PERFORM public._reg00083_linea(87, '2026-06-22T12:00:00+00:00'::timestamptz, 168.90, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'LUZ', 'Luz', false, NULL, 270, 2026, 3, 37.50, v_user);
    PERFORM public._reg00083_linea(87, '2026-06-22T12:00:00+00:00'::timestamptz, 168.90, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'AGUA', 'Agua', false, NULL, 270, 2026, 3, 6.00, v_user);
    PERFORM public._reg00083_linea(87, '2026-06-22T12:00:00+00:00'::timestamptz, 168.90, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'LUZ', 'Luz', false, NULL, 270, 2026, 4, 39.80, v_user);
    PERFORM public._reg00083_linea(87, '2026-06-22T12:00:00+00:00'::timestamptz, 168.90, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'AGUA', 'Agua', false, NULL, 270, 2026, 4, 6.00, v_user);

    -- ── Pago socio=88 · 2026-06-17 · S/ 100.00 ──
    PERFORM public._reg00083_linea(88, '2026-06-17T12:00:00+00:00'::timestamptz, 100.00, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, DEPOSITO 5 - D1 2026/03', 'LUZ', 'Luz', false, NULL, 177, 2026, 3, 22.20, v_user);
    PERFORM public._reg00083_linea(88, '2026-06-17T12:00:00+00:00'::timestamptz, 100.00, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, DEPOSITO 5 - D1 2026/03', 'AGUA', 'Agua', false, NULL, 177, 2026, 3, 6.00, v_user);
    PERFORM public._reg00083_linea(88, '2026-06-17T12:00:00+00:00'::timestamptz, 100.00, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, DEPOSITO 5 - D1 2026/03', 'G. ADM + G. ADM', 'Gastos administrativos', false, NULL, 177, 2026, 3, 60.00, v_user);
    PERFORM public._reg00083_linea(88, '2026-06-17T12:00:00+00:00'::timestamptz, 100.00, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, DEPOSITO 5 - D1 2026/03', 'P. SOCIAL', 'Previsión social', false, NULL, 177, 2026, 3, 5.00, v_user);
    PERFORM public._reg00083_linea(88, '2026-06-17T12:00:00+00:00'::timestamptz, 100.00, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, DEPOSITO 5 - D1 2026/03', 'DEPOSITO 5 - D1', 'Deposito', true, '5-D1', 177, 2026, 3, 6.80, v_user);

    -- ── Pago socio=95 · 2026-06-26 · S/ 92.80 ──
    PERFORM public._reg00083_linea(95, '2026-06-26T12:00:00+00:00'::timestamptz, 92.80, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'LUZ', 'Luz', false, NULL, 268, 2026, 4, 8.40, v_user);
    PERFORM public._reg00083_linea(95, '2026-06-26T12:00:00+00:00'::timestamptz, 92.80, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'AGUA', 'Agua', false, NULL, 268, 2026, 4, 6.00, v_user);

    -- ── Pago socio=90 · 2026-06-16 · S/ 469.10 ──
    PERFORM public._reg00083_linea(90, '2026-06-16T12:00:00+00:00'::timestamptz, 469.10, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04', 'LUZ', 'Luz', false, NULL, 230, 2026, 4, 401.00, v_user);
    PERFORM public._reg00083_linea(90, '2026-06-16T12:00:00+00:00'::timestamptz, 469.10, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04', 'AGUA', 'Agua', false, NULL, 230, 2026, 4, 33.10, v_user);
    PERFORM public._reg00083_linea(90, '2026-06-16T12:00:00+00:00'::timestamptz, 469.10, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04', 'G. ADM', 'Gastos administrativos', false, NULL, 230, 2026, 4, 30.00, v_user);
    PERFORM public._reg00083_linea(90, '2026-06-16T12:00:00+00:00'::timestamptz, 469.10, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04', 'P. SOCIAL', 'Previsión social', false, NULL, 230, 2026, 4, 5.00, v_user);

    -- ── Pago socio=91 · 2026-06-26 · S/ 135.60 ──
    PERFORM public._reg00083_linea(91, '2026-06-26T12:00:00+00:00'::timestamptz, 135.60, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'LUZ', 'Luz', false, NULL, 280, 2026, 3, 13.40, v_user);
    PERFORM public._reg00083_linea(91, '2026-06-26T12:00:00+00:00'::timestamptz, 135.60, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'AGUA', 'Agua', false, NULL, 280, 2026, 3, 34.20, v_user);
    PERFORM public._reg00083_linea(91, '2026-06-26T12:00:00+00:00'::timestamptz, 135.60, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'LUZ', 'Luz', false, NULL, 280, 2026, 4, 14.10, v_user);
    PERFORM public._reg00083_linea(91, '2026-06-26T12:00:00+00:00'::timestamptz, 135.60, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'AGUA', 'Agua', false, NULL, 280, 2026, 4, 40.60, v_user);

    -- ── Pago socio=96 · 2026-06-25 · S/ 351.00 ──
    PERFORM public._reg00083_linea(96, '2026-06-25T12:00:00+00:00'::timestamptz, 351.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'LUZ', 'Luz', false, NULL, 29, 2026, 4, 135.00, v_user);
    PERFORM public._reg00083_linea(96, '2026-06-25T12:00:00+00:00'::timestamptz, 351.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'AGUA', 'Agua', false, NULL, 29, 2026, 4, 6.00, v_user);

    -- ── Pago socio=98 · 2026-06-25 · S/ 1521.30 ──
    PERFORM public._reg00083_linea(98, '2026-06-25T12:00:00+00:00'::timestamptz, 1521.30, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'LUZ', 'Luz', false, NULL, 217, 2026, 4, 805.70, v_user);
    PERFORM public._reg00083_linea(98, '2026-06-25T12:00:00+00:00'::timestamptz, 1521.30, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'AGUA', 'Agua', false, NULL, 217, 2026, 4, 28.60, v_user);

    -- ── Pago socio=99 · 2026-06-17 · S/ 751.90 ──
    PERFORM public._reg00083_linea(99, '2026-06-17T12:00:00+00:00'::timestamptz, 751.90, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, DEPOSITO 4 - D1 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06, DEPOSITO 4 - D1 2026/06', 'LUZ', 'Luz', false, NULL, 201, 2026, 4, 108.80, v_user);
    PERFORM public._reg00083_linea(99, '2026-06-17T12:00:00+00:00'::timestamptz, 751.90, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, DEPOSITO 4 - D1 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06, DEPOSITO 4 - D1 2026/06', 'AGUA', 'Agua', false, NULL, 201, 2026, 4, 6.00, v_user);
    PERFORM public._reg00083_linea(99, '2026-06-17T12:00:00+00:00'::timestamptz, 751.90, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, DEPOSITO 4 - D1 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06, DEPOSITO 4 - D1 2026/06', 'G. ADM', 'Gastos administrativos', false, NULL, 201, 2026, 6, 60.00, v_user);
    PERFORM public._reg00083_linea(99, '2026-06-17T12:00:00+00:00'::timestamptz, 751.90, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, DEPOSITO 4 - D1 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06, DEPOSITO 4 - D1 2026/06', 'P. SOCIAL', 'Previsión social', false, NULL, 201, 2026, 6, 5.00, v_user);
    PERFORM public._reg00083_linea(99, '2026-06-17T12:00:00+00:00'::timestamptz, 751.90, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, DEPOSITO 4 - D1 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06, DEPOSITO 4 - D1 2026/06', 'DEPOSITO 4 - D1', 'Deposito', true, '4-D1', 201, 2026, 6, 200.00, v_user);

    -- ── Pago socio=108 · 2026-06-17 · S/ 200.10 ──
    PERFORM public._reg00083_linea(108, '2026-06-17T12:00:00+00:00'::timestamptz, 200.10, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05', 'LUZ', 'Luz', false, NULL, 279, 2026, 4, 154.50, v_user);
    PERFORM public._reg00083_linea(108, '2026-06-17T12:00:00+00:00'::timestamptz, 200.10, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05', 'AGUA', 'Agua', false, NULL, 279, 2026, 4, 10.60, v_user);

    -- ── Pago socio=110 · 2026-06-22 · S/ 392.10 ──
    PERFORM public._reg00083_linea(110, '2026-06-22T12:00:00+00:00'::timestamptz, 392.10, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04', 'LUZ', 'Luz', false, NULL, 259, 2026, 4, 306.20, v_user);
    PERFORM public._reg00083_linea(110, '2026-06-22T12:00:00+00:00'::timestamptz, 392.10, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04', 'AGUA', 'Agua', false, NULL, 259, 2026, 4, 85.90, v_user);

    -- ── Pago socio=112 · 2026-06-19 · S/ 559.80 ──
    PERFORM public._reg00083_linea(112, '2026-06-19T12:00:00+00:00'::timestamptz, 559.80, 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05', 'LUZ', 'Luz', false, NULL, 242, 2026, 5, 519.10, v_user);
    PERFORM public._reg00083_linea(112, '2026-06-19T12:00:00+00:00'::timestamptz, 559.80, 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05', 'AGUA', 'Agua', false, NULL, 242, 2026, 5, 40.70, v_user);

    -- ── Pago socio=116 · 2026-06-26 · S/ 190.10 ──
    PERFORM public._reg00083_linea(116, '2026-06-26T12:00:00+00:00'::timestamptz, 190.10, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'LUZ', 'Luz', false, NULL, 281, 2026, 5, 53.00, v_user);
    PERFORM public._reg00083_linea(116, '2026-06-26T12:00:00+00:00'::timestamptz, 190.10, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'AGUA', 'Agua', false, NULL, 281, 2026, 5, 6.00, v_user);
    PERFORM public._reg00083_linea(116, '2026-06-26T12:00:00+00:00'::timestamptz, 190.10, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'G. ADM', 'Gastos administrativos', false, NULL, 281, 2026, 5, 60.00, v_user);
    PERFORM public._reg00083_linea(116, '2026-06-26T12:00:00+00:00'::timestamptz, 190.10, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'P. SOCIAL', 'Previsión social', false, NULL, 281, 2026, 5, 5.00, v_user);

    -- ── Pago socio=122 · 2026-06-18 · S/ 106.20 ──
    PERFORM public._reg00083_linea(122, '2026-06-18T12:00:00+00:00'::timestamptz, 106.20, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'LUZ', 'Luz', false, NULL, 192, 2026, 5, 26.20, v_user);
    PERFORM public._reg00083_linea(122, '2026-06-18T12:00:00+00:00'::timestamptz, 106.20, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'AGUA', 'Agua', false, NULL, 192, 2026, 5, 6.00, v_user);

    -- ── Pago socio=126 · 2026-06-17 · S/ 417.50 ──
    PERFORM public._reg00083_linea(126, '2026-06-17T12:00:00+00:00'::timestamptz, 417.50, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05', 'G. ADM', 'Gastos administrativos', false, NULL, 227, 2026, 5, 30.00, v_user);
    PERFORM public._reg00083_linea(126, '2026-06-17T12:00:00+00:00'::timestamptz, 417.50, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05', 'P. SOCIAL', 'Previsión social', false, NULL, 227, 2026, 5, 5.00, v_user);

    -- ── Pago socio=123 · 2026-06-23 · S/ 666.70 ──
    PERFORM public._reg00083_linea(123, '2026-06-23T12:00:00+00:00'::timestamptz, 666.70, 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05', 'LUZ', 'Luz', false, NULL, 210, 2026, 5, 653.30, v_user);
    PERFORM public._reg00083_linea(123, '2026-06-23T12:00:00+00:00'::timestamptz, 666.70, 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05', 'AGUA', 'Agua', false, NULL, 210, 2026, 5, 13.40, v_user);

    -- ── Pago socio=131 · 2026-06-26 · S/ 232.40 ──
    PERFORM public._reg00083_linea(131, '2026-06-26T12:00:00+00:00'::timestamptz, 232.40, 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05', 'LUZ', 'Luz', false, NULL, 222, 2026, 5, 217.40, v_user);
    PERFORM public._reg00083_linea(131, '2026-06-26T12:00:00+00:00'::timestamptz, 232.40, 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05', 'AGUA', 'Agua', false, NULL, 222, 2026, 5, 15.00, v_user);

    -- ── Pago socio=135 · 2026-06-24 · S/ 283.80 ──
    PERFORM public._reg00083_linea(135, '2026-06-24T12:00:00+00:00'::timestamptz, 283.80, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'LUZ', 'Luz', false, NULL, 237, 2026, 4, 5.00, v_user);
    PERFORM public._reg00083_linea(135, '2026-06-24T12:00:00+00:00'::timestamptz, 283.80, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'AGUA', 'Agua', false, NULL, 237, 2026, 4, 6.00, v_user);
    PERFORM public._reg00083_linea(135, '2026-06-24T12:00:00+00:00'::timestamptz, 283.80, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'LUZ', 'Luz', false, NULL, 237, 2026, 5, 11.20, v_user);
    PERFORM public._reg00083_linea(135, '2026-06-24T12:00:00+00:00'::timestamptz, 283.80, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05', 'AGUA', 'Agua', false, NULL, 237, 2026, 5, 261.60, v_user);

    -- ── Pago socio=138 · 2026-06-26 · S/ 831.50 ──
    PERFORM public._reg00083_linea(138, '2026-06-26T12:00:00+00:00'::timestamptz, 831.50, 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'LUZ', 'Luz', false, NULL, 274, 2026, 5, 753.40, v_user);
    PERFORM public._reg00083_linea(138, '2026-06-26T12:00:00+00:00'::timestamptz, 831.50, 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'AGUA', 'Agua', false, NULL, 274, 2026, 5, 13.10, v_user);
    PERFORM public._reg00083_linea(138, '2026-06-26T12:00:00+00:00'::timestamptz, 831.50, 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'G. ADM', 'Gastos administrativos', false, NULL, 274, 2026, 5, 60.00, v_user);
    PERFORM public._reg00083_linea(138, '2026-06-26T12:00:00+00:00'::timestamptz, 831.50, 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'P. SOCIAL', 'Previsión social', false, NULL, 274, 2026, 5, 5.00, v_user);

    -- ── Pago socio=141 · 2026-06-18 · S/ 345.60 ──
    PERFORM public._reg00083_linea(141, '2026-06-18T12:00:00+00:00'::timestamptz, 345.60, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04', 'LUZ', 'Luz', false, NULL, 246, 2026, 4, 298.50, v_user);
    PERFORM public._reg00083_linea(141, '2026-06-18T12:00:00+00:00'::timestamptz, 345.60, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04', 'AGUA', 'Agua', false, NULL, 246, 2026, 4, 47.10, v_user);

    -- ── Pago socio=145 · 2026-06-23 · S/ 65.00 ──
    PERFORM public._reg00083_linea(145, '2026-06-23T12:00:00+00:00'::timestamptz, 65.00, 'Pago 16-30 jun 2026: G. ADM 2026/06, P. SOCIAL 2026/06', 'G. ADM', 'Gastos administrativos', false, NULL, 110, 2026, 6, 60.00, v_user);
    PERFORM public._reg00083_linea(145, '2026-06-23T12:00:00+00:00'::timestamptz, 65.00, 'Pago 16-30 jun 2026: G. ADM 2026/06, P. SOCIAL 2026/06', 'P. SOCIAL', 'Previsión social', false, NULL, 110, 2026, 6, 5.00, v_user);

    -- ── Pago socio=142 · 2026-06-16 · S/ 123.10 ──
    PERFORM public._reg00083_linea(142, '2026-06-16T12:00:00+00:00'::timestamptz, 123.10, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04', 'LUZ', 'Luz', false, NULL, 15, 2026, 3, 61.10, v_user);
    PERFORM public._reg00083_linea(142, '2026-06-16T12:00:00+00:00'::timestamptz, 123.10, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04', 'AGUA', 'Agua', false, NULL, 15, 2026, 3, 6.00, v_user);
    PERFORM public._reg00083_linea(142, '2026-06-16T12:00:00+00:00'::timestamptz, 123.10, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04', 'LUZ', 'Luz', false, NULL, 15, 2026, 4, 50.00, v_user);
    PERFORM public._reg00083_linea(142, '2026-06-16T12:00:00+00:00'::timestamptz, 123.10, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04', 'AGUA', 'Agua', false, NULL, 15, 2026, 4, 6.00, v_user);

    -- ── Pago socio=146 · 2026-06-16 · S/ 139.20 ──
    PERFORM public._reg00083_linea(146, '2026-06-16T12:00:00+00:00'::timestamptz, 139.20, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04', 'LUZ', 'Luz', false, NULL, 36, 2026, 3, 67.20, v_user);
    PERFORM public._reg00083_linea(146, '2026-06-16T12:00:00+00:00'::timestamptz, 139.20, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04', 'AGUA', 'Agua', false, NULL, 36, 2026, 3, 6.00, v_user);
    PERFORM public._reg00083_linea(146, '2026-06-16T12:00:00+00:00'::timestamptz, 139.20, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04', 'LUZ', 'Luz', false, NULL, 36, 2026, 4, 60.00, v_user);
    PERFORM public._reg00083_linea(146, '2026-06-16T12:00:00+00:00'::timestamptz, 139.20, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04', 'AGUA', 'Agua', false, NULL, 36, 2026, 4, 6.00, v_user);

    -- ── Pago socio=150 · 2026-06-19 · S/ 100.00 ──
    PERFORM public._reg00083_linea(150, '2026-06-19T12:00:00+00:00'::timestamptz, 100.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04', 'LUZ', 'Luz', false, NULL, 284, 2026, 4, 63.30, v_user);
    PERFORM public._reg00083_linea(150, '2026-06-19T12:00:00+00:00'::timestamptz, 100.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04', 'AGUA', 'Agua', false, NULL, 284, 2026, 4, 36.70, v_user);

    -- ── Pago socio=151 · 2026-06-22 · S/ 205.00 ──
    PERFORM public._reg00083_linea(151, '2026-06-22T12:00:00+00:00'::timestamptz, 205.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'LUZ', 'Luz', false, NULL, 162, 2026, 4, 29.00, v_user);
    PERFORM public._reg00083_linea(151, '2026-06-22T12:00:00+00:00'::timestamptz, 205.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'AGUA', 'Agua', false, NULL, 162, 2026, 4, 6.00, v_user);
    PERFORM public._reg00083_linea(151, '2026-06-22T12:00:00+00:00'::timestamptz, 205.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'G. ADM', 'Gastos administrativos', false, NULL, 162, 2026, 4, 60.00, v_user);
    PERFORM public._reg00083_linea(151, '2026-06-22T12:00:00+00:00'::timestamptz, 205.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'P. SOCIAL', 'Previsión social', false, NULL, 162, 2026, 4, 5.00, v_user);
    PERFORM public._reg00083_linea(151, '2026-06-22T12:00:00+00:00'::timestamptz, 205.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'FUMIGACION', 'Otros', false, NULL, 162, 2026, 4, 5.00, v_user);
    PERFORM public._reg00083_linea(151, '2026-06-22T12:00:00+00:00'::timestamptz, 205.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'LUZ', 'Luz', false, NULL, 162, 2026, 5, 29.00, v_user);
    PERFORM public._reg00083_linea(151, '2026-06-22T12:00:00+00:00'::timestamptz, 205.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'AGUA', 'Agua', false, NULL, 162, 2026, 5, 6.00, v_user);
    PERFORM public._reg00083_linea(151, '2026-06-22T12:00:00+00:00'::timestamptz, 205.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'G. ADM', 'Gastos administrativos', false, NULL, 162, 2026, 5, 60.00, v_user);
    PERFORM public._reg00083_linea(151, '2026-06-22T12:00:00+00:00'::timestamptz, 205.00, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'P. SOCIAL', 'Previsión social', false, NULL, 162, 2026, 5, 5.00, v_user);

    -- ── Pago socio=157 · 2026-06-24 · S/ 211.40 ──
    PERFORM public._reg00083_linea(157, '2026-06-24T12:00:00+00:00'::timestamptz, 211.40, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'LUZ', 'Luz', false, NULL, 181, 2026, 4, 38.80, v_user);
    PERFORM public._reg00083_linea(157, '2026-06-24T12:00:00+00:00'::timestamptz, 211.40, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'AGUA', 'Agua', false, NULL, 181, 2026, 4, 6.00, v_user);
    PERFORM public._reg00083_linea(157, '2026-06-24T12:00:00+00:00'::timestamptz, 211.40, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'G. ADM', 'Gastos administrativos', false, NULL, 181, 2026, 4, 60.00, v_user);
    PERFORM public._reg00083_linea(157, '2026-06-24T12:00:00+00:00'::timestamptz, 211.40, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'P. SOCIAL', 'Previsión social', false, NULL, 181, 2026, 4, 5.00, v_user);
    PERFORM public._reg00083_linea(157, '2026-06-24T12:00:00+00:00'::timestamptz, 211.40, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'LUZ', 'Luz', false, NULL, 181, 2026, 5, 30.60, v_user);
    PERFORM public._reg00083_linea(157, '2026-06-24T12:00:00+00:00'::timestamptz, 211.40, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'AGUA', 'Agua', false, NULL, 181, 2026, 5, 6.00, v_user);
    PERFORM public._reg00083_linea(157, '2026-06-24T12:00:00+00:00'::timestamptz, 211.40, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'G. ADM', 'Gastos administrativos', false, NULL, 181, 2026, 5, 60.00, v_user);
    PERFORM public._reg00083_linea(157, '2026-06-24T12:00:00+00:00'::timestamptz, 211.40, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'P. SOCIAL', 'Previsión social', false, NULL, 181, 2026, 5, 5.00, v_user);

    -- ── Pago socio=158 · 2026-06-17 · S/ 26.80 ──
    PERFORM public._reg00083_linea(158, '2026-06-17T12:00:00+00:00'::timestamptz, 26.80, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04', 'LUZ', 'Luz', false, NULL, 193, 2026, 3, 7.20, v_user);
    PERFORM public._reg00083_linea(158, '2026-06-17T12:00:00+00:00'::timestamptz, 26.80, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04', 'AGUA', 'Agua', false, NULL, 193, 2026, 3, 6.00, v_user);
    PERFORM public._reg00083_linea(158, '2026-06-17T12:00:00+00:00'::timestamptz, 26.80, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04', 'LUZ', 'Luz', false, NULL, 193, 2026, 4, 7.60, v_user);
    PERFORM public._reg00083_linea(158, '2026-06-17T12:00:00+00:00'::timestamptz, 26.80, 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04', 'AGUA', 'Agua', false, NULL, 193, 2026, 4, 6.00, v_user);

    -- ── Pago socio=172 · 2026-06-26 · S/ 31.40 ──
    PERFORM public._reg00083_linea(172, '2026-06-26T12:00:00+00:00'::timestamptz, 31.40, 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05', 'LUZ', 'Luz', false, NULL, 248, 2026, 5, 25.40, v_user);
    PERFORM public._reg00083_linea(172, '2026-06-26T12:00:00+00:00'::timestamptz, 31.40, 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05', 'AGUA', 'Agua', false, NULL, 248, 2026, 5, 6.00, v_user);

    -- ── Pago socio=177 · 2026-06-23 · S/ 283.30 ──
    PERFORM public._reg00083_linea(177, '2026-06-23T12:00:00+00:00'::timestamptz, 283.30, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04', 'LUZ', 'Luz', false, NULL, 213, 2026, 4, 192.70, v_user);
    PERFORM public._reg00083_linea(177, '2026-06-23T12:00:00+00:00'::timestamptz, 283.30, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04', 'AGUA', 'Agua', false, NULL, 213, 2026, 4, 90.60, v_user);

    -- ── Pago socio=178 · 2026-06-24 · S/ 200.00 ──
    PERFORM public._reg00083_linea(178, '2026-06-24T12:00:00+00:00'::timestamptz, 200.00, 'Pago 16-30 jun 2026: DEPOSITO 5 - D2 2026/03', 'DEPOSITO 5 - D2', 'Deposito', true, '5-D2', 255, 2026, 3, 200.00, v_user);

    -- ── Pago socio=180 · 2026-06-24 · S/ 478.90 ──
    PERFORM public._reg00083_linea(180, '2026-06-24T12:00:00+00:00'::timestamptz, 478.90, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, DEPOSITO 6 - D1 2026/04, LUZ 2026/05, AGUA 2026/05, DEPOSITO 6 - D1 2026/05', 'LUZ', 'Luz', false, NULL, 263, 2026, 4, 36.30, v_user);
    PERFORM public._reg00083_linea(180, '2026-06-24T12:00:00+00:00'::timestamptz, 478.90, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, DEPOSITO 6 - D1 2026/04, LUZ 2026/05, AGUA 2026/05, DEPOSITO 6 - D1 2026/05', 'AGUA', 'Agua', false, NULL, 263, 2026, 4, 6.00, v_user);
    PERFORM public._reg00083_linea(180, '2026-06-24T12:00:00+00:00'::timestamptz, 478.90, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, DEPOSITO 6 - D1 2026/04, LUZ 2026/05, AGUA 2026/05, DEPOSITO 6 - D1 2026/05', 'DEPOSITO 6 - D1', 'Deposito', true, '6-D1', 263, 2026, 4, 200.00, v_user);
    PERFORM public._reg00083_linea(180, '2026-06-24T12:00:00+00:00'::timestamptz, 478.90, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, DEPOSITO 6 - D1 2026/04, LUZ 2026/05, AGUA 2026/05, DEPOSITO 6 - D1 2026/05', 'LUZ', 'Luz', false, NULL, 263, 2026, 5, 30.60, v_user);
    PERFORM public._reg00083_linea(180, '2026-06-24T12:00:00+00:00'::timestamptz, 478.90, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, DEPOSITO 6 - D1 2026/04, LUZ 2026/05, AGUA 2026/05, DEPOSITO 6 - D1 2026/05', 'AGUA', 'Agua', false, NULL, 263, 2026, 5, 6.00, v_user);
    PERFORM public._reg00083_linea(180, '2026-06-24T12:00:00+00:00'::timestamptz, 478.90, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, DEPOSITO 6 - D1 2026/04, LUZ 2026/05, AGUA 2026/05, DEPOSITO 6 - D1 2026/05', 'DEPOSITO 6 - D1', 'Deposito', true, '6-D1', 263, 2026, 5, 200.00, v_user);

    -- ── Pago socio=182 · 2026-06-17 · S/ 77.00 ──
    PERFORM public._reg00083_linea(182, '2026-06-17T12:00:00+00:00'::timestamptz, 77.00, 'Pago 16-30 jun 2026: AGUA 2026/04, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'AGUA', 'Agua', false, NULL, 206, 2026, 4, 6.00, v_user);
    PERFORM public._reg00083_linea(182, '2026-06-17T12:00:00+00:00'::timestamptz, 77.00, 'Pago 16-30 jun 2026: AGUA 2026/04, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'AGUA', 'Agua', false, NULL, 206, 2026, 5, 6.00, v_user);
    PERFORM public._reg00083_linea(182, '2026-06-17T12:00:00+00:00'::timestamptz, 77.00, 'Pago 16-30 jun 2026: AGUA 2026/04, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'G. ADM', 'Gastos administrativos', false, NULL, 206, 2026, 5, 60.00, v_user);
    PERFORM public._reg00083_linea(182, '2026-06-17T12:00:00+00:00'::timestamptz, 77.00, 'Pago 16-30 jun 2026: AGUA 2026/04, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05', 'P. SOCIAL', 'Previsión social', false, NULL, 206, 2026, 5, 5.00, v_user);

    -- ── Pago socio=184 · 2026-06-24 · S/ 261.40 ──
    PERFORM public._reg00083_linea(184, '2026-06-24T12:00:00+00:00'::timestamptz, 261.40, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04', 'LUZ', 'Luz', false, NULL, 236, 2026, 4, 88.60, v_user);
    PERFORM public._reg00083_linea(184, '2026-06-24T12:00:00+00:00'::timestamptz, 261.40, 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04', 'AGUA', 'Agua', false, NULL, 236, 2026, 4, 172.80, v_user);

END $$;

-- =============================================================================
-- 4. Limpieza del helper
-- =============================================================================
DROP FUNCTION public._reg00083_linea(bigint, timestamptz, numeric, text, text, text, boolean, text, bigint, int, int, numeric, uuid);

COMMIT;
