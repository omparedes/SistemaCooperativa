const XLSX = require('xlsx');

const soloFile = 'migracion_coop/2026/3.DETALLE SOCIO M-R 3 -9-2025 - SOLO 2026.xlsx';
const deudasFile = 'migracion_coop/2026/3.DETALLE SOCIO M-R 3 -9-2025 - DEUDAS PENDIENTES.xlsx';

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
  'LUZ': 'Luz', 'AGUA': 'Agua', 'G. ADM': 'Gastos administrativos', 'P. SOCIAL': 'Previsión social'
};

function excelDateToJS(excelDate) {
  if (!excelDate) return null;
  if (excelDate instanceof Date) return excelDate;
  if (isNaN(excelDate)) return new Date(excelDate);
  const date = new Date((excelDate - 25569) * 86400 * 1000);
  const userTimezoneOffset = date.getTimezoneOffset() * 60000;
  return new Date(date.getTime() + userTimezoneOffset);
}

function trace() {
  const wbSolo = XLSX.readFile(soloFile, { cellDates: true });
  const wbDeudas = XLSX.readFile(deudasFile, { cellDates: true });
  
  const rawCharges = [];
  
  // SOLO 2026
  const wsSolo = wbSolo.Sheets['PAREDES FLORES OSCAR'];
  const rowsSolo = XLSX.utils.sheet_to_json(wsSolo, { header: 1, defval: '' });
  rowsSolo.forEach((r, idx) => {
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
    
    const cId = CONCEPTOS_BD[conceptoRaw.toUpperCase().trim()] || 'Otros';
    rawCharges.push({ source: 'SOLO 2026', line: idx+1, periodYear, periodMonth, concept: cId, monto });
  });

  // DEUDAS PENDIENTES
  const wsDeudas = wbDeudas.Sheets['PAREDES FLORES OSCAR'];
  const rowsDeudas = XLSX.utils.sheet_to_json(wsDeudas, { header: 1, defval: '' });
  rowsDeudas.forEach((r, idx) => {
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
    const cId = CONCEPTOS_BD[conceptoRaw.toUpperCase().trim()] || 'Otros';
    
    rawCharges.push({ source: 'DEUDAS PENDIENTES', line: idx+1, periodYear, periodMonth, concept: cId, monto });
  });

  console.log('--- ALL RAW CHARGES ---');
  rawCharges.forEach(c => console.log(c));
  
  console.log('\n--- GROUPED CHARGES ---');
  const grouped = {};
  rawCharges.forEach(c => {
    const key = `${c.concept}_${c.periodYear}_${c.periodMonth}`;
    if (!grouped[key]) grouped[key] = { concept: c.concept, year: c.periodYear, month: c.periodMonth, monto: 0, items: [] };
    grouped[key].monto += c.monto;
    grouped[key].items.push(`${c.source}(L${c.line}): ${c.monto}`);
  });
  
  Object.values(grouped).forEach(g => {
    console.log(`${g.concept} ${g.year}-${g.month} Total: ${g.monto} | Sources: [${g.items.join(', ')}]`);
  });
}

trace();
