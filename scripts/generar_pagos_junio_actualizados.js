/**
 * generar_pagos_1_8_julio_2026.js
 *
 * Lee "migracion_coop/julio/SOCIOS - CONSOLIDADO PAGOS 01-08 JULIO 2026.xlsx"
 * (hoja 'Detalle pagos') y genera supabase/migrations/00089_cargar_pagos_1_8_julio_2026.sql
 *
 * Mismo algoritmo que scripts/generar_pagos_16_30_junio_2026.js (migración 00077):
 *   1. Empata el socio en public.socios.
 *   2. Resuelve el puesto_id (puesto principal o almacén según concepto).
 *   3. Busca en montos_por_cobrar la deuda pendiente que corresponde a:
 *        puesto_id + concepto_id + periodo_mes + periodo_anio (no Cancelado)
 *   4. Agrupa todos los conceptos del mismo socio pagados el mismo día → 1 pago (cabecera).
 *   5. Pago total (monto_pagado >= deuda.monto): marca la deuda como 'Cancelado'.
 *      Pago parcial: inserta detalle_pago con el monto parcial (deuda queda Pendiente).
 *
 * Particularidades de este lote (01-08 julio 2026):
 *   - "DEPOSITO N° 8-3ER PISO MM/YYYY": formato legado que embebe el período en el propio
 *     concepto (no en la columna "Periodo", que aquí es solo la fecha de agrupación del
 *     recibo). Se resuelve al almacén "8-D3" (id fijo, confirmado contra BD) con el
 *     periodo tomado del sufijo MM/YYYY.
 *   - "MULTA ..." → concepto "Multa" (antes cuando este concepto no existía cayeron a
 *     "Otros"; ya existe en BD y se usa directamente).
 *   - "P" / "p. SOCIAL" → variantes de "P. SOCIAL" (Previsión social).
 *   - "P.S X FALL. FLORES FLORES UMBELINA" → concepto "Fallecimiento de socio".
 *   - "CAMBIO DE GIRO PROVISIONAL", "FUMIGACION" → sin concepto propio en BD, van a "Otros".
 *   - GARCIA LUCIA / TENORIO ALBERTINA: confirmado contra BD que NO existen en `socios`
 *     (alta de padrón pendiente, igual que en junio) → excluidas explícitamente.
 *
 * Uso: node scripts/generar_pagos_1_8_julio_2026.js
 */
'use strict';
const fs = require('fs');
const path = require('path');
const XLSX = require('xlsx');
const { createClient } = require('@supabase/supabase-js');

const EXCEL_PATH = 'migracion_coop/julio/SOCIOS - CONSOLIDADO PAGOS JUNIO 2026 ACTUALIZADO.xlsx';
const SHEET_NAME = 'Detalle pagos';
const OUTPUT_SQL = 'supabase/migrations/00090_correccion_pagos_junio.sql';

