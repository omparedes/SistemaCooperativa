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

const supabase = createClient(envVars.SUPABASE_URL, envVars.SUPABASE_SERVICE_ROLE_KEY);

const BLOCKS = [
  {
    name: 'A-C',
    solo2026: 'migracion_coop/2026/1.DETALLE SOCIO A-C NV 4-11-2025 - SOLO 2026.xlsx',
    deudas: 'migracion_coop/2026/1.DETALLE SOCIO A-C NV 4-11-2025 - DEUDAS PENDIENTES.xlsx'
  }
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

  let match = databaseSocios.find(s => {
    const dbNorm = normalizar(`${s.apellidos} ${s.nombres}`);
    const dbNormRev = normalizar(`${s.nombres} ${s.apellidos}`);
    return dbNorm === normSheet || dbNormRev === normSheet || dbNorm.includes(normSheet) || dbNormRev.includes(normSheet) || normSheet.includes(dbNorm);
  });

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
    
  const targetId = 80; // Alvarez Marin Marianela
  const targetSocio = dbSocios.find(s => s.id === targetId);
  console.log('Target Socio:', targetSocio);

  BLOCKS.forEach(block => {
    const wbSolo = XLSX.readFile(block.solo2026);
    const wbDeudas = XLSX.readFile(block.deudas);
    
    console.log(`\n=== MATCHING SHEETS FOR ID 80 IN BLOCK ${block.name} ===`);
    
    wbSolo.SheetNames.forEach(sheet => {
      const socio = findSocio(sheet, dbSocios);
      if (socio && socio.id === targetId) {
        console.log(`  SOLO 2026: "${sheet}" matched`);
      }
    });
    
    wbDeudas.SheetNames.forEach(sheet => {
      const socio = findSocio(sheet, dbSocios);
      if (socio && socio.id === targetId) {
        console.log(`  DEUDAS PENDIENTES: "${sheet}" matched`);
      }
    });
  });
}

main().catch(console.error);
