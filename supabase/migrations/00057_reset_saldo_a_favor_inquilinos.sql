-- =============================================================================
-- Migración 00057 — Resetear Saldo a Favor de Inquilinos a 0
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Propósito:
--   Al registrar los pagos del 2026 antes de las deudas, el sistema asignó
--   automáticamente el monto pagado como saldo a favor (excedente).
--   Esta migración limpia el saldo a favor de todos los inquilinos a 0.00.
-- =============================================================================

BEGIN;

UPDATE public.inquilinos
   SET saldo_a_favor = 0.00;

COMMIT;
