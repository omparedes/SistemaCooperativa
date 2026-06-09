-- =============================================================================
-- Migración 00066 — Reclasificar conceptos de deudas erróneamente en Otros (18)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- =============================================================================

DO $$
BEGIN
    -- 0. Corregir periodos de las multas específicas para evitar conflictos de clave única
    -- Puesto 248, MULTA 11/07/24 (id: 10280) -> periodo 2024-07, concepto 6
    UPDATE public.montos_por_cobrar
    SET periodo_anio = 2024, fecha_generacion = '2024-07-01', concepto_id = 6
    WHERE id = 10280;

    -- Puesto 248, MULTA 27/03/25 (id: 10281) -> periodo 2025-03
    UPDATE public.montos_por_cobrar
    SET periodo_anio = 2025, fecha_generacion = '2025-03-01'
    WHERE id = 10281;

    -- Puesto 29, MULTA 07/03/24 (id: 8486) -> periodo 2024-03, concepto 6
    UPDATE public.montos_por_cobrar
    SET periodo_anio = 2024, fecha_generacion = '2024-03-01', concepto_id = 6
    WHERE id = 8486;

    -- Puesto 29, MULTA 27/03/25 (id: 8488) -> periodo 2025-03
    UPDATE public.montos_por_cobrar
    SET periodo_anio = 2025, fecha_generacion = '2025-03-01'
    WHERE id = 8488;

    -- Puesto 29, MULTA 11/07/24 (id: 8487) -> periodo 2024-07, concepto 6
    UPDATE public.montos_por_cobrar
    SET periodo_anio = 2024, fecha_generacion = '2024-07-01', concepto_id = 6
    WHERE id = 8487;

    -- 1. Reclasificar resto de multas (concepto_id = 6)
    UPDATE public.montos_por_cobrar
    SET concepto_id = 6
    WHERE concepto_id = 18
      AND (observacion LIKE '%MULTA%' OR observacion LIKE '%Multa%');

    -- 2. Reclasificar depósitos (concepto_id = 16)
    UPDATE public.montos_por_cobrar
    SET concepto_id = 16
    WHERE concepto_id = 18
      AND (observacion LIKE '%DEPOSITO%' OR observacion LIKE '%Deposito%');

    -- 3. Reclasificar fallecimientos (concepto_id = 19)
    UPDATE public.montos_por_cobrar
    SET concepto_id = 19
    WHERE concepto_id = 18
      AND (observacion LIKE '%FALL.%' OR observacion LIKE '%FALL %' OR observacion LIKE '%FALLEC%');

    -- 4. Reclasificar aportes extraordinarios (concepto_id = 7)
    UPDATE public.montos_por_cobrar
    SET concepto_id = 7
    WHERE concepto_id = 18
      AND (observacion LIKE '%EXTRAORDINARIO%' OR observacion LIKE '%Extraordinario%');
END;
$$;
