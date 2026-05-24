-- =============================================================================
-- Migración 00039 — Corrección Saldo Inicial 2025: MAYHUASCA BASTIDAS
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- Generado: 2026-05-18
-- -----------------------------------------------------------------------------
-- PROBLEMA DETECTADO (migración 00038):
--   El algoritmo de matching asignó "MAYHUASCA BASTIDAS GLUDDY" (Excel item 92,
--   S/ 714.63) por fuzzy match al puesto 186 (MARILU), cuando en realidad es:
--     MAYHUASCA BASTIDAS DE TORRES CLUDDY AYDE → Puesto 135
--
--   El resultado en BD quedó:
--     Puesto 186: monto = 714.63  ← incorrecto (pertenece a GLUDDY/puesto 135)
--     Puesto 135: sin saldo inicial ← faltante
--     Puesto 186: debería tener S/ 506.49 (de MAYHUASCA BASTIDAS MARILU)
--
-- CORRECCIÓN:
--   1. UPDATE puesto 186: monto 714.63 → 506.49
--   2. INSERT puesto 135: S/ 714.63 (MAYHUASCA BASTIDAS DE TORRES CLUDDY AYDE)
-- =============================================================================

BEGIN;

DO $$
DECLARE
    v_puesto_186  bigint;
    v_puesto_135  bigint;
    v_concepto    bigint;
BEGIN
    SELECT id INTO v_puesto_186 FROM public.puestos WHERE codigo_puesto = '186' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_puesto_135 FROM public.puestos WHERE codigo_puesto = '135' AND deleted_at IS NULL LIMIT 1;
    SELECT id INTO v_concepto   FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025' LIMIT 1;

    IF v_puesto_186 IS NULL THEN
        RAISE EXCEPTION 'Puesto 186 no encontrado';
    END IF;
    IF v_puesto_135 IS NULL THEN
        RAISE EXCEPTION 'Puesto 135 no encontrado';
    END IF;
    IF v_concepto IS NULL THEN
        RAISE EXCEPTION 'Concepto Saldo Inicial 2025 no encontrado';
    END IF;

    -- PASO 1: Corregir monto de puesto 186 (MARILU: de 714.63 → 506.49)
    UPDATE public.montos_por_cobrar
       SET monto      = 506.49,
           observacion = 'Saldo inicial migrado al 31-12-2025 · MAYHUASCA BASTIDAS MARILU [corregido en 00039]'
     WHERE puesto_id    = v_puesto_186
       AND concepto_id  = v_concepto
       AND periodo_anio = 2025
       AND periodo_mes  = 12
       AND deleted_at IS NULL;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró el registro de Saldo Inicial 2025 para puesto 186';
    END IF;
    RAISE NOTICE '✓ Puesto 186 actualizado: 714.63 → 506.49 (MARILU)';

    -- PASO 2: Insertar saldo inicial para puesto 135 (CLUDDY AYDE: S/ 714.63)
    INSERT INTO public.montos_por_cobrar
        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)
    VALUES
        (v_puesto_135, v_concepto, 2025, 12, 714.63, 'Pendiente', 'Manual', '2025-12-31'::date,
         'Saldo inicial migrado al 31-12-2025 · MAYHUASCA BASTIDAS DE TORRES CLUDDY AYDE [insertado en 00039]')
    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)
        WHERE deleted_at IS NULL AND puesto_id IS NOT NULL
    DO NOTHING;

    RAISE NOTICE '✓ Puesto 135 insertado: S/ 714.63 (CLUDDY AYDE)';

END $$;

-- Verificación final
DO $$
DECLARE
    v_count  integer;
    v_suma   numeric;
BEGIN
    SELECT count(*), COALESCE(sum(monto), 0)
      INTO v_count, v_suma
      FROM public.montos_por_cobrar
     WHERE concepto_id = (SELECT id FROM public.conceptos WHERE nombre = 'Saldo Inicial 2025')
       AND deleted_at IS NULL;

    RAISE NOTICE '=================================================';
    RAISE NOTICE '00039 Corrección MAYHUASCA — Verificación';
    RAISE NOTICE 'Filas totales Saldo Inicial 2025: %  (esperado: 261)', v_count;
    RAISE NOTICE 'Suma total en BD:  S/ %  (esperado: 116569.87)', v_suma;
    RAISE NOTICE 'Diferencia vs Excel neta (116589.20 - excluidos 19.33): S/ %',
        (116589.20 - 19.33) - v_suma;
    RAISE NOTICE '=================================================';
END $$;

COMMIT;
