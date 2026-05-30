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

async function search() {
  console.log("Buscando en la BD...");
  
  // Buscar ALVAREZ o CAMPOS
  const { data: alvarez, error: aErr } = await supabase
    .from('socios')
    .select('id, nombres, apellidos')
    .or('apellidos.ilike.%alvarez%,apellidos.ilike.%campos%,nombres.ilike.%victor%')
    .is('deleted_at', null);
    
  console.log("\nResultados para ALVAREZ / CAMPOS / VICTOR:");
  if (alvarez) alvarez.forEach(s => console.log(`  ID: ${s.id} | "${s.apellidos}, ${s.nombres}"`));
  
  // Buscar CABERO o MENDOZA o GLORIA
  const { data: cabero, error: cErr } = await supabase
    .from('socios')
    .select('id, nombres, apellidos')
    .or('apellidos.ilike.%cabero%,apellidos.ilike.%mendoza%,nombres.ilike.%gloria%')
    .is('deleted_at', null);
    
  console.log("\nResultados para CABERO / MENDOZA / GLORIA:");
  if (cabero) cabero.forEach(s => console.log(`  ID: ${s.id} | "${s.apellidos}, ${s.nombres}"`));
}

search().catch(console.error);
