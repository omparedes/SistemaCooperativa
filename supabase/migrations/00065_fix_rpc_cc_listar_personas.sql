-- =============================================================================
-- Migración 00065 — Corrección de rpc_cc_listar_personas: calcular saldo neto
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- =============================================================================

BEGIN;

CREATE OR REPLACE FUNCTION public.rpc_cc_listar_personas()
RETURNS json
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  result json;
BEGIN
  IF public.get_my_rol() NOT IN ('Administrador', 'Caja') THEN
    RAISE EXCEPTION 'Acceso denegado.';
  END IF;

  SELECT coalesce(json_agg(t ORDER BY t.tipo, t.nombre), '[]'::json)
  INTO result
  FROM (

    -- ── SOCIOS ────────────────────────────────────────────────────────────────
    SELECT
      'socio'::text                   AS tipo,
      s.id,
      s.apellidos                     AS nombre,
      s.dni,
      s.estado,
      s.habilitado,
      s.saldo_a_favor,
      p.codigo_puesto,
      p.id                            AS puesto_id,
      coalesce(
        (
          SELECT sum(
            mc.monto - coalesce(
              (
                SELECT sum(dp.monto_aplicado)
                FROM   public.detalle_pagos dp
                WHERE  dp.monto_id = mc.id
                  AND  dp.deleted_at IS NULL
              ), 0
            )
          )
          FROM   public.montos_por_cobrar mc
          WHERE  mc.deleted_at IS NULL
            AND  mc.estado = 'Pendiente'
            AND  (mc.puesto_id = p.id OR mc.socio_id = s.id)
        ), 0
      )                               AS deuda_pendiente
    FROM public.socios s
    LEFT JOIN public.historial_titularidad ht
           ON ht.socio_id = s.id AND ht.fecha_fin IS NULL
    LEFT JOIN public.puestos p ON p.id = ht.puesto_id
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
      i.saldo_a_favor,
      p.codigo_puesto,
      p.id                            AS puesto_id,
      coalesce(
        (
          SELECT sum(
            mc.monto - coalesce(
              (
                SELECT sum(dp.monto_aplicado)
                FROM   public.detalle_pagos dp
                WHERE  dp.monto_id = mc.id
                  AND  dp.deleted_at IS NULL
              ), 0
            )
          )
          FROM   public.montos_por_cobrar mc
          WHERE  mc.deleted_at IS NULL
            AND  mc.estado = 'Pendiente'
            AND  mc.puesto_id = p.id
        ), 0
      )                               AS deuda_pendiente
    FROM public.inquilinos i
    LEFT JOIN public.historial_arriendos ha
           ON ha.inquilino_id = i.id AND ha.fecha_fin IS NULL
    LEFT JOIN public.puestos p ON p.id = ha.puesto_id
    WHERE i.deleted_at IS NULL

  ) t;

  RETURN result;
END;
$$;

COMMENT ON FUNCTION public.rpc_cc_listar_personas() IS
  'Cuenta Corriente: listado unificado de socios e inquilinos con deuda_pendiente (saldo neto) y saldo_a_favor.';

GRANT EXECUTE ON FUNCTION public.rpc_cc_listar_personas() TO authenticated;

COMMIT;
