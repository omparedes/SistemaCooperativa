const XLSX = require('xlsx');
const path = require('path');

const file = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_pagos_2026/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH - PAGOS 2026.xlsx');
const workbook = XLSX.readFile(file);

// Imprimir los primeros 20 renglones y 10 columnas de la hoja "AIRE HECTOR" y "ALVARO GUSTAVO"
function printSheet(sheetName) {
  const sheet = workbook.Sheets[sheetName];
  if (!sheet) {
    console.log(`Sheet ${sheetName} not found`);
    return;
  }
  console.log(`\n=== HOJA: ${sheetName} ===`);
  const range = XLSX.utils.decode_range(sheet['!ref']);
  for (let r = 0; r <= Math.min(25, range.e.r); r++) {
    const row = [];
    for (let c = 0; c <= Math.min(10, range.e.c); c++) {
      const cellRef = XLSX.utils.encode_cell({ r, c });
      const cell = sheet[cellRef];
      row.push(cell ? String(cell.v).substring(0, 20) : '');
    }
    // Solo imprimir si hay algún valor en la fila
    if (row.some(x => x !== '')) {
      console.log(`Fila ${r + 1}: `, row.map(x => x.padEnd(20)).join(' | '));
    }
  }
}

printSheet('AIRE HECTOR');
printSheet('ALVARO GUSTAVO');
