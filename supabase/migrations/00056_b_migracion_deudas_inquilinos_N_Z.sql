-- Migración 00056_b — Carga de Deudas Pendientes Inquilinos N-Z
BEGIN;

INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  31.60,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '46-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  32.40,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  11,
  2026,
  4,
  206.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  18,
  2026,
  4,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL FUMIGACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '58-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  1,
  2026,
  3,
  7.30,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  2,
  2026,
  3,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  8.30,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  240.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '5-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  1,
  2026,
  1,
  3.30,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  2,
  2026,
  1,
  3.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  1,
  2026,
  2,
  14.40,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente FEBRERO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 2
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  2,
  2026,
  2,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente FEBRERO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 2
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  1,
  2026,
  3,
  5.60,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  2,
  2026,
  3,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  7.20,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '27-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  19.10,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  11,
  2026,
  4,
  265.90,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  18,
  2026,
  4,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL FUMIGACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '59-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  1,
  2026,
  3,
  33.10,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  2,
  2026,
  3,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  32.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '57-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  1,
  2025,
  1,
  17.40,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2025
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  2,
  2025,
  1,
  3.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2025
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  6,
  2026,
  1,
  28.30,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO MULTA X CAPACITACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL)
    AND concepto_id = 6
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  18.30,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '28-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  1,
  2026,
  3,
  5.60,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  2,
  2026,
  3,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  7.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  600.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '17-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL),
  6,
  2026,
  1,
  28.30,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO MULTA X CAPACITACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL)
    AND concepto_id = 6
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL),
  1,
  2026,
  4,
  89.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL),
  2,
  2026,
  4,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL),
  18,
  2026,
  4,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL FUMIGACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '45' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  1,
  2026,
  3,
  5.60,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  2,
  2026,
  3,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  7.20,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '10-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  44.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  600.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '18-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  5.60,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  700.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '39-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL),
  18,
  2022,
  8,
  10.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente AGOSTO TAONARIO SANTA ROSA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2022
    AND periodo_mes = 8
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL),
  18,
  2024,
  5,
  10.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO TALONARIO MAMÁ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2024
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL),
  11,
  2025,
  7,
  300.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente JULIO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2025
    AND periodo_mes = 7
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL),
  11,
  2026,
  4,
  300.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL),
  18,
  2026,
  4,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL FUMIGACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL),
  11,
  2026,
  5,
  300.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '6-EP' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  9.30,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '6-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  11,
  2026,
  2,
  279.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente FEBRERO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 2
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  1,
  2026,
  3,
  15.70,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  2,
  2026,
  3,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  11,
  2026,
  3,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  17.20,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL),
  11,
  2026,
  4,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '42-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  16,
  2026,
  3,
  100.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO DEPOSITO'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL)
    AND concepto_id = 16
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  1,
  2026,
  4,
  75.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  11,
  2026,
  4,
  750.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  16,
  2026,
  4,
  200.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL DEPOSITO'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL)
    AND concepto_id = 16
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  11,
  2026,
  5,
  1000.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL),
  16,
  2026,
  5,
  200.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO DEPOSITO'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '52' AND deleted_at IS NULL)
    AND concepto_id = 16
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  11,
  2025,
  12,
  190.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente DICIEMBRE ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2025
    AND periodo_mes = 12
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  1,
  2026,
  1,
  9.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  2,
  2026,
  1,
  3.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  11,
  2026,
  1,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  6,
  2026,
  1,
  28.30,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO MULTA X CAPACITACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL)
    AND concepto_id = 6
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  1,
  2026,
  2,
  5.30,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente FEBRERO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 2
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  2,
  2026,
  2,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente FEBRERO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 2
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  11,
  2026,
  2,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente FEBRERO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 2
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  1,
  2026,
  3,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  2,
  2026,
  3,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL),
  11,
  2026,
  3,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '58' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  1,
  2026,
  4,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '46' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45-E' AND deleted_at IS NULL),
  11,
  2026,
  4,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '45-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '45-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '45-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-EP' AND deleted_at IS NULL),
  18,
  2026,
  4,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL FUMIGACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '7-EP' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '7-EP' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '7-EP' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL),
  9,
  2026,
  1,
  259.80,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente  AJUSTE SALDO FINAL'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '9-E' AND deleted_at IS NULL)
    AND concepto_id = 9
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  340.40,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '41-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-EP' AND deleted_at IS NULL),
  11,
  2024,
  5,
  10.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '3-EP' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2024
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-EP' AND deleted_at IS NULL),
  11,
  2026,
  5,
  300.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '3-EP' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-D3' AND deleted_at IS NULL),
  18,
  2026,
  5,
  150.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO DEPOSITO N°5 3PISO'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '6-D3' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '6-D3' AND deleted_at IS NULL),
  18,
  2026,
  5,
  150.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO DEPOSITO N°6 3PISO'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '6-D3' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-D2' AND deleted_at IS NULL),
  16,
  2025,
  2,
  150.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente FEBRERO DEPOSITO N° 11'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '11-D2' AND deleted_at IS NULL)
    AND concepto_id = 16
    AND periodo_anio = 2025
    AND periodo_mes = 2
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL),
  16,
  2025,
  10,
  150.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente OCTUBRE DEPOSITO'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL)
    AND concepto_id = 16
    AND periodo_anio = 2025
    AND periodo_mes = 10
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL),
  16,
  2025,
  11,
  150.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente NOVIEMBRE DEPOSITO'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL)
    AND concepto_id = 16
    AND periodo_anio = 2025
    AND periodo_mes = 11
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL),
  16,
  2025,
  12,
  150.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente DICIEMBRE DEPOSITO'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL)
    AND concepto_id = 16
    AND periodo_anio = 2025
    AND periodo_mes = 12
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL),
  16,
  2026,
  1,
  150.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO DEPOSITO'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL)
    AND concepto_id = 16
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL),
  16,
  2026,
  2,
  150.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente FEBRERO DEPOSITO'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL)
    AND concepto_id = 16
    AND periodo_anio = 2026
    AND periodo_mes = 2
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL),
  16,
  2026,
  3,
  150.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO DEPOSITO'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL)
    AND concepto_id = 16
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL),
  16,
  2026,
  4,
  150.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL DEPOSITO'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL)
    AND concepto_id = 16
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL),
  16,
  2026,
  5,
  150.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO DEPOSITO'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-D3' AND deleted_at IS NULL)
    AND concepto_id = 16
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL),
  11,
  2023,
  8,
  10.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente AGOSTO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2023
    AND periodo_mes = 8
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL),
  11,
  2023,
  12,
  50.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente DICIEMBRE ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2023
    AND periodo_mes = 12
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL),
  11,
  2025,
  12,
  40.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente DICIEMBRE ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2025
    AND periodo_mes = 12
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL),
  18,
  2026,
  4,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL FUMIGACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL),
  9,
  2026,
  1,
  10.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente  AJUSTE SALDO FINAL'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '5-EP' AND deleted_at IS NULL)
    AND concepto_id = 9
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-EP' AND deleted_at IS NULL),
  18,
  2026,
  4,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL FUMIGACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-EP' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-EP' AND deleted_at IS NULL),
  11,
  2026,
  5,
  300.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-EP' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);

COMMIT;