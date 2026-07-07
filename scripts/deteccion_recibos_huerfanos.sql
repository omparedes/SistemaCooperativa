-- =============================================================================
-- Diagnóstico: Recibos migrados sin conceptos (huérfanos) y descuadres
-- Cooperativa Primero de Mayo · SistemaCooperativa
-- -----------------------------------------------------------------------------
-- Contexto: la migración 00077 (pagos 16-30 junio 2026) insertó los recibos
-- (`pagos`) con su monto_total completo, pero omitió el desglose en
-- `detalle_pagos` para los 174 conceptos que no encontró en montos_por_cobrar
-- (marcados como "-- SIN DEUDA" en el propio archivo SQL). La migración 00074
-- sí aplicó el patrón correcto: crear la deuda faltante y luego empatarla.
--
-- Uso: ejecutar cada consulta por separado (solo lectura, sin efectos).
-- =============================================================================

-- ─────────────────────────────────────────────────────────────────────────────
-- 1. RECIBOS HUÉRFANOS: pagos vigentes SIN ningún detalle activo.
--    (el recibo existe y suma en caja, pero no desglosa ni un concepto)
-- ─────────────────────────────────────────────────────────────────────────────
SELECT
    pg.id                AS pago_id,
    pg.codigo_transaccion,
    pg.fecha_pago::date,
    pg.monto_total,
    pg.comprobante,
    coalesce(s.apellidos || ', ' || s.nombres,
             i.apellidos || ', ' || i.nombres) AS pagador,
    p.codigo_puesto,
    pg.observacion
FROM public.pagos pg
LEFT JOIN public.socios     s ON s.id = pg.socio_id
LEFT JOIN public.inquilinos i ON i.id = pg.inquilino_id
LEFT JOIN public.puestos    p ON p.id = pg.puesto_id
WHERE pg.deleted_at IS NULL
  AND NOT EXISTS (
      SELECT 1 FROM public.detalle_pagos dp
      WHERE dp.pago_id = pg.id AND dp.deleted_at IS NULL
  )
ORDER BY pg.fecha_pago, pg.id;

-- ─────────────────────────────────────────────────────────────────────────────
-- 2. RECIBOS DESCUADRADOS: la suma del detalle activo no cubre el monto_total.
--    OJO: un descuadre POSITIVO (detalle < total) es legítimo cuando el
--    excedente fue a saldo_a_favor (wizard). En recibos migrados
--    (observacion LIKE 'Pago 16-30 jun%' / 'Migración%') indica conceptos
--    faltantes. La columna `origen_probable` los distingue.
-- ─────────────────────────────────────────────────────────────────────────────
SELECT
    pg.id                AS pago_id,
    pg.codigo_transaccion,
    pg.fecha_pago::date,
    pg.monto_total,
    coalesce(det.suma_detalle, 0)                       AS suma_detalle,
    round(pg.monto_total - coalesce(det.suma_detalle, 0), 2) AS faltante,
    CASE
      WHEN pg.observacion ILIKE 'Pago 16-30 jun%'
        OR pg.observacion ILIKE 'Migración%'
        OR pg.observacion ILIKE '%migraci%'
      THEN 'MIGRADO — conceptos sin empatar'
      ELSE 'Operativo — posible excedente a saldo a favor'
    END                                                 AS origen_probable,
    coalesce(s.apellidos || ', ' || s.nombres,
             i.apellidos || ', ' || i.nombres)          AS pagador,
    p.codigo_puesto,
    pg.observacion
FROM public.pagos pg
LEFT JOIN LATERAL (
    SELECT sum(dp.monto_aplicado) AS suma_detalle
    FROM   public.detalle_pagos dp
    WHERE  dp.pago_id = pg.id AND dp.deleted_at IS NULL
) det ON true
LEFT JOIN public.socios     s ON s.id = pg.socio_id
LEFT JOIN public.inquilinos i ON i.id = pg.inquilino_id
LEFT JOIN public.puestos    p ON p.id = pg.puesto_id
WHERE pg.deleted_at IS NULL
  AND round(pg.monto_total - coalesce(det.suma_detalle, 0), 2) <> 0
