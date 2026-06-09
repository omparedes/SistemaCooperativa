const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');

// Cargar transacciones detalladas de Excel
const transacciones = JSON.parse(fs.readFileSync(path.join(__dirname, '../scratch/transacciones_inquilinos_completas.json'), 'utf8'));

// Cargar reporte de cruce inicial
const cruceReport = JSON.parse(fs.readFileSync(path.join(__dirname, '../scratch/cruce_inquilinos_report.json'), 'utf8'));

// Archivos maestros
const fileResumen = path.join(__dirname, '../migracion_coop/SOCIOS E INQUILINOS TERMINADO.xlsx');

// 1. Cargar mapeos de la hoja INQUIINOS y DEPOSITO
const masterPuestos = {};

const wb = XLSX.readFile(fileResumen);

const normalizar = (txt) => {
  if (!txt) return '';
  return txt.toLowerCase()
    .normalize("NFD").replace(/[\u0300-\u036f]/g, "")
    .replace(/ñ/g, 'n')
    .replace(/[^a-z0-9]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();
};

const sheetInq = wb.Sheets['INQUIINOS'];
if (sheetInq) {
  const data = XLSX.utils.sheet_to_json(sheetInq, { header: 1 });
  data.forEach((row, idx) => {
    const item = row[0];
    const dni = row[1] ? String(row[1]).trim() : '';
    const nombreCompleto = row[2] ? String(row[2]).trim() : '';
    const puesto = row[3] ? String(row[3]).trim() : '';

    if (item && dni && nombreCompleto && puesto) {
      const norm = normalizar(nombreCompleto);
      masterPuestos[norm] = { puesto, dni };
    }
  });
}

const sheetDep = wb.Sheets['DEPOSITO'];
if (sheetDep) {
  const data = XLSX.utils.sheet_to_json(sheetDep, { header: 1 });
  data.forEach(row => {
    const item = row[0];
    const nombre = row[1] ? String(row[1]).trim() : '';
    const apellido = row[2] ? String(row[2]).trim() : '';
    const puesto = row[4] ? String(row[4]).trim() : '';

    if (item && nombre && apellido && puesto) {
      const nombreCompleto = `${apellido} ${nombre}`;
      const norm = normalizar(nombreCompleto);
      masterPuestos[norm] = { puesto, dni: `DEP-${puesto}` };
    }
  });
}

const mapeoManual = {
  "CASTILLO ASAEL": { dni: "48773769", puesto: "1-E", tipo: "Inquilino" },
  "CAYO BASILIO": { dni: "08914131", puesto: "1-EP", tipo: "Tercero" },
  "DURAND BLANCA": { dni: "08030473", puesto: "3-SP", tipo: "Inquilino" },
  "FLORES DOMINICA": { dni: "09407642", puesto: "44-E", tipo: "Inquilino" },
  "LEON RODRIGUEZ - FUENTES": { dni: "73348594", puesto: "33-E", tipo: "Inquilino" },
  "PEÑA TEREZA": { dni: "08378642", puesto: "17-E", tipo: "Inquilino" },
  "SATALAYA SEGUNDO": { dni: "TEMP-58", puesto: "58", tipo: "Inquilino" },
  "EVELYN CUYA": { dni: "TEMP-11-D2", puesto: "11-D2", tipo: "Tercero" },
  "QUISPE MARISOL": { dni: "09700283", puesto: "53-E", tipo: "Inquilino" },
  "ACCO VICTOR": { dni: "DEP-5-D3", puesto: "6-D3", tipo: "Tercero" }
};

const excluidos = [
  "ALVARO GUSTAVO",
  "AYALA HILARY",
  "ATO MARIA",
  "CALLIROS FIORELLA",
  "FUENTES VANESSA",
  "HERRERA ELIZABETH",
  "LOAYZA JOSE",
  "LUJAN  DEISSY",
  "FLORES WILLIAMS",
  "GONZALEZ CARMEN",
  "GONZALES ROSMARY",
  "HUAMANI MAXIMO",
  "HUAMANI MAXIMO.",
  "IBARRA EMMA",
  "LUCAS  LUZ",
  "QUISPE ROSA MARIBEL"
];

const diccionarioHojas = {};

Object.entries(transacciones).forEach(([sheetName, data]) => {
  if (data.pagosCount === 0 && data.deudasCount === 0) return;
  if (excluidos.includes(sheetName)) return;

  if (mapeoManual[sheetName]) {
    diccionarioHojas[sheetName] = mapeoManual[sheetName];
    return;
  }

  const normSheet = normalizar(sheetName);
  let masterMatch = masterPuestos[normSheet];

  if (!masterMatch) {
    const sheetWords = normSheet.split(' ').filter(w => w.length > 2);
    const keys = Object.keys(masterPuestos);
    const bestKey = keys.find(k => {
      return sheetWords.every(w => k.includes(w));
    });
    if (bestKey) {
      masterMatch = masterPuestos[bestKey];
    }
  }

  if (!masterMatch) {
    const matched = cruceReport.emparejados.find(m => m.excel === sheetName);
    if (matched) {
      masterMatch = {
        dni: matched.dbDni,
        puesto: null
      };
    }
  }

  if (masterMatch) {
    diccionarioHojas[sheetName] = masterMatch;
  }
});

function generarSQL() {
  let sql = `-- Migración 00058 — Corrección de Fechas de Pagos de Inquilinos\n`;
  sql += `-- Propósito: Actualiza la columna fecha_pago con la fecha real del Excel en lugar de now()\n\n`;
  sql += `BEGIN;\n\n`;
  
  let updatesCount = 0;

  Object.entries(transacciones).forEach(([sheetName, data]) => {
    if (data.pagosCount === 0) return;
    if (excluidos.includes(sheetName)) return;

    const info = diccionarioHojas[sheetName];
    if (!info || !info.dni) return;

    data.pagos.forEach(p => {
      if (!p.fecha) return;
      
      sql += `UPDATE public.pagos 
   SET fecha_pago = '${p.fecha} 12:00:00-05'::timestamptz
 WHERE inquilino_id = (SELECT id FROM public.inquilinos WHERE DNI = '${info.dni}' AND deleted_at IS NULL)
   AND comprobante = '${p.documento}'
   AND monto_total = ${p.monto.toFixed(2)}
   AND observacion = 'Migracion 2026: Pago ${p.periodo} ${p.concepto}'
   AND fecha_pago::date = '2026-06-05'::date;\n`;
      updatesCount++;
    });
  });

  sql += `\nCOMMIT;\n`;

  fs.writeFileSync(path.join(__dirname, '../supabase/migrations/00058_correccion_fechas_pagos_inquilinos.sql'), sql);
  console.log(`Generados ${updatesCount} updates en 00058_correccion_fechas_pagos_inquilinos.sql`);
}

generarSQL();
