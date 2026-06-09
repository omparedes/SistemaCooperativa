const fs = require('fs');
const path = require('path');
const { createClient } = require('@supabase/supabase-js');

// Parser manual de .env
const envFile = fs.readFileSync(path.join(__dirname, '../.env'), 'utf8');
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

async function checkDnis() {
  const sqlFile = fs.readFileSync(path.join(__dirname, '../supabase/migrations/00055_b_migracion_pagos_inquilinos_N_Z_2026.sql'), 'utf8');
  
  // Encontrar todas las ocurrencias de DNI = '...'
  const matches = sqlFile.match(/DNI = '[^']+'/g) || [];
  const dnis = [...new Set(matches.map(m => m.match(/'([^']+)'/)[1]))];
  
  console.log(`Encontrados ${dnis.length} DNIs únicos en 00055_b`);
  
  const { data: dbInqs, error } = await supabase
    .from('inquilinos')
    .select('id, dni, nombres, apellidos')
    .is('deleted_at', null);
    
  if (error) {
    console.error('Error fetching inquilinos:', error);
    return;
  }
  
  const dbDnis = new Set(dbInqs.map(i => i.dni));
  
  console.log('\n=== DNIs no encontrados en la DB ===');
  let faltantes = 0;
  for (const dni of dnis) {
    if (!dbDnis.has(dni)) {
      console.log(` - DNI Faltante: "${dni}"`);
      faltantes++;
    }
  }
  
  if (faltantes === 0) {
    console.log('Todos los DNIs están presentes en la DB!');
  } else {
    console.log(`Total faltantes: ${faltantes}`);
  }
}

checkDnis().catch(console.error);
