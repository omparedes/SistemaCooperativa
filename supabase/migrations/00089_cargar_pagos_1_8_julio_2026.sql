-- =============================================================================
-- Migración 00089: Pagos 01-08 Julio 2026
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- Generado: 2026-07-09 desde scripts/generar_pagos_1_8_julio_2026.js
-- Fuente: migracion_coop/julio/SOCIOS - CONSOLIDADO PAGOS 01-08 JULIO 2026.xlsx (hoja "Detalle pagos")
-- Registra pagos reales 01-08 jul 2026. Marca deudas como Cancelado si pago total.
-- =============================================================================

DO $$
DECLARE
  v_pago_id bigint;
BEGIN

  -- Socio: AGUIRRE QUISPE WILFREDO GILMER | Fecha: 2026-07-07 | Doc: 33461 | Total: S/ 200.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (229, 1, 200.00, 'Efectivo', '33461', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO 6 - D2 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11515: DEPOSITO 6 - D2 2026/06 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11515, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11515;

  -- Socio: ALARCON ANAMPA BETSY JANET | Fecha: 2026-07-08 | Doc: 33555 | Total: S/ 150.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (160, 2, 150.00, 'Efectivo', '33555', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10773: LUZ 2026/05 | Monto deuda: S/42.5 | Pagado: S/14 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10773, 14.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10773;

  -- Deuda id=10774: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10774, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10774;

  -- Deuda id=10775: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10775, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10775;

  -- Deuda id=10776: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10776, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10776;

  -- Deuda id=11516: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11516, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11516;

  -- Deuda id=11517: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11517, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11517;

  -- Socio: ALARCON ANAMPA NANCY GUISELA | Fecha: 2026-07-06 | Doc: 33442 | Total: S/ 64.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (152, 3, 64.00, 'Efectivo', '33442', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- Deuda id=6266: LUZ 2026/04 | Monto deuda: S/58 | Pagado: S/58 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6266, 58.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6266;

  -- Deuda id=6267: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6267, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6267;

  -- Socio: ALARCON ANAMPA NANCY GUISELA | Fecha: 2026-07-06 | Doc: 33431 | Total: S/ 130.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (152, 3, 130.00, 'Efectivo', '33431', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10779: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10779, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10779;

  -- Deuda id=10780: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10780, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10780;

  -- Deuda id=11518: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11518, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11518;

  -- Deuda id=11519: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11519, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11519;

  -- Socio: ALARCON ANAMPA NANCY GUISELA | Fecha: 2026-07-08 | Doc: 33503 | Total: S/ 58.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (152, 3, 58.00, 'Efectivo', '33503', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10777: LUZ 2026/05 | Monto deuda: S/58 | Pagado: S/58 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10777, 58.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10777;

  -- Socio: ALARCON ANAMPA NANCY GUISELA | Fecha: 2026-07-08 | Doc: 33539 | Total: S/ 6.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (152, 3, 6.00, 'Efectivo', '33539', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10778: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10778, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10778;

  -- Socio: ALHUAY PALOMINO DE ALHUAY JUANA | Fecha: 2026-07-03 | Doc: 33394 | Total: S/ 56.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (275, 4, 56.90, 'Efectivo', '33394', '2026-07-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10781: LUZ 2026/05 | Monto deuda: S/25.3 | Pagado: S/25.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10781, 25.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10781;

  -- Deuda id=10782: AGUA 2026/05 | Monto deuda: S/31.6 | Pagado: S/31.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10782, 31.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10782;

  -- Socio: ALHUAY PALOMINO DE ALHUAY JUANA | Fecha: 2026-07-02 | Doc: 33384 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (275, 4, 65.00, 'Efectivo', '33384', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11520: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11520, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11520;

  -- Deuda id=11521: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11521, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11521;

  -- Socio: ALVAREZ CAMPOS ROLANDO | Fecha: 2026-07-08 | Doc: 33513 | Total: S/ 427.60
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (170, 5, 427.60, 'Efectivo', '33513', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/04, P. SOCIAL 2026/04, DEPOSITO 3 - D2 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=6316: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/38.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6316, 38.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6316;

  -- Deuda id=6317: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6317, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6317;

  -- Deuda id=11888: DEPOSITO 3 - D2 2026/04 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11888, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11888;

  -- Deuda id=10785: LUZ 2026/05 | Monto deuda: S/48 | Pagado: S/48 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10785, 48.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10785;

  -- Deuda id=10786: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10786, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10786;

  -- Deuda id=10787: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10787, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10787;

  -- Deuda id=10788: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10788, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10788;

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: ALVAREZ CAMPOS VICTOR ADRIANO | Fecha: 2026-07-02 | Doc: 33379 | Total: S/ 96.60
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (250, 6, 96.60, 'Efectivo', '33379', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=6339: LUZ 2026/03 | Monto deuda: S/25 | Pagado: S/25 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6339, 25.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6339;

  -- Deuda id=6340: AGUA 2026/03 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6340, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6340;

  -- Deuda id=11889: LUZ 2026/04 | Monto deuda: S/27.3 | Pagado: S/27.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11889, 27.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11889;

  -- Deuda id=11890: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11890, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11890;

  -- Deuda id=6341: LUZ 2026/05 | Monto deuda: S/26.3 | Pagado: S/26.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6341, 26.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6341;

  -- Deuda id=6342: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6342, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6342;

  -- Socio: ANAMPA CORAHUA CLEMENCIA MIGDONIA | Fecha: 2026-07-01 | Doc: 33356 | Total: S/ 141.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (154, 8, 141.00, 'Efectivo', '33356', '2026-07-01T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- Deuda id=6386: LUZ 2026/04 | Monto deuda: S/135 | Pagado: S/135 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6386, 135.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6386;

  -- Deuda id=6387: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6387, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6387;

  -- Socio: ANAMPA CORAHUA CLEMENCIA MIGDONIA | Fecha: 2026-07-06 | Doc: 33432 | Total: S/ 130.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (154, 8, 130.00, 'Efectivo', '33432', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10800: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10800, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10800;

  -- Deuda id=10801: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10801, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10801;

  -- Deuda id=11527: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11527, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11527;

  -- Deuda id=11528: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11528, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11528;

  -- Socio: ANAMPA CORAHUA CLEMENCIA MIGDONIA | Fecha: 2026-07-08 | Doc: 33530 | Total: S/ 141.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (154, 8, 141.00, 'Efectivo', '33530', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10798: LUZ 2026/05 | Monto deuda: S/135 | Pagado: S/135 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10798, 135.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10798;

  -- Deuda id=10799: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10799, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10799;

  -- Socio: ANCCO LEON VALENTINA | Fecha: 2026-07-06 | Doc: 33446 | Total: S/ 175.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (130, 9, 175.00, 'Efectivo', '33446', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10802: LUZ 2026/05 | Monto deuda: S/39 | Pagado: S/39 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10802, 39.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10802;

  -- Deuda id=10803: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10803, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10803;

  -- Deuda id=10804: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10804, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10804;

  -- Deuda id=10805: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10805, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10805;

  -- Deuda id=11529: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11529, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11529;

  -- Deuda id=11530: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11530, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11530;

  -- Socio: ATANASIO ORTEGA MAXIMILIANA | Fecha: 2026-07-03 | Doc: 33392 | Total: S/ 20.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (273, 10, 20.00, 'Efectivo', '33392', '2026-07-03T12:00:00+00:00', 'Pago 01-08 jul 2026: P. SOCIAL 2026/03, P. SOCIAL 2026/04, P. SOCIAL 2026/05, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=6434: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6434, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6434;

  -- Deuda id=6437: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6437, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6437;

  -- Deuda id=10809: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10809, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10809;

  -- Deuda id=11532: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11532, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11532;

  -- Socio: ATANASIO ORTEGA MAXIMILIANA | Fecha: 2026-07-07 | Doc: 33466 | Total: S/ 66.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (273, 10, 66.30, 'Efectivo', '33466', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10806: LUZ 2026/05 | Monto deuda: S/51.3 | Pagado: S/51.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10806, 51.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10806;

  -- Deuda id=10807: AGUA 2026/05 | Monto deuda: S/15 | Pagado: S/15 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10807, 15.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10807;

  -- Socio: AYALA HUASHUAYO NORMA GLADYS | Fecha: 2026-07-02 | Doc: 33375 | Total: S/ 97.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (60, 11, 97.00, 'Efectivo', '33375', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10810: LUZ 2026/05 | Monto deuda: S/26 | Pagado: S/26 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10810, 26.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10810;

  -- Deuda id=10811: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10811, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10811;

  -- Deuda id=11533: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11533, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11533;

  -- Deuda id=11534: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11534, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11534;

  -- Socio: AYALA TABOADA ELISEO | Fecha: 2026-07-02 | Doc: 33374 | Total: S/ 249.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (55, 12, 249.00, 'Efectivo', '33374', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06, DEPOSITO 1 - D3 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10814: LUZ 2026/05 | Monto deuda: S/28 | Pagado: S/28 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10814, 28.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10814;

  -- Deuda id=10815: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10815, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10815;

  -- Deuda id=11535: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11535, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11535;

  -- Deuda id=11536: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11536, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11536;

  -- Deuda id=11537: DEPOSITO 1 - D3 2026/06 | Monto deuda: S/150 | Pagado: S/150 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11537, 150.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11537;

  -- Socio: BASTIDAS MEDINA DINA | Fecha: 2026-07-07 | Doc: 33492 | Total: S/ 96.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (171, 13, 96.00, 'Efectivo', '33492', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10738: LUZ 2026/04 | Monto deuda: S/39 | Pagado: S/39 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10738, 39.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10738;

  -- Deuda id=10739: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10739, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10739;

  -- Deuda id=10819: LUZ 2026/05 | Monto deuda: S/45 | Pagado: S/45 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10819, 45.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10819;

  -- Deuda id=10820: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10820, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10820;

  -- Socio: BASTIDAS MEDINA DINA | Fecha: 2026-07-07 | Doc: 33493 | Total: S/ 130.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (171, 13, 130.00, 'Efectivo', '33493', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10821: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10821, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10821;

  -- Deuda id=10822: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10822, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10822;

  -- Deuda id=11538: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11538, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11538;

  -- Deuda id=11539: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11539, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11539;

  -- Socio: BASTIDAS MEDINA HERMENEGILDO | Fecha: 2026-07-06 | Doc: 33422 | Total: S/ 131.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (199, 14, 131.20, 'Efectivo', '33422', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=6533: LUZ 2026/04 | Monto deuda: S/32.5 | Pagado: S/32.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6533, 32.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6533;

  -- Deuda id=6534: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6534, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6534;

  -- Deuda id=10823: LUZ 2026/05 | Monto deuda: S/31.7 | Pagado: S/31.7 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10823, 31.70);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10823;

  -- Deuda id=10824: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10824, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10824;

  -- Deuda id=11540: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/50 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11540, 50.00);

  -- Deuda id=11541: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11541, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11541;

  -- Socio: BERNAOLA CARHUAZ DE PRADO FLORENCIA | Fecha: 2026-07-01 | Doc: 33358 | Total: S/ 226.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (261, 15, 226.50, 'Efectivo', '33358', '2026-07-01T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10827: LUZ 2026/05 | Monto deuda: S/123.5 | Pagado: S/123.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10827, 123.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10827;

  -- Deuda id=10828: AGUA 2026/05 | Monto deuda: S/103 | Pagado: S/103 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10828, 103.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10828;

  -- Socio: BERNAOLA CARHUAZ DE PRADO FLORENCIA | Fecha: 2026-07-08 | Doc: 33504 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (261, 15, 65.00, 'Efectivo', '33504', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11542: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11542, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11542;

  -- Deuda id=11543: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11543, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11543;

  -- Socio: BURGA CARRASCO ELIDA | Fecha: 2026-07-07 | Doc: 33481 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (66, 17, 65.00, 'Efectivo', '33481', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11546: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11546, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11546;

  -- Deuda id=11547: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11547, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11547;

  -- Socio: CABALLERO CALZADO GLADYS VICTORIA | Fecha: 2026-07-01 | Doc: 33362 | Total: S/ 195.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (203, 18, 195.00, 'Efectivo', '33362', '2026-07-01T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=6634: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6634, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6634;

  -- Deuda id=6635: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6635, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6635;

  -- Deuda id=10841: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10841, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10841;

  -- Deuda id=10842: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10842, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10842;

  -- Deuda id=11548: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11548, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11548;

  -- Deuda id=11549: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11549, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11549;

  -- Socio: CABERO MENDOZA GLORIA LUCINDA | Fecha: 2026-07-07 | Doc: 33472 | Total: S/ 167.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (108, 19, 167.40, 'Efectivo', '33472', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO 8 - D2 2026/03, DEPOSITO 8 - D2 2026/04, LUZ 2026/05, AGUA 2026/05, DEPOSITO 8 - D2 2026/05, DEPOSITO 8 - D2 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11901: DEPOSITO 8 - D2 2026/03 | Monto deuda: S/50.4 | Pagado: S/50.4 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11901, 50.40);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11901;

  -- Deuda id=11902: DEPOSITO 8 - D2 2026/04 | Monto deuda: S/20 | Pagado: S/20 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11902, 20.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11902;

  -- Deuda id=10843: LUZ 2026/05 | Monto deuda: S/39 | Pagado: S/39 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10843, 39.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10843;

  -- Deuda id=10844: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10844, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10844;

  -- Deuda id=11903: DEPOSITO 8 - D2 2026/05 | Monto deuda: S/20 | Pagado: S/20 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11903, 20.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11903;

  -- Deuda id=11552: DEPOSITO 8 - D2 2026/06 | Monto deuda: S/200 | Pagado: S/32 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11552, 32.00);

  -- Socio: CABERO MENDOZA GLORIA LUCINDA | Fecha: 2026-07-08 | Doc: 33549 | Total: S/ 1000.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (108, 19, 1000.00, 'Efectivo', '33549', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO N° 8-3ER PISO 08/2025 2025/08, DEPOSITO N° 8-3ER PISO 09/2025 2025/09, DEPOSITO N° 8-3ER PISO 10/2025 2025/10, DEPOSITO N° 8-3ER PISO 11/2025 2025/11, DEPOSITO N° 8-3ER PISO 12/2025 2025/12, DEPOSITO N° 8-3ER PISO 01/2026 2026/01, DEPOSITO N° 8-3ER PISO 02/2026 2026/02')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: DEPOSITO N° 8-3ER PISO 08/2025 2025/08 S/150 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO N° 8-3ER PISO 09/2025 2025/09 S/150 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO N° 8-3ER PISO 10/2025 2025/10 S/150 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO N° 8-3ER PISO 11/2025 2025/11 S/150 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO N° 8-3ER PISO 12/2025 2025/12 S/150 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO N° 8-3ER PISO 01/2026 2026/01 S/150 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO N° 8-3ER PISO 02/2026 2026/02 S/100 — registrado en pago pero sin monto_id

  -- Socio: CAHUANA VDA DE DAVILA VICENTINA | Fecha: 2026-07-08 | Doc: 33526 | Total: S/ 237.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (254, 20, 237.40, 'Efectivo', '33526', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10874: LUZ 2026/05 | Monto deuda: S/54.4 | Pagado: S/54.4 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10874, 54.40);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10874;

  -- Deuda id=10875: AGUA 2026/05 | Monto deuda: S/158 | Pagado: S/158 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10875, 158.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10875;

  -- Deuda id=11554: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/20 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11554, 20.00);

  -- Deuda id=11555: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11555, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11555;

  -- Socio: CAJALEON CARRASCO LUIS ENRIQUE | Fecha: 2026-07-08 | Doc: 33540 | Total: S/ 188.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (173, 21, 188.00, 'Efectivo', '33540', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=6705: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/16 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6705, 16.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6705;

  -- Deuda id=6706: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6706, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6706;

  -- Deuda id=6707: LUZ 2026/04 | Monto deuda: S/75 | Pagado: S/75 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6707, 75.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6707;

  -- Deuda id=6708: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6708, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6708;

  -- Deuda id=6702: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/10 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6702, 10.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6702;

  -- Deuda id=6709: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6709, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6709;

  -- Deuda id=10878: LUZ 2026/05 | Monto deuda: S/35 | Pagado: S/35 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10878, 35.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10878;

  -- Deuda id=10879: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10879, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10879;

  -- Deuda id=10881: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10881, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10881;

  -- Deuda id=11556: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/20 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11556, 20.00);

  -- Deuda id=11557: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11557, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11557;

  -- Socio: CALDERON TORRES BERTHA ESTELA | Fecha: 2026-07-01 | Doc: 33354 | Total: S/ 120.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (150, 22, 120.00, 'Efectivo', '33354', '2026-07-01T12:00:00+00:00', 'Pago 01-08 jul 2026: AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, P. SOCIAL 2026/05, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=6711: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6711, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6711;

  -- Deuda id=10882: LUZ 2026/05 | Monto deuda: S/98 | Pagado: S/98 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10882, 98.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10882;

  -- Deuda id=10883: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10883, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10883;

  -- Deuda id=10885: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10885, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10885;

  -- Deuda id=11559: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11559, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11559;

  -- Socio: CALDERON VERA SEGUNDO ALCIDES | Fecha: 2026-07-07 | Doc: 33462 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (278, 23, 65.00, 'Efectivo', '33462', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11560: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11560, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11560;

  -- Deuda id=11561: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11561, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11561;

  -- Socio: CALLE ALVAREZ MARCO ANTONIO | Fecha: 2026-07-07 | Doc: 33453 | Total: S/ 15.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (244, 24, 15.10, 'Efectivo', '33453', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03')
  RETURNING id INTO v_pago_id;

  -- Deuda id=6760: LUZ 2026/03 | Monto deuda: S/9.1 | Pagado: S/9.1 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6760, 9.10);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6760;

  -- Deuda id=6761: AGUA 2026/03 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6761, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6761;

  -- Socio: CALLE ALVAREZ MARCO ANTONIO | Fecha: 2026-07-07 | Doc: 33454 | Total: S/ 17.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (244, 24, 17.40, 'Efectivo', '33454', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- Deuda id=6762: LUZ 2026/04 | Monto deuda: S/11.4 | Pagado: S/11.4 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6762, 11.40);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6762;

  -- Deuda id=6763: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6763, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6763;

  -- Socio: CALLE ALVAREZ MARCO ANTONIO | Fecha: 2026-07-07 | Doc: 33455 | Total: S/ 17.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (244, 24, 17.20, 'Efectivo', '33455', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10890: LUZ 2026/05 | Monto deuda: S/11.2 | Pagado: S/11.2 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10890, 11.20);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10890;

  -- Deuda id=10891: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10891, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10891;

  -- Socio: CALLE CALLE FIDEL | Fecha: 2026-07-04 | Doc: 33406 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (146, 25, 65.00, 'Efectivo', '33406', '2026-07-04T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03')
  RETURNING id INTO v_pago_id;

  -- Deuda id=6782: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6782, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6782;

  -- Deuda id=6783: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6783, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6783;

  -- Socio: CALLE CALLE FIDEL | Fecha: 2026-07-04 | Doc: 33407 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (146, 25, 65.00, 'Efectivo', '33407', '2026-07-04T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- Deuda id=6786: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6786, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6786;

  -- Deuda id=6787: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6787, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6787;

  -- Socio: CALLE CALLE FIDEL | Fecha: 2026-07-07 | Doc: 33456 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (146, 25, 65.00, 'Efectivo', '33456', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10897: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10897, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10897;

  -- Deuda id=10898: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10898, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10898;

  -- Socio: CALLE CALLE FIDEL | Fecha: 2026-07-07 | Doc: 33457 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (146, 25, 65.00, 'Efectivo', '33457', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11565: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11565, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11565;

  -- Deuda id=11566: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11566, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11566;

  -- Socio: CAMPUZANO CABELLO VICENTA DONATILA | Fecha: 2026-07-03 | Doc: 33404 | Total: S/ 28.60
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (196, 26, 28.60, 'Efectivo', '33404', '2026-07-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10899: LUZ 2026/05 | Monto deuda: S/13.6 | Pagado: S/13.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10899, 13.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10899;

  -- Deuda id=10900: AGUA 2026/05 | Monto deuda: S/15 | Pagado: S/15 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10900, 15.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10900;

  -- Socio: CARDENA VILLAFUERTE ALEJANDRINA | Fecha: 2026-07-02 | Doc: 33371 | Total: S/ 11.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (62, 27, 11.00, 'Efectivo', '33371', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10903: LUZ 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10903, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10903;

  -- Deuda id=10904: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10904, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10904;

  -- Socio: CARDENA VILLAFUERTE ALEJANDRINA | Fecha: 2026-07-02 | Doc: 33370 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (62, 27, 65.00, 'Efectivo', '33370', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11569: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11569, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11569;

  -- Deuda id=11570: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11570, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11570;

  -- Socio: CARPIO VASQUEZ TEOFILA | Fecha: 2026-07-07 | Doc: 33471 | Total: S/ 226.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (277, 28, 226.00, 'Efectivo', '33471', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: MULTA 27/03/25 2026/03, MULTA 17/07/25 2026/07, MULTA 27/11/25 2026/11, MULTA 26/03/26 2026/03')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: MULTA 27/03/25 2026/03 S/56.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: MULTA 17/07/25 2026/07 S/56.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: MULTA 27/11/25 2026/11 S/56.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: MULTA 26/03/26 2026/03 S/56.5 — registrado en pago pero sin monto_id

  -- Socio: CARPIO VASQUEZ TEOFILA | Fecha: 2026-07-04 | Doc: 33414 | Total: S/ 390.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (277, 28, 390.00, 'Efectivo', '33414', '2026-07-04T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06, G. ADM 2026/07, P. SOCIAL 2026/07, G. ADM 2026/08, P. SOCIAL 2026/08, G. ADM 2026/09, P. SOCIAL 2026/09, G. ADM 2026/10, P. SOCIAL 2026/10, G. ADM 2026/11, P. SOCIAL 2026/11')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11571: G. ADM 2026/06 | Monto deuda: S/120 | Pagado: S/60 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11571, 60.00);

  -- Deuda id=11572: P. SOCIAL 2026/06 | Monto deuda: S/10 | Pagado: S/5 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11572, 5.00);

  -- Deuda id=11906: G. ADM 2026/07 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11906, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11906;

  -- Deuda id=11907: P. SOCIAL 2026/07 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11907, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11907;

  -- Deuda id=11909: G. ADM 2026/08 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11909, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11909;

  -- Deuda id=11910: P. SOCIAL 2026/08 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11910, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11910;

  -- Deuda id=11911: G. ADM 2026/09 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11911, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11911;

  -- Deuda id=11912: P. SOCIAL 2026/09 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11912, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11912;

  -- Deuda id=11913: G. ADM 2026/10 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11913, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11913;

  -- Deuda id=11914: P. SOCIAL 2026/10 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11914, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11914;

  -- Deuda id=11915: G. ADM 2026/11 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11915, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11915;

  -- Deuda id=11916: P. SOCIAL 2026/11 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11916, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11916;

  -- Socio: CARPIO VASQUEZ TEOFILA | Fecha: 2026-07-04 | Doc: 33415 | Total: S/ 310.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (277, 28, 310.00, 'Efectivo', '33415', '2026-07-04T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/12, P. SOCIAL 2026/12, G. ADM 2026/01, P. SOCIAL 2026/01, P.S X FALL. FLORES FLORES UMBELINA 2026/01, G. ADM 2026/02, P. SOCIAL 2026/02, LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11918: G. ADM 2026/12 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11918, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11918;

  -- Deuda id=11919: P. SOCIAL 2026/12 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11919, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11919;

  -- Deuda id=6857: G. ADM 2026/01 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6857, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6857;

  -- Deuda id=6858: P. SOCIAL 2026/01 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6858, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6858;

  -- SIN DEUDA: P.S X FALL. FLORES FLORES UMBELINA 2026/01 S/10 — registrado en pago pero sin monto_id

  -- Deuda id=6860: G. ADM 2026/02 | Monto deuda: S/56 | Pagado: S/56 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6860, 56.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6860;

  -- Deuda id=6861: P. SOCIAL 2026/02 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6861, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6861;

  -- Deuda id=6862: LUZ 2026/03 | Monto deuda: S/33 | Pagado: S/33 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6862, 33.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6862;

  -- Deuda id=6863: AGUA 2026/03 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6863, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6863;

  -- Deuda id=6864: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6864, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6864;

  -- Deuda id=6865: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6865, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6865;

  -- Deuda id=6867: LUZ 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6867, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6867;

  -- Socio: CARPIO VASQUEZ TEOFILA | Fecha: 2026-07-04 | Doc: 33416 | Total: S/ 217.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (277, 28, 217.00, 'Efectivo', '33416', '2026-07-04T12:00:00+00:00', 'Pago 01-08 jul 2026: AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=6868: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6868, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6868;

  -- Deuda id=6869: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6869, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6869;

  -- Deuda id=6870: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6870, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6870;

  -- Deuda id=6871: FUMIGACION 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6871, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6871;

  -- Deuda id=10907: LUZ 2026/05 | Monto deuda: S/25 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10907, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10907;

  -- Deuda id=10908: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10908, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10908;

  -- Deuda id=10909: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10909, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10909;

  -- Deuda id=10910: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10910, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10910;

  -- Deuda id=11571: G. ADM 2026/06 | Monto deuda: S/120 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11571, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11571;

  -- Deuda id=11572: P. SOCIAL 2026/06 | Monto deuda: S/10 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11572, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11572;

  -- Socio: CARRASCO SALVATIERRA FELICITA | Fecha: 2026-07-08 | Doc: 33558 | Total: S/ 260.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (172, 29, 260.00, 'Efectivo', '33558', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=6889: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6889, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6889;

  -- Deuda id=6890: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6890, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6890;

  -- Deuda id=6893: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6893, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6893;

  -- Deuda id=6894: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6894, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6894;

  -- Deuda id=10913: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10913, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10913;

  -- Deuda id=10914: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10914, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10914;

  -- Deuda id=11573: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11573, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11573;

  -- Deuda id=11574: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11574, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11574;

  -- Socio: CARRASCO SALVATIERRA FELICITA | Fecha: 2026-07-08 | Doc: 33559 | Total: S/ 161.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (172, 29, 161.20, 'Efectivo', '33559', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=6887: LUZ 2026/03 | Monto deuda: S/193.6 | Pagado: S/43.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6887, 43.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6887;

  -- Deuda id=6888: AGUA 2026/03 | Monto deuda: S/38 | Pagado: S/38 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6888, 38.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6888;

  -- Deuda id=6891: LUZ 2026/04 | Monto deuda: S/10 | Pagado: S/10 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6891, 10.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6891;

  -- Deuda id=6892: AGUA 2026/04 | Monto deuda: S/38 | Pagado: S/38 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6892, 38.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6892;

  -- Deuda id=10911: LUZ 2026/05 | Monto deuda: S/210 | Pagado: S/10 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10911, 10.00);

  -- Deuda id=10912: AGUA 2026/05 | Monto deuda: S/21.6 | Pagado: S/21.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10912, 21.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10912;

  -- Socio: CARTAGENA MAMANI BENJAMIN D | Fecha: 2026-07-06 | Doc: 33419 | Total: S/ 35.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (260, 30, 35.30, 'Efectivo', '33419', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10915: LUZ 2026/05 | Monto deuda: S/11.2 | Pagado: S/11.2 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10915, 11.20);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10915;

  -- Deuda id=10916: AGUA 2026/05 | Monto deuda: S/24.1 | Pagado: S/24.1 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10916, 24.10);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10916;

  -- Socio: CARTAGENA PALOMINO ALVARO BENJAMIN | Fecha: 2026-07-07 | Doc: 33491 | Total: S/ 460.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (185, 31, 460.00, 'Efectivo', '33491', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06, DEPOSITO 3 - D1 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=6937: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6937, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6937;

  -- Deuda id=6938: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6938, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6938;

  -- Deuda id=6941: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6941, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6941;

  -- Deuda id=6942: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6942, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6942;

  -- Deuda id=10921: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10921, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10921;

  -- Deuda id=10922: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10922, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10922;

  -- Deuda id=11577: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11577, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11577;

  -- Deuda id=11578: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11578, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11578;

  -- Deuda id=11579: DEPOSITO 3 - D1 2026/06 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11579, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11579;

  -- Socio: CARTAGENA PALOMINO ALVARO BENJAMIN | Fecha: 2026-07-06 | Doc: 33420 | Total: S/ 200.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (185, 31, 200.00, 'Efectivo', '33420', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO 3 - D1 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10923: DEPOSITO 3 - D1 2026/05 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10923, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10923;

  -- Socio: CASTRO GUTIERREZ AQUILA LUCRECIA | Fecha: 2026-07-07 | Doc: 33467 | Total: S/ 312.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (72, 33, 312.00, 'Efectivo', '33467', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10928: LUZ 2026/05 | Monto deuda: S/280 | Pagado: S/280 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10928, 280.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10928;

  -- Deuda id=10929: AGUA 2026/05 | Monto deuda: S/32 | Pagado: S/32 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10929, 32.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10929;

  -- Socio: CCOYLLO BUSTILLOS DEYSI KAREN | Fecha: 2026-07-08 | Doc: 33497 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (70, 34, 65.00, 'Efectivo', '33497', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11584: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11584, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11584;

  -- Deuda id=11585: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11585, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11585;

  -- Socio: CCOYLLO CHINCHAY DANIEL MASIA | Fecha: 2026-07-08 | Doc: 33516 | Total: S/ 31.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (158, 35, 31.00, 'Efectivo', '33516', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10936: LUZ 2026/05 | Monto deuda: S/25 | Pagado: S/25 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10936, 25.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10936;

  -- Deuda id=10937: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10937, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10937;

  -- Socio: CCOYLLO MAYHUASCA ALEXIS | Fecha: 2026-07-08 | Doc: 33498 | Total: S/ 13.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (205, 37, 13.10, 'Efectivo', '33498', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10944: LUZ 2026/05 | Monto deuda: S/7.1 | Pagado: S/7.1 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10944, 7.10);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10944;

  -- Deuda id=10945: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10945, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10945;

  -- Socio: CCOYLLO POLANCO GERMAN | Fecha: 2026-07-08 | Doc: 33515 | Total: S/ 96.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (132, 39, 96.00, 'Efectivo', '33515', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10952: LUZ 2026/05 | Monto deuda: S/25 | Pagado: S/25 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10952, 25.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10952;

  -- Deuda id=10953: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10953, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10953;

  -- Deuda id=11594: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11594, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11594;

  -- Deuda id=11595: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11595, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11595;

  -- Socio: CHALLCO CRUZ DE PALOMINO NICOLAZA | Fecha: 2026-07-03 | Doc: 33403 | Total: S/ 693.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (287, 41, 693.40, 'Efectivo', '33403', '2026-07-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=7168: LUZ 2026/04 | Monto deuda: S/425.2 | Pagado: S/425.2 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7168, 425.20);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7168;

  -- Deuda id=7169: AGUA 2026/04 | Monto deuda: S/33.1 | Pagado: S/33.1 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7169, 33.10);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7169;

  -- Deuda id=10961: LUZ 2026/05 | Monto deuda: S/798.8 | Pagado: S/198.8 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10961, 198.80);

  -- Deuda id=10962: AGUA 2026/05 | Monto deuda: S/36.3 | Pagado: S/36.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10962, 36.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10962;

  -- Socio: CHIRINOS CABRACANCHA MARIA LOURDES | Fecha: 2026-07-02 | Doc: 33377 | Total: S/ 166.60
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (174, 42, 166.60, 'Efectivo', '33377', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10965: LUZ 2026/05 | Monto deuda: S/138 | Pagado: S/138 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10965, 138.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10965;

  -- Deuda id=10966: AGUA 2026/05 | Monto deuda: S/18.6 | Pagado: S/28.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10966, 28.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10966;

  -- Socio: CHOQUEHUAMANI FELIX CEFERINO | Fecha: 2026-07-08 | Doc: 33496 | Total: S/ 184.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (188, 43, 184.80, 'Efectivo', '33496', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, FUMIGACION 2026/04, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=7212: LUZ 2026/03 | Monto deuda: S/17 | Pagado: S/17 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7212, 17.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7212;

  -- Deuda id=7213: AGUA 2026/03 | Monto deuda: S/57.1 | Pagado: S/57.1 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7213, 57.10);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7213;

  -- Deuda id=7210: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/20 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7210, 20.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7210;

  -- Deuda id=7214: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7214, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7214;

  -- Deuda id=7215: LUZ 2026/04 | Monto deuda: S/3.3 | Pagado: S/8.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7215, 8.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7215;

  -- Deuda id=7216: AGUA 2026/04 | Monto deuda: S/37 | Pagado: S/37 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7216, 37.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7216;

  -- Deuda id=7218: FUMIGACION 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7218, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7218;

  -- Deuda id=10970: AGUA 2026/05 | Monto deuda: S/37.3 | Pagado: S/35.4 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10970, 35.40);

  -- Socio: CHUCHULLO HACHA JOSE PEDRO | Fecha: 2026-07-04 | Doc: 33408 | Total: S/ 349.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (164, 44, 349.00, 'Efectivo', '33408', '2026-07-04T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, DEPOSITO 2 - D3 2026/05, DEPOSITO 2 - D3 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10973: LUZ 2026/05 | Monto deuda: S/43 | Pagado: S/43 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10973, 43.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10973;

  -- Deuda id=10974: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10974, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10974;

  -- Deuda id=11923: DEPOSITO 2 - D3 2026/05 | Monto deuda: S/150 | Pagado: S/150 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11923, 150.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11923;

  -- Deuda id=11607: DEPOSITO 2 - D3 2026/06 | Monto deuda: S/150 | Pagado: S/150 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11607, 150.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11607;

  -- Socio: CLEMENTE ALLER CIRILA | Fecha: 2026-07-07 | Doc: 33480 | Total: S/ 140.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (90, 45, 140.00, 'Efectivo', '33480', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10978: LUZ 2026/05 | Monto deuda: S/95 | Pagado: S/95 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10978, 95.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10978;

  -- Deuda id=11608: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/40 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11608, 40.00);

  -- Deuda id=11609: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11609, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11609;

  -- Socio: CLEMENTE ALLER CIRILA | Fecha: 2026-07-07 | Doc: 3348 | Total: S/ 6.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (90, 45, 6.00, 'Efectivo', '3348', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10979: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10979, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10979;

  -- Socio: CORDOVA PEREZ MARCO ANTONIO | Fecha: 2026-07-01 | Doc: 33365 | Total: S/ 369.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (189, 46, 369.50, 'Efectivo', '33365', '2026-07-01T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10982: LUZ 2026/05 | Monto deuda: S/43.7 | Pagado: S/43.7 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10982, 43.70);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10982;

  -- Deuda id=10983: AGUA 2026/05 | Monto deuda: S/195.8 | Pagado: S/195.8 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10983, 195.80);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10983;

  -- Deuda id=10984: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10984, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10984;

  -- Deuda id=10985: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10985, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10985;

  -- Deuda id=11610: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11610, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11610;

  -- Deuda id=11611: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11611, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11611;

  -- Socio: CORNEJO DONATO DE CORDOVA ESTELA PILAR | Fecha: 2026-07-06 | Doc: 33428 | Total: S/ 178.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (223, 47, 178.00, 'Efectivo', '33428', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=7358: LUZ 2026/03 | Monto deuda: S/18 | Pagado: S/18 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7358, 18.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7358;

  -- Deuda id=7359: AGUA 2026/03 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7359, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7359;

  -- Deuda id=7356: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/40 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7356, 40.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7356;

  -- Deuda id=7360: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7360, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7360;

  -- Deuda id=7361: LUZ 2026/04 | Monto deuda: S/17.7 | Pagado: S/17.7 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7361, 17.70);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7361;

  -- Deuda id=7362: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7362, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7362;

  -- Deuda id=7357: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/25 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7357, 25.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7357;

  -- Deuda id=7363: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7363, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7363;

  -- Deuda id=10986: LUZ 2026/05 | Monto deuda: S/19.3 | Pagado: S/19.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10986, 19.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10986;

  -- Deuda id=10987: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10987, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10987;

  -- Deuda id=10988: G. ADM 2026/05 | Monto deuda: S/25 | Pagado: S/25 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10988, 25.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10988;

  -- Deuda id=10989: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10989, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10989;

  -- Socio: CORNEJO DONATO DE CORDOVA ESTELA PILAR | Fecha: 2026-07-06 | Doc: 33429 | Total: S/ 35.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (223, 47, 35.00, 'Efectivo', '33429', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11612: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/30 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11612, 30.00);

  -- Deuda id=11613: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11613, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11613;

  -- Socio: CUCHO DE LA CRUZ SAUL PEDRO | Fecha: 2026-07-01 | Doc: 33364 | Total: S/ 71.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (271, 49, 71.20, 'Efectivo', '33364', '2026-07-01T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, LUZ 2026/06, AGUA 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=7400: LUZ 2026/03 | Monto deuda: S/8.5 | Pagado: S/8.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7400, 8.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7400;

  -- Deuda id=7401: AGUA 2026/03 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7401, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7401;

  -- Deuda id=7402: LUZ 2026/04 | Monto deuda: S/9.9 | Pagado: S/9.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7402, 9.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7402;

  -- Deuda id=7403: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7403, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7403;

  -- Deuda id=10994: LUZ 2026/05 | Monto deuda: S/9.8 | Pagado: S/9.8 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10994, 9.80);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10994;

  -- Deuda id=10995: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10995, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10995;

  -- SIN DEUDA: LUZ 2026/06 S/20 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/06 S/5 — registrado en pago pero sin monto_id

  -- Socio: CUEVAS MAYO ENRIQUE | Fecha: 2026-07-08 | Doc: 33506 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (168, 50, 65.00, 'Efectivo', '33506', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11617: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11617, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11617;

  -- Deuda id=11618: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11618, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11618;

  -- Socio: CUSI LAURA SONIA | Fecha: 2026-07-02 | Doc: 33383 | Total: S/ 32.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (249, 52, 32.50, 'Efectivo', '33383', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11006: LUZ 2026/05 | Monto deuda: S/26.5 | Pagado: S/26.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11006, 26.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11006;

  -- Deuda id=11007: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11007, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11007;

  -- Socio: DAVILA CAHUANA DE PAZ MARISOL | Fecha: 2026-07-08 | Doc: 33512 | Total: S/ 142.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (148, 54, 142.00, 'Efectivo', '33512', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=7525: LUZ 2026/04 | Monto deuda: S/65 | Pagado: S/65 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7525, 65.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7525;

  -- Deuda id=7526: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7526, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7526;

  -- Deuda id=11010: LUZ 2026/05 | Monto deuda: S/65 | Pagado: S/65 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11010, 65.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11010;

  -- Deuda id=11011: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11011, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11011;

  -- Socio: DAVILA CAHUANA DE PAZ MARISOL | Fecha: 2026-07-07 | Doc: 33485 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (148, 54, 65.00, 'Efectivo', '33485', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11012: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11012, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11012;

  -- Deuda id=11013: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11013, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11013;

  -- Socio: DAVILA CAHUANA DE PAZ MARISOL | Fecha: 2026-07-07 | Doc: 33449 | Total: S/ 200.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (148, 54, 200.00, 'Efectivo', '33449', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO 7 - D2 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11625: DEPOSITO 7 - D2 2026/06 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11625, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11625;

  -- Socio: DAVILA CAHUANA DE PAZ MARISOL | Fecha: 2026-07-08 | Doc: 33525 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (148, 54, 65.00, 'Efectivo', '33525', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11623: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11623, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11623;

  -- Deuda id=11624: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11624, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11624;

  -- Socio: ESPEJO URBANO ROSA FLORENCIA | Fecha: 2026-07-06 | Doc: 33434 | Total: S/ 179.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (106, 56, 179.00, 'Efectivo', '33434', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11019: LUZ 2026/05 | Monto deuda: S/108 | Pagado: S/108 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11019, 108.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11019;

  -- Deuda id=11020: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11020, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11020;

  -- Deuda id=11628: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11628, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11628;

  -- Deuda id=11629: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11629, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11629;

  -- Socio: ESTELA SUAREZ ELVIA | Fecha: 2026-07-02 | Doc: 33386 | Total: S/ 388.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (190, 57, 388.10, 'Efectivo', '33386', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11023: LUZ 2026/05 | Monto deuda: S/213.1 | Pagado: S/213.1 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11023, 213.10);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11023;

  -- Deuda id=11024: AGUA 2026/05 | Monto deuda: S/45 | Pagado: S/45 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11024, 45.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11024;

  -- Deuda id=11025: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11025, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11025;

  -- Deuda id=11026: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11026, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11026;

  -- Deuda id=11630: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11630, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11630;

  -- Deuda id=11631: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11631, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11631;

  -- Socio: FALCON CHIARA HECTOR MARCIAL | Fecha: 2026-07-07 | Doc: 33482 | Total: S/ 58.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (64, 59, 58.00, 'Efectivo', '33482', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11031: LUZ 2026/05 | Monto deuda: S/52 | Pagado: S/52 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11031, 52.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11031;

  -- Deuda id=11032: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11032, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11032;

  -- Socio: FLORES FLORES IRENE BERTILIA | Fecha: 2026-07-02 | Doc: 33373 | Total: S/ 64.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (247, 60, 64.30, 'Efectivo', '33373', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11636: G. ADM 2026/06 | Monto deuda: S/59.3 | Pagado: S/59.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11636, 59.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11636;

  -- Deuda id=11637: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11637, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11637;

  -- Socio: GAVILAN MOSQUERA NORMA LUZ | Fecha: 2026-07-08 | Doc: 33528 | Total: S/ 265.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (202, 63, 265.00, 'Efectivo', '33528', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03, G. ADM 2026/04, P. SOCIAL 2026/04, FUMIGACION 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=7740: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7740, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7740;

  -- Deuda id=7741: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7741, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7741;

  -- Deuda id=7742: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7742, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7742;

  -- Deuda id=7743: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7743, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7743;

  -- Deuda id=7744: FUMIGACION 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7744, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7744;

  -- Deuda id=11049: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11049, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11049;

  -- Deuda id=11050: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11050, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11050;

  -- Deuda id=11642: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11642, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11642;

  -- Deuda id=11643: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11643, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11643;

  -- Socio: GAVILAN MOSQUERA NORMA LUZ | Fecha: 2026-07-08 | Doc: 33527 | Total: S/ 240.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (202, 63, 240.20, 'Efectivo', '33527', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11047: LUZ 2026/05 | Monto deuda: S/148.3 | Pagado: S/148.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11047, 148.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11047;

  -- Deuda id=11048: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/91.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11048, 91.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11048;

  -- Socio: GELDRES REVILLA MIGUEL ANGEL | Fecha: 2026-07-08 | Doc: 33550 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (204, 64, 65.00, 'Efectivo', '33550', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11644: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11644, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11644;

  -- Deuda id=11645: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11645, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11645;

  -- Socio: GUTIERREZ CASTILLO JORGE JAIME | Fecha: 2026-07-08 | Doc: 33551 | Total: S/ 360.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (285, 65, 360.90, 'Efectivo', '33551', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11055: LUZ 2026/05 | Monto deuda: S/47.7 | Pagado: S/47.7 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11055, 47.70);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11055;

  -- Deuda id=11056: AGUA 2026/05 | Monto deuda: S/248.2 | Pagado: S/248.2 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11056, 248.20);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11056;

  -- Deuda id=11646: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11646, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11646;

  -- Deuda id=11647: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11647, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11647;

  -- Socio: GUTIERREZ CASTILLO TERESA JESUS | Fecha: 2026-07-08 | Doc: 33554 | Total: S/ 205.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (180, 66, 205.00, 'Efectivo', '33554', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/04, P. SOCIAL 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=7814: G. ADM 2026/04 | Monto deuda: S/47 | Pagado: S/47 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7814, 47.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7814;

  -- Deuda id=7815: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7815, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7815;

  -- Deuda id=7816: FUMIGACION 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7816, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 7816;

  -- Deuda id=11059: LUZ 2026/05 | Monto deuda: S/12 | Pagado: S/12 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11059, 12.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11059;

  -- Deuda id=11060: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11060, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11060;

  -- Deuda id=11061: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11061, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11061;

  -- Deuda id=11062: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11062, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11062;

  -- Deuda id=11648: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11648, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11648;

  -- Deuda id=11649: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11649, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11649;

  -- Socio: GUTIERREZ FLORES ROGER REYNAN | Fecha: 2026-07-08 | Doc: 33524 | Total: S/ 361.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (112, 68, 361.80, 'Efectivo', '33524', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11067: LUZ 2026/05 | Monto deuda: S/117 | Pagado: S/117 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11067, 117.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11067;

  -- Deuda id=11068: AGUA 2026/05 | Monto deuda: S/179.8 | Pagado: S/179.8 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11068, 179.80);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11068;

  -- Deuda id=11652: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11652, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11652;

  -- Deuda id=11653: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11653, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11653;

  -- Socio: HALIRE YUCRA JOSUE JAASIEL | Fecha: 2026-07-06 | Doc: 33447 | Total: S/ 444.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (195, 69, 444.90, 'Efectivo', '33447', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO 1 - D1 2026/04, LUZ 2026/05, AGUA 2026/05, DEPOSITO 1 - D1 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11924: DEPOSITO 1 - D1 2026/04 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11924, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11924;

  -- Deuda id=11071: LUZ 2026/05 | Monto deuda: S/28 | Pagado: S/28 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11071, 28.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11071;

  -- Deuda id=11072: AGUA 2026/05 | Monto deuda: S/16.9 | Pagado: S/16.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11072, 16.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11072;

  -- Deuda id=11075: DEPOSITO 1 - D1 2026/05 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11075, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11075;

  -- Socio: HEREDIA MUNOZ DE BRAVO MARIA | Fecha: 2026-07-08 | Doc: 33544 | Total: S/ 76.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (245, 70, 76.00, 'Efectivo', '33544', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11076: LUZ 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11076, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11076;

  -- Deuda id=11077: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11077, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11077;

  -- Deuda id=11657: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11657, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11657;

  -- Deuda id=11658: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11658, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11658;

  -- Socio: HUAMANI ROMERO DOMITILA CLEOFE | Fecha: 2026-07-07 | Doc: 33451 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (1, 72, 65.00, 'Efectivo', '33451', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11082: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11082, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11082;

  -- Deuda id=11083: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11083, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11083;

  -- Socio: HUAMANI ROMERO DOMITILA CLEOFE | Fecha: 2026-07-08 | Doc: 33510 | Total: S/ 260.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (1, 72, 260.00, 'Efectivo', '33510', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11080: LUZ 2026/05 | Monto deuda: S/189 | Pagado: S/189 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11080, 189.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11080;

  -- Deuda id=11081: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11081, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11081;

  -- Deuda id=11659: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11659, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11659;

  -- Deuda id=11660: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11660, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11660;

  -- Socio: HUASHUAYO GOMEZ EUDOSIA | Fecha: 2026-07-02 | Doc: 33376 | Total: S/ 363.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (52, 73, 363.00, 'Efectivo', '33376', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06, DEPOSITO 2 - D2 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11084: LUZ 2026/05 | Monto deuda: S/92 | Pagado: S/92 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11084, 92.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11084;

  -- Deuda id=11085: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11085, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11085;

  -- Deuda id=11661: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11661, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11661;

  -- Deuda id=11662: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11662, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11662;

  -- Deuda id=11663: DEPOSITO 2 - D2 2026/06 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11663, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11663;

  -- Socio: HUAYHUALLA DE LOPEZ DONATILA | Fecha: 2026-07-06 | Doc: 33417 | Total: S/ 173.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (208, 74, 173.10, 'Efectivo', '33417', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11089: LUZ 2026/05 | Monto deuda: S/107.5 | Pagado: S/107.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11089, 107.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11089;

  -- Deuda id=11090: AGUA 2026/05 | Monto deuda: S/65.6 | Pagado: S/65.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11090, 65.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11090;

  -- Socio: JARA ALVARES CRISTALINA | Fecha: 2026-07-06 | Doc: 33421 | Total: S/ 130.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (256, 76, 130.00, 'Efectivo', '33421', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11095: G. ADM 2026/05 | Monto deuda: S/40 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11095, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11095;

  -- Deuda id=11096: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11096, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11096;

  -- Deuda id=11666: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11666, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11666;

  -- Deuda id=11667: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11667, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11667;

  -- Socio: JARA ALVARES CRISTALINA | Fecha: 2026-07-08 | Doc: 33536 | Total: S/ 40.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (256, 76, 40.00, 'Efectivo', '33536', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/06 S/40 — registrado en pago pero sin monto_id

  -- Socio: JARA ALVAREZ MARIA CENAIDA | Fecha: 2026-07-02 | Doc: 33381 | Total: S/ 252.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (134, 77, 252.80, 'Efectivo', '33381', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06, G. ADM 2026/07, P. SOCIAL 2026/07')
  RETURNING id INTO v_pago_id;

  -- Deuda id=8078: G. ADM 2026/04 | Monto deuda: S/52.8 | Pagado: S/52.8 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8078, 52.80);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8078;

  -- Deuda id=8079: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8079, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8079;

  -- Deuda id=11099: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11099, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11099;

  -- Deuda id=11100: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11100, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11100;

  -- Deuda id=11668: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11668, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11668;

  -- Deuda id=11669: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11669, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11669;

  -- SIN DEUDA: G. ADM 2026/07 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/07 S/5 — registrado en pago pero sin monto_id

  -- Socio: JARA ALVAREZ MARIA CENAIDA | Fecha: 2026-07-06 | Doc: 33439 | Total: S/ 105.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (134, 77, 105.00, 'Efectivo', '33439', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11097: LUZ 2026/05 | Monto deuda: S/99 | Pagado: S/99 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11097, 99.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11097;

  -- Deuda id=11098: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11098, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11098;

  -- Socio: JARA ALVAREZ SANTOS PEDRO | Fecha: 2026-07-06 | Doc: 33440 | Total: S/ 195.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (183, 78, 195.40, 'Efectivo', '33440', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=8097: LUZ 2026/03 | Monto deuda: S/14.8 | Pagado: S/14.8 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8097, 14.80);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8097;

  -- Deuda id=8098: AGUA 2026/03 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8098, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8098;

  -- Deuda id=8099: LUZ 2026/04 | Monto deuda: S/14.6 | Pagado: S/14.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8099, 14.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8099;

  -- Deuda id=8100: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8100, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8100;

  -- Deuda id=8101: FUMIGACION 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8101, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8101;

  -- Deuda id=11101: LUZ 2026/05 | Monto deuda: S/13 | Pagado: S/13 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11101, 13.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11101;

  -- Deuda id=11102: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11102, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11102;

  -- Deuda id=11103: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11103, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11103;

  -- Deuda id=11104: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11104, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11104;

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: JUAREZ CUELLAR LEONOR | Fecha: 2026-07-08 | Doc: 33523 | Total: S/ 335.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (128, 79, 335.90, 'Efectivo', '33523', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11105: LUZ 2026/05 | Monto deuda: S/135 | Pagado: S/135 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11105, 135.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11105;

  -- Deuda id=11106: AGUA 2026/05 | Monto deuda: S/200.9 | Pagado: S/200.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11106, 200.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11106;

  -- Socio: JUAREZ CUELLAR LEONOR | Fecha: 2026-07-08 | Doc: 33518 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (128, 79, 65.00, 'Efectivo', '33518', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11672: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11672, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11672;

  -- Deuda id=11673: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11673, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11673;

  -- Socio: LAGOS LUNA DE LEYVA ZAIDA LUISA | Fecha: 2026-07-02 | Doc: 33366 | Total: S/ 44.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (86, 80, 44.00, 'Efectivo', '33366', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11109: LUZ 2026/05 | Monto deuda: S/38 | Pagado: S/38 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11109, 38.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11109;

  -- Deuda id=11110: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11110, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11110;

  -- Socio: LIMAS VARGAS CARMEN ROSA | Fecha: 2026-07-08 | Doc: 33556 | Total: S/ 550.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (8, 81, 550.00, 'Efectivo', '33556', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, DEPOSITO 7 - D3 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06, DEPOSITO 7 - D3 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=8172: LUZ 2026/04 | Monto deuda: S/49 | Pagado: S/49 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8172, 49.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8172;

  -- Deuda id=8173: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8173, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8173;

  -- Deuda id=11113: LUZ 2026/05 | Monto deuda: S/59 | Pagado: S/59 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11113, 59.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11113;

  -- Deuda id=11114: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11114, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11114;

  -- Deuda id=11115: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11115, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11115;

  -- Deuda id=11116: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11116, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11116;

  -- Deuda id=11931: DEPOSITO 7 - D3 2026/05 | Monto deuda: S/150 | Pagado: S/150 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11931, 150.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11931;

  -- Deuda id=11676: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11676, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11676;

  -- Deuda id=11677: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11677, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11677;

  -- Deuda id=11678: DEPOSITO 7 - D3 2026/06 | Monto deuda: S/150 | Pagado: S/150 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11678, 150.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11678;

  -- Socio: LOPEZ HUAYHUALLA NELLY NATIVIDAD | Fecha: 2026-07-07 | Doc: 33476 | Total: S/ 15.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (264, 82, 15.30, 'Efectivo', '33476', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11118: LUZ 2026/05 | Monto deuda: S/15.3 | Pagado: S/15.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11118, 15.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11118;

  -- Socio: LOPEZ HUAYHUALLA NELLY NATIVIDAD | Fecha: 2026-07-07 | Doc: 33475 | Total: S/ 17.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (264, 82, 17.00, 'Efectivo', '33475', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11119: AGUA 2026/05 | Monto deuda: S/17 | Pagado: S/17 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11119, 17.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11119;

  -- Socio: LUJAN GONZALES MARINO JUAN | Fecha: 2026-07-06 | Doc: 33418 | Total: S/ 130.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (272, 83, 130.00, 'Efectivo', '33418', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11124: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11124, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11124;

  -- Deuda id=11125: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11125, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11125;

  -- Deuda id=11681: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11681, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11681;

  -- Deuda id=11682: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11682, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11682;

  -- Socio: LUJAN GONZALES MARINO JUAN | Fecha: 2026-07-08 | Doc: 33509 | Total: S/ 123.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (272, 83, 123.50, 'Efectivo', '33509', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11122: LUZ 2026/05 | Monto deuda: S/91.8 | Pagado: S/91.8 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11122, 91.80);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11122;

  -- Deuda id=11123: AGUA 2026/05 | Monto deuda: S/31.7 | Pagado: S/31.7 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11123, 31.70);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11123;

  -- Socio: MALLQUI JULCA ALEJANDRINO TEODORO | Fecha: 2026-07-07 | Doc: 33478 | Total: S/ 65.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (286, 84, 65.30, 'Efectivo', '33478', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11126: LUZ 2026/05 | Monto deuda: S/34.3 | Pagado: S/34.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11126, 34.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11126;

  -- Deuda id=11127: AGUA 2026/05 | Monto deuda: S/31 | Pagado: S/31 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11127, 31.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11127;

  -- Socio: MALLQUI LOPEZ LIZBETH NATIVIDAD | Fecha: 2026-07-07 | Doc: 33477 | Total: S/ 198.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (225, 85, 198.90, 'Efectivo', '33477', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11130: LUZ 2026/05 | Monto deuda: S/28.6 | Pagado: S/28.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11130, 28.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11130;

  -- Deuda id=11131: AGUA 2026/05 | Monto deuda: S/40.3 | Pagado: S/40.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11131, 40.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11131;

  -- Deuda id=11132: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11132, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11132;

  -- Deuda id=11133: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11133, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11133;

  -- Deuda id=11685: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11685, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11685;

  -- Deuda id=11686: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11686, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11686;

  -- Socio: MAYTA MATOS HERMELINDA | Fecha: 2026-07-06 | Doc: 33444 | Total: S/ 100.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (184, 94, 100.00, 'Efectivo', '33444', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11135: AGUA 2026/05 | Monto deuda: S/127.6 | Pagado: S/100 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11135, 100.00);

  -- Socio: MAYTA MATOS HERMELINDA | Fecha: 2026-07-08 | Doc: 33508 | Total: S/ 199.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (184, 94, 199.70, 'Efectivo', '33508', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11134: LUZ 2026/05 | Monto deuda: S/42.1 | Pagado: S/42.1 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11134, 42.10);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11134;

  -- Deuda id=11135: AGUA 2026/05 | Monto deuda: S/127.6 | Pagado: S/27.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11135, 27.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11135;

  -- Deuda id=11136: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11136, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11136;

  -- Deuda id=11137: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11137, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11137;

  -- Deuda id=11687: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11687, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11687;

  -- Deuda id=11688: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11688, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11688;

  -- Socio: MORENO CHAVEZ RAFAEL FREDY | Fecha: 2026-07-06 | Doc: 33429 | Total: S/ 49.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (179, 100, 49.00, 'Efectivo', '33429', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11138: LUZ 2026/05 | Monto deuda: S/49 | Pagado: S/49 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11138, 49.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11138;

  -- Socio: MORENO CHAVEZ RAFAEL FREDY | Fecha: 2026-07-06 | Doc: 33423 | Total: S/ 101.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (179, 100, 101.00, 'Efectivo', '33423', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11139: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11139, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11139;

  -- Deuda id=11140: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11140, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11140;

  -- Deuda id=11141: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11141, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11141;

  -- Deuda id=11689: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/30 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11689, 30.00);

  -- Socio: MORENO CHAVEZ RAFAEL FREDY | Fecha: 2026-07-06 | Doc: 33424 | Total: S/ 35.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (179, 100, 35.00, 'Efectivo', '33424', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11689: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/30 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11689, 30.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11689;

  -- Deuda id=11690: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11690, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11690;

  -- Socio: MARIN HUAMAN DE SALAMANCA MARIA YNES | Fecha: 2026-07-08 | Doc: 33542 | Total: S/ 270.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (98, 86, 270.00, 'Efectivo', '33542', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=3112: LUZ 2026/04 | Monto deuda: S/87 | Pagado: S/87 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 3112, 87.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 3112;

  -- Deuda id=3113: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 3113, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 3113;

  -- Deuda id=11142: LUZ 2026/05 | Monto deuda: S/87 | Pagado: S/87 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11142, 87.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11142;

  -- Deuda id=11143: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11143, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11143;

  -- Deuda id=11144: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11144, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11144;

  -- Deuda id=11145: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11145, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11145;

  -- Deuda id=11691: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/19 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11691, 19.00);

  -- Socio: MARIN HUAMAN DE SALAMANCA MARIA YNES | Fecha: 2026-07-08 | Doc: 33543 | Total: S/ 46.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (98, 86, 46.00, 'Efectivo', '33543', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11691: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/41 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11691, 41.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11691;

  -- Deuda id=11692: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11692, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11692;

  -- Socio: ISIDRO MARIN CARLOS DANIEL | Fecha: 2026-07-04 | Doc: 33410 | Total: S/ 215.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (191, 75, 215.50, 'Efectivo', '33410', '2026-07-04T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11150: LUZ 2026/05 | Monto deuda: S/65.8 | Pagado: S/65.8 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11150, 65.80);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11150;

  -- Deuda id=11151: AGUA 2026/05 | Monto deuda: S/149.7 | Pagado: S/149.7 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11151, 149.70);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11151;

  -- Socio: MARIN LONDONE MARIA LUZ | Fecha: 2026-07-07 | Doc: 33490 | Total: S/ 300.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (177, 88, 300.00, 'Efectivo', '33490', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO 5 - D1 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, DEPOSITO 5 - D1 2026/04')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11932: DEPOSITO 5 - D1 2026/03 | Monto deuda: S/93.2 | Pagado: S/93.2 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11932, 93.20);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11932;

  -- Deuda id=8311: LUZ 2026/04 | Monto deuda: S/24.9 | Pagado: S/24.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8311, 24.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8311;

  -- Deuda id=8312: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8312, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8312;

  -- Deuda id=8313: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8313, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8313;

  -- Deuda id=8314: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8314, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8314;

  -- Deuda id=11933: DEPOSITO 5 - D1 2026/04 | Monto deuda: S/200 | Pagado: S/110.9 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11933, 110.90);

  -- Socio: MEDINA GUTIERREZ HONORATA | Fecha: 2026-07-08 | Doc: 33534 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (268, 95, 65.00, 'Efectivo', '33534', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11702: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11702, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11702;

  -- Deuda id=11703: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11703, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11703;

  -- Socio: MARIN ROCHA ESTEFANY JULISSA | Fecha: 2026-07-02 | Doc: 33380 | Total: S/ 112.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (221, 89, 112.90, 'Efectivo', '33380', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- Deuda id=8415: LUZ 2026/04 | Monto deuda: S/41.9 | Pagado: S/41.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8415, 41.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8415;

  -- Deuda id=8416: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8416, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8416;

  -- Deuda id=8417: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8417, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8417;

  -- Deuda id=8418: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8418, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8418;

  -- Socio: MARIN ROCHA ESTEFANY JULISSA | Fecha: 2026-07-08 | Doc: 33514 | Total: S/ 173.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (221, 89, 173.30, 'Efectivo', '33514', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11167: LUZ 2026/05 | Monto deuda: S/37.3 | Pagado: S/37.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11167, 37.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11167;

  -- Deuda id=11168: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11168, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11168;

  -- Deuda id=11169: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11169, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11169;

  -- Deuda id=11170: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11170, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11170;

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: MAYHUASCA BASTIDAS DE TORRES CLUDDY AYDE | Fecha: 2026-07-07 | Doc: 33452 | Total: S/ 433.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (230, 90, 433.50, 'Efectivo', '33452', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11171: LUZ 2026/05 | Monto deuda: S/395.8 | Pagado: S/395.8 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11171, 395.80);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11171;

  -- Deuda id=11172: AGUA 2026/05 | Monto deuda: S/37.7 | Pagado: S/37.7 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11172, 37.70);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11172;

  -- Socio: MAYHUASCA BASTIDAS ULISES | Fecha: 2026-07-07 | Doc: 33450 | Total: S/ 115.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (282, 92, 115.20, 'Efectivo', '33450', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11179: LUZ 2026/05 | Monto deuda: S/44.2 | Pagado: S/44.2 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11179, 44.20);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11179;

  -- Deuda id=11180: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11180, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11180;

  -- Deuda id=11181: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11181, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11181;

  -- Deuda id=11182: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11182, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11182;

  -- Socio: MEDINA JOTA DE CACERES VICENTA | Fecha: 2026-07-07 | Doc: 33483 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (29, 96, 65.00, 'Efectivo', '33483', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11714: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11714, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11714;

  -- Deuda id=11715: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11715, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11715;

  -- Socio: NICHO LOPEZ ESTHEPANY CARICIA | Fecha: 2026-07-08 | Doc: 33505 | Total: S/ 563.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (239, 101, 563.20, 'Efectivo', '33505', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11204: LUZ 2026/05 | Monto deuda: S/412.5 | Pagado: S/412.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11204, 412.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11204;

  -- Deuda id=11205: AGUA 2026/05 | Monto deuda: S/85.7 | Pagado: S/85.7 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11205, 85.70);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11205;

  -- Deuda id=11720: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11720, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11720;

  -- Deuda id=11721: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11721, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11721;

  -- Socio: OJEDA CAMPOS EDSON JUNIOR | Fecha: 2026-07-03 | Doc: 33397 | Total: S/ 703.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (228, 103, 703.70, 'Efectivo', '33397', '2026-07-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11212: LUZ 2026/05 | Monto deuda: S/672.9 | Pagado: S/672.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11212, 672.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11212;

  -- Deuda id=11213: AGUA 2026/05 | Monto deuda: S/30.8 | Pagado: S/30.8 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11213, 30.80);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11213;

  -- Socio: OQUENDO QUISPE JESSICA | Fecha: 2026-07-08 | Doc: 33537 | Total: S/ 101.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (267, 105, 101.00, 'Efectivo', '33537', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- Deuda id=8708: LUZ 2026/04 | Monto deuda: S/827.3 | Pagado: S/66 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8708, 66.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8708;

  -- Deuda id=8709: AGUA 2026/04 | Monto deuda: S/230.5 | Pagado: S/35 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8709, 35.00);

  -- Socio: OQUENDO QUISPE JESSICA | Fecha: 2026-07-08 | Doc: 33538 | Total: S/ 500.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (267, 105, 500.00, 'Efectivo', '33538', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=8709: AGUA 2026/04 | Monto deuda: S/230.5 | Pagado: S/189.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8709, 189.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8709;

  -- Deuda id=11220: LUZ 2026/05 | Monto deuda: S/62 | Pagado: S/62 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11220, 62.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11220;

  -- Deuda id=11221: AGUA 2026/05 | Monto deuda: S/227.5 | Pagado: S/227.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11221, 227.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11221;

  -- Deuda id=11222: G. ADM 2026/05 | Monto deuda: S/16 | Pagado: S/16 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11222, 16.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11222;

  -- Deuda id=11223: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11223, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11223;

  -- Socio: OQUENDO QUISPE MIGUEL EUFRACIO | Fecha: 2026-07-03 | Doc: 33399 | Total: S/ 454.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (241, 106, 454.40, 'Efectivo', '33399', '2026-07-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11224: LUZ 2026/05 | Monto deuda: S/448.4 | Pagado: S/448.4 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11224, 448.40);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11224;

  -- Deuda id=11225: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11225, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11225;

  -- Socio: PACOMPIA CARDENA GIOVANNI | Fecha: 2026-07-06 | Doc: 33425 | Total: S/ 32.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (94, 109, 32.00, 'Efectivo', '33425', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11232: LUZ 2026/05 | Monto deuda: S/26 | Pagado: S/26 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11232, 26.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11232;

  -- Deuda id=11233: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11233, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11233;

  -- Socio: PACOMPIA CARDENA GIOVANNI | Fecha: 2026-07-02 | Doc: 33369 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (94, 109, 65.00, 'Efectivo', '33369', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11734: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11734, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11734;

  -- Deuda id=11735: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11735, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11735;

  -- Socio: PALOMINO HANCCO CECILIA | Fecha: 2026-07-07 | Doc: 33470 | Total: S/ 379.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (259, 110, 379.90, 'Efectivo', '33470', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11236: LUZ 2026/05 | Monto deuda: S/290.6 | Pagado: S/290.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11236, 290.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11236;

  -- Deuda id=11237: AGUA 2026/05 | Monto deuda: S/89.3 | Pagado: S/89.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11237, 89.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11237;

  -- Socio: PALOMINO TENORIO SILVIO EDUARDO | Fecha: 2026-07-08 | Doc: 33521 | Total: S/ 329.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (288, 111, 329.00, 'Efectivo', '33521', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03, DEPOSITO 4 - D2 2026/03, G. ADM 2026/04, P. SOCIAL 2026/04, DEPOSITO 4 - D2 2026/04, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, DEPOSITO 4 - D2 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=8790: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/34 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8790, 34.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8790;

  -- Deuda id=8797: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8797, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8797;

  -- SIN DEUDA: DEPOSITO 4 - D2 2026/03 S/109 — registrado en pago pero sin monto_id

  -- Deuda id=8794: G. ADM 2026/04 | Monto deuda: S/108 | Pagado: S/12 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8794, 12.00);

  -- Deuda id=8799: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8799, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8799;

  -- Deuda id=11939: DEPOSITO 4 - D2 2026/04 | Monto deuda: S/93 | Pagado: S/32 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11939, 32.00);

  -- Deuda id=11241: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/2 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11241, 2.00);

  -- Deuda id=11242: G. ADM 2026/05 | Monto deuda: S/30 | Pagado: S/30 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11242, 30.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11242;

  -- Deuda id=11243: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11243, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11243;

  -- Deuda id=11940: DEPOSITO 4 - D2 2026/05 | Monto deuda: S/95 | Pagado: S/95 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11940, 95.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11940;

  -- Socio: PALOMINO TENORIO SILVIO EDUARDO | Fecha: 2026-07-08 | Doc: 33522 | Total: S/ 94.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (288, 111, 94.00, 'Efectivo', '33522', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06, DEPOSITO 4 - D2 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11738: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/22 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11738, 22.00);

  -- Deuda id=11739: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11739, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11739;

  -- Deuda id=11740: DEPOSITO 4 - D2 2026/06 | Monto deuda: S/200 | Pagado: S/67 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11740, 67.00);

  -- Socio: PAREDES FLORES OSCAR ALFREDO | Fecha: 2026-07-06 | Doc: 33441 | Total: S/ 151.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (140, 113, 151.00, 'Efectivo', '33441', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- Deuda id=8835: LUZ 2026/04 | Monto deuda: S/145 | Pagado: S/145 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8835, 145.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8835;

  -- Deuda id=8836: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8836, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8836;

  -- Socio: PAREDES FLORES OSCAR ALFREDO | Fecha: 2026-07-08 | Doc: 33552 | Total: S/ 161.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (140, 113, 161.00, 'Efectivo', '33552', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11249: LUZ 2026/05 | Monto deuda: S/155 | Pagado: S/155 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11249, 155.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11249;

  -- Deuda id=11250: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11250, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11250;

  -- Socio: PAREDES FLORES OSCAR ALFREDO | Fecha: 2026-07-01 | Doc: 33351 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (140, 113, 65.00, 'Efectivo', '33351', '2026-07-01T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11743: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11743, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11743;

  -- Deuda id=11744: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11744, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11744;

  -- Socio: PAREDES MORALES DIANA VONNETH | Fecha: 2026-07-07 | Doc: 33475 | Total: S/ 235.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (74, 114, 235.00, 'Efectivo', '33475', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11253: LUZ 2026/05 | Monto deuda: S/99 | Pagado: S/99 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11253, 99.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11253;

  -- Deuda id=11254: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11254, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11254;

  -- Deuda id=11255: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11255, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11255;

  -- Deuda id=11256: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11256, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11256;

  -- Deuda id=11745: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11745, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11745;

  -- Deuda id=11746: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11746, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11746;

  -- Socio: PAREDES MORALES OSCAR MARTIN | Fecha: 2026-07-08 | Doc: 33531 | Total: S/ 360.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (92, 115, 360.00, 'Efectivo', '33531', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10732: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10732, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10732;

  -- Deuda id=10733: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10733, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10733;

  -- Deuda id=10734: LUZ 2026/04 | Monto deuda: S/82 | Pagado: S/82 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10734, 82.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10734;

  -- Deuda id=10735: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10735, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10735;

  -- Deuda id=10736: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10736, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10736;

  -- Deuda id=10737: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10737, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10737;

  -- Deuda id=11257: LUZ 2026/05 | Monto deuda: S/82 | Pagado: S/82 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11257, 82.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11257;

  -- Deuda id=11258: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11258, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11258;

  -- Deuda id=11259: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/54 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11259, 54.00);

  -- Socio: PAREDES MORALES OSCAR MARTIN | Fecha: 2026-07-08 | Doc: 33553 | Total: S/ 76.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (92, 115, 76.00, 'Efectivo', '33553', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11259: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11259, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11259;

  -- Deuda id=11260: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11260, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11260;

  -- Deuda id=11747: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11747, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11747;

  -- Deuda id=11748: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11748, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11748;

  -- Socio: PEREZ PONCE DE ROMERO SATURNINA MARGARITA | Fecha: 2026-07-08 | Doc: 33533 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (281, 116, 65.00, 'Efectivo', '33533', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11749: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11749, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11749;

  -- Deuda id=11750: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11750, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11750;

  -- Socio: PEREZ QUISPE EPIFANIA RICARDINA | Fecha: 2026-07-07 | Doc: 33465 | Total: S/ 195.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (114, 117, 195.00, 'Efectivo', '33465', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/04, p. SOCIAL 2026/04, G. ADM 2026/04, p. SOCIAL 2026/04, G. ADM 2026/04, p. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- Deuda id=8925: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8925, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8925;

  -- Deuda id=8926: p. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8926, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8926;

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: p. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: p. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: PEREZ QUISPE EPIFANIA RICARDINA | Fecha: 2026-07-07 | Doc: 33464 | Total: S/ 46.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (114, 117, 46.00, 'Efectivo', '33464', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11265: LUZ 2026/05 | Monto deuda: S/40 | Pagado: S/40 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11265, 40.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11265;

  -- Deuda id=11266: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11266, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11266;

  -- Socio: PITTMAN CONCEPCION NELLY MARIA | Fecha: 2026-07-01 | Doc: 33352 | Total: S/ 260.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (102, 118, 260.00, 'Efectivo', '33352', '2026-07-01T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=8947: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8947, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8947;

  -- Deuda id=8948: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8948, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8948;

  -- Deuda id=8951: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8951, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8951;

  -- Deuda id=8952: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8952, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8952;

  -- Deuda id=11271: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11271, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11271;

  -- Deuda id=11272: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11272, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11272;

  -- Deuda id=11753: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11753, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11753;

  -- Deuda id=11754: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11754, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11754;

  -- Socio: PITTMAN CONCEPCION NELLY MARIA | Fecha: 2026-07-08 | Doc: 33500 | Total: S/ 51.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (102, 118, 51.00, 'Efectivo', '33500', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11269: LUZ 2026/05 | Monto deuda: S/45 | Pagado: S/45 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11269, 45.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11269;

  -- Deuda id=11270: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11270, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11270;

  -- Socio: QUINTANA VIDAL GLICERIO | Fecha: 2026-07-08 | Doc: 33517 | Total: S/ 130.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (192, 122, 130.00, 'Efectivo', '33517', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11287: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11287, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11287;

  -- Deuda id=11288: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11288, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11288;

  -- Deuda id=11761: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11761, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11761;

  -- Deuda id=11762: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11762, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11762;

  -- Socio: QUISPE AGUILAR DE PALOMINO DOROTEA | Fecha: 2026-07-07 | Doc: 33489 | Total: S/ 341.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (227, 126, 341.90, 'Efectivo', '33489', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11289: LUZ 2026/05 | Monto deuda: S/335.9 | Pagado: S/335.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11289, 335.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11289;

  -- Deuda id=11290: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11290, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11290;

  -- Socio: QUISPE CONSA MIGUEL | Fecha: 2026-07-08 | Doc: 33529 | Total: S/ 500.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (210, 123, 500.00, 'Efectivo', '33529', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/06 S/500 — registrado en pago pero sin monto_id

  -- Socio: QUISPE CONSA VIDAL | Fecha: 2026-07-02 | Doc: 33385 | Total: S/ 651.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (186, 124, 651.20, 'Efectivo', '33385', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11297: LUZ 2026/05 | Monto deuda: S/503.3 | Pagado: S/503.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11297, 503.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11297;

  -- Deuda id=11298: AGUA 2026/05 | Monto deuda: S/17.9 | Pagado: S/17.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11298, 17.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11298;

  -- Deuda id=11299: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11299, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11299;

  -- Deuda id=11300: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11300, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11300;

  -- Deuda id=11767: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11767, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11767;

  -- Deuda id=11768: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11768, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11768;

  -- Socio: QUISPE DURAN ADRIANA | Fecha: 2026-07-03 | Doc: 33398 | Total: S/ 587.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (252, 127, 587.50, 'Efectivo', '33398', '2026-07-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11305: LUZ 2026/05 | Monto deuda: S/439 | Pagado: S/439 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11305, 439.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11305;

  -- Deuda id=11306: AGUA 2026/05 | Monto deuda: S/148.5 | Pagado: S/148.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11306, 148.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11306;

  -- Socio: QUISPE ORTEGA ROSA CARMEN | Fecha: 2026-07-06 | Doc: 33426 | Total: S/ 421.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (269, 128, 421.40, 'Efectivo', '33426', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11309: LUZ 2026/05 | Monto deuda: S/410.7 | Pagado: S/410.7 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11309, 410.70);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11309;

  -- Deuda id=11310: AGUA 2026/05 | Monto deuda: S/10.7 | Pagado: S/10.7 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11310, 10.70);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11310;

  -- Socio: RAMOS CUEVA PEDRO RAUL | Fecha: 2026-07-02 | Doc: 33389 | Total: S/ 300.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (226, 130, 300.00, 'Efectivo', '33389', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9222: LUZ 2026/04 | Monto deuda: S/27.9 | Pagado: S/27.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9222, 27.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9222;

  -- Deuda id=9223: AGUA 2026/04 | Monto deuda: S/118.3 | Pagado: S/118.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9223, 118.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9223;

  -- Deuda id=9224: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9224, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9224;

  -- Deuda id=9225: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9225, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9225;

  -- Deuda id=9226: FUMIGACION 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9226, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9226;

  -- Deuda id=11317: LUZ 2026/05 | Monto deuda: S/26.3 | Pagado: S/26.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11317, 26.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11317;

  -- Deuda id=11318: AGUA 2026/05 | Monto deuda: S/129.4 | Pagado: S/57.5 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11318, 57.50);

  -- Socio: RAMOS CUEVA PEDRO RAUL | Fecha: 2026-07-02 | Doc: 33390 | Total: S/ 201.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (226, 130, 201.90, 'Efectivo', '33390', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11318: AGUA 2026/05 | Monto deuda: S/129.4 | Pagado: S/71.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11318, 71.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11318;

  -- Deuda id=11319: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11319, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11319;

  -- Deuda id=11320: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11320, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11320;

  -- Deuda id=11777: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11777, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11777;

  -- Deuda id=11778: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11778, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11778;

  -- Socio: REYES PEREZ DE VALENCIA NANCY VICTORIA | Fecha: 2026-07-06 | Doc: 33435 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (222, 131, 65.00, 'Efectivo', '33435', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11779: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11779, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11779;

  -- Deuda id=11780: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11780, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11780;

  -- Socio: RICSE SAYES TERESA REINA | Fecha: 2026-07-08 | Doc: 33548 | Total: S/ 260.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (231, 133, 260.00, 'Efectivo', '33548', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9293: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9293, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9293;

  -- Deuda id=9294: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9294, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9294;

  -- Deuda id=9297: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9297, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9297;

  -- Deuda id=9298: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9298, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9298;

  -- Deuda id=11331: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11331, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11331;

  -- Deuda id=11332: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11332, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11332;

  -- Deuda id=11783: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11783, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11783;

  -- Deuda id=11784: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11784, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11784;

  -- Socio: RICSE SAYES TERESA REINA | Fecha: 2026-07-03 | Doc: 33401 | Total: S/ 50.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (231, 133, 50.00, 'Efectivo', '33401', '2026-07-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11329: LUZ 2026/05 | Monto deuda: S/60.7 | Pagado: S/50 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11329, 50.00);

  -- Socio: RICSE SAYES TERESA REINA | Fecha: 2026-07-03 | Doc: 33402 | Total: S/ 17.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (231, 133, 17.20, 'Efectivo', '33402', '2026-07-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11329: LUZ 2026/05 | Monto deuda: S/60.7 | Pagado: S/10.7 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11329, 10.70);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11329;

  -- Deuda id=11330: AGUA 2026/05 | Monto deuda: S/6.5 | Pagado: S/6.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11330, 6.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11330;

  -- Socio: RIVERA CALLPA JUANA REGIS | Fecha: 2026-07-02 | Doc: 33372 | Total: S/ 82.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (166, 134, 82.00, 'Efectivo', '33372', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9325: LUZ 2026/04 | Monto deuda: S/35 | Pagado: S/35 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9325, 35.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9325;

  -- Deuda id=9326: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9326, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9326;

  -- Deuda id=11333: LUZ 2026/05 | Monto deuda: S/35 | Pagado: S/35 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11333, 35.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11333;

  -- Deuda id=11334: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11334, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11334;

  -- Socio: RODRIGUEZ ARQUINEGO IDILIO FELIX | Fecha: 2026-07-03 | Doc: 33395 | Total: S/ 325.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (136, 136, 325.00, 'Efectivo', '33395', '2026-07-03T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06, G. ADM 2026/07, P. SOCIAL 2026/07')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9372: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9372, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9372;

  -- Deuda id=9373: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9373, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9373;

  -- Deuda id=9374: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9374, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9374;

  -- Deuda id=9375: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9375, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9375;

  -- Deuda id=11343: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11343, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11343;

  -- Deuda id=11344: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11344, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11344;

  -- Deuda id=11787: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11787, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11787;

  -- Deuda id=11788: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11788, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11788;

  -- SIN DEUDA: G. ADM 2026/07 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/07 S/5 — registrado en pago pero sin monto_id

  -- Socio: RODRIGUEZ ARQUINEGO IDILIO FELIX | Fecha: 2026-07-06 | Doc: 33438 | Total: S/ 28.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (136, 136, 28.00, 'Efectivo', '33438', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11341: LUZ 2026/05 | Monto deuda: S/22 | Pagado: S/22 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11341, 22.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11341;

  -- Deuda id=11342: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11342, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11342;

  -- Socio: RODRIGUEZ CORDOVA MARCOS | Fecha: 2026-07-07 | Doc: 33486 | Total: S/ 170.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (234, 137, 170.00, 'Efectivo', '33486', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P 2026/03, LUZ 2026/04, AGUA 2026/04, P 2026/04, LUZ 2026/05, AGUA 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9393: LUZ 2026/03 | Monto deuda: S/24.2 | Pagado: S/24.2 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9393, 24.20);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9393;

  -- Deuda id=9394: AGUA 2026/03 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9394, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9394;

  -- Deuda id=9395: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9395, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9395;

  -- Deuda id=9396: P 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9396, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9396;

  -- Deuda id=9397: LUZ 2026/04 | Monto deuda: S/25.2 | Pagado: S/25.2 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9397, 25.20);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9397;

  -- Deuda id=9398: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9398, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9398;

  -- Deuda id=9399: P 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9399, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9399;

  -- Deuda id=11345: LUZ 2026/05 | Monto deuda: S/25.4 | Pagado: S/25.4 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11345, 25.40);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11345;

  -- Deuda id=11346: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11346, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11346;

  -- Deuda id=11348: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11348, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11348;

  -- Deuda id=11789: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/2.2 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11789, 2.20);

  -- Socio: RODRIGUEZ CORDOVA MARCOS | Fecha: 2026-07-07 | Doc: 33487 | Total: S/ 32.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (234, 137, 32.80, 'Efectivo', '33487', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11789: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/27.8 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11789, 27.80);

  -- Deuda id=11790: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11790, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11790;

  -- Socio: ROJAS CORNEJO ERICK JOHN | Fecha: 2026-07-01 | Doc: 33361 | Total: S/ 122.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (194, 139, 122.70, 'Efectivo', '33361', '2026-07-01T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9445: LUZ 2026/04 | Monto deuda: S/29.6 | Pagado: S/10.7 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9445, 10.70);

  -- Deuda id=11353: LUZ 2026/05 | Monto deuda: S/48.4 | Pagado: S/48.4 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11353, 48.40);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11353;

  -- Deuda id=11354: AGUA 2026/05 | Monto deuda: S/23.6 | Pagado: S/23.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11354, 23.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11354;

  -- Deuda id=11355: G. ADM 2026/05 | Monto deuda: S/30 | Pagado: S/30 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11355, 30.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11355;

  -- Deuda id=11356: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11356, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11356;

  -- Deuda id=11794: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11794, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11794;

  -- Socio: ROMERO FLORES EDDNA | Fecha: 2026-07-03 | Doc: 33391 | Total: S/ 343.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (246, 141, 343.00, 'Efectivo', '33391', '2026-07-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11357: LUZ 2026/05 | Monto deuda: S/286.6 | Pagado: S/286.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11357, 286.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11357;

  -- Deuda id=11358: AGUA 2026/05 | Monto deuda: S/51.4 | Pagado: S/51.4 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11358, 51.40);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11358;

  -- Deuda id=11796: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11796, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11796;

  -- Socio: SALAS MONTALVO JUDITH MAGALI | Fecha: 2026-07-03 | Doc: 33396 | Total: S/ 387.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (110, 145, 387.90, 'Efectivo', '33396', '2026-07-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11361: LUZ 2026/05 | Monto deuda: S/99 | Pagado: S/99 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11361, 99.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11361;

  -- Deuda id=11362: AGUA 2026/05 | Monto deuda: S/288.9 | Pagado: S/288.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11362, 288.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11362;

  -- Socio: ROJAS IGNACIO LIONILA JULIA | Fecha: 2026-07-01 | Doc: 33355 | Total: S/ 183.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (116, 140, 183.00, 'Efectivo', '33355', '2026-07-01T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9536: LUZ 2026/04 | Monto deuda: S/105 | Pagado: S/105 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9536, 105.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9536;

  -- Deuda id=9537: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9537, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9537;

  -- Deuda id=11365: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/72 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11365, 72.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11365;

  -- Socio: ROMERO NINAHUAMAN JAVIER JOHNNY | Fecha: 2026-07-07 | Doc: 33473 | Total: S/ 260.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (15, 142, 260.00, 'Efectivo', '33473', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9559: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9559, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9559;

  -- Deuda id=9560: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9560, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9560;

  -- SIN DEUDA: G. ADM 2026/03 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- Socio: ROMERO NINAHUAMAN JAVIER JOHNNY | Fecha: 2026-07-01 | Doc: 33359 | Total: S/ 61.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (15, 142, 61.00, 'Efectivo', '33359', '2026-07-01T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11949: LUZ 2026/05 | Monto deuda: S/55 | Pagado: S/55 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11949, 55.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11949;

  -- Deuda id=11368: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11368, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11368;

  -- Socio: ROMERO YSLA ESTEBAN LIDIO | Fecha: 2026-07-01 | Doc: 33363 | Total: S/ 333.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (251, 143, 333.00, 'Efectivo', '33363', '2026-07-01T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11950: LUZ 2026/05 | Monto deuda: S/298 | Pagado: S/298 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11950, 298.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11950;

  -- Deuda id=11371: AGUA 2026/05 | Monto deuda: S/35 | Pagado: S/35 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11371, 35.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11371;

  -- Socio: SAAVEDRA CURIPUMA LUIS HUMBERTO | Fecha: 2026-07-08 | Doc: 33545 | Total: S/ 110.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (120, 144, 110.00, 'Efectivo', '33545', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11951: LUZ 2026/05 | Monto deuda: S/47 | Pagado: S/47 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11951, 47.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11951;

  -- Deuda id=11374: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11374, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11374;

  -- Deuda id=11803: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/52 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11803, 52.00);

  -- Deuda id=11804: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11804, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11804;

  -- Socio: SALAS MONTALVO RUTH YOVANNA | Fecha: 2026-07-07 | Doc: 33473 | Total: S/ 260.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (36, 146, 260.00, 'Efectivo', '33473', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9628: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9628, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9628;

  -- Deuda id=9629: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9629, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9629;

  -- Deuda id=9632: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9632, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9632;

  -- Deuda id=9633: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9633, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9633;

  -- Deuda id=11378: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11378, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11378;

  -- Deuda id=11379: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11379, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11379;

  -- Deuda id=11805: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11805, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11805;

  -- Deuda id=11806: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11806, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11806;

  -- Socio: SALAS MONTALVO RUTH YOVANNA | Fecha: 2026-07-01 | Doc: 33360 | Total: S/ 71.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (36, 146, 71.00, 'Efectivo', '33360', '2026-07-01T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11952: LUZ 2026/05 | Monto deuda: S/65 | Pagado: S/65 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11952, 65.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11952;

  -- Deuda id=11377: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11377, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11377;

  -- Socio: SALAZAR CONCEPCION VICTORIA | Fecha: 2026-07-02 | Doc: 33387 | Total: S/ 18.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (197, 147, 18.30, 'Efectivo', '33387', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11953: LUZ 2026/05 | Monto deuda: S/12.3 | Pagado: S/12.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11953, 12.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11953;

  -- Deuda id=11380: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11380, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11380;

  -- Socio: SALAZAR CONCEPCION VICTORIA | Fecha: 2026-07-02 | Doc: 33388 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (197, 147, 65.00, 'Efectivo', '33388', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11807: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11807, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11807;

  -- Deuda id=11808: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11808, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11808;

  -- Socio: SALVATIERRA OQUENDO ALLISON ADRIANA | Fecha: 2026-07-08 | Doc: 33557 | Total: S/ 275.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (243, 148, 275.40, 'Efectivo', '33557', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11954: LUZ 2026/05 | Monto deuda: S/72.3 | Pagado: S/72.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11954, 72.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11954;

  -- Deuda id=11383: AGUA 2026/05 | Monto deuda: S/203.1 | Pagado: S/203.1 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11383, 203.10);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11383;

  -- Socio: SANCHEZ RODRIGUEZ JUDITH IRIS | Fecha: 2026-07-07 | Doc: 33463 | Total: S/ 260.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (284, 150, 260.00, 'Efectivo', '33463', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9724: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9724, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9724;

  -- Deuda id=9725: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9725, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9725;

  -- Deuda id=9728: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9728, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9728;

  -- Deuda id=9729: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9729, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9729;

  -- Deuda id=11387: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11387, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11387;

  -- Deuda id=11388: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11388, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11388;

  -- Deuda id=11811: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11811, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11811;

  -- Deuda id=11812: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11812, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11812;

  -- Socio: SANCHEZ RODRIGUEZ JUDITH IRIS | Fecha: 2026-07-07 | Doc: 33469 | Total: S/ 150.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (284, 150, 150.70, 'Efectivo', '33469', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: AGUA 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: AGUA 2026/04 S/23.6 — registrado en pago pero sin monto_id

  -- Deuda id=9730: FUMIGACION 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9730, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9730;

  -- Deuda id=11955: LUZ 2026/05 | Monto deuda: S/57.5 | Pagado: S/57.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11955, 57.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11955;

  -- Deuda id=11386: AGUA 2026/05 | Monto deuda: S/64.6 | Pagado: S/64.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11386, 64.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11386;

  -- Socio: SANTILLAN MESIA ZOILA MARIBEL | Fecha: 2026-07-06 | Doc: 33427 | Total: S/ 140.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (219, 152, 140.00, 'Efectivo', '33427', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9774: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/40 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9774, 40.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9774;

  -- Deuda id=9778: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9778, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9778;

  -- Deuda id=9775: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/25 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9775, 25.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9775;

  -- Deuda id=9781: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9781, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9781;

  -- Deuda id=11396: G. ADM 2026/05 | Monto deuda: S/25 | Pagado: S/25 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11396, 25.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11396;

  -- Deuda id=11397: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11397, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11397;

  -- Deuda id=11817: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/30 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11817, 30.00);

  -- Deuda id=11818: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11818, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11818;

  -- Socio: SANTILLAN MESIA ZOILA MARIBEL | Fecha: 2026-07-06 | Doc: 33430 | Total: S/ 175.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (219, 152, 175.70, 'Efectivo', '33430', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9776: LUZ 2026/03 | Monto deuda: S/56.6 | Pagado: S/56.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9776, 56.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9776;

  -- Deuda id=9777: AGUA 2026/03 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9777, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9777;

  -- Deuda id=9779: LUZ 2026/04 | Monto deuda: S/56.1 | Pagado: S/56.1 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9779, 56.10);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9779;

  -- Deuda id=9780: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9780, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9780;

  -- Deuda id=11957: LUZ 2026/05 | Monto deuda: S/45 | Pagado: S/45 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11957, 45.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11957;

  -- Deuda id=11395: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11395, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11395;

  -- Socio: SEGOVIA VILLAFUERTE DE PONCE JUSTINA | Fecha: 2026-07-08 | Doc: 33501 | Total: S/ 102.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (104, 153, 102.00, 'Efectivo', '33501', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9802: LUZ 2026/03 | Monto deuda: S/30 | Pagado: S/30 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9802, 30.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9802;

  -- Deuda id=9803: AGUA 2026/03 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9803, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9803;

  -- Deuda id=9804: LUZ 2026/04 | Monto deuda: S/20 | Pagado: S/20 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9804, 20.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9804;

  -- Deuda id=9805: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9805, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9805;

  -- Deuda id=9806: FUMIGACION 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9806, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9806;

  -- Deuda id=11958: LUZ 2026/05 | Monto deuda: S/29 | Pagado: S/29 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11958, 29.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11958;

  -- Deuda id=11398: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11398, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11398;

  -- Socio: SEGOVIA VILLAFUERTE DE PONCE JUSTINA | Fecha: 2026-07-08 | Doc: 33502 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (104, 153, 65.00, 'Efectivo', '33502', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11819: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11819, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11819;

  -- Deuda id=11820: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11820, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11820;

  -- Socio: SERMENO GUTIERREZ JAVIER YGNACIO | Fecha: 2026-07-07 | Doc: 33468 | Total: S/ 405.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (76, 154, 405.00, 'Efectivo', '33468', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11959: LUZ 2026/05 | Monto deuda: S/390 | Pagado: S/390 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11959, 390.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11959;

  -- Deuda id=11401: AGUA 2026/05 | Monto deuda: S/15 | Pagado: S/15 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11401, 15.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11401;

  -- Socio: SORIA TAPIA EDITH CATALINA | Fecha: 2026-07-01 | Doc: 33353 | Total: S/ 224.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (165, 155, 224.10, 'Efectivo', '33353', '2026-07-01T12:00:00+00:00', 'Pago 01-08 jul 2026: P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9842: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/4.1 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9842, 4.10);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9842;

  -- Deuda id=9843: LUZ 2026/04 | Monto deuda: S/39 | Pagado: S/39 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9843, 39.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9843;

  -- Deuda id=9844: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9844, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9844;

  -- Deuda id=9845: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9845, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9845;

  -- Deuda id=9846: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9846, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9846;

  -- Deuda id=11960: LUZ 2026/05 | Monto deuda: S/39 | Pagado: S/39 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11960, 39.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11960;

  -- Deuda id=11404: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11404, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11404;

  -- Deuda id=11405: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11405, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11405;

  -- Deuda id=11406: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11406, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11406;

  -- Socio: SORIA TAPIA EDITH CATALINA | Fecha: 2026-07-03 | Doc: 33393 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (165, 155, 65.00, 'Efectivo', '33393', '2026-07-03T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11823: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11823, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11823;

  -- Deuda id=11824: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11824, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11824;

  -- Socio: SOSA VALDIVIA JUANA ISABEL | Fecha: 2026-07-07 | Doc: 33484 | Total: S/ 42.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (22, 156, 42.00, 'Efectivo', '33484', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9882: LUZ 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9882, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9882;

  -- Deuda id=9883: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9883, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9883;

  -- Deuda id=11961: LUZ 2026/05 | Monto deuda: S/25 | Pagado: S/25 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11961, 25.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11961;

  -- Deuda id=11407: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11407, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11407;

  -- Socio: SOTO VARGAS DE FLORES MARIA DEL CARMEN | Fecha: 2026-07-07 | Doc: 33458 | Total: S/ 13.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (193, 158, 13.40, 'Efectivo', '33458', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11962: LUZ 2026/05 | Monto deuda: S/7.4 | Pagado: S/7.4 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11962, 7.40);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11962;

  -- Deuda id=11414: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11414, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11414;

  -- Socio: ORDONEZ NICHO AZUL CARILE | Fecha: 2026-07-07 | Doc: 33488 | Total: S/ 112.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (276, 107, 112.90, 'Efectivo', '33488', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11963: LUZ 2026/05 | Monto deuda: S/106.9 | Pagado: S/106.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11963, 106.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11963;

  -- Deuda id=11417: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11417, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11417;

  -- Socio: TELLO ALVAREZ MARINO | Fecha: 2026-07-02 | Doc: 33367 | Total: S/ 216.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (122, 160, 216.00, 'Efectivo', '33367', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9977: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9977, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9977;

  -- Deuda id=9978: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9978, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9978;

  -- Deuda id=9979: LUZ 2026/04 | Monto deuda: S/80 | Pagado: S/80 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9979, 80.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9979;

  -- Deuda id=9980: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9980, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9980;

  -- Deuda id=9981: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9981, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9981;

  -- Deuda id=9982: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9982, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9982;

  -- Socio: TELLO ALVAREZ MARINO | Fecha: 2026-07-08 | Doc: 33520 | Total: S/ 240.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (122, 160, 240.50, 'Efectivo', '33520', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9983: FUMIGACION 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9983, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9983;

  -- Deuda id=11965: LUZ 2026/05 | Monto deuda: S/99.5 | Pagado: S/99.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11965, 99.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11965;

  -- Deuda id=11423: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11423, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11423;

  -- Deuda id=11424: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11424, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11424;

  -- Deuda id=11425: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11425, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11425;

  -- Deuda id=11833: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11833, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11833;

  -- Deuda id=11834: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11834, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11834;

  -- Socio: TELLO QUINTANA EDGAR ERASMO | Fecha: 2026-07-08 | Doc: 33495 | Total: S/ 847.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (182, 161, 847.70, 'Efectivo', '33495', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, LUZ 2026/06, AGUA 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9998: LUZ 2026/04 | Monto deuda: S/176.1 | Pagado: S/176.1 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9998, 176.10);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9998;

  -- Deuda id=9999: AGUA 2026/04 | Monto deuda: S/71.9 | Pagado: S/71.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9999, 71.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9999;

  -- Deuda id=10000: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10000, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10000;

  -- Deuda id=10001: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10001, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10001;

  -- Deuda id=11966: LUZ 2026/05 | Monto deuda: S/134.2 | Pagado: S/134.2 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11966, 134.20);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11966;

  -- Deuda id=11426: AGUA 2026/05 | Monto deuda: S/270.5 | Pagado: S/270.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11426, 270.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11426;

  -- Deuda id=11427: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11427, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11427;

  -- Deuda id=11428: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11428, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11428;

  -- SIN DEUDA: LUZ 2026/06 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/06 S/5 — registrado en pago pero sin monto_id

  -- Socio: TINEO CABRERA SONIA | Fecha: 2026-07-08 | Doc: 33546 | Total: S/ 64.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (207, 162, 64.20, 'Efectivo', '33546', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11967: LUZ 2026/05 | Monto deuda: S/33 | Pagado: S/33 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11967, 33.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11967;

  -- Deuda id=11429: AGUA 2026/05 | Monto deuda: S/31.2 | Pagado: S/31.2 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11429, 31.20);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11429;

  -- Socio: TITO FALCON JESUSA RICARDINA | Fecha: 2026-07-01 | Doc: 33350 | Total: S/ 297.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (200, 164, 297.70, 'Efectivo', '33350', '2026-07-01T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/219 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/78.7 — registrado en pago pero sin monto_id

  -- Socio: TORRES ASTO SANTOS NERY F | Fecha: 2026-07-08 | Doc: 33499 | Total: S/ 114.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (232, 167, 114.80, 'Efectivo', '33499', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=5779: LUZ 2026/04 | Monto deuda: S/31.6 | Pagado: S/31.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 5779, 31.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 5779;

  -- Deuda id=5780: AGUA 2026/04 | Monto deuda: S/26.7 | Pagado: S/26.7 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 5780, 26.70);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 5780;

  -- Deuda id=12001: LUZ 2026/05 | Monto deuda: S/31.8 | Pagado: S/31.8 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12001, 31.80);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 12001;

  -- Deuda id=11445: AGUA 2026/05 | Monto deuda: S/24.7 | Pagado: S/24.7 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11445, 24.70);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11445;

  -- Socio: URETA CRUZ EMILIA | Fecha: 2026-07-08 | Doc: 33494 | Total: S/ 181.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (48, 169, 181.90, 'Efectivo', '33494', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=12014: LUZ 2026/05 | Monto deuda: S/89 | Pagado: S/89 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12014, 89.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 12014;

  -- Deuda id=11451: AGUA 2026/05 | Monto deuda: S/27.9 | Pagado: S/27.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11451, 27.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11451;

  -- Deuda id=11850: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11850, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11850;

  -- Deuda id=11851: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11851, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11851;

  -- Socio: VALENCIA TOMAS VICENTE DORIS | Fecha: 2026-07-01 | Doc: 33357 | Total: S/ 529.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (211, 170, 529.50, 'Efectivo', '33357', '2026-07-01T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=12015: LUZ 2026/05 | Monto deuda: S/517.1 | Pagado: S/517.1 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12015, 517.10);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 12015;

  -- Deuda id=11454: AGUA 2026/05 | Monto deuda: S/12.4 | Pagado: S/12.4 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11454, 12.40);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11454;

  -- Socio: VALERO PARIONA MAXIMO ALBINO | Fecha: 2026-07-07 | Doc: 33459 | Total: S/ 15.60
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (78, 171, 15.60, 'Efectivo', '33459', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=12016: LUZ 2026/05 | Monto deuda: S/150 | Pagado: S/9.6 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12016, 9.60);

  -- Deuda id=11457: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11457, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11457;

  -- Socio: VALERO SOTO MAXIMO ELIAS | Fecha: 2026-07-07 | Doc: 33460 | Total: S/ 130.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (248, 172, 130.00, 'Efectivo', '33460', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11461: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11461, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11461;

  -- Deuda id=11462: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11462, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11462;

  -- Deuda id=11856: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11856, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11856;

  -- Deuda id=11857: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11857, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11857;

  -- Socio: VALERO SOTO WILLY PERSEO | Fecha: 2026-07-04 | Doc: 33409 | Total: S/ 88.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (80, 173, 88.00, 'Efectivo', '33409', '2026-07-04T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=12017: LUZ 2026/05 | Monto deuda: S/142 | Pagado: S/82 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12017, 82.00);

  -- Deuda id=11463: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11463, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11463;

  -- Socio: VALLEJOS HUAMAN MARIA ANA | Fecha: 2026-07-02 | Doc: 33382 | Total: S/ 147.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (224, 174, 147.70, 'Efectivo', '33382', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=12018: LUZ 2026/05 | Monto deuda: S/81.4 | Pagado: S/81.4 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12018, 81.40);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 12018;

  -- Deuda id=11466: AGUA 2026/05 | Monto deuda: S/66.3 | Pagado: S/66.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11466, 66.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11466;

  -- Socio: VARA CASTRO DELIA ERNESTINA F | Fecha: 2026-07-08 | Doc: 33541 | Total: S/ 424.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (216, 176, 424.40, 'Efectivo', '33541', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: MULTA 27/11/25 2026/11, MULTA 26/03/2026 2026/03, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: MULTA 27/11/25 2026/11 S/113 — registrado en pago pero sin monto_id

  -- SIN DEUDA: MULTA 26/03/2026 2026/03 S/113 — registrado en pago pero sin monto_id

  -- Deuda id=10509: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/28 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10509, 28.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10509;

  -- Deuda id=10767: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10767, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10767;

  -- Deuda id=12063: LUZ 2026/05 | Monto deuda: S/25 | Pagado: S/25 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12063, 25.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 12063;

  -- Deuda id=11471: AGUA 2026/05 | Monto deuda: S/20.4 | Pagado: S/20.4 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11471, 20.40);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11471;

  -- Deuda id=11472: G. ADM 2026/05 | Monto deuda: S/50 | Pagado: S/50 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11472, 50.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11472;

  -- Deuda id=11473: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11473, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11473;

  -- Deuda id=11864: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11864, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11864;

  -- Deuda id=11865: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11865, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11865;

  -- Socio: VARA DE ROSAS ALICIA VALENTINA | Fecha: 2026-07-07 | Doc: 33448 | Total: S/ 268.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (213, 177, 268.70, 'Efectivo', '33448', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=12064: LUZ 2026/05 | Monto deuda: S/172.5 | Pagado: S/172.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12064, 172.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 12064;

  -- Deuda id=11474: AGUA 2026/05 | Monto deuda: S/96.2 | Pagado: S/96.2 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11474, 96.20);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11474;

  -- Socio: VICENTE CALIXTO JOSE ALBERTO | Fecha: 2026-07-06 | Doc: 33443 | Total: S/ 400.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (255, 178, 400.00, 'Efectivo', '33443', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO 5 - D2 2026/04, DEPOSITO 5 - D2 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=12065: DEPOSITO 5 - D2 2026/04 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12065, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 12065;

  -- Deuda id=12067: DEPOSITO 5 - D2 2026/05 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12067, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 12067;

  -- Socio: VICENTE CALIXTO JOSE ALBERTO | Fecha: 2026-07-08 | Doc: 33511 | Total: S/ 275.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (255, 178, 275.80, 'Efectivo', '33511', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06, DEPOSITO 5 - D2 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=12066: LUZ 2026/05 | Monto deuda: S/24.8 | Pagado: S/24.8 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12066, 24.80);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 12066;

  -- Deuda id=11477: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11477, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11477;

  -- Deuda id=11868: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/40 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11868, 40.00);

  -- Deuda id=11869: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11869, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11869;

  -- Deuda id=11870: DEPOSITO 5 - D2 2026/06 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11870, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11870;

  -- Socio: VILCHEZ GUTARRA LOURDES FANNY | Fecha: 2026-07-06 | Doc: 33433 | Total: S/ 1018.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (187, 179, 1018.50, 'Efectivo', '33433', '2026-07-06T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, DEPOSITO 7 - D1 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=12068: LUZ 2026/05 | Monto deuda: S/735.7 | Pagado: S/735.7 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12068, 735.70);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 12068;

  -- Deuda id=11481: AGUA 2026/05 | Monto deuda: S/82.8 | Pagado: S/82.8 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11481, 82.80);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11481;

  -- Deuda id=12069: DEPOSITO 7 - D1 2026/05 | Monto deuda: S/190 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12069, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 12069;

  -- Socio: VILLANUEVA INGA DE VASQUEZ ROSA PRIMITIVA | Fecha: 2026-07-08 | Doc: 33535 | Total: S/ 200.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (263, 180, 200.00, 'Efectivo', '33535', '2026-07-08T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO 6 - D1 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11876: DEPOSITO 6 - D1 2026/06 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11876, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11876;

  -- Socio: YRUPAILLA FALCON NILDA ADELINA | Fecha: 2026-07-07 | Doc: 33479 | Total: S/ 149.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (163, 183, 149.90, 'Efectivo', '33479', '2026-07-07T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10679: LUZ 2026/03 | Monto deuda: S/43.9 | Pagado: S/28.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10679, 28.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10679;

  -- Deuda id=10680: AGUA 2026/03 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10680, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10680;

  -- Deuda id=10681: LUZ 2026/04 | Monto deuda: S/13 | Pagado: S/13 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10681, 13.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10681;

  -- Deuda id=10682: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10682, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10682;

  -- SIN DEUDA: LUZ 2026/05 S/25 — registrado en pago pero sin monto_id

  -- Deuda id=11494: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11494, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11494;

  -- SIN DEUDA: G. ADM 2026/06 S/60 — registrado en pago pero sin monto_id

  -- Deuda id=11879: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11879, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11879;

  -- Socio: YRUPAILLA ANAMPA ISIDRO BELISARIO | Fecha: 2026-07-03 | Doc: 33405 | Total: S/ 10.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (206, 182, 10.20, 'Efectivo', '33405', '2026-07-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, LUZ 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10658: LUZ 2026/04 | Monto deuda: S/5.2 | Pagado: S/5.2 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10658, 5.20);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10658;

  -- Deuda id=12071: LUZ 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12071, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 12071;

  -- Socio: ZAPATA RIVERA ROSANA | Fecha: 2026-07-02 | Doc: 33378 | Total: S/ 296.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (236, 184, 296.90, 'Efectivo', '33378', '2026-07-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=12074: LUZ 2026/05 | Monto deuda: S/85.3 | Pagado: S/85.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12074, 85.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 12074;

  -- Deuda id=11499: AGUA 2026/05 | Monto deuda: S/211.6 | Pagado: S/211.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11499, 211.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11499;

  -- Socio: ZAPATA RIVERA ROSANA | Fecha: 2026-07-01 | Doc: 33349 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (236, 184, 65.00, 'Efectivo', '33349', '2026-07-01T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/06 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/06 S/5 — registrado en pago pero sin monto_id

END$$;

-- ─── SOCIOS EXCLUIDOS ─────────────────────────────────────────────────────
-- EXCLUIDO: "GARCIA LUCIA" — Socia nueva sin alta de padrón confirmada (igual que en la migración de junio 2026).
-- EXCLUIDO: "TENORIO ALBERTINA" — Nueva socia en reemplazo — sin alta confirmada en padrón (no existe en public.socios).

-- ─── LÍNEAS DUPLICADAS EN EL EXCEL FUENTE (deuda ya saldada en este lote) ───
-- DUPLICADO: ALVAREZ CAMPOS ROLANDO / "G. ADM" 2026/5 S/60: deuda id=10787 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc 33513) — registrada como SIN DEUDA
-- DUPLICADO: ALVAREZ CAMPOS ROLANDO / "P. SOCIAL" 2026/5 S/5: deuda id=10788 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc 33513) — registrada como SIN DEUDA
-- DUPLICADO: JARA SANTOS / "G. ADM" 2026/5 S/60: deuda id=11103 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc 33440) — registrada como SIN DEUDA
-- DUPLICADO: JARA SANTOS / "P. SOCIAL" 2026/5 S/5: deuda id=11104 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc 33440) — registrada como SIN DEUDA
-- DUPLICADO: Marin Rocha ESTEFANY / "G. ADM" 2026/5 S/60: deuda id=11169 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc 33514) — registrada como SIN DEUDA
-- DUPLICADO: Marin Rocha ESTEFANY / "P. SOCIAL" 2026/5 S/5: deuda id=11170 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc 33514) — registrada como SIN DEUDA
-- DUPLICADO: PEREZ EPIFANIA / "G. ADM" 2026/4 S/60: deuda id=8925 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc 33465) — registrada como SIN DEUDA
-- DUPLICADO: PEREZ EPIFANIA / "p. SOCIAL" 2026/4 S/5: deuda id=8926 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc 33465) — registrada como SIN DEUDA
-- DUPLICADO: PEREZ EPIFANIA / "G. ADM" 2026/4 S/60: deuda id=8925 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc 33465) — registrada como SIN DEUDA
-- DUPLICADO: PEREZ EPIFANIA / "p. SOCIAL" 2026/4 S/5: deuda id=8926 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc 33465) — registrada como SIN DEUDA
-- DUPLICADO: ROMERO JAVIER / "G. ADM" 2026/3 S/60: deuda id=9559 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc 33473) — registrada como SIN DEUDA
-- DUPLICADO: ROMERO JAVIER / "P. SOCIAL" 2026/3 S/5: deuda id=9560 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc 33473) — registrada como SIN DEUDA
-- DUPLICADO: ROMERO JAVIER / "G. ADM" 2026/3 S/60: deuda id=9559 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc 33473) — registrada como SIN DEUDA
-- DUPLICADO: ROMERO JAVIER / "P. SOCIAL" 2026/3 S/5: deuda id=9560 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc 33473) — registrada como SIN DEUDA
-- DUPLICADO: ROMERO JAVIER / "G. ADM" 2026/3 S/60: deuda id=9559 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc 33473) — registrada como SIN DEUDA
-- DUPLICADO: ROMERO JAVIER / "P. SOCIAL" 2026/3 S/5: deuda id=9560 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc 33473) — registrada como SIN DEUDA
