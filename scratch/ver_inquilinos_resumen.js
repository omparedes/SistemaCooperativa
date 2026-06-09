const XLSX = require('xlsx');
const path = require('path');

const file = path.join(__dirname, '../migracion_coop/SOCIOS E INQUILINOS TERMINADO.xlsx');
const wb = XLSX.readFile(file);
const sheet = wb.Sheets['INQUIINOS'];

if (sheet) {
  const data = XLSX.utils.sheet_to_json(sheet, { header: 1 });
  console.log(`=== HOJA INQUIINOS (${data.length} filas) ===`);
  data.slice(0, 100).forEach((row, idx) => {
    if (row.some(x => x !== undefined && x !== '')) {
      console.log(`Fila ${idx+1}:`, row.slice(0, 10).map(x => x !== undefined ? String(x).trim() : '').join(' | '));
    }
  });
} else {
  console.log('Sheet INQUIINOS not found');
}
