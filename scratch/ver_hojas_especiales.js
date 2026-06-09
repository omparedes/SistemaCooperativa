const XLSX = require('xlsx');
const path = require('path');
const fs = require('fs');

const pagosNZ = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_pagos_2026/DETALLE DE DEUDA POR CADA INQUILINO N-Z -2023 - RUTH  27.09 - PAGOS 2026.xlsx');
const deudasAM = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH - DEUDAS PENDIENTES.xlsx');
const deudasNZ = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO N-Z -2023 - RUTH  27.09 - DEUDAS PENDIENTES.xlsx');

function dumpSheet(filePath, sheetName, label) {
  if (!fs.existsSync(filePath)) return;
  const wb = XLSX.readFile(filePath);
  const sheet = wb.Sheets[sheetName];
  if (!sheet) {
    console.log(`${label}: Sheet ${sheetName} not found`);
    return;
  }
  console.log(`\n=== ${label} (${sheetName}) ===`);
  const range = XLSX.utils.decode_range(sheet['!ref']);
  for (let r = 0; r <= Math.min(100, range.e.r); r++) {
    const row = [];
    for (let c = 0; c <= Math.min(10, range.e.c); c++) {
      const cellRef = XLSX.utils.encode_cell({ r, c });
      const cell = sheet[cellRef];
      row.push(cell ? String(cell.v).trim() : '');
    }
    if (row.some(x => x !== '')) {
      console.log(`Row ${r+1}: ${row.filter((x, idx) => row[idx] !== '').join(' | ')}`);
    }
  }
}

dumpSheet(pagosNZ, '2016', 'PAGOS N-Z special');
dumpSheet(deudasAM, 'REVISION', 'DEUDAS A-M special');
dumpSheet(deudasNZ, 'REVISION', 'DEUDAS N-Z special');
