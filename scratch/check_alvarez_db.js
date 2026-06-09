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
  const { data: dbPuestos } = await supabase
    .from('puestos')
    .select('id, codigo_puesto')
    .eq('codigo_puesto', '80');
    
  const puestoId = dbPuestos[0]?.id;
  console.log(`Puesto 80 Database ID: ${puestoId}`);
  
  if (!puestoId) return;

  const { data: deudas } = await supabase
    .from('montos_por_cobrar')
    .select('id, puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, observacion, deleted_at')
    .eq('puesto_id', puestoId)
    .is('deleted_at', null);

  const { data: conceptos } = await supabase.from('conceptos').select('id, nombre');
  const conceptMap = {};
  conceptos.forEach(c => { conceptMap[c.id] = c.nombre; });

  console.log(`\n=== DEUDAS PUESTO 80 (ALVAREZ MARIN MARIANELA) ===`);
  deudas.forEach(d => {
    console.log(`ID: ${d.id} | ${conceptMap[d.concepto_id]} | ${d.periodo_anio}-${d.periodo_mes} | Monto: S/ ${d.monto} | Estado: ${d.estado} | Obs: "${d.observacion}"`);
  });
}

main().catch(console.error);
