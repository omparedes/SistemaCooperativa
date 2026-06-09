const XLSX = require('xlsx');

const soloFile = 'migracion_coop/2026/3.DETALLE SOCIO M-R 3 -9-2025 - SOLO 2026.xlsx';
const deudasFile = 'migracion_coop/2026/3.DETALLE SOCIO M-R 3 -9-2025 - DEUDAS PENDIENTES.xlsx';

function dumpSheet(file, sheetName) {
  console.log(`\n=== FILE: ${file} | SHEET: ${sheetName} ===`);
  try {
    const wb = XLSX.readFile(file, { cellDates: true, raw: false });
    const ws = wb.Sheets[sheetName];
    if (!ws) {
      console.log(`Sheet "${sheetName}" not found!`);
      return;
    }
    const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
    rows.forEach((r, idx) => {
      if (r.length > 0) {
        console.log(`Row ${idx + 1}:`, r.map(x => String(x).trim()));
      }
    });
  } catch (err) {
    console.error(`Error reading ${file}:`, err.message);
  }
}

// Check sheets containing 'PAREDES' or 'OSCAR'
const wbTemp = XLSX.readFile(soloFile);
const matches = wbTemp.SheetNames.filter(name => name.includes('PAREDES') || name.includes('OSCAR'));
console.log('Matching sheet names in SOLO 2026:', matches);

matches.forEach(m => {
  dumpSheet(soloFile, m);
  dumpSheet(deudasFile, m);
});
