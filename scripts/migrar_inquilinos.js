const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');

// Cargar transacciones detalladas de Excel
const transacciones = JSON.parse(fs.readFileSync(path.join(__dirname, '../scratch/transacciones_inquilinos_completas.json'), 'utf8'));

// Cargar reporte de cruce inicial para las hojas emparejadas automáticamente
const cruceReport = JSON.parse(fs.readFileSync(path.join(__dirname, '../scratch/cruce_inquilinos_report.json'), 'utf8'));

// Archivos maestros
const fileResumen = path.join(__dirname, '../migracion_coop/SOCIOS E INQUILINOS TERMINADO.xlsx');

// 1. Cargar mapeos de la hoja INQUIINOS y DEPOSITO de SOCIOS E INQUILINOS TERMINADO.xlsx
const masterPuestos = {}; // NombreNormalizado -> { puesto, dni }

const wb = XLSX.readFile(fileResumen);

// Normalizar texto para comparación
const normalizar = (txt) => {
  if (!txt) return '';
  return txt.toLowerCase()
    .normalize("NFD").replace(/[\u0300-\u036f]/g, "") // quitar tildes
    .replace(/ñ/g, 'n')
    .replace(/[^a-z0-9]/g, ' ') // reemplazar caracteres especiales por espacios
    .replace(/\s+/g, ' ') // unificar espacios
    .trim();
};

