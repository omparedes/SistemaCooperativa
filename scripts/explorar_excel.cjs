const XLSX = require('xlsx');

const ruta = 'migracion_coop/listapersonascoop.xlsx';
const wb = XLSX.readFile(ruta, { cellDates: true, raw: false });
const ws = wb.Sheets['Hoja1'];
const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });

// Skip header
const data = rows.slice(1).map((r, i) => ({
  fila: i + 2,
  nombre: String(r[0] ?? '').trim(),
  tipo:   String(r[1] ?? '').trim().toUpperCase(),
  puesto: r[2],
})).filter(r => r.nombre);

// Stats
const tipos = {};
data.forEach(r => { tipos[r.tipo] = (tipos[r.tipo] || 0) + 1; });
console.log('\n=== TIPOS ===', tipos);
console.log('Total filas con nombre:', data.length);

// Puestos únicos
const puestosSet = new Set(data.map(r => r.puesto));
const puestosArr = [...puestosSet].sort((a, b) => {
  const n = (v) => isNaN(Number(v)) ? v : Number(v);
  return n(a) < n(b) ? -1 : 1;
});
console.log(`\n=== PUESTOS ÚNICOS (${puestosArr.length}) ===`);
console.log('Rango numérico:', puestosArr.filter(p => !isNaN(Number(p))).join(', '));

// Puestos con múltiples personas
const puestoPers = {};
data.forEach(r => {
  const k = String(r.puesto);
  if (!puestoPers[k]) puestoPers[k] = [];
  puestoPers[k].push({ tipo: r.tipo, nombre: r.nombre });
});
const compartidos = Object.entries(puestoPers).filter(([, v]) => v.length > 1);
console.log(`\n=== PUESTOS COMPARTIDOS (${compartidos.length}) ===`);
compartidos.forEach(([p, pers]) => {
  console.log(`  Puesto ${p}:`);
  pers.forEach(pe => console.log(`    [${pe.tipo}] ${pe.nombre}`));
});

// Muestra de socios
console.log('\n=== PRIMEROS 5 SOCIOS ===');
data.filter(r => r.tipo === 'SOCIO').slice(0, 5)
    .forEach(r => console.log(`  fila ${r.fila}: puesto="${r.puesto}" nombre="${r.nombre}"`));

// Muestra de inquilinos
console.log('\n=== PRIMEROS 5 INQUILINOS ===');
data.filter(r => r.tipo === 'INQUILINO').slice(0, 5)
    .forEach(r => console.log(`  fila ${r.fila}: puesto="${r.puesto}" nombre="${r.nombre}"`));

// Últimas 5 filas
console.log('\n=== ÚLTIMAS 5 FILAS ===');
data.slice(-5).forEach(r => console.log(`  fila ${r.fila}: tipo="${r.tipo}" puesto="${r.puesto}" nombre="${r.nombre}"`));

// Filas con puesto vacío o raro
const raros = data.filter(r => !r.puesto || isNaN(Number(r.puesto)));
console.log(`\n=== FILAS CON PUESTO VACÍO O NO NUMÉRICO (${raros.length}) ===`);
raros.slice(0, 10).forEach(r => console.log(`  fila ${r.fila}: tipo="${r.tipo}" puesto="${r.puesto}" nombre="${r.nombre}"`));
