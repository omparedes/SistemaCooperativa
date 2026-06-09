const XLSX = require('xlsx');
const path = require('path');

const file = path.join(__dirname, '../migracion_coop/SOCIOS E INQUILINOS TERMINADO.xlsx');
const wb = XLSX.readFile(file);
console.log('Sheets in SOCIOS E INQUILINOS TERMINADO.xlsx:', wb.SheetNames);