// Cargar hoja INQUIINOS
const sheetInq = wb.Sheets['INQUIINOS'];
if (sheetInq) {
  const data = XLSX.utils.sheet_to_json(sheetInq, { header: 1 });
  data.forEach((row, idx) => {
    // Las filas útiles suelen empezar con un número de item en la col A (índice 0)
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

// Cargar hoja DEPOSITO (para depósitos/almacenes)
const sheetDep = wb.Sheets['DEPOSITO'];
if (sheetDep) {
  const data = XLSX.utils.sheet_to_json(sheetDep, { header: 1 });
  // La hoja DEPOSITO tiene formato de bloques por pisos. Las filas de datos tienen item en col 0, nombre en col 1, apellido en col 2, puesto en col 4
  data.forEach(row => {
    const item = row[0];
    const nombre = row[1] ? String(row[1]).trim() : '';
    const apellido = row[2] ? String(row[2]).trim() : '';
    const puesto = row[4] ? String(row[4]).trim() : '';

    if (item && nombre && apellido && puesto) {
      const nombreCompleto = `${apellido} ${nombre}`;
      const norm = normalizar(nombreCompleto);
      // Los depósitos usan DNIs técnicos del tipo DEP-[Puesto]
      masterPuestos[norm] = { puesto, dni: `DEP-${puesto}` };
    }
  });
}

console.log(`Cargados ${Object.keys(masterPuestos).length} registros de puestos desde el Excel maestro.`);

// Mapeo manual de las hojas activas que quedaron sin emparejar
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

// Hojas a excluir de la migración (exonerados, cancelados externos, duplicados o nuevos sin puesto)
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

// Diccionario unificado de Hojas a { DNI, Puesto }
const diccionarioHojas = {};

// 3. Cruzar hojas de Excel con el maestro del Excel y mapeo manual
Object.entries(transacciones).forEach(([sheetName, data]) => {
  if (data.pagosCount === 0 && data.deudasCount === 0) return;
  if (excluidos.includes(sheetName)) return;

  // Si está en mapeo manual
  if (mapeoManual[sheetName]) {
    diccionarioHojas[sheetName] = mapeoManual[sheetName];
    return;
  }

  // Buscar coincidencia en el maestro por nombre de hoja normalizado
  const normSheet = normalizar(sheetName);
  let masterMatch = masterPuestos[normSheet];

  if (!masterMatch) {
    // Buscar coincidencia parcial inteligente por palabras (tokens)
    const sheetWords = normSheet.split(' ').filter(w => w.length > 2); // palabras de más de 2 letras
    const keys = Object.keys(masterPuestos);
    const bestKey = keys.find(k => {
      // Verificar si todas las palabras de la hoja de Excel están en la llave del maestro
      return sheetWords.every(w => k.includes(w));
    });
    if (bestKey) {
      masterMatch = masterPuestos[bestKey];
    }
  }

  // Si no se encuentra en el maestro, buscar en cruceReport.emparejados
  if (!masterMatch) {
    const matched = cruceReport.emparejados.find(m => m.excel === sheetName);
    if (matched) {
      masterMatch = {
        dni: matched.dbDni,
        puesto: null // A resolver después si no está en el maestro
      };
    }
  }

  if (masterMatch) {
    diccionarioHojas[sheetName] = masterMatch;
  }
});

// Mapeo de conceptos en Excel a concepto_id en DB
const conceptoMap = {
  'LUZ': 1,
  'AGUA': 2,
  'ALQUILER': 11,
  'AJUSTE SALDO FINAL': 9, // Ajuste manual
  'FUMIGACION': 18, // Otros
  'DEPOSITO': 16,
  'DEPOSITO N° 11': 16,
  'TALONARIO SANTA ROSA': 10, // Otros ingresos
  'MULTA X CAPACITACION': 6 // Multa
};

// Mapeo de nombre de mes a número
const mesMap = {
  'ENERO': 1, 'FEBRERO': 2, 'MARZO': 3, 'ABRIL': 4, 'MAYO': 5, 'JUNIO': 6,
  'JULIO': 7, 'AGOSTO': 8, 'SETIEMBRE': 9, 'OCTUBRE': 10, 'NOVIEMBRE': 11, 'DICIEMBRE': 12
};

function generarSQLs() {
  let sqlPagosAM = `-- Migración 00055_a — Carga de Pagos Detallados Inquilinos A-M (2026)\nBEGIN;\n\n`;
  let sqlPagosNZ = `-- Migración 00055_b — Carga de Pagos Detallados Inquilinos N-Z (2026)\nBEGIN;\n\n`;
  let sqlDeudasAM = `-- Migración 00056_a — Carga de Deudas Pendientes Inquilinos A-M\nBEGIN;\n\n`;
  let sqlDeudasNZ = `-- Migración 00056_b — Carga de Deudas Pendientes Inquilinos N-Z\nBEGIN;\n\n`;

  let contPagosAM = 0;
  let contPagosNZ = 0;
  let contDeudasAM = 0;
  let contDeudasNZ = 0;
  let noResolvibles = 0;

  Object.entries(transacciones).forEach(([sheetName, data]) => {
    if (data.pagosCount === 0 && data.deudasCount === 0) return;

    if (excluidos.includes(sheetName)) {
      console.log(`Ignorando hoja excluida/exonerada: ${sheetName}`);
      return;
    }

    const info = diccionarioHojas[sheetName];
    if (!info || !info.dni || !info.puesto) {
      console.log(`Advertencia: No se pudo resolver DNI o Puesto para la hoja: ${sheetName} -> DNI: ${info ? info.dni : 'null'}, Puesto: ${info ? info.puesto : 'null'}`);
      noResolvibles++;
      return;
    }

    const isAM = data.esAM;

    // A. Generar Pagos 2026
    data.pagos.forEach(p => {
      const sqlTx = `SELECT public.rpc_procesar_pago(
  (SELECT id FROM public.puestos WHERE codigo_puesto = '${info.puesto}' AND deleted_at IS NULL),
  NULL::bigint,
  (SELECT id FROM public.inquilinos WHERE DNI = '${info.dni}' AND deleted_at IS NULL),
  ${p.monto.toFixed(2)},
  'Efectivo',
  '${p.documento || 'V-2026'}',
  'Migracion 2026: Pago ${p.periodo} ${p.concepto}',
  NULL::uuid,
  '[]'::jsonb,
  0.00 -- saldo utilizado
);\n`;

      if (isAM) {
        sqlPagosAM += sqlTx;
        contPagosAM++;
      } else {
        sqlPagosNZ += sqlTx;
        contPagosNZ++;
      }
    });

    // B. Generar Deudas
    data.deudas.forEach(d => {
      const mesNum = mesMap[d.periodo.toUpperCase()] || 1;
      const anioNum = d.fecha ? Number(d.fecha.split('-')[0]) : 2026;
      let conceptoId = conceptoMap[d.concepto.toUpperCase()];
      if (!conceptoId) {
        if (d.concepto.toUpperCase().includes('LUZ')) conceptoId = 1;
        else if (d.concepto.toUpperCase().includes('AGUA')) conceptoId = 2;
        else if (d.concepto.toUpperCase().includes('ALQUILER')) conceptoId = 11;
        else conceptoId = 18; // Otros
      }

      const sqlTx = `INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, observacion)
SELECT 
  (SELECT id FROM public.puestos WHERE codigo_puesto = '${info.puesto}' AND deleted_at IS NULL),
  ${conceptoId},
  ${anioNum},
  ${mesNum},
  ${d.monto.toFixed(2)},
  'Pendiente',
  'Manual',
  'Migracion 2026: Deuda Pendiente ${d.periodo} ${d.concepto}'
WHERE NOT EXISTS (
  SELECT 1 FROM public.montos_por_cobrar 
  WHERE puesto_id = (SELECT id FROM public.puestos WHERE codigo_puesto = '${info.puesto}' AND deleted_at IS NULL)
    AND concepto_id = ${conceptoId}
    AND periodo_anio = ${anioNum}
    AND periodo_mes = ${mesNum}
    AND deleted_at IS NULL
);\n`;

      if (isAM) {
        sqlDeudasAM += sqlTx;
        contDeudasAM++;
      } else {
        sqlDeudasNZ += sqlTx;
        contDeudasNZ++;
      }
    });
  });

  sqlPagosAM += `\nCOMMIT;`;
  sqlPagosNZ += `\nCOMMIT;`;
  sqlDeudasAM += `\nCOMMIT;`;
  sqlDeudasNZ += `\nCOMMIT;`;

  fs.writeFileSync(path.join(__dirname, '../supabase/migrations/00055_a_migracion_pagos_inquilinos_A_M_2026.sql'), sqlPagosAM);
  fs.writeFileSync(path.join(__dirname, '../supabase/migrations/00055_b_migracion_pagos_inquilinos_N_Z_2026.sql'), sqlPagosNZ);
  fs.writeFileSync(path.join(__dirname, '../supabase/migrations/00056_a_migracion_deudas_inquilinos_A_M.sql'), sqlDeudasAM);
  fs.writeFileSync(path.join(__dirname, '../supabase/migrations/00056_b_migracion_deudas_inquilinos_N_Z.sql'), sqlDeudasNZ);

  console.log(`\n=== MIGRACIÓN COMPLETADA EN SQL ===`);
  console.log(`Hojas no resolvibles: ${noResolvibles}`);
  console.log(`Pagos A-M generados: ${contPagosAM} -> 00055_a`);
  console.log(`Pagos N-Z generados: ${contPagosNZ} -> 00055_b`);
  console.log(`Deudas A-M generadas: ${contDeudasAM} -> 00056_a`);
  console.log(`Deudas N-Z generadas: ${contDeudasNZ} -> 00056_b`);
}

generarSQLs();
