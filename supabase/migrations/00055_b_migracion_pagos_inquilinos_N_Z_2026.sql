-- Migración 00055_b — Carga de Pagos Detallados Inquilinos N-Z (2026)
BEGIN;

SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  8.20,
  'Efectivo',
  'RII 3266',
  'Migracion 2026: Pago JULIO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  4.00,
  'Efectivo',
  'RII 3266',
  'Migracion 2026: Pago JULIO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  20.40,
  'Efectivo',
  'RII 3266',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3266',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  26.60,
  'Efectivo',
  'RII 3266',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3266',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  320.00,
  'Efectivo',
  'EB01-6776',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  180.00,
  'Efectivo',
  'EB01-6906',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  29.00,
  'Efectivo',
  'RII 3266',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3266',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6940',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  22.80,
  'Efectivo',
  'RII 3403',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3403',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7101',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  28.10,
  'Efectivo',
  'RII 3403',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3403',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7302',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01 - 7500',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'EII 3206',
  'Migracion 2026: Pago AGOSTO TALONARIO SANTA ROSA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  52.60,
  'Efectivo',
  'EII 3206',
  'Migracion 2026: Pago SETIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  4.00,
  'Efectivo',
  'EII 3206',
  'Migracion 2026: Pago SETIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  43.70,
  'Efectivo',
  'EII 3206',
  'Migracion 2026: Pago OCTUBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'EII 3206',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-6667',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  28.70,
  'Efectivo',
  'RII 3206',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  18.40,
  'Efectivo',
  'RII 3251',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3251',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  19.30,
  'Efectivo',
  'EB01-6847',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-6809',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  46.10,
  'Efectivo',
  'RII 3251',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3251',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  56.20,
  'Efectivo',
  'EB01-6847',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  143.80,
  'Efectivo',
  'EB01-6882',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  6.20,
  'Efectivo',
  'EB01-6882',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  160.00,
  'Efectivo',
  'EB01-6971',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  170.00,
  'Efectivo',
  'EB01-7012',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  163.80,
  'Efectivo',
  'EB01-7156',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  36.20,
  'Efectivo',
  'RII 3354',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3354',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  28.30,
  'Efectivo',
  'RII 3354',
  'Migracion 2026: Pago ENERO MULTA X CAPACITACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  136.20,
  'Efectivo',
  'EB01-7156',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  34.90,
  'Efectivo',
  'RII 3354',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3354',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  191.60,
  'Efectivo',
  'EB01-7199',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7248',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  72.20,
  'Efectivo',
  'EB01-7305',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  44.00,
  'Efectivo',
  'EB01-7305',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  37.80,
  'Efectivo',
  'RII 3387',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3387',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7337',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7338',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7381',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'EB01-7418',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  144.00,
  'Efectivo',
  'EB01-7418',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7459',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  8.90,
  'Efectivo',
  'RII 3212',
  'Migracion 2026: Pago OCTUBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3212',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  8.10,
  'Efectivo',
  'RII 3212',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3212',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  8.60,
  'Efectivo',
  'RII 3212',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3212',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  270.00,
  'Efectivo',
  'EB01-6771',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  80.00,
  'Efectivo',
  'EB01-6783',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  9.90,
  'Efectivo',
  'RII 3340',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3340',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-6941',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  9.00,
  'Efectivo',
  'RII 3340',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3340',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  120.00,
  'Efectivo',
  'EB01-7095',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  230.00,
  'Efectivo',
  'EB01-7172',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  210.00,
  'Efectivo',
  'EB01-7295',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  140.00,
  'Efectivo',
  'EB01-7394',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL),
  110.00,
  'Efectivo',
  'EB01 - 7493',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL),
  2.30,
  'Efectivo',
  'RII 3384',
  'Migracion 2026: Pago AGOSTO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3384',
  'Migracion 2026: Pago AGOSTO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3384',
  'Migracion 2026: Pago SETIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL),
  4.00,
  'Efectivo',
  'RII 3384',
  'Migracion 2026: Pago SETIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3384',
  'Migracion 2026: Pago OCTUBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3384',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL),
  1.70,
  'Efectivo',
  'RII 3384',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL),
  8.30,
  'Efectivo',
  'RII 3443',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3443',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3443',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3443',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-6772',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL),
  11.70,
  'Efectivo',
  'RII 3443',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-6942',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-7096',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-7296',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01 - 7494',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  40.80,
  'Efectivo',
  'RII 3207',
  'Migracion 2026: Pago SETIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  4.00,
  'Efectivo',
  'RII 3207',
  'Migracion 2026: Pago SETIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  34.00,
  'Efectivo',
  'RII 3207',
  'Migracion 2026: Pago OCTUBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3207',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  62.40,
  'Efectivo',
  'EB01-6741',
  'Migracion 2026: Pago OCTUBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-6668',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  37.50,
  'Efectivo',
  'RII 3207',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3207',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  30.00,
  'Efectivo',
  'EB01-6741',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  22.70,
  'Efectivo',
  'RII 3207',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  7.60,
  'Efectivo',
  'EB01-6741',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  70.00,
  'Efectivo',
  'EB01-6742',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  90.00,
  'Efectivo',
  'EB01-6773',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-6810',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-6848',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  11.60,
  'Efectivo',
  'RII 3259',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3259',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  32.40,
  'Efectivo',
  'EB01-6883',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  101.00,
  'Efectivo',
  'EB01-6883',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6972',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  60.00,
  'Efectivo',
  'EB01-6973',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  170.00,
  'Efectivo',
  'EB01-7013',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  21.10,
  'Efectivo',
  'RII 3329',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3329',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  28.30,
  'Efectivo',
  'RII 3329',
  'Migracion 2026: Pago ENERO MULTA X CAPACITACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  69.00,
  'Efectivo',
  'EB01-7158',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  22.10,
  'Efectivo',
  'RII 3329',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3329',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  19.50,
  'Efectivo',
  'EB01-7157',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  131.00,
  'Efectivo',
  'EB01-7158',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7247',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  149.50,
  'Efectivo',
  'EB01-7306',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  10.50,
  'Efectivo',
  'EB01-7306',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'EB01-7339',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  20.40,
  'Efectivo',
  'RII 3411',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3411',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  173.60,
  'Efectivo',
  'EB01-7382',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  65.90,
  'Efectivo',
  'EB01-7419',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  84.10,
  'Efectivo',
  'EB01-7419',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7460',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL),
  42.70,
  'Efectivo',
  'RII 3318',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3318',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL),
  42.90,
  'Efectivo',
  'RII 3318',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3318',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6766',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL),
  38.30,
  'Efectivo',
  'RII 3318',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3318',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6936',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL),
  37.90,
  'Efectivo',
  'RII 3318',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3318',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL),
  360.00,
  'Efectivo',
  'EB01-7094',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL),
  140.00,
  'Efectivo',
  'EB01-7139',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7293',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01 - 7492',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL),
  17.60,
  'Efectivo',
  'RII 3181',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3181',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL),
  20.10,
  'Efectivo',
  'RII 3265',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3265',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6644',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL),
  19.00,
  'Efectivo',
  'RII 3265',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3265',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL),
  650.00,
  'Efectivo',
  'EB01-6901',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL),
  21.40,
  'Efectivo',
  'RII 3349',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3349',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL),
  650.00,
  'Efectivo',
  'EB01-7038',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL),
  23.00,
  'Efectivo',
  'RII 3413',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL),
  7.00,
  'Efectivo',
  'RII 3413',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL),
  8.00,
  'Efectivo',
  'RII 3414',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL),
  650.00,
  'Efectivo',
  'EB01-7192',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL),
  650.00,
  'Efectivo',
  'EB01 - 7402',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3256',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EBE01-6609',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3256',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3256',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-6698',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3256',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3256',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-6873',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3256',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3256',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-7039',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL),
  14.40,
  'Efectivo',
  'RII 3358',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3358',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-7222',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-7407',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL),
  30.90,
  'Efectivo',
  'RII 3228',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3228',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL),
  30.10,
  'Efectivo',
  'RII 3287',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3287',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL),
  1000.00,
  'Efectivo',
  'EB01-6785',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL),
  29.60,
  'Efectivo',
  'RII 3336',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3336',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL),
  1000.00,
  'Efectivo',
  'EB01-6983',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL),
  31.10,
  'Efectivo',
  'RII 3390',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3390',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL),
  1000.00,
  'Efectivo',
  'EB01-7164',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL),
  1000.00,
  'Efectivo',
  'EB01-7316',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  9.00,
  'Efectivo',
  'RII 3169',
  'Migracion 2026: Pago SETIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  4.00,
  'Efectivo',
  'RII 3169',
  'Migracion 2026: Pago SETIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3169',
  'Migracion 2026: Pago OCTUBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3169',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3169',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3169',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  80.00,
  'Efectivo',
  'EB01-6616',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3382',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3382',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6768',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3382',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3382',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6938',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  14.40,
  'Efectivo',
  'RII 3382',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3382',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7097',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7297',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01 - 7495',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL),
  39.00,
  'Efectivo',
  'RII 3210',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3210',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL),
  400.00,
  'Efectivo',
  'EB01-6705',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6712',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL),
  39.00,
  'Efectivo',
  'RII 3210',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3210',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-6842',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL),
  28.30,
  'Efectivo',
  'RII 3255',
  'Migracion 2026: Pago ENERO MULTA X CAPACITACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL),
  45.00,
  'Efectivo',
  'RII 3297',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3297',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-7005',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL),
  44.00,
  'Efectivo',
  'RII 3350',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3350',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-7193',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL),
  44.00,
  'Efectivo',
  'RII 3409',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3409',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL),
  600.00,
  'Efectivo',
  'EB01-7377',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6601',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  9.00,
  'Efectivo',
  'RII 3166',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3166',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6607',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6608',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6627',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6652',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6663',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6696',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  70.00,
  'Efectivo',
  'EB01-6735',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'EB01-6794',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3231',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3231',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  30.00,
  'Efectivo',
  'EB01-6774',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  70.00,
  'Efectivo',
  'EB01-6795',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6845',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6870',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6878',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6914',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3277',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3277',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6956',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  40.00,
  'Efectivo',
  'EB01-6943',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  20.00,
  'Efectivo',
  'EB01-6957',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  170.00,
  'Efectivo',
  'EB01-7003',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7042',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7111',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  70.00,
  'Efectivo',
  'EB01-7129',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  11.00,
  'Efectivo',
  'RII 3392',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3392',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  30.00,
  'Efectivo',
  'EB01-7129',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7148',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7189',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7232',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7265',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  11.00,
  'Efectivo',
  'RII 3392',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3392',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  70.00,
  'Efectivo',
  'EB01-7327',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7371',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  110.00,
  'Efectivo',
  'EB01-7412',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '53-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7449',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3172',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3172',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL),
  700.00,
  'Efectivo',
  'EB01-6622',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3248',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3248',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01 - 6837',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL),
  400.00,
  'Efectivo',
  'EB01 - 6838',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3290',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3290',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL),
  700.00,
  'Efectivo',
  'EB01-6992',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL),
  14.40,
  'Efectivo',
  'RII 3362',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3362',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL),
  700.00,
  'Efectivo',
  'EB01-7134',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL),
  5.60,
  'Efectivo',
  'RII 3362',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3362',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL),
  700.00,
  'Efectivo',
  'EB01-7395',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48462586' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-6670',
  'Migracion 2026: Pago OCTUBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48462586' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-6670',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48462586' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-6863',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48462586' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7151',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48462586' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7207',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '48462586' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7256',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  4.90,
  'Efectivo',
  'RII 3167',
  'Migracion 2026: Pago OCTUBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3167',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3167',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3167',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  90.00,
  'Efectivo',
  'EB01-6610',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-6611',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  5.30,
  'Efectivo',
  'RII 3288',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3288',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  60.00,
  'Efectivo',
  'EB01-6775',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-6948',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  240.00,
  'Efectivo',
  'EB01-6986',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  7.00,
  'Efectivo',
  'RII 3288',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3288',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  28.30,
  'Efectivo',
  'RII 3325',
  'Migracion 2026: Pago ENERO MULTA X CAPACITACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7099',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  9.20,
  'Efectivo',
  'RII 3325',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3325',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7152',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-7234',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  8.00,
  'Efectivo',
  'RII 3360',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3360',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-7299',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01 - 7497',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10625419' AND deleted_at IS NULL),
  1000.00,
  'Efectivo',
  'RII 3342',
  'Migracion 2026: Pago ABRIL GARANTIA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '10625419' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7182',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6707',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6849',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6897',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL),
  15.50,
  'Efectivo',
  'RII 3204',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3204',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6897',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL),
  15.70,
  'Efectivo',
  'RII 3264',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3264',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6897',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL),
  13.80,
  'Efectivo',
  'RII 3353',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3353',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7279',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL),
  121.00,
  'Efectivo',
  'EB01-7362',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  170.00,
  'Efectivo',
  'RII 3177',
  'Migracion 2026: Pago AGOSTO DEPOSITO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'RII 3177',
  'Migracion 2026: Pago SETIEMBRE DEPOSITO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'RII 3177',
  'Migracion 2026: Pago OCTUBRE DEPOSITO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  52.60,
  'Efectivo',
  'RII 3195',
  'Migracion 2026: Pago OCTUBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3195',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-6635',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6636',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  80.00,
  'Efectivo',
  'RII 3177',
  'Migracion 2026: Pago NOVIEMBRE DEPOSITO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  41.40,
  'Efectivo',
  'RII 3195',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'RII 3208',
  'Migracion 2026: Pago NOVIEMBRE DEPOSITO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  8.50,
  'Efectivo',
  'RII 3209',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3209',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  70.00,
  'Efectivo',
  'RII 3209',
  'Migracion 2026: Pago NOVIEMBRE DEPOSITO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  50.60,
  'Efectivo',
  'RII 3209',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3209',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  400.00,
  'Efectivo',
  'EB01-6736',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'RII 3215',
  'Migracion 2026: Pago DICIEMBRE DEPOSITO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'RII 3216',
  'Migracion 2026: Pago DICIEMBRE DEPOSITO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'RII 3252',
  'Migracion 2026: Pago ENERO DEPOSITO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  49.20,
  'Efectivo',
  'RII 3283',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3283',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6970',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7009',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7159',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'EB01-7203',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7230',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-6945',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  48.50,
  'Efectivo',
  'RII 3330',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3330',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7231',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7273',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'RII 3395',
  'Migracion 2026: Pago FEBRERO DEPOSITO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-7330',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'EB01-7380',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  50.50,
  'Efectivo',
  'RII 3380',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3380',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-7301',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  550.00,
  'Efectivo',
  'EB01-7380',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7426',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7455',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7456',
  'Migracion 2026: Pago MARZO DEPOSITO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'EB01 - 7499',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  30.00,
  'Efectivo',
  'EB01-6633',
  'Migracion 2026: Pago AGOSTO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  470.00,
  'Efectivo',
  'EB01-6633',
  'Migracion 2026: Pago SETIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  30.00,
  'Efectivo',
  'EB01-6699',
  'Migracion 2026: Pago SETIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  8.60,
  'Efectivo',
  'RII 3176',
  'Migracion 2026: Pago OCTUBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3176',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  170.00,
  'Efectivo',
  'EB01-6699',
  'Migracion 2026: Pago OCTUBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  330.00,
  'Efectivo',
  'EB01-6799',
  'Migracion 2026: Pago OCTUBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3176',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3176',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  70.00,
  'Efectivo',
  'EB01-6799',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  30.00,
  'Efectivo',
  'EB01-6855',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  170.00,
  'Efectivo',
  'EB01-6856',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  140.00,
  'Efectivo',
  'EB01-6881',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  90.00,
  'Efectivo',
  'EB01-7043',
  'Migracion 2026: Pago NOVIEMBRE AL',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  0.20,
  'Efectivo',
  'RII 3235',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  11.00,
  'Efectivo',
  'RII 3236',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3236',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  110.00,
  'Efectivo',
  'EB01-7043',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7349',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7360',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL),
  1000.00,
  'Efectivo',
  'EB01-6615',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL),
  15.50,
  'Efectivo',
  'RII 3245',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3245',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL),
  850.00,
  'Efectivo',
  'EB01-6820',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3305',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3305',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL),
  1000.00,
  'Efectivo',
  'EB01-6922',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL),
  14.80,
  'Efectivo',
  'RII 3308',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3308',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL),
  1000.00,
  'Efectivo',
  'EB01-7112',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL),
  15.90,
  'Efectivo',
  'RII 3405',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3405',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL),
  750.00,
  'Efectivo',
  'EB01-7320',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'EB01-7348',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL),
  900.00,
  'Efectivo',
  'EB01-7466',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7507',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73192679' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6612',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73192679' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6613',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73192679' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7021',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73192679' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7021',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '73192679' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7208',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '28312595' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EBO1-6788',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '28312595' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7030',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '28312595' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7125',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '28312595' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7361',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '21-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3243',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '21-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3243',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '21-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6770',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '21-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3299',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '21-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3299',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '21-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6944',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '21-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL),
  14.40,
  'Efectivo',
  'RII 3320',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '21-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3320',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '21-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7100',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '21-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL),
  5.60,
  'Efectivo',
  'RII 3391',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '21-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3391',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '21-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7300',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '21-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL),
  7.20,
  'Efectivo',
  'RII 3438',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '21-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3438',
  'Migracion 2026: Pago ABRIL AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '21-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01 - 7498',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3185',
  'Migracion 2026: Pago AGOSTO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3185',
  'Migracion 2026: Pago AGOSTO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3185',
  'Migracion 2026: Pago SETIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  4.00,
  'Efectivo',
  'RII 3185',
  'Migracion 2026: Pago SETIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3185',
  'Migracion 2026: Pago OCTUBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3185',
  'Migracion 2026: Pago OCTUBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3185',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3185',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  380.00,
  'Efectivo',
  'EB01-6653',
  'Migracion 2026: Pago NOVIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6653',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3356',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3356',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7133',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  15.00,
  'Efectivo',
  'RII 3356',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3356',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7204',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  14.40,
  'Efectivo',
  'RII 3356',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3356',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7204',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7204',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  5.60,
  'Efectivo',
  'RII 3439',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3439',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  450.00,
  'Efectivo',
  'EB01-7409',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  7.20,
  'Efectivo',
  'RII 3439',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  1.20,
  'Efectivo',
  'RII 3439',
  'Migracion 2026: Pago ABRIL AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  50.00,
  'Efectivo',
  'EB01-7468',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL),
  250.00,
  'Efectivo',
  'EB01-7467',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL),
  10.00,
  'Efectivo',
  'RII 3182',
  'Migracion 2026: Pago DICIEMBRE RECONEXION DE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL),
  108.00,
  'Efectivo',
  'RII 3196',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3196',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-6816',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'RII 3273',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL),
  127.60,
  'Efectivo',
  'RII 3274',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3274',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-6974',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL),
  235.20,
  'Efectivo',
  'RII 3375',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3375',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7117',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL),
  233.00,
  'Efectivo',
  'RII 3424',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3424',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3424',
  'Migracion 2026: Pago ABRIL FUMIGACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL),
  500.00,
  'Efectivo',
  'EB01-7427',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  11.80,
  'Efectivo',
  'RII 3199',
  'Migracion 2026: Pago NOVIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3199',
  'Migracion 2026: Pago NOVIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  12.80,
  'Efectivo',
  'RII 3199',
  'Migracion 2026: Pago DICIEMBRE LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3199',
  'Migracion 2026: Pago DICIEMBRE AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-6782',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  11.90,
  'Efectivo',
  'RII 3276',
  'Migracion 2026: Pago ENERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  3.00,
  'Efectivo',
  'RII 3276',
  'Migracion 2026: Pago ENERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  28.30,
  'Efectivo',
  'RII 3445',
  'Migracion 2026: Pago ENERO MULTA X CAPACITACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-6954',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  19.10,
  'Efectivo',
  'RII 3359',
  'Migracion 2026: Pago FEBRERO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3359',
  'Migracion 2026: Pago FEBRERO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-7227',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  13.30,
  'Efectivo',
  'RII 3361',
  'Migracion 2026: Pago MARZO LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3361',
  'Migracion 2026: Pago MARZO AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  14.50,
  'Efectivo',
  'RII 3445',
  'Migracion 2026: Pago ABRIL LUZ',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  6.00,
  'Efectivo',
  'RII 3445',
  'Migracion 2026: Pago ABRIL AGUA',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-7502',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-E' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL),
  350.00,
  'Efectivo',
  'EB01-7503',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42799850' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-6747',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42799850' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-6748',
  'Migracion 2026: Pago DICIEMBRE ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42799850' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-6923',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42799850' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7140',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42799850' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7236',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42799850' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7237',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42799850' AND deleted_at IS NULL),
  5.00,
  'Efectivo',
  'RII 3425',
  'Migracion 2026: Pago ABRIL FUMIGACION',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '42799850' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'EB01-7431',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-D3' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'RII 3253',
  'Migracion 2026: Pago DICIEMBRE DEPOSITO N°6 3PISO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-D3' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'RII 3253',
  'Migracion 2026: Pago DICIEMBRE DEPOSITO N°8 3PISO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-D3' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'RII 3253',
  'Migracion 2026: Pago ENERO DEPOSITO N°6 3PISO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-D3' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'RII 3253',
  'Migracion 2026: Pago ENERO DEPOSITO N°8 3PISO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-D3' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'RII 3344',
  'Migracion 2026: Pago FEBRERO DEPOSITO N°6 3PISO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-D3' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'RII 3344',
  'Migracion 2026: Pago FEBRERO DEPOSITO N°8 3PISO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-D3' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'RII 3344',
  'Migracion 2026: Pago MARZO DEPOSITO N°6 3PISO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-D3' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'RII 3344',
  'Migracion 2026: Pago MARZO DEPOSITO N°8 3PISO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-D3' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7448',
  'Migracion 2026: Pago ABRIL DEPOSITO N°5 3PISO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-D3' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7448',
  'Migracion 2026: Pago ABRIL DEPOSITO N°6 3PISO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-4-D3' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7196',
  'Migracion 2026: Pago AGOSTO DEPOSITO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-4-D3' AND deleted_at IS NULL),
  150.00,
  'Efectivo',
  'EB01-7196',
  'Migracion 2026: Pago SETIEMBRE DEPOSITO',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL),
  300.00,
  'Efectivo',
  'E001-309',
  'Migracion 2026: Pago ENERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL),
  260.00,
  'Efectivo',
  'E001-325',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL),
  40.00,
  'Efectivo',
  'E001-338',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL),
  170.00,
  'Efectivo',
  'E001-355',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL),
  130.00,
  'Efectivo',
  'E001-357',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL),
  160.00,
  'Efectivo',
  'E001-377',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL),
  140.00,
  'Efectivo',
  'E001-379',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'E001-393',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'E001-395',
  'Migracion 2026: Pago MAYO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '29096837' AND deleted_at IS NULL),
  140.00,
  'Efectivo',
  'EB01-6825',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '29096837' AND deleted_at IS NULL),
  70.00,
  'Efectivo',
  'EB01-6981',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '29096837' AND deleted_at IS NULL),
  80.00,
  'Efectivo',
  'EB01-7031',
  'Migracion 2026: Pago FEBRERO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '29096837' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7113',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '29096837' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7176',
  'Migracion 2026: Pago MARZO ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '29096837' AND deleted_at IS NULL),
  200.00,
  'Efectivo',
  'EB01-7347',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);
SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-EP' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '29096837' AND deleted_at IS NULL),
  100.00,
  'Efectivo',
  'EB01-7389',
  'Migracion 2026: Pago ABRIL ALQUILER',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);

COMMIT;