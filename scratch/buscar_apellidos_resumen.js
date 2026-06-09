const XLSX = require('xlsx');
const path = require('path');
const fs = require('fs');

const fileResumen = path.join(__dirname, '../migracion_coop/SOCIOS E INQUILINOS TERMINADO.xlsx');
const fileCuentas = path.join(__dirname, '../migracion_coop/CUENTAS X COBRAR AL 31-12-2025.xlsx');

const surnames = ["Fuentes", "Loayza", "Lucas", "Cuya"];

function searchSurnames(filePath, label) {
  if (!fs.existsSync(filePath)) return;
  console.log(`\n=== Buscando en ${label} ===`);
  const wb = XLSX.readFile(filePath);
  
  wb.SheetNames.forEach(sheetName => {
    const sheet = wb.Sheets[sheetName];
    const data = XLSX.utils.sheet_to_json(sheet, { header: 1 });
    data.forEach((row, rIdx) => {
      const rowStr = row.join(' ').toLowerCase();
      surnames.forEach(surname => {
        if (rowStr.includes(surname.toLowerCase())) {
          console.log(`Sheet: ${sheetName} | Row ${rIdx+1}: ${row.filter(x => x !== '').join(' | ')}`);
        }
      });
    });
  });
}

searchSurnames(fileResumen, 'SOCIOS E INQUILINOS TERMINADO.xlsx');
searchSurnames(fileCuentas, 'CUENTAS X COBRAR AL 31-12-2025.xlsx');
