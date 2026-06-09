const XLSX = require('xlsx');
const path = require('path');

const file = path.join(__dirname, '../migracion_coop/CUENTAS X COBRAR AL 31-12-2025.xlsx');
const wb = XLSX.readFile(file);
const sheet = wb.Sheets['ANEXO 2- N6 IN-pg 26-27'];

if (sheet) {
  console.log('=== ANEXO 2 ===');
  const data = XLSX.utils.sheet_to_json(sheet, { header: 1 });
  // Imprimir las primeras 95 filas (solo columnas A a G)
  data.slice(0, 95).forEach((row, idx) => {
    // Si la fila tiene algún dato
    if (row.some(x => x !== undefined && x !== '')) {
      console.log(`Fila ${idx+1}:`, row.slice(0, 10).map(x => x !== undefined ? String(x).trim() : '').join(' | '));
    }
  });
} else {
  console.log('Sheet not found');
}
