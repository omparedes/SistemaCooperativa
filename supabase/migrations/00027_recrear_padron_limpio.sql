-- =============================================================================
-- Migración 00027 — Recrear Padrón Limpio (Wipe & Replace)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- PROPÓSITO: Elimina el padrón corrupto de pruebas y crea uno nuevo y limpio
-- con IDs predecibles (1–185 para socios y puestos, 1–98 para inquilinos).
--
-- QUÉ SE HACE:
--   1. TRUNCATE CASCADE de las tablas de padrón + tablas financieras dependientes
--      (montos_por_cobrar, pagos, detalle_pagos también quedan en 0 por CASCADE).
--   2. INSERT de 185 Socios con DNI genérico SOC-001..SOC-185.
--   3. INSERT de 185 Puestos con código genérico P-001..P-185.
--   4. INSERT de 185 filas en historial_titularidad (socio N ↔ puesto N).
--   5. INSERT de 98 Inquilinos con DNI genérico INQ-001..INQ-098.
--      (Sin asignación a puestos — se hace desde la UI.)
--
-- NOMBRES: Se usan placeholders porque los nombres reales no fueron provistos
-- en esta ejecución. Actualiza en masa desde la UI del ERP o con un UPDATE.
--
-- IDs PREDECIBLES (gracias a RESTART IDENTITY + inserts secuenciales):
--   socios.id    1..185  ←→  puestos.id    1..185
--   inquilinos.id 1..98
--   Esto permite que el seed de deudas referencie directamente socio_id = N.
--
-- EJECUCIÓN: Debe ejecutarse ANTES de seed_migracion_deudas_iniciales.sql.
-- PREREQUISITO: 00026_reset_financiero.sql ya aplicado (o ejecutar en orden).
-- =============================================================================

BEGIN;

-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 0: Confirmación de estado previo
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
BEGIN
    RAISE NOTICE '=================================================';
    RAISE NOTICE 'WIPE & REPLACE del Padrón — Cooperativa 1° de Mayo';
    RAISE NOTICE '=================================================';
    RAISE NOTICE 'Estado ANTES del reset:';
    RAISE NOTICE '  socios:    %', (SELECT count(*) FROM public.socios);
    RAISE NOTICE '  inquilinos: %', (SELECT count(*) FROM public.inquilinos);
    RAISE NOTICE '  puestos:   %', (SELECT count(*) FROM public.puestos);
    RAISE NOTICE '  giros (SE CONSERVAN): %', (SELECT count(*) FROM public.giros WHERE deleted_at IS NULL);
END;
$$;


-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 1: Wipe total del padrón (y tablas financieras dependientes)
--
-- CASCADE propaga el TRUNCATE a:
--   historial_titularidad, historial_arriendos (referenciadas por socios/inquilinos/puestos)
--   montos_por_cobrar, pagos, detalle_pagos   (si quedó algo de 00026)
--
-- RESTART IDENTITY: las secuencias bigserial vuelven a 1 → IDs predecibles.
-- ─────────────────────────────────────────────────────────────────────────────
TRUNCATE TABLE
    public.socios,
    public.inquilinos,
    public.puestos,
    public.historial_titularidad,
    public.historial_arriendos
RESTART IDENTITY CASCADE;


-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 2: 185 Socios
--
-- DNI genérico SOC-001..SOC-185 (único, cumple UNIQUE constraint).
-- nombres = '' (campo NOT NULL — se deja vacío según instrucción).
-- apellidos = placeholder hasta que el admin actualice vía UI.
-- fecha_ingreso = 2026-05-01 (fecha de corte Go-Live).
--
-- ▶ Para actualizar con nombres reales, ejecutar en la UI o con:
--   UPDATE public.socios SET apellidos = 'NOMBRE REAL', nombres = 'Nombre'
--   WHERE dni = 'SOC-001';
--
-- ▶ Si tienes el listado en CSV, puedes hacer un UPDATE masivo via:
--   scripts/actualizar_nombres_padron.ts  (ver instrucciones al final)
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO public.socios (dni, nombres, apellidos, estado, habilitado, fecha_ingreso)
SELECT
    'SOC-' || lpad(n::text, 3, '0'),
    '',                                                 -- nombres: vacío según instrucción
    'SOCIO ' || lpad(n::text, 3, '0') || ' — ACTUALIZAR NOMBRE',
    'Activo',
    true,
    '2026-05-01'
FROM generate_series(1, 185) AS n;

DO $$ BEGIN RAISE NOTICE '✓ 185 socios insertados (id 1..185).'; END; $$;


-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 3: 185 Puestos genéricos
--
-- codigo_puesto = P-001..P-185 (código provisional — actualizar con código real
-- del local físico desde la UI: Puestos → Editar código).
-- giro_id = primer giro activo disponible (se actualiza luego por puesto).
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
    v_giro_default bigint;
BEGIN
    SELECT id INTO v_giro_default
    FROM public.giros
    WHERE deleted_at IS NULL
    ORDER BY id
    LIMIT 1;

    IF v_giro_default IS NULL THEN
        RAISE EXCEPTION 'No hay giros activos en la tabla public.giros. '
            'Ejecutar el seed de giros (migración 00003) antes de este script.';
    END IF;

    RAISE NOTICE 'Usando giro_id=% como giro por defecto para los 185 puestos.', v_giro_default;
