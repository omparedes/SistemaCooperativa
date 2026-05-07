'use strict';
/**
 * hard_reset_padron.cjs
 *
 * Lee migracion_coop/SOCIOS E INQUILINOS TERMINADO.xlsx
 * y genera supabase/migrations/00036_hard_reset_y_padron_limpio.sql
 *
 * El SQL empieza con TRUNCATE + RESTART de secuencias, luego
 * re-puebla TODO desde el Excel. NO requiere conexión a Supabase.
 *
 * Uso: node scripts/hard_reset_padron.cjs
 */

const XLSX = require('xlsx');
const fs   = require('fs');
const path = require('path');

// =============================================================================
// CONFIG
// =============================================================================
const ROOT      = path.resolve(__dirname, '..');
const EXCEL     = path.join(ROOT, 'migracion_coop', 'SOCIOS E INQUILINOS TERMINADO.xlsx');
const OUT_SQL   = path.join(ROOT, 'supabase', 'migrations', '00036_hard_reset_y_padron_limpio.sql');

const FECHA_INICIO   = '2020-01-01';
const GIRO_SQL       = "(SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1)";
const COOP_SOCIO_SQL = "(SELECT id FROM public.socios WHERE dni = '00000000' LIMIT 1)";

// Tablas financieras a truncar (en orden seguro para CASCADE)
const TRUNCATE_TABLES = [
  'public.detalle_pagos',
  'public.pagos',
  'public.recaudacion_abonos',
  'public.montos_por_cobrar',
  'public.historial_arriendos',
  'public.historial_titularidad',
  'public.inquilinos',
  'public.socios',
  'public.puestos',
];

// Secuencias a reiniciar
const SEQUENCES = [
  'public.detalle_pagos_id_seq',
  'public.pagos_id_seq',
  'public.recaudacion_abonos_id_seq',
  'public.montos_por_cobrar_id_seq',
  'public.historial_arriendos_id_seq',
  'public.historial_titularidad_id_seq',
  'public.inquilinos_id_seq',
  'public.socios_id_seq',
  'public.puestos_id_seq',
  'public.seq_codigo_transaccion',
];

