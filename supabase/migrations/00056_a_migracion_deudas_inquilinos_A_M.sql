-- Migración 00056_a — Carga de Deudas Pendientes Inquilinos A-M
BEGIN;

INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  15.90,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  11.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  100.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '31-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  18,
  2025,
  10,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente OCTUBRE FUMIGACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2025
    AND periodo_mes = 10
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  6,
  2026,
  1,
  28.30,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO MULTA X CAPACITACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL)
    AND concepto_id = 6
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL),
  18,
  2026,
  4,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL FUMIGACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '1-SP' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  9.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '51-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL),
  6,
  2026,
  1,
  28.30,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO MULTA X CAPACITACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL)
    AND concepto_id = 6
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  17.60,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL),
  18,
  2026,
  4,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL FUMIGACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  700.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '34-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  11,
  2025,
  7,
  300.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente JULIO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2025
    AND periodo_mes = 7
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  1,
  2026,
  2,
  43.60,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente FEBRERO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 2
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  2,
  2026,
  2,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente FEBRERO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 2
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  11,
  2026,
  2,
  600.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente FEBRERO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 2
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  1,
  2026,
  3,
  45.60,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  2,
  2026,
  3,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  11,
  2026,
  3,
  800.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  45.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  11,
  2026,
  4,
  800.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  800.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  11,
  2024,
  5,
  165.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2024
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  11,
  2024,
  5,
  29.90,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER Z. DE CARGA Y DESCARGA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2024
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  6,
  2026,
  1,
  28.30,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO MULTA X CAPACITACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL)
    AND concepto_id = 6
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  10.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '29-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL),
  18,
  2024,
  5,
  10.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO TALONARIO MAMÁ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2024
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  160.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '3-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  1,
  2026,
  3,
  5.60,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  2,
  2026,
  3,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  7.20,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  11,
  2026,
  4,
  200.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '16-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  11,
  2026,
  4,
  50.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '11-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  11,
  2026,
  4,
  50.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '12-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  7.20,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  2,
  2026,
  5,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '8-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  11,
  2025,
  8,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente AGOSTO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2025
    AND periodo_mes = 8
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  6,
  2026,
  1,
  28.30,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO MULTA X CAPACITACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL)
    AND concepto_id = 6
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  9.60,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '52-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  11,
  2026,
  3,
  218.70,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  22.40,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  84.60,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  11,
  2026,
  4,
  350.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  350.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '30-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  28.90,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  11,
  2026,
  4,
  100.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  700.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '54-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  7.20,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '24-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  11,
  2026,
  4,
  160.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  400.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '37-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  1,
  2026,
  3,
  36.70,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  2,
  2026,
  3,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  39.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  700.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '1-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-EP' AND deleted_at IS NULL),
  18,
  2025,
  10,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente OCTUBRE FUMIGACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '1-EP' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2025
    AND periodo_mes = 10
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-EP' AND deleted_at IS NULL),
  11,
  2026,
  5,
  300.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '1-EP' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '1-EP' AND deleted_at IS NULL),
  9,
  2026,
  1,
  10.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente  AJUSTE SALDO FINAL'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '1-EP' AND deleted_at IS NULL)
    AND concepto_id = 9
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  7.20,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '23-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  1,
  2026,
  3,
  5.60,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  2,
  2026,
  3,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  7.20,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  2,
  2026,
  5,
  12.50,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  176.70,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '25-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-SP' AND deleted_at IS NULL),
  11,
  2025,
  8,
  450.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente AGOSTO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-SP' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2025
    AND periodo_mes = 8
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-SP' AND deleted_at IS NULL),
  10,
  2025,
  8,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente AGOSTO TALONARIO SANTA ROSA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-SP' AND deleted_at IS NULL)
    AND concepto_id = 10
    AND periodo_anio = 2025
    AND periodo_mes = 8
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-SP' AND deleted_at IS NULL),
  18,
  2025,
  10,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente OCTUBRE FUMIGACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-SP' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2025
    AND periodo_mes = 10
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-SP' AND deleted_at IS NULL),
  18,
  2026,
  4,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL FUMIGACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-SP' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '2-SP' AND deleted_at IS NULL),
  18,
  2026,
  5,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO TALONARIO DIA DE LA MADRE'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '2-SP' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  7.20,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '14-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  5.60,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '38-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  7.30,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '62-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  1,
  2026,
  4,
  99.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  2,
  2026,
  4,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL),
  11,
  2026,
  5,
  1200.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '32' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  11,
  2026,
  4,
  255.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  18,
  2026,
  4,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL FUMIGACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '43-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  1,
  2026,
  1,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  2,
  2026,
  1,
  3.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  1,
  2026,
  2,
  14.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente FEBRERO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 2
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  2,
  2026,
  2,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente FEBRERO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 2
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  1,
  2026,
  3,
  14.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  2,
  2026,
  3,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MARZO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 3
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  14.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  18,
  2026,
  5,
  10.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO TALONARIO DIA DE LA MADRE'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL),
  11,
  2026,
  6,
  250.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente JUNIO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '49-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 6
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  7.20,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  160.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '22-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL),
  9,
  2026,
  1,
  28.30,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente  AJUSTE SALDO FINAL'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '3-SP' AND deleted_at IS NULL)
    AND concepto_id = 9
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  11,
  2025,
  8,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente AGOSTO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2025
    AND periodo_mes = 8
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '19-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  1,
  2025,
  6,
  44.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente JUNIO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2025
    AND periodo_mes = 6
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  2,
  2025,
  6,
  4.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente JUNIO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2025
    AND periodo_mes = 6
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  1,
  2025,
  7,
  44.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente JULIO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2025
    AND periodo_mes = 7
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  2,
  2025,
  7,
  4.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente JULIO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2025
    AND periodo_mes = 7
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  11,
  2025,
  8,
  350.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente AGOSTO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2025
    AND periodo_mes = 8
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  10,
  2025,
  8,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente AGOSTO TALONARIO SANTA ROSA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL)
    AND concepto_id = 10
    AND periodo_anio = 2025
    AND periodo_mes = 8
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  6,
  2026,
  1,
  28.30,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO MULTA X CAPACITACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL)
    AND concepto_id = 6
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  1,
  2026,
  4,
  44.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  2,
  2026,
  4,
  10.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  18,
  2026,
  4,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL FUMIGACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL),
  9,
  2026,
  1,
  10.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente  AJUSTE SALDO FINAL'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-SP' AND deleted_at IS NULL)
    AND concepto_id = 9
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  10,
  2025,
  8,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente AGOSTO TALONARIO SANTA ROSA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL)
    AND concepto_id = 10
    AND periodo_anio = 2025
    AND periodo_mes = 8
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  2.80,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  11,
  2026,
  4,
  200.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '44-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  450.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '15-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  17.40,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  11,
  2026,
  4,
  110.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  600.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '48-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  1,
  2025,
  7,
  24.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente JULIO LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2025
    AND periodo_mes = 7
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  2,
  2025,
  7,
  4.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente JULIO AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2025
    AND periodo_mes = 7
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  11,
  2025,
  7,
  600.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente JULIO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2025
    AND periodo_mes = 7
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  11,
  2025,
  8,
  600.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente AGOSTO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2025
    AND periodo_mes = 8
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  10,
  2025,
  8,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente AGOSTO TALONARIO SANTA ROSA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL)
    AND concepto_id = 10
    AND periodo_anio = 2025
    AND periodo_mes = 8
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  20.60,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL),
  18,
  2026,
  4,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL FUMIGACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '47-E' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  34.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  11,
  2026,
  4,
  370.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '20-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  38.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  600.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '50-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-EP' AND deleted_at IS NULL),
  18,
  2026,
  4,
  5.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL FUMIGACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-EP' AND deleted_at IS NULL)
    AND concepto_id = 18
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '4-EP' AND deleted_at IS NULL),
  11,
  2026,
  5,
  300.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '4-EP' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  7.20,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '26-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  850.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '33-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  29.50,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '56-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  9.10,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  6.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '55-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  6,
  2026,
  1,
  28.30,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ENERO MULTA X CAPACITACION'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL)
    AND concepto_id = 6
    AND periodo_anio = 2026
    AND periodo_mes = 1
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  1,
  2026,
  4,
  7.20,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL LUZ'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL)
    AND concepto_id = 1
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  2,
  2026,
  4,
  15.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ABRIL AGUA'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL)
    AND concepto_id = 2
    AND periodo_anio = 2026
    AND periodo_mes = 4
    AND deleted_at IS NULL
);
INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL),
  11,
  2026,
  5,
  500.00,
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente MAYO ALQUILER'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '13-E' AND deleted_at IS NULL)
    AND concepto_id = 11
    AND periodo_anio = 2026
    AND periodo_mes = 5
    AND deleted_at IS NULL
);

COMMIT;