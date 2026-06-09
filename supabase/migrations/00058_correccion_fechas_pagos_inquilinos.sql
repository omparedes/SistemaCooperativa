-- Migración 00058 — Corrección de Fechas de Pagos de Inquilinos
-- Propósito: Actualiza la columna fecha_pago con la fecha real del Excel en lugar de now()

BEGIN;

UPDATE public.pagos 
   SET fecha_pago = '2026-01-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'RII 3187'
   AND monto_total = 15.90
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'RII 3187'
   AND monto_total = 12.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6659'
   AND monto_total = 180.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'RII 3261'
   AND monto_total = 17.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'RII 3261'
   AND monto_total = 12.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6757'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'RII 3261'
   AND monto_total = 17.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'RII 3261'
   AND monto_total = 11.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6892'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'RII 3352'
   AND monto_total = 28.30
   AND observacion = 'Migracion 2026: Pago ENERO MULTA X CAPACITACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6930'
   AND monto_total = 570.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7015'
   AND monto_total = 230.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'RII 3352'
   AND monto_total = 16.00
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'RII 3352'
   AND monto_total = 11.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7083'
   AND monto_total = 700.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7197'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'RII 3406'
   AND monto_total = 17.00
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'RII 3406'
   AND monto_total = 11.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7282'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7363'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10019147' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7481'
   AND monto_total = 700.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-16 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL)
   AND comprobante = 'RII 3197'
   AND monto_total = 36.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-16 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL)
   AND comprobante = 'RII 3197'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-16 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6679'
   AND monto_total = 550.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-17 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6874'
   AND monto_total = 550.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-17 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL)
   AND comprobante = 'RII 3257'
   AND monto_total = 36.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-17 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL)
   AND comprobante = 'RII 3257'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-16 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL)
   AND comprobante = 'RII 3304'
   AND monto_total = 36.00
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-16 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL)
   AND comprobante = 'RII 3304'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-16 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7035'
   AND monto_total = 550.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL)
   AND comprobante = 'RII 3348'
   AND monto_total = 36.00
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL)
   AND comprobante = 'RII 3348'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7191'
   AND monto_total = 550.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7393'
   AND monto_total = 550.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL)
   AND comprobante = 'RII 3427'
   AND monto_total = 36.00
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09350799' AND deleted_at IS NULL)
   AND comprobante = 'RII 3427'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ABRIL AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL)
   AND comprobante = 'RII 3198'
   AND monto_total = 9.80
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL)
   AND comprobante = 'RII 3198'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL)
   AND comprobante = 'EB01- 6686'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6915'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6929'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL)
   AND comprobante = 'RII 3292'
   AND monto_total = 9.10
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL)
   AND comprobante = 'RII 3292'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6929'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6993'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL)
   AND comprobante = 'RII 3373'
   AND monto_total = 8.50
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL)
   AND comprobante = 'RII 3373'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7130'
   AND monto_total = 450.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL)
   AND comprobante = 'RII 3373'
   AND monto_total = 8.10
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL)
   AND comprobante = 'RII 3373'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7262'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09706677' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7420'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL)
   AND comprobante = 'RII 3183'
   AND monto_total = 1000.00
   AND observacion = 'Migracion 2026: Pago ENERO GARANTIA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6648'
   AND monto_total = 700.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL)
   AND comprobante = 'RII 3291'
   AND monto_total = 14.30
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL)
   AND comprobante = 'RII 3291'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7000'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7061'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL)
   AND comprobante = 'RII 3374'
   AND monto_total = 20.20
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL)
   AND comprobante = 'RII 3374'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-16 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7211'
   AND monto_total = 700.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL)
   AND comprobante = 'RII 3374'
   AND monto_total = 19.70
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL)
   AND comprobante = 'RII 3374'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08877133' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7390'
   AND monto_total = 700.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6617'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6623'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6637'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6642'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'RII 3250'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE FUMIGACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6646'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6655'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6660'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6669'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-16 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6680'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6693'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6700'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-26 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6728'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6786'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6800'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6801'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6846'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'RII 3396'
   AND monto_total = 39.40
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'RII 3396'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6749'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6846'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6880'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6965'
   AND monto_total = 400.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'RII 3396'
   AND monto_total = 5.60
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'RII 3408'
   AND monto_total = 40.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'RII 3408'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6965'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7004'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7194'
   AND monto_total = 400.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7235'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'RII 3418'
   AND monto_total = 44.30
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'RII3418'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'RII 3418'
   AND monto_total = 28.30
   AND observacion = 'Migracion 2026: Pago ENERO MULTA X CAPACITACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7235'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7272'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44071731' AND deleted_at IS NULL)
   AND comprobante = 'RII 3408'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago ABRIL FUMIGACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL)
   AND comprobante = 'RII 3368'
   AND monto_total = 10.60
   AND observacion = 'Migracion 2026: Pago OCTUBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL)
   AND comprobante = 'RII 3368'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL)
   AND comprobante = 'RII 3368'
   AND monto_total = 8.50
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL)
   AND comprobante = 'RII 3368'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL)
   AND comprobante = 'RII 3368'
   AND monto_total = 9.40
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL)
   AND comprobante = 'RII 3368'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6769'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL)
   AND comprobante = 'RII 3368'
   AND monto_total = 11.60
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL)
   AND comprobante = 'RII 3368'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6939'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL)
   AND comprobante = 'RII 3368'
   AND monto_total = 11.60
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL)
   AND comprobante = 'RII 3368'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7098'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL)
   AND comprobante = 'RII 3369'
   AND monto_total = 9.60
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL)
   AND comprobante = 'RII 3369'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7298'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '00254279' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7496'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-24 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL)
   AND comprobante = 'RII 3213'
   AND monto_total = 120.60
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-24 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL)
   AND comprobante = 'RII 3213'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6759'
   AND monto_total = 800.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL)
   AND comprobante = 'RII 3263'
   AND monto_total = 117.20
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL)
   AND comprobante = 'RII 3263'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6932'
   AND monto_total = 1000.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL)
   AND comprobante = 'RII 3312'
   AND monto_total = 115.50
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL)
   AND comprobante = 'RII 3312'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7058'
   AND monto_total = 1000.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL)
   AND comprobante = 'RII 3407'
   AND monto_total = 119.60
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL)
   AND comprobante = 'RII 3407'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7284'
   AND monto_total = 1000.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '43650510' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7483'
   AND monto_total = 1000.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'RII 3175'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago AGOSTO TALONARIO SANTA ROSA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'RII 3254'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago SETIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'RII 3254'
   AND monto_total = 4.00
   AND observacion = 'Migracion 2026: Pago SETIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'RII 3254'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'RII 3254'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6632'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'RII 3254'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'RII 3254'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6632'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6703'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6740'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'RII 3254'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'RII 3254'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6887'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6850'
   AND monto_total = 90.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6898'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'RII 3271'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'RII 3271'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6917'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6999'
   AND monto_total = 210.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7102'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'RII 3335'
   AND monto_total = 14.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'RII 3335'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7243'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7368'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-26 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7445'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-26 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7445'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '31428533' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7461'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'RII 3224'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago AGOSTO TALONARIO SANTA ROSA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'RII 3224'
   AND monto_total = 3.40
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'RII 3224'
   AND monto_total = 23.60
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'RII 3224'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6758'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6758'
   AND monto_total = 700.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'RII 3224'
   AND monto_total = 21.60
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'RII 3224'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6931'
   AND monto_total = 700.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'RII 3224'
   AND monto_total = 21.70
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'RII 3224'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7084'
   AND monto_total = 700.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'RII 3224'
   AND monto_total = 15.70
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'RII 3317'
   AND monto_total = 3.80
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'RII 3317'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7283'
   AND monto_total = 700.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'RII 3317'
   AND monto_total = 10.20
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'RII 3383'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'RII 3442'
   AND monto_total = 0.80
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'RII 3442'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago ABRIL AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'RII 3442'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago ABRIL FUMIGACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'RII 3442'
   AND monto_total = 38.20
   AND observacion = 'Migracion 2026: Pago MAYO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44982231' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7482'
   AND monto_total = 700.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6630'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6701'
   AND monto_total = 135.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'RII 3202'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'RII 3202'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6737'
   AND monto_total = 115.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6803'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6884'
   AND monto_total = 160.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6885'
   AND monto_total = 40.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'RII 3280'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'RII 3280'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'RII 3280'
   AND monto_total = 28.30
   AND observacion = 'Migracion 2026: Pago ENERO MULTA X CAPACITACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6967'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7047'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'RII 3326'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'RII 3327'
   AND monto_total = 4.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'RII 3327'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7153'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7154'
   AND monto_total = 129.60
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7239'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'RII 3376'
   AND monto_total = 5.60
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'RII 3376'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7269'
   AND monto_total = 220.40
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7375'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7416'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'RII 3431'
   AND monto_total = 7.20
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'RII 3431'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago ABRIL AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47384400' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7453'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6631'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6702'
   AND monto_total = 135.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'RII 3203'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'RII 3203'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6738'
   AND monto_total = 115.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6804'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6805'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6886'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'RII 3281'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'RII 3281'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'RII 3281'
   AND monto_total = 28.30
   AND observacion = 'Migracion 2026: Pago ENERO MULTA X CAPACITACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6968'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7048'
   AND monto_total = 180.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7049'
   AND monto_total = 20.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'RII 3328'
   AND monto_total = 14.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'RII 3328'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7155'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7155'
   AND monto_total = 129.60
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7240'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'RII 3377'
   AND monto_total = 5.60
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'RII 3377'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7268'
   AND monto_total = 220.40
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7376'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7417'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'RII 3432'
   AND monto_total = 7.20
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'RII 3432'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago ABRIL AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '40466902' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7454'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL)
   AND comprobante = 'RII 3289'
   AND monto_total = 24.80
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL)
   AND comprobante = 'RII 3289'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL)
   AND comprobante = 'RII 3289'
   AND monto_total = 15.50
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL)
   AND comprobante = 'RII 3289'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6760'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL)
   AND comprobante = 'RII 3289'
   AND monto_total = 16.10
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL)
   AND comprobante = 'RII 3289'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6933'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL)
   AND comprobante = 'RII 3428'
   AND monto_total = 14.50
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL)
   AND comprobante = 'RII 3428'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7086'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL)
   AND comprobante = 'RII 3428'
   AND monto_total = 12.90
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL)
   AND comprobante = 'RII 3428'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7285'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL)
   AND comprobante = 'RII 3428'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL)
   AND comprobante = 'RII 3428'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago ABRIL AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08386063' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7484'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6629'
   AND monto_total = 400.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6697'
   AND monto_total = 180.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'RII  3201'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'RII 3201'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6761'
   AND monto_total = 40.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6836'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7008'
   AND monto_total = 60.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'RII 3298'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'RII 3298'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7008'
   AND monto_total = 542.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7165'
   AND monto_total = 58.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'RII 3412'
   AND monto_total = 14.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'RII 3412'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7165'
   AND monto_total = 242.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7245'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7331'
   AND monto_total = 58.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'RII 3412'
   AND monto_total = 5.60
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'RII 3412'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7286'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7331'
   AND monto_total = 242.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7384'
   AND monto_total = 280.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45136700' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7385'
   AND monto_total = 28.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL)
   AND comprobante = 'RII 3186'
   AND monto_total = 7.90
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL)
   AND comprobante = 'RII 3186'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6654'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL)
   AND comprobante = 'RII 3249'
   AND monto_total = 6.50
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL)
   AND comprobante = 'RII 3249'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6839'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL)
   AND comprobante = 'RII 3303'
   AND monto_total = 8.10
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL)
   AND comprobante = 'RII 3303'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7024'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL)
   AND comprobante = 'RII 3321'
   AND monto_total = 6.60
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL)
   AND comprobante = 'RII 3321'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7143'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL)
   AND comprobante = 'RII 3402'
   AND monto_total = 9.30
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL)
   AND comprobante = 'RII 3402'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42082589' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7342'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6665'
   AND monto_total = 57.20
   AND observacion = 'Migracion 2026: Pago JUNIO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3189'
   AND monto_total = 14.60
   AND observacion = 'Migracion 2026: Pago JULIO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3189'
   AND monto_total = 10.80
   AND observacion = 'Migracion 2026: Pago JULIO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3189'
   AND monto_total = 4.50
   AND observacion = 'Migracion 2026: Pago AGOSTO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3189'
   AND monto_total = 18.80
   AND observacion = 'Migracion 2026: Pago AGOSTO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3189'
   AND monto_total = 8.50
   AND observacion = 'Migracion 2026: Pago SETIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3189'
   AND monto_total = 13.00
   AND observacion = 'Migracion 2026: Pago SETIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3189'
   AND monto_total = 12.70
   AND observacion = 'Migracion 2026: Pago OCTUBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3189'
   AND monto_total = 31.90
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6665'
   AND monto_total = 228.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6666'
   AND monto_total = 82.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3190'
   AND monto_total = 16.90
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3190'
   AND monto_total = 46.80
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6666'
   AND monto_total = 54.30
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6975'
   AND monto_total = 295.70
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3284'
   AND monto_total = 17.90
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3284'
   AND monto_total = 45.40
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6975'
   AND monto_total = 241.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7202'
   AND monto_total = 109.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3355'
   AND monto_total = 20.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3355'
   AND monto_total = 59.40
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7202'
   AND monto_total = 311.60
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7326'
   AND monto_total = 38.40
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7326'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3419'
   AND monto_total = 15.80
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3419'
   AND monto_total = 63.40
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7326'
   AND monto_total = 11.60
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3419'
   AND monto_total = 16.50
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'RII 3419'
   AND monto_total = 84.60
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '60812334' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7421'
   AND monto_total = 119.70
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-292'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-297'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-305'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-307'
   AND monto_total = 120.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'RII 3221'
   AND monto_total = 26.50
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'RII 3221'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-308'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-313'
   AND monto_total = 80.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-314'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-317'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-318'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-319'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'RII 3269'
   AND monto_total = 21.10
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'RII 3269'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-323'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-330'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-331'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-336'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-346'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-353'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-358'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-365'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'RII 3345'
   AND monto_total = 0.10
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'RII 3345'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'RII 3346'
   AND monto_total = 20.00
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-365'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-370'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'RII 3379'
   AND monto_total = 20.10
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'RII 3379'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-376'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-380'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-383'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-383'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-386'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10104498146' AND deleted_at IS NULL)
   AND comprobante = 'E001-389'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'RII 3193'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'RII 3193'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6674'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6739'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'RII 3219'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'RII 3219'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6840'
   AND monto_total = 220.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6841'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7006'
   AND monto_total = 180.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'RII 3331'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'RII 3331'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7006'
   AND monto_total = 120.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7007'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'RII 3331'
   AND monto_total = 14.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'RII 3331'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7160'
   AND monto_total = 80.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7160'
   AND monto_total = 112.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7198'
   AND monto_total = 188.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7249'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'RII 3370'
   AND monto_total = 5.60
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'RII 3370'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7332'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7332'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44168936' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7413'
   AND monto_total = 400.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6634'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6708'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'RII 3205'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'RII 3205'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6743'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6916'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'RII 3270'
   AND monto_total = 9.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'RII 3270'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6916'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6977'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7011'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7114'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'RII 3338'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'RII 3338'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7167'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7200'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7238'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7271'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7087'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7271'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7297'
   AND monto_total = 70.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'RII 3399'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'RII 3399'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7335'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7336'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7378'
   AND monto_total = 80.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'RII 3400'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago ABRIL FUMIGACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7425'
   AND monto_total = 140.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7458'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46405540' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7485'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL)
   AND comprobante = 'RII 3192'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago AGOSTO TALONARIO SANTA ROSA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL)
   AND comprobante = 'RII 3192'
   AND monto_total = 30.50
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL)
   AND comprobante = 'RII 3192'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6673'
   AND monto_total = 650.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL)
   AND comprobante = 'RII 3258'
   AND monto_total = 26.60
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL)
   AND comprobante = 'RII 3258'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6879'
   AND monto_total = 700.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL)
   AND comprobante = 'RII 3323'
   AND monto_total = 35.50
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL)
   AND comprobante = 'RII 3323'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL)
   AND comprobante = 'RII 3323'
   AND monto_total = 35.00
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL)
   AND comprobante = 'RII 3323'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7149'
   AND monto_total = 700.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7241'
   AND monto_total = 400.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7242'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48773769' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7372'
   AND monto_total = 700.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08914131' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6645'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08914131' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6853'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08914131' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7020'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-17 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08914131' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7216'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08914131' AND deleted_at IS NULL)
   AND comprobante = 'RII 3426'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago ABRIL FUMIGACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08914131' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7435'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08914131' AND deleted_at IS NULL)
   AND comprobante = 'RII 3426'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago MAYO TALONARIO DIA DE LA MADRE'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL)
   AND comprobante = 'RII 3179'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL)
   AND comprobante = 'RII 3179'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6640'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL)
   AND comprobante = 'RII 3237'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL)
   AND comprobante = 'RII 3237'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6807'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL)
   AND comprobante = 'RII 3301'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL)
   AND comprobante = 'RII 3301'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL)
   AND comprobante = 'RII 3332'
   AND monto_total = 28.30
   AND observacion = 'Migracion 2026: Pago ENERO MULTA X CAPACITACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7023'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL)
   AND comprobante = 'RII 3332'
   AND monto_total = 14.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL)
   AND comprobante = 'RII 3332'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7161'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL)
   AND comprobante = 'RII 3397'
   AND monto_total = 5.60
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL)
   AND comprobante = 'RII 3397'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44002664' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7333'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL)
   AND comprobante = 'RII 3278'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL)
   AND comprobante = 'RII 3278'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6762'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL)
   AND comprobante = 'RII 3278'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL)
   AND comprobante = 'RII 3278'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6946'
   AND monto_total = 360.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6961'
   AND monto_total = 140.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL)
   AND comprobante = 'RII 3337'
   AND monto_total = 14.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL)
   AND comprobante = 'RII 3337'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7088'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7288'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46542458' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7486'
   AND monto_total = 240.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20097655' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6619'
   AND monto_total = 450.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20097655' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6819'
   AND monto_total = 450.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20097655' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7019'
   AND monto_total = 450.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20097655' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7131'
   AND monto_total = 450.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20097655' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7367'
   AND monto_total = 450.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20097655' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7476'
   AND monto_total = 450.00
   AND observacion = 'Migracion 2026: Pago JULIO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL)
   AND comprobante = 'RII 3173'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL)
   AND comprobante = 'RII 3173'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6625'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL)
   AND comprobante = 'RII 3232'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL)
   AND comprobante = 'RII 3232'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6798'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL)
   AND comprobante = 'RII 3294'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL)
   AND comprobante = 'RII 3294'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL)
   AND comprobante = 'RII 3339'
   AND monto_total = 28.30
   AND observacion = 'Migracion 2026: Pago ENERO MULTA X CAPACITACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6997'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL)
   AND comprobante = 'RII 3339'
   AND monto_total = 14.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL)
   AND comprobante = 'RII 3339'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7171'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL)
   AND comprobante = 'RII 3393'
   AND monto_total = 5.60
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL)
   AND comprobante = 'RII 3393'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41762238' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7328'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'RII 3188'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago AGOSTO TALONARIO SANTA ROSA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'RII 3188'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'RII 3188'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6664'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'RII 23247'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'RII 3247'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6835'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'RII 3351'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'RII 3351'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'RII 3351'
   AND monto_total = 28.30
   AND observacion = 'Migracion 2026: Pago ENERO MULTA X CAPACITACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'RII 3351'
   AND monto_total = 14.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'RII 3351'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7095'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7270'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'RII 3378'
   AND monto_total = 5.60
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'RII 3378'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7270'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7373'
   AND monto_total = 170.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7374'
   AND monto_total = 30.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7414'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10474827' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7415'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL)
   AND comprobante = 'RII 3168'
   AND monto_total = 9.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL)
   AND comprobante = 'RII 3168'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6614'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL)
   AND comprobante = 'RII 3227'
   AND monto_total = 7.70
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL)
   AND comprobante = 'RII 3227'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6784'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL)
   AND comprobante = 'RII 3286'
   AND monto_total = 8.30
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL)
   AND comprobante = 'RII 3286'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6982'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL)
   AND comprobante = 'RII 3314'
   AND monto_total = 7.70
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL)
   AND comprobante = 'RII 3314'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7104'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL)
   AND comprobante = 'RII 3363'
   AND monto_total = 6.30
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL)
   AND comprobante = 'RII 3363'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7322'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '47205649' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7508'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL)
   AND comprobante = 'RII 3191'
   AND monto_total = 91.20
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL)
   AND comprobante = 'RII 3191'
   AND monto_total = 8.50
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6671'
   AND monto_total = 1000.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6672'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL)
   AND comprobante = 'RII 3220'
   AND monto_total = 92.50
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL)
   AND comprobante = 'RII 3220'
   AND monto_total = 8.50
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6857'
   AND monto_total = 1200.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL)
   AND comprobante = 'RII 3341'
   AND monto_total = 89.90
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL)
   AND comprobante = 'RII 3341'
   AND monto_total = 6.40
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7068'
   AND monto_total = 1200.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL)
   AND comprobante = 'RII 3341'
   AND monto_total = 88.60
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL)
   AND comprobante = 'RII 3341'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-16 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7209'
   AND monto_total = 1200.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL)
   AND comprobante = 'RI 3416'
   AND monto_total = 91.80
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL)
   AND comprobante = 'RII 3416'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL)
   AND comprobante = 'RII 3416'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago ABRIL FUMIGACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '03901433' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7408'
   AND monto_total = 1200.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'RII 3364'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago AGOSTO TALONARIO SANTA ROSA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'RII 3239'
   AND monto_total = 8.60
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'RII 3239'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6744'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6808'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'RII 3239'
   AND monto_total = 8.20
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'RII 3239'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6889'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'RII 3260'
   AND monto_total = 7.60
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'RII 3260'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6976'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7014'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7069'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7168'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7168'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7246'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'RII 3364'
   AND monto_total = 8.90
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'RII 3364'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7276'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7344'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'RII 3364'
   AND monto_total = 6.50
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'RII 3364'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7344'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7352'
   AND monto_total = 45.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7383'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7462'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'RII 3436'
   AND monto_total = 7.40
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'RII 3436'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago ABRIL AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08995920' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7462'
   AND monto_total = 245.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'RII 3262'
   AND monto_total = 8.00
   AND observacion = 'Migracion 2026: Pago SETIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'RII 3262'
   AND monto_total = 4.00
   AND observacion = 'Migracion 2026: Pago SETIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'RII 3262'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'RII 3262'
   AND monto_total = 2.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'RII 3404'
   AND monto_total = 4.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'RII 3404'
   AND monto_total = 9.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'RII 3404'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'RII 3404'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'RII 3404'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6713'
   AND monto_total = 230.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6714'
   AND monto_total = 20.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'RII 3404'
   AND monto_total = 7.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6714'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6893'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6894'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6894'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7044'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7044'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7224'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7224'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-06-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7505'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-06-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71577898' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7505'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago JUNIO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL)
   AND comprobante = 'RII 3180'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL)
   AND comprobante = 'RII3180'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6641'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL)
   AND comprobante = 'RII 3238'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL)
   AND comprobante = 'RII 3238'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6806'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL)
   AND comprobante = 'RII 3302'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL)
   AND comprobante = 'RII 3302'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL)
   AND comprobante = 'RII 3333'
   AND monto_total = 28.30
   AND observacion = 'Migracion 2026: Pago ENERO MULTA X CAPACITACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7022'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL)
   AND comprobante = 'RII 3333'
   AND monto_total = 14.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL)
   AND comprobante = 'RII 3333'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7162'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL)
   AND comprobante = 'RII 3398'
   AND monto_total = 5.60
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL)
   AND comprobante = 'RII 3398'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7334'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10233461' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7501'
   AND monto_total = 340.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL)
   AND comprobante = '3222'
   AND monto_total = 36.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL)
   AND comprobante = '3222'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL)
   AND comprobante = '3222'
   AND monto_total = 36.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL)
   AND comprobante = '3222'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6754'
   AND monto_total = 550.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL)
   AND comprobante = 'RII 3381'
   AND monto_total = 36.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL)
   AND comprobante = 'RII 3381'
   AND monto_total = 8.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6926'
   AND monto_total = 550.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL)
   AND comprobante = 'RII 3307'
   AND monto_total = 36.00
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL)
   AND comprobante = 'RII 3307'
   AND monto_total = 8.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7060'
   AND monto_total = 550.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL)
   AND comprobante = 'RII 3381'
   AND monto_total = 36.00
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL)
   AND comprobante = 'RII 3381'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7274'
   AND monto_total = 550.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08030473' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7477'
   AND monto_total = 550.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'RII 3174'
   AND monto_total = 25.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'RII 3174'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6628'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'RII 3242'
   AND monto_total = 25.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'RII 3242'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6812'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'RII 3309'
   AND monto_total = 30.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'RII 3309'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'RII 3309'
   AND monto_total = 17.00
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'RII 3310'
   AND monto_total = 12.00
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'RII 3310'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7062'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'RII 3372'
   AND monto_total = 29.00
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'RII 3372'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7253'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-26 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7446'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-26 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'RII 3429'
   AND monto_total = 30.00
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-26 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'RII 3429'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago ABRIL AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-26 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09369721' AND deleted_at IS NULL)
   AND comprobante = 'RII 3429'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago ABRIL FUMIGACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL)
   AND comprobante = 'RII 3164'
   AND monto_total = 44.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL)
   AND comprobante = 'RII 3164'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6602'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL)
   AND comprobante = 'RII 3230'
   AND monto_total = 44.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL)
   AND comprobante = 'RII 3230'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6792'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL)
   AND comprobante = 'RII 3275'
   AND monto_total = 44.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL)
   AND comprobante = 'RII 3275'
   AND monto_total = 8.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6951'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL)
   AND comprobante = 'RII 3313'
   AND monto_total = 44.00
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL)
   AND comprobante = 'RII 3313'
   AND monto_total = 8.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7103'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL)
   AND comprobante = 'RII 3385'
   AND monto_total = 44.00
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL)
   AND comprobante = 'RII 3385'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7303'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-06-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08899417' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7509'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10106511476' AND deleted_at IS NULL)
   AND comprobante = 'E001-298'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10106511476' AND deleted_at IS NULL)
   AND comprobante = 'E001.315'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10106511476' AND deleted_at IS NULL)
   AND comprobante = 'E001-345'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10106511476' AND deleted_at IS NULL)
   AND comprobante = 'E001-371'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10106511476' AND deleted_at IS NULL)
   AND comprobante = 'RII 3437'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago ABRIL FUMIGACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10106511476' AND deleted_at IS NULL)
   AND comprobante = 'E001-390'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3170'
   AND monto_total = 8.90
   AND observacion = 'Migracion 2026: Pago OCTUBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3173'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3170'
   AND monto_total = 11.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3170'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6620'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6706'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6811'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3240'
   AND monto_total = 8.60
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3240'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6888'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3282'
   AND monto_total = 9.60
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3282'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6969'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7115'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7115'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7166'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7201'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7244'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3410'
   AND monto_total = 9.00
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3410'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7379'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7422'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3434'
   AND monto_total = 8.50
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3434'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3410'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago ABRIL FUMIGACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3434'
   AND monto_total = 5.50
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09407642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7457'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'RII 3225'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago AGOSTO TALONARIO SANTA ROSA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'RII 3225'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'RII 3225'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'RII 3225'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'RII 3225'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'EBO1-6626'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6763'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'RII 3324'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'RII 3324'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6763'
   AND monto_total = 180.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6947'
   AND monto_total = 320.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'RII 3324'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'RII 3324'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7089'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'RII 3324'
   AND monto_total = 14.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'RII 3324'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7150'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7289'
   AND monto_total = 190.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'RII 3394'
   AND monto_total = 5.60
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'RII 3394'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7329'
   AND monto_total = 60.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'RII 3394'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago ABRIL FUMIGACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-26 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7447'
   AND monto_total = 400.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-26 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'RII 3430'
   AND monto_total = 7.20
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-26 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'RII 3430'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago ABRIL AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7487'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08905454' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7487'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'RII 3214'
   AND monto_total = 26.80
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'RII 3214'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6732'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'RII 3272'
   AND monto_total = 38.20
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'RII 3272'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6924'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6925'
   AND monto_total = 400.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'RII 3315'
   AND monto_total = 32.70
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'RII 3315'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7107'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'RII 3386'
   AND monto_total = 28.30
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'RII 3386'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7304'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'RII 3421'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago ABRIL FUMIGACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7424'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'RII 3440'
   AND monto_total = 30.00
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'RII 3440'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago ABRIL AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41844307' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7471'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'RII 3244'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago AGOSTO TALONARIO SANTA ROSA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'RII 3241'
   AND monto_total = 7.20
   AND observacion = 'Migracion 2026: Pago OCTUBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'RII 3241'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6675'
   AND monto_total = 290.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6676'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6752'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'RII 3241'
   AND monto_total = 7.30
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'RII 3241'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6753'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'RII 3241'
   AND monto_total = 7.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'RII 3241'
   AND monto_total = 3.50
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'RII 3244'
   AND monto_total = 21.10
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 6815'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'RII 3422'
   AND monto_total = 8.20
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'RII 3422'
   AND monto_total = 25.80
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7025'
   AND monto_total = 550.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7173'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'RII 3422'
   AND monto_total = 7.80
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'RII 3422'
   AND monto_total = 25.20
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7173'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-16 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7210'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7277'
   AND monto_total = 40.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7278'
   AND monto_total = 60.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7323'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7343'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'RII 3422'
   AND monto_total = 5.60
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'RII 3422'
   AND monto_total = 17.40
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7386'
   AND monto_total = 400.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'RII 3423'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago ABRIL FUMIGACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10347772' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7463'
   AND monto_total = 90.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'RII3178'
   AND monto_total = 29.90
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'RII 3178'
   AND monto_total = 7.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6638'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'RII 3229'
   AND monto_total = 31.40
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'RII 3229'
   AND monto_total = 5.30
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6791'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'RII 3295'
   AND monto_total = 30.20
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'RII 3295'
   AND monto_total = 5.80
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'RII 3296'
   AND monto_total = 0.60
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6998'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'RII 3229'
   AND monto_total = 1.30
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'RII 3296'
   AND monto_total = 0.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'RII 3322'
   AND monto_total = 30.00
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'RII 3322'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7144'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'RII 3389'
   AND monto_total = 22.50
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'RII 3389'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7315'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-06-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7510'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-06-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71009767' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7511'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6802'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'RII 3233'
   AND monto_total = 30.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'RII 3233'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6966'
   AND monto_total = 170.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'RII 3279'
   AND monto_total = 35.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'RII 3279'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'RII 3279'
   AND monto_total = 28.30
   AND observacion = 'Migracion 2026: Pago ENERO MULTA X CAPACITACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6966'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7163'
   AND monto_total = 400.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'RII 3334'
   AND monto_total = 34.00
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'RII 3334'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7163'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7090'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7250'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'RII 3371'
   AND monto_total = 34.00
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'RII 3371'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7290'
   AND monto_total = 30.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7340'
   AND monto_total = 120.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7340'
   AND monto_total = 80.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '04352513' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7488'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3184'
   AND monto_total = 23.20
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3184'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6651'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3234'
   AND monto_total = 21.90
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3234'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6877'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3300'
   AND monto_total = 26.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3300'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7018'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3343'
   AND monto_total = 30.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3343'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7177'
   AND monto_total = 400.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7178'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3415'
   AND monto_total = 30.40
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3415'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41365838' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7406'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46101817' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6687'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46101817' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6955'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46101817' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6955'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46101817' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7223'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46101817' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7396'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = 'RII 3165'
   AND monto_total = 89.90
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = 'RII 3165'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6604'
   AND monto_total = 550.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = '3226'
   AND monto_total = 87.60
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = '3226'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6780'
   AND monto_total = 800.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = 'RII 3285'
   AND monto_total = 77.30
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = 'RII 3285'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6979'
   AND monto_total = 800.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = 'RII 3316'
   AND monto_total = 78.50
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = 'RII 3316'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7108'
   AND monto_total = 800.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = 'RII 3388'
   AND monto_total = 68.50
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = 'RII 3388'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7311'
   AND monto_total = 800.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = 'RII 3441'
   AND monto_total = 86.70
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = 'RII 3441'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago ABRIL AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '46950481' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7472'
   AND monto_total = 800.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL)
   AND comprobante = 'RII 3268'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL)
   AND comprobante = 'RII 3268'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL)
   AND comprobante = 'RII 3268'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL)
   AND comprobante = 'RII 3268'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6764'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL)
   AND comprobante = 'RII 3268'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL)
   AND comprobante = 'RII 3268'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6934'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-24 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL)
   AND comprobante = 'RII 3311'
   AND monto_total = 14.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-24 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL)
   AND comprobante = 'RII 3311'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7091'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL)
   AND comprobante = 'RII 3417'
   AND monto_total = 5.60
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL)
   AND comprobante = 'RII 3417'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7291'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07279524' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7489'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'RII 3200'
   AND monto_total = 13.90
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'RII 3200'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6690'
   AND monto_total = 750.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6908'
   AND monto_total = 850.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'RII 3267'
   AND monto_total = 13.30
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'RII 3267'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'RII 3347'
   AND monto_total = 28.30
   AND observacion = 'Migracion 2026: Pago ENERO MULTA X CAPACITACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7010'
   AND monto_total = 850.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'RII 3347'
   AND monto_total = 16.10
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'RII 3347'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7190'
   AND monto_total = 850.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'RII 3357'
   AND monto_total = 18.20
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'RII 3357'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'RII 3357'
   AND monto_total = 15.40
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'RII 3420'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago ABRIL FUMIGACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7423'
   AND monto_total = 850.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'RII 3435'
   AND monto_total = 0.30
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73348594' AND deleted_at IS NULL)
   AND comprobante = 'RII 3435'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago ABRIL AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL)
   AND comprobante = 'RII 3367'
   AND monto_total = 37.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL)
   AND comprobante = 'RII 3367'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL)
   AND comprobante = 'RII 3367'
   AND monto_total = 35.50
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL)
   AND comprobante = 'RII 3367'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6765'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL)
   AND comprobante = 'RII 3367'
   AND monto_total = 30.80
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL)
   AND comprobante = 'RII 3367'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6935'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL)
   AND comprobante = 'RII 3367'
   AND monto_total = 31.60
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL)
   AND comprobante = 'RII 3367'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7092'
   AND monto_total = 360.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7138'
   AND monto_total = 140.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL)
   AND comprobante = 'RII 3367'
   AND monto_total = 27.40
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL)
   AND comprobante = 'RII 3367'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7292'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10026348' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7490'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3365'
   AND monto_total = 9.20
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3365'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3365'
   AND monto_total = 8.90
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3365'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6767'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3365'
   AND monto_total = 7.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3365'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6937'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3365'
   AND monto_total = 9.00
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3365'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7093'
   AND monto_total = 360.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7137'
   AND monto_total = 140.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3366'
   AND monto_total = 7.00
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL)
   AND comprobante = 'RII 3366'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7294'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09575838' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7491'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL)
   AND comprobante = 'rRII 3171'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL)
   AND comprobante = 'RII 3171'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6621'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL)
   AND comprobante = 'RII 3246'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL)
   AND comprobante = 'RII 3246'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6822'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL)
   AND comprobante = 'RII 3293'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL)
   AND comprobante = 'RII 3293'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6994'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL)
   AND comprobante = 'RII 3319'
   AND monto_total = 14.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL)
   AND comprobante = 'RII 3319'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7142'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL)
   AND comprobante = 'RII 3401'
   AND monto_total = 5.60
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL)
   AND comprobante = 'RII 3401'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '07266341' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7341'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'RII 3266'
   AND monto_total = 8.20
   AND observacion = 'Migracion 2026: Pago JULIO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'RII 3266'
   AND monto_total = 4.00
   AND observacion = 'Migracion 2026: Pago JULIO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'RII 3266'
   AND monto_total = 20.40
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'RII 3266'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'RII 3266'
   AND monto_total = 26.60
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'RII 3266'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6776'
   AND monto_total = 320.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6906'
   AND monto_total = 180.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'RII 3266'
   AND monto_total = 29.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'RII 3266'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6940'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'RII 3403'
   AND monto_total = 22.80
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'RII 3403'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7101'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'RII 3403'
   AND monto_total = 28.10
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'RII 3403'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7302'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48822765' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7500'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EII 3206'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago AGOSTO TALONARIO SANTA ROSA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EII 3206'
   AND monto_total = 52.60
   AND observacion = 'Migracion 2026: Pago SETIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EII 3206'
   AND monto_total = 4.00
   AND observacion = 'Migracion 2026: Pago SETIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EII 3206'
   AND monto_total = 43.70
   AND observacion = 'Migracion 2026: Pago OCTUBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EII 3206'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6667'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'RII 3206'
   AND monto_total = 28.70
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'RII 3251'
   AND monto_total = 18.40
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'RII 3251'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6847'
   AND monto_total = 19.30
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6809'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'RII 3251'
   AND monto_total = 46.10
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'RII 3251'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6847'
   AND monto_total = 56.20
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6882'
   AND monto_total = 143.80
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6882'
   AND monto_total = 6.20
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6971'
   AND monto_total = 160.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7012'
   AND monto_total = 170.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7156'
   AND monto_total = 163.80
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'RII 3354'
   AND monto_total = 36.20
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'RII 3354'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'RII 3354'
   AND monto_total = 28.30
   AND observacion = 'Migracion 2026: Pago ENERO MULTA X CAPACITACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7156'
   AND monto_total = 136.20
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'RII 3354'
   AND monto_total = 34.90
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'RII 3354'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7199'
   AND monto_total = 191.60
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7248'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7305'
   AND monto_total = 72.20
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7305'
   AND monto_total = 44.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'RII 3387'
   AND monto_total = 37.80
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'RII 3387'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7337'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7338'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7381'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7418'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7418'
   AND monto_total = 144.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72446110' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7459'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'RII 3212'
   AND monto_total = 8.90
   AND observacion = 'Migracion 2026: Pago OCTUBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'RII 3212'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'RII 3212'
   AND monto_total = 8.10
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'RII 3212'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'RII 3212'
   AND monto_total = 8.60
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'RII 3212'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6771'
   AND monto_total = 270.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6783'
   AND monto_total = 80.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'RII 3340'
   AND monto_total = 9.90
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'RII 3340'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6941'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'RII 3340'
   AND monto_total = 9.00
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'RII 3340'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7095'
   AND monto_total = 120.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7172'
   AND monto_total = 230.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7295'
   AND monto_total = 210.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7394'
   AND monto_total = 140.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10481732' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7493'
   AND monto_total = 110.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL)
   AND comprobante = 'RII 3384'
   AND monto_total = 2.30
   AND observacion = 'Migracion 2026: Pago AGOSTO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL)
   AND comprobante = 'RII 3384'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago AGOSTO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL)
   AND comprobante = 'RII 3384'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago SETIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL)
   AND comprobante = 'RII 3384'
   AND monto_total = 4.00
   AND observacion = 'Migracion 2026: Pago SETIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL)
   AND comprobante = 'RII 3384'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL)
   AND comprobante = 'RII 3384'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL)
   AND comprobante = 'RII 3384'
   AND monto_total = 1.70
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL)
   AND comprobante = 'RII 3443'
   AND monto_total = 8.30
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL)
   AND comprobante = 'RII 3443'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL)
   AND comprobante = 'RII 3443'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL)
   AND comprobante = 'RII 3443'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6772'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL)
   AND comprobante = 'RII 3443'
   AND monto_total = 11.70
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6942'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7096'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7296'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '06651184' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7494'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'RII 3207'
   AND monto_total = 40.80
   AND observacion = 'Migracion 2026: Pago SETIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'RII 3207'
   AND monto_total = 4.00
   AND observacion = 'Migracion 2026: Pago SETIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'RII 3207'
   AND monto_total = 34.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'RII 3207'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6741'
   AND monto_total = 62.40
   AND observacion = 'Migracion 2026: Pago OCTUBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6668'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'RII 3207'
   AND monto_total = 37.50
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'RII 3207'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6741'
   AND monto_total = 30.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'RII 3207'
   AND monto_total = 22.70
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6741'
   AND monto_total = 7.60
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6742'
   AND monto_total = 70.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6773'
   AND monto_total = 90.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6810'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6848'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'RII 3259'
   AND monto_total = 11.60
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'RII 3259'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6883'
   AND monto_total = 32.40
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6883'
   AND monto_total = 101.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6972'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6973'
   AND monto_total = 60.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7013'
   AND monto_total = 170.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'RII 3329'
   AND monto_total = 21.10
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'RII 3329'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'RII 3329'
   AND monto_total = 28.30
   AND observacion = 'Migracion 2026: Pago ENERO MULTA X CAPACITACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7158'
   AND monto_total = 69.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'RII 3329'
   AND monto_total = 22.10
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'RII 3329'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7157'
   AND monto_total = 19.50
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7158'
   AND monto_total = 131.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7247'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7306'
   AND monto_total = 149.50
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7306'
   AND monto_total = 10.50
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7339'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'RII 3411'
   AND monto_total = 20.40
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'RII 3411'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7382'
   AND monto_total = 173.60
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7419'
   AND monto_total = 65.90
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7419'
   AND monto_total = 84.10
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '80055674' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7460'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL)
   AND comprobante = 'RII 3318'
   AND monto_total = 42.70
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL)
   AND comprobante = 'RII 3318'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL)
   AND comprobante = 'RII 3318'
   AND monto_total = 42.90
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL)
   AND comprobante = 'RII 3318'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6766'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL)
   AND comprobante = 'RII 3318'
   AND monto_total = 38.30
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL)
   AND comprobante = 'RII 3318'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6936'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL)
   AND comprobante = 'RII 3318'
   AND monto_total = 37.90
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL)
   AND comprobante = 'RII 3318'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7094'
   AND monto_total = 360.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7139'
   AND monto_total = 140.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7293'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08139723' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7492'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL)
   AND comprobante = 'RII 3181'
   AND monto_total = 17.60
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL)
   AND comprobante = 'RII 3181'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL)
   AND comprobante = 'RII 3265'
   AND monto_total = 20.10
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL)
   AND comprobante = 'RII 3265'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6644'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL)
   AND comprobante = 'RII 3265'
   AND monto_total = 19.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL)
   AND comprobante = 'RII 3265'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6901'
   AND monto_total = 650.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL)
   AND comprobante = 'RII 3349'
   AND monto_total = 21.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL)
   AND comprobante = 'RII 3349'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-17 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7038'
   AND monto_total = 650.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL)
   AND comprobante = 'RII 3413'
   AND monto_total = 23.00
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL)
   AND comprobante = 'RII 3413'
   AND monto_total = 7.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL)
   AND comprobante = 'RII 3414'
   AND monto_total = 8.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7192'
   AND monto_total = 650.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '44465773' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7402'
   AND monto_total = 650.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-17 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3256'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL)
   AND comprobante = 'EBE01-6609'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-17 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3256'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-17 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3256'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6698'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-17 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3256'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-17 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3256'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-16 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6873'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-17 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3256'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-17 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3256'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-17 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7039'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3358'
   AND monto_total = 14.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL)
   AND comprobante = 'RII 3358'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7222'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08378642' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7407'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL)
   AND comprobante = 'RII 3228'
   AND monto_total = 30.90
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL)
   AND comprobante = 'RII 3228'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL)
   AND comprobante = 'RII 3287'
   AND monto_total = 30.10
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL)
   AND comprobante = 'RII 3287'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6785'
   AND monto_total = 1000.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL)
   AND comprobante = 'RII 3336'
   AND monto_total = 29.60
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL)
   AND comprobante = 'RII 3336'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6983'
   AND monto_total = 1000.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL)
   AND comprobante = 'RII 3390'
   AND monto_total = 31.10
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL)
   AND comprobante = 'RII 3390'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7164'
   AND monto_total = 1000.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '72336226' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7316'
   AND monto_total = 1000.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'RII 3169'
   AND monto_total = 9.00
   AND observacion = 'Migracion 2026: Pago SETIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'RII 3169'
   AND monto_total = 4.00
   AND observacion = 'Migracion 2026: Pago SETIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'RII 3169'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'RII 3169'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'RII 3169'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'RII 3169'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6616'
   AND monto_total = 80.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'RII 3382'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'RII 3382'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6768'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'RII 3382'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'RII 3382'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6938'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'RII 3382'
   AND monto_total = 14.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'RII 3382'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7097'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7297'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09720689' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7495'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL)
   AND comprobante = 'RII 3210'
   AND monto_total = 39.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL)
   AND comprobante = 'RII 3210'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6705'
   AND monto_total = 400.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6712'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL)
   AND comprobante = 'RII 3210'
   AND monto_total = 39.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL)
   AND comprobante = 'RII 3210'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6842'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-16 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL)
   AND comprobante = 'RII 3255'
   AND monto_total = 28.30
   AND observacion = 'Migracion 2026: Pago ENERO MULTA X CAPACITACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL)
   AND comprobante = 'RII 3297'
   AND monto_total = 45.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL)
   AND comprobante = 'RII 3297'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7005'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL)
   AND comprobante = 'RII 3350'
   AND monto_total = 44.00
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL)
   AND comprobante = 'RII 3350'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7193'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL)
   AND comprobante = 'RII 3409'
   AND monto_total = 44.00
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL)
   AND comprobante = 'RII 3409'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42841670' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7377'
   AND monto_total = 600.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6601'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'RII 3166'
   AND monto_total = 9.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'RII 3166'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6607'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6608'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6627'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6652'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6663'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6696'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6735'
   AND monto_total = 70.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6794'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'RII 3231'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'RII 3231'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6774'
   AND monto_total = 30.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-03 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6795'
   AND monto_total = 70.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6845'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-16 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6870'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6878'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-25 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6914'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'RII 3277'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'RII 3277'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6956'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6943'
   AND monto_total = 40.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6957'
   AND monto_total = 20.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7003'
   AND monto_total = 170.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7042'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7111'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7129'
   AND monto_total = 70.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'RII 3392'
   AND monto_total = 11.00
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'RII 3392'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7129'
   AND monto_total = 30.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7148'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7189'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7232'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7265'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'RII 3392'
   AND monto_total = 11.00
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'RII 3392'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7327'
   AND monto_total = 70.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7371'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7412'
   AND monto_total = 110.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-26 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09700283' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7449'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL)
   AND comprobante = 'RII 3172'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL)
   AND comprobante = 'RII 3172'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6622'
   AND monto_total = 700.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL)
   AND comprobante = 'RII 3248'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL)
   AND comprobante = 'RII 3248'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 6837'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 6838'
   AND monto_total = 400.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL)
   AND comprobante = 'RII 3290'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL)
   AND comprobante = 'RII 3290'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6992'
   AND monto_total = 700.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL)
   AND comprobante = 'RII 3362'
   AND monto_total = 14.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL)
   AND comprobante = 'RII 3362'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7134'
   AND monto_total = 700.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL)
   AND comprobante = 'RII 3362'
   AND monto_total = 5.60
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL)
   AND comprobante = 'RII 3362'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '41747705' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7395'
   AND monto_total = 700.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48462586' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6670'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48462586' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6670'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48462586' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6863'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48462586' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7151'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-16 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48462586' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7207'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-24 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '48462586' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7256'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'RII 3167'
   AND monto_total = 4.90
   AND observacion = 'Migracion 2026: Pago OCTUBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'RII 3167'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'RII 3167'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'RII 3167'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6610'
   AND monto_total = 90.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6611'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'RII 3288'
   AND monto_total = 5.30
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'RII 3288'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6775'
   AND monto_total = 60.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6948'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6986'
   AND monto_total = 240.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'RII 3288'
   AND monto_total = 7.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'RII 3288'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'RII 3325'
   AND monto_total = 28.30
   AND observacion = 'Migracion 2026: Pago ENERO MULTA X CAPACITACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7099'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'RII 3325'
   AND monto_total = 9.20
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'RII 3325'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7152'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7234'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'RII 3360'
   AND monto_total = 8.00
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'RII 3360'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7299'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09852414' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7497'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10625419' AND deleted_at IS NULL)
   AND comprobante = 'RII 3342'
   AND monto_total = 1000.00
   AND observacion = 'Migracion 2026: Pago ABRIL GARANTIA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '10625419' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7182'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6707'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6849'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6897'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL)
   AND comprobante = 'RII 3204'
   AND monto_total = 15.50
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL)
   AND comprobante = 'RII 3204'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6897'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL)
   AND comprobante = 'RII 3264'
   AND monto_total = 15.70
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL)
   AND comprobante = 'RII 3264'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6897'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL)
   AND comprobante = 'RII 3353'
   AND monto_total = 13.80
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL)
   AND comprobante = 'RII 3353'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7279'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09135097' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7362'
   AND monto_total = 121.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3177'
   AND monto_total = 170.00
   AND observacion = 'Migracion 2026: Pago AGOSTO DEPOSITO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3177'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago SETIEMBRE DEPOSITO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3177'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE DEPOSITO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3195'
   AND monto_total = 52.60
   AND observacion = 'Migracion 2026: Pago OCTUBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3195'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6635'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6636'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3177'
   AND monto_total = 80.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE DEPOSITO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3195'
   AND monto_total = 41.40
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3208'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE DEPOSITO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3209'
   AND monto_total = 8.50
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3209'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3209'
   AND monto_total = 70.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE DEPOSITO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3209'
   AND monto_total = 50.60
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3209'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6736'
   AND monto_total = 400.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3215'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE DEPOSITO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3216'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE DEPOSITO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3252'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ENERO DEPOSITO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3283'
   AND monto_total = 49.20
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3283'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6970'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7009'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7159'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7203'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7230'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6945'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3330'
   AND monto_total = 48.50
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-08 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3330'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7231'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7273'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3395'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago FEBRERO DEPOSITO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7330'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7380'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3380'
   AND monto_total = 50.50
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'RII 3380'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7301'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7380'
   AND monto_total = 550.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7426'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7455'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7456'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MARZO DEPOSITO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '45452812' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7499'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6633'
   AND monto_total = 30.00
   AND observacion = 'Migracion 2026: Pago AGOSTO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6633'
   AND monto_total = 470.00
   AND observacion = 'Migracion 2026: Pago SETIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6699'
   AND monto_total = 30.00
   AND observacion = 'Migracion 2026: Pago SETIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'RII 3176'
   AND monto_total = 8.60
   AND observacion = 'Migracion 2026: Pago OCTUBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'RII 3176'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6699'
   AND monto_total = 170.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6799'
   AND monto_total = 330.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'RII 3176'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'RII 3176'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6799'
   AND monto_total = 70.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6855'
   AND monto_total = 30.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6856'
   AND monto_total = 170.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6881'
   AND monto_total = 140.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7043'
   AND monto_total = 90.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AL'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'RII 3235'
   AND monto_total = 0.20
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'RII 3236'
   AND monto_total = 11.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'RII 3236'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-18 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7043'
   AND monto_total = 110.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7349'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'TEMP-58' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7360'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6615'
   AND monto_total = 1000.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL)
   AND comprobante = 'RII 3245'
   AND monto_total = 15.50
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL)
   AND comprobante = 'RII 3245'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6820'
   AND monto_total = 850.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-17 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL)
   AND comprobante = 'RII 3305'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-17 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL)
   AND comprobante = 'RII 3305'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6922'
   AND monto_total = 1000.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL)
   AND comprobante = 'RII 3308'
   AND monto_total = 14.80
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-23 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL)
   AND comprobante = 'RII 3308'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7112'
   AND monto_total = 1000.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL)
   AND comprobante = 'RII 3405'
   AND monto_total = 15.90
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL)
   AND comprobante = 'RII 3405'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7320'
   AND monto_total = 750.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7348'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7466'
   AND monto_total = 900.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-06-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '71390650' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7507'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73192679' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6612'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73192679' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6613'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73192679' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7021'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73192679' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7021'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-16 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '73192679' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7208'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '28312595' AND deleted_at IS NULL)
   AND comprobante = 'EBO1-6788'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '28312595' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7030'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '28312595' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7125'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '28312595' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7361'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL)
   AND comprobante = 'RII 3243'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL)
   AND comprobante = 'RII 3243'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6770'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL)
   AND comprobante = 'RII 3299'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL)
   AND comprobante = 'RII 3299'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6944'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL)
   AND comprobante = 'RII 3320'
   AND monto_total = 14.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL)
   AND comprobante = 'RII 3320'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7100'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL)
   AND comprobante = 'RII 3391'
   AND monto_total = 5.60
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL)
   AND comprobante = 'RII 3391'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7300'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL)
   AND comprobante = 'RII 3438'
   AND monto_total = 7.20
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL)
   AND comprobante = 'RII 3438'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago ABRIL AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '08363214' AND deleted_at IS NULL)
   AND comprobante = 'EB01 - 7498'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3185'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago AGOSTO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3185'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago AGOSTO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3185'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago SETIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3185'
   AND monto_total = 4.00
   AND observacion = 'Migracion 2026: Pago SETIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3185'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3185'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago OCTUBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3185'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3185'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6653'
   AND monto_total = 380.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-12 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6653'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3356'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3356'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-06 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7133'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3356'
   AND monto_total = 15.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3356'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7204'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3356'
   AND monto_total = 14.40
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3356'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7204'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7204'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3439'
   AND monto_total = 5.60
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3439'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7409'
   AND monto_total = 450.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3439'
   AND monto_total = 7.20
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'RII 3439'
   AND monto_total = 1.20
   AND observacion = 'Migracion 2026: Pago ABRIL AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7468'
   AND monto_total = 50.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '09574907' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7467'
   AND monto_total = 250.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-09 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL)
   AND comprobante = 'RII 3182'
   AND monto_total = 10.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE RECONEXION DE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL)
   AND comprobante = 'RII 3196'
   AND monto_total = 108.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL)
   AND comprobante = 'RII 3196'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6816'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL)
   AND comprobante = 'RII 3273'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL)
   AND comprobante = 'RII 3274'
   AND monto_total = 127.60
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL)
   AND comprobante = 'RII 3274'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-04 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6974'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL)
   AND comprobante = 'RII 3375'
   AND monto_total = 235.20
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL)
   AND comprobante = 'RII 3375'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7117'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL)
   AND comprobante = 'RII 3424'
   AND monto_total = 233.00
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL)
   AND comprobante = 'RII 3424'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL)
   AND comprobante = 'RII 3424'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago ABRIL FUMIGACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-20 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42479516' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7427'
   AND monto_total = 500.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'RII 3199'
   AND monto_total = 11.80
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'RII 3199'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago NOVIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'RII 3199'
   AND monto_total = 12.80
   AND observacion = 'Migracion 2026: Pago DICIEMBRE LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-19 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'RII 3199'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6782'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'RII 3276'
   AND monto_total = 11.90
   AND observacion = 'Migracion 2026: Pago ENERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'RII 3276'
   AND monto_total = 3.00
   AND observacion = 'Migracion 2026: Pago ENERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-06-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'RII 3445'
   AND monto_total = 28.30
   AND observacion = 'Migracion 2026: Pago ENERO MULTA X CAPACITACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-02 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6954'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'RII 3359'
   AND monto_total = 19.10
   AND observacion = 'Migracion 2026: Pago FEBRERO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'RII 3359'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago FEBRERO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7227'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'RII 3361'
   AND monto_total = 13.30
   AND observacion = 'Migracion 2026: Pago MARZO LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'RII 3361'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago MARZO AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-06-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'RII 3445'
   AND monto_total = 14.50
   AND observacion = 'Migracion 2026: Pago ABRIL LUZ'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-06-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'RII 3445'
   AND monto_total = 6.00
   AND observacion = 'Migracion 2026: Pago ABRIL AGUA'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-06-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7502'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-06-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '20654471' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7503'
   AND monto_total = 350.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42799850' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6747'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-29 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42799850' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6748'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-27 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42799850' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6923'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42799850' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7140'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42799850' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7236'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-22 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42799850' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7237'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42799850' AND deleted_at IS NULL)
   AND comprobante = 'RII 3425'
   AND monto_total = 5.00
   AND observacion = 'Migracion 2026: Pago ABRIL FUMIGACION'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-21 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '42799850' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7431'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL)
   AND comprobante = 'RII 3253'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE DEPOSITO N°6 3PISO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL)
   AND comprobante = 'RII 3253'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago DICIEMBRE DEPOSITO N°8 3PISO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL)
   AND comprobante = 'RII 3253'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago ENERO DEPOSITO N°6 3PISO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-11 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL)
   AND comprobante = 'RII 3253'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago ENERO DEPOSITO N°8 3PISO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL)
   AND comprobante = 'RII 3344'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago FEBRERO DEPOSITO N°6 3PISO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL)
   AND comprobante = 'RII 3344'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago FEBRERO DEPOSITO N°8 3PISO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL)
   AND comprobante = 'RII 3344'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago MARZO DEPOSITO N°6 3PISO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL)
   AND comprobante = 'RII 3344'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago MARZO DEPOSITO N°8 3PISO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-26 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7448'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago ABRIL DEPOSITO N°5 3PISO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-26 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-5-D3' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7448'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago ABRIL DEPOSITO N°6 3PISO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-4-D3' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7196'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago AGOSTO DEPOSITO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-15 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = 'DEP-4-D3' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7196'
   AND monto_total = 150.00
   AND observacion = 'Migracion 2026: Pago SETIEMBRE DEPOSITO'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-01-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL)
   AND comprobante = 'E001-309'
   AND monto_total = 300.00
   AND observacion = 'Migracion 2026: Pago ENERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-28 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL)
   AND comprobante = 'E001-325'
   AND monto_total = 260.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-13 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL)
   AND comprobante = 'E001-338'
   AND monto_total = 40.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL)
   AND comprobante = 'E001-355'
   AND monto_total = 170.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL)
   AND comprobante = 'E001-357'
   AND monto_total = 130.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL)
   AND comprobante = 'E001-377'
   AND monto_total = 160.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL)
   AND comprobante = 'E001-379'
   AND monto_total = 140.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-30 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL)
   AND comprobante = 'E001-393'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-31 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '15605235546' AND deleted_at IS NULL)
   AND comprobante = 'E001-395'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago MAYO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-02-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '29096837' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6825'
   AND monto_total = 140.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-05 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '29096837' AND deleted_at IS NULL)
   AND comprobante = 'EB01-6981'
   AND monto_total = 70.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-03-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '29096837' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7031'
   AND monto_total = 80.00
   AND observacion = 'Migracion 2026: Pago FEBRERO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-01 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '29096837' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7113'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-04-10 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '29096837' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7176'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago MARZO ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-07 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '29096837' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7347'
   AND monto_total = 200.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;
UPDATE public.pagos 
   SET fecha_pago = '2026-05-14 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '29096837' AND deleted_at IS NULL)
   AND comprobante = 'EB01-7389'
   AND monto_total = 100.00
   AND observacion = 'Migracion 2026: Pago ABRIL ALQUILER'
   AND fecha_pago::date = '2026-06-05'::date;

COMMIT;
