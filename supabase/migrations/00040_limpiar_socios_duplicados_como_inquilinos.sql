-- =============================================================================
-- Migración 00040 — Limpiar socios duplicados en tabla inquilinos
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- =============================================================================
-- CONTEXTO:
--   La migración 00036 creó registros de "inquilino" con DNI='DEP-X-DY' para
--   personas que alquilan depósitos. Muchas de esas personas son socios activos,
--   lo que genera un perfil duplicado. Un socio NUNCA debe existir también en
--   la tabla inquilinos.
--
-- ESTRUCTURA DE DATOS (00036):
--   socios:          nombres='',  apellidos='NOMBRE COMPLETO'
--   inquilinos DEP:  nombres='',  apellidos='NOMBRE ABREV',  dni='DEP-X-DY'
--
-- CRITERIO DE DUPLICADO:
--   i.apellidos es SUBSTRING del s.apellidos (upper+trim).
--   El puesto depósito se obtiene directamente del DNI: 'DEP-6-D2' → '6-D2'.
--   No se requiere historial_arriendos activo (puede no existir si el socio
--   cooperativa DNI='00000000' no estaba creado cuando corrió 00036).
--
-- RESULTADO ESPERADO: inquilinos activos = 87  (103 − 16 = 87)
-- =============================================================================

BEGIN;

-- =============================================================================
-- PASO 0 — DRY-RUN: identifica los duplicados sin modificar nada
-- =============================================================================
DO $$
DECLARE
    v_total integer := 0;
    v_rec   record;
BEGIN
    RAISE NOTICE '=== SOCIOS DUPLICADOS EN INQUILINOS (DEP-) — DRY-RUN ===';
    RAISE NOTICE '%-10s | %-40s | %-40s | %',
        'Dep.', 'Inquilino (BD)', 'Socio (BD)', 'soc_puesto';
    RAISE NOTICE '%', repeat('-', 100);

    FOR v_rec IN
        SELECT DISTINCT ON (i.id)
            replace(i.dni, 'DEP-', '')       AS cod_dep,
            i.id                              AS inq_id,
            i.apellidos                       AS inq_nombre,
            s.id                              AS soc_id,
            s.apellidos                       AS soc_nombre,
            p_soc.codigo_puesto               AS cod_soc,
            p_dep.id                          AS puesto_dep_id
        FROM public.inquilinos i
        -- El puesto depósito se obtiene del propio DNI del inquilino
        JOIN public.puestos p_dep
            ON p_dep.codigo_puesto = replace(i.dni, 'DEP-', '')
           AND p_dep.deleted_at IS NULL
        -- Matching por nombre: s.apellidos contiene i.apellidos como substring
        JOIN public.socios s
            ON upper(trim(s.apellidos)) LIKE '%' || upper(trim(i.apellidos)) || '%'
           AND s.apellidos <> ''
        JOIN public.historial_titularidad ht
            ON ht.socio_id = s.id AND ht.fecha_fin IS NULL
        JOIN public.puestos p_soc
            ON p_soc.id = ht.puesto_id
        WHERE i.deleted_at IS NULL
          AND s.deleted_at IS NULL
          AND i.dni LIKE 'DEP-%'
          AND i.apellidos <> ''
        ORDER BY i.id, s.id
    LOOP
        v_total := v_total + 1;
        RAISE NOTICE '%-10s | %-40s | %-40s | %',
            v_rec.cod_dep, v_rec.inq_nombre, v_rec.soc_nombre, v_rec.cod_soc;
    END LOOP;

    RAISE NOTICE '%', repeat('-', 100);
    RAISE NOTICE 'Duplicados detectados: %  (esperado: 16)', v_total;
    RAISE NOTICE 'Sin cambios — solo lectura.';

    IF v_total <> 16 THEN
        RAISE EXCEPTION
            'Se detectaron % duplicados en lugar de 16. '
            'Revisar el matching antes de proceder.',
            v_total;
    END IF;
END $$;


-- =============================================================================
-- PASO 1 — LIMPIEZA
-- =============================================================================
DO $$
DECLARE
    v_dup         record;
    v_sistema_uid uuid;
    v_arr_id      bigint;
    v_procesados  integer := 0;
    v_errores     integer := 0;
