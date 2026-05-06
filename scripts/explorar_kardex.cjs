/**
 * Explora la estructura de UN archivo de detalle de socios/inquilinos.
 * Muestra: hojas, fila de cabeceras, primeras filas de datos.
 */
'use strict';
const XLSX = require('xlsx');

const archivo = process.argv[2] || 'migracion_coop/1.DETALLE SOCIO A-C NV 4-11-2025 (1).xlsx';
console.log('\n=== ARCHIVO:', archivo, '===');

const wb = XLSX.readFile(archivo, { raw: false, cellDates: false });
console.log('Hojas:', wb.SheetNames.length, '→', wb.SheetNames.slice(0, 8).join(', '), '...');

// Explorar las 2 primeras hojas en detalle
const muestra = wb.SheetNames.slice(0, 2);
for (const sheetName of muestra) {
  const ws = wb.Sheets[sheetName];
  const mat = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '', raw: false, dateNF: 'dd/mm/yyyy' });

  console.log(`\n${'─'.repeat(60)}`);
  console.log(`HOJA: "${sheetName}"  (${mat.length} filas totales)`);

  // Mostrar las primeras 10 filas raw
  mat.slice(0, 12).forEach((r, i) =>
    console.log(`  fila ${i + 1}: [${r.map(c => JSON.stringify(c)).join(', ')}]`)
  );

  // Buscar fila de cabeceras
  const headerIdx = mat.findIndex(r =>
    r.some(c => /^FECHA$/i.test(String(c).trim())) &&
    r.some(c => /POR\s*COBRAR|COBRAR/i.test(String(c).trim()))
  );

  if (headerIdx >= 0) {
    console.log(`\n  → Cabeceras en fila ${headerIdx + 1}:`, mat[headerIdx].map(c => `"${c}"`).join(', '));
    console.log('  → Primeras 3 filas de datos:');
    mat.slice(headerIdx + 1, headerIdx + 4).forEach((r, i) =>
      console.log(`    data ${i + 1}: [${r.map(c => JSON.stringify(c)).join(', ')}]`)
    );
  } else {
    console.log('  ⚠ No se encontraron cabeceras con FECHA+POR COBRAR');
  }
}

// Verificar si todas las hojas siguen el mismo patrón
console.log('\n=== ANÁLISIS DE TODAS LAS HOJAS ===');
let conCabeceras = 0, sinCabeceras = 0;
const filasCabecera = new Set();
for (const sheetName of wb.SheetNames) {
  const ws = wb.Sheets[sheetName];
  const mat = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '', raw: false });
  const hi = mat.findIndex(r =>
    r.some(c => /^FECHA$/i.test(String(c).trim())) &&
    r.some(c => /POR\s*COBRAR|COBRAR/i.test(String(c).trim()))
  );
  if (hi >= 0) { conCabeceras++; filasCabecera.add(hi + 1); }
  else sinCabeceras++;
}
console.log(`Con cabeceras: ${conCabeceras} | Sin cabeceras: ${sinCabeceras}`);
console.log('Filas donde aparecen cabeceras:', [...filasCabecera].sort().join(', '));