END;
$$;

INSERT INTO public.puestos (codigo_puesto, giro_id, estado, tiene_medidor_luz, tiene_medidor_agua)
SELECT
    'P-' || lpad(n::text, 3, '0'),
    (SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1),
    'Activo',
    false,
    false
FROM generate_series(1, 185) AS n;

DO $$ BEGIN RAISE NOTICE '✓ 185 puestos insertados (id 1..185, código P-001..P-185).'; END; $$;


-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 4: Titularidades — socio N ↔ puesto N
--
-- Después de RESTART IDENTITY + inserts secuenciales:
--   socios.id = 1..185  y  puestos.id = 1..185
-- Por eso el JOIN es directo: socio #N es titular del puesto #N.
-- fecha_inicio = 2026-05-01 (inicio del sistema productivo).
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO public.historial_titularidad (puesto_id, socio_id, fecha_inicio)
SELECT n, n, '2026-05-01'
FROM generate_series(1, 185) AS n;

DO $$ BEGIN RAISE NOTICE '✓ 185 titularidades insertadas (socio N ↔ puesto N).'; END; $$;


-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 5: 98 Inquilinos
--
-- DNI genérico INQ-001..INQ-098.
-- Sin asignación a puestos (historial_arriendos queda vacío).
-- La asignación se hace desde la UI: Inquilinos → Asignar puesto.
-- ─────────────────────────────────────────────────────────────────────────────
INSERT INTO public.inquilinos (dni, nombres, apellidos)
SELECT
    'INQ-' || lpad(n::text, 3, '0'),
    '',                                                 -- nombres: vacío según instrucción
    'INQUILINO ' || lpad(n::text, 3, '0') || ' — ACTUALIZAR NOMBRE'
FROM generate_series(1, 98) AS n;

DO $$ BEGIN RAISE NOTICE '✓ 98 inquilinos insertados (id 1..98), sin asignación de puesto aún.'; END; $$;


-- ─────────────────────────────────────────────────────────────────────────────
-- PASO 6: Verificación final con assertions
-- ─────────────────────────────────────────────────────────────────────────────
DO $$
DECLARE
    v_socios    integer;
    v_puestos   integer;
    v_titulares integer;
    v_inq       integer;
    v_arriendos integer;
BEGIN
    SELECT count(*) INTO v_socios    FROM public.socios;
    SELECT count(*) INTO v_puestos   FROM public.puestos;
    SELECT count(*) INTO v_titulares FROM public.historial_titularidad WHERE fecha_fin IS NULL;
    SELECT count(*) INTO v_inq       FROM public.inquilinos;
    SELECT count(*) INTO v_arriendos FROM public.historial_arriendos;

    ASSERT v_socios    = 185, format('ERROR: se esperaban 185 socios, hay %s', v_socios);
    ASSERT v_puestos   = 185, format('ERROR: se esperaban 185 puestos, hay %s', v_puestos);
    ASSERT v_titulares = 185, format('ERROR: se esperaban 185 titularidades vigentes, hay %s', v_titulares);
    ASSERT v_inq       = 98,  format('ERROR: se esperaban 98 inquilinos, hay %s', v_inq);
    ASSERT v_arriendos = 0,   format('ERROR: historial_arriendos debería estar vacío, hay %s', v_arriendos);

    -- Verificar que los IDs empiezan en 1 (RESTART IDENTITY funcionó)
    ASSERT (SELECT min(id) FROM public.socios)  = 1, 'ERROR: socio min(id) != 1';
    ASSERT (SELECT max(id) FROM public.socios)  = 185, 'ERROR: socio max(id) != 185';
    ASSERT (SELECT min(id) FROM public.puestos) = 1, 'ERROR: puesto min(id) != 1';
    ASSERT (SELECT max(id) FROM public.puestos) = 185, 'ERROR: puesto max(id) != 185';

    -- Verificar coherencia de titularidades (socio N ↔ puesto N)
    ASSERT (
        SELECT count(*) FROM public.historial_titularidad ht
        WHERE ht.socio_id = ht.puesto_id AND fecha_fin IS NULL
    ) = 185, 'ERROR: La asignación socio_N ↔ puesto_N no es correcta';

    RAISE NOTICE '=================================================';
    RAISE NOTICE '✓ PADRÓN RECREADO EXITOSAMENTE';
    RAISE NOTICE '=================================================';
    RAISE NOTICE '  Socios:       % (id 1..185, DNI SOC-001..SOC-185)', v_socios;
    RAISE NOTICE '  Puestos:      % (id 1..185, código P-001..P-185)', v_puestos;
    RAISE NOTICE '  Titularidades vigentes: % (socio N ↔ puesto N)', v_titulares;
    RAISE NOTICE '  Inquilinos:   % (id 1..98, DNI INQ-001..INQ-098)', v_inq;
    RAISE NOTICE '  Arriendos vigentes: 0 (asignar desde la UI)';
    RAISE NOTICE '=================================================';
    RAISE NOTICE 'SIGUIENTE PASO: Ejecutar seed_migracion_deudas_iniciales.sql';
END;
$$;

COMMIT;
