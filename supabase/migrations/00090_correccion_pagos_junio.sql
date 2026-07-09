-- =============================================================================
-- Migración 00089: Pagos 01-08 Julio 2026
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- Generado: 2026-07-09 desde scripts/generar_pagos_1_8_julio_2026.js
-- Fuente: migracion_coop/julio/SOCIOS - CONSOLIDADO PAGOS JUNIO 2026 ACTUALIZADO.xlsx (hoja "Detalle pagos")
-- Registra pagos reales 01-08 jul 2026. Marca deudas como Cancelado si pago total.
-- =============================================================================

DO $$
DECLARE
  v_pago_id bigint;
BEGIN

  -- Socio: AGUIRRE QUISPE WILFREDO GILMER | Fecha: 2026-06-22 | Doc: 33304 | Total: S/ 249.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (229, 1, 249.50, 'Efectivo', '33304', '2026-06-22T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, DEPOSITO 6 - D2 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/43.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO 6 - D2 2026/04 S/200 — registrado en pago pero sin monto_id

  -- Socio: AGUIRRE QUISPE WILFREDO GILMER | Fecha: 2026-06-23 | Doc: 33307 | Total: S/ 251.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (229, 1, 251.30, 'Efectivo', '33307', '2026-06-23T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, DEPOSITO 6 - D2 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/45.3 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO 6 - D2 2026/05 S/200 — registrado en pago pero sin monto_id

  -- Socio: AGUIRRE QUISPE WILFREDO GILMER | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (229, 1, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11513: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11513, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11513;

  -- Deuda id=11514: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11514, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11514;

  -- Socio: ALARCON ANAMPA BETSY JANET | Fecha: 2026-06-22 | Doc: 33298 | Total: S/ 140.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (160, 2, 140.00, 'Efectivo', '33298', '2026-06-22T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/40.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/28.5 — registrado en pago pero sin monto_id

  -- Socio: ALARCON ANAMPA NANCY GUISELA | Fecha: 2026-06-10 | Doc: 33229 | Total: S/ 58.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (152, 3, 58.30, 'Efectivo', '33229', '2026-06-10T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, FUMIGACION 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/47.3 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: FUMIGACION 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: ALHUAY PALOMINO DE ALHUAY JUANA | Fecha: 2026-06-12 | Doc: 33251 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (275, 4, 65.00, 'Efectivo', '33251', '2026-06-12T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: ALVAREZ CAMPOS ROLANDO | Fecha: 2026-06-02 | Doc: 33169 | Total: S/ 200.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (170, 5, 200.00, 'Efectivo', '33169', '2026-06-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, DEPOSITO 3 - D2 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/26.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO 3 - D2 2026/03 S/100 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/40 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/21.4 — registrado en pago pero sin monto_id

  -- Socio: ALVAREZ CAMPOS ROLANDO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 200.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (170, 5, 200.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11524: DEPOSITO 2026/06 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11524, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11524;

  -- Socio: ALVAREZ CAMPOS VICTOR ADRIANO | Fecha: 2026-06-17 | Doc: 33275 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (250, 6, 65.00, 'Efectivo', '33275', '2026-06-17T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/06 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/06 S/5 — registrado en pago pero sin monto_id

  -- Socio: ALVAREZ MARIN MARIANELA | Fecha: 2026-06-25 | Doc: 33321 | Total: S/ 50.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (176, 7, 50.00, 'Efectivo', '33321', '2026-06-25T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/7.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/36.3 — registrado en pago pero sin monto_id

  -- Socio: ANAMPA CORAHUA CLEMENCIA MIGDONIA | Fecha: 2026-06-03 | Doc: 33176 | Total: S/ 79.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (154, 8, 79.80, 'Efectivo', '33176', '2026-06-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/73.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- Socio: ANCCO LEON VALENTINA | Fecha: 2026-06-03 | Doc: 33183 | Total: S/ 196.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (130, 9, 196.00, 'Efectivo', '33183', '2026-06-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/27 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/27 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: ATANASIO ORTEGA MAXIMILIANA | Fecha: 2026-06-02 | Doc: 33159 | Total: S/ 107.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (273, 10, 107.90, 'Efectivo', '33159', '2026-06-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/30.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/15 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/47.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/15 — registrado en pago pero sin monto_id

  -- Socio: ATANASIO ORTEGA MAXIMILIANA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 60.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (273, 10, 60.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11531: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11531, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11531;

  -- Socio: AYALA HUASHUAYO NORMA GLADYS | Fecha: 2026-06-08 | Doc: 33213 | Total: S/ 91.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (60, 11, 91.00, 'Efectivo', '33213', '2026-06-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/20 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: AYALA TABOADA ELISEO | Fecha: 2026-06-08 | Doc: 33212 | Total: S/ 246.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (55, 12, 246.00, 'Efectivo', '33212', '2026-06-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05, DEPOSITO 1 - D3 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/25 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO 1 - D3 2026/05 S/150 — registrado en pago pero sin monto_id

  -- Socio: BASTIDAS MEDINA HERMENEGILDO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 10.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (199, 14, 10.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11540: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/10 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11540, 10.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11540;

  -- Socio: BERNAOLA CARHUAZ DE PRADO FLORENCIA | Fecha: 2026-06-03 | Doc: 33187 | Total: S/ 239.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (261, 15, 239.10, 'Efectivo', '33187', '2026-06-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/140.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/98.7 — registrado en pago pero sin monto_id

  -- Socio: BERNAOLA CARHUAZ DE PRADO FLORENCIA | Fecha: 2026-06-09 | Doc: 33215 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (261, 15, 65.00, 'Efectivo', '33215', '2026-06-09T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: BERNAOLA CARHUAZ DE PRADO FLORENCIA | Fecha: 2026-06-04 | Doc: 33191 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (261, 15, 65.00, 'Efectivo', '33191', '2026-06-04T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: BRAVO HEREDIA ANA MARITZA | Fecha: 2026-06-03 | Doc: 33182 | Total: S/ 259.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (161, 16, 259.00, 'Efectivo', '33182', '2026-06-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, FUMIGACION 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/118 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: FUMIGACION 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: BURGA CARRASCO ELIDA | Fecha: 2026-06-10 | Doc: 33231 | Total: S/ 107.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (66, 17, 107.00, 'Efectivo', '33231', '2026-06-10T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/11, P. SOCIAL 2026/11, G. ADM 2026/12')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/11 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/11 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/12 S/42 — registrado en pago pero sin monto_id

  -- Socio: BURGA CARRASCO ELIDA | Fecha: 2026-06-25 | Doc: 33318 | Total: S/ 369.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (66, 17, 369.00, 'Efectivo', '33318', '2026-06-25T12:00:00+00:00', 'Pago 01-08 jul 2026: MULTA 27/11/2025 2026/11, G. ADM 2026/03, P. SOCIAL 2026/03, MULTA 27/11/2025 2026/03, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: MULTA 27/11/2025 2026/11 S/56.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: MULTA 27/11/2025 2026/03 S/56.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/55 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/6 — registrado en pago pero sin monto_id

  -- Socio: BURGA CARRASCO ELIDA | Fecha: 2026-06-10 | Doc: 33232 | Total: S/ 84.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (66, 17, 84.00, 'Efectivo', '33232', '2026-06-10T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/12, P. SOCIAL 2026/12, G. ADM 2026/02, P. SOCIAL 2026/02')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/12 S/18 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/12 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/02 S/56 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/02 S/5 — registrado en pago pero sin monto_id

  -- Socio: BURGA CARRASCO ELIDA | Fecha: 2026-06-03 | Doc: 33185 | Total: S/ 146.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (66, 17, 146.50, 'Efectivo', '33185', '2026-06-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/02, AGUA 2026/02, LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/02 S/33.9 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/02 S/10 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/03 S/35.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/55 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: CABALLERO CALZADO GLADYS VICTORIA | Fecha: 2026-06-22 | Doc: 33303 | Total: S/ 25.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (203, 18, 25.30, 'Efectivo', '33303', '2026-06-22T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/8.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/5.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- Socio: CABERO MENDOZA GLORIA LUCINDA | Fecha: 2026-06-10 | Doc: 33233 | Total: S/ 120.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (108, 19, 120.00, 'Efectivo', '33233', '2026-06-10T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, DEPOSITO 8 - D2 2026/03, LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/28.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO 8 - D2 2026/03 S/49.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/30 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: CABERO MENDOZA GLORIA LUCINDA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 233.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (108, 19, 233.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06, DEPOSITO 8 - D2 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11550: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11550, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11550;

  -- Deuda id=11551: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11551, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11551;

  -- Deuda id=11552: DEPOSITO 8 - D2 2026/06 | Monto deuda: S/200 | Pagado: S/168 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11552, 168.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11552;

  -- Socio: CAHUANA VDA DE DAVILA VICENTINA | Fecha: 2026-06-24 | Doc: 33316 | Total: S/ 190.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (254, 20, 190.30, 'Efectivo', '33316', '2026-06-24T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/55.9 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/134.4 — registrado en pago pero sin monto_id

  -- Socio: CAHUANA VDA DE DAVILA VICENTINA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 40.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (254, 20, 40.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11554: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/40 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11554, 40.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11554;

  -- Socio: CAJALEON CARRASCO LUIS ENRIQUE | Fecha: 2026-06-03 | Doc: 33188 | Total: S/ 100.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (173, 21, 100.00, 'Efectivo', '33188', '2026-06-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/50 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/44 — registrado en pago pero sin monto_id

  -- Socio: CAJALEON CARRASCO LUIS ENRIQUE | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 40.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (173, 21, 40.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11556: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/40 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11556, 40.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11556;

  -- Socio: CALDERON VERA SEGUNDO ALCIDES | Fecha: 2026-06-30 | Doc: 33332 | Total: S/ 324.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (278, 23, 324.80, 'Efectivo', '33332', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/194.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/65.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: CALLE ALVAREZ MARCO ANTONIO | Fecha: 2026-06-01 | Doc: 33162 | Total: S/ 200.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (244, 24, 200.00, 'Efectivo', '33162', '2026-06-01T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO 10 - D2 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: DEPOSITO 10 - D2 2026/04 S/200 — registrado en pago pero sin monto_id

  -- Socio: CALLE ALVAREZ MARCO ANTONIO | Fecha: 2026-06-16 | Doc: 33266 | Total: S/ 100.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (244, 24, 100.00, 'Efectivo', '33266', '2026-06-16T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: DEPOSITO 2026/05 S/100 — registrado en pago pero sin monto_id

  -- Socio: CALLE ALVAREZ MARCO ANTONIO | Fecha: 2026-06-16 | Doc: 33267 | Total: S/ 100.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (244, 24, 100.00, 'Efectivo', '33267', '2026-06-16T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO 10 - D2 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: DEPOSITO 10 - D2 2026/05 S/100 — registrado en pago pero sin monto_id

  -- Socio: CALLE ALVAREZ MARCO ANTONIO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (244, 24, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11562: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11562, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11562;

  -- Deuda id=11563: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11563, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11563;

  -- Socio: CALLE ALVAREZ MARCO ANTONIO | Fecha: 2026-06-30 | Doc: 33341 | Total: S/ 200.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (244, 24, 200.00, 'Efectivo', '33341', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO 10 - D2 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11564: DEPOSITO 10 - D2 2026/06 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11564, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11564;

  -- Socio: CALLE CALLE FIDEL | Fecha: 2026-06-15 | Doc: 33255 | Total: S/ 35.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (146, 25, 35.00, 'Efectivo', '33255', '2026-06-15T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/29 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: CALLE CALLE FIDEL | Fecha: 2026-06-30 | Doc: 33342 | Total: S/ 38.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (146, 25, 38.00, 'Efectivo', '33342', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/32 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- Socio: CAMPUZANO CABELLO VICENTA DONATILA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (196, 26, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11567: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11567, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11567;

  -- Deuda id=11568: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11568, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11568;

  -- Socio: CARDENA VILLAFUERTE ALEJANDRINA | Fecha: 2026-06-10 | Doc: 33225 | Total: S/ 11.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (62, 27, 11.00, 'Efectivo', '33225', '2026-06-10T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: CARDENA VILLAFUERTE ALEJANDRINA | Fecha: 2026-06-10 | Doc: 33224 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (62, 27, 65.00, 'Efectivo', '33224', '2026-06-10T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: CARPIO VASQUEZ TEOFILA | Fecha: 2026-06-02 | Doc: 33171 | Total: S/ 10.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (277, 28, 10.00, 'Efectivo', '33171', '2026-06-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/10 — registrado en pago pero sin monto_id

  -- Socio: CARPIO VASQUEZ TEOFILA | Fecha: 2026-06-04 | Doc: 33194 | Total: S/ 10.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (277, 28, 10.00, 'Efectivo', '33194', '2026-06-04T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/10 — registrado en pago pero sin monto_id

  -- Socio: CARRASCO SALVATIERRA FELICITA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 200.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (172, 29, 200.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10911: LUZ 2026/05 | Monto deuda: S/210 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10911, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10911;

  -- Socio: CARTAGENA MAMANI BENJAMIN D | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (260, 30, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11575: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11575, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11575;

  -- Deuda id=11576: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11576, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11576;

  -- Socio: CARTAGENA PALOMINO ALVARO BENJAMIN | Fecha: 2026-06-25 | Doc: 33320 | Total: S/ 180.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (185, 31, 180.20, 'Efectivo', '33320', '2026-06-25T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/49 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/13.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/49.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/12.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/45.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/10.1 — registrado en pago pero sin monto_id

  -- Socio: CASTRO ALEJANDRO HORTENCIA LUCILA | Fecha: 2026-06-25 | Doc: 33322 | Total: S/ 85.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (175, 32, 85.40, 'Efectivo', '33322', '2026-06-25T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/03 S/25 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/21.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: FUMIGACION 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/16.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- Socio: CASTRO GUTIERREZ AQUILA LUCRECIA | Fecha: 2026-06-08 | Doc: 33209 | Total: S/ 294.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (72, 33, 294.00, 'Efectivo', '33209', '2026-06-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/280 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/14 — registrado en pago pero sin monto_id

  -- Socio: CASTRO GUTIERREZ AQUILA LUCRECIA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (72, 33, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11582: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11582, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11582;

  -- Deuda id=11583: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11583, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11583;

  -- Socio: CCOYLLO BUSTILLOS DEYSI KAREN | Fecha: 2026-06-17 | Doc: 33281 | Total: S/ 447.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (70, 34, 447.00, 'Efectivo', '33281', '2026-06-17T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/185 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/185 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: CCOYLLO CHINCHAY DANIEL MASIA | Fecha: 2026-06-15 | Doc: 33261 | Total: S/ 127.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (158, 35, 127.30, 'Efectivo', '33261', '2026-06-15T12:00:00+00:00', 'Pago 01-08 jul 2026: MULTA X CAPACITACION 2026/01, LUZ 2026/03, AGUA 2026/03, MULTA 26/03/2026 2026/03, LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: MULTA X CAPACITACION 2026/01 S/28.3 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/03 S/14.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: MULTA 26/03/2026 2026/03 S/56.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/16 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: CCOYLLO CHINCHAY DANIEL MASIA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (158, 35, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11586: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11586, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11586;

  -- Deuda id=11587: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11587, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11587;

  -- Socio: CCOYLLO CHINCHAY JUDITH NATY | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (144, 36, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11588: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11588, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11588;

  -- Deuda id=11589: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11589, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11589;

  -- Socio: CCOYLLO MAYHUASCA ALEXIS | Fecha: 2026-06-16 | Doc: 33265 | Total: S/ 125.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (205, 37, 125.80, 'Efectivo', '33265', '2026-06-16T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/20 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/32.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/40 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/22.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: CCOYLLO MAYHUASCA ALEXIS | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (205, 37, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11590: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11590, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11590;

  -- Deuda id=11591: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11591, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11591;

  -- Socio: CCOYLLO POLANCO DANIEL | Fecha: 2026-06-04 | Doc: 33195 | Total: S/ 459.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (212, 38, 459.40, 'Efectivo', '33195', '2026-06-04T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/388.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: CCOYLLO POLANCO DANIEL | Fecha: 2026-06-26 | Doc: 33330 | Total: S/ 447.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (212, 38, 447.80, 'Efectivo', '33330', '2026-06-26T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/376.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: CCOYLLO POLANCO GERMAN | Fecha: 2026-06-16 | Doc: 33268 | Total: S/ 239.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (132, 39, 239.50, 'Efectivo', '33268', '2026-06-16T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/14.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/18 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: CERDA YUPANQUI CARMEN ROSA | Fecha: 2026-06-02 | Doc: 33168 | Total: S/ 31.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (198, 40, 31.50, 'Efectivo', '33168', '2026-06-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/25.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: CERDA YUPANQUI CARMEN ROSA | Fecha: 2026-06-30 | Doc: 33338 | Total: S/ 554.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (198, 40, 554.80, 'Efectivo', '33338', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO 2 - D1 2026/04, LUZ 2026/05, AGUA 2026/05, DEPOSITO 2 - D1 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06, G. ADM 2026/07, P. SOCIAL 2026/07')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11921: DEPOSITO 2 - D1 2026/04 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11921, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11921;

  -- SIN DEUDA: LUZ 2026/05 S/18.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- Deuda id=11922: DEPOSITO 2 - D1 2026/05 | Monto deuda: S/200 | Pagado: S/200 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11922, 200.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11922;

  -- SIN DEUDA: G. ADM 2026/06 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/06 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/07 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/07 S/5 — registrado en pago pero sin monto_id

  -- Socio: CERDA YUPANQUI CARMEN ROSA | Fecha: 2026-06-30 | Doc: 33339 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (198, 40, 65.00, 'Efectivo', '33339', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/08, P. SOCIAL 2026/08')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/08 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/08 S/5 — registrado en pago pero sin monto_id

  -- Socio: CHUCHULLO HACHA JOSE PEDRO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 665.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (164, 44, 665.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/600 — registrado en pago pero sin monto_id

  -- Deuda id=11605: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11605, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11605;

  -- Deuda id=11606: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11606, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11606;

  -- Socio: CHIRINOS CABRACANCHA MARIA LOURDES | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 55.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (174, 42, 55.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11601: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/50 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11601, 50.00);

  -- Deuda id=11602: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11602, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11602;

  -- Socio: CHOQUEHUAMANI FELIX CEFERINO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 80.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (188, 43, 80.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10969: LUZ 2026/05 | Monto deuda: S/13.1 | Pagado: S/13.1 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10969, 13.10);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10969;

  -- Deuda id=10970: AGUA 2026/05 | Monto deuda: S/37.3 | Pagado: S/1.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10970, 1.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10970;

  -- Deuda id=11603: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11603, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11603;

  -- Deuda id=11604: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11604, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11604;

  -- Socio: CHUCHULLO HACHA JOSE PEDRO | Fecha: 2026-06-12 | Doc: 33247 | Total: S/ 189.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (164, 44, 189.00, 'Efectivo', '33247', '2026-06-12T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, DEPOSITO 2 - D3 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/33 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO 2 - D3 2026/04 S/150 — registrado en pago pero sin monto_id

  -- Socio: CHUCHULLO HACHA JOSE PEDRO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (164, 44, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/06 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/06 S/5 — registrado en pago pero sin monto_id

  -- Socio: CLEMENTE ALLER CIRILA | Fecha: 2026-06-19 | Doc: 33294 | Total: S/ 246.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (90, 45, 246.90, 'Efectivo', '33294', '2026-06-19T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/94.9 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/75 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: CLEMENTE ALLER CIRILA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 20.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (90, 45, 20.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11608: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/20 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11608, 20.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11608;

  -- Socio: CORNEJO DONATO DE CORDOVA ESTELA PILAR | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 30.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (223, 47, 30.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11612: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/30 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11612, 30.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11612;

  -- Socio: CRUZ JARAMILLO LUIS | Fecha: 2026-06-18 | Doc: 33289 | Total: S/ 31.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (262, 48, 31.20, 'Efectivo', '33289', '2026-06-18T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/25.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- Socio: CRUZ JARAMILLO LUIS | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 24.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (262, 48, 24.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/06 S/24 — registrado en pago pero sin monto_id

  -- Socio: CUCHO DE LA CRUZ SAUL PEDRO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 40.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (271, 49, 40.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11615: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/40 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11615, 40.00);

  -- Socio: CUEVAS MAYO ENRIQUE | Fecha: 2026-06-12 | Doc: 33248 | Total: S/ 185.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (168, 50, 185.00, 'Efectivo', '33248', '2026-06-12T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/49 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: CUEVAS MAYO ENRIQUE | Fecha: 2026-06-17 | Doc: 33286 | Total: S/ 55.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (168, 50, 55.00, 'Efectivo', '33286', '2026-06-17T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/49 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- Socio: CULE CARRASCO HAYDEE MONICA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 150.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (266, 51, 150.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06, LUZ 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11619: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11619, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11619;

  -- Deuda id=11620: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11620, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11620;

  -- SIN DEUDA: LUZ 2026/06 S/85 — registrado en pago pero sin monto_id

  -- Socio: CUSI LAURA SONIA | Fecha: 2026-06-05 | Doc: 33203 | Total: S/ 52.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (249, 52, 52.30, 'Efectivo', '33203', '2026-06-05T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/16.9 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/23.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: CUSI LAURA SONIA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (249, 52, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11621: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11621, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11621;

  -- Deuda id=11622: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11622, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11622;

  -- Socio: DAVILA CAHUANA DE PAZ MARISOL | Fecha: 2026-06-09 | Doc: 33217 | Total: S/ 130.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (148, 54, 130.00, 'Efectivo', '33217', '2026-06-09T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/03 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: DAVILA CAHUANA DE PAZ MARISOL | Fecha: 2026-06-03 | Doc: 33186 | Total: S/ 200.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (148, 54, 200.00, 'Efectivo', '33186', '2026-06-03T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO 7 - D2 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: DEPOSITO 7 - D2 2026/05 S/200 — registrado en pago pero sin monto_id

  -- Socio: DE LA CRUZ ESTEBAN JOSE LUIS | Fecha: 2026-06-05 | Doc: 33202 | Total: S/ 104.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (220, 55, 104.30, 'Efectivo', '33202', '2026-06-05T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/80.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/23.7 — registrado en pago pero sin monto_id

  -- Socio: DE LA CRUZ ESTEBAN JOSE LUIS | Fecha: 2026-06-22 | Doc: 33297 | Total: S/ 71.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (220, 55, 71.20, 'Efectivo', '33297', '2026-06-22T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/53 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/18.2 — registrado en pago pero sin monto_id

  -- Socio: DE LA CRUZ ESTEBAN JOSE LUIS | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (220, 55, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11626: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11626, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11626;

  -- Deuda id=11627: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11627, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11627;

  -- Socio: ESPEJO URBANO ROSA FLORENCIA | Fecha: 2026-06-08 | Doc: 33210 | Total: S/ 235.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (106, 56, 235.00, 'Efectivo', '33210', '2026-06-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/99 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: ESTELA SUAREZ ELVIA | Fecha: 2026-06-16 | Doc: 33264 | Total: S/ 331.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (190, 57, 331.80, 'Efectivo', '33264', '2026-06-16T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/214.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/52.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: ESTRADA CHACON OSCAR ALFREDO | Fecha: 2026-06-15 | Doc: 33257 | Total: S/ 251.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (257, 58, 251.20, 'Efectivo', '33257', '2026-06-15T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/18.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/114.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/54 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/54 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: ESTRADA CHACON OSCAR ALFREDO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 8.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (257, 58, 8.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11632: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/8 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11632, 8.00);

  -- Socio: FALCON CHIARA HECTOR MARCIAL | Fecha: 2026-06-10 | Doc: 33230 | Total: S/ 276.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (64, 59, 276.70, 'Efectivo', '33230', '2026-06-10T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/01, AGUA 2026/01, LUZ 2026/02, AGUA 2026/02, LUZ 2026/03, AGUA 2026/03, MULTA 26/03/2026 2026/03, LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/01 S/49.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/01 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/02 S/48.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/02 S/10 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/03 S/50.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: MULTA 26/03/2026 2026/03 S/56.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/45 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: FLORES FLORES IRENE BERTILIA | Fecha: 2026-06-08 | Doc: 33207 | Total: S/ 746.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (247, 60, 746.80, 'Efectivo', '33207', '2026-06-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/577.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/104.3 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: FLORES FLORES IRENE BERTILIA | Fecha: 2026-06-16 | Doc: 33273 | Total: S/ 722.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (247, 60, 722.00, 'Efectivo', '33273', '2026-06-16T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/538.3 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/118 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/06 S/0.7 — registrado en pago pero sin monto_id

  -- Socio: FLORES FLORES UMBELINA DORA | Fecha: 2026-06-11 | Doc: 33241 | Total: S/ 250.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (258, 61, 250.50, 'Efectivo', '33241', '2026-06-11T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/250.5 — registrado en pago pero sin monto_id

  -- Socio: FLORES FLORES UMBELINA DORA | Fecha: 2026-06-15 | Doc: 33258 | Total: S/ 236.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (258, 61, 236.10, 'Efectivo', '33258', '2026-06-15T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/8.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/109.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/54 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/54 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: FLORES FLORES UMBELINA DORA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 8.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (258, 61, 8.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11638: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/8 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11638, 8.00);

  -- Socio: FLORES YATO FRANCISCA DOLORES | Fecha: 2026-06-30 | Doc: 33337 | Total: S/ 204.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (84, 62, 204.00, 'Efectivo', '33337', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/68 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/06 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/06 S/5 — registrado en pago pero sin monto_id

  -- Socio: GELDRES REVILLA MIGUEL ANGEL | Fecha: 2026-06-22 | Doc: 33302 | Total: S/ 162.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (204, 64, 162.00, 'Efectivo', '33302', '2026-06-22T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/37.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/12.9 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/32.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/13.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: GUTIERREZ CASTILLO JORGE JAIME | Fecha: 2026-06-15 | Doc: 33260 | Total: S/ 295.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (285, 65, 295.20, 'Efectivo', '33260', '2026-06-15T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/54.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/241 — registrado en pago pero sin monto_id

  -- Socio: GUTIERREZ CASTILLO TERESA JESUS | Fecha: 2026-06-24 | Doc: 33313 | Total: S/ 100.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (180, 66, 100.00, 'Efectivo', '33313', '2026-06-24T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/13 — registrado en pago pero sin monto_id

  -- Socio: GUTIERREZ FLORES ROGER REYNAN | Fecha: 2026-06-10 | Doc: 33228 | Total: S/ 427.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (112, 68, 427.40, 'Efectivo', '33228', '2026-06-10T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/117 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/180.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: HALIRE YUCRA JOSUE JAASIEL | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (195, 69, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11654: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11654, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11654;

  -- Deuda id=11655: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11655, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11655;

  -- Socio: HEREDIA MUNOZ DE BRAVO MARIA | Fecha: 2026-06-03 | Doc: 33184 | Total: S/ 98.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (245, 70, 98.70, 'Efectivo', '33184', '2026-06-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/8.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/8.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/16 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/44 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: HUAMANI ROMERO DOMITILA CLEOFE | Fecha: 2026-06-15 | Doc: 33253 | Total: S/ 94.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (1, 72, 94.50, 'Efectivo', '33253', '2026-06-15T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/94.5 — registrado en pago pero sin monto_id

  -- Socio: HUAMANI ROMERO DOMITILA CLEOFE | Fecha: 2026-06-15 | Doc: 33254 | Total: S/ 100.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (1, 72, 100.50, 'Efectivo', '33254', '2026-06-15T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/94.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: HUASHUAYO GOMEZ EUDOSIA | Fecha: 2026-06-08 | Doc: 33214 | Total: S/ 350.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (52, 73, 350.00, 'Efectivo', '33214', '2026-06-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05, DEPOSITO 2 - D2 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/79 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO 2 - D2 2026/05 S/200 — registrado en pago pero sin monto_id

  -- Socio: HUAYHUALLA DE LOPEZ DONATILA | Fecha: 2026-06-04 | Doc: 33200 | Total: S/ 219.60
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (208, 74, 219.60, 'Efectivo', '33200', '2026-06-04T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/149.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/70.5 — registrado en pago pero sin monto_id

  -- Socio: HUAYHUALLA DE LOPEZ DONATILA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (208, 74, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11664: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11664, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11664;

  -- Deuda id=11665: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11665, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11665;

  -- Socio: JARA ALVARES CRISTALINA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 40.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (256, 76, 40.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, LUZ 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=8056: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/0.1 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8056, 0.10);

  -- Deuda id=11093: LUZ 2026/05 | Monto deuda: S/10.7 | Pagado: S/10.7 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11093, 10.70);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11093;

  -- Deuda id=11094: AGUA 2026/05 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11094, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11094;

  -- SIN DEUDA: LUZ 2026/06 S/23.2 — registrado en pago pero sin monto_id

  -- Socio: JARA ALVAREZ SANTOS PEDRO | Fecha: 2026-06-19 | Doc: 33295 | Total: S/ 10.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (183, 78, 10.00, 'Efectivo', '33295', '2026-06-19T12:00:00+00:00', 'Pago 01-08 jul 2026: USO DE LUZ 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: USO DE LUZ 2026/06 S/10 — registrado en pago pero sin monto_id

  -- Socio: JARA ALVAREZ SANTOS PEDRO | Fecha: 2026-06-24 | Doc: 33315 | Total: S/ 10.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (183, 78, 10.00, 'Efectivo', '33315', '2026-06-24T12:00:00+00:00', 'Pago 01-08 jul 2026: USO DE LUZ 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: USO DE LUZ 2026/06 S/10 — registrado en pago pero sin monto_id

  -- Socio: JUAREZ CUELLAR LEONOR | Fecha: 2026-06-10 | Doc: 33227 | Total: S/ 396.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (128, 79, 396.80, 'Efectivo', '33227', '2026-06-10T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/135 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/196.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: LAGOS LUNA DE LEYVA ZAIDA LUISA | Fecha: 2026-06-02 | Doc: 33167 | Total: S/ 87.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (86, 80, 87.00, 'Efectivo', '33167', '2026-06-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/45 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/30 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: LAGOS LUNA DE LEYVA ZAIDA LUISA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (86, 80, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11674: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11674, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11674;

  -- Deuda id=11675: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11675, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11675;

  -- Socio: LOPEZ HUAYHUALLA NELLY NATIVIDAD | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (264, 82, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11679: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11679, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11679;

  -- Deuda id=11680: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11680, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11680;

  -- Socio: LUJAN GONZALES MARINO JUAN | Fecha: 2026-06-20 | Doc: 33296 | Total: S/ 146.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (272, 83, 146.70, 'Efectivo', '33296', '2026-06-20T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/120 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/26.7 — registrado en pago pero sin monto_id

  -- Socio: MALLQUI JULCA ALEJANDRINO TEODORO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (286, 84, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11683: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11683, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11683;

  -- Deuda id=11684: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11684, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11684;

  -- Socio: MAYTA MATOS HERMELINDA | Fecha: 2026-06-15 | Doc: 33259 | Total: S/ 100.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (184, 94, 100.00, 'Efectivo', '33259', '2026-06-15T12:00:00+00:00', 'Pago 01-08 jul 2026: AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: AGUA 2026/04 S/100 — registrado en pago pero sin monto_id

  -- Socio: MAYTA MATOS HERMELINDA | Fecha: 2026-06-30 | Doc: 33340 | Total: S/ 59.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (184, 94, 59.50, 'Efectivo', '33340', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/53.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/5.7 — registrado en pago pero sin monto_id

  -- Socio: MORENO CHAVEZ RAFAEL FREDY | Fecha: 2026-06-04 | Doc: 33199 | Total: S/ 118.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (179, 100, 118.80, 'Efectivo', '33199', '2026-06-04T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/47.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: HUAMAN YNCA VISITACION | Fecha: 2026-06-03 | Doc: 33175 | Total: S/ 100.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (235, 71, 100.00, 'Efectivo', '33175', '2026-06-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/19 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- Deuda id=7936: LUZ 2026/04 | Monto deuda: S/27 | Pagado: S/10 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 7936, 10.00);

  -- Socio: ISIDRO MARIN CARLOS DANIEL | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (191, 75, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11695: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11695, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11695;

  -- Deuda id=11696: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11696, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11696;

  -- Socio: MARIN LONDONE EDUARDO SANTIAGO | Fecha: 2026-06-22 | Doc: 33301 | Total: S/ 168.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (270, 87, 168.90, 'Efectivo', '33301', '2026-06-22T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/37.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/39.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/38.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/30 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: MARIN LONDONE EDUARDO SANTIAGO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (270, 87, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11697: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11697, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11697;

  -- Deuda id=11698: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11698, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11698;

  -- Socio: MARIN LONDONE MARIA LUZ | Fecha: 2026-06-17 | Doc: 33279 | Total: S/ 50.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (177, 88, 50.00, 'Efectivo', '33279', '2026-06-17T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/22.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/21.8 — registrado en pago pero sin monto_id

  -- Socio: MARIN LONDONE MARIA LUZ | Fecha: 2026-06-17 | Doc: 33280 | Total: S/ 50.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (177, 88, 50.00, 'Efectivo', '33280', '2026-06-17T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03, DEPOSITO 5 - D1 2026/03')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/03 S/38.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO 5 - D1 2026/03 S/6.8 — registrado en pago pero sin monto_id

  -- Socio: MEDINA GUTIERREZ HONORATA | Fecha: 2026-06-26 | Doc: 33325 | Total: S/ 92.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (268, 95, 92.80, 'Efectivo', '33325', '2026-06-26T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/8.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/7.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: MAYHUASCA BASTIDAS DE TORRES CLUDDY AYDE | Fecha: 2026-06-16 | Doc: 33271 | Total: S/ 469.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (230, 90, 469.10, 'Efectivo', '33271', '2026-06-16T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/401 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/33.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/30 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: MAYHUASCA BASTIDAS DE TORRES CLUDDY AYDE | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (230, 90, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11706: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11706, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11706;

  -- Deuda id=11707: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11707, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11707;

  -- Socio: MAYHUASCA BASTIDAS MARILU | Fecha: 2026-06-26 | Doc: 33324 | Total: S/ 135.60
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (280, 91, 135.60, 'Efectivo', '33324', '2026-06-26T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/13.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/34.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/14.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/40.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/13.3 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/20 — registrado en pago pero sin monto_id

  -- Socio: MAYHUASCA BASTIDAS MARILU | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (280, 91, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11708: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11708, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11708;

  -- Deuda id=11709: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11709, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11709;

  -- Socio: MAYTA COLQUI VIOLETA | Fecha: 2026-06-01 | Doc: 33161 | Total: S/ 44.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (253, 93, 44.30, 'Efectivo', '33161', '2026-06-01T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/28.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/15.8 — registrado en pago pero sin monto_id

  -- Socio: MAYTA COLQUI VIOLETA | Fecha: 2026-06-26 | Doc: 33323 | Total: S/ 43.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (253, 93, 43.00, 'Efectivo', '33323', '2026-06-26T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/29 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/14 — registrado en pago pero sin monto_id

  -- Socio: MAYTA COLQUI VIOLETA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (253, 93, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11712: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11712, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11712;

  -- Deuda id=11713: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11713, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11713;

  -- Socio: MEDINA JOTA DE CACERES VICENTA | Fecha: 2026-06-25 | Doc: 33317 | Total: S/ 351.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (29, 96, 351.00, 'Efectivo', '33317', '2026-06-25T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/135 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/139 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: MEDINA MEDRANO JUAN CARLOS | Fecha: 2026-06-11 | Doc: 33234 | Total: S/ 130.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (238, 97, 130.00, 'Efectivo', '33234', '2026-06-11T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: MELO BACA MARINA | Fecha: 2026-06-25 | Doc: 33319 | Total: S/ 1521.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (217, 98, 1521.30, 'Efectivo', '33319', '2026-06-25T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/805.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/28.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/654.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/32.5 — registrado en pago pero sin monto_id

  -- Socio: MELO BACA MARINA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (217, 98, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11718: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11718, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11718;

  -- Deuda id=11719: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11719, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11719;

  -- Socio: MESIA CRUZ GLADYS | Fecha: 2026-06-17 | Doc: 33282 | Total: S/ 221.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (201, 99, 221.90, 'Efectivo', '33282', '2026-06-17T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/108.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/101.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- Socio: MESIA CRUZ GLADYS | Fecha: 2026-06-17 | Doc: 33283 | Total: S/ 130.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (201, 99, 130.00, 'Efectivo', '33283', '2026-06-17T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/06 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/06 S/5 — registrado en pago pero sin monto_id

  -- Socio: MESIA CRUZ GLADYS | Fecha: 2026-06-17 | Doc: 33284 | Total: S/ 400.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (201, 99, 400.00, 'Efectivo', '33284', '2026-06-17T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO 4 - D1 2026/05, DEPOSITO 4 - D1 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: DEPOSITO 4 - D1 2026/05 S/200 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO 4 - D1 2026/06 S/200 — registrado en pago pero sin monto_id

  -- Socio: NICHO LOPEZ ESTHEPANY CARICIA | Fecha: 2026-06-10 | Doc: 33221 | Total: S/ 566.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (239, 101, 566.10, 'Efectivo', '33221', '2026-06-10T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/433.3 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/67.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: NAHUI RUIZ AURELIO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (156, 102, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11722: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11722, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11722;

  -- Deuda id=11723: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11723, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11723;

  -- Socio: OJEDA CAMPOS EDSON JUNIOR | Fecha: 2026-06-08 | Doc: 33206 | Total: S/ 746.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (228, 103, 746.50, 'Efectivo', '33206', '2026-06-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/717.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/29.3 — registrado en pago pero sin monto_id

  -- Socio: OJEDA CAMPOS EDSON JUNIOR | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (228, 103, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11724: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11724, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11724;

  -- Deuda id=11725: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11725, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11725;

  -- Socio: OQUENDO ARISACA MELESIA ROSARIO | Fecha: 2026-06-30 | Doc: 33336 | Total: S/ 180.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (214, 104, 180.40, 'Efectivo', '33336', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/44.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/06 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/06 S/5 — registrado en pago pero sin monto_id

  -- Socio: OQUENDO QUISPE JESSICA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (267, 105, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11728: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11728, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11728;

  -- Deuda id=11729: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11729, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11729;

  -- Socio: OQUENDO QUISPE MIGUEL EUFRACIO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 300.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (241, 106, 300.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06, G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11730: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11730, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11730;

  -- Deuda id=11731: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11731, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11731;

  -- SIN DEUDA: G. ADM 2026/06 S/235 — registrado en pago pero sin monto_id

  -- Socio: ORTIZ NAUPA WELINTONH | Fecha: 2026-06-17 | Doc: 33288 | Total: S/ 200.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (279, 108, 200.10, 'Efectivo', '33288', '2026-06-17T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/154.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/10.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/30 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: ORTIZ NAUPA WELINTONH | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 42.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (279, 108, 42.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11732: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/42 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11732, 42.00);

  -- Socio: PACOMPIA CARDENA GIOVANNI | Fecha: 2026-06-10 | Doc: 33223 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (94, 109, 65.00, 'Efectivo', '33223', '2026-06-10T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: PALOMINO HANCCO CECILIA | Fecha: 2026-06-22 | Doc: 33299 | Total: S/ 392.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (259, 110, 392.10, 'Efectivo', '33299', '2026-06-22T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/306.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/85.9 — registrado en pago pero sin monto_id

  -- Socio: PALOMINO HANCCO CECILIA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (259, 110, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11736: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11736, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11736;

  -- Deuda id=11737: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11737, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11737;

  -- Socio: PALOMINO TENORIO SILVIO EDUARDO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 190.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (288, 111, 190.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, G. ADM 2026/06, DEPOSITO 4 - D2 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=8795: LUZ 2026/04 | Monto deuda: S/13.7 | Pagado: S/9.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8795, 9.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8795;

  -- Deuda id=8798: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 8798, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 8798;

  -- Deuda id=11240: LUZ 2026/05 | Monto deuda: S/27.4 | Pagado: S/3.1 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11240, 3.10);

  -- Deuda id=11738: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/38 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11738, 38.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11738;

  -- Deuda id=11740: DEPOSITO 4 - D2 2026/06 | Monto deuda: S/200 | Pagado: S/133 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11740, 133.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11740;

  -- Socio: PALOMINO VELASQUEZ EUSEBIO | Fecha: 2026-06-01 | Doc: 33160 | Total: S/ 652.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (242, 112, 652.10, 'Efectivo', '33160', '2026-06-01T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/614.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/37.3 — registrado en pago pero sin monto_id

  -- Socio: PALOMINO VELASQUEZ EUSEBIO | Fecha: 2026-06-19 | Doc: 33292 | Total: S/ 559.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (242, 112, 559.80, 'Efectivo', '33292', '2026-06-19T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/519.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/40.7 — registrado en pago pero sin monto_id

  -- Socio: PALOMINO VELASQUEZ EUSEBIO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 265.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (242, 112, 265.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06, LUZ 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11741: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11741, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11741;

  -- Deuda id=11742: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11742, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11742;

  -- SIN DEUDA: LUZ 2026/06 S/200 — registrado en pago pero sin monto_id

  -- Socio: PAREDES FLORES OSCAR ALFREDO | Fecha: 2026-06-08 | Doc: 33211 | Total: S/ 155.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (140, 113, 155.00, 'Efectivo', '33211', '2026-06-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/149 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- Socio: PAREDES FLORES OSCAR ALFREDO | Fecha: 2026-06-10 | Doc: 33222 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (140, 113, 65.00, 'Efectivo', '33222', '2026-06-10T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: PAREDES MORALES DIANA VONNETH | Fecha: 2026-06-30 | Doc: 33347 | Total: S/ 313.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (74, 114, 313.70, 'Efectivo', '33347', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/72.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/99 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: PEREZ PONCE DE ROMERO SATURNINA MARGARITA | Fecha: 2026-06-26 | Doc: 33326 | Total: S/ 190.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (281, 116, 190.10, 'Efectivo', '33326', '2026-06-26T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/60.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/53 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: PEREZ QUISPE EPIFANIA RICARDINA | Fecha: 2026-06-03 | Doc: 33180 | Total: S/ 84.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (114, 117, 84.50, 'Efectivo', '33180', '2026-06-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/39.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/33 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: PEREZ QUISPE EPIFANIA RICARDINA | Fecha: 2026-06-03 | Doc: 33181 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (114, 117, 65.00, 'Efectivo', '33181', '2026-06-03T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/03, P. SOCIAL 2026/03')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/03 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- Socio: PITTMAN CONCEPCION NELLY MARIA | Fecha: 2026-06-04 | Doc: 33197 | Total: S/ 51.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (102, 118, 51.00, 'Efectivo', '33197', '2026-06-04T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/45 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: PLAZA COSQUILLO ROSA ESTELA | Fecha: 2026-06-11 | Doc: 33235 | Total: S/ 146.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (233, 119, 146.00, 'Efectivo', '33235', '2026-06-11T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, FUMIGACION 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: FUMIGACION 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: PRADO LLANCARI ZOSIMA | Fecha: 2026-06-30 | Doc: 33345 | Total: S/ 113.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (118, 121, 113.00, 'Efectivo', '33345', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: MULTA 27/11/25 2026/11, MULTA 26/03/26 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: MULTA 27/11/25 2026/11 S/56.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: MULTA 26/03/26 2026/05 S/56.5 — registrado en pago pero sin monto_id

  -- Socio: PRADO LLANCARI ZOSIMA | Fecha: 2026-06-30 | Doc: 33344 | Total: S/ 210.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (118, 121, 210.00, 'Efectivo', '33344', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/74 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/06 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/06 S/5 — registrado en pago pero sin monto_id

  -- Socio: QUINTANA VIDAL GLICERIO | Fecha: 2026-06-18 | Doc: 33290 | Total: S/ 106.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (192, 122, 106.20, 'Efectivo', '33290', '2026-06-18T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/30.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/31.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/26.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- Socio: QUINTANA VIDAL GLICERIO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 10.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (192, 122, 10.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/06 S/10 — registrado en pago pero sin monto_id

  -- Socio: QUISPE AGUILAR DE PALOMINO DOROTEA | Fecha: 2026-06-17 | Doc: 33277 | Total: S/ 417.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (227, 126, 417.50, 'Efectivo', '33277', '2026-06-17T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/376.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/30 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: QUISPE AGUILAR DE PALOMINO DOROTEA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (227, 126, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11763: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11763, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11763;

  -- Deuda id=11764: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11764, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11764;

  -- Socio: QUISPE CONSA MIGUEL | Fecha: 2026-06-16 | Doc: 33272 | Total: S/ 712.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (210, 123, 712.00, 'Efectivo', '33272', '2026-06-16T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/694 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/18 — registrado en pago pero sin monto_id

  -- Socio: QUISPE CONSA MIGUEL | Fecha: 2026-06-23 | Doc: 33308 | Total: S/ 666.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (210, 123, 666.70, 'Efectivo', '33308', '2026-06-23T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/653.3 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/13.4 — registrado en pago pero sin monto_id

  -- Socio: QUISPE CONSA MIGUEL | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (210, 123, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11765: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11765, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11765;

  -- Deuda id=11766: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11766, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11766;

  -- Socio: QUISPE CONSA VIDAL | Fecha: 2026-06-16 | Doc: 33263 | Total: S/ 655.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (186, 124, 655.80, 'Efectivo', '33263', '2026-06-16T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/575.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/15.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: QUISPE COPAYO ELIO CARLOS | Fecha: 2026-06-03 | Doc: 33178 | Total: S/ 1040.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (209, 125, 1040.80, 'Efectivo', '33178', '2026-06-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/1011.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/29.1 — registrado en pago pero sin monto_id

  -- Socio: QUISPE DURAN ADRIANA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 300.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (252, 127, 300.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06, LUZ 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11771: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11771, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11771;

  -- Deuda id=11772: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11772, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11772;

  -- SIN DEUDA: LUZ 2026/06 S/235 — registrado en pago pero sin monto_id

  -- Socio: QUISPE ORTEGA ROSA CARMEN | Fecha: 2026-06-12 | Doc: 33250 | Total: S/ 494.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (269, 128, 494.70, 'Efectivo', '33250', '2026-06-12T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/484.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/10 — registrado en pago pero sin monto_id

  -- Socio: QUISPE ORTEGA ROSA CARMEN | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (269, 128, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11773: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11773, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11773;

  -- Deuda id=11774: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11774, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11774;

  -- Socio: QUISPE URIBE LUCIANO | Fecha: 2026-06-27 | Doc: 33331 | Total: S/ 55.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (96, 129, 55.00, 'Efectivo', '33331', '2026-06-27T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/49 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- Socio: QUISPE URIBE LUCIANO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (96, 129, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11775: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11775, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11775;

  -- Deuda id=11776: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11776, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11776;

  -- Socio: REYES PEREZ DE VALENCIA NANCY VICTORIA | Fecha: 2026-06-04 | Doc: 33196 | Total: S/ 255.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (222, 131, 255.50, 'Efectivo', '33196', '2026-06-04T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, FUMIGACION 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/235.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/15 — registrado en pago pero sin monto_id

  -- SIN DEUDA: FUMIGACION 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: REYES PEREZ DE VALENCIA NANCY VICTORIA | Fecha: 2026-06-05 | Doc: 33205 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (222, 131, 65.00, 'Efectivo', '33205', '2026-06-05T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: REYES PEREZ DE VALENCIA NANCY VICTORIA | Fecha: 2026-06-26 | Doc: 33329 | Total: S/ 232.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (222, 131, 232.40, 'Efectivo', '33329', '2026-06-26T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/217.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/15 — registrado en pago pero sin monto_id

  -- Socio: REYES SANCHEZ MILENA GERALDINE | Fecha: 2026-06-03 | Doc: 33179 | Total: S/ 1406.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (215, 132, 1406.90, 'Efectivo', '33179', '2026-06-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/1256.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/20.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: RICSE SAYES TERESA REINA | Fecha: 2026-06-09 | Doc: 33216 | Total: S/ 63.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (231, 133, 63.00, 'Efectivo', '33216', '2026-06-09T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, FUMIGACION 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/49.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/8.9 — registrado en pago pero sin monto_id

  -- Deuda id=9299: FUMIGACION 2026/04 | Monto deuda: S/5 | Pagado: S/4.9 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9299, 4.90);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9299;

  -- Socio: RIVERA FERNANDEZ MARINA MAXILIANA | Fecha: 2026-06-24 | Doc: 33311 | Total: S/ 283.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (237, 135, 283.80, 'Efectivo', '33311', '2026-06-24T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/11.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/261.6 — registrado en pago pero sin monto_id

  -- Socio: RIVERA FERNANDEZ MARINA MAXILIANA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (237, 135, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11785: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11785, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11785;

  -- Deuda id=11786: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11786, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11786;

  -- Socio: RODRIGUEZ CORDOVA MARCOS | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 30.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (234, 137, 30.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11789: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/30 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11789, 30.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11789;

  -- Socio: RODRIGUEZ MORENO NORA | Fecha: 2026-06-26 | Doc: 33328 | Total: S/ 831.50
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (274, 138, 831.50, 'Efectivo', '33328', '2026-06-26T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/753.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/13.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: ROJAS CORNEJO ERICK JOHN | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 89.60
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (194, 139, 89.60, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=9445: LUZ 2026/04 | Monto deuda: S/29.6 | Pagado: S/29.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 9445, 29.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 9445;

  -- Deuda id=11793: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11793, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11793;

  -- Socio: ROMERO FLORES EDDNA | Fecha: 2026-06-18 | Doc: 33291 | Total: S/ 345.60
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (246, 141, 345.60, 'Efectivo', '33291', '2026-06-18T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/298.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/47.1 — registrado en pago pero sin monto_id

  -- Socio: ROMERO FLORES EDDNA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 60.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (246, 141, 60.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11795: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11795, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11795;

  -- Socio: SALAS MONTALVO JUDITH MAGALI | Fecha: 2026-06-01 | Doc: 33163 | Total: S/ 5.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (110, 145, 5.00, 'Efectivo', '33163', '2026-06-01T12:00:00+00:00', 'Pago 01-08 jul 2026: FUMIGACION 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: FUMIGACION 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: SALAS MONTALVO JUDITH MAGALI | Fecha: 2026-06-03 | Doc: 33177 | Total: S/ 95.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (110, 145, 95.00, 'Efectivo', '33177', '2026-06-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/95 — registrado en pago pero sin monto_id

  -- Socio: SALAS MONTALVO JUDITH MAGALI | Fecha: 2026-06-10 | Doc: 33226 | Total: S/ 231.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (110, 145, 231.20, 'Efectivo', '33226', '2026-06-10T12:00:00+00:00', 'Pago 01-08 jul 2026: AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: AGUA 2026/04 S/231.2 — registrado en pago pero sin monto_id

  -- Socio: SALAS MONTALVO JUDITH MAGALI | Fecha: 2026-06-23 | Doc: 33306 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (110, 145, 65.00, 'Efectivo', '33306', '2026-06-23T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/06 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/06 S/5 — registrado en pago pero sin monto_id

  -- Socio: ROJAS IGNACIO LIONILA JULIA | Fecha: 2026-06-03 | Doc: 33173 | Total: S/ 75.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (116, 140, 75.10, 'Efectivo', '33173', '2026-06-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/69.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- Socio: ROMERO NINAHUAMAN JAVIER JOHNNY | Fecha: 2026-06-16 | Doc: 33269 | Total: S/ 123.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (15, 142, 123.10, 'Efectivo', '33269', '2026-06-16T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/61.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/50 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: ROMERO YSLA ESTEBAN LIDIO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (251, 143, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11801: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11801, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11801;

  -- Deuda id=11802: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11802, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11802;

  -- Socio: SAAVEDRA CURIPUMA LUIS HUMBERTO | Fecha: 2026-06-11 | Doc: 33236 | Total: S/ 40.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (120, 144, 40.00, 'Efectivo', '33236', '2026-06-11T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/35 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: SAAVEDRA CURIPUMA LUIS HUMBERTO | Fecha: 2026-06-11 | Doc: 33237 | Total: S/ 115.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (120, 144, 115.00, 'Efectivo', '33237', '2026-06-11T12:00:00+00:00', 'Pago 01-08 jul 2026: AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: AGUA 2026/04 S/1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/52 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/52 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: SAAVEDRA CURIPUMA LUIS HUMBERTO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 8.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (120, 144, 8.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11803: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/8 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11803, 8.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11803;

  -- Socio: SALAS MONTALVO RUTH YOVANNA | Fecha: 2026-06-16 | Doc: 33270 | Total: S/ 139.20
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (36, 146, 139.20, 'Efectivo', '33270', '2026-06-16T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/67.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: SALAZAR CONCEPCION VICTORIA | Fecha: 2026-06-04 | Doc: 33189 | Total: S/ 19.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (197, 147, 19.00, 'Efectivo', '33189', '2026-06-04T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/13 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: SALAZAR CONCEPCION VICTORIA | Fecha: 2026-06-04 | Doc: 33190 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (197, 147, 65.00, 'Efectivo', '33190', '2026-06-04T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: SALVATIERRA OQUENDO ALLISON ADRIANA | Fecha: 2026-06-03 | Doc: 33174 | Total: S/ 341.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (243, 148, 341.00, 'Efectivo', '33174', '2026-06-03T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/76.9 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/264.1 — registrado en pago pero sin monto_id

  -- Socio: SALVATIERRA OQUENDO ALLISON ADRIANA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (243, 148, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11809: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11809, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11809;

  -- Deuda id=11810: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11810, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11810;

  -- Socio: SANCHEZ RODRIGUEZ JUDITH IRIS | Fecha: 2026-06-09 | Doc: 33218 | Total: S/ 94.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (284, 150, 94.80, 'Efectivo', '33218', '2026-06-09T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/47.1 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/47.7 — registrado en pago pero sin monto_id

  -- Socio: SANCHEZ RODRIGUEZ JUDITH IRIS | Fecha: 2026-06-19 | Doc: 33293 | Total: S/ 100.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (284, 150, 100.00, 'Efectivo', '33293', '2026-06-19T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/63.3 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/36.7 — registrado en pago pero sin monto_id

  -- Socio: SANCHEZ ASTO DE TORRES YOLANDA SOFIA TERESA | Fecha: 2026-06-30 | Doc: 33335 | Total: S/ 195.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (107, 149, 195.00, 'Efectivo', '33335', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/59 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/06 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/06 S/5 — registrado en pago pero sin monto_id

  -- Socio: SANCHEZ SOTO LUCIA YRENE | Fecha: 2026-06-22 | Doc: 33300 | Total: S/ 205.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (162, 151, 205.00, 'Efectivo', '33300', '2026-06-22T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, FUMIGACION 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
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

  -- Socio: SANTILLAN MESIA ZOILA MARIBEL | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 30.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (219, 152, 30.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11817: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/30 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11817, 30.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11817;

  -- Socio: SERMENO GUTIERREZ JAVIER YGNACIO | Fecha: 2026-06-02 | Doc: 33164 | Total: S/ 405.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (76, 154, 405.00, 'Efectivo', '33164', '2026-06-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/390 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/15 — registrado en pago pero sin monto_id

  -- Socio: SERMENO GUTIERREZ JAVIER YGNACIO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (76, 154, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11821: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11821, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11821;

  -- Deuda id=11822: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11822, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11822;

  -- Socio: SOTO GALLEGO DE VALERO SOFIA | Fecha: 2026-06-24 | Doc: 33310 | Total: S/ 211.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (181, 157, 211.40, 'Efectivo', '33310', '2026-06-24T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/38.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/30.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: SOTO VARGAS DE FLORES MARIA DEL CARMEN | Fecha: 2026-06-17 | Doc: 33276 | Total: S/ 26.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (193, 158, 26.80, 'Efectivo', '33276', '2026-06-17T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/7.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/7.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: SOTO VARGAS DE FLORES MARIA DEL CARMEN | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (193, 158, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11827: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11827, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11827;

  -- Deuda id=11828: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11828, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11828;

  -- Socio: ORDONEZ NICHO AZUL CARILE | Fecha: 2026-06-04 | Doc: 33193 | Total: S/ 433.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (276, 107, 433.00, 'Efectivo', '33193', '2026-06-04T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/108.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/117.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: TAIPE OQUENDO EUGENIO JOEL | Fecha: 2026-06-30 | Doc: 33334 | Total: S/ 195.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (88, 159, 195.00, 'Efectivo', '33334', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/59 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/06 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/06 S/5 — registrado en pago pero sin monto_id

  -- Socio: TELLO QUINTANA EDGAR ERASMO | Fecha: 2026-06-08 | Doc: 33208 | Total: S/ 392.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (182, 161, 392.90, 'Efectivo', '33208', '2026-06-08T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/154.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/173.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- Socio: TINEO CABRERA SONIA | Fecha: 2026-06-12 | Doc: 33252 | Total: S/ 49.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (207, 162, 49.80, 'Efectivo', '33252', '2026-06-12T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/33 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/16.8 — registrado en pago pero sin monto_id

  -- Socio: TINEO CABRERA SONIA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (207, 162, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11837: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11837, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11837;

  -- Deuda id=11838: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11838, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11838;

  -- Socio: TITO FALCON JESUSA RICARDINA | Fecha: 2026-06-01 | Doc: 33158 | Total: S/ 294.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (200, 164, 294.10, 'Efectivo', '33158', '2026-06-01T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/229.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/64.9 — registrado en pago pero sin monto_id

  -- Socio: TITO FALCON JESUSA RICARDINA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (200, 164, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11839: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11839, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11839;

  -- Deuda id=11840: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11840, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11840;

  -- Socio: TORRES ASTO FRANCISCO CONTESOR | Fecha: 2026-06-30 | Doc: 33343 | Total: S/ 183.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (283, 166, 183.70, 'Efectivo', '33343', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/48.3 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/70.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/06 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/06 S/5 — registrado en pago pero sin monto_id

  -- Socio: TORRES ASTO SANTOS NERY F | Fecha: 2026-06-12 | Doc: 33246 | Total: S/ 45.10
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (232, 167, 45.10, 'Efectivo', '33246', '2026-06-12T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/9.5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/35.6 — registrado en pago pero sin monto_id

  -- Socio: TORRES ASTO SANTOS NERY F | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (232, 167, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11846: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11846, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11846;

  -- Deuda id=11847: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11847, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11847;

  -- Socio: TORRES ASTO VDA DE CALDERON JUANA FRONILDA | Fecha: 2026-06-11 | Doc: 33239 | Total: S/ 90.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (178, 168, 90.00, 'Efectivo', '33239', '2026-06-11T12:00:00+00:00', 'Pago 01-08 jul 2026: PAGO EXTRAORDINARIO PARA ARBITRIOS MUNICIPALES 2026/07')
  RETURNING id INTO v_pago_id;

  -- Deuda id=12008: PAGO EXTRAORDINARIO PARA ARBITRIOS MUNICIPALES 2026/07 | Monto deuda: S/403.5 | Pagado: S/90 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12008, 90.00);

  -- Socio: TORRES ASTO VDA DE CALDERON JUANA FRONILDA | Fecha: 2026-06-11 | Doc: 33240 | Total: S/ 160.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (178, 168, 160.00, 'Efectivo', '33240', '2026-06-11T12:00:00+00:00', 'Pago 01-08 jul 2026: PAGO EXTRAORDINARIO PARA ARBITRIOS MUNICIPALES 2026/07')
  RETURNING id INTO v_pago_id;

  -- Deuda id=12008: PAGO EXTRAORDINARIO PARA ARBITRIOS MUNICIPALES 2026/07 | Monto deuda: S/403.5 | Pagado: S/160 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12008, 160.00);

  -- Socio: TORRES ASTO VDA DE CALDERON JUANA FRONILDA | Fecha: 2026-06-05 | Doc: 33201 | Total: S/ 219.70
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (178, 168, 219.70, 'Efectivo', '33201', '2026-06-05T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/02, G. ADM 2026/03, G. ADM 2026/09, P. SOCIAL 2026/09, G. ADM 2026/10, P. SOCIAL 2026/10, G. ADM 2026/11, P. SOCIAL 2026/11, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/02 S/56 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/09 S/16 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/09 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/10 S/12 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/10 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/11 S/12 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/11 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/18 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/19.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: TORRES ASTO VDA DE CALDERON JUANA FRONILDA | Fecha: 2026-06-11 | Doc: 33243 | Total: S/ 10.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (178, 168, 10.00, 'Efectivo', '33243', '2026-06-11T12:00:00+00:00', 'Pago 01-08 jul 2026: P.S X FALL. MANUEL RIOS 2026/09')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: P.S X FALL. MANUEL RIOS 2026/09 S/10 — registrado en pago pero sin monto_id

  -- Socio: TORRES ASTO VDA DE CALDERON JUANA FRONILDA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 44.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (178, 168, 44.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11848: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/44 | PARCIAL
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11848, 44.00);

  -- Socio: URETA CRUZ EMILIA | Fecha: 2026-06-12 | Doc: 33249 | Total: S/ 179.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (48, 169, 179.80, 'Efectivo', '33249', '2026-06-12T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/85 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/29.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: VALENCIA TOMAS VICENTE DORIS | Fecha: 2026-06-05 | Doc: 33204 | Total: S/ 534.60
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (211, 170, 534.60, 'Efectivo', '33204', '2026-06-05T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/524 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/10.6 — registrado en pago pero sin monto_id

  -- Socio: VALENCIA TOMAS VICENTE DORIS | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (211, 170, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11852: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11852, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11852;

  -- Deuda id=11853: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11853, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11853;

  -- Socio: VALERO PARIONA MAXIMO ALBINO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 215.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (78, 171, 215.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, LUZ 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=10278: LUZ 2026/04 | Monto deuda: S/3.6 | Pagado: S/3.6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10278, 3.60);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10278;

  -- Deuda id=10279: AGUA 2026/04 | Monto deuda: S/6 | Pagado: S/6 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 10279, 6.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 10279;

  -- Deuda id=12016: LUZ 2026/05 | Monto deuda: S/150 | Pagado: S/140.4 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12016, 140.40);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 12016;

  -- Deuda id=11854: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11854, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11854;

  -- Deuda id=11855: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11855, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11855;

  -- Socio: VALERO SOTO MAXIMO ELIAS | Fecha: 2026-06-26 | Doc: 33327 | Total: S/ 31.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (248, 172, 31.40, 'Efectivo', '33327', '2026-06-26T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/25.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- Socio: VALERO SOTO WILLY PERSEO | Fecha: 2026-06-12 | Doc: 33244 | Total: S/ 142.80
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (80, 173, 142.80, 'Efectivo', '33244', '2026-06-12T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/136.8 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- Socio: VALERO SOTO WILLY PERSEO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 125.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (80, 173, 125.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=12017: LUZ 2026/05 | Monto deuda: S/142 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12017, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 12017;

  -- Deuda id=11858: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11858, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11858;

  -- Deuda id=11859: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11859, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11859;

  -- Socio: VALLEJOS HUAMAN MARIA ANA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (224, 174, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11860: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11860, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11860;

  -- Deuda id=11861: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11861, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11861;

  -- Socio: VARA CASTRO DELIA ERNESTINA F | Fecha: 2026-06-04 | Doc: 33198 | Total: S/ 200.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (216, 176, 200.00, 'Efectivo', '33198', '2026-06-04T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/02, AGUA 2026/02, LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03, LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/02 S/29 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/02 S/14 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/03 S/30 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/21 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/50 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/04 S/28 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/21 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/2 — registrado en pago pero sin monto_id

  -- Socio: VARA DE ROSAS ALICIA VALENTINA | Fecha: 2026-06-23 | Doc: 33305 | Total: S/ 283.30
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (213, 177, 283.30, 'Efectivo', '33305', '2026-06-23T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/192.7 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/90.6 — registrado en pago pero sin monto_id

  -- Socio: VARA DE ROSAS ALICIA VALENTINA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (213, 177, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11866: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11866, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11866;

  -- Deuda id=11867: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11867, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11867;

  -- Socio: VICENTE CALIXTO JOSE ALBERTO | Fecha: 2026-06-02 | Doc: 33166 | Total: S/ 91.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (255, 178, 91.40, 'Efectivo', '33166', '2026-06-02T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/03, AGUA 2026/03, G. ADM 2026/03, P. SOCIAL 2026/03')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/03 S/20.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/03 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/03 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/03 S/5 — registrado en pago pero sin monto_id

  -- Socio: VICENTE CALIXTO JOSE ALBERTO | Fecha: 2026-06-24 | Doc: 33314 | Total: S/ 200.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (255, 178, 200.00, 'Efectivo', '33314', '2026-06-24T12:00:00+00:00', 'Pago 01-08 jul 2026: DEPOSITO 5 - D2 2026/03')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: DEPOSITO 5 - D2 2026/03 S/200 — registrado en pago pero sin monto_id

  -- Socio: VICENTE CALIXTO JOSE ALBERTO | Fecha: 2026-06-10 | Doc: 33219 | Total: S/ 96.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (255, 178, 96.40, 'Efectivo', '33219', '2026-06-10T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, G. ADM 2026/04, P. SOCIAL 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/25.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/04 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/04 S/5 — registrado en pago pero sin monto_id

  -- Socio: VICENTE CALIXTO JOSE ALBERTO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 20.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (255, 178, 20.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11868: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/20 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11868, 20.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11868;

  -- Socio: VILCHEZ GUTARRA LOURDES FANNY | Fecha: 2026-06-11 | Doc: 33242 | Total: S/ 1079.60
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (187, 179, 1079.60, 'Efectivo', '33242', '2026-06-11T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, DEPOSITO 7 - D1 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/799.4 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/80.2 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO 7 - D1 2026/04 S/200 — registrado en pago pero sin monto_id

  -- Socio: VILCHEZ GUTARRA LOURDES FANNY | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (187, 179, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11871: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11871, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11871;

  -- Deuda id=11872: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11872, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11872;

  -- Socio: VILLANUEVA INGA DE VASQUEZ ROSA PRIMITIVA | Fecha: 2026-06-24 | Doc: 33312 | Total: S/ 478.90
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (263, 180, 478.90, 'Efectivo', '33312', '2026-06-24T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04, DEPOSITO 6 - D1 2026/04, LUZ 2026/05, AGUA 2026/05, DEPOSITO 6 - D1 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/36.3 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO 6 - D1 2026/04 S/200 — registrado en pago pero sin monto_id

  -- SIN DEUDA: LUZ 2026/05 S/30.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: DEPOSITO 6 - D1 2026/05 S/200 — registrado en pago pero sin monto_id

  -- Socio: VILLANUEVA INGA DE VASQUEZ ROSA PRIMITIVA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (263, 180, 65.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11874: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11874, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11874;

  -- Deuda id=11875: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11875, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11875;

  -- Socio: YAURIMUCHA RIMACHI MARCOS | Fecha: 2026-06-30 | Doc: 33333 | Total: S/ 203.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (82, 181, 203.00, 'Efectivo', '33333', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/05 S/67 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/06 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/06 S/5 — registrado en pago pero sin monto_id

  -- Socio: YRUPAILLA FALCON NILDA ADELINA | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 80.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (163, 183, 80.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05, LUZ 2026/05')
  RETURNING id INTO v_pago_id;

  -- Deuda id=11495: G. ADM 2026/05 | Monto deuda: S/6 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11495, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11495;

  -- Deuda id=11496: P. SOCIAL 2026/05 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11496, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11496;

  -- SIN DEUDA: LUZ 2026/05 S/15 — registrado en pago pero sin monto_id

  -- Socio: YRUPAILLA ANAMPA ISIDRO BELISARIO | Fecha: 2026-06-17 | Doc: 33278 | Total: S/ 77.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (206, 182, 77.00, 'Efectivo', '33278', '2026-06-17T12:00:00+00:00', 'Pago 01-08 jul 2026: AGUA 2026/04, AGUA 2026/05, G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: AGUA 2026/04 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/05 S/6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

  -- Socio: ZAPATA VELIT VICTORIANO | Fecha: 2026-06-30 | Doc: TARJETA-JUN | Total: S/ 605.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (240, 185, 605.00, 'Efectivo', 'TARJETA-JUN', '2026-06-30T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/05, AGUA 2026/05, G. ADM 2026/06, P. SOCIAL 2026/06, LUZ 2026/06')
  RETURNING id INTO v_pago_id;

  -- Deuda id=12072: LUZ 2026/05 | Monto deuda: S/140.5 | Pagado: S/140.5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12072, 140.50);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 12072;

  -- Deuda id=12073: AGUA 2026/05 | Monto deuda: S/20 | Pagado: S/20 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 12073, 20.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 12073;

  -- Deuda id=11882: G. ADM 2026/06 | Monto deuda: S/60 | Pagado: S/60 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11882, 60.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11882;

  -- Deuda id=11883: P. SOCIAL 2026/06 | Monto deuda: S/5 | Pagado: S/5 | TOTAL (Cancelado)
  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)
  VALUES (v_pago_id, 11883, 5.00);
  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = 11883;

  -- SIN DEUDA: LUZ 2026/06 S/379.5 — registrado en pago pero sin monto_id

  -- Socio: ZAPATA RIVERA ROSANA | Fecha: 2026-06-24 | Doc: 33309 | Total: S/ 261.40
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (236, 184, 261.40, 'Efectivo', '33309', '2026-06-24T12:00:00+00:00', 'Pago 01-08 jul 2026: LUZ 2026/04, AGUA 2026/04')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: LUZ 2026/04 S/88.6 — registrado en pago pero sin monto_id

  -- SIN DEUDA: AGUA 2026/04 S/172.8 — registrado en pago pero sin monto_id

  -- Socio: ZAPATA RIVERA ROSANA | Fecha: 2026-06-10 | Doc: 33220 | Total: S/ 65.00
  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)
  VALUES (236, 184, 65.00, 'Efectivo', '33220', '2026-06-10T12:00:00+00:00', 'Pago 01-08 jul 2026: G. ADM 2026/05, P. SOCIAL 2026/05')
  RETURNING id INTO v_pago_id;

  -- SIN DEUDA: G. ADM 2026/05 S/60 — registrado en pago pero sin monto_id

  -- SIN DEUDA: P. SOCIAL 2026/05 S/5 — registrado en pago pero sin monto_id

END$$;

-- ─── FILAS OMITIDAS ───────────────────────────────────────────────────────
-- OMITIDA: CERDA CARMEN / "DEPOSITO 2 - D2" / periodo 2026/6: no se pudo resolver puesto de almacén (sin_almacen)
-- OMITIDA: CERDA CARMEN / "DEPOSITO 2 - D2" / periodo 2026/7: no se pudo resolver puesto de almacén (sin_almacen)
-- OMITIDA: CERDA CARMEN / "DEPOSITO 2 - D2" / periodo 2026/8: no se pudo resolver puesto de almacén (sin_almacen)

-- ─── SOCIOS EXCLUIDOS ─────────────────────────────────────────────────────
-- EXCLUIDO: "GARCIA LUCIA" — Socia nueva sin alta de padrón confirmada (igual que en la migración de junio 2026).
-- EXCLUIDO: "TENORIO ALBERTINA" — Nueva socia en reemplazo — sin alta confirmada en padrón (no existe en public.socios).

-- ─── LÍNEAS DUPLICADAS EN EL EXCEL FUENTE (deuda ya saldada en este lote) ───
-- DUPLICADO: CHUCHULLO JOSE / "G. ADM" 2026/6 S/60: deuda id=11605 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc TARJETA-JUN) — registrada como SIN DEUDA
-- DUPLICADO: CHUCHULLO JOSE / "P. SOCIAL" 2026/6 S/5: deuda id=11606 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc TARJETA-JUN) — registrada como SIN DEUDA
-- DUPLICADO: OQUENDO MIGUEL / "G. ADM" 2026/6 S/235: deuda id=11730 ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc TARJETA-JUN) — registrada como SIN DEUDA
