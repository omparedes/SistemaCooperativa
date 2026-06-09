BEGIN;

-- Corrección de deuda de Depósito para HUASHUAYO GOMEZ EUDOSIA (Puesto 9)
-- Ajustar el monto de Depósito N° 2 de Agosto de 2025 de S/ 190.00 a S/ 200.00
UPDATE public.montos_por_cobrar
SET monto = 200.00
WHERE id = 7990
  AND puesto_id = 52
  AND concepto_id = 16
  AND periodo_anio = 2025
  AND periodo_mes = 8;

COMMIT;
