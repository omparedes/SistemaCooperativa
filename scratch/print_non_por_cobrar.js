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

function printNonPorCobrarNumeric(files, label) {
  console.log(`\n=== NON-'POR COBRAR' NUMERIC VALUES IN ${label} ===`);
  files.forEach(file => {
    const wb = XLSX.readFile(file);
    wb.SheetNames.forEach(sheet => {
      if (sheet === 'RESUMEN' || sheet === 'PLANTILLA') return;
      const ws = wb.Sheets[sheet];
      const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
      rows.forEach((r, idx) => {
        const valE = parseFloat(r[4]);
        if (isNaN(valE) || valE <= 0) return;
        
        const tipo = String(r[1] || '').trim().toUpperCase();
        if (tipo !== 'POR COBRAR') {
          console.log(`File: ${file.split('/').pop()} | Sheet: ${sheet} | Row: ${idx+1} | Col A: ${r[0]} | Col B (tipo): "${r[1]}" | Col C (periodo): "${r[2]}" | Col D (concepto): "${r[3]}" | Col E (monto): ${valE}`);
        }
      });
    });
  });
}

printNonPorCobrarNumeric(sociosFiles, 'SOCIOS');
printNonPorCobrarNumeric(inquilinosFiles, 'INQUILINOS');
