-- =============================================================================
-- Migración 00095 — RPC para Reporte de Estados de Cuenta y Resumen de Deudas
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Provee el endpoint server-side para el Resumen Consolidado de Deudas:
--   · rpc_reporte_resumen_deudas() -> devuelve lista unificada de socios e
--     inquilinos con 'deuda_pendiente' y 'cant_pendientes', delegando en la fuente
--     canónica fn_deudas_pagador (00082).
--   · RLS / Seguridad: SECURITY DEFINER con verificación de rol Admin o Caja.
--   · Rendimiento: CROSS JOIN LATERAL sobre fn_deudas_pagador calcula el total
--     y el conteo en una sola pasada.
-- =============================================================================

BEGIN;

CREATE OR REPLACE FUNCTION public.rpc_reporte_resumen_deudas()
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_rol    text;
  v_result json;
BEGIN
  v_rol := public.get_my_rol();
  IF v_rol NOT IN ('Administrador', 'Caja') THEN
    RAISE EXCEPTION 'Acceso denegado: solo Administrador o Caja puede consultar el resumen de deudas.';
  END IF;

  SELECT coalesce(json_agg(t ORDER BY t.tipo, t.nombre), '[]'::json)
  INTO v_result
  FROM (
    -- ── SOCIOS ────────────────────────────────────────────────────────────────
    SELECT
      'socio'::text                   AS tipo,
      s.id,
      s.apellidos                     AS nombre,
      s.dni,
      s.estado,
      s.habilitado,
      coalesce(s.saldo_a_favor, 0)   AS saldo_a_favor,
      p.codigo_puesto,
      p.id                            AS puesto_id,
      coalesce(deu.total, 0)::numeric AS deuda_pendiente,
      coalesce(deu.cant, 0)::int      AS cant_pendientes
    FROM public.socios s
    LEFT JOIN public.historial_titularidad ht
           ON ht.socio_id = s.id AND ht.fecha_fin IS NULL
    LEFT JOIN public.puestos p ON p.id = ht.puesto_id
    CROSS JOIN LATERAL (
      SELECT
        coalesce(sum(d.saldo_pendiente), 0)::numeric AS total,
        count(*)::int                                 AS cant
      FROM public.fn_deudas_pagador('socio', s.id) d
      WHERE d.saldo_pendiente > 0
    ) deu
    WHERE s.deleted_at IS NULL

    UNION ALL

    -- ── INQUILINOS ────────────────────────────────────────────────────────────
    SELECT
      'inquilino'::text               AS tipo,
      i.id,
      i.apellidos                     AS nombre,
      i.dni,
      'Activo'::text                  AS estado,
      NULL::boolean                   AS habilitado,
      coalesce(i.saldo_a_favor, 0)   AS saldo_a_favor,
      p.codigo_puesto,
      p.id                            AS puesto_id,
      coalesce(deu.total, 0)::numeric AS deuda_pendiente,
      coalesce(deu.cant, 0)::int      AS cant_pendientes
    FROM public.inquilinos i
    LEFT JOIN public.historial_arriendos ha
           ON ha.inquilino_id = i.id AND ha.fecha_fin IS NULL
    LEFT JOIN public.puestos p ON p.id = ha.puesto_id
    CROSS JOIN LATERAL (
      SELECT
        coalesce(sum(d.saldo_pendiente), 0)::numeric AS total,
        count(*)::int                                 AS cant
      FROM public.fn_deudas_pagador('inquilino', i.id) d
      WHERE d.saldo_pendiente > 0
    ) deu
    WHERE i.deleted_at IS NULL
  ) t;

  RETURN v_result;
END;
$$;

COMMENT ON FUNCTION public.rpc_reporte_resumen_deudas() IS
  'Reportes > Estados de Cuenta: listado unificado de socios e inquilinos con '
  'deuda_pendiente y cant_pendientes calculadas via fn_deudas_pagador. (00095)';

GRANT EXECUTE ON FUNCTION public.rpc_reporte_resumen_deudas() TO authenticated;

COMMIT;
