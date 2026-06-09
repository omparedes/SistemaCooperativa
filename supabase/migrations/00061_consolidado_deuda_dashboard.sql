-- =============================================================================
-- Migración 00061 — Consolidado de Deuda por Tipo para el Dashboard
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- =============================================================================

BEGIN;

DROP VIEW IF EXISTS public.vw_deuda_consolidada_por_tipo CASCADE;

CREATE OR REPLACE VIEW public.vw_deuda_consolidada_por_tipo
WITH (security_invoker = true) AS
SELECT 
    tipo_deudor,
    SUM(saldo)::numeric(14,2) AS total_saldo
FROM public.vw_deuda_filtrada
GROUP BY tipo_deudor;

COMMENT ON VIEW public.vw_deuda_consolidada_por_tipo IS
    'Consolida la deuda pendiente total por tipo de deudor para evitar límites de paginación en el Dashboard.';

GRANT SELECT ON public.vw_deuda_consolidada_por_tipo TO authenticated, anon;

COMMIT;
