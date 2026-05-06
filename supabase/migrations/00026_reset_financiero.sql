-- =============================================================================
-- Migración 00026 — Reset Financiero (Go-Live)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- PROPÓSITO: Limpia TODA la data transaccional de prueba y deja el sistema
-- listo para operar con datos reales a partir de Mayo 2026.
--
-- QUÉ SE ELIMINA (datos financieros de prueba):
--   ✗ detalle_pagos, pagos               — historial de cobros de prueba
--   ✗ montos_por_cobrar                  — deudas generadas en testing
--   ✗ mediciones_luz, registro_artefactos — mediciones de prueba
--   ✗ gastos                             — egresos de prueba
--   ✗ movimientos_bancarios              — movimientos bancarios de prueba
--   ✗ inventario_movimientos             — kardex de prueba
--   ✗ ingresos_internos                  — ingresos espontáneos de prueba
--   ✗ saldo_a_favor de socios/inquilinos  — resetear a 0.00
--
-- QUÉ SE CONSERVA (padrón e información permanente):
--   ✓ socios, inquilinos, puestos, giros
--   ✓ historial_titularidad, historial_arriendos
--   ✓ conceptos, configuraciones
--   ✓ auditoria (append-only — nunca se borra por política)
--   ✓ inventario_productos (catálogo; solo se resetea el stock_actual a 0)
--
-- CORRECCIÓN DE NOMBRES (los nombres originales del usuario diferían del schema):
--   Usuario decía         →  Nombre real en BD
--   lecturas_medidores    →  mediciones_luz
--   cargos_extraordinarios → (no existe como tabla; están dentro de montos_por_cobrar)
--   kardex_inventario     →  inventario_movimientos
--
-- ADVERTENCIA: Este script es IRREVERSIBLE. Ejecutar solo sobre el entorno
-- correcto DESPUÉS de hacer un backup con: supabase db dump -f backup_pregolivesql
-- =============================================================================


-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 0: Verificación de seguridad — confirmar que no hay pagos reales
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
    v_total_pagos integer;
BEGIN
    SELECT count(*) INTO v_total_pagos
    FROM public.pagos
    WHERE deleted_at IS NULL
      -- Excluye los pagos de prueba (ajusta el rango de fechas si tu testing fue en otro período)
      AND fecha_pago >= '2026-01-01';

    RAISE NOTICE '============================================';
    RAISE NOTICE 'RESET FINANCIERO — Cooperativa Primero de Mayo';
    RAISE NOTICE '============================================';
    RAISE NOTICE 'Pagos activos encontrados (post 2026-01-01): %', v_total_pagos;
    RAISE NOTICE 'Total montos_por_cobrar activos: %',
        (SELECT count(*) FROM public.montos_por_cobrar WHERE deleted_at IS NULL);
    RAISE NOTICE 'Total gastos activos: %',
        (SELECT count(*) FROM public.gastos WHERE deleted_at IS NULL);
    RAISE NOTICE '--- Procediendo con el reset... ---';
END;
$$;


-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 1: Vaciar tablas transaccionales
--
-- TRUNCATE … RESTART IDENTITY CASCADE:
--   • RESTART IDENTITY: reinicia las secuencias bigserial a 1 (IDs vuelven a 1).
--   • CASCADE: propaga el truncate a tablas que tengan FK apuntando a las
--     listadas (en este caso, detalle_pagos → pagos ya está en la lista).
--   • El orden importa para evitar conflictos: hijos antes que padres.
--     Con CASCADE es automático, pero lo listamos explícitamente para claridad.
-- ─────────────────────────────────────────────────────────────────────────────

TRUNCATE TABLE
    -- ── Núcleo financiero (orden: hijo → padre) ───────────────────────────────
    public.detalle_pagos,            -- FK → pagos, montos_por_cobrar
    public.pagos,                    -- FK → socios, inquilinos, puestos
    public.montos_por_cobrar,        -- FK → puestos, socios, conceptos
    -- ── Mediciones (base de cálculo de luz) ──────────────────────────────────
    public.mediciones_luz,           -- (mediciones_luz = "lecturas_medidores" en schema real)
    public.registro_artefactos,
    -- ── Módulos de gestión ───────────────────────────────────────────────────
    public.ingresos_internos,
    public.gastos,
    public.movimientos_bancarios,
    public.inventario_movimientos    -- (inventario_movimientos = "kardex_inventario" en schema real)
RESTART IDENTITY CASCADE;


-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 2: Resetear la secuencia de códigos de transacción
-- seq_codigo_transaccion es una secuencia standalone (no bigserial de tabla),
-- por lo que no queda afectada por RESTART IDENTITY del TRUNCATE anterior.
-- ─────────────────────────────────────────────────────────────────────────────
ALTER SEQUENCE public.seq_codigo_transaccion RESTART WITH 1;


-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 3: Resetear stock_actual del inventario
-- El trigger tg_actualizar_stock mantiene el stock al insertar movimientos.
-- Al borrar los movimientos, el stock_actual queda en su valor anterior.
-- Lo llevamos a 0 para que el admin haga el ingreso real de apertura.
-- ─────────────────────────────────────────────────────────────────────────────
UPDATE public.inventario_productos
SET stock_actual = 0
WHERE stock_actual <> 0;


-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 4: Resetear saldo_a_favor de socios e inquilinos
-- Cualquier saldo de favor acumulado durante el período de prueba se anula.
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
    ASSERT (SELECT count(*) FROM public.pagos)               = 0, 'ERROR: pagos no vacío';
    ASSERT (SELECT count(*) FROM public.detalle_pagos)       = 0, 'ERROR: detalle_pagos no vacío';
    ASSERT (SELECT count(*) FROM public.montos_por_cobrar)   = 0, 'ERROR: montos_por_cobrar no vacío';
    ASSERT (SELECT count(*) FROM public.mediciones_luz)      = 0, 'ERROR: mediciones_luz no vacío';
    ASSERT (SELECT count(*) FROM public.gastos)              = 0, 'ERROR: gastos no vacío';
    ASSERT (SELECT count(*) FROM public.movimientos_bancarios) = 0, 'ERROR: movimientos_bancarios no vacío';
    ASSERT (SELECT count(*) FROM public.inventario_movimientos) = 0, 'ERROR: inventario_movimientos no vacío';
    ASSERT (SELECT sum(saldo_a_favor) FROM public.socios)    = 0, 'ERROR: saldo_a_favor socios no es 0';
    ASSERT (SELECT sum(saldo_a_favor) FROM public.inquilinos) = 0, 'ERROR: saldo_a_favor inquilinos no es 0';

    RAISE NOTICE '✓ Reset financiero completado exitosamente.';
    RAISE NOTICE '  Padrón conservado: % socios, % inquilinos, % puestos.',
        (SELECT count(*) FROM public.socios   WHERE deleted_at IS NULL),
        (SELECT count(*) FROM public.inquilinos WHERE deleted_at IS NULL),
        (SELECT count(*) FROM public.puestos  WHERE deleted_at IS NULL);
    RAISE NOTICE '  Siguiente paso: ejecutar seed_migracion_deudas_iniciales.sql';
END;
$$;
