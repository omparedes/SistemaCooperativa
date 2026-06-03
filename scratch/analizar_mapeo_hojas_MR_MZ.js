const XLSX = require('xlsx');
const path = require('path');

const file = path.join(__dirname, '../migracion_coop/2026/3.DETALLE SOCIO M-R 3 -9-2025 - DEUDAS PENDIENTES.xlsx');
const wb = XLSX.readFile(file);
const firstSheet = wb.SheetNames[0];

console.log("Primera hoja del Excel de deudas pendientes:", firstSheet);
const ws = wb.Sheets[firstSheet];
const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });

console.log("Primeras 15 filas:");
rows.slice(0, 15).forEach((r, idx) => {
  console.log(`Fila ${idx}:`, JSON.stringify(r));
});
