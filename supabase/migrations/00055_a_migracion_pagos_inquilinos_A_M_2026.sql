-- Migración 00055_a — Carga de Pagos Detallados Inquilinos A-M (2026)
BEGIN;

SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  15.90,
  'Efectivo',
  'RII 3187',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  12.00,
  'Efectivo',
  'RII 3187',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  180.00,
  'Efectivo',
  'EB01-6659',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  17.00,
  'Efectivo',
  'RII 3261',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  12.00,
  'Efectivo',
  'RII 3261',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6757',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  17.00,
  'Efectivo',
  'RII 3261',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  11.00,
  'Efectivo',
  'RII 3261',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-6892',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  28.30,
  'Efectivo',
  'RII 3352',
  'Migracion 2026: Pago ENERO MULTA X CAPACITACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  570.00,
  'Efectivo',
  'EB01-6930',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  230.00,
  'Efectivo',
  'EB01-7015',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  16.00,
  'Efectivo',
  'RII 3352',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  11.00,
  'Efectivo',
  'RII 3352',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  700.00,
  'Efectivo',
  'EB01-7083',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7197',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  17.00,
  'Efectivo',
  'RII 3406',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  11.00,
  'Efectivo',
  'RII 3406',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7282',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7363',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL),
  700.00,
  'Efectivo',
  'EB01 - 7481',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL),
  36.00,
  'Efectivo',
  'RII 3197',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3197',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL),
  550.00,
  'Efectivo',
  'EB01-6679',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL),
  550.00,
  'Efectivo',
  'EB01-6874',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL),
  36.00,
  'Efectivo',
  'RII 3257',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3257',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL),
  36.00,
  'Efectivo',
  'RII 3304',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3304',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL),
  550.00,
  'Efectivo',
  'EB01-7035',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL),
  36.00,
  'Efectivo',
  'RII 3348',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3348',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL),
  550.00,
  'Efectivo',
  'EB01-7191',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL),
  550.00,
  'Efectivo',
  'EB01-7393',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL),
  36.00,
  'Efectivo',
  'RII 3427',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3427',
  'Migracion 2026: Pago ABRIL AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL),
  9.80,
  'Efectivo',
  'RII 3198',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3198',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01- 6686',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-6915',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6929',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL),
  9.10,
  'Efectivo',
  'RII 3292',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3292',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-6929',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6993',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL),
  8.50,
  'Efectivo',
  'RII 3373',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3373',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL),
  450.00,
  'Efectivo',
  'EB01-7130',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL),
  8.10,
  'Efectivo',
  'RII 3373',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3373',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-7262',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7420',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL),
  1000.00,
  'Efectivo',
  'RII 3183',
  'Migracion 2026: Pago ENERO GARANTIA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL),
  700.00,
  'Efectivo',
  'EB01-6648',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL),
  14.30,
  'Efectivo',
  'RII 3291',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3291',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-7000',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7061',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL),
  20.20,
  'Efectivo',
  'RII 3374',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3374',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL),
  700.00,
  'Efectivo',
  'EB01-7211',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL),
  19.70,
  'Efectivo',
  'RII 3374',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3374',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL),
  700.00,
  'Efectivo',
  'EB01-7390',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6617',
  'Migracion 2026: Pago OCTUBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6623',
  'Migracion 2026: Pago OCTUBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6637',
  'Migracion 2026: Pago OCTUBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6642',
  'Migracion 2026: Pago OCTUBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3250',
  'Migracion 2026: Pago OCTUBRE FUMIGACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6646',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6655',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6660',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6669',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6680',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6693',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6700',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6728',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6786',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6800',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6801',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6846',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  39.40,
  'Efectivo',
  'RII 3396',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3396',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6749',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6846',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-6880',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  400.00,
  'Efectivo',
  'EB01-6965',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  5.60,
  'Efectivo',
  'RII 3396',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  40.00,
  'Efectivo',
  'RII 3408',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3408',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6965',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7004',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  400.00,
  'Efectivo',
  'EB01-7194',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7235',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  44.30,
  'Efectivo',
  'RII 3418',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII3418',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  28.30,
  'Efectivo',
  'RII 3418',
  'Migracion 2026: Pago ENERO MULTA X CAPACITACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7235',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7272',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3408',
  'Migracion 2026: Pago ABRIL FUMIGACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL),
  10.60,
  'Efectivo',
  'RII 3368',
  'Migracion 2026: Pago OCTUBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3368',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL),
  8.50,
  'Efectivo',
  'RII 3368',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3368',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL),
  9.40,
  'Efectivo',
  'RII 3368',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3368',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6769',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL),
  11.60,
  'Efectivo',
  'RII 3368',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3368',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6939',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL),
  11.60,
  'Efectivo',
  'RII 3368',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3368',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7098',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL),
  9.60,
  'Efectivo',
  'RII 3369',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3369',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7298',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01 - 7496',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL),
  120.60,
  'Efectivo',
  'RII 3213',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3213',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL),
  800.00,
  'Efectivo',
  'EB01-6759',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL),
  117.20,
  'Efectivo',
  'RII 3263',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3263',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL),
  1000.00,
  'Efectivo',
  'EB01-6932',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL),
  115.50,
  'Efectivo',
  'RII 3312',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3312',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL),
  1000.00,
  'Efectivo',
  'EB01-7058',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL),
  119.60,
  'Efectivo',
  'RII 3407',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3407',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL),
  1000.00,
  'Efectivo',
  'EB01-7284',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL),
  1000.00,
  'Efectivo',
  'EB01 - 7483',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3175',
  'Migracion 2026: Pago AGOSTO TALONARIO SANTA ROSA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3254',
  'Migracion 2026: Pago SETIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  4.00,
  'Efectivo',
  'RII 3254',
  'Migracion 2026: Pago SETIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3254',
  'Migracion 2026: Pago OCTUBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3254',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-6632',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3254',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3254',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6632',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6703',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6740',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3254',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3254',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6887',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  90.00,
  'Efectivo',
  'EB01-6850',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6898',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3271',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3271',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6917',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  210.00,
  'Efectivo',
  'EB01-6999',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7102',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  14.40,
  'Efectivo',
  'RII 3335',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3335',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7243',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7368',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7445',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7445',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7461',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3224',
  'Migracion 2026: Pago AGOSTO TALONARIO SANTA ROSA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  3.40,
  'Efectivo',
  'RII 3224',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  23.60,
  'Efectivo',
  'RII 3224',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3224',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'EB01-6758',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  700.00,
  'Efectivo',
  'EB01-6758',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  21.60,
  'Efectivo',
  'RII 3224',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3224',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  700.00,
  'Efectivo',
  'EB01-6931',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  21.70,
  'Efectivo',
  'RII 3224',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3224',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  700.00,
  'Efectivo',
  'EB01-7084',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  15.70,
  'Efectivo',
  'RII 3224',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  3.80,
  'Efectivo',
  'RII 3317',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3317',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  700.00,
  'Efectivo',
  'EB01-7283',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  10.20,
  'Efectivo',
  'RII 3317',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3383',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  0.80,
  'Efectivo',
  'RII 3442',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3442',
  'Migracion 2026: Pago ABRIL AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3442',
  'Migracion 2026: Pago ABRIL FUMIGACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  38.20,
  'Efectivo',
  'RII 3442',
  'Migracion 2026: Pago MAYO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '40-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL),
  700.00,
  'Efectivo',
  'EB01 - 7482',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'EB01-6630',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  135.00,
  'Efectivo',
  'EB01-6701',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3202',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3202',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  115.00,
  'Efectivo',
  'EB01-6737',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6803',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  160.00,
  'Efectivo',
  'EB01-6884',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  40.00,
  'Efectivo',
  'EB01-6885',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3280',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3280',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  28.30,
  'Efectivo',
  'RII 3280',
  'Migracion 2026: Pago ENERO MULTA X CAPACITACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6967',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7047',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3326',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  4.40,
  'Efectivo',
  'RII 3327',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3327',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7153',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  129.60,
  'Efectivo',
  'EB01-7154',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7239',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  5.60,
  'Efectivo',
  'RII 3376',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3376',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  220.40,
  'Efectivo',
  'EB01-7269',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7375',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7416',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  7.20,
  'Efectivo',
  'RII 3431',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3431',
  'Migracion 2026: Pago ABRIL AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7453',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'EB01-6631',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  135.00,
  'Efectivo',
  'EB01-6702',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3203',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3203',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  115.00,
  'Efectivo',
  'EB01-6738',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6804',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6805',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6886',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3281',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3281',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  28.30,
  'Efectivo',
  'RII 3281',
  'Migracion 2026: Pago ENERO MULTA X CAPACITACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6968',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  180.00,
  'Efectivo',
  'EB01-7048',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  20.00,
  'Efectivo',
  'EB01-7049',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  14.40,
  'Efectivo',
  'RII 3328',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3328',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7155',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  129.60,
  'Efectivo',
  'EB01-7155',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7240',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  5.60,
  'Efectivo',
  'RII 3377',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3377',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  220.40,
  'Efectivo',
  'EB01-7268',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7376',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7417',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  7.20,
  'Efectivo',
  'RII 3432',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3432',
  'Migracion 2026: Pago ABRIL AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7454',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL),
  24.80,
  'Efectivo',
  'RII 3289',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3289',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL),
  15.50,
  'Efectivo',
  'RII 3289',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3289',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6760',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL),
  16.10,
  'Efectivo',
  'RII 3289',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3289',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6933',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL),
  14.50,
  'Efectivo',
  'RII 3428',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3428',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7086',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL),
  12.90,
  'Efectivo',
  'RII 3428',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3428',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7285',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3428',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3428',
  'Migracion 2026: Pago ABRIL AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01 - 7484',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  400.00,
  'Efectivo',
  'EB01-6629',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  180.00,
  'Efectivo',
  'EB01-6697',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII  3201',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3201',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  40.00,
  'Efectivo',
  'EB01-6761',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6836',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  60.00,
  'Efectivo',
  'EB01-7008',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3298',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3298',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  542.00,
  'Efectivo',
  'EB01-7008',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  58.00,
  'Efectivo',
  'EB01-7165',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  14.40,
  'Efectivo',
  'RII 3412',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3412',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  242.00,
  'Efectivo',
  'EB01-7165',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7245',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  58.00,
  'Efectivo',
  'EB01-7331',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  5.60,
  'Efectivo',
  'RII 3412',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3412',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-7286',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  242.00,
  'Efectivo',
  'EB01-7331',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  280.00,
  'Efectivo',
  'EB01-7384',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL),
  28.00,
  'Efectivo',
  'EB01-7385',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL),
  7.90,
  'Efectivo',
  'RII 3186',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3186',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6654',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL),
  6.50,
  'Efectivo',
  'RII 3249',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3249',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6839',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL),
  8.10,
  'Efectivo',
  'RII 3303',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3303',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7024',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL),
  6.60,
  'Efectivo',
  'RII 3321',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3321',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7143',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL),
  9.30,
  'Efectivo',
  'RII 3402',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3402',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7342',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  57.20,
  'Efectivo',
  'EB01-6665',
  'Migracion 2026: Pago JUNIO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  14.60,
  'Efectivo',
  'RII 3189',
  'Migracion 2026: Pago JULIO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  10.80,
  'Efectivo',
  'RII 3189',
  'Migracion 2026: Pago JULIO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  4.50,
  'Efectivo',
  'RII 3189',
  'Migracion 2026: Pago AGOSTO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  18.80,
  'Efectivo',
  'RII 3189',
  'Migracion 2026: Pago AGOSTO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  8.50,
  'Efectivo',
  'RII 3189',
  'Migracion 2026: Pago SETIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  13.00,
  'Efectivo',
  'RII 3189',
  'Migracion 2026: Pago SETIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  12.70,
  'Efectivo',
  'RII 3189',
  'Migracion 2026: Pago OCTUBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  31.90,
  'Efectivo',
  'RII 3189',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  228.00,
  'Efectivo',
  'EB01-6665',
  'Migracion 2026: Pago OCTUBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  82.00,
  'Efectivo',
  'EB01-6666',
  'Migracion 2026: Pago OCTUBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  16.90,
  'Efectivo',
  'RII 3190',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  46.80,
  'Efectivo',
  'RII 3190',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  54.30,
  'Efectivo',
  'EB01-6666',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  295.70,
  'Efectivo',
  'EB01-6975',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  17.90,
  'Efectivo',
  'RII 3284',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  45.40,
  'Efectivo',
  'RII 3284',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  241.00,
  'Efectivo',
  'EB01-6975',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  109.00,
  'Efectivo',
  'EB01-7202',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  20.00,
  'Efectivo',
  'RII 3355',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  59.40,
  'Efectivo',
  'RII 3355',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  311.60,
  'Efectivo',
  'EB01-7202',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  38.40,
  'Efectivo',
  'EB01-7326',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-7326',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  15.80,
  'Efectivo',
  'RII 3419',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  63.40,
  'Efectivo',
  'RII 3419',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  11.60,
  'Efectivo',
  'EB01-7326',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  16.50,
  'Efectivo',
  'RII 3419',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  84.60,
  'Efectivo',
  'RII 3419',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL),
  119.70,
  'Efectivo',
  'EB01-7421',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'E001-292',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'E001-297',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'E001-305',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  120.00,
  'Efectivo',
  'E001-307',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  26.50,
  'Efectivo',
  'RII 3221',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3221',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'E001-308',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  80.00,
  'Efectivo',
  'E001-313',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'E001-314',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'E001-317',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'E001-318',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'E001-319',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  21.10,
  'Efectivo',
  'RII 3269',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3269',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'E001-323',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'E001-330',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'E001-331',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'E001-336',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'E001-346',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'E001-353',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'E001-358',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'E001-365',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  0.10,
  'Efectivo',
  'RII 3345',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3345',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  20.00,
  'Efectivo',
  'RII 3346',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'E001-365',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'E001-370',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  20.10,
  'Efectivo',
  'RII 3379',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3379',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'E001-376',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'E001-380',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'E001-383',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'E001-383',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'E001-386',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'E001-389',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3193',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3193',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-6674',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6739',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3219',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3219',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  220.00,
  'Efectivo',
  'EB01-6840',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6841',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  180.00,
  'Efectivo',
  'EB01-7006',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3331',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3331',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  120.00,
  'Efectivo',
  'EB01-7006',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7007',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  14.40,
  'Efectivo',
  'RII 3331',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3331',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  80.00,
  'Efectivo',
  'EB01-7160',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  112.00,
  'Efectivo',
  'EB01-7160',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  188.00,
  'Efectivo',
  'EB01-7198',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7249',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  5.60,
  'Efectivo',
  'RII 3370',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3370',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7332',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7332',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL),
  400.00,
  'Efectivo',
  'EB01-7413',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-6634',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6708',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3205',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3205',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6743',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-6916',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  9.00,
  'Efectivo',
  'RII 3270',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3270',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6916',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6977',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7011',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7114',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3338',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3338',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7167',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7200',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7238',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7271',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7087',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-7271',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  70.00,
  'Efectivo',
  'EB01-7297',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3399',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3399',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7335',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-7336',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  80.00,
  'Efectivo',
  'EB01-7378',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3400',
  'Migracion 2026: Pago ABRIL FUMIGACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  140.00,
  'Efectivo',
  'EB01-7425',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7458',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01 - 7485',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3192',
  'Migracion 2026: Pago AGOSTO TALONARIO SANTA ROSA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL),
  30.50,
  'Efectivo',
  'RII 3192',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3192',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL),
  650.00,
  'Efectivo',
  'EB01-6673',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL),
  26.60,
  'Efectivo',
  'RII 3258',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3258',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL),
  700.00,
  'Efectivo',
  'EB01-6879',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL),
  35.50,
  'Efectivo',
  'RII 3323',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3323',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL),
  35.00,
  'Efectivo',
  'RII 3323',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3323',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL),
  700.00,
  'Efectivo',
  'EB01-7149',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL),
  400.00,
  'Efectivo',
  'EB01-7241',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7242',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL),
  700.00,
  'Efectivo',
  'EB01-7372',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08914131' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-6645',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08914131' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-6853',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08914131' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7020',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08914131' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7216',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08914131' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3426',
  'Migracion 2026: Pago ABRIL FUMIGACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08914131' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7435',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08914131' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3426',
  'Migracion 2026: Pago MAYO TALONARIO DIA DE LA MADRE',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3179',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3179',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6640',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3237',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3237',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6807',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3301',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3301',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL),
  28.30,
  'Efectivo',
  'RII 3332',
  'Migracion 2026: Pago ENERO MULTA X CAPACITACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7023',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL),
  14.40,
  'Efectivo',
  'RII 3332',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3332',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7161',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL),
  5.60,
  'Efectivo',
  'RII 3397',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3397',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7333',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3278',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3278',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6762',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3278',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3278',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL),
  360.00,
  'Efectivo',
  'EB01-6946',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL),
  140.00,
  'Efectivo',
  'EB01-6961',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL),
  14.40,
  'Efectivo',
  'RII 3337',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3337',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7088',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7288',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL),
  240.00,
  'Efectivo',
  'EB01 - 7486',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20097655' AND deleted_at IS NULL),
  450.00,
  'Efectivo',
  'EB01-6619',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20097655' AND deleted_at IS NULL),
  450.00,
  'Efectivo',
  'EB01-6819',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20097655' AND deleted_at IS NULL),
  450.00,
  'Efectivo',
  'EB01-7019',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20097655' AND deleted_at IS NULL),
  450.00,
  'Efectivo',
  'EB01-7131',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20097655' AND deleted_at IS NULL),
  450.00,
  'Efectivo',
  'EB01-7367',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20097655' AND deleted_at IS NULL),
  450.00,
  'Efectivo',
  'EB01-7476',
  'Migracion 2026: Pago JULIO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3173',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3173',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6625',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3232',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3232',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6798',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3294',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3294',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL),
  28.30,
  'Efectivo',
  'RII 3339',
  'Migracion 2026: Pago ENERO MULTA X CAPACITACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6997',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL),
  14.40,
  'Efectivo',
  'RII 3339',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3339',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7171',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL),
  5.60,
  'Efectivo',
  'RII 3393',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3393',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7328',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3188',
  'Migracion 2026: Pago AGOSTO TALONARIO SANTA ROSA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3188',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3188',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6664',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 23247',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3247',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6835',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3351',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3351',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  28.30,
  'Efectivo',
  'RII 3351',
  'Migracion 2026: Pago ENERO MULTA X CAPACITACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  14.40,
  'Efectivo',
  'RII 3351',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3351',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7095',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7270',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  5.60,
  'Efectivo',
  'RII 3378',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3378',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7270',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  170.00,
  'Efectivo',
  'EB01-7373',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  30.00,
  'Efectivo',
  'EB01-7374',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7414',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7415',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL),
  9.00,
  'Efectivo',
  'RII 3168',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3168',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-6614',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL),
  7.70,
  'Efectivo',
  'RII 3227',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3227',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-6784',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL),
  8.30,
  'Efectivo',
  'RII 3286',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3286',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-6982',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL),
  7.70,
  'Efectivo',
  'RII 3314',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3314',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-7104',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL),
  6.30,
  'Efectivo',
  'RII 3363',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3363',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-7322',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-7508',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL),
  91.20,
  'Efectivo',
  'RII 3191',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL),
  8.50,
  'Efectivo',
  'RII 3191',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL),
  1000.00,
  'Efectivo',
  'EB01-6671',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6672',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL),
  92.50,
  'Efectivo',
  'RII 3220',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL),
  8.50,
  'Efectivo',
  'RII 3220',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL),
  1200.00,
  'Efectivo',
  'EB01-6857',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL),
  89.90,
  'Efectivo',
  'RII 3341',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL),
  6.40,
  'Efectivo',
  'RII 3341',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL),
  1200.00,
  'Efectivo',
  'EB01-7068',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL),
  88.60,
  'Efectivo',
  'RII 3341',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3341',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL),
  1200.00,
  'Efectivo',
  'EB01-7209',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL),
  91.80,
  'Efectivo',
  'RI 3416',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3416',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3416',
  'Migracion 2026: Pago ABRIL FUMIGACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL),
  1200.00,
  'Efectivo',
  'EB01-7408',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3364',
  'Migracion 2026: Pago AGOSTO TALONARIO SANTA ROSA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  8.60,
  'Efectivo',
  'RII 3239',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3239',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-6744',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6808',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  8.20,
  'Efectivo',
  'RII 3239',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3239',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-6889',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  7.60,
  'Efectivo',
  'RII 3260',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3260',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6976',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7014',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7069',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-7168',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7168',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7246',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  8.90,
  'Efectivo',
  'RII 3364',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3364',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7276',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-7344',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  6.50,
  'Efectivo',
  'RII 3364',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3364',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7344',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  45.00,
  'Efectivo',
  'EB01-7352',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7383',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'EB01-7462',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  7.40,
  'Efectivo',
  'RII 3436',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3436',
  'Migracion 2026: Pago ABRIL AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL),
  245.00,
  'Efectivo',
  'EB01-7462',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  8.00,
  'Efectivo',
  'RII 3262',
  'Migracion 2026: Pago SETIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  4.00,
  'Efectivo',
  'RII 3262',
  'Migracion 2026: Pago SETIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3262',
  'Migracion 2026: Pago OCTUBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  2.00,
  'Efectivo',
  'RII 3262',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  4.00,
  'Efectivo',
  'RII 3404',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  9.00,
  'Efectivo',
  'RII 3404',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3404',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3404',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3404',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  230.00,
  'Efectivo',
  'EB01-6713',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  20.00,
  'Efectivo',
  'EB01-6714',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  7.00,
  'Efectivo',
  'RII 3404',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'EB01-6714',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6893',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6894',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'EB01-6894',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'EB01-7044',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'EB01-7044',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'EB01-7224',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'EB01-7224',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'EB01-7505',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'EB01-7505',
  'Migracion 2026: Pago JUNIO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3180',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII3180',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6641',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3238',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3238',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6806',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3302',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3302',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL),
  28.30,
  'Efectivo',
  'RII 3333',
  'Migracion 2026: Pago ENERO MULTA X CAPACITACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7022',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL),
  14.40,
  'Efectivo',
  'RII 3333',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3333',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7162',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL),
  5.60,
  'Efectivo',
  'RII 3398',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3398',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7334',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL),
  340.00,
  'Efectivo',
  'EB01 - 7501',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL),
  36.00,
  'Efectivo',
  '3222',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  '3222',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL),
  36.00,
  'Efectivo',
  '3222',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  '3222',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL),
  550.00,
  'Efectivo',
  'EB01-6754',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL),
  36.00,
  'Efectivo',
  'RII 3381',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL),
  8.00,
  'Efectivo',
  'RII 3381',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL),
  550.00,
  'Efectivo',
  'EB01-6926',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL),
  36.00,
  'Efectivo',
  'RII 3307',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL),
  8.00,
  'Efectivo',
  'RII 3307',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL),
  550.00,
  'Efectivo',
  'EB01-7060',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL),
  36.00,
  'Efectivo',
  'RII 3381',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3381',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL),
  550.00,
  'Efectivo',
  'EB01-7274',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL),
  550.00,
  'Efectivo',
  'EB01-7477',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  25.00,
  'Efectivo',
  'RII 3174',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3174',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6628',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  25.00,
  'Efectivo',
  'RII 3242',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3242',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6812',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  30.00,
  'Efectivo',
  'RII 3309',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3309',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  17.00,
  'Efectivo',
  'RII 3309',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  12.00,
  'Efectivo',
  'RII 3310',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3310',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7062',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  29.00,
  'Efectivo',
  'RII 3372',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3372',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7253',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7446',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  30.00,
  'Efectivo',
  'RII 3429',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3429',
  'Migracion 2026: Pago ABRIL AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3429',
  'Migracion 2026: Pago ABRIL FUMIGACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL),
  44.00,
  'Efectivo',
  'RII 3164',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3164',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-6602',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL),
  44.00,
  'Efectivo',
  'RII 3230',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3230',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-6792',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL),
  44.00,
  'Efectivo',
  'RII 3275',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL),
  8.00,
  'Efectivo',
  'RII 3275',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-6951',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL),
  44.00,
  'Efectivo',
  'RII 3313',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL),
  8.00,
  'Efectivo',
  'RII 3313',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-7103',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL),
  44.00,
  'Efectivo',
  'RII 3385',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3385',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-7303',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-7509',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10106511476' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'E001-298',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10106511476' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'E001.315',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10106511476' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'E001-345',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10106511476' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'E001-371',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10106511476' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3437',
  'Migracion 2026: Pago ABRIL FUMIGACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-SP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10106511476' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'E001-390',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  8.90,
  'Efectivo',
  'RII 3170',
  'Migracion 2026: Pago OCTUBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3173',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  11.00,
  'Efectivo',
  'RII 3170',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3170',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6620',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6706',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6811',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  8.60,
  'Efectivo',
  'RII 3240',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3240',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6888',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  9.60,
  'Efectivo',
  'RII 3282',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3282',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6969',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7115',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7115',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7166',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7201',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7244',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  9.00,
  'Efectivo',
  'RII 3410',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3410',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7379',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7422',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  8.50,
  'Efectivo',
  'RII 3434',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3434',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3410',
  'Migracion 2026: Pago ABRIL FUMIGACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  5.50,
  'Efectivo',
  'RII 3434',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7457',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3225',
  'Migracion 2026: Pago AGOSTO TALONARIO SANTA ROSA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3225',
  'Migracion 2026: Pago OCTUBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3225',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3225',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3225',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EBO1-6626',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6763',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3324',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3324',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  180.00,
  'Efectivo',
  'EB01-6763',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  320.00,
  'Efectivo',
  'EB01-6947',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3324',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3324',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7089',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  14.40,
  'Efectivo',
  'RII 3324',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3324',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'EB01-7150',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  190.00,
  'Efectivo',
  'EB01-7289',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  5.60,
  'Efectivo',
  'RII 3394',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3394',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  60.00,
  'Efectivo',
  'EB01-7329',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3394',
  'Migracion 2026: Pago ABRIL FUMIGACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  400.00,
  'Efectivo',
  'EB01-7447',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  7.20,
  'Efectivo',
  'RII 3430',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3430',
  'Migracion 2026: Pago ABRIL AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01 - 7487',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01 - 7487',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  26.80,
  'Efectivo',
  'RII 3214',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3214',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6732',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  38.20,
  'Efectivo',
  'RII 3272',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3272',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6924',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  400.00,
  'Efectivo',
  'EB01-6925',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  32.70,
  'Efectivo',
  'RII 3315',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3315',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7107',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  28.30,
  'Efectivo',
  'RII 3386',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3386',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7304',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3421',
  'Migracion 2026: Pago ABRIL FUMIGACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7424',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  30.00,
  'Efectivo',
  'RII 3440',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3440',
  'Migracion 2026: Pago ABRIL AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '60-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7471',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3244',
  'Migracion 2026: Pago AGOSTO TALONARIO SANTA ROSA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  7.20,
  'Efectivo',
  'RII 3241',
  'Migracion 2026: Pago OCTUBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3241',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  290.00,
  'Efectivo',
  'EB01-6675',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'EB01-6676',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-6752',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  7.30,
  'Efectivo',
  'RII 3241',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3241',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-6753',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  7.00,
  'Efectivo',
  'RII 3241',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  3.50,
  'Efectivo',
  'RII 3241',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  21.10,
  'Efectivo',
  'RII 3244',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01 - 6815',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  8.20,
  'Efectivo',
  'RII 3422',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  25.80,
  'Efectivo',
  'RII 3422',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  550.00,
  'Efectivo',
  'EB01-7025',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-7173',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  7.80,
  'Efectivo',
  'RII 3422',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  25.20,
  'Efectivo',
  'RII 3422',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7173',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7210',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  40.00,
  'Efectivo',
  'EB01-7277',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  60.00,
  'Efectivo',
  'EB01-7278',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7323',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7343',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  5.60,
  'Efectivo',
  'RII 3422',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  17.40,
  'Efectivo',
  'RII 3422',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  400.00,
  'Efectivo',
  'EB01-7386',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3423',
  'Migracion 2026: Pago ABRIL FUMIGACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL),
  90.00,
  'Efectivo',
  'EB01-7463',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  29.90,
  'Efectivo',
  'RII3178',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  7.00,
  'Efectivo',
  'RII 3178',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-6638',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  31.40,
  'Efectivo',
  'RII 3229',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  5.30,
  'Efectivo',
  'RII 3229',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-6791',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  30.20,
  'Efectivo',
  'RII 3295',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  5.80,
  'Efectivo',
  'RII 3295',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  0.60,
  'Efectivo',
  'RII 3296',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-6998',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  1.30,
  'Efectivo',
  'RII 3229',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  0.40,
  'Efectivo',
  'RII 3296',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  30.00,
  'Efectivo',
  'RII 3322',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3322',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-7144',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  22.50,
  'Efectivo',
  'RII 3389',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3389',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-7315',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7510',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7511',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6802',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  30.00,
  'Efectivo',
  'RII 3233',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3233',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  170.00,
  'Efectivo',
  'EB01-6966',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  35.00,
  'Efectivo',
  'RII 3279',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3279',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  28.30,
  'Efectivo',
  'RII 3279',
  'Migracion 2026: Pago ENERO MULTA X CAPACITACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6966',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  400.00,
  'Efectivo',
  'EB01-7163',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  34.00,
  'Efectivo',
  'RII 3334',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3334',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7163',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7090',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7250',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  34.00,
  'Efectivo',
  'RII 3371',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3371',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  30.00,
  'Efectivo',
  'EB01-7290',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  120.00,
  'Efectivo',
  'EB01-7340',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  80.00,
  'Efectivo',
  'EB01-7340',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01 - 7488',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL),
  23.20,
  'Efectivo',
  'RII 3184',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3184',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-6651',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL),
  21.90,
  'Efectivo',
  'RII 3234',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3234',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-6877',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL),
  26.00,
  'Efectivo',
  'RII 3300',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3300',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-7018',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL),
  30.40,
  'Efectivo',
  'RII 3343',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3343',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL),
  400.00,
  'Efectivo',
  'EB01-7177',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7178',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL),
  30.40,
  'Efectivo',
  'RII 3415',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3415',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-7406',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46101817' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-6687',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46101817' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-6955',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46101817' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-6955',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46101817' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7223',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46101817' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7396',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  89.90,
  'Efectivo',
  'RII 3165',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3165',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  550.00,
  'Efectivo',
  'EB01-6604',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  87.60,
  'Efectivo',
  '3226',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  '3226',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  800.00,
  'Efectivo',
  'EB01-6780',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  77.30,
  'Efectivo',
  'RII 3285',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3285',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  800.00,
  'Efectivo',
  'EB01-6979',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  78.50,
  'Efectivo',
  'RII 3316',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3316',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  800.00,
  'Efectivo',
  'EB01-7108',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  68.50,
  'Efectivo',
  'RII 3388',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3388',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  800.00,
  'Efectivo',
  'EB01-7311',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  86.70,
  'Efectivo',
  'RII 3441',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3441',
  'Migracion 2026: Pago ABRIL AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '61-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL),
  800.00,
  'Efectivo',
  'EB01-7472',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3268',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3268',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3268',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3268',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6764',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3268',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3268',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6934',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL),
  14.40,
  'Efectivo',
  'RII 3311',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3311',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7091',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL),
  5.60,
  'Efectivo',
  'RII 3417',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3417',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7291',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01 - 7489',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  13.90,
  'Efectivo',
  'RII 3200',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3200',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  750.00,
  'Efectivo',
  'EB01-6690',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  850.00,
  'Efectivo',
  'EB01-6908',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  13.30,
  'Efectivo',
  'RII 3267',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3267',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  28.30,
  'Efectivo',
  'RII 3347',
  'Migracion 2026: Pago ENERO MULTA X CAPACITACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  850.00,
  'Efectivo',
  'EB01-7010',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  16.10,
  'Efectivo',
  'RII 3347',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3347',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  850.00,
  'Efectivo',
  'EB01-7190',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  18.20,
  'Efectivo',
  'RII 3357',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3357',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  15.40,
  'Efectivo',
  'RII 3357',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3420',
  'Migracion 2026: Pago ABRIL FUMIGACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  850.00,
  'Efectivo',
  'EB01-7423',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  0.30,
  'Efectivo',
  'RII 3435',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3435',
  'Migracion 2026: Pago ABRIL AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL),
  37.00,
  'Efectivo',
  'RII 3367',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3367',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL),
  35.50,
  'Efectivo',
  'RII 3367',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3367',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6765',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL),
  30.80,
  'Efectivo',
  'RII 3367',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3367',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6935',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL),
  31.60,
  'Efectivo',
  'RII 3367',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3367',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL),
  360.00,
  'Efectivo',
  'EB01-7092',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL),
  140.00,
  'Efectivo',
  'EB01-7138',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL),
  27.40,
  'Efectivo',
  'RII 3367',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3367',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7292',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01 - 7490',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL),
  9.20,
  'Efectivo',
  'RII 3365',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3365',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL),
  8.90,
  'Efectivo',
  'RII 3365',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3365',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6767',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL),
  7.00,
  'Efectivo',
  'RII 3365',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3365',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6937',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL),
  9.00,
  'Efectivo',
  'RII 3365',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3365',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL),
  360.00,
  'Efectivo',
  'EB01-7093',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL),
  140.00,
  'Efectivo',
  'EB01-7137',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL),
  7.00,
  'Efectivo',
  'RII 3366',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3366',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7294',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01 - 7491',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'rRII 3171',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3171',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6621',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3246',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3246',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6822',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3293',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3293',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6994',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL),
  14.40,
  'Efectivo',
  'RII 3319',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3319',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7142',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL),
  5.60,
  'Efectivo',
  'RII 3401',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3401',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7341',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);

COMMIT;