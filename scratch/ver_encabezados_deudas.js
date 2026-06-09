const XLSX = require('xlsx');
const path = require('path');
const fs = require('fs');

const deudasAM = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH - DEUDAS PENDIENTES.xlsx');
const deudasNZ = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO N-Z -2023 - RUTH  27.09 - DEUDAS PENDIENTES.xlsx');

const activeSheets = [
  { file: deudasAM, name: 'ALVARO GUSTAVO' },
  { file: deudasAM, name: 'CASTILLO ASAEL' },
  { file: deudasAM, name: 'CAYO BASILIO' },
  { file: deudasAM, name: 'DURAND BLANCA' },
  { file: deudasAM, name: 'FLORES DOMINICA' },
  { file: deudasAM, name: 'FUENTES VANESSA' },
  { file: deudasAM, name: 'HERRERA ELIZABETH' },
  { file: deudasAM, name: 'LEON RODRIGUEZ - FUENTES' },
  { file: deudasAM, name: 'LOAYZA JOSE' },
  { file: deudasAM, name: 'FLORES WILLIAMS' },
  { file: deudasAM, name: 'GONZALEZ CARMEN' },
  { file: deudasAM, name: 'LUCAS  LUZ' },
  { file: deudasNZ, name: 'PEÑA TEREZA' },
  { file: deudasNZ, name: 'QUISPE ROSA MARIBEL' },
  { file: deudasNZ, name: 'SATALAYA SEGUNDO' },
  { file: deudasNZ, name: 'EVELYN CUYA' }
];

console.log('=== INSPECCION DE ENCABEZADOS DE HOJAS ACTIVAS SIN EMPAREJAR ===');

for (const item of activeSheets) {
  if (!fs.existsSync(item.file)) continue;
  const wb = XLSX.readFile(item.file);
  const sheet = wb.Sheets[item.name];
  if (!sheet) {
    console.log(`Sheet ${item.name} not found`);
    continue;
  }
  
  console.log(`\n--- HOJA: ${item.name} ---`);
  
  // Imprimir las primeras 5 filas completas (hasta columna H)
  const range = sheet['!ref'] ? XLSX.utils.decode_range(sheet['!ref']) : null;
  if (!range) {
    console.log('Rango vacío');
    continue;
  }
  
  for (let r = 0; r <= Math.min(6, range.e.r); r++) {
    const rowCells = [];
    for (let c = 0; c <= Math.min(8, range.e.c); c++) {
      const cellRef = XLSX.utils.encode_cell({ r, c });
      const cell = sheet[cellRef];
      rowCells.push(cell && cell.v !== undefined ? String(cell.v).trim() : '');
    }
    if (rowCells.some(x => x !== '')) {
      console.log(`Fila ${r+1}: ${rowCells.map((x, idx) => `[Col ${idx+1}: ${x}]`).filter((x, idx) => rowCells[idx] !== '').join(' | ')}`);
    }
  }
}
