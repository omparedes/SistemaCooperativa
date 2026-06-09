const XLSX = require('xlsx');
const path = require('path');
const fs = require('fs');

const pagosAM = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_pagos_2026/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH - PAGOS 2026.xlsx');
const pagosNZ = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_pagos_2026/DETALLE DE DEUDA POR CADA INQUILINO N-Z -2023 - RUTH  27.09 - PAGOS 2026.xlsx');
const deudasAM = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH - DEUDAS PENDIENTES.xlsx');
const deudasNZ = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO N-Z -2023 - RUTH  27.09 - DEUDAS PENDIENTES.xlsx');

function excelDateToISO(serial) {
  if (!serial || isNaN(serial)) return null;
  // Excel base date is 1899-12-30 due to a leap year bug in Lotus 1-2-3
  const date = new Date((serial - 25569) * 86400 * 1000);
  return date.toISOString().split('T')[0];
}

function parseTransactions(filePath, sheetName) {
  const wb = XLSX.readFile(filePath);
  const sheet = wb.Sheets[sheetName];
  if (!sheet || !sheet['!ref']) return [];

  const range = XLSX.utils.decode_range(sheet['!ref']);
  const txs = [];
  const isPagos = filePath.includes('pagos');

  for (let r = range.s.r; r <= range.e.r; r++) {
    // Leer celdas A, B, C, D de la fila r
    const valA = sheet[XLSX.utils.encode_cell({ r, c: 0 })]?.v;
    const valB = sheet[XLSX.utils.encode_cell({ r, c: 1 })]?.v;
    const valC = sheet[XLSX.utils.encode_cell({ r, c: 2 })]?.v;
    const valD = sheet[XLSX.utils.encode_cell({ r, c: 3 })]?.v;
    // El monto está en col F (5) para pagos y en col E (4) para deudas
    const valMontoRaw = sheet[XLSX.utils.encode_cell({ r, c: isPagos ? 5 : 4 })]?.v;

    // Si la fila está vacía, saltar
    if (valA === undefined && valB === undefined && valC === undefined && valD === undefined && valMontoRaw === undefined) {
      continue;
    }

    const monto = Number(valMontoRaw);
    if (!isNaN(monto) && valD) {
      const fecha = typeof valA === 'number' ? excelDateToISO(valA) : valA;
      txs.push({
        fila: r + 1,
        fechaOriginal: valA,
        fecha: fecha,
        documento: valB ? String(valB).trim() : '',
        periodo: valC ? String(valC).trim() : '',
        concepto: valD ? String(valD).trim() : '',
        monto: monto
      });
    }
  }

  return txs;
}

function analyzeAll() {
  const loadSheets = (file) => XLSX.readFile(file).SheetNames;
  
  const sheetsPAM = loadSheets(pagosAM).filter(s => s !== '2016');
  const sheetsPNZ = loadSheets(pagosNZ).filter(s => s !== '2016');
  const sheetsDAM = loadSheets(deudasAM).filter(s => s !== '2016' && s !== 'REVISION');
  const sheetsDNZ = loadSheets(deudasNZ).filter(s => s !== '2016' && s !== 'REVISION');

  const todasLasHojas = [...new Set([...sheetsPAM, ...sheetsPNZ, ...sheetsDAM, ...sheetsDNZ])];
  console.log(`Total hojas únicas a procesar: ${todasLasHojas.length}`);

  const report = {};

  for (const sheet of todasLasHojas) {
    const esAM = sheetsPAM.includes(sheet) || sheetsDAM.includes(sheet);
    
    const pFile = esAM ? pagosAM : pagosNZ;
    const dFile = esAM ? deudasAM : deudasNZ;

    const pagos = parseTransactions(pFile, sheet);
    const deudas = parseTransactions(dFile, sheet);

    report[sheet] = {
      esAM,
      pagosCount: pagos.length,
      deudasCount: deudas.length,
      pagos: pagos,
      deudas: deudas
    };
  }

  fs.writeFileSync(
    path.join(__dirname, 'transacciones_inquilinos_completas.json'),
    JSON.stringify(report, null, 2)
  );

  console.log(`Saved report for ${todasLasHojas.length} tenants in scratch/transacciones_inquilinos_completas.json`);
}

analyzeAll();
