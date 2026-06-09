const XLSX = require('xlsx');
const path = require('path');

const pagosFile = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_pagos_2026/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH - PAGOS 2026.xlsx');
const deudasFile = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH - DEUDAS PENDIENTES.xlsx');

function checkSheet(filePath, sheetName, label) {
  const wb = XLSX.readFile(filePath);
  const sheet = wb.Sheets[sheetName];
  if (!sheet) {
    console.log(`${label}: Sheet ${sheetName} not found`);
    return;
  }
  const ref = sheet['!ref'];
  console.log(`${label}: Sheet range is ${ref}`);
  if (!ref) return;

  const range = XLSX.utils.decode_range(ref);
  let count = 0;
  for (let r = range.s.r; r <= range.e.r; r++) {
    for (let c = range.s.c; c <= range.e.c; c++) {
      const cellRef = XLSX.utils.encode_cell({ r, c });
      const cell = sheet[cellRef];
      if (cell && cell.v !== undefined && cell.v !== '') {
        count++;
        if (count <= 10) {
          console.log(`Cell ${cellRef} (Row ${r+1}, Col ${c+1}): ${cell.v}`);
        }
      }
    }
  }
  console.log(`${label}: Total cells with data: ${count}`);
}

checkSheet(pagosFile, 'ALVARO GUSTAVO', 'PAGOS - ALVARO GUSTAVO');
checkSheet(deudasFile, 'ALVARO GUSTAVO', 'DEUDAS - ALVARO GUSTAVO');
