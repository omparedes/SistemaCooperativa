-- =============================================================================
-- BORRADOR — Migración 00062 — Depuración de cargos pre-2026 redundantes
-- Cooperativa Primero de Mayo · SistemaCooperativa
--
-- ⚠️  ESTE ARCHIVO ES UN BORRADOR PARA REVISIÓN HUMANA. NO SE HA EJECUTADO
--     CONTRA LA BASE DE DATOS. Renombrar (quitar sufijo _DRAFT) y aplicar
--     manualmente solo después de validar el listado de IDs abajo.
--
-- CONTEXTO / HALLAZGO (verificado por scratch/reconcile_check_impacto.js,
-- consulta de solo lectura contra la BD real, 2026-06-07):
--
--   El 2026-06-05 se insertaron 1000 registros en `montos_por_cobrar` con el
--   prefijo de observación "Migracion 2026: Deuda Pendiente ..." (carga
--   detallada fila por fila desde Excel). De esos, 34 registros (16 puestos)
--   tienen `periodo_anio < 2026` y coexisten con un registro de
--   "Saldo inicial migrado al 31-12-2025" (concepto "Saldo Inicial 2025",
--   migración 00038, fecha_generacion = 2025-12-31) para el MISMO puesto.
--
--   El saldo inicial consolida toda la deuda acumulada hasta el 31-12-2025;
--   por lo tanto estos 34 registros detallados de periodos anteriores a 2026
--   representan un DOBLE CONTEO de montos que ya están incluidos en el
--   saldo consolidado.
--
--   Impacto estimado: S/ 4,574.40 de sobreconteo
--     (Alquiler S/3,875.00 · Depósito S/450.00 · Luz S/129.40 ·
--      Otros Ingresos S/60.00 · Otros S/45.00 · Agua S/15.00)
--
--   Total deuda pendiente actual:        S/ 125,933.49
--   Total estimado tras esta depuración: S/ 121,359.09
--
-- NOTA IMPORTANTE: las cifras objetivo mencionadas en la solicitud original
-- (deuda total S/ 98,652.30, desglose Socios S/ 54,696.00 / Inquilinos
-- S/ 43,956.30, "17 puestos duplicados", "colisiones de facturación ERP
-- Mar-Abr 2026") NO pudieron verificarse contra el estado real de la BD:
--   • La suma actual (S/ 125,933.49) no coincide con ninguna de las cifras
--     mencionadas como "actual" (S/ 143,923.49) ni "objetivo" (S/ 98,652.30).
--   • No se encontraron colisiones de cargos automáticos ERP vs. migrados
--     para Mar/Abr/May 2026 (0 claves puesto+periodo+concepto con >1 registro).
--   • Solo se identificaron 16 puestos (no 17) con coexistencia de saldo
--     inicial + detalle pre-2026, y la magnitud (S/ 4,574.40) es muy inferior
--     a la diferencia reclamada (~S/ 45,271).
-- Por lo tanto este borrador se limita ÚNICAMENTE al hallazgo que pude
-- verificar de forma independiente y reproducible.
--
-- MÉTODO: soft-delete (deleted_at = now()), conforme a la regla de dominio
-- "Prohibido DELETE FROM en tablas financieras o de historiales de personas"
-- (CLAUDE.md §4.3). Los registros quedan auditables y reversibles.
-- =============================================================================

BEGIN;

DO $depuracion_pre2026$
DECLARE
    v_user_uuid uuid;
    v_ids       bigint[] := ARRAY[
        5991, 5922, 5933, 6003, 6004, 6005, 5948, 6176, 6180, 6181, 6182,
        6038, 6039, 6040, 6041, 6042, 6043, 6188, 6189, 6190, 6140, 6141,
        6142, 6036, 6116, 6117, 5944, 6049, 6059, 6060, 6061, 6062, 6063, 5965
    ];
    v_count     int;
BEGIN
    SELECT id INTO v_user_uuid FROM public.perfiles WHERE rol = 'Administrador' AND activo = true LIMIT 1;
    IF v_user_uuid IS NULL THEN v_user_uuid := '00000000-0000-0000-0000-000000000000'; END IF;

    -- Verificación defensiva: solo tocar registros que SIGAN cumpliendo el
    -- criterio (Pendiente, no eliminados, observación con el prefijo esperado,
    -- periodo < 2026 y puesto con saldo inicial consolidado). Si la BD cambió
    -- desde el análisis, esta consulta devolverá menos filas de las 34 esperadas
    -- y el RAISE NOTICE lo hará evidente antes de continuar.
    SELECT count(*) INTO v_count
    FROM public.montos_por_cobrar m
    WHERE m.id = ANY(v_ids)
      AND m.deleted_at IS NULL
      AND m.estado = 'Pendiente'
      AND m.periodo_anio < 2026
      AND m.observacion LIKE 'Migracion 2026: Deuda Pendiente%'
      AND EXISTS (
          SELECT 1 FROM public.montos_por_cobrar si
          WHERE si.puesto_id = m.puesto_id
            AND si.deleted_at IS NULL
            AND si.observacion LIKE 'Saldo inicial migrado al 31-12-2025%'
      );

    IF v_count <> array_length(v_ids, 1) THEN
        RAISE EXCEPTION
            'Verificación falló: % de % registros candidatos siguen cumpliendo el criterio. Revisar antes de aplicar (la BD pudo haber cambiado desde el análisis).',
            v_count, array_length(v_ids, 1);
    END IF;

    -- Soft-delete: preserva el registro para auditoría, lo marca como anulado
    -- por duplicación detectada contra el saldo inicial consolidado.
    UPDATE public.montos_por_cobrar
    SET deleted_at       = now(),
        anulado_por      = v_user_uuid,
        motivo_anulacion = 'Depuración 00062: cargo detallado pre-2026 redundante con "Saldo inicial migrado al 31-12-2025" del mismo puesto (doble conteo detectado en migración masiva del 2026-06-05)'
    WHERE id = ANY(v_ids);

    RAISE NOTICE 'Depuración 00062: % registros marcados como eliminados (soft-delete). Reducción esperada de deuda pendiente: S/ 4,574.40', v_count;
END;
$depuracion_pre2026$;

-- Reporte de validación posterior
SELECT
    (SELECT count(*) FROM public.montos_por_cobrar WHERE estado = 'Pendiente' AND deleted_at IS NULL)                  AS pendientes_total,
    (SELECT round(sum(monto)::numeric, 2) FROM public.montos_por_cobrar WHERE estado = 'Pendiente' AND deleted_at IS NULL) AS suma_pendiente_total;

COMMIT;
