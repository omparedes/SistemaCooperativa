/**
 * migracion_historica.cjs — Importador de Historial Financiero desde Excel
 * Cooperativa Primero de Mayo · SistemaCooperativa
 *
 * FLUJO:
 *   1. Lee socios/inquilinos/conceptos actuales desde Supabase (IDs reales).
 *   2. Parsea cada hoja kardex de los 6 archivos Excel.
 *   3. Hace fuzzy-match del nombre en la hoja con el padrón de la BD.
 *   4. Genera supabase/migrations/00029_historial_pagos_excel.sql
 *      con un DO block por persona que inserta cargos + pagos + detalles.
 *
 * EJECUTAR: node scripts/migracion_historica.cjs
 */
'use strict';
const XLSX  = require('xlsx');
const https = require('https');
const fs    = require('fs');
const path  = require('path');

// ─────────────────────────────────────────────────────────────────────────────
// CONFIGURACIÓN
// ─────────────────────────────────────────────────────────────────────────────
const PROJECT_REF  = 'sucnpjawtpattgkatqqn';
const ACCESS_TOKEN = 'sbp_79ceb3fff5213a0938192b5a91432061ace78db9';
const OUTPUT_SQL   = 'supabase/migrations/00029_historial_pagos_excel.sql';
const MIN_MATCH    = 0.55; // Umbral mínimo de similitud de nombre

const EXCEL_FILES = [
  'migracion_coop/1.DETALLE SOCIO A-C NV 4-11-2025 (1).xlsx',
  'migracion_coop/2.DETALLE SOCIO C-Q NV 4-11-2025 (2).xlsx',
  'migracion_coop/3.DETALLE SOCIO M-R 3 -9-2025 (3).xlsx',
  'migracion_coop/4.DETALLE SOCIO M-Z NV 4-11-2025 (2).xlsx',
  'migracion_coop/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH.xlsx',
  'migracion_coop/DETALLE DE DEUDA POR CADA INQUILINO N-Z -2023 - RUTH  27.09.xlsx',
];

// Mapeo: texto del Excel → nombre canónico en conceptos BD
const CONCEPT_NORM = {
  'LUZ': 'Luz', 'LUZ ': 'Luz',
  'AGUA': 'Agua', 'AGUA RESIDUAL': 'Agua',
  'G. ADM': 'Gastos administrativos', 'G.ADM': 'Gastos administrativos',
  'GAST. ADM': 'Gastos administrativos', 'G.A.': 'Gastos administrativos',
  'GASTOS ADM': 'Gastos administrativos', 'GASTOS ADMINISTRATIVOS': 'Gastos administrativos',
  'P. SOCIAL': 'Previsión social', 'P.SOCIAL': 'Previsión social',
  'PREV. SOCIAL': 'Previsión social', 'PREVISION SOCIAL': 'Previsión social',
  'PREVISION': 'Previsión social', 'P.S': 'Previsión social',
  'DEPOSITO': 'Aporte extraordinario', 'DEPÓSITO': 'Aporte extraordinario',
  'MULTA': 'Multa', 'MULTAS': 'Multa',
  'MULTA Y/O VARIOS': 'Multa', 'MULTA Y/O VARIOS ': 'Multa',
  'VARIOS': 'Multa', 'CORTE Y RECONEXION': 'Multa',
  'CAMBIO DE GIRO': 'Multa', 'CUOTA DE ACTIVIDAD': 'Multa',
  'PARRILLA': 'Multa', 'P.S.FALLEC.': 'Multa', 'P.S POR FALL.': 'Multa',
  'PS FALLECIDO': 'Multa',
  'MANTENIMIENTO': 'Mantenimiento',
  'ALQUILER': 'Alquiler',        // Concepto nuevo que se crea en el SQL
  'ALQUILER ': 'Alquiler',
};

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
  'DICIEMBRE': 12, 'DIC': 12,
};

