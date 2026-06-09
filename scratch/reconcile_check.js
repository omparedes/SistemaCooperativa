// Script de análisis (SOLO LECTURA) — verifica las afirmaciones de la
// reconciliación de deudas pendientes (socios + inquilinos) sin modificar nada.
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

function normalizar(texto) {
  if (!texto) return '';
  return texto.toString()
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .toUpperCase()
    .trim()
    .replace(/\s+/g, ' ');
}

async function main() {
  // 1. Total de deuda pendiente actual
  const { data: deudas, error: errD } = await supabase
    .from('montos_por_cobrar')
    .select('id, puesto_id, monto, estado, periodo_anio, periodo_mes, observacion, concepto_id, deleted_at')
    .eq('estado', 'Pendiente')
    .is('deleted_at', null);
  if (errD) throw errD;

  const totalPendiente = deudas.reduce((s, d) => s + Number(d.monto), 0);
  console.log(`\n=== TOTAL DEUDA PENDIENTE ACTUAL ===`);
  console.log(`Registros: ${deudas.length}  ·  Suma: S/ ${totalPendiente.toFixed(2)}`);

  // 2. Desglose por tipo de entidad (socio vs inquilino) vía puestos -> historial_titularidad / ocupaciones
  const { data: puestos, error: errP } = await supabase
    .from('puestos')
    .select('id, codigo_puesto');
  if (errP) throw errP;
  const puestoMap = {};
  puestos.forEach(p => { puestoMap[p.id] = p.codigo_puesto; });

  // 3. Buscar específicamente los nombres "OSCAR MARTIN" / "OSCAR ALFREDO" en socios
  const { data: socios, error: errS } = await supabase
    .from('socios')
    .select('id, nombres, apellidos, dni')
    .or('nombres.ilike.%OSCAR%,apellidos.ilike.%PAREDES%');
  if (errS) throw errS;
  console.log(`\n=== SOCIOS CANDIDATOS (PAREDES / OSCAR) ===`);
  socios.forEach(s => console.log(`  ID ${s.id}: ${s.apellidos} ${s.nombres} (DNI ${s.dni})`));

  // 4. Replicar el matching viejo (primer match >=2 palabras) vs nuevo (mejor score)
  const sheetName = 'PAREDES OSCAR MARTIN';
  const normSheet = normalizar(sheetName);
  const partsSheet = normSheet.split(' ').filter(w => w.length > 2);

  let oldMatch = null;
  let bestScore = 0, newMatch = null;
  const allDb = await supabase.from('socios').select('id, nombres, apellidos, dni');
  for (const s of allDb.data) {
    const dbNorm = normalizar(`${s.apellidos} ${s.nombres}`);
    let coincs = 0;
    for (const p of partsSheet) if (dbNorm.includes(p)) coincs++;
    if (!oldMatch && coincs >= 2) oldMatch = s;
    if (coincs > bestScore) { bestScore = coincs; newMatch = s; }
  }
  console.log(`\n=== SIMULACIÓN MATCHING para hoja "${sheetName}" ===`);
  console.log(`  Algoritmo ANTERIOR (primer match >=2 palabras): ${oldMatch ? `ID ${oldMatch.id} - ${oldMatch.apellidos} ${oldMatch.nombres}` : 'sin match'}`);
  console.log(`  Algoritmo NUEVO (mejor score=${bestScore}):           ${newMatch ? `ID ${newMatch.id} - ${newMatch.apellidos} ${newMatch.nombres}` : 'sin match'}`);

  // 5. Buscar puestos con deudas duplicadas: observación de saldo inicial 2025 + deudas detalladas pre-2026
  const { data: deudasAll, error: errDA } = await supabase
    .from('montos_por_cobrar')
    .select('puesto_id, periodo_anio, monto, observacion, estado, deleted_at')
    .is('deleted_at', null);
  if (errDA) throw errDA;

  const porPuesto = {};
  deudasAll.forEach(d => {
    if (!porPuesto[d.puesto_id]) porPuesto[d.puesto_id] = { saldoInicial: [], detallePre2026: [] };
    const obs = (d.observacion || '');
    if (obs.includes('Saldo inicial migrado al 31-12-2025')) porPuesto[d.puesto_id].saldoInicial.push(d);
    else if (d.periodo_anio < 2026) porPuesto[d.puesto_id].detallePre2026.push(d);
  });

  const duplicados = Object.entries(porPuesto).filter(([_, v]) => v.saldoInicial.length > 0 && v.detallePre2026.length > 0);
  console.log(`\n=== PUESTOS CON POSIBLE DUPLICACIÓN (saldo inicial 2025 + detalle pre-2026) ===`);
  console.log(`  Total puestos afectados: ${duplicados.length}`);
  duplicados.forEach(([puestoId, v]) => {
    const sumIni = v.saldoInicial.reduce((s, d) => s + Number(d.monto), 0);
    const sumDet = v.detallePre2026.reduce((s, d) => s + Number(d.monto), 0);
    console.log(`  Puesto ${puestoId} (${puestoMap[puestoId] || '?'}): saldo_inicial=${v.saldoInicial.length} regs / S/ ${sumIni.toFixed(2)}   detalle_pre2026=${v.detallePre2026.length} regs / S/ ${sumDet.toFixed(2)}`);
  });

  // 6. Cargos ERP automáticos (marzo/abril/mayo 2026) que coexistan con cargos migrados del Excel para el mismo puesto/periodo/concepto
  const { data: deudas2026, error: errD26 } = await supabase
    .from('montos_por_cobrar')
    .select('id, puesto_id, periodo_anio, periodo_mes, concepto_id, monto, observacion, metodo_calculo, estado, deleted_at')
    .in('periodo_anio', [2026])
    .in('periodo_mes', [3, 4, 5])
    .is('deleted_at', null);
  if (errD26) throw errD26;

  const porClave = {};
  deudas2026.forEach(d => {
    const key = `${d.puesto_id}_${d.periodo_anio}_${d.periodo_mes}_${d.concepto_id}`;
    if (!porClave[key]) porClave[key] = [];
    porClave[key].push(d);
  });
  const colisiones = Object.entries(porClave).filter(([_, list]) => list.length > 1);
  console.log(`\n=== POSIBLES COLISIONES (mismo puesto/periodo/concepto, Mar-May 2026) ===`);
  console.log(`  Total claves con >1 registro: ${colisiones.length}`);
  colisiones.slice(0, 30).forEach(([key, list]) => {
    console.log(`  ${key}:`);
    list.forEach(d => console.log(`     id=${d.id} monto=${d.monto} metodo=${d.metodo_calculo} estado=${d.estado} obs="${(d.observacion || '').slice(0, 70)}"`));
  });

  // 7. Doble espacio "POR  COBRAR" — no se puede inspeccionar BD (es del Excel), se reporta para revisión manual del script de inquilinos.
  console.log(`\n=== NOTA ===`);
  console.log(`El typo "POR  COBRAR" (doble espacio) solo puede verificarse leyendo los Excel de inquilinos.`);
  console.log(`Revisar manualmente con script dedicado si se confirma su existencia.`);
}

main().catch(e => { console.error(e); process.exit(1); });
