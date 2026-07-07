/**
 * generar_regularizacion_00083.cjs
 *
 * Parsea supabase/migrations/00077_pagos_16_30_junio_2026.sql y genera
 * supabase/migrations/00083_regularizacion_recibos_00077.sql
 *
 * Contexto: 00077 insertó los recibos (pagos) con su monto_total completo,
 * pero omitió el detalle_pagos de los conceptos que no encontró como deuda
 * pendiente (comentarios "-- SIN DEUDA: <LABEL> <anio>/<mes> S/<monto>").
 * Esos recibos quedaron huérfanos/descuadrados.
 *
 * Estrategia (patrón de 00074):
 *   1. Localizar el pago por (socio_id, fecha_pago, monto_total, observacion).
 *   2. Resolver concepto_id con el MISMO mapeo del generador original
 *      (generar_pagos_16_30_junio_2026.js): LUZ→Luz, AGUA→Agua,
 *      G. ADM→Gastos administrativos, P. SOCIAL→Previsión social,
 *      DEPOSITO*→Deposito, resto→Otros.
 *   3. Resolver puesto: principal (del INSERT) o almacén del socio
 *      (sufijo "N-Dx" del label, vía ocupaciones_almacenes ∪ titularidades
 *      de tipo Almacén) — en runtime, dentro de la migración.
 *   4. Buscar la deuda (unique: puesto+concepto+anio+mes, deleted_at IS NULL);
 *      si no existe, crearla con el monto pagado; si existe saldada o
 *      Cancelada, saltar con NOTICE.
 *   5. Insertar detalle_pagos (idempotente) y recalcular estado
 *      (Pagado/Pendiente, nunca pisar Cancelado).
 *
 * Además emite el fix del bug puntual: dos depósitos del mismo pago
 * aplicados al mismo monto_id 10894 (líneas 163-169 de 00077).
 *
 * Uso: node scripts/generar_regularizacion_00083.cjs
 */
'use strict';
const fs = require('fs');

const INPUT = 'supabase/migrations/00077_pagos_16_30_junio_2026.sql';
const OUTPUT = 'supabase/migrations/00083_regularizacion_recibos_00077.sql';