// =============================================================================
// HELPERS
// =============================================================================
function normName(s) {
  return String(s)
    .toUpperCase()
    .normalize('NFD').replace(/[̀-ͯ]/g, '')
    .replace(/[^A-Z0-9 ]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();
}

function normDni(d) {
  return String(d).replace(/\s+/g, '').trim();
}

/** Escapa un string para SQL single-quoted */
function esc(s) {
  return `'${String(s).replace(/'/g, "''")}'`;
}

// =============================================================================
// EXCEL PARSING
// =============================================================================

/**
 * Hoja SOCIOS: [idx, DNI, "Apellidos y nombres", Puesto-numérico]
 * Devuelve 185 registros.
 */
function parseSocios(wb) {
  const ws   = wb.Sheets['SOCIOS'];
  const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
  return rows.slice(1)
    .filter(r => r[1] && String(r[2]).trim())
    .map(r => ({
      dni:    normDni(r[1]),
      nombre: normName(r[2]),
      puesto: String(r[3]).trim(),   // ej: "134", "63", "59"
    }));
}

/**
 * Hoja INQUIINOS (typo en Excel):
 *   Sección E  : puestos "31-E", "2-E", etc. | col[4]='' o 'COOP'
 *   Sección SP : detectada por puesto="Inquilinos 2do Piso"
 *   Sección EP : detectada por puesto="Espacios"
 *
 * Devuelve array de { dni, nombre, puesto, section, coop_mark }.
 */
function parseInquilinos(wb) {
  const ws   = wb.Sheets['INQUIINOS'];
  const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
  const out  = [];
  let section = 'E';

  for (const r of rows.slice(1)) {
    const dni    = String(r[1]).trim();
    const nombre = String(r[2]).trim();
    const puesto = String(r[3]).trim();
    const extra  = String(r[4]).trim().toUpperCase();

    if (puesto === 'Inquilinos 2do Piso') { section = 'SP'; continue; }
    if (puesto === 'Espacios')            { section = 'EP'; continue; }
    if (puesto === 'DNI' || dni === 'DNI' || (!dni && !nombre)) continue;
    if (!nombre) continue;

    out.push({
      dni:       normDni(dni),
      nombre:    normName(nombre),
      puesto:    puesto,
      section,
      coop_mark: extra === 'COOP',
    });
  }
  return out;
}

/**
 * Hoja DEPOSITO: tres secciones (1ER→D1, 2DO→D2, 3ER→D3)
 * Columnas: [idx, apellidos, nombres, giro, puesto_code, monto]
 * Incluye filas "COOPERATIVA" → se marca con isCoop=true.
 * NO hay columna DNI → todos reciben DNI placeholder.
 */
function parseDepositos(wb) {
  const ws   = wb.Sheets['DEPOSITO'];
  const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
  const out  = [];
  let seccion = 'D1';

  for (const r of rows) {
    const colB = String(r[1]).trim();
    const colC = String(r[2]).trim();
    const colD = String(r[3]).trim();
    const colE = String(r[4]).trim();

    if (colB === 'NOMBRE') {
      const piso = String(r[4]).toUpperCase();
      if      (piso.includes('1ER')) seccion = 'D1';
      else if (piso.includes('2DO')) seccion = 'D2';
      else if (piso.includes('3ER')) seccion = 'D3';
      continue;
    }
    if (!colB && !colE) continue;
    if (!colE) continue;

    const isCoop = colB.toUpperCase() === 'COOPERATIVA';
    const nombre = isCoop ? 'COOPERATIVA PRIMERO DE MAYO' : normName(`${colB} ${colC}`);

    out.push({
      nombre,
      giro:    colD,
      puesto:  colE,
      seccion,
      isCoop,
    });
  }
  return out;
}

// =============================================================================
// SQL GENERATION
// =============================================================================
const L = [];
function line(s = '') { L.push(s); }
function sep(title) {
  line('');
  line(`-- ${'─'.repeat(77)}`);
  line(`-- ${title}`);
  line(`-- ${'─'.repeat(77)}`);
}

// =============================================================================
// MAIN
// =============================================================================
function main() {
  console.log('\n📋 Leyendo Excel:', path.basename(EXCEL));
  const wb = XLSX.readFile(EXCEL);

  const exSocios    = parseSocios(wb);
  const exInqs      = parseInquilinos(wb);
  const exDepositos = parseDepositos(wb);

  const exInqsE    = exInqs.filter(i => i.section === 'E' && !i.coop_mark);
  const exInqsCoop = exInqs.filter(i => i.coop_mark);
  const exInqsSP   = exInqs.filter(i => i.section === 'SP');
  const exInqsEP   = exInqs.filter(i => i.section === 'EP');

  const exDepsD1   = exDepositos.filter(d => d.seccion === 'D1');
  const exDepsD2   = exDepositos.filter(d => d.seccion === 'D2');
  const exDepsD3   = exDepositos.filter(d => d.seccion === 'D3');

  console.log(`  Socios:            ${exSocios.length}    (esperados: 185)`);
  console.log(`  Inquilinos E:      ${exInqsE.length}    (esperados: 60)`);
  console.log(`  Inquilinos COOP:   ${exInqsCoop.length}     (esperados: 4)`);
  console.log(`  Inquilinos SP:     ${exInqsSP.length}     (esperados: 6)`);
  console.log(`  Inquilinos EP:     ${exInqsEP.length}     (esperados: 7)`);
  console.log(`  Depósitos D1:      ${exDepsD1.length}     (esperados: 7)`);
  console.log(`  Depósitos D2:      ${exDepsD2.length}    (esperados: 11)`);
  console.log(`  Depósitos D3:      ${exDepsD3.length}     (esperados: 8)`);

  // ─── Detectar DNIs duplicados en SOCIOS ────────────────────────────────────
  const dniCount = {};
  exSocios.forEach(s => { dniCount[s.dni] = (dniCount[s.dni] || 0) + 1; });
  const dupDnis  = new Set(Object.keys(dniCount).filter(d => dniCount[d] > 1));
  const seenDnis = new Set();

  // Construir lista final de socios con DNIs desambiguados
  const socios = exSocios.map(s => {
    let dni = s.dni;
    if (dupDnis.has(dni)) {
      if (seenDnis.has(dni)) dni = `${dni}-DUP`;
      seenDnis.add(s.dni);
    }
    return { ...s, dniResuelto: dni };
  });
  if (dupDnis.size) {
    console.log(`  ⚠️  DNIs duplicados en SOCIOS: ${[...dupDnis].join(', ')} → el 2° lleva sufijo -DUP`);
  }

  // ─── Calcular todos los códigos de puesto necesarios ──────────────────────
  const puestoCodes = new Set([
    ...socios.map(s => s.puesto),
    ...exInqsE.map(i => i.puesto),
    ...exInqsCoop.map(i => String(i.puesto)),
    ...exInqsSP.map(i => i.puesto),
    ...exInqsEP.map(i => i.puesto),
    ...exDepsD1.map(d => d.puesto),
    ...exDepsD2.map(d => d.puesto),
    ...exDepsD3.map(d => d.puesto),
  ]);
  const puestosOrdenados = [...puestoCodes].sort((a, b) => a.localeCompare(b, undefined, { numeric: true }));

  console.log(`\n  Total puestos únicos: ${puestosOrdenados.length}`);

  // ==========================================================================
  // GENERACIÓN SQL
  // ==========================================================================
  const now = new Date().toISOString().slice(0, 10);

  const totalInqs = exInqsE.length + exInqsCoop.length + exInqsSP.length +
                    exInqsEP.length + exDepsD1.length + exDepsD2.length + exDepsD3.length;

  // ── ENCABEZADO ─────────────────────────────────────────────────────────────
  line(`-- ${'='.repeat(77)}`);
  line(`-- Migración 00036 — HARD RESET + Padrón Limpio (generado ${now})`);
  line(`-- Cooperativa Primero de Mayo · SistemaCooperativa`);
  line(`-- Fuente: migracion_coop/SOCIOS E INQUILINOS TERMINADO.xlsx`);
  line(`-- ${'='.repeat(77)}`);
  line(`-- RESUMEN:`);
  line(`--   Socios:                ${socios.length}`);
  line(`--   Puestos únicos:        ${puestosOrdenados.length}`);
  line(`--   Inquilinos 1er piso:   ${exInqsE.length + exInqsCoop.length}  (-E + COOP)`);
  line(`--   Inquilinos 2do piso:   ${exInqsSP.length}  (-SP)`);
  line(`--   Inquilinos espacios:   ${exInqsEP.length}  (-EP)`);
  line(`--   Inquilinos depós. D1:  ${exDepsD1.length}`);
  line(`--   Inquilinos depós. D2:  ${exDepsD2.length}`);
  line(`--   Inquilinos depós. D3:  ${exDepsD3.length}`);
  line(`--   Total inquilinos:      ${totalInqs}`);
  line(`-- ${'='.repeat(77)}`);
  line(`-- ⚠️  PREREQUISITO:`);
  line(`--   Debe existir un socio con DNI='00000000' que represente a la Cooperativa.`);
  line(`--   Se usa como socio_titular_id en puestos SP, EP y Depósitos.`);
  line(`--   Si no existe, los arriendos SP/EP/D emitirán WARNING y se omitirán.`);
  line(`-- ⚠️  VERIFICAR MANUALMENTE:`);
  line(`--   [ ] Socios con DNI duplicado (sufijo -DUP): verificar identidad`);
  if (dupDnis.size) {
    dupDnis.forEach(d => line(`--       • ${d}`));
  }
  line(`-- ${'='.repeat(77)}`);
  line('');
  line('BEGIN;');

  // ── PASO 0: TRUNCATE agresivo ──────────────────────────────────────────────
  sep('PASO 0: HARD RESET — Truncar todas las tablas del padrón y financieras');
  line(`-- ⚠️  DESTRUCTIVO E IRREVERSIBLE. Solo ejecutar en entorno NO-producción.`);
  line(`TRUNCATE`);
  TRUNCATE_TABLES.forEach((t, i) => {
    const comma = i < TRUNCATE_TABLES.length - 1 ? ',' : '';
    line(`  ${t}${comma}`);
  });
  line(`CASCADE;`);
  line('');

  // ── PASO 0b: RESTART secuencias ────────────────────────────────────────────
  sep('PASO 0b: Reiniciar secuencias de ID para partir desde 1');
  SEQUENCES.forEach(seq => {
    // IF EXISTS para no fallar si alguna secuencia aún no existe (migraciones opcionales)
    line(`ALTER SEQUENCE IF EXISTS ${seq} RESTART WITH 1;`);
  });

  // ── PASO 1: Insertar todos los puestos ─────────────────────────────────────
  sep(`PASO 1: Insertar ${puestosOrdenados.length} puestos (socios + E + SP + EP + D1/D2/D3)`);
  line(`INSERT INTO public.puestos (codigo_puesto, giro_id, estado, tiene_medidor_luz, tiene_medidor_agua)`);
  line(`VALUES`);
  puestosOrdenados.forEach((code, i) => {
    const comma = i < puestosOrdenados.length - 1 ? ',' : '';
    let tag = '';
    if      (code.includes('-SP')) tag = ' -- 2do Piso';
    else if (code.includes('-EP')) tag = ' -- Espacio';
    else if (code.match(/-D\d$/))  tag = ' -- Depósito';
    else if (code.includes('-E'))  tag = ' -- Puesto pequeño';
    line(`  (${esc(code)}, ${GIRO_SQL}, 'Activo', false, false)${comma}${tag}`);
  });
  line(`ON CONFLICT (codigo_puesto) DO NOTHING;`);

  // ── PASO 2: Insertar 185 socios ────────────────────────────────────────────
  sep(`PASO 2: Insertar ${socios.length} socios`);
  line(`INSERT INTO public.socios`);
  line(`  (dni, nombres, apellidos, estado, habilitado, fecha_ingreso,`);
  line(`   usa_recaudacion_tarjeta)`);
  line(`VALUES`);
  socios.forEach((s, i) => {
    const comma = i < socios.length - 1 ? ',' : '';
    line(`  (${esc(s.dniResuelto)}, '', ${esc(s.nombre)}, 'Activo', true, ${esc(FECHA_INICIO)}, false)${comma}`);
  });
  line(`ON CONFLICT (dni) DO UPDATE SET`);
  line(`  apellidos               = EXCLUDED.apellidos,`);
  line(`  estado                  = 'Activo',`);
  line(`  habilitado              = true,`);
  line(`  usa_recaudacion_tarjeta = false;`);

  // ── PASO 3: historial_titularidad — 185 socios ↔ puestos ──────────────────
  sep(`PASO 3: historial_titularidad — ${socios.length} socios vinculados a sus puestos`);
  line(`DO $$`);
  line(`DECLARE`);
  line(`  rec record;`);
  line(`  v_s bigint; v_p bigint;`);
  line(`BEGIN`);
  line(`  FOR rec IN (`);
  line(`    SELECT * FROM (VALUES`);

  socios.forEach((s, i) => {
    const comma = i < socios.length - 1 ? ',' : '';
    line(`      (${esc(s.dniResuelto)}, ${esc(s.puesto)})${comma}`);
  });

  line(`    ) t(dni, puesto_code)`);
  line(`  )`);
  line(`  LOOP`);
  line(`    SELECT id INTO v_s FROM public.socios WHERE dni = rec.dni;`);
  line(`    SELECT id INTO v_p FROM public.puestos WHERE codigo_puesto = rec.puesto_code;`);
  line(`    IF v_s IS NULL THEN`);
  line(`      RAISE WARNING 'Titularidad: socio no encontrado DNI=%', rec.dni;`);
  line(`      CONTINUE;`);
  line(`    END IF;`);
  line(`    IF v_p IS NULL THEN`);
  line(`      RAISE WARNING 'Titularidad: puesto no encontrado código=%', rec.puesto_code;`);
  line(`      CONTINUE;`);
  line(`    END IF;`);
  line(`    IF NOT EXISTS (`);
  line(`      SELECT 1 FROM public.historial_titularidad`);
  line(`      WHERE puesto_id = v_p AND socio_id = v_s AND fecha_fin IS NULL`);
  line(`    ) THEN`);
  line(`      INSERT INTO public.historial_titularidad (puesto_id, socio_id, fecha_inicio)`);
  line(`      VALUES (v_p, v_s, ${esc(FECHA_INICIO)});`);
  line(`    END IF;`);
  line(`  END LOOP;`);
  line(`END; $$;`);

  // ── PASO 4: Insertar inquilinos ────────────────────────────────────────────
  // Orden: E, COOP, SP, EP, D1, D2, D3
  // Depósitos: DNI = 'DEP-<puesto>' (sin DNI en Excel)
  // COOPERATIVA D2: DNI = 'COOP-<puesto>'
  const inqRows = [
    ...exInqsE.map(i    => ({ dni: i.dni,            nombre: i.nombre, tag: '' })),
    ...exInqsCoop.map(i => ({ dni: i.dni,            nombre: i.nombre, tag: ' -- COOP' })),
    ...exInqsSP.map(i   => ({ dni: i.dni,            nombre: i.nombre, tag: ' -- 2do Piso' })),
    ...exInqsEP.map(i   => ({ dni: i.dni,            nombre: i.nombre, tag: ' -- Espacio' })),
    ...exDepsD1.map(d   => ({ dni: `DEP-${d.puesto}`, nombre: d.nombre, tag: ` -- Depósito ${d.seccion}` })),
    ...exDepsD2.map(d   => ({
      dni:    d.isCoop ? `COOP-${d.puesto}` : `DEP-${d.puesto}`,
      nombre: d.nombre,
      tag:    ` -- Depósito ${d.seccion}${d.isCoop ? ' (Cooperativa)' : ''}`,
    })),
    ...exDepsD3.map(d   => ({ dni: `DEP-${d.puesto}`, nombre: d.nombre, tag: ` -- Depósito ${d.seccion}` })),
  ];

  sep(`PASO 4: Insertar ${inqRows.length} inquilinos`);
  line(`INSERT INTO public.inquilinos (dni, nombres, apellidos)`);
  line(`VALUES`);
  inqRows.forEach((r, i) => {
    const comma = i < inqRows.length - 1 ? ',' : '';
    line(`  (${esc(r.dni)}, '', ${esc(r.nombre)})${comma}${r.tag}`);
  });
  line(`ON CONFLICT (dni) DO UPDATE SET`);
  line(`  apellidos = EXCLUDED.apellidos;`);

  // ── PASO 5: historial_arriendos — E y COOP (auto-resolubles) ──────────────
  const inqConHistorial = [
    ...exInqsE.map(i    => ({
      dni:        i.dni,
      nombre:     i.nombre,
      puesto:     i.puesto,
      base_puesto: i.puesto.replace(/-E$/i, '').trim(),
    })),
    ...exInqsCoop.map(i => ({
      dni:        i.dni,
      nombre:     i.nombre,
      puesto:     String(i.puesto),
      base_puesto: String(i.puesto),    // misma clave: el socio es el titular del puesto COOP
    })),
  ];

  sep(`PASO 5: historial_arriendos — ${inqConHistorial.length} inquilinos E+COOP (auto-resolubles)`);
  line(`-- socio_titular_id se resuelve desde historial_titularidad del puesto base.`);
  line(`-- Si el puesto base no tiene titular, se emite WARNING y se omite.`);
  line(`DO $$`);
  line(`DECLARE`);
  line(`  rec record;`);
  line(`  v_inq bigint; v_pue bigint; v_soc bigint;`);
  line(`BEGIN`);
  line(`  FOR rec IN (`);
  line(`    SELECT * FROM (VALUES`);

  inqConHistorial.forEach((i, idx) => {
    const comma = idx < inqConHistorial.length - 1 ? ',' : '';
    line(`      (${esc(i.dni)}, ${esc(i.puesto)}, ${esc(i.base_puesto)})${comma}`);
  });

  line(`    ) t(inq_dni, puesto_code, base_puesto)`);
  line(`  )`);
  line(`  LOOP`);
  line(`    SELECT id INTO v_inq FROM public.inquilinos WHERE dni = rec.inq_dni;`);
  line(`    SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = rec.puesto_code;`);
  line(`    SELECT ht.socio_id INTO v_soc`);
  line(`      FROM public.historial_titularidad ht`);
  line(`      JOIN public.puestos p ON p.id = ht.puesto_id`);
  line(`      WHERE p.codigo_puesto = rec.base_puesto AND ht.fecha_fin IS NULL`);
  line(`      LIMIT 1;`);
  line(`    IF v_inq IS NULL THEN`);
  line(`      RAISE WARNING 'Arriendo: inquilino no encontrado DNI=%', rec.inq_dni;`);
  line(`      CONTINUE;`);
  line(`    END IF;`);
  line(`    IF v_pue IS NULL THEN`);
  line(`      RAISE WARNING 'Arriendo: puesto no encontrado código=%', rec.puesto_code;`);
  line(`      CONTINUE;`);
  line(`    END IF;`);
  line(`    IF v_soc IS NULL THEN`);
  line(`      RAISE WARNING 'Arriendo: sin titular vigente para puesto base=%  — DNI=% OMITIDO',`);
  line(`                    rec.base_puesto, rec.inq_dni;`);
  line(`      CONTINUE;`);
  line(`    END IF;`);
  line(`    IF NOT EXISTS (`);
  line(`      SELECT 1 FROM public.historial_arriendos`);
  line(`      WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL`);
  line(`    ) THEN`);
  line(`      INSERT INTO public.historial_arriendos`);
  line(`        (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)`);
  line(`      VALUES (v_pue, v_inq, v_soc, ${esc(FECHA_INICIO)});`);
  line(`      RAISE NOTICE 'Arriendo: DNI=% → puesto=%', rec.inq_dni, rec.puesto_code;`);
  line(`    END IF;`);
  line(`  END LOOP;`);
  line(`END; $$;`);

  // ── PASO 6: SP y EP ───────────────────────────────────────────────────────
  sep(`PASO 6: historial_arriendos para -SP y -EP (${exInqsSP.length + exInqsEP.length} arriendos)`);
  line(`-- socio_titular_id = socio cooperativa con DNI '00000000'.`);
  line(`-- Si ese socio no existe, cada DO-block emitirá WARNING y saltará la fila.`);
  line('');

  [...exInqsSP, ...exInqsEP].forEach(inq => {
    const tag = inq.section === 'SP' ? '2do Piso' : 'Espacio';
    line(`-- ${tag}: ${inq.nombre} → ${inq.puesto}`);
    line(`DO $$`);
    line(`DECLARE v_inq bigint; v_pue bigint; v_soc bigint;`);
    line(`BEGIN`);
    line(`  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = ${esc(inq.dni)};`);
    line(`  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = ${esc(inq.puesto)};`);
    line(`  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;`);
    line(`  IF v_inq IS NULL OR v_pue IS NULL THEN`);
    line(`    RAISE WARNING '${inq.nombre}: inquilino o puesto no encontrado'; RETURN;`);
    line(`  END IF;`);
    line(`  IF v_soc IS NULL THEN`);
    line(`    RAISE WARNING '${inq.nombre}: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;`);
    line(`  END IF;`);
    line(`  IF NOT EXISTS (`);
    line(`    SELECT 1 FROM public.historial_arriendos`);
    line(`    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL`);
    line(`  ) THEN`);
    line(`    INSERT INTO public.historial_arriendos`);
    line(`      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)`);
    line(`    VALUES (v_pue, v_inq, v_soc, ${esc(FECHA_INICIO)});`);
    line(`    RAISE NOTICE 'Arriendo SP/EP: % → %', '${inq.nombre}', '${inq.puesto}';`);
    line(`  END IF;`);
    line(`END; $$;`);
    line('');
  });

  // ── PASO 7: Depósitos D1 / D2 / D3 ──────────────────────────────────────
  const totalDeps = exDepsD1.length + exDepsD2.length + exDepsD3.length;
  sep(`PASO 7: historial_arriendos para Depósitos D1/D2/D3 (${totalDeps} arriendos)`);
  line(`-- Los depósitos son propiedad de la Cooperativa.`);
  line(`-- socio_titular_id = socio cooperativa con DNI '00000000'.`);
  line('');

  [...exDepsD1, ...exDepsD2, ...exDepsD3].forEach(dep => {
    const dniInq = dep.isCoop ? `COOP-${dep.puesto}` : `DEP-${dep.puesto}`;
    line(`-- ${dep.seccion}: ${dep.nombre} → ${dep.puesto}`);
    line(`DO $$`);
    line(`DECLARE v_inq bigint; v_pue bigint; v_soc bigint;`);
    line(`BEGIN`);
    line(`  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = ${esc(dniInq)};`);
    line(`  SELECT id INTO v_pue FROM public.puestos    WHERE codigo_puesto = ${esc(dep.puesto)};`);
    line(`  SELECT id INTO v_soc FROM public.socios WHERE dni = '00000000' LIMIT 1;`);
    line(`  IF v_inq IS NULL OR v_pue IS NULL THEN`);
    line(`    RAISE WARNING '${dep.nombre}: inquilino o puesto no encontrado'; RETURN;`);
    line(`  END IF;`);
    line(`  IF v_soc IS NULL THEN`);
    line(`    RAISE WARNING '${dep.nombre}: socio cooperativa (DNI=00000000) no encontrado — arriendo OMITIDO'; RETURN;`);
    line(`  END IF;`);
    line(`  IF NOT EXISTS (`);
    line(`    SELECT 1 FROM public.historial_arriendos`);
    line(`    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL`);
    line(`  ) THEN`);
    line(`    INSERT INTO public.historial_arriendos`);
    line(`      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)`);
    line(`    VALUES (v_pue, v_inq, v_soc, ${esc(FECHA_INICIO)});`);
    line(`    RAISE NOTICE 'Arriendo Depósito: % → %', '${dep.nombre}', '${dep.puesto}';`);
    line(`  END IF;`);
    line(`END; $$;`);
    line('');
  });

  // ── PASO 8: Estado final y verificación ────────────────────────────────────
  sep('PASO 8: Estado final y verificación');
  line(`DO $$`);
  line(`DECLARE`);
  line(`  v_socios bigint; v_inqs bigint; v_puestos bigint;`);
  line(`  v_tit    bigint; v_arr  bigint;`);
  line(`BEGIN`);
  line(`  SELECT count(*) INTO v_socios  FROM public.socios   WHERE deleted_at IS NULL;`);
  line(`  SELECT count(*) INTO v_inqs    FROM public.inquilinos WHERE deleted_at IS NULL;`);
  line(`  SELECT count(*) INTO v_puestos FROM public.puestos   WHERE deleted_at IS NULL;`);
  line(`  SELECT count(*) INTO v_tit     FROM public.historial_titularidad WHERE fecha_fin IS NULL;`);
  line(`  SELECT count(*) INTO v_arr     FROM public.historial_arriendos   WHERE fecha_fin IS NULL;`);
  line(`  RAISE NOTICE '========================================================';`);
  line(`  RAISE NOTICE '✓ Migración 00036 completada';`);
  line(`  RAISE NOTICE '  Socios activos:          %  (esperados: ${socios.length})', v_socios;`);
  line(`  RAISE NOTICE '  Inquilinos activos:      %  (esperados: ${totalInqs})', v_inqs;`);
  line(`  RAISE NOTICE '  Puestos activos:         %  (esperados: ${puestosOrdenados.length})', v_puestos;`);
  line(`  RAISE NOTICE '  Titularidades vigentes:  %  (esperados: ${socios.length})', v_tit;`);
  const totalArriendos = inqConHistorial.length + exInqsSP.length + exInqsEP.length +
                         exDepsD1.length + exDepsD2.length + exDepsD3.length;
  line(`  RAISE NOTICE '  Arriendos vigentes:      %  (esperados: ${totalArriendos} si DNI 00000000 existe)', v_arr;`);
  line(`  IF v_socios <> ${socios.length} THEN`);
  line(`    RAISE WARNING 'SOCIOS: se esperaban ${socios.length}, se encontraron %', v_socios;`);
  line(`  END IF;`);
  line(`  IF v_tit <> v_socios THEN`);
  line(`    RAISE WARNING 'HAY % SOCIOS SIN TITULARIDAD VIGENTE', (v_socios - v_tit);`);
  line(`  END IF;`);
  line(`  RAISE NOTICE '========================================================';`);
  line(`END; $$;`);

  line('');
  line('COMMIT;');

  // ─── Escribir archivo ──────────────────────────────────────────────────────
  fs.writeFileSync(OUT_SQL, L.join('\n'), 'utf8');
  const size = (fs.statSync(OUT_SQL).size / 1024).toFixed(1);
  console.log(`\n✅ SQL generado: ${path.basename(OUT_SQL)}`);
  console.log(`   Líneas: ${L.length}   Tamaño: ${size} KB`);

  console.log('\n═══════════════════════════════════════════════════════');
  console.log('RESUMEN DEL HARD RESET');
  console.log('═══════════════════════════════════════════════════════');
  console.log(`  Tablas a truncar:      ${TRUNCATE_TABLES.length}`);
  console.log(`  Secuencias a reiniciar:${SEQUENCES.length}`);
  console.log(`  Puestos a insertar:    ${puestosOrdenados.length}`);
  console.log(`  Socios a insertar:     ${socios.length}`);
  console.log(`  Inquilinos a insertar: ${totalInqs}`);
  console.log(`    - E (1er piso):      ${exInqsE.length}`);
  console.log(`    - COOP (1er piso):   ${exInqsCoop.length}`);
  console.log(`    - SP (2do piso):     ${exInqsSP.length}`);
  console.log(`    - EP (Espacios):     ${exInqsEP.length}`);
  console.log(`    - D1 Depósitos:      ${exDepsD1.length}`);
  console.log(`    - D2 Depósitos:      ${exDepsD2.length}`);
  console.log(`    - D3 Depósitos:      ${exDepsD3.length}`);
  console.log(`  Arriendos E+COOP:      ${inqConHistorial.length}  (auto via titularidad)`);
  console.log(`  Arriendos SP+EP:       ${exInqsSP.length + exInqsEP.length}  (via DNI 00000000)`);
  console.log(`  Arriendos D1+D2+D3:    ${exDepsD1.length + exDepsD2.length + exDepsD3.length}  (via DNI 00000000)`);
  console.log('───────────────────────────────────────────────────────');
  console.log('PREREQUISITO: Crear en BD el socio con DNI=00000000 que');
  console.log('representa a la Cooperativa como titular de puestos SP/EP/D.');
  console.log('PRÓXIMO PASO: pegar en SQL Editor del Supabase Dashboard');
  console.log('═══════════════════════════════════════════════════════\n');
}

main();
