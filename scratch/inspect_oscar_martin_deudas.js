const XLSX = require('xlsx');
const file = 'migracion_coop/2026/3.DETALLE SOCIO M-R 3 -9-2025 - DEUDAS PENDIENTES.xlsx';
const sheetName = 'PAREDES OSCAR MARTIN';

try {
  const wb = XLSX.readFile(file, { cellDates: true, raw: false });
  const ws = wb.Sheets[sheetName];
  if (!ws) {
    console.log(`Sheet "${sheetName}" not found!`);
  } else {
    console.log(`Rows in sheet "${sheetName}":`);
    const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
    rows.forEach((r, i) => console.log(`Row ${i+1}:`, r.map(x => String(x).trim())));
  }
} catch (err) {
  console.error(err);
}