const RE_PAGO_VALUES =
  /^\s*VALUES \((\d+), (\d+), ([\d.]+), 'Efectivo', NULL, '([^']+)', '((?:[^']|'')*)'\)$/;
const RE_SIN_DEUDA =
  /^\s*-- SIN DEUDA: (.*) (\d{4})\/(\d{2}) S\/([\d.]+) — registrado/;
const RE_DEPOSITO_SUFIJO = /^DEPOSITO\s+(\d+)\s*-\s*D(\d+)$/i;

function mapearConcepto(label) {
  const c = label.trim();
  if (c === 'LUZ' || c === 'USO DE LUZ') return 'Luz';
  if (c === 'AGUA') return 'Agua';
  if (c === 'G. ADM') return 'Gastos administrativos';
  if (c === 'P. SOCIAL') return 'Previsión social';
  if (c.startsWith('DEPOSITO')) return 'Deposito';
  return 'Otros';
}

function infoDeposito(label) {
  const c = label.trim();
  if (!c.startsWith('DEPOSITO')) return { esDeposito: false, sufijo: null };
  const m = c.match(RE_DEPOSITO_SUFIJO);
  if (m) return { esDeposito: true, sufijo: `${m[1]}-D${m[2]}` };
  return { esDeposito: true, sufijo: null }; // "DEPOSITO" simple → único almacén
}

function escSql(s) {
  return String(s).replace(/'/g, "''");
}

// ─── Parseo de 00077 ─────────────────────────────────────────────────────────
const src = fs.readFileSync(INPUT, 'utf8').split(/\r?\n/);

const pagos = []; // { puesto, socio, total, fecha, obsEscapada, lineas: [] }
let actual = null;

for (const line of src) {
  const mv = line.match(RE_PAGO_VALUES);
  if (mv) {
    actual = {
      puesto: Number(mv[1]),
      socio: Number(mv[2]),
      total: mv[3],
      fecha: mv[4],
      obsEscapada: mv[5], // ya viene escapada ('' dobles) tal cual del SQL
      lineas: [],
    };
    pagos.push(actual);
    continue;
  }
  const ms = line.match(RE_SIN_DEUDA);
  if (ms && actual) {
    actual.lineas.push({
      label: ms[1].trim(),
      anio: Number(ms[2]),
      mes: Number(ms[3]),
      monto: Number(ms[4]),
    });
  }
}

const totalSinDeuda = pagos.reduce((s, p) => s + p.lineas.length, 0);
console.log(`Pagos parseados: ${pagos.length} | Líneas SIN DEUDA: ${totalSinDeuda}`);

// ─── Fusión de líneas que colisionan en la misma deuda ───────────────────────
// Dos labels distintos del mismo pago pueden mapear al mismo
// (concepto, puesto, periodo) — p.ej. MULTA y FUMIGACION → 'Otros' mismo mes.
// El unique index de montos_por_cobrar impediría dos filas, así que se
// fusionan en una sola línea con el monto sumado y el label concatenado.
let fusionadas = 0;
for (const p of pagos) {
  const buckets = new Map();
  for (const l of p.lineas) {
    const dep = infoDeposito(l.label);
    const key = [mapearConcepto(l.label), dep.esDeposito, dep.sufijo ?? '', l.anio, l.mes].join('|');
    if (buckets.has(key)) {
      const b = buckets.get(key);
      b.monto = Math.round((b.monto + l.monto) * 100) / 100;
      b.label = `${b.label} + ${l.label}`;
      fusionadas++;
    } else {
      buckets.set(key, { ...l, ...dep, concepto: mapearConcepto(l.label) });
    }
  }
  p.lineas = [...buckets.values()];
}
const totalLineas = pagos.reduce((s, p) => s + p.lineas.length, 0);
console.log(`Líneas tras fusión: ${totalLineas} (fusionadas: ${fusionadas})`);

// Inventario de labels para revisión
const inventario = new Map();
for (const p of pagos) for (const l of p.lineas) {
  const k = `${l.label} → ${l.concepto}${l.esDeposito ? ` (almacén${l.sufijo ? ' ' + l.sufijo : ' único'})` : ''}`;
  inventario.set(k, (inventario.get(k) || 0) + 1);
}
console.log('\nInventario de conceptos SIN DEUDA:');
[...inventario.entries()].sort((a, b) => b[1] - a[1]).forEach(([k, n]) => console.log(`  ${String(n).padStart(3)} × ${k}`));

// ─── Emisión del SQL ─────────────────────────────────────────────────────────
const L = [];
L.push(`-- =============================================================================`);
L.push(`-- Migración 00083 — Regularización de recibos migrados sin conceptos (00077)`);
L.push(`-- Cooperativa Primero de Mayo · SistemaCooperativa`);
L.push(`-- Generado: ${new Date().toISOString().slice(0, 10)} desde scripts/generar_regularizacion_00083.cjs`);
L.push(`-- -----------------------------------------------------------------------------`);
L.push(`-- La migración 00077 insertó ${pagos.length} recibos con ${totalSinDeuda} conceptos "SIN DEUDA"`);
L.push(`-- (sin fila en detalle_pagos), dejando recibos huérfanos o descuadrados.`);
L.push(`-- Esta migración aplica el patrón de 00074: busca o crea la deuda en`);
L.push(`-- montos_por_cobrar, inserta el detalle y recalcula el estado. Todo es`);
L.push(`-- idempotente y los casos no resolubles se reportan con RAISE NOTICE`);
L.push(`-- ("00083 SKIP ...") sin abortar la transacción del bloque.`);
L.push(`-- También corrige el bug puntual del monto_id 10894 (dos depósitos del`);
L.push(`-- mismo pago aplicados a la misma deuda).`);
L.push(`-- Verificación posterior: scripts/deteccion_recibos_huerfanos.sql`);
L.push(`-- =============================================================================`);
L.push(``);
L.push(`BEGIN;`);
L.push(``);
L.push(`-- =============================================================================`);
L.push(`-- 1. Helper temporal (se elimina al final de esta migración)`);
L.push(`-- =============================================================================`);
L.push(`CREATE FUNCTION public._reg00083_linea(`);
L.push(`    p_socio_id         bigint,`);
L.push(`    p_fecha            timestamptz,`);
L.push(`    p_monto_total      numeric,`);
L.push(`    p_observacion      text,`);
L.push(`    p_label            text,`);
L.push(`    p_concepto_nombre  text,`);
L.push(`    p_es_deposito      boolean,`);
L.push(`    p_sufijo           text,`);
L.push(`    p_puesto_principal bigint,`);
L.push(`    p_anio             int,`);
L.push(`    p_mes              int,`);
L.push(`    p_monto            numeric,`);
L.push(`    p_user             uuid`);
L.push(`)`);
L.push(`RETURNS void`);
L.push(`LANGUAGE plpgsql`);
L.push(`SET search_path = public`);
L.push(`AS $fn$`);
L.push(`DECLARE`);
L.push(`    v_pago_id     bigint;`);
L.push(`    v_concepto_id bigint;`);
L.push(`    v_puesto_id   bigint;`);
L.push(`    v_monto_id    bigint;`);
L.push(`    v_deuda_monto numeric;`);
L.push(`    v_estado      text;`);
L.push(`    v_aplicado    numeric;`);
L.push(`    v_n           int;`);
L.push(`BEGIN`);
L.push(`    -- 1. Localizar el recibo insertado por 00077`);
L.push(`    SELECT id INTO v_pago_id`);
L.push(`    FROM public.pagos`);
L.push(`    WHERE socio_id    = p_socio_id`);
L.push(`      AND fecha_pago  = p_fecha`);
L.push(`      AND monto_total = p_monto_total`);
L.push(`      AND observacion = p_observacion`);
L.push(`      AND deleted_at IS NULL`);
L.push(`    ORDER BY id`);
L.push(`    LIMIT 1;`);
L.push(``);
L.push(`    IF v_pago_id IS NULL THEN`);
L.push(`        RAISE NOTICE '00083 SKIP [pago no hallado] socio=% fecha=% total=% linea="%"',`);
L.push(`            p_socio_id, p_fecha, p_monto_total, p_label;`);
L.push(`        RETURN;`);
L.push(`    END IF;`);
L.push(``);
L.push(`    -- 2. Concepto (mismo mapeo que el generador de 00077)`);
L.push(`    SELECT id INTO v_concepto_id`);
L.push(`    FROM public.conceptos`);
L.push(`    WHERE nombre = p_concepto_nombre AND deleted_at IS NULL`);
L.push(`    LIMIT 1;`);
L.push(`    IF v_concepto_id IS NULL THEN`);
L.push(`        RAISE NOTICE '00083 SKIP [concepto "%" no existe] pago=% linea="%"',`);
L.push(`            p_concepto_nombre, v_pago_id, p_label;`);
L.push(`        RETURN;`);
L.push(`    END IF;`);
L.push(``);
L.push(`    -- 3. Puesto: principal, o almacén del socio para labels DEPOSITO*`);
L.push(`    IF p_es_deposito THEN`);
L.push(`        SELECT count(*), min(t.puesto_id) INTO v_n, v_puesto_id`);
L.push(`        FROM (`);
L.push(`            SELECT oa.puesto_id`);
L.push(`            FROM public.ocupaciones_almacenes oa`);
L.push(`            JOIN public.puestos pu ON pu.id = oa.puesto_id`);
L.push(`            WHERE oa.socio_id = p_socio_id AND oa.fecha_fin IS NULL`);
L.push(`              AND (p_sufijo IS NULL OR pu.codigo_puesto LIKE '%' || p_sufijo)`);
L.push(`            UNION`);
L.push(`            SELECT ht.puesto_id`);
L.push(`            FROM public.historial_titularidad ht`);
L.push(`            JOIN public.puestos pu ON pu.id = ht.puesto_id`);
L.push(`            WHERE ht.socio_id = p_socio_id AND ht.fecha_fin IS NULL`);
L.push(`              AND pu.tipo_espacio = 'Almacen'`);
L.push(`              AND (p_sufijo IS NULL OR pu.codigo_puesto LIKE '%' || p_sufijo)`);
L.push(`        ) t;`);
L.push(``);
L.push(`        IF v_n <> 1 OR v_puesto_id IS NULL THEN`);
L.push(`            RAISE NOTICE '00083 SKIP [almacén no resuelto: % candidatos] pago=% socio=% linea="%"',`);
L.push(`                v_n, v_pago_id, p_socio_id, p_label;`);
L.push(`            RETURN;`);
L.push(`        END IF;`);
L.push(`    ELSE`);
L.push(`        v_puesto_id := p_puesto_principal;`);
L.push(`    END IF;`);
L.push(``);
L.push(`    -- 4. Deuda: buscar por la clave única (puesto, concepto, periodo) o crearla`);
L.push(`    SELECT mc.id, mc.monto, mc.estado INTO v_monto_id, v_deuda_monto, v_estado`);
L.push(`    FROM public.montos_por_cobrar mc`);
L.push(`    WHERE mc.puesto_id = v_puesto_id AND mc.concepto_id = v_concepto_id`);
L.push(`      AND mc.periodo_anio = p_anio AND mc.periodo_mes = p_mes`);
L.push(`      AND mc.deleted_at IS NULL`);
L.push(`    LIMIT 1;`);
L.push(``);
L.push(`    IF v_monto_id IS NULL THEN`);
L.push(`        INSERT INTO public.montos_por_cobrar`);
L.push(`            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado,`);
L.push(`             metodo_calculo, fecha_generacion, observacion, created_by)`);
L.push(`        VALUES`);
L.push(`            (v_puesto_id, v_concepto_id, p_anio, p_mes, p_monto, 'Pendiente',`);
L.push(`             'Manual', current_date,`);
L.push(`             'Regularización 00083: concepto "' || p_label || '" de recibo migrado en 00077',`);
L.push(`             p_user)`);
L.push(`        RETURNING id, monto, estado INTO v_monto_id, v_deuda_monto, v_estado;`);
L.push(`    ELSE`);
L.push(`        IF v_estado = 'Cancelado' THEN`);
L.push(`            RAISE NOTICE '00083 SKIP [deuda % ya Cancelada] pago=% linea="%"',`);
L.push(`                v_monto_id, v_pago_id, p_label;`);
L.push(`            RETURN;`);
L.push(`        END IF;`);
L.push(`        SELECT coalesce(sum(dp.monto_aplicado), 0) INTO v_aplicado`);
L.push(`        FROM public.detalle_pagos dp`);
L.push(`        WHERE dp.monto_id = v_monto_id AND dp.deleted_at IS NULL;`);
L.push(`        IF v_deuda_monto - v_aplicado <= 0.005 THEN`);
L.push(`            RAISE NOTICE '00083 SKIP [deuda % ya saldada] pago=% linea="%"',`);
L.push(`                v_monto_id, v_pago_id, p_label;`);
L.push(`            RETURN;`);
L.push(`        END IF;`);
L.push(`    END IF;`);
L.push(``);
L.push(`    -- 5. Detalle (idempotente por pago+monto)`);
L.push(`    IF NOT EXISTS (`);
L.push(`        SELECT 1 FROM public.detalle_pagos`);
L.push(`        WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL`);
L.push(`    ) THEN`);
L.push(`        INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by)`);
L.push(`        VALUES (v_pago_id, v_monto_id, p_monto, p_user);`);
L.push(`    END IF;`);
L.push(``);
L.push(`    -- 6. Recalcular estado (nunca pisar Cancelado)`);
L.push(`    SELECT coalesce(sum(dp.monto_aplicado), 0) INTO v_aplicado`);
L.push(`    FROM public.detalle_pagos dp`);
L.push(`    WHERE dp.monto_id = v_monto_id AND dp.deleted_at IS NULL;`);
L.push(``);
L.push(`    UPDATE public.montos_por_cobrar`);
L.push(`    SET estado = CASE WHEN v_aplicado >= monto - 0.005 THEN 'Pagado' ELSE 'Pendiente' END`);
L.push(`    WHERE id = v_monto_id AND estado <> 'Cancelado';`);
L.push(`END;`);
L.push(`$fn$;`);
L.push(``);
L.push(`-- =============================================================================`);
L.push(`-- 2. Fix puntual: monto_id 10894 recibió DOS depósitos del mismo pago`);
L.push(`--    (00077 líneas 163-169: "DEPOSITO 2026/05" y "DEPOSITO 10 - D2 2026/05",`);
L.push(`--    ambas de S/100 sobre una deuda de S/200 — la deuda del segundo almacén`);
L.push(`--    no recibió su abono). Se reubica el segundo detalle en la deuda del`);
L.push(`--    otro almacén del socio, creándola (S/200, monto del Excel) si no existe.`);
L.push(`--    Solo se toca algo si el destino es resoluble; si no, NOTICE y sin cambios.`);
L.push(`-- =============================================================================`);
L.push(`DO $$`);
L.push(`DECLARE`);
L.push(`    v_user          uuid;`);
L.push(`    v_pago_id       bigint;`);
L.push(`    v_socio         bigint;`);
L.push(`    v_dup_id        bigint;`);
L.push(`    v_dup_monto     numeric;`);
L.push(`    v_concepto_dep  bigint;`);
L.push(`    v_puesto_10894  bigint;`);
L.push(`    v_destino_id    bigint;`);
L.push(`    v_puesto_dest   bigint;`);
L.push(`    v_n             int;`);
L.push(`    v_aplicado      numeric;`);
L.push(`BEGIN`);
L.push(`    SELECT id INTO v_user FROM public.perfiles WHERE rol = 'Administrador' AND activo = true LIMIT 1;`);
L.push(`    IF v_user IS NULL THEN v_user := '00000000-0000-0000-0000-000000000000'; END IF;`);
L.push(``);
L.push(`    -- Pago con más de un detalle activo sobre 10894`);
L.push(`    SELECT dp.pago_id INTO v_pago_id`);
L.push(`    FROM public.detalle_pagos dp`);
L.push(`    WHERE dp.monto_id = 10894 AND dp.deleted_at IS NULL`);
L.push(`    GROUP BY dp.pago_id`);
L.push(`    HAVING count(*) > 1`);
L.push(`    LIMIT 1;`);
L.push(``);
L.push(`    IF v_pago_id IS NULL THEN`);
L.push(`        RAISE NOTICE '00083: duplicado sobre monto 10894 no encontrado (nada que corregir).';`);
L.push(`        RETURN;`);
L.push(`    END IF;`);
L.push(``);
L.push(`    SELECT socio_id INTO v_socio FROM public.pagos WHERE id = v_pago_id;`);
L.push(`    SELECT puesto_id INTO v_puesto_10894 FROM public.montos_por_cobrar WHERE id = 10894;`);
L.push(`    SELECT id INTO v_concepto_dep FROM public.conceptos WHERE nombre = 'Deposito' AND deleted_at IS NULL LIMIT 1;`);
L.push(``);
L.push(`    -- Detalle sobrante (el de mayor id = segunda línea del pago en 00077)`);
L.push(`    SELECT id, monto_aplicado INTO v_dup_id, v_dup_monto`);
L.push(`    FROM public.detalle_pagos`);
L.push(`    WHERE pago_id = v_pago_id AND monto_id = 10894 AND deleted_at IS NULL`);
L.push(`    ORDER BY id DESC`);
L.push(`    LIMIT 1;`);
L.push(``);
L.push(`    -- Destino: deuda Deposito 2026/05 de OTRO almacén del socio`);
L.push(`    SELECT count(*), min(mc.id) INTO v_n, v_destino_id`);
L.push(`    FROM public.montos_por_cobrar mc`);
L.push(`    WHERE mc.concepto_id = v_concepto_dep`);
L.push(`      AND mc.periodo_anio = 2026 AND mc.periodo_mes = 5`);
L.push(`      AND mc.id <> 10894 AND mc.deleted_at IS NULL`);
L.push(`      AND mc.puesto_id IN (`);
L.push(`          SELECT oa.puesto_id FROM public.ocupaciones_almacenes oa`);
L.push(`          WHERE oa.socio_id = v_socio AND oa.fecha_fin IS NULL`);
L.push(`          UNION`);
L.push(`          SELECT ht.puesto_id FROM public.historial_titularidad ht`);
L.push(`          JOIN public.puestos pu ON pu.id = ht.puesto_id`);
L.push(`          WHERE ht.socio_id = v_socio AND ht.fecha_fin IS NULL AND pu.tipo_espacio = 'Almacen'`);
L.push(`      );`);
L.push(``);
L.push(`    IF v_destino_id IS NULL THEN`);
L.push(`        -- No existe: crearla en el almacén del socio que NO es el de 10894`);
L.push(`        SELECT count(*), min(t.puesto_id) INTO v_n, v_puesto_dest`);
L.push(`        FROM (`);
L.push(`            SELECT oa.puesto_id FROM public.ocupaciones_almacenes oa`);
L.push(`            WHERE oa.socio_id = v_socio AND oa.fecha_fin IS NULL`);
L.push(`            UNION`);
L.push(`            SELECT ht.puesto_id FROM public.historial_titularidad ht`);
L.push(`            JOIN public.puestos pu ON pu.id = ht.puesto_id`);
L.push(`            WHERE ht.socio_id = v_socio AND ht.fecha_fin IS NULL AND pu.tipo_espacio = 'Almacen'`);
L.push(`        ) t`);
L.push(`        WHERE t.puesto_id <> v_puesto_10894;`);
L.push(``);
L.push(`        IF v_n <> 1 OR v_puesto_dest IS NULL THEN`);
L.push(`            RAISE NOTICE '00083 SKIP [fix 10894: segundo almacén no resoluble, candidatos=%] — sin cambios.', v_n;`);
L.push(`            RETURN;`);
L.push(`        END IF;`);
L.push(``);
L.push(`        INSERT INTO public.montos_por_cobrar`);
L.push(`            (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado,`);
L.push(`             metodo_calculo, fecha_generacion, observacion, created_by)`);
L.push(`        VALUES`);
L.push(`            (v_puesto_dest, v_concepto_dep, 2026, 5, 200.00, 'Pendiente',`);
L.push(`             'Manual', current_date,`);
L.push(`             'Regularización 00083: deuda "DEPOSITO 10 - D2 2026/05" del recibo de 00077 que fue aplicado por error al monto 10894',`);
L.push(`             v_user)`);
L.push(`        RETURNING id INTO v_destino_id;`);
L.push(`    END IF;`);
L.push(``);
L.push(`    -- Reubicación: soft-delete del detalle duplicado + detalle correcto`);
L.push(`    UPDATE public.detalle_pagos`);
L.push(`    SET deleted_at       = now(),`);
L.push(`        anulado_por      = v_user,`);
L.push(`        motivo_anulacion = 'Regularización 00083: detalle duplicado — 00077 aplicó dos depósitos distintos al mismo monto_id 10894'`);
L.push(`    WHERE id = v_dup_id;`);
L.push(``);
L.push(`    IF NOT EXISTS (`);
L.push(`        SELECT 1 FROM public.detalle_pagos`);
L.push(`        WHERE pago_id = v_pago_id AND monto_id = v_destino_id AND deleted_at IS NULL`);
L.push(`    ) THEN`);
L.push(`        INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by)`);
L.push(`        VALUES (v_pago_id, v_destino_id, v_dup_monto, v_user);`);
L.push(`    END IF;`);
L.push(``);
L.push(`    -- Recalcular estados de ambas deudas`);
L.push(`    SELECT coalesce(sum(monto_aplicado), 0) INTO v_aplicado`);
L.push(`    FROM public.detalle_pagos WHERE monto_id = 10894 AND deleted_at IS NULL;`);
L.push(`    UPDATE public.montos_por_cobrar`);
L.push(`    SET estado = CASE WHEN v_aplicado >= monto - 0.005 THEN 'Pagado' ELSE 'Pendiente' END`);
L.push(`    WHERE id = 10894 AND estado <> 'Cancelado';`);
L.push(``);
L.push(`    SELECT coalesce(sum(monto_aplicado), 0) INTO v_aplicado`);
L.push(`    FROM public.detalle_pagos WHERE monto_id = v_destino_id AND deleted_at IS NULL;`);
L.push(`    UPDATE public.montos_por_cobrar`);
L.push(`    SET estado = CASE WHEN v_aplicado >= monto - 0.005 THEN 'Pagado' ELSE 'Pendiente' END`);
L.push(`    WHERE id = v_destino_id AND estado <> 'Cancelado';`);
L.push(``);
L.push(`    RAISE NOTICE '00083: fix 10894 aplicado — detalle % reubicado a la deuda %.', v_dup_id, v_destino_id;`);
L.push(`END $$;`);
L.push(``);
L.push(`-- =============================================================================`);
L.push(`-- 3. Regularización de las ${totalLineas} líneas "SIN DEUDA" de 00077`);
L.push(`-- =============================================================================`);
L.push(`DO $$`);
L.push(`DECLARE`);
L.push(`    v_user uuid;`);
L.push(`BEGIN`);
L.push(`    SELECT id INTO v_user FROM public.perfiles WHERE rol = 'Administrador' AND activo = true LIMIT 1;`);
L.push(`    IF v_user IS NULL THEN v_user := '00000000-0000-0000-0000-000000000000'; END IF;`);
L.push(``);

for (const p of pagos) {
  if (p.lineas.length === 0) continue;
  L.push(`    -- ── Pago socio=${p.socio} · ${p.fecha.slice(0, 10)} · S/ ${p.total} ──`);
  for (const l of p.lineas) {
    const args = [
      String(p.socio),
      `'${p.fecha}'::timestamptz`,
      p.total,
      `'${p.obsEscapada}'`,
      `'${escSql(l.label)}'`,
      `'${escSql(l.concepto)}'`,
      l.esDeposito ? 'true' : 'false',
      l.sufijo ? `'${escSql(l.sufijo)}'` : 'NULL',
      String(p.puesto),
      String(l.anio),
      String(l.mes),
      l.monto.toFixed(2),
      'v_user',
    ];
    L.push(`    PERFORM public._reg00083_linea(${args.join(', ')});`);
  }
  L.push(``);
}

L.push(`END $$;`);
L.push(``);
L.push(`-- =============================================================================`);
L.push(`-- 4. Limpieza del helper`);
L.push(`-- =============================================================================`);
L.push(`DROP FUNCTION public._reg00083_linea(bigint, timestamptz, numeric, text, text, text, boolean, text, bigint, int, int, numeric, uuid);`);
L.push(``);
L.push(`COMMIT;`);
L.push(``);

fs.writeFileSync(OUTPUT, L.join('\n'));
console.log(`\nSQL generado: ${OUTPUT} (${L.length} líneas)`);
