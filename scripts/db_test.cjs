const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');

// Parser manual de .env
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

if (!supabaseUrl || !supabaseKey) {
  console.error("Faltan credenciales de Supabase en el archivo .env");
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkDb() {
  console.log("Conectando a Supabase...");
  
  // 1. Conceptos
  const { data: conceptos, error: cErr } = await supabase
    .from('conceptos')
    .select('id, nombre, tipo')
    .is('deleted_at', null);
    
  if (cErr) {
    console.error("Error al leer conceptos:", cErr);
  } else {
    console.log(`\n=== CONCEPTOS EN BD (${conceptos.length}) ===`);
    conceptos.forEach(c => console.log(`  ID: ${c.id} | Nombre: "${c.nombre}" | Tipo: ${c.tipo}`));
  }
  
  // 2. Muestra de Socios
  const { data: socios, error: sErr } = await supabase
    .from('socios')
    .select('id, nombres, apellidos')
    .is('deleted_at', null)
    .limit(5);
    
  if (sErr) {
    console.error("Error al leer socios:", sErr);
  } else {
    console.log(`\n=== MUESTRA DE SOCIOS EN BD (${socios.length}) ===`);
    socios.forEach(s => console.log(`  ID: ${s.id} | Nombre: "${s.apellidos}, ${s.nombres}"`));
  }
}

checkDb().catch(console.error);
