const XLSX = require('xlsx');

const file = 'migracion_coop/2026/SOCIOS - CONSOLIDADO POR COBRAR REVISADO.xlsx';

try {
  const wb = XLSX.readFile(file);
  const ws = wb.Sheets['Detalle por cobrar'];
  const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
  
  console.log(`=== SEARCH FOR AMOUNTS 78.3 OR 87.0 OR 87 ===`);
  rows.forEach((r, idx) => {
    const val = parseFloat(r[6]);
    if (val === 78.3 || val === 87.0 || val === 87) {
      console.log(`Row ${idx+1}:`, r.map(x => String(x).trim()));
    }
  });
} catch (err) {
  console.error(err);
}
