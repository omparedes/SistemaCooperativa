const XLSX = require('xlsx');

const files = [
  'migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH - DEUDAS PENDIENTES.xlsx',
  'migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO N-Z -2023 - RUTH  27.09 - DEUDAS PENDIENTES.xlsx'
];

let totalInquilinosExcel = 0;
let sheetCount = 0;

files.forEach(file => {
  const wb = XLSX.readFile(file);
  wb.SheetNames.forEach(sheet => {
    if (sheet === 'RESUMEN' || sheet === 'PLANTILLA') return;
    sheetCount++;
    const ws = wb.Sheets[sheet];
    const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
    rows.forEach(r => {
      if (r.length < 5) return;
      const tipo = String(r[1] || '').trim().toUpperCase();
      const monto = parseFloat(r[4]);
      if (tipo === 'POR COBRAR' && !isNaN(monto)) {
        totalInquilinosExcel += monto;
      }
    });
  });
});

console.log(`Inquilinos Excel Outstanding Debts Sum: S/ ${totalInquilinosExcel.toFixed(2)} (${sheetCount} sheets processed)`);