BEGIN
    SELECT id INTO v_sistema_uid
      FROM auth.users ORDER BY created_at LIMIT 1;

    IF v_sistema_uid IS NULL THEN
        RAISE EXCEPTION 'No hay usuarios en auth.users.';
    END IF;

    FOR v_dup IN
        SELECT DISTINCT ON (i.id)
            replace(i.dni, 'DEP-', '')  AS cod_dep,
            i.id                         AS inq_id,
            i.apellidos                  AS inq_nombre,
            s.id                         AS soc_id,
            p_soc.codigo_puesto          AS cod_soc,
            p_dep.id                     AS puesto_dep_id
        FROM public.inquilinos i
        JOIN public.puestos p_dep
            ON p_dep.codigo_puesto = replace(i.dni, 'DEP-', '')
           AND p_dep.deleted_at IS NULL
        JOIN public.socios s
            ON upper(trim(s.apellidos)) LIKE '%' || upper(trim(i.apellidos)) || '%'
           AND s.apellidos <> ''
        JOIN public.historial_titularidad ht
            ON ht.socio_id = s.id AND ht.fecha_fin IS NULL
        JOIN public.puestos p_soc ON p_soc.id = ht.puesto_id
        WHERE i.deleted_at IS NULL
          AND s.deleted_at IS NULL
          AND i.dni LIKE 'DEP-%'
          AND i.apellidos <> ''
        ORDER BY i.id, s.id
    LOOP
        BEGIN
            -- ── A. Cerrar arriendo activo del depósito (si existe) ───────────
            SELECT ha.id INTO v_arr_id
              FROM public.historial_arriendos ha
             WHERE ha.puesto_id = v_dup.puesto_dep_id
               AND ha.fecha_fin IS NULL
             LIMIT 1;

            IF v_arr_id IS NOT NULL THEN
                UPDATE public.historial_arriendos
                   SET fecha_fin      = current_date,
                       motivo_termino = 'Mig. 00040: inquilino era socio (puesto ' ||
                                        v_dup.cod_soc || '). Titularidad reasignada.'
                 WHERE id = v_arr_id;
            END IF;

            -- ── B. Crear titularidad socio → depósito (si no existe) ─────────
            INSERT INTO public.historial_titularidad
                (puesto_id, socio_id, fecha_inicio, motivo_cambio)
            SELECT
                v_dup.puesto_dep_id, v_dup.soc_id, current_date,
                'Mig. 00040: deposito reasignado desde registro inquilino duplicado.'
            WHERE NOT EXISTS (
                SELECT 1 FROM public.historial_titularidad
                 WHERE socio_id = v_dup.soc_id AND puesto_id = v_dup.puesto_dep_id
                   AND fecha_fin IS NULL
            );

            -- ── C. Soft-delete del inquilino duplicado ───────────────────────
            UPDATE public.inquilinos
               SET deleted_at       = now(),
                   anulado_por      = v_sistema_uid,
                   motivo_anulacion = 'Mig. 00040: duplicado — es socio puesto ' ||
                                      v_dup.cod_soc || '. Deposito ' || v_dup.cod_dep ||
                                      ' reasignado a historial_titularidad.'
             WHERE id = v_dup.inq_id AND deleted_at IS NULL;

            v_procesados := v_procesados + 1;
            RAISE NOTICE '[%] -> socio puesto % : "%"',
                v_dup.cod_dep, v_dup.cod_soc, v_dup.inq_nombre;

        EXCEPTION WHEN OTHERS THEN
            v_errores := v_errores + 1;
            RAISE WARNING '[%] Error: %', v_dup.cod_dep, SQLERRM;
        END;
    END LOOP;

    RAISE NOTICE '';
    RAISE NOTICE 'Procesados: % / 16  |  Errores: %', v_procesados, v_errores;

    IF v_errores > 0 THEN
        RAISE EXCEPTION 'Hubo % errores. Revisar logs.', v_errores;
    END IF;
END $$;


-- =============================================================================
-- PASO 2 — VERIFICACIÓN FINAL con ASSERT
-- =============================================================================
DO $$
DECLARE
    v_inq_activos integer;
    v_eliminados  integer;
BEGIN
    SELECT count(*) INTO v_inq_activos FROM public.inquilinos WHERE deleted_at IS NULL;
    SELECT count(*) INTO v_eliminados  FROM public.inquilinos
     WHERE deleted_at IS NOT NULL AND motivo_anulacion LIKE '%Mig. 00040%';

    RAISE NOTICE '=================================================';
    RAISE NOTICE '00040 — Verificacion final';
    RAISE NOTICE 'Inquilinos activos:   % (esperado: 87)', v_inq_activos;
    RAISE NOTICE 'Eliminados (00040):   % (esperado: 16)', v_eliminados;

    ASSERT v_inq_activos = 87,
        format('FALLO: inquilinos activos = %s, esperado 87', v_inq_activos);
    ASSERT v_eliminados = 16,
        format('FALLO: eliminados = %s, esperado 16', v_eliminados);

    RAISE NOTICE '✓ ASSERT inquilinos activos = 87  OK';
    RAISE NOTICE '✓ ASSERT eliminados = 16          OK';
    RAISE NOTICE '=================================================';
END $$;

COMMIT;