// ─────────────────────────────────────────────────────────────────────────────
// API
// ─────────────────────────────────────────────────────────────────────────────
function apiQuery(sql) {
  return new Promise((resolve, reject) => {
    const body = JSON.stringify({ query: sql });
    const req  = https.request({
      hostname: 'api.supabase.com',
      path: `/v1/projects/${PROJECT_REF}/database/query`,
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${ACCESS_TOKEN}`,
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(body, 'utf8'),
      },
    }, res => {
      let data = '';
      res.on('data', c => data += c);
      res.on('end', () => {
        if (res.statusCode >= 200 && res.statusCode < 300) resolve(JSON.parse(data));
        else reject(new Error(`HTTP ${res.statusCode}: ${data.slice(0, 300)}`));
      });
    });
    req.on('error', reject);
    req.write(body, 'utf8');
    req.end();
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// HELPERS DE TEXTO Y FECHAS
// ─────────────────────────────────────────────────────────────────────────────
function norm(s) {
  return String(s ?? '')
    .normalize('NFD').replace(/[̀-ͯ]/g, '')
    .replace(/[^A-Z0-9 ]/gi, ' ')
    .replace(/\s+/g, ' ').trim().toUpperCase();
}

function levenshtein(a, b) {
  if (a === b) return 0;
  const m = a.length, n = b.length;
  if (m === 0) return n; if (n === 0) return m;
  const dp = Array.from({ length: m + 1 }, (_, i) =>
    Array.from({ length: n + 1 }, (_, j) => i === 0 ? j : j === 0 ? i : 0)
  );
  for (let i = 1; i <= m; i++)
    for (let j = 1; j <= n; j++)
      dp[i][j] = a[i-1] === b[j-1] ? dp[i-1][j-1]
        : 1 + Math.min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]);
  return dp[m][n];
}

function similarity(a, b) {
  const na = norm(a), nb = norm(b);
  const maxLen = Math.max(na.length, nb.length);
  if (maxLen === 0) return 1;
  return 1 - levenshtein(na, nb) / maxLen;
}

function parseNum(s) {
  const clean = String(s ?? '').replace(/[,]/g, '.').replace(/[^0-9.\-]/g, '');
  const n = parseFloat(clean);
  return isNaN(n) ? 0 : n;
}

// Fechas en formato M/D/YY (Excel US locale)
function parseDate(s) {
  const str = String(s ?? '').trim();
  if (!str) return null;
  const parts = str.split('/');
  if (parts.length !== 3) return null;
  const nums = parts.map(Number);
  if (nums.some(isNaN)) return null;
  let [p0, p1, p2] = nums;
  // Detect format: if p1 > 12, must be day → M/D/YY
  // If p0 > 12, must be day → D/M/YY
  let m, d;
  if (p1 > 12) { m = p0; d = p1; }       // M/D/YY
  else if (p0 > 12) { d = p0; m = p1; }  // D/M/YY
  else { m = p0; d = p1; }               // Assume M/D/YY (Excel default)
  const y = p2 < 100 ? (p2 < 50 ? 2000 + p2 : 1900 + p2) : p2;
  if (m < 1 || m > 12 || d < 1 || d > 31) return null;
  return new Date(y, m - 1, d);
}

function dateSql(d) {
  if (!d) return null;
  return `${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,'0')}-${String(d.getDate()).padStart(2,'0')}`;
}

function sq(s) { // SQL-safe string literal
  if (s === null || s === undefined) return 'NULL';
  return "'" + String(s).replace(/'/g, "''") + "'";
}

function resolveConcepto(rawConc, conceptoMap) {
  if (!rawConc) return null;
  const key = rawConc.trim().toUpperCase();
  // 1. Direct lookup in CONCEPT_NORM
  if (CONCEPT_NORM[key]) return conceptoMap.get(CONCEPT_NORM[key]) ?? null;
  // 2. Try normalized key
  const normKey = norm(key);
  for (const [alias, canonical] of Object.entries(CONCEPT_NORM)) {
    if (norm(alias) === normKey) return conceptoMap.get(canonical) ?? null;
  }
  // 3. Try partial match against canonical names
  for (const [name, id] of conceptoMap) {
    if (norm(name) === normKey) return id;
  }
  return null;
}

function getMetodoPago(doc) {
  const u = String(doc ?? '').toUpperCase();
  if (/TARJETA|CHEQUE|TRANSFERENCIA|TRANSF|YAPE|PLIN|BANCO/.test(u)) return 'Transferencia';
  return 'Efectivo';
}

// ─────────────────────────────────────────────────────────────────────────────
// PARSER DE KARDEX (una hoja Excel)
// ─────────────────────────────────────────────────────────────────────────────
function parseKardex(mat) {
  // Encontrar fila de cabeceras
  const hi = mat.findIndex(r =>
    r.some(c => /^FECHA$/i.test(String(c).trim())) &&
    r.some(c => /POR[\s_]?COBRAR/i.test(String(c).trim()))
  );
  if (hi < 0) return null; // No es hoja kardex

  // Índices de columnas
  const headers = mat[hi].map(c => norm(String(c)));
  const iF  = headers.findIndex(h => h === 'FECHA');
  const iD  = headers.findIndex(h => h === 'DOCUMENTO');
  const iP  = headers.findIndex(h => h === 'PERIODO');
  const iC  = headers.findIndex(h => h === 'CONCEPTO');
  const iCo = headers.findIndex(h => /POR.?COBRAR/.test(h));
  const iPa = headers.findIndex(h => /^PAGADO$/.test(h));
  const iSa = headers.findIndex(h => /SALDO/.test(h));
  if (iF < 0 || iD < 0) return null;

  // Nombre completo (buscar en las primeras filas, columna B típicamente)
  let fullName = '';
  for (let i = 0; i < Math.min(hi, 4); i++) {
    for (let j = 0; j < Math.min(mat[i].length, 6); j++) {
      const v = String(mat[i][j] ?? '').trim();
      if (v.length > fullName.length
        && v.length > 5
        && /[A-ZÁÉÍÓÚÑ]{3,}/i.test(v)
        && !/COOPERATIVA|RECIBO|PERIODO|FECHA|DEUDA|KARDEX/i.test(v)) {
        fullName = v;
      }
    }
  }

  const cargos = []; // {conc_key, anio, mes, monto, fecha_gen}
  const pagos  = []; // {fecha, doc, total, lineas:[{conc_key|null, anio, mes, monto}]}

  let curFecha = null, curAnio = null, curMes = null;
  let inCobrar = false;
  let curPago  = null; // pago group actual

  for (let r = hi + 1; r < mat.length; r++) {
    const row     = mat[r];
    const fecha   = iF >= 0  ? String(row[iF]  ?? '').trim() : '';
    const doc     = iD >= 0  ? String(row[iD]  ?? '').trim() : '';
    const per     = iP >= 0  ? String(row[iP]  ?? '').trim() : '';
    const conc    = iC >= 0  ? String(row[iC]  ?? '').trim() : '';
    const cobrar  = iCo >= 0 ? parseNum(row[iCo]) : 0;
    const pagado  = iPa >= 0 ? parseNum(row[iPa]) : 0;
    const saldo   = iSa >= 0 ? parseNum(row[iSa]) : 0;

    // Fila completamente vacía
    const isEmpty = !fecha && !doc && !per && !conc && cobrar === 0 && pagado === 0;
    if (isEmpty) continue;

    // Actualizar fecha/año contexto
    const parsedDate = fecha ? parseDate(fecha) : null;
    if (parsedDate) {
      curFecha = parsedDate;
      curAnio  = parsedDate.getFullYear();
    }

    // Actualizar mes contexto
    const perUp = per.toUpperCase().trim();
    const parsedMes = MESES[perUp] ?? null;
    if (parsedMes) curMes = parsedMes;

    // ── SALDO INICIAL ────────────────────────────────────────────────────────
    if (/^SALDO\s+AL\s*/i.test(doc) || /^SALDO\s+ANTERIOR/i.test(doc)) {
      const montoSaldo = saldo > 0 ? saldo : cobrar > 0 ? cobrar : 0;
      if (montoSaldo > 0) {
        const mYear = parseInt((doc.match(/(\d{4})/) || [])[1] ?? curAnio ?? 2016);
        cargos.push({ conc_key: 'Deuda anterior', anio: mYear, mes: 12, monto: montoSaldo,
          fecha_gen: dateSql(curFecha) || `${mYear + 1}-01-01`, is_saldo: true });
      }
      inCobrar = false; curPago = null;
      continue;
    }

    // ── POR COBRAR (cargo) ───────────────────────────────────────────────────
    if (/^POR\s*COBRAR$/i.test(doc)) {
      inCobrar = true;
      curPago  = null;
      if (cobrar > 0 && conc) {
        cargos.push({ conc_key: conc, anio: curAnio, mes: curMes ?? 1,
          monto: cobrar, fecha_gen: dateSql(curFecha) });
      }
      continue;
    }

    // ── Sub-fila de cargo (FECHA y DOC vacíos, inCobrar activo) ─────────────
    if (!fecha && !doc && inCobrar && cobrar > 0 && conc) {
      cargos.push({ conc_key: conc, anio: curAnio, mes: curMes ?? 1,
        monto: cobrar, fecha_gen: dateSql(curFecha) });
      continue;
    }

    // ── PAGO ─────────────────────────────────────────────────────────────────
    if (pagado > 0 && doc && !/^POR\s*COBRAR$/i.test(doc) && !/^SALDO/i.test(doc)) {
      inCobrar = false;

      // Agrupar pagos por (fecha, doc)
      const groupKey = `${dateSql(curFecha)}||${doc}`;
      if (!curPago || curPago._key !== groupKey) {
        curPago = { _key: groupKey, fecha: curFecha, doc, lineas: [] };
        pagos.push(curPago);
      }
      curPago.lineas.push({
        conc_key: conc || null,
        anio: (parsedMes && curAnio) ? curAnio : null,
        mes:  parsedMes ?? null,
        monto: pagado,
        periodo_raw: per,
      });
    }
  }

  return { fullName: fullName.trim(), cargos, pagos };
}

// ─────────────────────────────────────────────────────────────────────────────
// GENERADOR SQL POR PERSONA
// ─────────────────────────────────────────────────────────────────────────────
let blockId = 0;

function buildPersonSQL(info, conceptoMap) {
  const { tipo, id, puestoId, fullName, archivo, cargos, pagos } = info;
  blockId++;
  const bid = blockId;
  const pf  = tipo === 'socio' ? 'socio_id' : 'inquilino_id';

  if (!puestoId) return `-- ⚠ Sin puesto: ${fullName} (${tipo}_id=${id})\n`;

  const lines = [];
  lines.push(`-- [${'─'.repeat(56)}]`);
  lines.push(`-- [${bid}] ${tipo.toUpperCase()}: ${fullName}`);
  lines.push(`-- ${tipo}_id=${id}  puesto_id=${puestoId}  cargos=${cargos.length}  pagos=${pagos.length}`);
  lines.push(`-- fuente: ${path.basename(archivo)}`);
  lines.push(`DO $b${bid}$ DECLARE v bigint; BEGIN`);

  // ── INSERT cargos ─────────────────────────────────────────────────────────
  const chargeKeys = new Set();
  for (const c of cargos) {
    const cid = resolveConcepto(c.conc_key, conceptoMap);
    if (!cid || !c.anio || !c.mes || c.monto <= 0) continue;
    const key = `${cid}|${c.anio}|${c.mes}`;
    if (chargeKeys.has(key)) continue;
    chargeKeys.add(key);
    const fgen = c.fecha_gen || `${c.anio}-${String(c.mes).padStart(2,'0')}-01`;
    const obs  = c.is_saldo ? sq('Saldo histórico migrado') : sq('Importado Excel histórico');
    lines.push(
      `INSERT INTO public.montos_por_cobrar(puesto_id,concepto_id,periodo_anio,periodo_mes,` +
      `monto,estado,metodo_calculo,fecha_generacion,observacion)` +
      `VALUES(${puestoId},${cid},${c.anio},${c.mes},${c.monto.toFixed(2)},` +
      `'Pendiente','Manual',${sq(fgen)},${obs})` +
      `ON CONFLICT(puesto_id,concepto_id,periodo_anio,periodo_mes)` +
      `WHERE deleted_at IS NULL AND puesto_id IS NOT NULL DO NOTHING;`
    );
  }

  // ── INSERT pagos + detalle ────────────────────────────────────────────────
  for (const pg of pagos) {
    const total = pg.lineas.reduce((s, l) => s + l.monto, 0);
    if (total <= 0 || !pg.fecha) continue;

    const fechaStr = dateSql(pg.fecha);
    if (!fechaStr) continue;

    const metodo = getMetodoPago(pg.doc);
    // Comprobante: guardar el número de recibo si parece un número, sino null
    const comp   = /^\d+$/.test(pg.doc.trim()) ? pg.doc.trim() : null;

    lines.push(
      `INSERT INTO public.pagos(puesto_id,${pf},monto_total,metodo_pago,comprobante,` +
      `fecha_pago,observacion)` +
      `VALUES(${puestoId},${id},${total.toFixed(2)},${sq(metodo)},${sq(comp)},` +
      `${sq(fechaStr)},'Importado Excel histórico')RETURNING id INTO v;`
    );

    for (const linea of pg.lineas) {
      if (linea.monto <= 0) continue;
      let selectClause;
      const cid = linea.conc_key ? resolveConcepto(linea.conc_key, conceptoMap) : null;
      if (cid && linea.anio && linea.mes) {
        // Pago específico a (concepto, anio, mes)
        selectClause =
          `SELECT v,id,${linea.monto.toFixed(2)} ` +
          `FROM public.montos_por_cobrar ` +
          `WHERE puesto_id=${puestoId} AND concepto_id=${cid} ` +
          `AND periodo_anio=${linea.anio} AND periodo_mes=${linea.mes} ` +
          `AND deleted_at IS NULL LIMIT 1`;
      } else {
        // FIFO: pago al deuda más antigua pendiente
        selectClause =
          `SELECT v,id,${linea.monto.toFixed(2)} ` +
          `FROM public.montos_por_cobrar ` +
          `WHERE puesto_id=${puestoId} AND deleted_at IS NULL ` +
          `ORDER BY periodo_anio ASC,periodo_mes ASC LIMIT 1`;
      }
      lines.push(
        `IF v IS NOT NULL THEN ` +
        `INSERT INTO public.detalle_pagos(pago_id,monto_id,monto_aplicado)` +
        `${selectClause};END IF;`
      );
    }
  }

  // ── Marcar montos pagados ─────────────────────────────────────────────────
  if (cargos.length > 0) {
    lines.push(
      `UPDATE public.montos_por_cobrar SET estado='Pagado' ` +
      `WHERE puesto_id=${puestoId} AND deleted_at IS NULL ` +
      `AND (SELECT COALESCE(SUM(dp.monto_aplicado),0) ` +
      `FROM public.detalle_pagos dp JOIN public.pagos pg ON pg.id=dp.pago_id ` +
      `WHERE dp.monto_id=montos_por_cobrar.id AND dp.deleted_at IS NULL ` +
      `AND pg.deleted_at IS NULL)>=monto;`
    );
  }

  lines.push(
    `EXCEPTION WHEN OTHERS THEN RAISE WARNING 'Error b${bid} ${fullName.replace(/'/g, "''")}:%',SQLERRM;` +
    `END;$b${bid}$;`
  );
  lines.push('');
  return lines.join('\n');
}

