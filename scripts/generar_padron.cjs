/**
 * generar_padron.cjs
 * Lee migracion_coop/listapersonascoop.xlsx y genera
 * supabase/migrations/00028_recrear_padron_real.sql
 *
 * Columnas del Excel (Hoja1):
 *   A: APELLIDO Y NOMBRE  |  B: TIPO (SOCIO/INQUILINO)  |  C: PUESTO
 */
'use strict';
const XLSX = require('xlsx');
const fs   = require('fs');
const path = require('path');

// ─────────────────────────────────────────────────────────────────────────────
// 1. LEER EXCEL
// ─────────────────────────────────────────────────────────────────────────────
const wb   = XLSX.readFile('migracion_coop/listapersonascoop.xlsx', { raw: false });
const ws   = wb.Sheets['Hoja1'];
const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });

const ALL = rows.slice(1)
  .map((r, i) => ({
    rowNum:  i + 2,
    nombre:  limpiarNombre(String(r[0] ?? '').trim()),
    tipo:    String(r[1] ?? '').trim().toUpperCase(),
    puesto:  String(r[2] ?? '').trim(),
  }))
  .filter(r => r.nombre && r.tipo);

const SOCIOS    = ALL.filter(r => r.tipo === 'SOCIO');
const INQUILINOS = ALL.filter(r => r.tipo === 'INQUILINO');

// ─────────────────────────────────────────────────────────────────────────────
// 2. PUESTOS ÚNICOS
// ─────────────────────────────────────────────────────────────────────────────
// Primero los socios (numéricos), luego los inquilinos (alfa)
const puestosNumericos = unique(SOCIOS.map(s => s.puesto))
  .sort((a, b) => Number(a) - Number(b));
const puestosAlfa = unique(
  INQUILINOS.map(i => i.puesto).filter(p => !puestosNumericos.includes(p))
).sort();

const PUESTOS = [...puestosNumericos, ...puestosAlfa];

// Map puesto-code → 1-based insertion ID
const pId = {};
PUESTOS.forEach((p, i) => { pId[p] = i + 1; });

// Map nombre_limpio → socio insertion ID (para resolver socio_titular_id)
const socioIdxByPuesto = {};
SOCIOS.forEach((s, i) => { socioIdxByPuesto[s.puesto] = i + 1; });

// Detección de puestos compartidos (inquilinos)
const inqByPuesto = {};
INQUILINOS.forEach(inq => {
  if (!inqByPuesto[inq.puesto]) inqByPuesto[inq.puesto] = [];
  inqByPuesto[inq.puesto].push(inq);
});
const compartidos = new Set(
  Object.entries(inqByPuesto)
    .filter(([, v]) => v.length > 1)
    .map(([k]) => k)
);

