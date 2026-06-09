const XLSX = require('xlsx');

const file = 'migracion_coop/2026/SOCIOS - CONSOLIDADO POR COBRAR REVISADO.xlsx';

try {
  const wb = XLSX.readFile(file);
  const ws = wb.Sheets['Detalle por cobrar'];
  const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
  
  console.log(`=== SEARCH FOR "ALVAREZ" IN CONSOLIDATED FILE ===`);
  rows.forEach((r, idx) => {
    const socio = String(r[1] || '').toUpperCase();
    if (socio.includes('ALVAREZ') || socio.includes('MARIANELA')) {
      console.log(`Row ${idx+1}:`, r.map(x => String(x).trim()));
    }
  });
} catch (err) {
  console.error(err);
}
