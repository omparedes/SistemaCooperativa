const XLSX = require('xlsx');

const BLOCKS = [
  {
    name: 'M-R',
    solo2026: 'migracion_coop/2026/3.DETALLE SOCIO M-R 3 -9-2025 - SOLO 2026.xlsx',
    deudas: 'migracion_coop/2026/3.DETALLE SOCIO M-R 3 -9-2025 - DEUDAS PENDIENTES.xlsx'
  }
];

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

// Mimic the main script logic for Socio 113
const dbSocios = [
  { id: 113, nombres: 'OSCAR ALFREDO', apellidos: 'PAREDES FLORES', DNI: '08411083' }
];

function findSocio(sheetName) {
  const normSheet = normalizar(sheetName);
  if (!normSheet || normSheet === 'RESUMEN' || normSheet === 'PLANTILLA') return null;
  let match = dbSocios.find(s => {
    const dbNorm = normalizar(`${s.apellidos} ${s.nombres}`);
    const dbNormRev = normalizar(`${s.nombres} ${s.apellidos}`);
    return dbNorm === normSheet || dbNormRev === normSheet || dbNorm.includes(normSheet) || dbNormRev.includes(normSheet) || normSheet.includes(dbNorm);
  });
  return match;
}

BLOCKS.forEach(block => {
  const wbSolo = XLSX.readFile(block.solo2026, { cellDates: true });
  const wbDeudas = XLSX.readFile(block.deudas, { cellDates: true });

  const entry = {
    socio: dbSocios[0],
    rawCharges: [],
    rawPayments: []
  };

  // 1. SOLO 2026
  wbSolo.SheetNames.forEach(sheetName => {
    const socio = findSocio(sheetName);
    if (!socio) return;
    console.log(`Matched sheet in SOLO 2026: "${sheetName}"`);
    const ws = wbSolo.Sheets[sheetName];
    const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
    rows.forEach((r, idx) => {
      if (r.length < 6 || !r[0]) return;
      const fecha = excelDateToJS(r[0]);
      if (!fecha || isNaN(fecha.getTime())) return;
      const comprobante = String(r[1] || '').trim();
      const periodoStr = String(r[2] || '').trim().toUpperCase();
      const conceptoRaw = String(r[3] || '').trim();
      const monto = parseFloat(r[5]);
      if (isNaN(monto) || monto <= 0 || !MESES[periodoStr]) return;

      const payMonth = fecha.getMonth() + 1;
      const payYear = fecha.getFullYear();
      const periodMonth = MESES[periodoStr];
      const periodYear = (periodMonth > payMonth) ? (payYear - 1) : payYear;

      let normalizedConcept = CONCEPTOS_BD[conceptoRaw.toUpperCase().trim()] || 'Otros';
      if (conceptoRaw.toUpperCase().trim() === 'G. ADM' && monto === 5.00) {
        normalizedConcept = 'Previsión social';
      }

      console.log(`SOLO 2026 L${idx+1}: Period ${periodYear}-${periodMonth}, Concept ${normalizedConcept}, Amount ${monto}`);

      entry.rawCharges.push({ anio: periodYear, mes: periodMonth, concepto: normalizedConcept, monto, conceptoRaw });
    });
  });

  // 2. DEUDAS PENDIENTES
  wbDeudas.SheetNames.forEach(sheetName => {
    const socio = findSocio(sheetName);
    if (!socio) return;
    console.log(`Matched sheet in DEUDAS PENDIENTES: "${sheetName}"`);
    const ws = wbDeudas.Sheets[sheetName];
    const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });
    rows.forEach((r, idx) => {
      if (r.length < 5 || !r[0]) return;
      const fecha = excelDateToJS(r[0]);
      if (!fecha || isNaN(fecha.getTime())) return;
      const tipo = String(r[1] || '').trim().toUpperCase();
      const periodoStr = String(r[2] || '').trim().toUpperCase();
      const conceptoRaw = String(r[3] || '').trim();
      const monto = parseFloat(r[4]);
      if (tipo !== 'POR COBRAR' || isNaN(monto) || monto <= 0 || !MESES[periodoStr]) return;

      const periodYear = fecha.getFullYear();
      const periodMonth = MESES[periodoStr];

      let normalizedConcept = CONCEPTOS_BD[conceptoRaw.toUpperCase().trim()] || 'Otros';
      if (conceptoRaw.toUpperCase().trim() === 'G. ADM' && monto === 5.00) {
        normalizedConcept = 'Previsión social';
      }

      console.log(`DEUDAS L${idx+1}: Period ${periodYear}-${periodMonth}, Concept ${normalizedConcept}, Amount ${monto}`);

      entry.rawCharges.push({ anio: periodYear, mes: periodMonth, concepto: normalizedConcept, monto, conceptoRaw });
    });
  });

  console.log('\n--- Grouping ---');
  const chargesMap = {};
  entry.rawCharges.forEach(c => {
    const key = `${c.concepto}_${c.anio}_${c.mes}`;
    if (!chargesMap[key]) {
      chargesMap[key] = { concepto: c.concepto, anio: c.anio, mes: c.mes, monto: 0 };
    }
    chargesMap[key].monto += c.monto;
  });
  console.log(chargesMap);
});