ORDER BY faltante DESC, pg.fecha_pago;

-- ─────────────────────────────────────────────────────────────────────────────
-- 3. DETALLES DUPLICADOS: dos o más líneas del mismo pago apuntando al mismo
--    monto_id. Caso confirmado en 00077 (pago de CALLE ALVAREZ: los depósitos
--    "DEPOSITO 2026/05" y "DEPOSITO 10 - D2 2026/05" apuntan ambos al
--    monto_id 10894; la segunda deuda no recibió su abono).
-- ─────────────────────────────────────────────────────────────────────────────
SELECT
    dp.pago_id,
    dp.monto_id,
    count(*)                    AS lineas,
    sum(dp.monto_aplicado)      AS total_aplicado,
    mc.monto                    AS monto_deuda,
    mc.estado,
    c.nombre                    AS concepto,
    pu.codigo_puesto
FROM public.detalle_pagos dp
JOIN public.montos_por_cobrar mc ON mc.id = dp.monto_id
JOIN public.conceptos c          ON c.id  = mc.concepto_id
LEFT JOIN public.puestos pu      ON pu.id = mc.puesto_id
WHERE dp.deleted_at IS NULL
GROUP BY dp.pago_id, dp.monto_id, mc.monto, mc.estado, c.nombre, pu.codigo_puesto
HAVING count(*) > 1
ORDER BY dp.pago_id;

-- ─────────────────────────────────────────────────────────────────────────────
-- 4. DEUDAS SOBRE-PAGADAS: el detalle activo supera el monto de la deuda
--    (consecuencia típica del punto 3, o de empates con montos del Excel
--    que no coincidían con la deuda: p.ej. deuda S/55 con abono S/60 en 00077).
-- ─────────────────────────────────────────────────────────────────────────────
SELECT
    mc.id           AS monto_id,
    c.nombre        AS concepto,
    pu.codigo_puesto,
    mc.periodo_anio,
    mc.periodo_mes,
    mc.monto,
    sum(dp.monto_aplicado) AS aplicado,
    round(sum(dp.monto_aplicado) - mc.monto, 2) AS exceso,
    mc.estado
FROM public.montos_por_cobrar mc
JOIN public.detalle_pagos dp ON dp.monto_id = mc.id AND dp.deleted_at IS NULL
JOIN public.conceptos c      ON c.id = mc.concepto_id
LEFT JOIN public.puestos pu  ON pu.id = mc.puesto_id
WHERE mc.deleted_at IS NULL
GROUP BY mc.id, c.nombre, pu.codigo_puesto, mc.periodo_anio, mc.periodo_mes, mc.monto, mc.estado
HAVING round(sum(dp.monto_aplicado) - mc.monto, 2) > 0
ORDER BY exceso DESC;

-- ─────────────────────────────────────────────────────────────────────────────
-- 5. RESUMEN EJECUTIVO: cuántos recibos y cuánto dinero está sin desglosar,
--    agrupado por lote de origen.
-- ─────────────────────────────────────────────────────────────────────────────
SELECT
    CASE
      WHEN pg.observacion ILIKE 'Pago 16-30 jun%' THEN 'Lote 00077 (16-30 jun)'
      WHEN pg.observacion ILIKE '%migraci%'       THEN 'Otros lotes migrados'
      ELSE 'Operativo (wizard/CC)'
    END                                            AS lote,
    count(*)                                       AS recibos_descuadrados,
    sum(round(pg.monto_total - coalesce(det.suma_detalle, 0), 2)) AS monto_sin_desglosar
FROM public.pagos pg
LEFT JOIN LATERAL (
    SELECT sum(dp.monto_aplicado) AS suma_detalle
    FROM   public.detalle_pagos dp
    WHERE  dp.pago_id = pg.id AND dp.deleted_at IS NULL
) det ON true
WHERE pg.deleted_at IS NULL
  AND round(pg.monto_total - coalesce(det.suma_detalle, 0), 2) > 0
GROUP BY 1
ORDER BY monto_sin_desglosar DESC;
