'use strict';
/**
 * sincronizar_padron_final.cjs
 *
 * Lee  migracion_coop/SOCIOS E INQUILINOS TERMINADO.xlsx,
 * compara contra la BD real de Supabase (socios, inquilinos, puestos,
 * historial_titularidad, historial_arriendos) y genera
 * supabase/migrations/00035_upsert_padron_final.sql
 *
 * SEGURIDAD: Este script SOLO GENERA SQL — nunca escribe en la BD.
 * Similitud de cadenas: implementación Dice-bigramas (equivalente a
 * la librería `string-similarity` sin dependencias externas).
 *
 * Uso: node scripts/sincronizar_padron_final.cjs
 */

const XLSX = require('xlsx');
const fs   = require('fs');
const path = require('path');
const { createClient } = require('@supabase/supabase-js');

// =============================================================================
// CONFIG
// =============================================================================
const ROOT      = path.resolve(__dirname, '..');
const EXCEL     = path.join(ROOT, 'migracion_coop', 'SOCIOS E INQUILINOS TERMINADO.xlsx');
const OUT_SQL   = path.join(ROOT, 'supabase', 'migrations', '00035_upsert_padron_final.sql');
const ENV_FILE  = path.join(ROOT, '.env');

const FECHA_INICIO  = '2020-01-01'; // Fecha base para todos los historiales
const SIM_THRESHOLD = 0.82;         // Umbral mínimo de similitud para match por nombre
const GIRO_SQL      = "(SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1)";

// =============================================================================
// ENV LOADER — sin dotenv
// =============================================================================
function loadEnv() {
  const env = {};
  if (!fs.existsSync(ENV_FILE)) return env;
  fs.readFileSync(ENV_FILE, 'utf8').split('\n').forEach(line => {
    const m = line.match(/^([A-Z_][A-Z0-9_]*)\s*=\s*(.+)$/);
    if (m) env[m[1]] = m[2].trim();
  });
  return env;
}

// =============================================================================
// STRING SIMILARITY — Dice coefficient sobre bigramas
// (implementación equivalente a la librería `string-similarity`)
// =============================================================================
function bigrams(str) {
  const set = new Set();
  for (let i = 0; i < str.length - 1; i++) set.add(str.slice(i, i + 2));
  return set;
}

function similarity(a, b) {
  if (a === b) return 1.0;
  if (a.length < 2 || b.length < 2) return 0.0;
  const ba = bigrams(a), bb = bigrams(b);
  let hits = 0;
  for (const bg of ba) if (bb.has(bg)) hits++;
  return (2 * hits) / (ba.size + bb.size);
}

