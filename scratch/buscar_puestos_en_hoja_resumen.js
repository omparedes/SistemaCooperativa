const XLSX = require('xlsx');
const path = require('path');
const fs = require('fs');

const fileResumen = path.join(__dirname, '../migracion_coop/SOCIOS E INQUILINOS TERMINADO.xlsx');
const fileCuentas = path.join(__dirname, '../migracion_coop/CUENTAS X COBRAR AL 31-12-2025.xlsx');

const newTenants = [
  "FUENTES VANESSA",
  "HERRERA ELIZABETH",
  "LOAYZA JOSE",
  "FLORES WILLIAMS",
  "GONZALEZ CARMEN",
  "LUCAS  LUZ",
  "QUISPE ROSA MARIBEL",
  "SATALAYA SEGUNDO",
  "EVELYN CUYA"
];

function searchInExcel(filePath, label) {
  if (!fs.existsSync(filePath)) {
    console.log(`${label}: File not found`);
    return;
  }
  console.log(`\n=== Buscando en ${label} ===`);
  const wb = XLSX.readFile(filePath);
  
  wb.SheetNames.forEach(sheetName => {
    const sheet = wb.Sheets[sheetName];
    const data = XLSX.utils.sheet_to_json(sheet, { header: 1 });
    data.forEach((row, rIdx) => {
      const rowStr = row.join(' ').toLowerCase();
      newTenants.forEach(tenant => {
        const parts = tenant.toLowerCase().split(' ').filter(p => p.length > 2);
        const matches = parts.every(p => rowStr.includes(p));
        if (matches) {
          console.log(`Sheet: ${sheetName} | Row ${rIdx+1}: ${row.filter(x => x !== '').join(' | ')}`);
        }
      });
    });
  });
}

searchInExcel(fileResumen, 'SOCIOS E INQUILINOS TERMINADO.xlsx');
searchInExcel(fileCuentas, 'CUENTAS X COBRAR AL 31-12-2025.xlsx');
