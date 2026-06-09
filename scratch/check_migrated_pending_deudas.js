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
  const { data: dbDeudas, error } = await supabase
    .from('montos_por_cobrar')
    .select('id, puesto_id, socio_id, monto, estado, observacion')
    .is('deleted_at', null)
    .eq('estado', 'Pendiente');
    
  if (error) {
    console.error(error);
    return;
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
  
  let totalSocioPuesto = 0;
  let totalSocioDirect = 0;
  let totalInquilinoPuesto = 0;
  
  // We need active arriendos to check if a puesto has a tenant
  const { data: dbArriendos } = await supabase
    .from('historial_arriendos')
    .select('puesto_id')
    .is('fecha_fin', null);
  const activeLeasePuestos = new Set(dbArriendos.map(a => a.puesto_id));

  dbDeudas.forEach(r => {
    const obs = String(r.observacion || '').toLowerCase();
    if (obs.includes('migracion') || obs.includes('migración')) {
      const origMonto = parseFloat(r.monto);
      const applied = appliedMap[r.id] || 0;
      const saldo = origMonto - applied;
      
      if (saldo > 0) {
        if (r.socio_id) {
          totalSocioDirect += saldo;
        } else {
          if (activeLeasePuestos.has(r.puesto_id)) {
            totalInquilinoPuesto += saldo;
          } else {
            totalSocioPuesto += saldo;
          }
        }
      }
    }
  });
  
  console.log(`Migrated Pending Debts (Net Saldo):`);
  console.log(`- Socios (via puesto):    S/ ${totalSocioPuesto.toFixed(2)}`);
  console.log(`- Socios (direct):        S/ ${totalSocioDirect.toFixed(2)}`);
  console.log(`- Inquilinos (via puesto): S/ ${totalInquilinoPuesto.toFixed(2)}`);
  console.log(`- Total:                  S/ ${(totalSocioPuesto + totalSocioDirect + totalInquilinoPuesto).toFixed(2)}`);
}

main().catch(console.error);