// =============================================================================
// NORMALIZACIÓN
// =============================================================================
function normName(s) {
  return String(s)
    .toUpperCase()
    .normalize('NFD').replace(/[̀-ͯ]/g, '') // quitar tildes
    .replace(/[^A-Z0-9 ]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();
}

function normDni(d) {
  return String(d).replace(/\s+/g, '').trim();
}

/** Escapa un string para SQL single-quoted */
function esc(s) { return `'${String(s).replace(/'/g, "''")}'`; }

/** Devuelve true si el DNI parece un placeholder generado por nosotros */
function isPlaceholderDni(d) {
  return /^(SOC|INQ)-\d+$/.test(d);
}

// =============================================================================
// EXCEL PARSING
// =============================================================================

/** Hoja SOCIOS: columnas (idx, DNI, "Apellidos y nombres", Puesto-numérico) */
function parseSocios(wb) {
  const ws   = wb.Sheets['SOCIOS'];
  const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
  return rows.slice(1)
    .filter(r => r[1] && String(r[2]).trim())
    .map(r => ({
      dni:    normDni(r[1]),
      nombre: normName(r[2]),
      puesto: String(r[3]).trim(),
    }));
}

/**
 * Hoja INQUIINOS (typo en Excel): columnas (idx, DNI, "Apellidos y nombres", Puesto, Marca, _)
 * El sheet tiene tres secciones separadas por filas-header internas:
 *   1ª (default): puestos -E
 *   2ª (header: puesto="Inquilinos 2do Piso"): puestos -SP
 *   3ª (header: puesto="Espacios"): puestos -EP
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

    // Detectar cambio de sección por la columna "Puesto"
    if (puesto === 'Inquilinos 2do Piso') { section = 'SP'; continue; }
    if (puesto === 'Espacios')            { section = 'EP'; continue; }

    // Saltar filas de cabecera internas (col DNI = "DNI") y filas vacías
    if (dni === 'DNI' || (!dni && !nombre)) continue;
    if (!nombre) continue;

    out.push({
      dni:       normDni(dni),
      nombre:    normName(nombre),
      puesto,                        // código tal cual: "31-E", "1-SP", "1-EP", "32" (COOP)
      coop_mark: extra === 'COOP',   // puestos principales alquilados directamente a la Cooperativa
      section,                       // 'E' | 'SP' | 'EP'
    });
  }
  return out;
}

/**
 * Hoja DEPOSITO: tres sub-secciones (1ER PISO→D1, 2DO PISO→D2, 3ER PISO→D3)
 * Columnas: (idx, "NOMBRE"=apellidos, "APELLIDO"=nombres, giro, codigo_puesto, monto)
 * Las filas "COOPERATIVA" se omiten (depósito propiedad de la cooperativa, sin inquilino).
 */
function parseDepositos(wb) {
  const ws   = wb.Sheets['DEPOSITO'];
  const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
  const out  = [];
  let seccion = 'D1';

  for (const r of rows) {
    const colB = String(r[1]).trim(); // apellidos (cabecera "NOMBRE")
    const colC = String(r[2]).trim(); // nombres   (cabecera "APELLIDO")
    const colD = String(r[3]).trim(); // giro
    const colE = String(r[4]).trim(); // código de puesto
    const colF = r[5];               // monto

    // Filas de cabecera de sección
    if (colB === 'NOMBRE') {
      const piso = String(r[4]).toUpperCase();
      if      (piso.includes('1ER')) seccion = 'D1';
      else if (piso.includes('2DO')) seccion = 'D2';
      else if (piso.includes('3ER')) seccion = 'D3';
      continue;
    }
    // Filas vacías
    if (!colB && !colE) continue;
    // Filas COOPERATIVA → depósito de la cooperativa, sin arrendatario externo
    if (colB.toUpperCase() === 'COOPERATIVA') {
      console.log(`  [DEPOSITO] ℹ️  Omitiendo ${colE} — propiedad Cooperativa (sin arrendatario)`);
      continue;
    }
    if (!colE) continue;

    out.push({
      dni:     null,                            // DEPOSITO no tiene columna DNI
      nombre:  normName(`${colB} ${colC}`),     // "APELLIDOS NOMBRES" = formato estándar BD
      giro:    colD,
      puesto:  colE,
      monto:   typeof colF === 'number' ? colF : 0,
      seccion,                                  // 'D1' | 'D2' | 'D3'
    });
  }
  return out;
}

// =============================================================================
// FETCH BD
// =============================================================================
async function fetchBD(sb) {
  console.log('  → Cargando socios...');
  const { data: socios, error: e1 } = await sb
    .from('socios').select('id,dni,nombres,apellidos,estado,habilitado').limit(5000);
  if (e1) throw new Error(`socios: ${e1.message}`);

  console.log('  → Cargando inquilinos...');
  const { data: inquilinos, error: e2 } = await sb
    .from('inquilinos').select('id,dni,nombres,apellidos').limit(5000);
  if (e2) throw new Error(`inquilinos: ${e2.message}`);

  console.log('  → Cargando puestos...');
  const { data: puestos, error: e3 } = await sb
    .from('puestos').select('id,codigo_puesto').limit(5000);
  if (e3) throw new Error(`puestos: ${e3.message}`);

  console.log('  → Cargando historial_titularidad (vigente)...');
  const { data: titulares, error: e4 } = await sb
    .from('historial_titularidad')
    .select('id,puesto_id,socio_id,fecha_fin')
    .is('fecha_fin', null)
    .limit(5000);
  if (e4) throw new Error(`historial_titularidad: ${e4.message}`);

  console.log('  → Cargando historial_arriendos (vigente)...');
  const { data: arriendos, error: e5 } = await sb
    .from('historial_arriendos')
    .select('id,puesto_id,inquilino_id,socio_titular_id,fecha_fin')
    .is('fecha_fin', null)
    .limit(5000);
  if (e5) throw new Error(`historial_arriendos: ${e5.message}`);

  return { socios, inquilinos, puestos, titulares, arriendos };
}

// =============================================================================
// MATCHING
// =============================================================================

/**
 * Busca la mejor coincidencia en bdList para person:
 *   1. DNI exacto (si no es placeholder ni vacío)
 *   2. Similitud de nombre ≥ SIM_THRESHOLD
 * Retorna { bd, method, score } o null.
 */
function findMatch(person, bdList) {
  // 1. Exact DNI
  if (person.dni && !isPlaceholderDni(person.dni)) {
    const byDni = bdList.find(b => normDni(b.dni) === person.dni);
    if (byDni) return { bd: byDni, method: 'dni', score: 1.0 };
  }

  // 2. Name similarity
  const exNorm = person.nombre;
  let bestBd = null, bestScore = 0;
  for (const b of bdList) {
    const bdNorm = normName(b.apellidos || '');
    const s = similarity(exNorm, bdNorm);
    if (s > bestScore) { bestBd = b; bestScore = s; }
  }
  if (bestScore >= SIM_THRESHOLD) {
    return { bd: bestBd, method: 'name', score: bestScore };
  }

  return null;
}

// =============================================================================
// SQL GENERATION HELPERS
// =============================================================================
const L = []; // líneas del SQL
const WARN = []; // advertencias acumuladas

function line(s = '') { L.push(s); }
function sep(title) {
  line('');
  line(`-- ${'─'.repeat(77)}`);
  line(`-- ${title}`);
  line(`-- ${'─'.repeat(77)}`);
}
function warn(msg) { WARN.push(msg); console.warn('  ⚠️ ', msg); }

// =============================================================================
// MAIN
// =============================================================================
async function main() {
  // ─── 1. ENV + Cliente Supabase ────────────────────────────────────────────
  const env = loadEnv();
  if (!env.SUPABASE_URL || !env.SUPABASE_SERVICE_ROLE_KEY) {
    throw new Error(
      'Faltan SUPABASE_URL o SUPABASE_SERVICE_ROLE_KEY en .env\n' +
      'Copia .env.local a .env y completa los valores.'
    );
  }
  const sb = createClient(env.SUPABASE_URL, env.SUPABASE_SERVICE_ROLE_KEY, {
    auth: { persistSession: false },
  });

  // ─── 2. Leer Excel ────────────────────────────────────────────────────────
  console.log('\n📋 Leyendo Excel:', path.basename(EXCEL));
  const wb = XLSX.readFile(EXCEL);

  const exSocios    = parseSocios(wb);
  const exInqs      = parseInquilinos(wb);
  const exDepositos = parseDepositos(wb);

  const exInqsE    = exInqs.filter(i => i.section === 'E' && !i.coop_mark);
  const exInqsCoop = exInqs.filter(i => i.coop_mark);
  const exInqsSP   = exInqs.filter(i => i.section === 'SP');
  const exInqsEP   = exInqs.filter(i => i.section === 'EP');

  console.log(`   Socios:               ${exSocios.length}`);
  console.log(`   Inquilinos -E:        ${exInqsE.length}`);
  console.log(`   Inquilinos COOP:      ${exInqsCoop.length}`);
  console.log(`   Inquilinos -SP:       ${exInqsSP.length}`);
  console.log(`   Inquilinos -EP:       ${exInqsEP.length}`);
  console.log(`   Depósitos (personas): ${exDepositos.length}`);

  // ─── 3. Fetch BD ──────────────────────────────────────────────────────────
  console.log('\n🔌 Conectando a Supabase...');
  const bd = await fetchBD(sb);
  console.log(`   BD Socios:          ${bd.socios.length}`);
  console.log(`   BD Inquilinos:      ${bd.inquilinos.length}`);
  console.log(`   BD Puestos:         ${bd.puestos.length}`);
  console.log(`   BD Titularidades:   ${bd.titulares.length}`);
  console.log(`   BD Arriendos:       ${bd.arriendos.length}`);

  // Map de puestos BD por código
  const bdPuestosByCode = new Map(bd.puestos.map(p => [p.codigo_puesto, p]));

  // ─── 4. Detectar DNIs duplicados en Excel SOCIOS ──────────────────────────
  const dniCount = {};
  exSocios.forEach(s => { dniCount[s.dni] = (dniCount[s.dni] || 0) + 1; });
  const dupDnis = new Set(Object.keys(dniCount).filter(d => dniCount[d] > 1));
  if (dupDnis.size) {
    warn(`DNIs duplicados en hoja SOCIOS (el 2º se marcará con sufijo -DUP): ${[...dupDnis].join(', ')}`);
  }
  const seenDnis = new Set();

  // ─── 5. Match socios ──────────────────────────────────────────────────────
  console.log('\n🔍 Analizando socios...');
  const socioUpdates   = []; // { excelRow, bd, newDni }
  const socioInserts   = []; // excelRow (no match)
  const socsMatchedIds = new Set();

  for (const s of exSocios) {
    let dni = s.dni;
    // Manejar DNIs duplicados en Excel: sufijamos el segundo
    if (dupDnis.has(dni)) {
      if (seenDnis.has(dni)) {
        const newDni = `${dni}-DUP`;
        warn(`DNI duplicado ${dni} (${s.nombre}) → usando ${newDni}`);
        dni = newDni;
      }
      seenDnis.add(s.dni);
    }

    const match = findMatch({ dni, nombre: s.nombre }, bd.socios);
    if (match) {
      if (socsMatchedIds.has(match.bd.id)) {
        warn(`Socio BD id=${match.bd.id} (${match.bd.apellidos}) ya fue emparejado → posible duplicado en Excel para: ${s.nombre}`);
        socioInserts.push({ ...s, dni });
        continue;
      }
      socsMatchedIds.add(match.bd.id);
      socioUpdates.push({ ex: { ...s, dni }, bd: match.bd, method: match.method, score: match.score });
    } else {
      socioInserts.push({ ...s, dni });
    }
  }

  // Socios en BD no presentes en Excel
  const sociosHuerfanos = bd.socios.filter(b => !socsMatchedIds.has(b.id));

  console.log(`   Socios actualizados (match): ${socioUpdates.length}`);
  console.log(`   Socios nuevos (INSERT):      ${socioInserts.length}`);
  console.log(`   Socios en BD sin match Excel: ${sociosHuerfanos.length}`);

  // ─── 6. Match inquilinos ──────────────────────────────────────────────────
  console.log('\n🔍 Analizando inquilinos...');
  const allExInqs     = [...exInqsE, ...exInqsCoop, ...exInqsSP, ...exInqsEP];
  const inqUpdates    = [];
  const inqInserts    = [];
  const inqMatchedIds = new Set();

  for (const inq of allExInqs) {
    const match = findMatch({ dni: inq.dni, nombre: inq.nombre }, bd.inquilinos);
    if (match) {
      if (inqMatchedIds.has(match.bd.id)) {
        warn(`Inquilino BD id=${match.bd.id} ya emparejado → doble match para: ${inq.nombre}`);
        inqInserts.push(inq);
        continue;
      }
      inqMatchedIds.add(match.bd.id);
      inqUpdates.push({ ex: inq, bd: match.bd, method: match.method, score: match.score });
    } else {
      inqInserts.push(inq);
    }
  }

  // ─── 7. Procesar DEPOSITO ─────────────────────────────────────────────────
  console.log('\n🔍 Analizando depósitos...');
  const depIsSOCIO   = []; // renter es un SOCIO → solo crear puesto, TODO arriendo
  const depIsINQ     = []; // renter ya está en inquilinos (match)
  const depNuevos    = []; // renter nuevo → INSERT inquilino, TODO arriendo

  for (const dep of exDepositos) {
    // Buscar en socios primero (por nombre, no hay DNI)
    let bestBd = null, bestScore = 0;
    for (const b of bd.socios) {
      const s = similarity(dep.nombre, normName(b.apellidos || ''));
      if (s > bestScore) { bestBd = b; bestScore = s; }
    }
    if (bestScore >= SIM_THRESHOLD) {
      console.log(`   [DEP] ${dep.puesto}: ${dep.nombre} → SOCIO (${bestBd.apellidos}, score=${bestScore.toFixed(2)})`);
      depIsSOCIO.push({ dep, socio: bestBd, score: bestScore });
      continue;
    }

    // Buscar en inquilinos
    bestBd = null; bestScore = 0;
    for (const b of bd.inquilinos) {
      const s = similarity(dep.nombre, normName(b.apellidos || ''));
      if (s > bestScore) { bestBd = b; bestScore = s; }
    }
    if (bestScore >= SIM_THRESHOLD) {
      console.log(`   [DEP] ${dep.puesto}: ${dep.nombre} → INQ BD (${bestBd.apellidos}, score=${bestScore.toFixed(2)})`);
      depIsINQ.push({ dep, inq: bestBd, score: bestScore });
      continue;
    }

    console.log(`   [DEP] ${dep.puesto}: ${dep.nombre} → NUEVO inquilino`);
    depNuevos.push(dep);
  }

  // ─── 8. Calcular puestos nuevos ───────────────────────────────────────────
  const allExPuestoCodes = new Set([
    ...exInqsE.map(i => i.puesto),
    ...exInqsCoop.map(i => String(i.puesto)),
    ...exInqsSP.map(i => i.puesto),
    ...exInqsEP.map(i => i.puesto),
    ...exDepositos.map(d => d.puesto),
    ...exSocios.map(s => String(s.puesto)),
  ]);
  const puestosNuevos = [...allExPuestoCodes].filter(c => !bdPuestosByCode.has(c)).sort();
  console.log(`\n📦 Puestos nuevos a insertar: ${puestosNuevos.length}`);
  if (puestosNuevos.length) console.log(`   ${puestosNuevos.join(', ')}`);

  // ─── 9. Generar SQL ───────────────────────────────────────────────────────
  console.log('\n📝 Generando SQL...');
  const now = new Date().toISOString().slice(0, 10);

  const totalNuevosSocios   = socioInserts.length;
  const totalNuevosInqs     = inqInserts.length + depNuevos.length;
  const totalNuevosPuestos  = puestosNuevos.length;

  // ── ENCABEZADO ──────────────────────────────────────────────────────────
  line(`-- ${'='.repeat(77)}`);
  line(`-- Migración 00035 — UPSERT Padrón Final (generado ${now})`);
  line(`-- Cooperativa Primero de Mayo · SistemaCooperativa`);
  line(`-- Fuente: migracion_coop/SOCIOS E INQUILINOS TERMINADO.xlsx`);
  line(`-- ${'='.repeat(77)}`);
  line(`-- RESUMEN:`);
  line(`--   Socios Excel:          ${exSocios.length}`);
  line(`--     • Match en BD:       ${socioUpdates.length}  (se actualiza DNI/datos si hay placeholder)`);
  line(`--     • Nuevos (INSERT):   ${totalNuevosSocios}`);
  line(`--     • BD sin match:      ${sociosHuerfanos.length}  (ver PASO 12 — revisar si marcar Inactivo)`);
  line(`--   Inquilinos Excel:      ${allExInqs.length}`);
  line(`--     • -E (pequeños):     ${exInqsE.length}`);
  line(`--     • COOP:              ${exInqsCoop.length}`);
  line(`--     • -SP (2do piso):    ${exInqsSP.length}`);
  line(`--     • -EP (espacios):    ${exInqsEP.length}`);
  line(`--   Depósitos:             ${exDepositos.length}`);
  line(`--     • Renter=Socio:      ${depIsSOCIO.length}  (→ solo puesto, arriendo manual)`);
  line(`--     • Renter=Inq BD:     ${depIsINQ.length}`);
  line(`--     • Renter Nuevo:      ${depNuevos.length}`);
  line(`--   Puestos nuevos:        ${totalNuevosPuestos}`);
  line(`-- ${'='.repeat(77)}`);
  line(`-- ⚠️  REQUIERE REVISIÓN MANUAL:`);
  line(`--   [ ] Socios en BD sin match (PASO 12): decidir si marcar Inactivo`);
  line(`--   [ ] Arriendos -SP y -EP (PASO 10): asignar socio_titular_id manualmente`);
  line(`--   [ ] Arriendos depósitos (PASO 11): asignar socio_titular_id manualmente`);
  if (WARN.length) {
    line(`--   [ ] Advertencias del script:`);
    WARN.forEach(w => line(`--       • ${w}`));
  }
  line(`-- ${'='.repeat(77)}`);
  line('');
  line('BEGIN;');

  // ── PASO 1: Estado inicial ───────────────────────────────────────────────
  sep('PASO 1: Estado inicial (diagnóstico)');
  line(`DO $$ BEGIN`);
  line(`  RAISE NOTICE '=================================================';`);
  line(`  RAISE NOTICE 'Migración 00035 — UPSERT Padrón Final';`);
  line(`  RAISE NOTICE 'Fecha ejecución: %', now();`);
  line(`  RAISE NOTICE 'Socios:              %', (SELECT count(*) FROM public.socios WHERE deleted_at IS NULL);`);
  line(`  RAISE NOTICE 'Inquilinos:          %', (SELECT count(*) FROM public.inquilinos WHERE deleted_at IS NULL);`);
  line(`  RAISE NOTICE 'Puestos:             %', (SELECT count(*) FROM public.puestos WHERE deleted_at IS NULL);`);
  line(`  RAISE NOTICE 'Titularidades vigentes: %', (SELECT count(*) FROM public.historial_titularidad WHERE fecha_fin IS NULL);`);
  line(`  RAISE NOTICE 'Arriendos vigentes:     %', (SELECT count(*) FROM public.historial_arriendos WHERE fecha_fin IS NULL);`);
  line(`END; $$;`);

  // ── PASO 2: Puestos nuevos ───────────────────────────────────────────────
  sep(`PASO 2: Insertar ${totalNuevosPuestos} puestos nuevos (SP, EP, Dx + cualquier faltante)`);
  if (puestosNuevos.length > 0) {
    line(`INSERT INTO public.puestos (codigo_puesto, giro_id, estado, tiene_medidor_luz, tiene_medidor_agua)`);
    line(`VALUES`);
    puestosNuevos.forEach((code, i) => {
      const comma = i < puestosNuevos.length - 1 ? ',' : '';
      let tag = '';
      if (code.includes('-SP')) tag = '-- Segundo Piso';
      else if (code.includes('-EP')) tag = '-- Espacio';
      else if (code.match(/-D\d/)) tag = '-- Depósito';
      else if (code.includes('-E')) tag = '-- Puesto pequeño';
      line(`    (${esc(code)}, ${GIRO_SQL}, 'Activo', false, false)${comma} ${tag}`);
    });
    line(`ON CONFLICT (codigo_puesto) DO NOTHING;`);
  } else {
    line(`-- No hay puestos nuevos que insertar.`);
  }

  // ── PASO 3: UPDATE socios con match (corregir DNI real si hay placeholder) ─
  sep('PASO 3: Actualizar socios existentes (DNI real + normalizar apellidos)');
  if (socioUpdates.length === 0) {
    line('-- Todos los socios ya tienen DNI real o no se encontraron matches.');
  }
  for (const { ex, bd: bdRow, method, score } of socioUpdates) {
    const needsDniUpdate   = bdRow.dni !== ex.dni;
    const needsNameUpdate  = normName(bdRow.apellidos) !== ex.nombre;
    const needsUpdate      = needsDniUpdate || needsNameUpdate;
    const scoreStr         = method === 'name' ? ` (por nombre, score=${score.toFixed(2)})` : '';

    if (method === 'name' && score < 0.90) {
      line(`-- ⚠️  Match por nombre con confianza MEDIA para: ${ex.nombre}`);
      line(`--     BD actual: "${bdRow.apellidos}" (id=${bdRow.id}, DNI=${bdRow.dni})${scoreStr}`);
      line(`--     Verificar antes de aplicar.`);
    }

    if (!needsUpdate) {
      line(`-- OK (sin cambios): ${ex.nombre} [DNI=${ex.dni}]${scoreStr}`);
      continue;
    }

    line(`-- Match${scoreStr}: ${ex.nombre}`);
    line(`UPDATE public.socios SET`);
    const sets = [];
    if (needsDniUpdate)  sets.push(`  dni       = ${esc(ex.dni)}`);
    if (needsNameUpdate) sets.push(`  apellidos = ${esc(ex.nombre)}`);
    sets.push(`  estado    = 'Activo'`);
    line(sets.join(',\n') + '');
    line(`WHERE id = ${bdRow.id}`);
    if (needsDniUpdate) {
      line(`  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != ${esc(ex.dni)});`);
    } else {
      line(';');
    }
    line('');
  }

  // ── PASO 4: INSERT socios nuevos ─────────────────────────────────────────
  sep(`PASO 4: Insertar ${socioInserts.length} socios nuevos`);
  if (socioInserts.length === 0) {
    line('-- No hay socios nuevos.');
  } else {
    line(`INSERT INTO public.socios (dni, nombres, apellidos, estado, habilitado, fecha_ingreso)`);
    line(`VALUES`);
    socioInserts.forEach((s, i) => {
      const comma = i < socioInserts.length - 1 ? ',' : '';
      line(`    (${esc(s.dni)}, '', ${esc(s.nombre)}, 'Activo', true, ${esc(FECHA_INICIO)})${comma}`);
    });
    line(`ON CONFLICT (dni) DO UPDATE SET`);
    line(`  apellidos = EXCLUDED.apellidos,`);
    line(`  estado    = 'Activo'`);
    line(`WHERE public.socios.apellidos LIKE 'SOCIO %' OR public.socios.apellidos = '';`);
  }

  // ── PASO 5: UPDATE inquilinos con match ───────────────────────────────────
  sep('PASO 5: Actualizar inquilinos existentes (DNI real si hay placeholder)');
  if (inqUpdates.length === 0) {
    line('-- Ningún inquilino con datos a actualizar.');
  }
  for (const { ex, bd: bdRow, method, score } of inqUpdates) {
    const needsDniUpdate  = bdRow.dni !== ex.dni;
    const needsNameUpdate = normName(bdRow.apellidos) !== ex.nombre;
    const needsUpdate     = needsDniUpdate || needsNameUpdate;
    const scoreStr        = method === 'name' ? ` (nombre, score=${score.toFixed(2)})` : '';

    if (!needsUpdate) {
      line(`-- OK (sin cambios): ${ex.nombre} [DNI=${ex.dni}]${scoreStr}`);
      continue;
    }
    line(`-- Match${scoreStr}: ${ex.nombre}`);
    line(`UPDATE public.inquilinos SET`);
    const sets = [];
    if (needsDniUpdate)  sets.push(`  dni       = ${esc(ex.dni)}`);
    if (needsNameUpdate) sets.push(`  apellidos = ${esc(ex.nombre)}`);
    line(sets.join(',\n'));
    line(`WHERE id = ${bdRow.id}`);
    if (needsDniUpdate) {
      line(`  AND (dni LIKE 'SOC-%' OR dni LIKE 'INQ-%' OR dni != ${esc(ex.dni)});`);
    } else {
      line(';');
    }
    line('');
  }

  // ── PASO 6: INSERT inquilinos nuevos (E/SP/EP sin match) ──────────────────
  const inqInsertsConDepositos = [
    ...inqInserts,
    ...depNuevos.map(d => ({ ...d, section: d.seccion, coop_mark: false })),
  ];

  sep(`PASO 6: Insertar ${inqInsertsConDepositos.length} inquilinos nuevos`);
  if (inqInsertsConDepositos.length === 0) {
    line('-- No hay inquilinos nuevos.');
  } else {
    line(`INSERT INTO public.inquilinos (dni, nombres, apellidos)`);
    line(`VALUES`);
    inqInsertsConDepositos.forEach((inq, i) => {
      const comma   = i < inqInsertsConDepositos.length - 1 ? ',' : '';
      // Para depósitos sin DNI generamos un placeholder único
      const dniVal  = inq.dni ? esc(inq.dni) : esc(`DEP-${inq.puesto}`);
      const secTag  = inq.section === 'SP' ? '-- 2do Piso'
                    : inq.section === 'EP' ? '-- Espacio'
                    : inq.seccion          ? `-- Depósito ${inq.seccion}`
                    : '';
      line(`    (${dniVal}, '', ${esc(inq.nombre)})${comma} ${secTag}`);
    });
    line(`ON CONFLICT (dni) DO UPDATE SET`);
    line(`  apellidos = EXCLUDED.apellidos`);
    line(`WHERE public.inquilinos.apellidos LIKE 'INQUILINO %' OR public.inquilinos.apellidos = '';`);
  }

  // ── PASO 7: historial_titularidad — socios ↔ puestos ─────────────────────
  sep(`PASO 7: historial_titularidad — ${exSocios.length} socios vinculados a sus puestos`);
  line(`-- Lógica por socio (resuelve ID por DNI en tiempo de ejecución SQL):`);
  line(`--   • Cierra titularidades vigentes equivocadas (diferente socio para el mismo puesto)`);
  line(`--   • Inserta si no existe la combinación socio+puesto vigente`);
  line(`DO $$`);
  line(`DECLARE`);
  line(`  rec record;`);
  line(`  v_s bigint; v_p bigint;`);
  line(`BEGIN`);
  line(`  FOR rec IN (`);
  line(`    SELECT * FROM (VALUES`);

  // Construir la tabla de valores (dni, puesto_code) para todos los socios
  const socioValues = exSocios.map((s, i) => {
    const dni = (() => {
      // Si fue actualizado, usar el nuevo DNI; si era duplicado, usar el sufijado
      const upd = socioUpdates.find(u => u.ex.nombre === s.nombre);
      if (upd) return upd.ex.dni;
      const ins = socioInserts.find(u => u.nombre === s.nombre);
      if (ins) return ins.dni;
      return s.dni; // fallback
    })();
    return `      (${esc(dni)}, ${esc(String(s.puesto))})`;
  });

  socioValues.forEach((v, i) => {
    const comma = i < socioValues.length - 1 ? ',' : '';
    line(`${v}${comma}`);
  });

  line(`    ) t(dni, puesto_code)`);
  line(`  )`);
  line(`  LOOP`);
  line(`    SELECT id INTO v_s FROM public.socios WHERE dni = rec.dni;`);
  line(`    SELECT id INTO v_p FROM public.puestos WHERE codigo_puesto = rec.puesto_code;`);
  line(`    IF v_s IS NULL THEN`);
  line(`      RAISE WARNING 'historial_titularidad: socio no encontrado DNI=%', rec.dni;`);
  line(`      CONTINUE;`);
  line(`    END IF;`);
  line(`    IF v_p IS NULL THEN`);
  line(`      RAISE WARNING 'historial_titularidad: puesto no encontrado código=%', rec.puesto_code;`);
  line(`      CONTINUE;`);
  line(`    END IF;`);
  line(`    -- Cerrar cualquier titularidad vigente en este puesto que sea de otro socio`);
  line(`    UPDATE public.historial_titularidad`);
  line(`      SET fecha_fin = CURRENT_DATE`);
  line(`    WHERE puesto_id = v_p AND fecha_fin IS NULL AND socio_id != v_s;`);
  line(`    -- Insertar sólo si no existe ya la titularidad vigente`);
  line(`    IF NOT EXISTS (`);
  line(`      SELECT 1 FROM public.historial_titularidad`);
  line(`      WHERE puesto_id = v_p AND socio_id = v_s AND fecha_fin IS NULL`);
  line(`    ) THEN`);
  line(`      INSERT INTO public.historial_titularidad (puesto_id, socio_id, fecha_inicio)`);
  line(`      VALUES (v_p, v_s, ${esc(FECHA_INICIO)});`);
  line(`      RAISE NOTICE 'Titularidad creada: DNI=% → puesto=%', rec.dni, rec.puesto_code;`);
  line(`    END IF;`);
  line(`  END LOOP;`);
  line(`END; $$;`);

  // ── PASO 8: historial_arriendos — inquilinos -E + COOP ────────────────────
  const inqConHistorial = [
    ...exInqsE.map(i => ({ ...i, base_puesto: i.puesto.replace(/-E$/i, '').trim() })),
    ...exInqsCoop.map(i => ({ ...i, base_puesto: String(i.puesto) })),
  ];

  sep(`PASO 8: historial_arriendos — ${inqConHistorial.length} inquilinos (-E y COOP)`);
  line(`-- socio_titular_id se resuelve desde historial_titularidad del puesto BASE.`);
  line(`-- Si el base_puesto no tiene titular vigente, se emite RAISE WARNING y se omite.`);
  line(`DO $$`);
  line(`DECLARE`);
  line(`  rec record;`);
  line(`  v_inq bigint; v_pue bigint; v_soc bigint;`);
  line(`BEGIN`);
  line(`  FOR rec IN (`);
  line(`    SELECT * FROM (VALUES`);

  const arrValues = inqConHistorial.map(i => {
    const dniVal    = `${esc(i.dni)}`;
    const pueVal    = `${esc(i.puesto)}`;
    const baseVal   = `${esc(i.base_puesto)}`;
    return `      (${dniVal}, ${pueVal}, ${baseVal})`;
  });
  arrValues.forEach((v, i) => {
    const comma = i < arrValues.length - 1 ? ',' : '';
    line(`${v}${comma}`);
  });

  line(`    ) t(inq_dni, puesto_code, base_puesto)`);
  line(`  )`);
  line(`  LOOP`);
  line(`    SELECT id INTO v_inq FROM public.inquilinos WHERE dni = rec.inq_dni;`);
  line(`    SELECT id INTO v_pue FROM public.puestos WHERE codigo_puesto = rec.puesto_code;`);
  line(`    SELECT ht.socio_id INTO v_soc`);
  line(`      FROM public.historial_titularidad ht`);
  line(`      JOIN public.puestos p ON p.id = ht.puesto_id`);
  line(`      WHERE p.codigo_puesto = rec.base_puesto AND ht.fecha_fin IS NULL`);
  line(`      LIMIT 1;`);
  line(`    IF v_inq IS NULL THEN`);
  line(`      RAISE WARNING 'historial_arriendos: inquilino no encontrado DNI=%', rec.inq_dni;`);
  line(`      CONTINUE;`);
  line(`    END IF;`);
  line(`    IF v_pue IS NULL THEN`);
  line(`      RAISE WARNING 'historial_arriendos: puesto no encontrado código=%', rec.puesto_code;`);
  line(`      CONTINUE;`);
  line(`    END IF;`);
  line(`    IF v_soc IS NULL THEN`);
  line(`      RAISE WARNING 'historial_arriendos: sin titular vigente para puesto base=%; OMITIDO — asignar manualmente.', rec.base_puesto;`);
  line(`      CONTINUE;`);
  line(`    END IF;`);
  line(`    -- Cerrar arriendo vigente para OTRO inquilino en el mismo puesto`);
  line(`    UPDATE public.historial_arriendos`);
  line(`      SET fecha_fin = CURRENT_DATE`);
  line(`    WHERE puesto_id = v_pue AND fecha_fin IS NULL AND inquilino_id != v_inq;`);
  line(`    -- Insertar si no existe`);
  line(`    IF NOT EXISTS (`);
  line(`      SELECT 1 FROM public.historial_arriendos`);
  line(`      WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL`);
  line(`    ) THEN`);
  line(`      INSERT INTO public.historial_arriendos`);
  line(`        (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)`);
  line(`      VALUES (v_pue, v_inq, v_soc, ${esc(FECHA_INICIO)});`);
  line(`      RAISE NOTICE 'Arriendo creado: DNI=% → puesto=%', rec.inq_dni, rec.puesto_code;`);
  line(`    END IF;`);
  line(`  END LOOP;`);
  line(`END; $$;`);

  // ── PASO 9: Depósitos — vincular inquilino a puesto cuando ya existe en BD ─
  sep(`PASO 9: Depósitos — arriendos para renters que ya existen en BD como inquilinos`);
  line(`-- Para estos registros el puesto ya fue insertado en PASO 2.`);
  line(`-- El socio_titular_id NO APLICA (depósito de la Cooperativa) — campo NOT NULL:`);
  line(`-- se usa el primer socio activo como placeholder; CORREGIR MANUALMENTE.`);

  if (depIsINQ.length === 0) {
    line('-- No hay depósitos con renter ya registrado como inquilino en BD.');
  } else {
    for (const { dep, inq } of depIsINQ) {
      line('');
      line(`-- Depósito ${dep.puesto} — renter: ${dep.nombre} (INQ BD id=${inq.id})`);
      line(`DO $$`);
      line(`DECLARE`);
      line(`  v_inq bigint; v_pue bigint; v_soc bigint;`);
      line(`BEGIN`);
      line(`  SELECT id INTO v_inq FROM public.inquilinos WHERE id = ${inq.id};`);
      line(`  SELECT id INTO v_pue FROM public.puestos WHERE codigo_puesto = ${esc(dep.puesto)};`);
      line(`  -- ⚠️  PLACEHOLDER: depósito de la Cooperativa — NO tiene socio titular real.`);
      line(`  -- Reemplazar manualmente la siguiente línea con el socio_id correcto.`);
      line(`  SELECT id INTO v_soc FROM public.socios WHERE deleted_at IS NULL ORDER BY id LIMIT 1;`);
      line(`  IF v_pue IS NULL OR v_inq IS NULL OR v_soc IS NULL THEN`);
      line(`    RAISE WARNING 'Depósito ${dep.puesto}: falta puesto/inquilino/socio';`);
      line(`    RETURN;`);
      line(`  END IF;`);
      line(`  IF NOT EXISTS (`);
      line(`    SELECT 1 FROM public.historial_arriendos`);
      line(`    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL`);
      line(`  ) THEN`);
      line(`    INSERT INTO public.historial_arriendos`);
      line(`      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)`);
      line(`    VALUES (v_pue, v_inq, v_soc, ${esc(FECHA_INICIO)});`);
      line(`  END IF;`);
      line(`END; $$;`);
    }
  }

  // ── PASO 10: -SP y -EP → puestos ya insertados, historial TODO ───────────
  sep('PASO 10 (MANUAL): historial_arriendos para -SP y -EP');
  line(`-- Los puestos -SP (2do Piso) y -EP (Espacios) son propiedad de la Cooperativa.`);
  line(`-- NO tienen socio_titular_id individual → historial_arriendos requiere asignación manual.`);
  line(`-- Los inquilinos ya fueron insertados en PASO 6.`);
  line(`--`);
  line(`-- PARA CADA UNO: descomenta el bloque, reemplaza <SOCIO_ID_COOPERATIVA> con el id`);
  line(`-- del socio que represente a la Cooperativa, y ejecuta.`);
  line('');

  [...exInqsSP, ...exInqsEP].forEach(inq => {
    const tag = inq.section === 'SP' ? '2do Piso' : 'Espacio';
    line(`/*`);
    line(`-- ${tag}: ${inq.nombre} → puesto ${inq.puesto}`);
    line(`DO $$`);
    line(`DECLARE v_inq bigint; v_pue bigint;`);
    line(`BEGIN`);
    line(`  SELECT id INTO v_inq FROM public.inquilinos WHERE dni = ${esc(inq.dni)};`);
    line(`  SELECT id INTO v_pue FROM public.puestos WHERE codigo_puesto = ${esc(inq.puesto)};`);
    line(`  IF v_inq IS NULL OR v_pue IS NULL THEN`);
    line(`    RAISE WARNING '${inq.nombre}: inquilino o puesto no encontrado'; RETURN;`);
    line(`  END IF;`);
    line(`  IF NOT EXISTS (`);
    line(`    SELECT 1 FROM public.historial_arriendos`);
    line(`    WHERE puesto_id = v_pue AND inquilino_id = v_inq AND fecha_fin IS NULL`);
    line(`  ) THEN`);
    line(`    INSERT INTO public.historial_arriendos`);
    line(`      (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)`);
    line(`    VALUES (v_pue, v_inq, <SOCIO_ID_COOPERATIVA>, ${esc(FECHA_INICIO)});`);
    line(`  END IF;`);
    line(`END; $$;`);
    line(`*/`);
    line('');
  });

  // ── PASO 11: Depósitos nuevos → inquilinos ya insertados, historial TODO ──
  sep('PASO 11 (MANUAL): historial_arriendos depósitos nuevos + depósitos de socios');
  line(`-- Los depósitos son propiedad de la Cooperativa: socio_titular_id sin asignar.`);
  line(`-- Inquilinos nuevos ya insertados en PASO 6 con DNI=DEP-<puesto>.`);
  line('');
  line(`-- Depósitos donde el renter ES un SOCIO (no puede ser inquilino_id directamente):`);
  depIsSOCIO.forEach(({ dep, socio }) => {
    line(`-- • ${dep.puesto}: ${dep.nombre} → SOCIO id=${socio.id} (${socio.apellidos})`);
    line(`--   Requiere decisión de modelo: ¿crear duplicado en inquilinos o nueva tabla?`);
  });
  line('');
  line(`-- Depósitos nuevos (insertar arriendo manualmente cuando se decida socio_titular_id):`);
  depNuevos.forEach(dep => {
    line(`-- • ${dep.puesto}: ${dep.nombre} (DNI temporal = 'DEP-${dep.puesto}')`);
  });

  // ── PASO 12: Socios huérfanos (BD sin Excel) ─────────────────────────────
  sep('PASO 12 (MANUAL): Socios en BD no presentes en el Excel definitivo');
  line(`-- Los siguientes ${sociosHuerfanos.length} socios están en BD pero NO aparecen en el padrón Excel.`);
  line(`-- Verificar con el administrador si deben marcarse como Inactivos.`);
  line(`-- Para marcar: descomenta el UPDATE correspondiente.`);
  line('');
  if (sociosHuerfanos.length === 0) {
    line(`-- Ninguno. Todos los socios en BD tienen correspondencia en el Excel.`);
  } else {
    sociosHuerfanos.forEach(s => {
      line(`-- id=${s.id} DNI=${s.dni} → "${s.apellidos}"`);
    });
    line('');
    line(`/*`);
    line(`UPDATE public.socios SET estado = 'Inactivo', habilitado = false`);
    line(`WHERE id IN (`);
    line(`  ${sociosHuerfanos.map(s => s.id).join(', ')}`);
    line(`);`);
    line(`*/`);
  }

  // ── PASO 13: Estado final y verificaciones ────────────────────────────────
  sep('PASO 13: Estado final y verificación');
  line(`DO $$`);
  line(`DECLARE`);
  line(`  v_socios    bigint; v_inqs bigint; v_puestos bigint;`);
  line(`  v_titulares bigint; v_arriendos bigint;`);
  line(`BEGIN`);
  line(`  SELECT count(*) INTO v_socios    FROM public.socios WHERE deleted_at IS NULL;`);
  line(`  SELECT count(*) INTO v_inqs      FROM public.inquilinos WHERE deleted_at IS NULL;`);
  line(`  SELECT count(*) INTO v_puestos   FROM public.puestos WHERE deleted_at IS NULL;`);
  line(`  SELECT count(*) INTO v_titulares FROM public.historial_titularidad WHERE fecha_fin IS NULL;`);
  line(`  SELECT count(*) INTO v_arriendos FROM public.historial_arriendos WHERE fecha_fin IS NULL;`);
  line(`  RAISE NOTICE '=================================================';`);
  line(`  RAISE NOTICE '✓ Migración 00035 completada';`);
  line(`  RAISE NOTICE '  Socios activos:         %', v_socios;`);
  line(`  RAISE NOTICE '  Inquilinos activos:     %', v_inqs;`);
  line(`  RAISE NOTICE '  Puestos activos:        %', v_puestos;`);
  line(`  RAISE NOTICE '  Titularidades vigentes: %', v_titulares;`);
  line(`  RAISE NOTICE '  Arriendos vigentes:     %', v_arriendos;`);
  line(`  -- Verificación: cada socio debe tener como mínimo una titularidad vigente`);
  line(`  IF v_titulares < v_socios THEN`);
  line(`    RAISE WARNING 'Hay % socios sin titularidad vigente — revisar PASO 7', (v_socios - v_titulares);`);
  line(`  END IF;`);
  line(`  RAISE NOTICE '=================================================';`);
  line(`END; $$;`);

  line('');
  line('COMMIT;');

  // ─── 10. Escribir archivo SQL ──────────────────────────────────────────────
  fs.writeFileSync(OUT_SQL, L.join('\n'), 'utf8');
  console.log(`\n✅ SQL generado: ${OUT_SQL}`);
  console.log(`   Líneas:     ${L.length}`);
  console.log(`   Tamaño:     ${(fs.statSync(OUT_SQL).size / 1024).toFixed(1)} KB`);

  // ─── 11. Resumen final en consola ─────────────────────────────────────────
  console.log('\n═══════════════════════════════════════════════════');
  console.log('RESUMEN DE CAMBIOS A APLICAR');
  console.log('═══════════════════════════════════════════════════');
  console.log(`  Puestos nuevos:                 ${totalNuevosPuestos}`);
  console.log(`  Socios actualizados (match BD): ${socioUpdates.length}`);
  console.log(`  Socios nuevos (INSERT):         ${totalNuevosSocios}`);
  console.log(`  Inquilinos actualizados:        ${inqUpdates.length}`);
  console.log(`  Inquilinos nuevos:              ${totalNuevosInqs}`);
  console.log(`  Titularidades a asegurar:       ${exSocios.length}`);
  console.log(`  Arriendos -E/-COOP a asegurar:  ${inqConHistorial.length}`);
  console.log('───────────────────────────────────────────────────');
  console.log('REQUIERE ACCIÓN MANUAL:');
  console.log(`  • Socios en BD sin padrón Excel:  ${sociosHuerfanos.length} (PASO 12)`);
  console.log(`  • Arriendos -SP (2do Piso):        ${exInqsSP.length} (PASO 10)`);
  console.log(`  • Arriendos -EP (Espacios):        ${exInqsEP.length} (PASO 10)`);
  console.log(`  • Arriendos depósitos nuevos:      ${depNuevos.length} (PASO 11)`);
  console.log(`  • Depósitos de socios:             ${depIsSOCIO.length} (PASO 11)`);
  if (WARN.length) {
    console.log('───────────────────────────────────────────────────');
    console.log('ADVERTENCIAS:');
    WARN.forEach(w => console.log(`  ⚠️  ${w}`));
  }
  console.log('═══════════════════════════════════════════════════');
  console.log('\nPROXIMO PASO: revisar el SQL generado y aplicar con:');
  console.log('  supabase db push  (CLI)');
  console.log('  — o pegar en el SQL Editor de Supabase Dashboard\n');
}

main().catch(err => {
  console.error('\n❌ Error fatal:', err.message || err);
  process.exit(1);
});
