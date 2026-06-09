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

async function main() {
  const { data, error } = await supabase
    .from('vw_deuda_filtrada')
    .select('tipo_deudor, saldo');
    
  if (error) {
    console.error(error);
    return;
  }
  
  let totalSocio = 0;
  let totalInquilino = 0;
  let totalOtros = 0;
  
  data.forEach(r => {
    const s = parseFloat(r.saldo);
    if (r.tipo_deudor === 'socio') totalSocio += s;
    else if (r.tipo_deudor === 'inquilino') totalInquilino += s;
    else totalOtros += s;
  });
  
  console.log(`Current DB Pending Debts:`);
  console.log(`- Socios:     S/ ${totalSocio.toFixed(2)}`);
  console.log(`- Inquilinos: S/ ${totalInquilino.toFixed(2)}`);
  console.log(`- Otros:      S/ ${totalOtros.toFixed(2)}`);
  console.log(`- Total:      S/ ${(totalSocio + totalInquilino + totalOtros).toFixed(2)}`);
}

main().catch(console.error);
