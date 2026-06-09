const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');
const XLSX = require('xlsx');

// 1. Cargar configuración de .env
const envFile = fs.readFileSync('.env', 'utf8');
const envVars = {};
envFile.split('\n').forEach(line => {
  const match = line.match(/^\s*([^#=\s]+)\s*=\s*(.*)\s*$/);
  if (match) {
    let val = match[2].trim();
    if (val.startsWith('"') && val.endsWith('"')) val = val.slice(1, -1);
    if (val.startsWith("'") && val.endsWith("'")) val = val.slice(1, -1);
    envVars[match[1]] = val;
  }
});

const supabaseUrl = envVars.SUPABASE_URL;
const supabaseKey = envVars.SUPABASE_SERVICE_ROLE_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

const MESES = {
  'ENERO': 1, 'ENE': 1,
  'FEBRERO': 2, 'FEB': 2,
  'MARZO': 3, 'MAR': 3,
  'ABRIL': 4, 'ABR': 4,
  'MAYO': 5, 'MAY': 5,
  'JUNIO': 6, 'JUN': 6,
  'JULIO': 7, 'JUL': 7,
  'AGOSTO': 8, 'AGO': 8,
  'SEPTIEMBRE': 9, 'SETIEMBRE': 9, 'SET': 9, 'SEP': 9,
  'OCTUBRE': 10, 'OCT': 10,
  'NOVIEMBRE': 11, 'NOV': 11,
  'DICIEMBRE': 12, 'DIC': 12
};

const CONCEPTOS_BD = {
  'LUZ': 'Luz',
  'AGUA': 'Agua',
  'G. ADM': 'Gastos administrativos',
  'P. SOCIAL': 'Previsión social',
  'P.S': 'Previsión social',
  'DEPOSITO': 'Aporte extraordinario'
};

const BLOCKS = [
  {
    name: 'A-C',
    solo2026: 'migracion_coop/2026/1.DETALLE SOCIO A-C NV 4-11-2025 - SOLO 2026.xlsx',
    deudas: 'migracion_coop/2026/1.DETALLE SOCIO A-C NV 4-11-2025 - DEUDAS PENDIENTES.xlsx'
  },
  {
    name: 'C-Q',
    solo2026: 'migracion_coop/2026/2.DETALLE SOCIO C-Q NV 4-11-2025 - SOLO 2026.xlsx',
    deudas: 'migracion_coop/2026/2.DETALLE SOCIO C-Q NV 4-11-2025 - DEUDAS PENDIENTES.xlsx'
  },
  {
    name: 'M-R',
    solo2026: 'migracion_coop/2026/3.DETALLE SOCIO M-R 3 -9-2025 - SOLO 2026.xlsx',
    deudas: 'migracion_coop/2026/3.DETALLE SOCIO M-R 3 -9-2025 - DEUDAS PENDIENTES.xlsx'
  },
  {
    name: 'M-Z',
    solo2026: 'migracion_coop/2026/4.DETALLE SOCIO M-Z NV 4-11-2025 - SOLO 2026.xlsx',
    deudas: 'migracion_coop/2026/4.DETALLE SOCIO M-Z NV 4-11-2025 - DEUDAS PENDIENTES.xlsx'
  }
];

function normalizar(texto) {
  if (!texto) return '';
  return texto.toString()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toUpperCase()
    .trim()
    .replace(/\s+/g, ' ');
}

function excelDateToJS(excelDate) {
  if (!excelDate) return null;
  if (excelDate instanceof Date) return excelDate;
  if (isNaN(excelDate)) return new Date(excelDate);
  const date = new Date((excelDate - 25569) * 86400 * 1000);
  const userTimezoneOffset = date.getTimezoneOffset() * 60000;
  return new Date(date.getTime() + userTimezoneOffset);
}

function findSocio(sheetName, databaseSocios) {
  const normSheet = normalizar(sheetName);
  if (!normSheet || normSheet === 'RESUMEN' || normSheet === 'PLANTILLA') return null;

  // 1. Coincidencia exacta o contención directa
  let match = databaseSocios.find(s => {
    const dbNorm = normalizar(`${s.apellidos} ${s.nombres}`);
    const dbNormRev = normalizar(`${s.nombres} ${s.apellidos}`);
    return dbNorm === normSheet || dbNormRev === normSheet || dbNorm.includes(normSheet) || dbNormRev.includes(normSheet) || normSheet.includes(dbNorm);
  });

  // 2. Coincidencia por partes (al menos 2 palabras significativas)
  if (!match) {
    const partsSheet = normSheet.split(' ').filter(w => w.length > 2);
    match = databaseSocios.find(s => {
      const dbNorm = normalizar(`${s.apellidos} ${s.nombres}`);
      let coincs = 0;
      for (const p of partsSheet) {
        if (dbNorm.includes(p)) coincs++;
      }
      return coincs >= 2;
    });
  }

  return match;
}

async function main() {
  const { data: dbSocios } = await supabase
    .from('socios')
    .select('id, nombres, apellidos, dni');
  
  console.log(`Loaded ${dbSocios.length} socios from DB.`);
  
  // We want to see what is mapped to ID 113 (PAREDES FLORES OSCAR ALFREDO)
  const targetSocioId = 113;
  const targetSocio = dbSocios.find(s => s.id === targetSocioId);
  console.log('Target socio:', targetSocio);

  const matchedSheetsList = [];
  
  for (const block of BLOCKS) {
    const wbSolo = XLSX.readFile(block.solo2026, { cellDates: true });
    const wbDeudas = XLSX.readFile(block.deudas, { cellDates: true });
    
    wbSolo.SheetNames.forEach(sheetName => {
      const socio = findSocio(sheetName, dbSocios);
      if (socio && socio.id === targetSocioId) {
        matchedSheetsList.push({ block: block.name, type: 'SOLO 2026', sheetName });
      }
    });

    wbDeudas.SheetNames.forEach(sheetName => {
      const socio = findSocio(sheetName, dbSocios);
      if (socio && socio.id === targetSocioId) {
        matchedSheetsList.push({ block: block.name, type: 'DEUDAS PENDIENTES', sheetName });
      }
    });
  }

  console.log('Matched sheets for socio ID 113:', matchedSheetsList);
}

main().catch(console.error);
