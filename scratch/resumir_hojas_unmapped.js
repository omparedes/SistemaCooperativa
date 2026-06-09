const fs = require('fs');
const path = require('path');

const transacciones = JSON.parse(fs.readFileSync(path.join(__dirname, 'transacciones_inquilinos_completas.json'), 'utf8'));

const unmappedSheets = [
  "ALVARO GUSTAVO",
  "AYALA HILARY",
  "ATO MARIA",
  "CALLIROS FIORELLA",
  "CASTILLO ASAEL",
  "CAYO BASILIO",
  "DURAND BLANCA",
  "FLORES DOMINICA",
  "FUENTES VANESSA",
  "HERRERA ELIZABETH",
  "LEON RODRIGUEZ - FUENTES",
  "LOAYZA JOSE",
  "LUJAN  DEISSY",
  "FLORES WILLIAMS",
  "GONZALEZ CARMEN",
  "GONZALES ROSMARY",
  "IBARRA EMMA",
  "LUCAS  LUZ",
  "PEÑA TEREZA",
  "QUISPE MARISOL",
  "QUISPE ROSA MARIBEL",
  "SATALAYA SEGUNDO",
  "TITO ISABEL",
  "MALCA LUZ",
  "EVELYN CUYA"
];

console.log('=== RESUMEN DE HOJAS SIN EMPAREJAR EN EXCEL ===');
const activeUnmapped = [];

for (const sheet of unmappedSheets) {
  const data = transacciones[sheet];
  if (!data) continue;

  if (data.pagosCount > 0 || data.deudasCount > 0) {
    activeUnmapped.push({
      sheet,
      pagos: data.pagosCount,
      deudas: data.deudasCount,
      firstPago: data.pagos[0] ? { concepto: data.pagos[0].concepto, monto: data.pagos[0].monto } : null,
      firstDeuda: data.deudas[0] ? { concepto: data.deudas[0].concepto, monto: data.deudas[0].monto } : null
    });
  }
}

console.table(activeUnmapped);
console.log(`Hojas activas sin emparejar: ${activeUnmapped.length}`);
fs.writeFileSync(path.join(__dirname, 'hojas_activas_unmapped.json'), JSON.stringify(activeUnmapped, null, 2));
