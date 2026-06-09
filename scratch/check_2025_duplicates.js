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
  let allDeudas = [];
  let page = 0;
  const pageSize = 1000;
  
  while (true) {
    const { data, error } = await supabase
      .from('montos_por_cobrar')
      .select('id, puesto_id, socio_id, monto, estado, observacion, periodo_anio, periodo_mes')
      .is('deleted_at', null)
      .eq('estado', 'Pendiente')
      .range(page * pageSize, (page + 1) * pageSize - 1);
      
    if (error) {
      console.error(error);
      break;
    }
    if (!data || data.length === 0) break;
    allDeudas = allDeudas.concat(data);
    if (data.length < pageSize) break;
    page++;
  }

  // Group by puesto_id to see duplicates
  const puestoDeudas = {};
  allDeudas.forEach(d => {
    if (!d.puesto_id) return;
    if (!puestoDeudas[d.puesto_id]) puestoDeudas[d.puesto_id] = [];
    puestoDeudas[d.puesto_id].push(d);
  });

  console.log(`Checking for duplication between consolidated 2025 balances and detailed pre-2026 debts:`);
  let duplicateCount = 0;
  
  Object.entries(puestoDeudas).forEach(([puestoId, list]) => {
    const hasConsolidated = list.some(d => String(d.observacion).includes('Saldo inicial migrado al 31-12-2025'));
    const hasDetailedPre2026 = list.some(d => (d.periodo_anio <= 2025) && (String(d.observacion).includes('Migración') || String(d.observacion).includes('Migracion')));
    
    if (hasConsolidated && hasDetailedPre2026) {
      duplicateCount++;
      console.log(`\n- Puesto ID ${puestoId} has BOTH:`);
      list.filter(d => String(d.observacion).includes('Saldo inicial migrado al 31-12-2025') || d.periodo_anio <= 2025).forEach(d => {
        console.log(`  * ID ${d.id} | Year-Month: ${d.periodo_anio}-${d.periodo_mes} | Amount: S/ ${d.monto} | State: ${d.estado} | Obs: "${d.observacion}"`);
      });
    }
  });
  
  console.log(`\nTotal puestos with potential duplication: ${duplicateCount}`);
}

main().catch(console.error);
