const XLSX = require('xlsx');

const sociosFiles = [
  'migracion_coop/2026/1.DETALLE SOCIO A-C NV 4-11-2025 - DEUDAS PENDIENTES.xlsx',
  'migracion_coop/2026/2.DETALLE SOCIO C-Q NV 4-11-2025 - DEUDAS PENDIENTES.xlsx',
  'migracion_coop/2026/3.DETALLE SOCIO M-R 3 -9-2025 - DEUDAS PENDIENTES.xlsx',
  'migracion_coop/2026/4.DETALLE SOCIO M-Z NV 4-11-2025 - DEUDAS PENDIENTES.xlsx'
];

const inquilinosFiles = [
  'migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH - DEUDAS PENDIENTES.xlsx',
  'migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO N-Z -2023 - RUTH  27.09 - DEUDAS PENDIENTES.xlsx'
];

function excelDateToJS(excelDate) {
  if (!excelDate) return null;
  if (excelDate instanceof Date) return excelDate;
  if (isNaN(excelDate)) return new Date(excelDate);
  const date = new Date((excelDate - 25569) * 86400 * 1000);
  const userTimezoneOffset = date.getTimezoneOffset() * 60000;
  return new Date(date.getTime() + userTimezoneOffset);
}

function analyzeYears(files, label) {
  console.log(`\n=== YEAR BREAKDOWN FOR ${label} ===`);
  const yearSums = {};
  
  files.forEach(file => {
    const wb = XLSX.readFile(file);
    wb.SheetNames.forEach(sheet => {
      if (sheet === 'RESUMEN' || sheet === 'PLANTILLA') return;
      const ws = wb.Sheets[sheet];
      const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
      rows.forEach(r => {
        const valE = parseFloat(r[4]);
        if (isNaN(valE) || valE <= 0) return;
        
        // Columna A contains the date
        const fecha = excelDateToJS(r[0]);
        if (!fecha || isNaN(fecha.getTime())) return;
        
        const year = fecha.getFullYear();
        yearSums[year] = (yearSums[year] || 0) + valE;
      });
    });
  });
  
  Object.keys(yearSums).sort().forEach(y => {
    console.log(`Year ${y}: S/ ${yearSums[y].toFixed(2)}`);
  });
}

analyzeYears(sociosFiles, 'SOCIOS');
analyzeYears(inquilinosFiles, 'INQUILINOS');
