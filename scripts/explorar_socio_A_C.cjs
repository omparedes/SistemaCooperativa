const XLSX = require('xlsx');
const fs = require('fs');

const ruta = 'migracion_coop/2026/1.DETALLE SOCIO A-C NV 4-11-2025 - SOLO 2026.xlsx';
const wb = XLSX.readFile(ruta, { cellDates: true });

console.log(`=== ANALIZANDO HOJAS EN DETALLE ===`);

// Vamos a listar los conceptos únicos de todo el archivo para entender qué pagos se están haciendo
const conceptosUnicos = new Set();
const metodosPagoUnicos = new Set();

wb.SheetNames.forEach((sheetName) => {
  const ws = wb.Sheets[sheetName];
  // Leer raw arrays
  const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
  
  rows.forEach((row) => {
    if (row.length === 0 || !row[0]) return; // Fila vacía
    const concepto = String(row[3] || '').trim().toUpperCase();
    if (concepto) conceptosUnicos.add(concepto);
    
    const recibo = String(row[1] || '').trim().toUpperCase();
    if (recibo.startsWith('TARJETA')) {
      metodosPagoUnicos.add(recibo);
    }
  });
});

console.log('Conceptos únicos encontrados en todas las hojas:', Array.from(conceptosUnicos));
console.log('Métodos de pago tipo Tarjeta encontrados:', Array.from(metodosPagoUnicos));

// Mostrar el detalle exacto de las primeras 15 filas de la primera hoja
const wsFirst = wb.Sheets[wb.SheetNames[0]];
const rowsFirst = XLSX.utils.sheet_to_json(wsFirst, { header: 1, defval: '' });
console.log(`\n=== MUESTRA DE LA PRIMERA HOJA: "${wb.SheetNames[0]}" (Sin asumir cabeceras) ===`);
rowsFirst.slice(0, 15).forEach((r, i) => {
  console.log(`  Fila ${i + 1}:`, r.map(c => typeof c === 'object' && c instanceof Date ? c.toISOString().split('T')[0] : c));
});
