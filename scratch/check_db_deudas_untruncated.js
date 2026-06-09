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
  // Use RPC or custom query if possible, or fetch all rows by paginating
  // Since we don't have direct SQL runner tool but we have a DB test script or pg client,
  // let's paginate or fetch count first.
  let allRows = [];
  let page = 0;
  const pageSize = 1000;
  
  while (true) {
    const { data, error } = await supabase
      .from('vw_deuda_filtrada')
      .select('tipo_deudor, saldo')
      .range(page * pageSize, (page + 1) * pageSize - 1);
      
    if (error) {
      console.error(error);
      break;
    }
    if (!data || data.length === 0) break;
    allRows = allRows.concat(data);
    if (data.length < pageSize) break;
    page++;
  }
  
  let totalSocio = 0;
  let totalInquilino = 0;
  let totalOtros = 0;
  
  allRows.forEach(r => {
    const s = parseFloat(r.saldo);
    if (r.tipo_deudor === 'socio') totalSocio += s;
    else if (r.tipo_deudor === 'inquilino') totalInquilino += s;
    else totalOtros += s;
  });
  
  console.log(`Total rows retrieved from vw_deuda_filtrada: ${allRows.length}`);
  console.log(`Actual DB Pending Debts (untruncated):`);
  console.log(`- Socios:     S/ ${totalSocio.toFixed(2)}`);
  console.log(`- Inquilinos: S/ ${totalInquilino.toFixed(2)}`);
  console.log(`- Otros:      S/ ${totalOtros.toFixed(2)}`);
  console.log(`- Total:      S/ ${(totalSocio + totalInquilino + totalOtros).toFixed(2)}`);
}

main().catch(console.error);