// ─────────────────────────────────────────────────────────────────────────────
// MAIN
// ─────────────────────────────────────────────────────────────────────────────
async function main() {
  console.log('\n══════════════════════════════════════════════════════');
  console.log('  Migración Histórica — Cooperativa Primero de Mayo');
  console.log('══════════════════════════════════════════════════════\n');

  // ── Paso 1: Cargar IDs desde Supabase ─────────────────────────────────────
  process.stdout.write('Paso 1: Leyendo padrón desde Supabase... ');
  const [socRows, inqRows, concRows] = await Promise.all([
    apiQuery(`SELECT s.id,s.apellidos,ht.puesto_id FROM public.socios s LEFT JOIN public.historial_titularidad ht ON ht.socio_id=s.id AND ht.fecha_fin IS NULL WHERE s.deleted_at IS NULL`),
    apiQuery(`SELECT i.id,i.apellidos,ha.puesto_id FROM public.inquilinos i LEFT JOIN public.historial_arriendos ha ON ha.inquilino_id=i.id AND ha.fecha_fin IS NULL WHERE i.deleted_at IS NULL`),
    apiQuery(`SELECT id,nombre FROM public.conceptos WHERE deleted_at IS NULL`),
  ]);

  const allPersonas = [
    ...socRows.map(r => ({ tipo: 'socio',     id: Number(r.id), nombre: r.apellidos, puestoId: r.puesto_id ? Number(r.puesto_id) : null })),
    ...inqRows.map(r => ({ tipo: 'inquilino', id: Number(r.id), nombre: r.apellidos, puestoId: r.puesto_id ? Number(r.puesto_id) : null })),
  ];

  // Mapa nombre canonico → id de concepto
  const conceptoMap = new Map(concRows.map(r => [r.nombre, Number(r.id)]));
  // Agregar aliases normalizados
  for (const [alias, canonical] of Object.entries(CONCEPT_NORM)) {
    const cid = conceptoMap.get(canonical);
    if (cid && !conceptoMap.has(alias)) conceptoMap.set(alias, cid);
  }

  console.log(`OK (${allPersonas.length} personas, ${conceptoMap.size} conceptos)`);

  // Función de matching
  function matchPerson(name) {
    if (!name || name.length < 4) return null;
    let best = null, bestScore = MIN_MATCH;
    for (const p of allPersonas) {
      const s = similarity(name, p.nombre);
      if (s > bestScore) { bestScore = s; best = p; }
    }
    return best;
  }

  // ── Paso 2: Procesar Excel ────────────────────────────────────────────────
  console.log('\nPaso 2: Procesando archivos Excel...');

  const sqlBlocks = [];
  let matched = 0, unmatched = 0, totalSheets = 0;
  const unmatchedLog = [];
  const matchedLog   = [];

  // Necesitamos "Alquiler" en el mapa aunque no esté en BD aún
  // Se inserta en el header del SQL y el mapa se actualiza con ID placeholder
  // (se resuelve en tiempo de ejecución del SQL)
  let hasAlquiler = false;

  for (const archivo of EXCEL_FILES) {
    if (!fs.existsSync(archivo)) {
      console.log(`  ⚠ No encontrado: ${archivo}`);
      continue;
    }
    const wb = XLSX.readFile(archivo, { raw: false, cellDates: false });
    console.log(`  📂 ${path.basename(archivo)} (${wb.SheetNames.length} hojas)`);

    for (const sheetName of wb.SheetNames) {
      const ws = wb.Sheets[sheetName];
      const mat = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '', raw: false });
      const parsed = parseKardex(mat);
      if (!parsed) continue; // Hoja resumen

      totalSheets++;
      const { fullName, cargos, pagos } = parsed;

      // Detectar si se usa concepto Alquiler
      if (cargos.some(c => /ALQUILER/i.test(c.conc_key))) hasAlquiler = true;

      // Matching
      const person = matchPerson(fullName) || matchPerson(sheetName);

      if (!person) {
        unmatched++;
        unmatchedLog.push({ sheetName, fullName, archivo });
        continue;
      }

      matched++;
      matchedLog.push({ sheetName, fullName, person: person.nombre, score: similarity(fullName, person.nombre).toFixed(2) });

      sqlBlocks.push(buildPersonSQL({
        tipo: person.tipo, id: person.id, puestoId: person.puestoId,
        fullName, archivo, cargos, pagos,
      }, conceptoMap));
    }
  }

  console.log(`\n  Hojas kardex procesadas: ${totalSheets}`);
  console.log(`  Matched:   ${matched}`);
  console.log(`  Sin match: ${unmatched}`);

  if (unmatchedLog.length > 0) {
    console.log('\n  ⚠ Hojas sin match de persona (revisar manualmente):');
    unmatchedLog.forEach(u =>
      console.log(`    "${u.fullName}" / hoja "${u.sheetName}" / ${path.basename(u.archivo)}`)
    );
  }

  // ── Paso 3: Generar SQL ───────────────────────────────────────────────────
  console.log('\nPaso 3: Escribiendo SQL...');

  const now = new Date().toISOString().slice(0, 10);
  const header = `-- ${'='.repeat(77)}
-- Migración 00029 — Historial Financiero importado desde Excel
-- Cooperativa Primero de Mayo · Generado: ${now}
-- Hojas procesadas: ${matched} | Sin match: ${unmatched} | Bloques DO: ${blockId}
--
-- CÓMO APLICAR:
--   Opción A: Supabase Studio → SQL Editor → Ejecutar (puede tardar varios minutos)
--   Opción B: node scripts/aplicar_historial.cjs
--
-- Cada DO block es atómico e independiente.
-- Un error en una persona imprime RAISE WARNING y continúa con la siguiente.
-- ${'='.repeat(77)}

-- Asegurar que el concepto "Alquiler" (para inquilinos) existe
${hasAlquiler ? `INSERT INTO public.conceptos(nombre,tipo,activo,descripcion)\nVALUES('Alquiler','Fijo',true,'Arriendo mensual pagado por inquilinos')\nON CONFLICT(nombre) DO NOTHING;\n` : '-- (concepto Alquiler no detectado en los Excels)'}
`;

  const footer = `
-- ${'─'.repeat(77)}
-- Actualización global: marcar montos 100% cubiertos como Pagado
UPDATE public.montos_por_cobrar SET estado='Pagado'
WHERE deleted_at IS NULL AND estado='Pendiente'
AND (
  SELECT COALESCE(SUM(dp.monto_aplicado),0)
  FROM public.detalle_pagos dp JOIN public.pagos pg ON pg.id=dp.pago_id
  WHERE dp.monto_id=montos_por_cobrar.id AND dp.deleted_at IS NULL AND pg.deleted_at IS NULL
) >= monto;

-- Reporte final
SELECT
  (SELECT count(*) FROM public.montos_por_cobrar WHERE deleted_at IS NULL)      AS montos_total,
  (SELECT count(*) FROM public.montos_por_cobrar WHERE deleted_at IS NULL AND estado='Pagado')   AS montos_pagados,
  (SELECT count(*) FROM public.montos_por_cobrar WHERE deleted_at IS NULL AND estado='Pendiente') AS montos_pendientes,
  (SELECT count(*) FROM public.pagos          WHERE deleted_at IS NULL)          AS pagos_total,
  (SELECT count(*) FROM public.detalle_pagos  WHERE deleted_at IS NULL)          AS detalles_total,
  (SELECT round(sum(monto),2) FROM public.montos_por_cobrar WHERE deleted_at IS NULL)      AS deuda_historica_total,
  (SELECT round(sum(monto_total),2) FROM public.pagos WHERE deleted_at IS NULL)            AS cobrado_historico_total;
`;

  const sqlContent = header + sqlBlocks.join('\n') + footer;
  fs.writeFileSync(OUTPUT_SQL, sqlContent, 'utf8');

  const mb = (Buffer.byteLength(sqlContent, 'utf8') / (1024 * 1024)).toFixed(2);
  console.log(`\n✅ Generado: ${OUTPUT_SQL}`);
  console.log(`   Tamaño: ${mb} MB`);
  console.log(`   Bloques DO: ${blockId} personas`);

  // ── Guardar log de matching ───────────────────────────────────────────────
  const logPath = 'supabase/migrations/00029_matching_log.txt';
  const logLines = [
    `Matching log — ${now}`,
    `Total: ${totalSheets} | Matched: ${matched} | Sin match: ${unmatched}`,
    '',
    'MATCHED:',
    ...matchedLog.map(m => `  [${m.score}] Excel:"${m.fullName}" → BD:"${m.person}"`),
    '',
    'SIN MATCH:',
    ...unmatchedLog.map(u => `  Excel:"${u.fullName}" / hoja:"${u.sheetName}"`),
  ];
  fs.writeFileSync(logPath, logLines.join('\n'), 'utf8');
  console.log(`   Log de matching: ${logPath}`);

  console.log('\nPara aplicar el SQL:');
  console.log('  node scripts/aplicar_historial.cjs');
  console.log('  (o pegar en Supabase Studio → SQL Editor)');
}

main().catch(e => { console.error('Error fatal:', e.message); process.exit(1); });
