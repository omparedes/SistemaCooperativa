-- =============================================================================
-- Migración 00075 — Corrección de desfase de fecha en pagos de Junio 2026
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Corrige el desfase de 1 día hacia atrás causado por guardar las fechas en UTC
-- sin especificar la zona horaria en el script de generación.
-- Añade 17 horas a la fecha_pago, lo que cambia la hora de 00:00:00 UTC (19:00:00 del
-- día anterior en Lima) a 17:00:00 UTC (12:00:00 en Lima/Perú).
-- =============================================================================

BEGIN;

UPDATE public.pagos
SET fecha_pago = fecha_pago + interval '17 hours'
WHERE observacion = 'Migración de pagos Junio 2026'
  AND (fecha_pago::time) = '00:00:00'::time
  AND deleted_at IS NULL;

COMMIT;
