/**
 * generar_seed_deudas.cjs
 * Lee el Excel del padrón y genera seed_migracion_deudas_iniciales.sql
 * con los nombres reales de socios y búsqueda por ILIKE.
 * Los montos quedan en 0.00 — el usuario rellena los valores reales.
 */
'use strict';
const XLSX = require('xlsx');
const fs   = require('fs');

const wb   = XLSX.readFile('migracion_coop/listapersonascoop.xlsx', { raw: false });
const ws   = wb.Sheets['Hoja1'];
const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });

const SOCIOS = rows.slice(1)
  .map(r => ({
    nombre: limpiarNombre(String(r[0] ?? '').trim()),
    tipo:   String(r[1] ?? '').trim().toUpperCase(),
    puesto: String(r[2] ?? '').trim(),
  }))
  .filter(r => r.nombre && r.tipo === 'SOCIO');

function limpiarNombre(s) {
  return s.replace(/\s+(CORTADO|FALLECIO|FALLECIDO|BAJA|INACTIVO|INACTIVE|NULO)$/i, '').trim();
}
function esc(s) { return "'" + String(s).replace(/'/g, "''") + "'"; }

const L = [];
L.push(`-- =============================================================================`);
L.push(`-- Seed: Inyección de Deudas Iniciales — Go-Live Mayo 2026  (v4 — padrón real)`);
L.push(`-- Cooperativa Primero de Mayo · SistemaCooperativa`);
L.push(`-- Generado: ${new Date().toISOString().slice(0, 10)} a partir de listapersonascoop.xlsx`);
L.push(`-- =============================================================================`);
L.push(`-- INSTRUCCIONES:`);
L.push(`--   1. Rellena los montos reales del CSV en las dos secciones marcadas con ▼▼▼.`);
L.push(`--   2. Ejecuta en Supabase Studio → SQL Editor (es un único DO block).`);
L.push(`--   3. La búsqueda es por ILIKE en apellidos — si hay ambigüedad, ajusta el nombre.`);
L.push(`--`);
L.push(`-- MAPEO:`);
L.push(`--   ga_ps    → Gastos administrativos  → puesto del socio (via historial_titularidad)`);
L.push(`--   luz_agua → Deuda anterior          → puesto del socio`);
L.push(`--   deposito → Aporte extraordinario   → puesto del socio`);
L.push(`--   multas   → Multa                   → socio directamente (deuda personal)`);
L.push(`-- =============================================================================`);
L.push(``);
L.push(`DO $$`);
L.push(`DECLARE`);
L.push(`    c_ga   bigint;`);
L.push(`    c_luz  bigint;`);
L.push(`    c_dep  bigint;`);
L.push(`    c_mul  bigint;`);
L.push(`    v_fp   integer;   -- filas de puesto insertadas`);
L.push(`    v_fm   integer;   -- filas de multa insertadas`);
L.push(`BEGIN`);
L.push(`    -- Resolución de IDs de conceptos`);
L.push(`    SELECT id INTO c_ga  FROM public.conceptos WHERE nombre = 'Gastos administrativos';`);
L.push(`    SELECT id INTO c_luz FROM public.conceptos WHERE nombre = 'Deuda anterior';`);
L.push(`    SELECT id INTO c_dep FROM public.conceptos WHERE nombre = 'Aporte extraordinario';`);
L.push(`    SELECT id INTO c_mul FROM public.conceptos WHERE nombre = 'Multa';`);
L.push(`    IF c_ga IS NULL THEN RAISE EXCEPTION 'Concepto "Gastos administrativos" no encontrado'; END IF;`);
L.push(`    IF c_luz IS NULL THEN RAISE EXCEPTION 'Concepto "Deuda anterior" no encontrado'; END IF;`);
L.push(`    IF c_dep IS NULL THEN RAISE EXCEPTION 'Concepto "Aporte extraordinario" no encontrado'; END IF;`);
L.push(`    IF c_mul IS NULL THEN RAISE EXCEPTION 'Concepto "Multa" no encontrado'; END IF;`);
L.push(``);

// ─── BLOQUE A: Deudas de puesto ────────────────────────────────────────────
L.push(`    -- =====================================================================`);
L.push(`    -- BLOQUE A — Deudas de PUESTO (GA/PS, Luz/Agua, Depósito)`);
L.push(`    -- Busca el puesto_id vía JOIN LATERAL sobre apellidos del socio.`);
L.push(`    -- =====================================================================`);
L.push(`    INSERT INTO public.montos_por_cobrar`);
L.push(`        (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes,`);
L.push(`         monto, estado, metodo_calculo, fecha_generacion, observacion)`);
L.push(`    SELECT`);
L.push(`        ht.puesto_id,`);
L.push(`        NULL,`);
L.push(`        t.concepto_id,`);
L.push(`        2026, 5,`);
L.push(`        t.monto,`);
L.push(`        'Pendiente', 'Manual', CURRENT_DATE, 'Deuda Go-Live May-2026'`);
L.push(`    FROM (VALUES`);
L.push(`-- ▼▼▼ DATOS PUESTO (nombre_socio, ga_ps, luz_agua, deposito) ▼▼▼`);
L.push(`-- Rellena los 0.00 con los montos reales. Deja 0.00 si no tiene deuda en ese rubro.`);
L.push(`-- El nombre es el APELLIDO Y NOMBRE del Excel — búsqueda por ILIKE '%nombre%'.`);

SOCIOS.forEach((s, i) => {
  const comma = i < SOCIOS.length - 1 ? ',' : '';
  L.push(`        (${esc(s.nombre)}, 0.00::numeric, 0.00::numeric, 0.00::numeric)${comma}`);
});

L.push(`-- ▲▲▲ FIN DATOS BLOQUE A ▲▲▲`);
L.push(`    ) AS d(nombre, ga_ps, luz_agua, deposito)`);
L.push(`    -- JOIN LATERAL: busca el puesto del socio cuyo apellidos coincida con el nombre`);
L.push(`    JOIN LATERAL (`);
L.push(`        SELECT ht2.puesto_id`);
L.push(`        FROM public.historial_titularidad ht2`);
L.push(`        JOIN public.socios s ON s.id = ht2.socio_id`);
L.push(`        WHERE s.apellidos ILIKE '%' || d.nombre || '%'`);
L.push(`          AND ht2.fecha_fin IS NULL`);
L.push(`        LIMIT 1`);
L.push(`    ) AS ht ON true`);
L.push(`    -- CROSS JOIN expande 3 conceptos por fila (ga_ps, luz_agua, deposito)`);
L.push(`    CROSS JOIN LATERAL (VALUES`);
L.push(`        (c_ga,  d.ga_ps),`);
L.push(`        (c_luz, d.luz_agua),`);
L.push(`        (c_dep, d.deposito)`);
L.push(`    ) AS t(concepto_id, monto)`);
L.push(`    WHERE t.monto > 0`);
L.push(`    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)`);
L.push(`        WHERE deleted_at IS NULL AND puesto_id IS NOT NULL`);
L.push(`        DO NOTHING;`);
L.push(``);
L.push(`    GET DIAGNOSTICS v_fp = ROW_COUNT;`);
L.push(``);

// ─── BLOQUE B: Multas personales del socio ────────────────────────────────
L.push(`    -- =====================================================================`);
L.push(`    -- BLOQUE B — Deudas personales del SOCIO (Multas / Otros)`);
L.push(`    -- Busca directamente el socio_id por apellidos.`);
L.push(`    -- =====================================================================`);
L.push(`    INSERT INTO public.montos_por_cobrar`);
L.push(`        (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes,`);
L.push(`         monto, estado, metodo_calculo, fecha_generacion, observacion)`);
L.push(`    SELECT`);
L.push(`        NULL,`);
L.push(`        s.id,`);
L.push(`        c_mul,`);
L.push(`        2026, 5,`);
L.push(`        d.multas,`);
L.push(`        'Pendiente', 'Manual', CURRENT_DATE, 'Deuda Go-Live May-2026 — Multa'`);
L.push(`    FROM (VALUES`);
L.push(`-- ▼▼▼ DATOS MULTAS (nombre_socio, multas) ▼▼▼`);

SOCIOS.forEach((s, i) => {
  const comma = i < SOCIOS.length - 1 ? ',' : '';
  L.push(`        (${esc(s.nombre)}, 0.00::numeric)${comma}`);
});

L.push(`-- ▲▲▲ FIN DATOS BLOQUE B ▲▲▲`);
L.push(`    ) AS d(nombre, multas)`);
L.push(`    JOIN LATERAL (`);
L.push(`        SELECT id FROM public.socios`);
L.push(`        WHERE apellidos ILIKE '%' || d.nombre || '%'`);
L.push(`        LIMIT 1`);
L.push(`    ) AS s ON true`);
L.push(`    WHERE d.multas > 0`);
L.push(`    ON CONFLICT (socio_id, concepto_id, periodo_anio, periodo_mes)`);
L.push(`        WHERE deleted_at IS NULL AND socio_id IS NOT NULL`);
L.push(`        DO NOTHING;`);
L.push(``);
L.push(`    GET DIAGNOSTICS v_fm = ROW_COUNT;`);
L.push(``);

// ─── RESUMEN ──────────────────────────────────────────────────────────────
L.push(`    RAISE NOTICE '============================================';`);
L.push(`    RAISE NOTICE 'SEED COMPLETADO';`);
L.push(`    RAISE NOTICE '  Deudas de puesto insertadas: %', v_fp;`);
L.push(`    RAISE NOTICE '  Deudas de multa insertadas:  %', v_fm;`);
L.push(`    RAISE NOTICE '  Total:  %', v_fp + v_fm;`);
L.push(`    RAISE NOTICE '  Monto total: S/ %',`);
L.push(`        (SELECT round(sum(monto),2) FROM public.montos_por_cobrar WHERE periodo_anio=2026 AND periodo_mes=5);`);
L.push(`    RAISE NOTICE '============================================';`);
L.push(`END;`);
L.push(`$$;`);

const out = L.join('\n');
fs.writeFileSync('supabase/seed_migracion_deudas_iniciales.sql', out, 'utf8');
console.log(`✓ Generado: supabase/seed_migracion_deudas_iniciales.sql`);
console.log(`  ${SOCIOS.length} socios en el seed (nombres reales del Excel)`);
console.log(`  Montos en 0.00 → rellenar con datos del CSV de deudas`);
