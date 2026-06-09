const XLSX = require('xlsx');
const path = require('path');
const fs = require('fs');

const deudasAM = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH - DEUDAS PENDIENTES.xlsx');
const deudasNZ = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO N-Z -2023 - RUTH  27.09 - DEUDAS PENDIENTES.xlsx');

const targets = [
  { file: deudasAM, sheet: 'LOAYZA JOSE' },
  { file: deudasAM, sheet: 'FLORES WILLIAMS' },
  { file: deudasAM, sheet: 'GONZALEZ CARMEN' },
  { file: deudasAM, sheet: 'LUCAS  LUZ' },
  { file: deudasNZ, sheet: 'QUISPE ROSA MARIBEL' }
];

targets.forEach(t => {
  if (!fs.existsSync(t.file)) return;
  const wb = XLSX.readFile(t.file);
  const sheet = wb.Sheets[t.sheet];
  if (!sheet) {
    console.log(`Sheet ${t.sheet} not found`);
    return;
  }
  console.log(`\n=== HOJA: ${t.sheet} (todas las celdas con datos) ===`);
  const ref = sheet['!ref'];
  if (!ref) return;
  const range = XLSX.utils.decode_range(ref);
  for (let r = range.s.r; r <= range.e.r; r++) {
    const row = [];
    for (let c = range.s.c; c <= range.e.c; c++) {
      const cellRef = XLSX.utils.encode_cell({ r, c });
      const cell = sheet[cellRef];
      row.push(cell ? `${cellRef}:${cell.v}` : '');
    }
    if (row.some(x => x !== '')) {
      console.log(`Row ${r+1}:`, row.filter(x => x !== '').join(' | '));
    }
  }
});
