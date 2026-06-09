const XLSX = require('xlsx');
const path = require('path');
const fs = require('fs');

const pagosAM = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_pagos_2026/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH - PAGOS 2026.xlsx');
const pagosNZ = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_pagos_2026/DETALLE DE DEUDA POR CADA INQUILINO N-Z -2023 - RUTH  27.09 - PAGOS 2026.xlsx');
const deudasAM = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH - DEUDAS PENDIENTES.xlsx');
const deudasNZ = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO N-Z -2023 - RUTH  27.09 - DEUDAS PENDIENTES.xlsx');

function listSheets(filePath, label) {
  if (!fs.existsSync(filePath)) {
    console.log(`${label}: File not found at ${filePath}`);
    return [];
  }
  const workbook = XLSX.readFile(filePath);
  console.log(`\n=== ${label} (${workbook.SheetNames.length} sheets) ===`);
  console.log(workbook.SheetNames.slice(0, 10).join(', ') + (workbook.SheetNames.length > 10 ? ' ... and more' : ''));
  return workbook.SheetNames;
}

const sheetsPagosAM = listSheets(pagosAM, 'PAGOS A-M');
const sheetsPagosNZ = listSheets(pagosNZ, 'PAGOS N-Z');
const sheetsDeudasAM = listSheets(deudasAM, 'DEUDAS A-M');
const sheetsDeudasNZ = listSheets(deudasNZ, 'DEUDAS N-Z');

// Guardar lista completa de hojas en un archivo JSON para poder revisarla
const report = {
  pagosAM: sheetsPagosAM,
  pagosNZ: sheetsPagosNZ,
  deudasAM: sheetsDeudasAM,
  deudasNZ: sheetsDeudasNZ
};
fs.writeFileSync(path.join(__dirname, 'hojas_inquilinos.json'), JSON.stringify(report, null, 2));
console.log('\nSaved sheets lists to scratch/hojas_inquilinos.json');