// ─────────────────────────────────────────────────────────────────────────────
// 3. RESOLUCIÓN DE socio_titular_id para cada inquilino
//    Regla: strip "-E" o "E" del código del puesto del inquilino,
//    buscar el socio con ese puesto numérico base.
// ─────────────────────────────────────────────────────────────────────────────
function resolverTitular(puestoInq) {
  const base = puestoInq.replace(/-E$/i, '').replace(/E$/i, '').trim();
  return socioIdxByPuesto[base] || null;
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. GENERAR SQL
// ─────────────────────────────────────────────────────────────────────────────
const L = []; // líneas del SQL
const GIRO = "(SELECT id FROM public.giros WHERE deleted_at IS NULL ORDER BY id LIMIT 1)";
const FECHA = "'2020-01-01'";

const now = new Date().toISOString().slice(0, 10);

L.push(`-- ${'='.repeat(77)}`);
L.push(`-- Migración 00028 — Padrón Real (generado automáticamente ${now})`);
L.push(`-- Fuente: migracion_coop/listapersonascoop.xlsx`);
L.push(`-- Socios: ${SOCIOS.length} | Inquilinos: ${INQUILINOS.length} | Puestos únicos: ${PUESTOS.length}`);
L.push(`-- Puestos compartidos (arriendos no insertados, asignar por UI): ${[...compartidos].join(', ')}`);
L.push(`-- ${'='.repeat(77)}`);
L.push('');
L.push('BEGIN;');
L.push('');

// ── TRUNCATE ──────────────────────────────────────────────────────────────────
L.push('-- PASO 1: Wipe completo del padrón anterior');
L.push('TRUNCATE TABLE');
L.push('    public.socios,');
L.push('    public.inquilinos,');
L.push('    public.puestos,');
L.push('    public.historial_titularidad,');
L.push('    public.historial_arriendos');
L.push('RESTART IDENTITY CASCADE;');
L.push('');

// ── PUESTOS ───────────────────────────────────────────────────────────────────
L.push(`-- PASO 2: ${PUESTOS.length} puestos únicos (${puestosNumericos.length} numéricos + ${puestosAlfa.length} alfa)`);
L.push('INSERT INTO public.puestos (codigo_puesto, giro_id, estado, tiene_medidor_luz, tiene_medidor_agua)');
L.push('VALUES');
PUESTOS.forEach((p, i) => {
  const comma = i < PUESTOS.length - 1 ? ',' : ';';
  L.push(`    (${esc(p)}, ${GIRO}, 'Activo', false, false)${comma}`);
});
L.push('');

// ── SOCIOS ────────────────────────────────────────────────────────────────────
L.push(`-- PASO 3: ${SOCIOS.length} socios`);
L.push('INSERT INTO public.socios (dni, nombres, apellidos, estado, habilitado, fecha_ingreso)');
L.push('VALUES');
SOCIOS.forEach((s, i) => {
  const comma = i < SOCIOS.length - 1 ? ',' : ';';
  const dni = `SOC-${pad(i + 1, 3)}`;
  L.push(`    (${esc(dni)}, '', ${esc(s.nombre)}, 'Activo', true, '2020-01-01')${comma}`);
});
L.push('');

// ── HISTORIAL_TITULARIDAD ─────────────────────────────────────────────────────
L.push(`-- PASO 4: ${SOCIOS.length} titularidades`);
L.push('INSERT INTO public.historial_titularidad (puesto_id, socio_id, fecha_inicio)');
L.push('VALUES');
SOCIOS.forEach((s, i) => {
  const comma = i < SOCIOS.length - 1 ? ',' : ';';
  const pid = pId[s.puesto];
  const sid = i + 1;
  L.push(`    (${pid}, ${sid}, ${FECHA})${comma}  -- ${s.nombre} → puesto "${s.puesto}"`);
});
L.push('');

// ── INQUILINOS ────────────────────────────────────────────────────────────────
L.push(`-- PASO 5: ${INQUILINOS.length} inquilinos`);
L.push('INSERT INTO public.inquilinos (dni, nombres, apellidos)');
L.push('VALUES');
INQUILINOS.forEach((inq, i) => {
  const comma = i < INQUILINOS.length - 1 ? ',' : ';';
  const dni = `INQ-${pad(i + 1, 3)}`;
  L.push(`    (${esc(dni)}, '', ${esc(inq.nombre)})${comma}`);
});
L.push('');

// ── HISTORIAL_ARRIENDOS ───────────────────────────────────────────────────────
const arriendosOK   = [];
const arriendosSkip = [];

INQUILINOS.forEach((inq, i) => {
  const pid       = pId[inq.puesto];
  const iid       = i + 1;
  const titularId = resolverTitular(inq.puesto);
  const esComp    = compartidos.has(inq.puesto);

  if (!pid || !titularId || esComp) {
    arriendosSkip.push({ inq, iid, pid, titularId, esComp });
  } else {
    arriendosOK.push({ inq, iid, pid, titularId });
  }
});

L.push(`-- PASO 6: ${arriendosOK.length} arriendos automáticos`);
if (arriendosSkip.length > 0) {
  L.push(`-- Omitidos: ${arriendosSkip.length} (sin titular identificable o puesto compartido)`);
  L.push('--   Asignar desde UI → Inquilinos → Asignar puesto');
  arriendosSkip.forEach(({ inq, iid }) => {
    const razon = compartidos.has(inq.puesto) ? 'puesto compartido' : 'sin socio titular';
    L.push(`--   INQ-${pad(iid, 3)} "${inq.nombre}" → puesto "${inq.puesto}" (${razon})`);
  });
}

if (arriendosOK.length > 0) {
  L.push('INSERT INTO public.historial_arriendos (puesto_id, inquilino_id, socio_titular_id, fecha_inicio)');
  L.push('VALUES');
  arriendosOK.forEach(({ inq, iid, pid, titularId }, i) => {
    const comma = i < arriendosOK.length - 1 ? ',' : ';';
    L.push(`    (${pid}, ${iid}, ${titularId}, ${FECHA})${comma}  -- ${inq.nombre} → puesto "${inq.puesto}"`);
  });
}
L.push('');

// ── VERIFICACIÓN ──────────────────────────────────────────────────────────────
L.push(`-- PASO 7: Verificación`);
L.push(`DO $$`);
L.push(`BEGIN`);
L.push(`    ASSERT (SELECT count(*) FROM public.socios)                = ${SOCIOS.length},    'ERROR: socios';`);
L.push(`    ASSERT (SELECT count(*) FROM public.inquilinos)            = ${INQUILINOS.length}, 'ERROR: inquilinos';`);
L.push(`    ASSERT (SELECT count(*) FROM public.puestos)               = ${PUESTOS.length},    'ERROR: puestos';`);
L.push(`    ASSERT (SELECT count(*) FROM public.historial_titularidad WHERE fecha_fin IS NULL) = ${SOCIOS.length}, 'ERROR: titularidades';`);
L.push(`    ASSERT (SELECT count(*) FROM public.historial_arriendos WHERE fecha_fin IS NULL)   = ${arriendosOK.length}, 'ERROR: arriendos';`);
L.push(`    RAISE NOTICE '✓ Padrón real aplicado exitosamente.';`);
L.push(`    RAISE NOTICE '  Socios:      ${SOCIOS.length}';`);
L.push(`    RAISE NOTICE '  Inquilinos:  ${INQUILINOS.length} (${arriendosOK.length} con puesto asignado, ${arriendosSkip.length} pendientes de UI)';`);
L.push(`    RAISE NOTICE '  Puestos:     ${PUESTOS.length}';`);
L.push(`END;`);
L.push(`$$;`);
L.push('');
L.push('COMMIT;');

// ─────────────────────────────────────────────────────────────────────────────
// 5. GUARDAR SQL
// ─────────────────────────────────────────────────────────────────────────────
const outPath = 'supabase/migrations/00028_recrear_padron_real.sql';
fs.writeFileSync(outPath, L.join('\n'), 'utf8');

console.log(`✓ Generado: ${outPath}`);
console.log(`  Socios: ${SOCIOS.length}`);
console.log(`  Inquilinos: ${INQUILINOS.length}`);
console.log(`  Puestos únicos: ${PUESTOS.length}`);
console.log(`  Titularidades: ${SOCIOS.length}`);
console.log(`  Arriendos automáticos: ${arriendosOK.length}`);
console.log(`  Arriendos omitidos (asignar por UI): ${arriendosSkip.length}`);
if (arriendosSkip.length > 0) {
  arriendosSkip.forEach(({ inq, iid }) => {
    const razon = compartidos.has(inq.puesto) ? 'compartido' : 'sin titular';
    console.log(`    INQ-${pad(iid, 3)}: "${inq.nombre}" puesto="${inq.puesto}" (${razon})`);
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// HELPERS
// ─────────────────────────────────────────────────────────────────────────────
function esc(s) {
  return "'" + String(s).replace(/'/g, "''") + "'";
}
function pad(n, len) {
  return String(n).padStart(len, '0');
}
function unique(arr) {
  return [...new Set(arr)];
}
function limpiarNombre(s) {
  // Elimina anotaciones finales como CORTADO, FALLECIO, BAJA, INACTIVO
  return s.replace(/\s+(CORTADO|FALLECIO|FALLECIDO|BAJA|INACTIVO|INACTIVE|NULO)$/i, '').trim();
}
