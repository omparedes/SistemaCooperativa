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
      .eq('periodo_anio', 2026)
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
  
  // Load applied payments details to calculate net saldo
  const { data: dbDetails } = await supabase
    .from('detalle_pagos')
    .select('monto_id, monto_aplicado')
    .is('deleted_at', null);
    
  const appliedMap = {};
  dbDetails.forEach(d => {
    appliedMap[d.monto_id] = (appliedMap[d.monto_id] || 0) + parseFloat(d.monto_aplicado);
  });

  let migratedSum = 0;
  let autoSum = 0;
  let migratedCount = 0;
  let autoCount = 0;

  allDeudas.forEach(r => {
    const origMonto = parseFloat(r.monto);
    const applied = appliedMap[r.id] || 0;
    const saldo = origMonto - applied;
    
    if (saldo > 0) {
      const obs = String(r.observacion || '').toLowerCase();
      if (obs.includes('migracion') || obs.includes('migración')) {
        migratedSum += saldo;
        migratedCount++;
      } else {
        autoSum += saldo;
        autoCount++;
      }
    }
  });

  console.log(`2026 Outstanding Debts in DB:`);
  console.log(`- Migrated from Excel: S/ ${migratedSum.toFixed(2)} (${migratedCount} rows)`);
  console.log(`- Auto-generated (ERP): S/ ${autoSum.toFixed(2)} (${autoCount} rows)`);
  console.log(`- Total 2026 Pending:   S/ ${(migratedSum + autoSum).toFixed(2)}`);
}

main().catch(console.error);
