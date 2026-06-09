const XLSX = require('xlsx');
const path = require('path');

const file = path.join(__dirname, '../migracion_coop/CUENTAS X COBRAR AL 31-12-2025.xlsx');
const wb = XLSX.readFile(file);
const sheet = wb.Sheets['ANEXO 2- N6 IN-pg 26-27'];

if (sheet) {
  console.log('=== ANEXO 2 COLUMNAS EXTRA ===');
  const data = XLSX.utils.sheet_to_json(sheet, { header: 1 });
  // Buscar filas correspondientes a Elizabeth Herrera, Rosa Maribel Quispe y Segundo Satalaya
  data.forEach((row, idx) => {
    const rowStr = row.join(' ').toLowerCase();
    if (rowStr.includes('herrera diaz elizabeth') || rowStr.includes('quispe quispe rosa maribel') || rowStr.includes('satalaya tapulima')) {
      console.log(`Fila ${idx+1}:`, row.map((x, cIdx) => `[Col ${cIdx+1}: ${x !== undefined ? String(x).trim() : ''}]`).filter(x => !x.includes(': ]')).join(' | '));
    }
  });
} else {
  console.log('Sheet not found');
}
