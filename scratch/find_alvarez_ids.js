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

const supabase = createClient(envVars.SUPABASE_URL, envVars.SUPABASE_SERVICE_ROLE_KEY);

async function main() {
  // 1. Find the partner "ALVAREZ MARIN MARIANELA"
  const { data: dbSocios } = await supabase
    .from('socios')
    .select('id, nombres, apellidos, dni')
    .ilike('apellidos', '%ALVAREZ%');
    
  console.log('--- SOCIO SEARCH ---');
  dbSocios.forEach(s => console.log(`Socio ID ${s.id}: "${s.apellidos} ${s.nombres}" (DNI: ${s.dni})`));

  // 2. Find the puesto with code '80'
  const { data: dbPuestos } = await supabase
    .from('puestos')
    .select('id, codigo_puesto');
    
  const p80 = dbPuestos.find(p => p.codigo_puesto === '80');
  console.log(`\n--- PUESTO 80 ---`);
  console.log(p80);

  // 3. Find active titularity for Puesto 80
  if (p80) {
    const { data: dbTit } = await supabase
      .from('historial_titularidad')
      .select('id, socio_id, puesto_id, fecha_inicio, fecha_fin')
      .eq('puesto_id', p80.id)
      .is('fecha_fin', null);
    console.log(`\n--- ACTIVE TITULARITY FOR PUESTO 80 ---`);
    dbTit.forEach(t => console.log(`Titularidad ID ${t.id} | Socio ID ${t.socio_id} | Puesto ID ${t.puesto_id}`));
  }
}

main().catch(console.error);