// ─── Carga de .env ──────────────────────────────────────────────────────────
const envFile = fs.readFileSync('.env', 'utf8');
const envVars = {};
envFile.split('\n').forEach((line) => {
  const m = line.match(/^\s*([^#=\s]+)\s*=\s*(.*)\s*$/);
  if (m) {
    let val = m[2].trim();
    if (val.startsWith('"') && val.endsWith('"')) val = val.slice(1, -1);
    if (val.startsWith("'") && val.endsWith("'")) val = val.slice(1, -1);
    envVars[m[1]] = val;
  }
});
const supabase = createClient(envVars.SUPABASE_URL, envVars.SUPABASE_SERVICE_ROLE_KEY);

// PostgREST limita cada respuesta a 1000 filas por defecto (ver CLAUDE.md §5.2).
// montos_por_cobrar tiene miles de filas — hay que paginar con .range() o se
// pierden silenciosamente las deudas fuera de las primeras 1000.
async function fetchAllPaginado(query) {
  const PAGE = 1000;
  let desde = 0;
  let todas = [];
  for (;;) {
    const { data, error } = await query.range(desde, desde + PAGE - 1);
    if (error) throw error;
    todas = todas.concat(data);
    if (data.length < PAGE) break;
    desde += PAGE;
  }
  return todas;
}

// ─── Mapeo manual: nombre normalizado → id de socio ─────────────────────────
const MANUAL_MAP = {
  // Alias de la carga histrica
  "MAYHUASCA CLUDY": 90,
  "DE LA CRUZ FLAVIA": 56, // DE LA CRUZ RAMOS FLAVIA
  "CHALLCO NICOLAZA": 44, // CHALLCO ACARDE NICOLASA
  "CRUZ LUIS": 48, // CRUZ JARAMILLO LUIS (asumiendo 48, si no es as, se ajusta)
  "DELA CRUZ JOSE": 55, // DE LA CRUZ ESTEBAN JOSE LUIS
  "PRADO ZOZIMA": 121, // PRADO LLANCARI ZOSIMA
};

// Socios excluidos: confirmado contra BD (2026-07-08) que no existen en `socios`.
const EXCLUIR_SOCIOS = {
  'GARCIA LUCIA': 'Socia nueva sin alta de padrón confirmada (igual que en la migración de junio 2026).',
  'TENORIO ALBERTINA': 'Nueva socia en reemplazo — sin alta confirmada en padrón (no existe en public.socios).',
};

// ─── Mapa de meses en español ────────────────────────────────────────────────
const MES_MAP = {
  ENERO: 1, FEBRERO: 2, MARZO: 3, ABRIL: 4, MAYO: 5, JUNIO: 6,
  JULIO: 7, AGOSTO: 8, SETIEMBRE: 9, SEPTIEMBRE: 9, OCTUBRE: 10, NOVIEMBRE: 11, DICIEMBRE: 12,
};

// Filas con celda "Periodo" vacía en el Excel: el mes se infiere de la fila
// vecina con el mismo Documento (misma secuencia mensual). Índice = posición
// 0-based de la fila de datos (excluyendo cabecera), verificado manualmente
// contra el archivo fuente (confirmado con Documento + Concepto adjuntos).
const PERIODO_FIX_POR_INDICE = {
  194: 'JUNIO',   // CARRASCO FELICITA doc 33558, G. ADM   (sigue a MARZO/ABRIL/MAYO)
  195: 'JUNIO',   // CARRASCO FELICITA doc 33558, P. SOCIAL
  487: 'MARZO',   // PALOMINO SILVIO doc 33521, G. ADM      (precede a ABRIL/MAYO)
  488: 'MARZO',   // PALOMINO SILVIO doc 33521, P. SOCIAL
  489: 'MARZO',   // PALOMINO SILVIO doc 33521, DEPOSITO 4 - D2
  673: 'JUNIO',   // SANCHEZ JUDITH doc 33463, P. SOCIAL    (pareja de la fila JUNIO/G. ADM anterior)
};

// ─── Utilidades ──────────────────────────────────────────────────────────────
function normalize(s) {
  return String(s).normalize('NFD').replace(/[̀-ͯ]/g, '')
    .toUpperCase().replace(/[^A-Z0-9\s]/g, ' ').replace(/\s+/g, ' ').trim();
}

function esc(s) {
  return "'" + String(s).replace(/'/g, "''") + "'";
}

function excelDateToISO(serial) {
  if (!serial) return null;
  if (serial instanceof Date) return serial.toISOString().slice(0, 10);
  if (!isNaN(serial)) {
    const d = new Date((Number(serial) - 25569) * 86400 * 1000);
    return d.toISOString().slice(0, 10);
  }
  return null;
}

// Parsea "DEPOSITO X - DY" → { num: 'X', piso: Y } o null
function parsearDeposito(concepto) {
  const m = String(concepto).trim().match(/^DEPOSITO\s+(\d+)\s*-\s*D(\d)$/i);
  if (!m) return null;
  return { num: m[1], piso: parseInt(m[2], 10) };
}

// Parsea "DEPOSITO N° 8-3ER PISO MM/YYYY" (formato legado) → { mes, anio } o null
function parsearDepositoLegado(concepto) {
  const m = String(concepto).trim().match(/^DEPOSITO\s+N.?\s*8-3ER PISO\s+(\d{2})\/(\d{4})$/i);
  if (!m) return null;
  return { periodo_mes: parseInt(m[1], 10), periodo_anio: parseInt(m[2], 10) };
}

// ─── Empate de socios ────────────────────────────────────────────────────────
function construirIndice(socios) {
  return socios.map(s => ({
    ...s,
    apellidosNorm: normalize(s.apellidos),
    tokens: new Set(normalize(s.apellidos).split(' ').filter(t => t.length >= 2)),
  }));
}

function empatarSocio(nombre, indice) {
  const norm = normalize(nombre);
  if (MANUAL_MAP[norm] !== undefined) {
    const id = MANUAL_MAP[norm];
    const s = indice.find(x => x.id === id);
    if (s) return { socio: s, metodo: 'manual' };
  }
  const exacto = indice.find(s => s.apellidosNorm === norm);
  if (exacto) return { socio: exacto, metodo: 'exacto' };
  const tokensExcel = norm.split(' ').filter(t => t.length >= 2);
  const candidatos = indice.filter(s => tokensExcel.every(t => s.tokens.has(t)));
  if (candidatos.length === 1) return { socio: candidatos[0], metodo: 'subset' };
  if (candidatos.length > 1) return { socio: null, metodo: 'ambiguo', candidatos };
  return { socio: null, metodo: 'sin_match' };
}

// ─── Main ─────────────────────────────────────────────────────────────────────
async function main() {
  console.log('Leyendo Excel:', EXCEL_PATH);
  const wb = XLSX.readFile(EXCEL_PATH, { raw: false });
  const ws = wb.Sheets[SHEET_NAME];
  if (!ws) throw new Error(`Hoja "${SHEET_NAME}" no encontrada. Disponibles: ${wb.SheetNames.join(', ')}`);
  const allRowsRaw = XLSX.utils.sheet_to_json(ws, { defval: '' });
  const allRows = allRowsRaw.map((r, i) => ({ ...r, __idx: i }));
  const rows = allRows.filter(r => Number(r['Monto pagado']) > 0);
  console.log(`Filas leídas: ${allRows.length} | Con monto > 0: ${rows.length}`);

  console.log('Descargando datos de BD...');
  const [
    { data: socios, error: e1 },
    { data: historial, error: e2 },
    { data: puestos, error: e3 },
    { data: ocupaciones, error: e4 },
    { data: conceptos, error: e5 },
  ] = await Promise.all([
    supabase.from('socios').select('id, apellidos, nombres, dni').is('deleted_at', null),
    supabase.from('historial_titularidad').select('socio_id, puesto_id').is('fecha_fin', null),
    supabase.from('puestos').select('id, codigo_puesto, tipo_espacio'),
    supabase.from('ocupaciones_almacenes').select('socio_id, puesto_id').is('fecha_fin', null),
    supabase.from('conceptos').select('id, nombre'),
  ]);
  for (const e of [e1, e2, e3, e4, e5]) if (e) throw e;

  // montos_por_cobrar: miles de filas → paginado explícito (ver fetchAllPaginado)
  const deudas = await fetchAllPaginado(
    supabase.from('montos_por_cobrar')
      .select(`
        id, puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado,
        detalle_pagos ( monto_aplicado, deleted_at )
      `)
      .not('estado', 'eq', 'Cancelado')
      .is('deleted_at', null)
      .order('id')
  );
  console.log(`montos_por_cobrar (no Cancelado, paginado): ${deudas.length} filas`);

  const tipoEspacioPorPuesto = new Map(puestos.map(p => [p.id, p.tipo_espacio]));
  const codigoPorPuesto = new Map(puestos.map(p => [p.id, p.codigo_puesto]));

  // Mapas de concepto nombre → id
  const cIdPorNombre = new Map(conceptos.map(c => [c.nombre, c.id]));
  const requeridos = ['Gastos administrativos', 'Previsión social', 'Luz', 'Agua', 'Deposito', 'Otros', 'Multa', 'Fallecimiento de socio'];
  for (const n of requeridos) {
    if (!cIdPorNombre.has(n)) throw new Error(`Concepto "${n}" no encontrado en BD`);
  }

  // Almacén legado "8-3ER PISO" → confirmado contra BD como puesto "8-D3"
  const puesto8D3 = puestos.find(p => p.codigo_puesto === '8-D3' && p.tipo_espacio === 'Almacen');
  if (!puesto8D3) throw new Error('No se encontró el almacén "8-D3" en BD (requerido para "DEPOSITO N° 8-3ER PISO").');

  // Puesto principal y almacenes por socio
  const puestoPrincipalPorSocio = new Map();
  for (const h of historial) {
    if (tipoEspacioPorPuesto.get(h.puesto_id) !== 'Almacen') {
      puestoPrincipalPorSocio.set(h.socio_id, h.puesto_id);
    }
  }
  const almacenesPorSocio = new Map();
  for (const o of ocupaciones) {
    const lista = almacenesPorSocio.get(o.socio_id) || [];
    lista.push({ puesto_id: o.puesto_id, codigo: codigoPorPuesto.get(o.puesto_id) || '' });
    almacenesPorSocio.set(o.socio_id, lista);
  }

  // Índice de deudas: clave = "puesto_id|concepto_id|anio|mes" → deuda (solo si tiene saldo pendiente)
  const deudaIndex = new Map();
  for (const d of deudas) {
    if (!d.puesto_id) continue;
    const ya_pagado = (d.detalle_pagos || [])
      .filter(dp => dp.deleted_at === null)
      .reduce((acc, dp) => acc + Number(dp.monto_aplicado), 0);
    const saldo = Math.round((Number(d.monto) - ya_pagado) * 100) / 100;
    if (saldo <= 0.005) continue;
    const key = `${d.puesto_id}|${d.concepto_id}|${d.periodo_anio}|${d.periodo_mes}`;
    deudaIndex.set(key, { ...d, ya_pagado, saldo });
  }
  console.log(`Deudas con saldo pendiente en BD: ${deudaIndex.size}`);

  const indice = construirIndice(socios);

  // ─── Empate de socios ──────────────────────────────────────────────────────
  const nombresExcel = [...new Set(rows.map(r => String(r['Socio']).trim()))];
  const empateNombre = new Map();
  const sinMatch = [], ambiguos = [], excluidos = [];

  for (const nombre of nombresExcel) {
    const normNombre = normalize(nombre);
    if (EXCLUIR_SOCIOS[normNombre] || EXCLUIR_SOCIOS[nombre.trim()]) {
      excluidos.push({ nombre, motivo: EXCLUIR_SOCIOS[normNombre] || EXCLUIR_SOCIOS[nombre.trim()] });
      continue;
    }
    const r = empatarSocio(nombre, indice);
    if (r.socio) {
      empateNombre.set(nombre, r.socio);
    } else if (r.metodo === 'ambiguo') {
      ambiguos.push({ nombre, candidatos: r.candidatos.map(c => `${c.id}:${c.apellidos}`) });
    } else {
      sinMatch.push(nombre);
    }
  }

  console.log(`\nSocios distintos en Excel: ${nombresExcel.length}`);
  console.log(`Empatados: ${empateNombre.size}`);
  if (excluidos.length) {
    console.log(`\nEXCLUIDOS (${excluidos.length}):`);
    excluidos.forEach(e => console.log(`  "${e.nombre}" → ${e.motivo}`));
  }
  if (ambiguos.length) {
    console.log(`\nAMBIGUOS (${ambiguos.length}) — agregar a MANUAL_MAP:`);
    ambiguos.forEach(a => console.log(`  "${a.nombre}" → ${a.candidatos.join(' | ')}`));
  }
  if (sinMatch.length) {
    console.log(`\nSIN MATCH (${sinMatch.length}) — agregar a MANUAL_MAP:`);
    sinMatch.forEach(n => console.log(`  "${normalize(n)}": <id>, // ${n}`));
  }
  if (ambiguos.length || sinMatch.length) {
    console.log('\nAbortando: hay socios sin empatar. Completa MANUAL_MAP y vuelve a ejecutar.');
    process.exit(1);
  }

  // ─── Procesamiento de filas ────────────────────────────────────────────────
  function resolverConceptoId(concepto) {
    const c = String(concepto).trim().toUpperCase();
    if (c === 'LUZ' || c === 'USO DE LUZ') return cIdPorNombre.get('Luz');
    if (c === 'AGUA') return cIdPorNombre.get('Agua');
    if (c === 'G. ADM') return cIdPorNombre.get('Gastos administrativos');
    if (c === 'P. SOCIAL' || c === 'P') return cIdPorNombre.get('Previsión social');
    if (c.startsWith('MULTA')) return cIdPorNombre.get('Multa');
    if (c.startsWith('P.S X FALL')) return cIdPorNombre.get('Fallecimiento de socio');
    if (c.startsWith('DEPOSITO')) return cIdPorNombre.get('Deposito');
    // FUMIGACION, CAMBIO DE GIRO PROVISIONAL, etc. → Otros
    return cIdPorNombre.get('Otros');
  }

  // Resolver puesto_id para un socio y concepto dado
  function resolverPuestoId(socio, concepto) {
    const cTrim = String(concepto).trim();

    if (parsearDepositoLegado(cTrim)) {
      return { puesto_id: puesto8D3.id, tipo: 'almacen_legado' };
    }

    const depositoInfo = parsearDeposito(cTrim);
    if (depositoInfo) {
      const almacenes = almacenesPorSocio.get(socio.id) || [];
      const sufijo = `${depositoInfo.num}-D${depositoInfo.piso}`;
      const match = almacenes.filter(a => a.codigo && a.codigo.endsWith(sufijo));
      if (match.length === 1) return { puesto_id: match[0].puesto_id, tipo: 'almacen' };
      if (match.length > 1) return { puesto_id: null, tipo: 'ambiguo_almacen', sufijo };
      return { puesto_id: null, tipo: 'sin_almacen', sufijo };
    }
    if (cTrim.toUpperCase() === 'DEPOSITO') {
      const almacenes = almacenesPorSocio.get(socio.id) || [];
      if (almacenes.length === 1) return { puesto_id: almacenes[0].puesto_id, tipo: 'almacen' };
      if (almacenes.length > 1) return { puesto_id: null, tipo: 'ambiguo_almacen_simple' };
      return { puesto_id: null, tipo: 'sin_almacen_simple' };
    }
    // Concepto de puesto principal
    const puesto_id = puestoPrincipalPorSocio.get(socio.id) || null;
    return { puesto_id, tipo: 'principal' };
  }

  // Agrupar filas por (Socio + Fecha) → pago cabecera con múltiples líneas
  const pagosPorSocioFecha = new Map();
  const omitidas = [];
  const duplicadosEnLote = [];

  for (const row of rows) {
    const nombreExcel = String(row['Socio']).trim();
    const conceptoOriginal = String(row['Concepto']).trim();
    const monto = Number(row['Monto pagado']);
    const fechaISO = excelDateToISO(row['Fecha']);
    const documento = String(row['Documento'] || '').trim() || null;

    const socio = empateNombre.get(nombreExcel);
    if (!socio) continue; // excluido

    if (!fechaISO) {
      omitidas.push(`${nombreExcel} / ${conceptoOriginal}: fecha inválida`);
      continue;
    }
    if (!(monto > 0)) continue;

    const legado = parsearDepositoLegado(conceptoOriginal);
    let periodo_mes, periodo_anio;
    if (legado) {
      periodo_mes = legado.periodo_mes;
      periodo_anio = legado.periodo_anio;
    } else {
      let periodoStr = String(row['Periodo']).trim().toUpperCase();
      if (!periodoStr && PERIODO_FIX_POR_INDICE[row.__idx]) periodoStr = PERIODO_FIX_POR_INDICE[row.__idx];
      periodo_mes = MES_MAP[periodoStr] || null;
      periodo_anio = 2026;
    }

    const { puesto_id, tipo } = resolverPuestoId(socio, conceptoOriginal);
    const concepto_id = resolverConceptoId(conceptoOriginal);

    if (!puesto_id && tipo !== 'principal') {
      omitidas.push(`${nombreExcel} / "${conceptoOriginal}" / periodo ${periodo_anio}/${periodo_mes}: no se pudo resolver puesto de almacén (${tipo})`);
      continue;
    }
    if (!puesto_id) {
      omitidas.push(`${nombreExcel} / "${conceptoOriginal}": socio sin puesto principal activo`);
      continue;
    }
    if (!periodo_mes) {
      omitidas.push(`${nombreExcel} / "${conceptoOriginal}": período desconocido "${row['Periodo']}"`);
      continue;
    }

    // Saldo restante en vivo: se decrementa según se van consumiendo líneas de
    // este mismo lote, para que una fila duplicada (mismo Documento repetido en
    // el Excel fuente, p. ej. PEREZ EPIFANIA doc 33465 con G. ADM/P. SOCIAL de
    // ABRIL listado 3 veces) NO vuelva a aplicarse sobre una deuda que ya quedó
    // en 0 dentro de este mismo lote — cae a SIN DEUDA en vez de sobre-aplicarse.
    const deudaKey = `${puesto_id}|${concepto_id}|${periodo_anio}|${periodo_mes}`;
    const deudaRef = deudaIndex.get(deudaKey) || null;
    let deudaAplicada = null;
    if (deudaRef && deudaRef.saldo > 0.005) {
      const cubierto = monto >= deudaRef.saldo - 0.005;
      deudaAplicada = { id: deudaRef.id, monto: deudaRef.monto, cubierto };
      deudaRef.saldo = cubierto ? 0 : deudaRef.saldo - monto;
    } else if (deudaRef) {
      duplicadosEnLote.push(`${nombreExcel} / "${conceptoOriginal}" ${periodo_anio}/${periodo_mes} S/${monto}: deuda id=${deudaRef.id} ya quedó saldada por otra línea de este mismo lote (posible duplicado en el Excel fuente, doc ${documento}) — registrada como SIN DEUDA`);
    }

    const pagoKey = `${nombreExcel}|${fechaISO}|${documento || ''}`;
    if (!pagosPorSocioFecha.has(pagoKey)) {
      pagosPorSocioFecha.set(pagoKey, {
        socio,
        puesto_id: puestoPrincipalPorSocio.get(socio.id) || puesto_id,
        fecha: fechaISO,
        documento,
        lineas: [],
      });
    }
    pagosPorSocioFecha.get(pagoKey).lineas.push({
      concepto: conceptoOriginal,
      concepto_id,
      puesto_id,
      monto,
      periodo_mes,
      periodo_anio,
      deuda: deudaAplicada,
    });
  }

  // ─── Generación del SQL ───────────────────────────────────────────────────
  const lines = [];
  lines.push('-- =============================================================================');
  lines.push('-- Migración 00089: Pagos 01-08 Julio 2026');
  lines.push('-- Cooperativa Primero de Mayo · SistemaCooperativa');
  lines.push(`-- Generado: ${new Date().toISOString().slice(0, 10)} desde scripts/generar_pagos_1_8_julio_2026.js`);
  lines.push(`-- Fuente: ${EXCEL_PATH} (hoja "${SHEET_NAME}")`);
  lines.push('-- Registra pagos reales 01-08 jul 2026. Marca deudas como Cancelado si pago total.');
  lines.push('-- =============================================================================');
  lines.push('');
  lines.push('DO $$');
  lines.push('DECLARE');
  lines.push('  v_pago_id bigint;');
  lines.push('BEGIN');
  lines.push('');

  let totalPagos = 0;
  let totalDetalles = 0;
  let totalSinDeuda = 0;
  let totalCancelados = 0;
  let totalParciales = 0;

  for (const [key, pago] of pagosPorSocioFecha.entries()) {
    const { socio, puesto_id, fecha, documento, lineas } = pago;
    const montoTotal = lineas.reduce((acc, l) => acc + l.monto, 0);
    const obsLineas = lineas.map(l => `${l.concepto} ${l.periodo_anio}/${String(l.periodo_mes).padStart(2, '0')}`).join(', ');

    lines.push(`  -- Socio: ${socio.apellidos} | Fecha: ${fecha} | Doc: ${documento ?? 'N/A'} | Total: S/ ${montoTotal.toFixed(2)}`);
    lines.push(`  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)`);
    lines.push(`  VALUES (${puesto_id}, ${socio.id}, ${montoTotal.toFixed(2)}, 'Efectivo', ${documento ? esc(documento) : 'NULL'}, ${esc(fecha + 'T12:00:00+00:00')}, ${esc('Pago 01-08 jul 2026: ' + obsLineas)})`);
    lines.push(`  RETURNING id INTO v_pago_id;`);
    lines.push('');

    for (const linea of lineas) {
      if (linea.deuda) {
        const cubierto = linea.deuda.cubierto;
        lines.push(`  -- Deuda id=${linea.deuda.id}: ${linea.concepto} ${linea.periodo_anio}/${String(linea.periodo_mes).padStart(2, '0')} | Monto deuda: S/${linea.deuda.monto} | Pagado: S/${linea.monto} | ${cubierto ? 'TOTAL (Cancelado)' : 'PARCIAL'}`);
        lines.push(`  INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado)`);
        lines.push(`  VALUES (v_pago_id, ${linea.deuda.id}, ${linea.monto.toFixed(2)});`);
        if (cubierto) {
          lines.push(`  UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = ${linea.deuda.id};`);
          totalCancelados++;
        } else {
          totalParciales++;
        }
        totalDetalles++;
      } else {
        lines.push(`  -- SIN DEUDA: ${linea.concepto} ${linea.periodo_anio}/${String(linea.periodo_mes).padStart(2, '0')} S/${linea.monto} — registrado en pago pero sin monto_id`);
        totalSinDeuda++;
      }
      lines.push('');
    }
    totalPagos++;
  }

  lines.push('END$$;');
  lines.push('');

  if (omitidas.length) {
    lines.push('-- ─── FILAS OMITIDAS ───────────────────────────────────────────────────────');
    omitidas.forEach(m => lines.push(`-- OMITIDA: ${m}`));
    lines.push('');
  }
  if (excluidos.length) {
    lines.push('-- ─── SOCIOS EXCLUIDOS ─────────────────────────────────────────────────────');
    excluidos.forEach(e => lines.push(`-- EXCLUIDO: "${e.nombre}" — ${e.motivo}`));
    lines.push('');
  }
  if (duplicadosEnLote.length) {
    lines.push('-- ─── LÍNEAS DUPLICADAS EN EL EXCEL FUENTE (deuda ya saldada en este lote) ───');
    duplicadosEnLote.forEach(m => lines.push(`-- DUPLICADO: ${m}`));
    lines.push('');
  }

  fs.mkdirSync(path.dirname(OUTPUT_SQL), { recursive: true });
  fs.writeFileSync(OUTPUT_SQL, lines.join('\n'));

  console.log(`\n=== Resumen ===`);
  console.log(`Pagos (cabeceras) generados : ${totalPagos}`);
  console.log(`Detalles de pago            : ${totalDetalles}`);
  console.log(`  - Deudas canceladas (total): ${totalCancelados}`);
  console.log(`  - Pagos parciales           : ${totalParciales}`);
  console.log(`  - Sin deuda en BD           : ${totalSinDeuda}`);
  if (omitidas.length) {
    console.log(`\nOMITIDAS (${omitidas.length}):`);
    omitidas.forEach(m => console.log('  ' + m));
  }
  if (duplicadosEnLote.length) {
    console.log(`\nDUPLICADOS EN LOTE (${duplicadosEnLote.length}) — deuda ya saldada por otra línea del mismo Excel:`);
    duplicadosEnLote.forEach(m => console.log('  ' + m));
  }
  console.log(`\nSQL generado: ${OUTPUT_SQL}`);
}

main().catch(err => { console.error(err); process.exit(1); });
