-- =============================================================================
-- Migración 00037 — Reset Financiero Pre-GoLive (2026-01-01)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- PROPÓSITO: Elimina TODA la data transaccional (incluye el historial 2016-2025
-- importado en 00029) y deja el sistema listo para operar desde el 2026-01-01
-- con un único "Saldo Inicial 2025" por puesto (migración 00038).
--
-- QUÉ SE ELIMINA (tablas transaccionales):
--   ✗ detalle_pagos, pagos              — cobros de prueba/histórico
--   ✗ recaudacion_abonos               — abonos de tarjeta de prueba
--   ✗ montos_por_cobrar                — ~miles de filas de 00029 (2016-2025)
--   ✗ mediciones_luz, registro_artefactos
--   ✗ ingresos_internos, gastos
--   ✗ movimientos_bancarios
--   ✗ inventario_movimientos
--   ✗ notificaciones_sistema           — notificaciones históricas de prueba
--
-- QUÉ SE CONSERVA (padrón + catálogos + auditoría):
--   ✓ socios, inquilinos, puestos, giros          (185 / 103 / 288)
--   ✓ historial_titularidad, historial_arriendos
--   ✓ conceptos, configuraciones, recaudacion_config
--   ✓ inventario_productos              (catálogo; stock_actual → 0)
--   ✓ auditoria                         (append-only por política, NUNCA se borra)
--
-- ADVERTENCIA: IRREVERSIBLE. Antes de ejecutar:
--   supabase db dump -f backup_pre_golive_$(date +%F).sql
-- =============================================================================

BEGIN;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 0: Verificación previa — confirmar que el padrón está cargado
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
BEGIN
    RAISE NOTICE '=================================================';
    RAISE NOTICE 'RESET FINANCIERO PRE-GOLIVE — Cooperativa Primero de Mayo';
    RAISE NOTICE '=================================================';
    RAISE NOTICE 'Socios activos:    %', (SELECT count(*) FROM public.socios WHERE deleted_at IS NULL);
    RAISE NOTICE 'Inquilinos activos: %', (SELECT count(*) FROM public.inquilinos WHERE deleted_at IS NULL);
    RAISE NOTICE 'Puestos activos:   %', (SELECT count(*) FROM public.puestos WHERE deleted_at IS NULL);
    RAISE NOTICE 'montos_por_cobrar: % filas (a eliminar)', (SELECT count(*) FROM public.montos_por_cobrar);
    RAISE NOTICE 'pagos:             % filas (a eliminar)', (SELECT count(*) FROM public.pagos);
    RAISE NOTICE '--- Procediendo con el reset... ---';
END $$;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 1: Vaciar tablas transaccionales (hijo → padre para FK)
-- RESTART IDENTITY: reinicia secuencias bigserial a 1
-- CASCADE: propaga a tablas dependientes no listadas explícitamente
-- ─────────────────────────────────────────────────────────────────────────────
TRUNCATE TABLE
    -- Núcleo financiero (orden: hijo → padre)
    public.detalle_pagos,
    public.pagos,
    public.recaudacion_abonos,
    public.montos_por_cobrar,
    -- Mediciones (base de cálculo de luz)
    public.mediciones_luz,
    public.registro_artefactos,
    -- Módulos de gestión
    public.ingresos_internos,
    public.gastos,
    public.movimientos_bancarios,
    public.inventario_movimientos
RESTART IDENTITY CASCADE;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 2: Reset secuencia standalone de códigos de transacción
-- seq_codigo_transaccion NO está ligada a ninguna tabla, no la afecta RESTART IDENTITY
-- ─────────────────────────────────────────────────────────────────────────────
ALTER SEQUENCE public.seq_codigo_transaccion RESTART WITH 1;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 3: Resetear stock_actual del inventario
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE public.inventario_productos
SET stock_actual = 0
WHERE stock_actual <> 0;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 4: Resetear saldo_a_favor de socios e inquilinos
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE public.socios
SET saldo_a_favor = 0.00
WHERE saldo_a_favor <> 0.00;

UPDATE public.inquilinos
SET saldo_a_favor = 0.00
WHERE saldo_a_favor <> 0.00;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 5: Verificación final
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
BEGIN
    -- Tablas transaccionales deben estar vacías
    ASSERT (SELECT count(*) FROM public.pagos)               = 0, 'ERROR: pagos no vacío';
    ASSERT (SELECT count(*) FROM public.detalle_pagos)       = 0, 'ERROR: detalle_pagos no vacío';
    ASSERT (SELECT count(*) FROM public.recaudacion_abonos)  = 0, 'ERROR: recaudacion_abonos no vacío';
    ASSERT (SELECT count(*) FROM public.montos_por_cobrar)   = 0, 'ERROR: montos_por_cobrar no vacío';
    ASSERT (SELECT count(*) FROM public.mediciones_luz)      = 0, 'ERROR: mediciones_luz no vacío';
    ASSERT (SELECT count(*) FROM public.gastos)              = 0, 'ERROR: gastos no vacío';
    ASSERT (SELECT count(*) FROM public.movimientos_bancarios) = 0, 'ERROR: movimientos_bancarios no vacío';
    ASSERT (SELECT count(*) FROM public.inventario_movimientos) = 0, 'ERROR: inventario_movimientos no vacío';

    -- Saldos deben ser 0
    ASSERT COALESCE((SELECT sum(saldo_a_favor) FROM public.socios), 0)     = 0, 'ERROR: saldo_a_favor socios no es 0';
    ASSERT COALESCE((SELECT sum(saldo_a_favor) FROM public.inquilinos), 0) = 0, 'ERROR: saldo_a_favor inquilinos no es 0';

    -- Padrón debe estar intacto (valores de 00036)
    ASSERT (SELECT count(*) FROM public.socios     WHERE deleted_at IS NULL) = 185, 'ERROR: socios count ≠ 185';
    ASSERT (SELECT count(*) FROM public.inquilinos WHERE deleted_at IS NULL) = 103, 'ERROR: inquilinos count ≠ 103';
    ASSERT (SELECT count(*) FROM public.puestos    WHERE deleted_at IS NULL) = 288, 'ERROR: puestos count ≠ 288';

    RAISE NOTICE '=================================================';
    RAISE NOTICE '✓ Reset financiero completado exitosamente.';
    RAISE NOTICE '  Padrón conservado: 185 socios · 103 inquilinos · 288 puestos';
    RAISE NOTICE '  Siguiente paso: supabase db push (migración 00038_saldos_iniciales_2025.sql)';
    RAISE NOTICE '=================================================';
END $$;

COMMIT;
