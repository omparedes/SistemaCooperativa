const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const XLSX = require('xlsx');

const envFile = fs.readFileSync('.env', 'utf8');
const envVars = {};
envFile.split('\n').forEach(line => {
  const match = line.match(/^\s*([^#=\s]+)\s*=\s*(.*)\s*$/);
  if (match) {
    let val = match[2].trim();
    if (val.startsWith('"') && val.endsWith('"')) val = val.slice(1, -1);
    if (val.startsWith("'") && val.endsWith("'")) val = val.slice(1, -1);
    envVars[match[1]] = val;
  }
});

const supabaseUrl = envVars.SUPABASE_URL;
const supabaseKey = envVars.SUPABASE_SERVICE_ROLE_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

const MESES = {
  'ENERO': 1, 'ENE': 1,
  'FEBRERO': 2, 'FEB': 2,
  'MARZO': 3, 'MAR': 3,
  'ABRIL': 4, 'ABR': 4,
  'MAYO': 5, 'MAY': 5,
  'JUNIO': 6, 'JUN': 6,
  'JULIO': 7, 'JUL': 7,
  'AGOSTO': 8, 'AGO': 8,
  'SEPTIEMBRE': 9, 'SETIEMBRE': 9, 'SET': 9, 'SEP': 9,
  'OCTUBRE': 10, 'OCT': 10,
  'NOVIEMBRE': 11, 'NOV': 11,
  'DICIEMBRE': 12, 'DIC': 12
};

const sociosFiles = [
  'migracion_coop/2026/1.DETALLE SOCIO A-C NV 4-11-2025 - DEUDAS PENDIENTES.xlsx',
  'migracion_coop/2026/2.DETALLE SOCIO C-Q NV 4-11-2025 - DEUDAS PENDIENTES.xlsx',
  'migracion_coop/2026/3.DETALLE SOCIO M-R 3 -9-2025 - DEUDAS PENDIENTES.xlsx',
  'migracion_coop/2026/4.DETALLE SOCIO M-Z NV 4-11-2025 - DEUDAS PENDIENTES.xlsx'
];

function normalizar(texto) {
  if (!texto) return '';
  return texto.toString()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toUpperCase()
    .trim()
    .replace(/\s+/g, ' ');
}

function findSocio(sheetName, databaseSocios) {
  const normSheet = normalizar(sheetName);
  if (!normSheet || normSheet === 'RESUMEN' || normSheet === 'PLANTILLA') return null;

  // 1. Exact or containment
  let match = databaseSocios.find(s => {
    const dbNorm = normalizar(`${s.apellidos} ${s.nombres}`);
    const dbNormRev = normalizar(`${s.nombres} ${s.apellidos}`);
    return dbNorm === normSheet || dbNormRev === normSheet || dbNorm.includes(normSheet) || dbNormRev.includes(normSheet) || normSheet.includes(dbNorm);
  });

  // 2. Word overlapping
  if (!match) {
    const partsSheet = normSheet.split(' ').filter(w => w.length > 2);
    match = databaseSocios.find(s => {
      const dbNorm = normalizar(`${s.apellidos} ${s.nombres}`);
      let coincs = 0;
      for (const p of partsSheet) {
        if (dbNorm.includes(p)) coincs++;
      }
      return coincs >= 2;
    });
  }

  return match;
}

async function main() {
  const { data: dbSocios } = await supabase
    .from('socios')
    .select('id, nombres, apellidos, dni');
  
  const { data: dbTitularidades } = await supabase
    .from('historial_titularidad')
    .select('socio_id, puesto_id')
    .is('fecha_fin', null);

  const socioPuestoMap = {};
  dbTitularidades.forEach(t => {
    socioPuestoMap[t.socio_id] = t.puesto_id;
  });

  console.log(`Loaded ${dbSocios.length} database partners and ${dbTitularidades.length} active titularities.`);

  let totalExcelPending = 0;
  let totalMappedPending = 0;
  let totalSkippedPending = 0;
  let totalOmittedPending = 0; // mapped but no puesto
  
  const skippedSheets = [];
  const omittedSheets = [];
  const mappedSummary = {}; // socioId -> sum

  sociosFiles.forEach(file => {
    const wb = XLSX.readFile(file);
    wb.SheetNames.forEach(sheet => {
      if (sheet === 'RESUMEN' || sheet === 'PLANTILLA') return;
      
      const ws = wb.Sheets[sheet];
      const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
      let sheetSum = 0;
      rows.forEach(r => {
        if (r.length < 5) return;
        const tipo = String(r[1] || '').trim().toUpperCase();
        const monto = parseFloat(r[4]);
        if (tipo === 'POR COBRAR' && !isNaN(monto)) {
          sheetSum += monto;
        }
      });
      
      totalExcelPending += sheetSum;
      
      const socio = findSocio(sheet, dbSocios);
      if (!socio) {
        totalSkippedPending += sheetSum;
        skippedSheets.push({ file: file.split('/').pop(), sheet, amount: sheetSum });
      } else {
        const puestoId = socioPuestoMap[socio.id];
        if (!puestoId) {
          totalOmittedPending += sheetSum;
          omittedSheets.push({ file: file.split('/').pop(), sheet, partner: `${socio.apellidos} ${socio.nombres}`, amount: sheetSum });
        } else {
          totalMappedPending += sheetSum;
          mappedSummary[socio.id] = (mappedSummary[socio.id] || 0) + sheetSum;
        }
      }
    });
  });

  console.log(`\n=== SOCIOS MAPPING COVERAGE REPORT ===`);
  console.log(`Total outstanding debt in Excel files:  S/ ${totalExcelPending.toFixed(2)}`);
  console.log(`Total mapped & linked to a puesto:       S/ ${totalMappedPending.toFixed(2)}`);
  console.log(`Total mapped but omitted (no puesto):    S/ ${totalOmittedPending.toFixed(2)}`);
  console.log(`Total skipped (no matching partner):     S/ ${totalSkippedPending.toFixed(2)}`);
  
  console.log(`\n=== SKIPPED SHEETS (No matching partner in DB) ===`);
  skippedSheets.forEach(s => console.log(`- File: ${s.file} | Sheet: "${s.sheet}" | Amount: S/ ${s.amount.toFixed(2)}`));

  console.log(`\n=== OMITTED SHEETS (Matching partner has no active puesto in DB) ===`);
  omittedSheets.forEach(o => console.log(`- File: ${o.file} | Sheet: "${o.sheet}" | Partner: "${o.partner}" | Amount: S/ ${o.amount.toFixed(2)}`));
}

main().catch(console.error);
