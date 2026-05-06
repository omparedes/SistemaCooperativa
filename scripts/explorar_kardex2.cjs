/**
 * Explora en detalle la estructura de kardex individual por persona.
 */
'use strict';
const XLSX = require('xlsx');

// Test both socio and inquilino formats
const archivos = [
  'migracion_coop/1.DETALLE SOCIO A-C NV 4-11-2025 (1).xlsx',
  'migracion_coop/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH.xlsx',
];

for (const archivo of archivos) {
  const wb = XLSX.readFile(archivo, { raw: false, cellDates: false });
  console.log(`\n${'='.repeat(70)}`);
  console.log('ARCHIVO:', archivo.split('/').pop());

  // Find first sheet WITH kardex format (FECHA + POR COBRAR headers)
  for (const sheetName of wb.SheetNames) {
    const ws = wb.Sheets[sheetName];
    const mat = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '', raw: false });

    const hi = mat.findIndex(r =>
      r.some(c => /^FECHA$/i.test(String(c).trim())) &&
      r.some(c => /POR\s*COBRAR|COBRAR/i.test(String(c).trim()))
    );

    if (hi < 0) continue; // Skip summary sheets

    console.log(`\n── HOJA: "${sheetName}" ──`);
    console.log('Filas totales:', mat.length);

    // Show first few rows (header context + headers + data)
    mat.slice(0, hi + 1).forEach((r, i) =>
      console.log(`  fila ${i+1} (pre-header): [${r.slice(0,10).map(c => JSON.stringify(c)).join(', ')}...]`)
    );

    const headers = mat[hi];
    console.log(`\n  CABECERAS (fila ${hi+1}):`);
    headers.forEach((h, i) => {
      if (String(h).trim()) console.log(`    col[${i}] = "${String(h).trim()}"`);
    });

    // Show 10 data rows
    console.log(`\n  DATOS (primeras 10 filas después de cabeceras):`);
    mat.slice(hi + 1, hi + 11).forEach((r, i) => {
      // Only show non-empty rows
      const nonEmpty = r.filter(c => String(c).trim()).length;
      if (nonEmpty > 0) {
        console.log(`  fila ${hi + i + 2}: [${r.map(c => JSON.stringify(c)).join(', ')}]`);
      }
    });

    // Show last 5 data rows
    const dataRows = mat.slice(hi + 1).filter(r => r.filter(c => String(c).trim()).length > 0);
    console.log(`\n  TOTAL filas con dato: ${dataRows.length}`);
    console.log('  Últimas 3 filas:');
    dataRows.slice(-3).forEach(r =>
      console.log(`    [${r.map(c => JSON.stringify(c)).join(', ')}]`)
    );
    break; // Only analyze first kardex sheet per file
  }
}
