const XLSX = require('xlsx');
const fs = require('fs');

const sociosFiles = [
  'migracion_coop/2026/1.DETALLE SOCIO A-C NV 4-11-2025 - DEUDAS PENDIENTES.xlsx',
  'migracion_coop/2026/2.DETALLE SOCIO C-Q NV 4-11-2025 - DEUDAS PENDIENTES.xlsx',
  'migracion_coop/2026/3.DETALLE SOCIO M-R 3 -9-2025 - DEUDAS PENDIENTES.xlsx',
  'migracion_coop/2026/4.DETALLE SOCIO M-Z NV 4-11-2025 - DEUDAS PENDIENTES.xlsx'
];

let totalSociosExcel = 0;
let sociosSheetsCount = 0;

sociosFiles.forEach(file => {
  const wb = XLSX.readFile(file);
  wb.SheetNames.forEach(sheet => {
    if (sheet === 'RESUMEN' || sheet === 'PLANTILLA') return;
    sociosSheetsCount++;
    const ws = wb.Sheets[sheet];
    const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
    rows.forEach(r => {
      if (r.length < 5) return;
      const tipo = String(r[1] || '').trim().toUpperCase();
      const monto = parseFloat(r[4]);
      if (tipo === 'POR COBRAR' && !isNaN(monto)) {
        totalSociosExcel += monto;
      }
    });
  });
});

console.log(`Socios Excel Outstanding Debts Sum: S/ ${totalSociosExcel.toFixed(2)} (${sociosSheetsCount} sheets processed)`);
