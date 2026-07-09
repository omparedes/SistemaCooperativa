-- =============================================================================
-- Migración 00088 — RPC Padrón Electoral Completo (Asambleas)
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- rpc_asambleas_padron(): calcula en un solo viaje la deuda consolidada
-- (fn_deudas_pagador, fuente canónica — 00082) de TODOS los socios en estado
-- 'Activo' y los separa en dos listas:
--   · habiles       — deuda_total = 0
--   · inhabilitados — deuda_total > 0 (con el monto)
-- Solo socios Activos entran al padrón (un socio Inactivo no aparece aunque
-- deba cero). Rol Admin|Caja, igual que el resto del módulo de Asambleas.
-- =============================================================================

BEGIN;

CREATE OR REPLACE FUNCTION public.rpc_asambleas_padron()
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    v_habiles       json;
    v_inhabilitados json;
BEGIN
    IF public.get_my_rol() NOT IN ('Administrador', 'Caja') THEN
        RAISE EXCEPTION 'Acceso denegado.';
    END IF;

    CREATE TEMP TABLE tmp_padron_electoral ON COMMIT DROP AS
    SELECT
        s.id,
        s.dni,
        s.nombres,
        s.apellidos,
        p.codigo_puesto,
        coalesce(
            (SELECT sum(d.saldo_pendiente)
             FROM public.fn_deudas_pagador('socio', s.id) d
             WHERE d.saldo_pendiente > 0),
            0
        )::numeric(12,2) AS deuda_total
    FROM public.socios s
    LEFT JOIN public.historial_titularidad ht
           ON ht.socio_id = s.id AND ht.fecha_fin IS NULL
    LEFT JOIN public.puestos p ON p.id = ht.puesto_id
    WHERE s.deleted_at IS NULL
      AND s.estado = 'Activo';

    SELECT coalesce(json_agg(json_build_object(
        'id',            t.id,
        'dni',           t.dni,
        'nombres',       t.nombres,
        'apellidos',     t.apellidos,
        'codigo_puesto', t.codigo_puesto
    ) ORDER BY t.apellidos, t.nombres), '[]'::json)
    INTO v_habiles
    FROM tmp_padron_electoral t
    WHERE t.deuda_total = 0;

    SELECT coalesce(json_agg(json_build_object(
        'id',            t.id,
        'dni',           t.dni,
        'nombres',       t.nombres,
        'apellidos',     t.apellidos,
        'codigo_puesto', t.codigo_puesto,
        'deuda_total',   t.deuda_total
    ) ORDER BY t.deuda_total DESC, t.apellidos), '[]'::json)
    INTO v_inhabilitados
    FROM tmp_padron_electoral t
    WHERE t.deuda_total > 0;

    RETURN json_build_object(
        'generado_en',   (now() AT TIME ZONE 'America/Lima'),
        'total_activos', (SELECT count(*) FROM tmp_padron_electoral),
        'habiles',       v_habiles,
        'inhabilitados', v_inhabilitados
    );
END;
$$;

COMMENT ON FUNCTION public.rpc_asambleas_padron() IS
    'Padrón Electoral completo: separa a todos los socios Activos en Hábiles '
    '(deuda = 0) e Inhabilitados (deuda > 0), calculado sobre fn_deudas_pagador '
    '— misma fuente canónica que Caja/Cuenta Corriente/Portal. Rol Admin|Caja. (00088)';

GRANT EXECUTE ON FUNCTION public.rpc_asambleas_padron() TO authenticated;

COMMIT;
