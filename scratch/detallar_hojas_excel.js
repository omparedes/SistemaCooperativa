const XLSX = require('xlsx');
const path = require('path');
const fs = require('fs');

const pagosAM = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_pagos_2026/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH - PAGOS 2026.xlsx');
const pagosNZ = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_pagos_2026/DETALLE DE DEUDA POR CADA INQUILINO N-Z -2023 - RUTH  27.09 - PAGOS 2026.xlsx');
const deudasAM = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH - DEUDAS PENDIENTES.xlsx');
const deudasNZ = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO N-Z -2023 - RUTH  27.09 - DEUDAS PENDIENTES.xlsx');

const unmappedSheets = [
  { file: pagosAM, sheet: 'ALVARO GUSTAVO' },
  { file: pagosAM, sheet: 'AYALA HILARY' },
  { file: pagosAM, sheet: 'ATO MARIA' },
  { file: pagosAM, sheet: 'CALLIROS FIORELLA' },
  { file: pagosAM, sheet: 'CASTILLO ASAEL' },
  { file: pagosAM, sheet: 'CAYO BASILIO' },
  { file: pagosAM, sheet: 'DURAND BLANCA' },
  { file: pagosAM, sheet: 'FLORES DOMINICA' },
  { file: pagosAM, sheet: 'FUENTES VANESSA' },
  { file: pagosAM, sheet: 'HERRERA ELIZABETH' },
  { file: pagosAM, sheet: 'LEON RODRIGUEZ - FUENTES' },
  { file: pagosAM, sheet: 'LOAYZA JOSE' },
  { file: pagosAM, sheet: 'LUJAN  DEISSY' },
  { file: pagosAM, sheet: 'FLORES WILLIAMS' },
  { file: pagosAM, sheet: 'GONZALEZ CARMEN' },
  { file: pagosAM, sheet: 'GONZALES ROSMARY' },
  { file: pagosAM, sheet: 'IBARRA EMMA' },
  { file: pagosAM, sheet: 'LUCAS  LUZ' },
  { file: pagosNZ, sheet: 'PEÑA TEREZA' },
  { file: pagosNZ, sheet: 'QUISPE MARISOL' },
  { file: pagosNZ, sheet: 'QUISPE ROSA MARIBEL' },
  { file: pagosNZ, sheet: 'SATALAYA SEGUNDO' },
  { file: pagosNZ, sheet: 'TITO ISABEL' },
  { file: pagosNZ, sheet: 'MALCA LUZ' },
  { file: pagosNZ, sheet: 'EVELYN CUYA' }
];

function inspectSheet(filePath, sheetName) {
  if (!fs.existsSync(filePath)) return { error: 'File not found' };
  const workbook = XLSX.readFile(filePath);
  const sheet = workbook.Sheets[sheetName];
  if (!sheet) return { error: `Sheet ${sheetName} not found` };

  // Convertir a matriz
  const range = XLSX.utils.decode_range(sheet['!ref']);
  const rows = [];
  // Leemos las primeras 12 filas para ver los datos del inquilino y del puesto
  for (let r = 0; r <= Math.min(12, range.e.r); r++) {
    const row = [];
    for (let c = 0; c <= Math.min(10, range.e.c); c++) {
      const cellRef = XLSX.utils.encode_cell({ r, c });
      const cell = sheet[cellRef];
      row.push(cell ? cell.v : null);
    }
    rows.push(row);
  }

  // Buscar texto que parezca puesto, socio, inquilino
  let infoPuesto = null;
  let infoNombre = null;
  
  rows.forEach(r => {
    const rowStr = r.join(' ').toLowerCase();
    if (rowStr.includes('puesto') || rowStr.includes('pto')) {
      infoPuesto = r.filter(x => x !== null).join(' | ');
    }
    if (rowStr.includes('inquilino') || rowStr.includes('nombre') || rowStr.includes('socio')) {
      infoNombre = r.filter(x => x !== null).join(' | ');
    }
  });

  return {
    sheetName,
    firstRows: rows.slice(0, 6).map(r => r.filter(x => x !== null).join(' | ')),
    infoPuesto,
    infoNombre
  };
}

const results = unmappedSheets.map(item => {
  const data = inspectSheet(item.file, item.sheet);
  return {
    sheet: item.sheet,
    infoNombre: data.infoNombre,
    infoPuesto: data.infoPuesto,
    firstRows: data.firstRows
  };
});

fs.writeFileSync(
  path.join(__dirname, 'detalles_hojas_inquilinos.json'),
  JSON.stringify(results, null, 2)
);

console.log('Saved inspection results to scratch/detalles_hojas_inquilinos.json');
