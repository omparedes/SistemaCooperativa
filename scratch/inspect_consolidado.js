const XLSX = require('xlsx');

const file = 'migracion_coop/2026/SOCIOS - CONSOLIDADO POR COBRAR REVISADO.xlsx';

try {
  const wb = XLSX.readFile(file);
  console.log(`Sheet Names (${wb.SheetNames.length}):`, wb.SheetNames.slice(0, 10), wb.SheetNames.length > 10 ? '...' : '');
  
  const firstSheet = wb.SheetNames[0];
  console.log(`\n=== FIRST SHEET: "${firstSheet}" ===`);
  const ws = wb.Sheets[firstSheet];
  const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
  
  console.log(`Total rows: ${rows.length}`);
  console.log(`First 15 rows:`);
  rows.slice(0, 15).forEach((r, i) => {
    console.log(`Row ${i+1}:`, r.map(x => String(x).trim()));
  });
} catch (err) {
  console.error(err);
}
