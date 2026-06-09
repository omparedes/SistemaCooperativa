BEGIN;

-- =============================================================================
-- Migración 00071 — Corregir deuda de Gastos Administrativos de Abril 2026 para Mayhuasca
-- Ajustar monto a S/ 60.00 y estado a 'Pendiente' para reflejar el pago parcial
-- =============================================================================

UPDATE public.montos_por_cobrar
   SET monto = 60.00,
       estado = 'Pendiente',
       observacion = 'Alineación de pago parcial G. ADM Abril 2026 · MAYHUASCA BASTIDAS DE TORRES CLUDDY AYDE',
       updated_at = now()
 WHERE id = 3614
   AND puesto_id = 230
   AND concepto_id = 3
   AND periodo_anio = 2026
   AND periodo_mes = 4;

COMMIT;
