import * as XLSX from 'xlsx';
import { readFileSync } from 'fs';

const ruta = 'migracion_coop/listapersonascoop.xlsx';
const wb = XLSX.readFile(ruta, { cellDates: true, raw: false });

console.log(`\n=== HOJAS ENCONTRADAS (${wb.SheetNames.length}) ===`);
wb.SheetNames.forEach((name, i) => console.log(`  [${i}] "${name}"`));

for (const name of wb.SheetNames) {
  const ws = wb.Sheets[name];
  const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
  const headers = rows[0] ?? [];
  const sample  = rows.slice(1, 4);

  console.log(`\n${'─'.repeat(60)}`);
  console.log(`HOJA: "${name}"  (${rows.length - 1} filas de datos)`);
  console.log(`COLUMNAS (${headers.length}):`);
  headers.forEach((h, i) => console.log(`  [${i}] "${h}"`));
  console.log('MUESTRA (hasta 3 filas):');
  sample.forEach((r, i) => console.log(`  fila ${i + 1}:`, JSON.stringify(r)));
}
