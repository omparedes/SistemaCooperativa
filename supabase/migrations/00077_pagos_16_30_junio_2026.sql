-- =============================================================================
-- Migración 00077: Pagos 16-30 Junio 2026
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- Generado: 2026-06-30 desde scripts/generar_pagos_16_30_junio_2026.js
-- Fuente: migracion_coop/junio/SOCIOS - CONSOLIDADO PAGOS 16-30 JUNIO 2026.xlsx (hoja "Detalle pagos")
-- Registra pagos reales 16-26 jun 2026. Marca deudas como Cancelado si pago total.
-- Idempotente: usa DO $$ ... END$$ con EXCEPTION para manejar duplicados por comprobante.
-- =============================================================================

DO $$
DECLARE
  v_pago_id bigint;
BEGIN

  -- Socio: AGUIRRE QUISPE WILFREDO GILMER | Fecha: 2026-06-22 | Total: S/ 249.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (229, 1, 249.50, 'Efectivo', NULL, '2026-06-22T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, DEPOSITO 6 - D2 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/43.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO 6 - D2 2026/04 S/200 — registrado en pago pero sin monto_id

  -- Socio: AGUIRRE QUISPE WILFREDO GILMER | Fecha: 2026-06-23 | Total: S/ 251.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (229, 1, 251.30, 'Efectivo', NULL, '2026-06-23T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05, DEPOSITO 6 - D2 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10768: LUZ 2026/05 | Monto deuda: S/45.3 | Pagado: S/45.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10768, 45.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10768;

  -- Deuda id=10769: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10769, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10769;

  -- Deuda id=10772: DEPOSITO 6 - D2 2026/05 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10772, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10772;

  -- Socio: ALARCON ANAMPA BETSY JANET | Fecha: 2026-06-22 | Total: S/ 140.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (160, 2, 140.00, 'Efectivo', NULL, '2026-06-22T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/40.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Deuda id=10773: LUZ 2026/05 | Monto deuda: S/42.5 | Pagado: S/28.5 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10773, 28.50);

  -- Socio: ALVAREZ CAMPOS VICTOR ADRIANO | Fecha: 2026-06-17 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (250, 6, 65.00, 'Efectivo', NULL, '2026-06-17T12:00:00+00:00', 'Pago 16-30 jun 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/06 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/06 S/5 — registrado en pago pero sin monto_id

  -- Socio: ALVAREZ MARIN MARIANELA | Fecha: 2026-06-25 | Total: S/ 50.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (176, 7, 50.00, 'Efectivo', NULL, '2026-06-25T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/7.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/36.3 — registrado en pago pero sin monto_id

  -- Socio: BURGA CARRASCO ELIDA | Fecha: 2026-06-25 | Total: S/ 369.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (66, 17, 369.00, 'Efectivo', NULL, '2026-06-25T12:00:00+00:00', 'Pago 16-30 jun 2026: MULTA 27/11/2025 2026/11, G. ADM 2026/03, P. SOCIAL 2026/03, MULTA 27/11/2025 2026/03, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: MULTA 27/11/2025 2026/11 S/56.5 — registrado en pago pero sin monto_id

  -- Deuda id=6608: G. ADM 2026/03 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6608, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6608;

  -- Deuda id=6609: P. SOCIAL 2026/03 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6609, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6609;

  -- SIN DEUDA: MULTA 27/11/2025 2026/03 S/56.5 — registrado en pago pero sin monto_id

  -- Deuda id=6613: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6613, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6613;

  -- Deuda id=6614: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 6614, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 6614;

  -- Deuda id=10835: LUZ 2026/05 | Monto deuda: S/55 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10835, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10835;

  -- Deuda id=10836: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/5 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10836, 5.00);

  -- Deuda id=10837: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/55 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10837, 55.00);

  -- Deuda id=10838: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10838, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10838;

  -- Socio: CABALLERO CALZADO GLADYS VICTORIA | Fecha: 2026-06-22 | Total: S/ 25.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (203, 18, 25.30, 'Efectivo', NULL, '2026-06-22T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/8.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Deuda id=10839: LUZ 2026/05 | Monto deuda: S/5.2 | Pagado: S/5.2 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10839, 5.20);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10839;

  -- Deuda id=10840: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10840, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10840;

  -- Socio: CAHUANA VDA DE DAVILA VICENTINA | Fecha: 2026-06-24 | Total: S/ 190.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (254, 20, 190.30, 'Efectivo', NULL, '2026-06-24T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/55.9 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/134.4 — registrado en pago pero sin monto_id

  -- Socio: CALLE ALVAREZ MARCO ANTONIO | Fecha: 2026-06-16 | Total: S/ 200.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (244, 24, 200.00, 'Efectivo', NULL, '2026-06-16T12:00:00+00:00', 'Pago 16-30 jun 2026: DEPOSITO 2026/05, DEPOSITO 10 - D2 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10894: DEPOSITO 2026/05 | Monto deuda: S/200 | Pagado: S/100 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10894, 100.00);

  -- Deuda id=10894: DEPOSITO 10 - D2 2026/05 | Monto deuda: S/200 | Pagado: S/100 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10894, 100.00);

  -- Socio: CARTAGENA PALOMINO ALVARO BENJAMIN | Fecha: 2026-06-25 | Total: S/ 180.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (185, 31, 180.20, 'Efectivo', NULL, '2026-06-25T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/49 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/13.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/49.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/12.5 — registrado en pago pero sin monto_id

  -- Deuda id=10919: LUZ 2026/05 | Monto deuda: S/45.8 | Pagado: S/45.8 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10919, 45.80);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10919;

  -- Deuda id=10920: AGUA 2026/05 | Monto deuda: S/10.1 | Pagado: S/10.1 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10920, 10.10);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10920;

  -- Socio: CASTRO ALEJANDRO HORTENCIA LUCILA | Fecha: 2026-06-25 | Total: S/ 85.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (175, 32, 85.40, 'Efectivo', NULL, '2026-06-25T12:00:00+00:00', 'Pago 16-30 jun 2026: G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/03 S/25 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/21.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: FUMIGACION 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Deuda id=10924: LUZ 2026/05 | Monto deuda: S/16.8 | Pagado: S/16.8 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10924, 16.80);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10924;

  -- Deuda id=10925: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10925, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10925;

  -- Socio: CCOYLLO BUSTILLOS DEYSI KAREN | Fecha: 2026-06-17 | Total: S/ 447.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (70, 34, 447.00, 'Efectivo', NULL, '2026-06-17T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/185 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Deuda id=10932: LUZ 2026/05 | Monto deuda: S/185 | Pagado: S/185 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10932, 185.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10932;

  -- Deuda id=10933: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10933, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10933;

  -- Deuda id=10934: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10934, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10934;

  -- Deuda id=10935: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10935, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10935;

  -- Socio: CCOYLLO MAYHUASCA ALEXIS | Fecha: 2026-06-16 | Total: S/ 125.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (205, 37, 125.80, 'Efectivo', NULL, '2026-06-16T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/20 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/32.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/40 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/22.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: CCOYLLO POLANCO DANIEL | Fecha: 2026-06-26 | Total: S/ 447.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (212, 38, 447.80, 'Efectivo', NULL, '2026-06-26T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10948: LUZ 2026/05 | Monto deuda: S/376.8 | Pagado: S/376.8 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10948, 376.80);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10948;

  -- Deuda id=10949: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10949, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10949;

  -- Deuda id=10950: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10950, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10950;

  -- Deuda id=10951: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10951, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10951;

  -- Socio: CCOYLLO POLANCO GERMAN | Fecha: 2026-06-16 | Total: S/ 239.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (132, 39, 239.50, 'Efectivo', NULL, '2026-06-16T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/14.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/18 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Deuda id=10954: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10954, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10954;

  -- Deuda id=10955: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10955, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10955;

  -- Socio: CLEMENTE ALLER CIRILA | Fecha: 2026-06-19 | Total: S/ 216.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (90, 45, 216.90, 'Efectivo', NULL, '2026-06-19T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/94.9 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/45 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: CRUZ JARAMILLO LUIS | Fecha: 2026-06-18 | Total: S/ 31.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (262, 48, 31.20, 'Efectivo', NULL, '2026-06-18T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10990: LUZ 2026/05 | Monto deuda: S/25.2 | Pagado: S/25.2 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10990, 25.20);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10990;

  -- Deuda id=10991: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10991, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10991;

  -- Socio: CUEVAS MAYO ENRIQUE | Fecha: 2026-06-17 | Total: S/ 55.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (168, 50, 55.00, 'Efectivo', NULL, '2026-06-17T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10998: LUZ 2026/05 | Monto deuda: S/49 | Pagado: S/49 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10998, 49.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10998;

  -- Deuda id=10999: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10999, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10999;

  -- Socio: DE LA CRUZ ESTEBAN JOSE LUIS | Fecha: 2026-06-22 | Total: S/ 71.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (220, 55, 71.20, 'Efectivo', NULL, '2026-06-22T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11015: LUZ 2026/05 | Monto deuda: S/53 | Pagado: S/53 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11015, 53.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11015;

  -- Deuda id=11016: AGUA 2026/05 | Monto deuda: S/18.2 | Pagado: S/18.2 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11016, 18.20);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11016;

  -- Socio: ESTELA SUAREZ ELVIA | Fecha: 2026-06-16 | Total: S/ 331.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (190, 57, 331.80, 'Efectivo', NULL, '2026-06-16T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/214.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/52.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: FLORES FLORES IRENE BERTILIA | Fecha: 2026-06-16 | Total: S/ 722.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (247, 60, 722.00, 'Efectivo', NULL, '2026-06-16T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, LUZ 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11035: LUZ 2026/05 | Monto deuda: S/538.3 | Pagado: S/538.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11035, 538.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11035;

  -- Deuda id=11036: AGUA 2026/05 | Monto deuda: S/118 | Pagado: S/118 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11036, 118.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11036;

  -- Deuda id=11037: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11037, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11037;

  -- Deuda id=11038: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11038, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11038;

  -- SIN DEUDA: LUZ 2026/06 S/0.7 — registrado en pago pero sin monto_id

  -- Socio: GELDRES REVILLA MIGUEL ANGEL | Fecha: 2026-06-22 | Total: S/ 162.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (204, 64, 162.00, 'Efectivo', NULL, '2026-06-22T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/37.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/12.9 — registrado en pago pero sin monto_id

  -- Deuda id=11051: LUZ 2026/05 | Monto deuda: S/32.6 | Pagado: S/32.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11051, 32.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11051;

  -- Deuda id=11052: AGUA 2026/05 | Monto deuda: S/13.7 | Pagado: S/13.7 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11052, 13.70);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11052;

  -- Deuda id=11053: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11053, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11053;

  -- Deuda id=11054: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11054, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11054;

  -- Socio: GUTIERREZ CASTILLO TERESA JESUS | Fecha: 2026-06-24 | Total: S/ 100.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (180, 66, 100.00, 'Efectivo', NULL, '2026-06-24T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/13 — registrado en pago pero sin monto_id

  -- Socio: JARA ALVAREZ SANTOS PEDRO | Fecha: 2026-06-19 | Total: S/ 10.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (183, 78, 10.00, 'Efectivo', NULL, '2026-06-19T12:00:00+00:00', 'Pago 16-30 jun 2026: USO DE LUZ 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: USO DE LUZ 2026/06 S/10 — registrado en pago pero sin monto_id

  -- Socio: JARA ALVAREZ SANTOS PEDRO | Fecha: 2026-06-24 | Total: S/ 10.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (183, 78, 10.00, 'Efectivo', NULL, '2026-06-24T12:00:00+00:00', 'Pago 16-30 jun 2026: USO DE LUZ 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: USO DE LUZ 2026/06 S/10 — registrado en pago pero sin monto_id

  -- Socio: LUJAN GONZALES MARINO JUAN | Fecha: 2026-06-20 | Total: S/ 146.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (272, 83, 146.70, 'Efectivo', NULL, '2026-06-20T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/120 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/26.7 — registrado en pago pero sin monto_id

  -- Socio: MARIN LONDONE EDUARDO SANTIAGO | Fecha: 2026-06-22 | Total: S/ 168.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (270, 87, 168.90, 'Efectivo', NULL, '2026-06-22T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/37.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/39.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Deuda id=11154: LUZ 2026/05 | Monto deuda: S/38.6 | Pagado: S/38.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11154, 38.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11154;

  -- Deuda id=11155: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11155, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11155;

  -- Deuda id=11156: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/30 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11156, 30.00);

  -- Deuda id=11157: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11157, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11157;

  -- Socio: MARIN LONDONE MARIA LUZ | Fecha: 2026-06-17 | Total: S/ 100.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (177, 88, 100.00, 'Efectivo', NULL, '2026-06-17T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, DEPOSITO 5 - D1 2026/03')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/22.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/21.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/38.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO 5 - D1 2026/03 S/6.8 — registrado en pago pero sin monto_id

  -- Socio: MEDINA GUTIERREZ HONORATA | Fecha: 2026-06-26 | Total: S/ 92.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (268, 95, 92.80, 'Efectivo', NULL, '2026-06-26T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/8.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Deuda id=11163: LUZ 2026/05 | Monto deuda: S/7.4 | Pagado: S/7.4 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11163, 7.40);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11163;

  -- Deuda id=11164: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11164, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11164;

  -- Deuda id=11165: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11165, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11165;

  -- Deuda id=11166: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11166, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11166;

  -- Socio: MAYHUASCA BASTIDAS DE TORRES CLUDDY AYDE | Fecha: 2026-06-16 | Total: S/ 469.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (230, 90, 469.10, 'Efectivo', NULL, '2026-06-16T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/401 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/33.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/30 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: MAYHUASCA BASTIDAS MARILU | Fecha: 2026-06-26 | Total: S/ 135.60
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (280, 91, 135.60, 'Efectivo', NULL, '2026-06-26T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/13.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/34.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/14.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/40.6 — registrado en pago pero sin monto_id

  -- Deuda id=11175: LUZ 2026/05 | Monto deuda: S/13.3 | Pagado: S/13.3 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11175, 13.30);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11175;

  -- Deuda id=11176: AGUA 2026/05 | Monto deuda: S/20 | Pagado: S/20 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11176, 20.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11176;

  -- Socio: MAYTA COLQUI VIOLETA | Fecha: 2026-06-26 | Total: S/ 43.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (253, 93, 43.00, 'Efectivo', NULL, '2026-06-26T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11183: LUZ 2026/05 | Monto deuda: S/29 | Pagado: S/29 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11183, 29.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11183;

  -- Deuda id=11184: AGUA 2026/05 | Monto deuda: S/14 | Pagado: S/14 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11184, 14.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11184;

  -- Socio: MEDINA JOTA DE CACERES VICENTA | Fecha: 2026-06-25 | Total: S/ 351.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (29, 96, 351.00, 'Efectivo', NULL, '2026-06-25T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/135 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Deuda id=11187: LUZ 2026/05 | Monto deuda: S/139 | Pagado: S/139 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11187, 139.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11187;

  -- Deuda id=11188: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11188, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11188;

  -- Deuda id=11189: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11189, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11189;

  -- Deuda id=11190: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11190, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11190;

  -- Socio: MELO BACA MARINA | Fecha: 2026-06-25 | Total: S/ 1521.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (217, 98, 1521.30, 'Efectivo', NULL, '2026-06-25T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/805.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/28.6 — registrado en pago pero sin monto_id

  -- Deuda id=11195: LUZ 2026/05 | Monto deuda: S/654.5 | Pagado: S/654.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11195, 654.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11195;

  -- Deuda id=11196: AGUA 2026/05 | Monto deuda: S/32.5 | Pagado: S/32.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11196, 32.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11196;

  -- Socio: MESIA CRUZ GLADYS | Fecha: 2026-06-17 | Total: S/ 751.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (201, 99, 751.90, 'Efectivo', NULL, '2026-06-17T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, DEPOSITO 4 - D1 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06, DEPOSITO 4 - D1 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/108.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Deuda id=11199: LUZ 2026/05 | Monto deuda: S/101.1 | Pagado: S/101.1 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11199, 101.10);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11199;

  -- Deuda id=11200: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11200, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11200;

  -- Deuda id=11201: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11201, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11201;

  -- Deuda id=11202: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11202, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11202;

  -- Deuda id=11203: DEPOSITO 4 - D1 2026/05 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11203, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11203;

  -- SIN DEUDA: G. ADM 2026/06 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/06 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO 4 - D1 2026/06 S/200 — registrado en pago pero sin monto_id

  -- Socio: ORTIZ NAUPA WELINTONH | Fecha: 2026-06-17 | Total: S/ 200.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (279, 108, 200.10, 'Efectivo', NULL, '2026-06-17T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/154.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/10.6 — registrado en pago pero sin monto_id

  -- Deuda id=11230: G. ADM 2026/05 | Monto deuda: S/60 | Pagado: S/30 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11230, 30.00);

  -- Deuda id=11231: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11231, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11231;

  -- Socio: PALOMINO HANCCO CECILIA | Fecha: 2026-06-22 | Total: S/ 392.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (259, 110, 392.10, 'Efectivo', NULL, '2026-06-22T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/306.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/85.9 — registrado en pago pero sin monto_id

  -- Socio: PALOMINO VELASQUEZ EUSEBIO | Fecha: 2026-06-19 | Total: S/ 559.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (242, 112, 559.80, 'Efectivo', NULL, '2026-06-19T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/519.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/40.7 — registrado en pago pero sin monto_id

  -- Socio: PEREZ PONCE DE ROMERO SATURNINA MARGARITA | Fecha: 2026-06-26 | Total: S/ 190.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (281, 116, 190.10, 'Efectivo', NULL, '2026-06-26T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=8899: LUZ 2026/04 | Monto deuda: S/60.1 | Pagado: S/60.1 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8899, 60.10);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8899;

  -- Deuda id=8900: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8900, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8900;

  -- SIN DEUDA: LUZ 2026/05 S/53 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: QUINTANA VIDAL GLICERIO | Fecha: 2026-06-18 | Total: S/ 106.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (192, 122, 106.20, 'Efectivo', NULL, '2026-06-18T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9046: LUZ 2026/03 | Monto deuda: S/30.2 | Pagado: S/30.2 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9046, 30.20);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9046;

  -- Deuda id=9047: AGUA 2026/03 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9047, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9047;

  -- Deuda id=9048: LUZ 2026/04 | Monto deuda: S/31.8 | Pagado: S/31.8 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9048, 31.80);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9048;

  -- Deuda id=9049: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9049, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9049;

  -- SIN DEUDA: LUZ 2026/05 S/26.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- Socio: QUISPE AGUILAR DE PALOMINO DOROTEA | Fecha: 2026-06-17 | Total: S/ 417.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (227, 126, 417.50, 'Efectivo', NULL, '2026-06-17T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9137: LUZ 2026/04 | Monto deuda: S/376.5 | Pagado: S/376.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9137, 376.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9137;

  -- Deuda id=9138: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9138, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9138;

  -- SIN DEUDA: G. ADM 2026/05 S/30 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: QUISPE CONSA MIGUEL | Fecha: 2026-06-16 | Total: S/ 712.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (210, 123, 712.00, 'Efectivo', NULL, '2026-06-16T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9068: LUZ 2026/04 | Monto deuda: S/694 | Pagado: S/694 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9068, 694.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9068;

  -- Deuda id=9069: AGUA 2026/04 | Monto deuda: S/18 | Pagado: S/18 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9069, 18.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9069;

  -- Socio: QUISPE CONSA MIGUEL | Fecha: 2026-06-23 | Total: S/ 666.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (210, 123, 666.70, 'Efectivo', NULL, '2026-06-23T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/653.3 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/13.4 — registrado en pago pero sin monto_id

  -- Socio: QUISPE CONSA VIDAL | Fecha: 2026-06-16 | Total: S/ 655.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (186, 124, 655.80, 'Efectivo', NULL, '2026-06-16T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9090: LUZ 2026/04 | Monto deuda: S/575.2 | Pagado: S/575.2 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9090, 575.20);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9090;

  -- Deuda id=9091: AGUA 2026/04 | Monto deuda: S/15.6 | Pagado: S/15.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9091, 15.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9091;

  -- Deuda id=9092: G. ADM 2026/04 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9092, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9092;

  -- Deuda id=9093: P. SOCIAL 2026/04 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9093, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9093;

  -- Socio: REYES PEREZ DE VALENCIA NANCY VICTORIA | Fecha: 2026-06-26 | Total: S/ 232.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (222, 131, 232.40, 'Efectivo', NULL, '2026-06-26T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/217.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/15 — registrado en pago pero sin monto_id

  -- Socio: RIVERA FERNANDEZ MARINA MAXILIANA | Fecha: 2026-06-24 | Total: S/ 283.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (237, 135, 283.80, 'Efectivo', NULL, '2026-06-24T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/11.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/261.6 — registrado en pago pero sin monto_id

  -- Socio: RODRIGUEZ MORENO NORA | Fecha: 2026-06-26 | Total: S/ 831.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (274, 138, 831.50, 'Efectivo', NULL, '2026-06-26T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/753.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/13.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: ROMERO FLORES EDDNA | Fecha: 2026-06-18 | Total: S/ 345.60
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (246, 141, 345.60, 'Efectivo', NULL, '2026-06-18T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/298.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/47.1 — registrado en pago pero sin monto_id

  -- Socio: SALAS MONTALVO JUDITH MAGALI | Fecha: 2026-06-23 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (110, 145, 65.00, 'Efectivo', NULL, '2026-06-23T12:00:00+00:00', 'Pago 16-30 jun 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/06 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/06 S/5 — registrado en pago pero sin monto_id

  -- Socio: ROMERO NINAHUAMAN JAVIER JOHNNY | Fecha: 2026-06-16 | Total: S/ 123.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (15, 142, 123.10, 'Efectivo', NULL, '2026-06-16T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/61.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/50 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: SALAS MONTALVO RUTH YOVANNA | Fecha: 2026-06-16 | Total: S/ 139.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (36, 146, 139.20, 'Efectivo', NULL, '2026-06-16T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/67.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: SANCHEZ RODRIGUEZ JUDITH IRIS | Fecha: 2026-06-19 | Total: S/ 100.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (284, 150, 100.00, 'Efectivo', NULL, '2026-06-19T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/63.3 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/36.7 — registrado en pago pero sin monto_id

  -- Socio: SANCHEZ SOTO LUCIA YRENE | Fecha: 2026-06-22 | Total: S/ 205.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (162, 151, 205.00, 'Efectivo', NULL, '2026-06-22T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/29 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: FUMIGACION 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/29 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: SOTO GALLEGO DE VALERO SOFIA | Fecha: 2026-06-24 | Total: S/ 211.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (181, 157, 211.40, 'Efectivo', NULL, '2026-06-24T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/38.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/30.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: SOTO VARGAS DE FLORES MARIA DEL CARMEN | Fecha: 2026-06-17 | Total: S/ 26.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (193, 158, 26.80, 'Efectivo', NULL, '2026-06-17T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/7.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/7.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: VALERO SOTO MAXIMO ELIAS | Fecha: 2026-06-26 | Total: S/ 31.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (248, 172, 31.40, 'Efectivo', NULL, '2026-06-26T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/25.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- Socio: VARA DE ROSAS ALICIA VALENTINA | Fecha: 2026-06-23 | Total: S/ 283.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (213, 177, 283.30, 'Efectivo', NULL, '2026-06-23T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/192.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/90.6 — registrado en pago pero sin monto_id

  -- Socio: VICENTE CALIXTO JOSE ALBERTO | Fecha: 2026-06-24 | Total: S/ 200.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (255, 178, 200.00, 'Efectivo', NULL, '2026-06-24T12:00:00+00:00', 'Pago 16-30 jun 2026: DEPOSITO 5 - D2 2026/03')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: DEPOSITO 5 - D2 2026/03 S/200 — registrado en pago pero sin monto_id

  -- Socio: VILLANUEVA INGA DE VASQUEZ ROSA PRIMITIVA | Fecha: 2026-06-24 | Total: S/ 478.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (263, 180, 478.90, 'Efectivo', NULL, '2026-06-24T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04, DEPOSITO 6 - D1 2026/04, LUZ 2026/05, AGUA 2026/05, DEPOSITO 6 - D1 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/36.3 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO 6 - D1 2026/04 S/200 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/30.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO 6 - D1 2026/05 S/200 — registrado en pago pero sin monto_id

  -- Socio: YRUPAILLA ANAMPA ISIDRO BELISARIO | Fecha: 2026-06-17 | Total: S/ 77.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (206, 182, 77.00, 'Efectivo', NULL, '2026-06-17T12:00:00+00:00', 'Pago 16-30 jun 2026: AGUA 2026/04, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: ZAPATA RIVERA ROSANA | Fecha: 2026-06-24 | Total: S/ 261.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (236, 184, 261.40, 'Efectivo', NULL, '2026-06-24T12:00:00+00:00', 'Pago 16-30 jun 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/88.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/172.8 — registrado en pago pero sin monto_id

END$$;
