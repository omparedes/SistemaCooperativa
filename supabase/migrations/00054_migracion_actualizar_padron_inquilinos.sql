-- =============================================================================
-- Migración 00054 — Actualizar Padrón de Inquilinos 2026
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Cambios:
--   1. Inserta los nuevos inquilinos confirmados (Satalaya, Cuya, Quispe).
--   2. Registra los arriendos y ocupaciones de almacenes para los que tienen puesto asignado.
--   3. Aplica soft-delete a los 5 inquilinos inactivos/duplicados.
-- =============================================================================

BEGIN;

DO $$
DECLARE
    v_sistema_uid uuid;
    v_inq_satalaya_id bigint;
    v_inq_cuya_id bigint;
    v_socio_titular_id bigint;
    v_arr_prev_id bigint;
    v_ocu_prev_id bigint;
BEGIN
    -- 1. Obtener UID de usuario del sistema para auditoría
    SELECT id INTO v_sistema_uid FROM auth.users ORDER BY created_at LIMIT 1;
    IF v_sistema_uid IS NULL THEN
        RAISE EXCEPTION '00054: no se encontró ningún usuario administrador en auth.users.';
    END IF;

    -- =============================================================================
    -- PASO 1 — INSERTAR INQUILINOS NUEVOS
    -- =============================================================================

    -- A. Segundo Satalaya
    INSERT INTO public.inquilinos (nombres, apellidos, dni, tipo_inquilino, created_by)
    VALUES ('ELVIS SEGUNDO', 'SATALAYA TAPULIMA', 'TEMP-58', 'Inquilino', v_sistema_uid)
    ON CONFLICT (dni) DO UPDATE SET nombres = EXCLUDED.nombres, apellidos = EXCLUDED.apellidos
    RETURNING id INTO v_inq_satalaya_id;

    -- B. Evelyn Cuya (Tercero porque arrienda depósito y no tiene puesto principal)
    INSERT INTO public.inquilinos (nombres, apellidos, dni, tipo_inquilino, created_by)
    VALUES ('EVELYN', 'CUYA', 'TEMP-11-D2', 'Tercero', v_sistema_uid)
    ON CONFLICT (dni) DO UPDATE SET nombres = EXCLUDED.nombres, apellidos = EXCLUDED.apellidos
    RETURNING id INTO v_inq_cuya_id;

    -- C. Rosa Maribel Quispe (Nueva inquilina sin puesto asignado aún)
    INSERT INTO public.inquilinos (nombres, apellidos, dni, tipo_inquilino, created_by)
    VALUES ('ROSA MARIBEL', 'QUISPE', 'TEMP-ROSA-QUISPE', 'Inquilino', v_sistema_uid)
    ON CONFLICT (dni) DO UPDATE SET nombres = EXCLUDED.nombres, apellidos = EXCLUDED.apellidos;

    RAISE NOTICE '00054: Inquilinos nuevos creados/actualizados con éxito.';

    -- =============================================================================
    -- PASO 2 — REGISTRAR ARRIENDOS Y OCUPACIONES DE ALMACENES
    -- =============================================================================

    -- A. Puesto 58 (ID 150) -> SEGUNDO ELVIS SATALAYA TAPULIMA
    -- Obtener socio titular del puesto 150
    SELECT socio_id INTO v_socio_titular_id
      FROM public.historial_titularidad
     WHERE puesto_id = 150 AND fecha_fin IS NULL
     LIMIT 1;

    -- Si no tiene titular, usar el primer socio activo de la Cooperativa como placeholder (requerido por NOT NULL)
    IF v_socio_titular_id IS NULL THEN
        SELECT id INTO v_socio_titular_id 
          FROM public.socios 
         WHERE deleted_at IS NULL 
         ORDER BY id 
         LIMIT 1;
    END IF;

    -- Cerrar arriendo anterior si existe activo
    SELECT id INTO v_arr_prev_id FROM public.historial_arriendos WHERE puesto_id = 150 AND fecha_fin IS NULL LIMIT 1;
    IF v_arr_prev_id IS NOT NULL THEN
        UPDATE public.historial_arriendos
           SET fecha_fin = '2025-12-31',
               motivo_termino = 'Mig. 00054: Reemplazado por ingreso de Segundo Satalaya en 2026'
         WHERE id = v_arr_prev_id;
    END IF;

    -- Abrir nuevo arriendo
    INSERT INTO public.historial_arriendos (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)
    VALUES (150, v_inq_satalaya_id, v_socio_titular_id, '2026-01-01')
    ON CONFLICT DO NOTHING;

    -- B. Depósito 11-D2 (Puesto ID 58) -> EVELYN CUYA
    -- Evelyn Cuya arrienda el almacén 11-D2. La ocupación va en ocupaciones_almacenes
    SELECT id INTO v_ocu_prev_id FROM public.ocupaciones_almacenes WHERE puesto_id = 58 AND fecha_fin IS NULL LIMIT 1;
    IF v_ocu_prev_id IS NOT NULL THEN
        UPDATE public.ocupaciones_almacenes
           SET fecha_fin = '2025-12-31',
               motivo_cierre = 'Mig. 00054: Reemplazado por ingreso de Evelyn Cuya en 2026'
         WHERE id = v_ocu_prev_id;
    END IF;
    INSERT INTO public.ocupaciones_almacenes (puesto_id, tipo_ocupante, inquilino_id, fecha_inicio)
    VALUES (58, 'Tercero', v_inq_cuya_id, '2026-01-01');

    RAISE NOTICE '00054: Relaciones de arriendo y ocupaciones de almacenes actualizadas.';

    -- =============================================================================
    -- PASO 3 — APLICAR SOFT-DELETE A LOS 5 INQUILINOS RETIRADOS/DUPLICADOS
    -- =============================================================================

    -- A. Gladys Mesias (ID 81)
    UPDATE public.inquilinos
       SET deleted_at = now(),
           anulado_por = v_sistema_uid,
           motivo_anulacion = 'Mig. 00054: Registro inactivo / no figura en Excel de deudas o pagos 2026'
     WHERE id = 81 AND deleted_at IS NULL;

    -- B. Marisol Davila Cahuana (ID 91)
    UPDATE public.inquilinos
       SET deleted_at = now(),
           anulado_por = v_sistema_uid,
           motivo_anulacion = 'Mig. 00054: Registro inactivo / no figura en Excel de deudas o pagos 2026'
     WHERE id = 91 AND deleted_at IS NULL;

    -- C. Rosa Villanueva Inga (ID 83)
    UPDATE public.inquilinos
       SET deleted_at = now(),
           anulado_por = v_sistema_uid,
           motivo_anulacion = 'Mig. 00054: Registro inactivo / no figura en Excel de deudas o pagos 2026'
     WHERE id = 83 AND deleted_at IS NULL;

    -- D. Victor Acco Noa (ID 101, duplicado técnico)
    UPDATE public.inquilinos
       SET deleted_at = now(),
           anulado_por = v_sistema_uid,
           motivo_anulacion = 'Mig. 00054: Duplicado técnico de depósito / se unifica con ID 100'
     WHERE id = 101 AND deleted_at IS NULL;

    -- E. Jessica Patricia Saldaña Donayre (ID 95, duplicado técnico)
    UPDATE public.inquilinos
       SET deleted_at = now(),
           anulado_por = v_sistema_uid,
           motivo_anulacion = 'Mig. 00054: Duplicado técnico de depósito / se unifica con ID 63'
     WHERE id = 95 AND deleted_at IS NULL;

    RAISE NOTICE '00054: Soft-delete aplicado correctamente a los 5 inquilinos retirados/duplicados.';

END $$;

COMMIT;
