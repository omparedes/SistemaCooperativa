const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');

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

function normalizar(texto) {
  if (!texto) return '';
  return texto.toString()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toUpperCase()
    .trim()
    .replace(/\s+/g, ' ');
}

function findSocioDebug(sheetName, databaseSocios) {
  const normSheet = normalizar(sheetName);
  console.log(`\nDebugging match for sheetName: "${sheetName}" (normalized: "${normSheet}")`);

  // 1. Coincidencia exacta o contención directa
  console.log("Phase 1: Exact or containment check");
  for (const s of databaseSocios) {
    const dbNorm = normalizar(`${s.apellidos} ${s.nombres}`);
    const dbNormRev = normalizar(`${s.nombres} ${s.apellidos}`);
    if (dbNorm === normSheet || dbNormRev === normSheet || dbNorm.includes(normSheet) || dbNormRev.includes(normSheet) || normSheet.includes(dbNorm)) {
      console.log(`-> MATCH FOUND in Phase 1: DB ID ${s.id} ("${s.apellidos} ${s.nombres}")`);
      return s;
    }
  }

  // 2. Coincidencia por partes (al menos 2 palabras significativas)
  console.log("Phase 2: Part-by-part word matching");
  const partsSheet = normSheet.split(' ').filter(w => w.length > 2);
  console.log('Parts of sheet name:', partsSheet);
  
  for (const s of databaseSocios) {
    const dbNorm = normalizar(`${s.apellidos} ${s.nombres}`);
    let coincs = 0;
    const matchedWords = [];
    for (const p of partsSheet) {
      if (dbNorm.includes(p)) {
        coincs++;
        matchedWords.push(p);
      }
    }
    if (coincs >= 2) {
      console.log(`-> MATCH FOUND in Phase 2: DB ID ${s.id} ("${s.apellidos} ${s.nombres}") matches ${coincs} words: ${JSON.stringify(matchedWords)}`);
      return s;
    }
  }

  console.log("No match found.");
  return null;
}

async function main() {
  const { data: dbSocios } = await supabase
    .from('socios')
    .select('id, nombres, apellidos, dni');
  
  // Find candidates with surname PAREDES
  const candidates = dbSocios.filter(s => s.apellidos.includes('PAREDES') || s.nombres.includes('PAREDES'));
  console.log('Socio database candidates containing PAREDES:');
  candidates.forEach(c => console.log(`ID ${c.id}: "${c.apellidos} ${c.nombres}"`));

  findSocioDebug('PAREDES OSCAR MARTIN', dbSocios);
}

main().catch(console.error);
