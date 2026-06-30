/**
 * generar_migracion_mayo_2026.js
 *
 * Lee "migracion_coop/junio/SOCIOS - CONSOLIDADO POR COBRAR MAYO 2026.xlsx"
 * (hoja 'Detalle por cobrar mayo'), empata cada socio contra public.socios,
 * resuelve el puesto_id correspondiente y genera
 * supabase/migrations/00073_cargar_deudas_mayo_2026.sql
 *
 * Tres familias de filas en el Excel:
 *   1. Conceptos base (LUZ/AGUA/G. ADM/P. SOCIAL) -> puesto principal del socio
 *      (historial_titularidad activo, tipo_espacio != 'Almacen').
 *   2. DEPOSITO / DEPOSITO N° X [MM/YYYY] -> concepto Deposito(16)/Alquiler(11),
 *      puesto resuelto vía ocupaciones_almacenes activa del socio. El sufijo
 *      MM/YYYY (si existe) fija el periodo real del cargo retroactivo.
 *   3. RECONEXION DE LUZ -> concepto Otros(18), puesto principal del socio.
 *
 * Uso: node scripts/generar_migracion_mayo_2026.js
 */
'use strict';
const fs = require('fs');
const path = require('path');
const XLSX = require('xlsx');
const { createClient } = require('@supabase/supabase-js');

const EXCEL_PATH = 'migracion_coop/junio/SOCIOS - CONSOLIDADO POR COBRAR MAYO 2026.xlsx';
const SHEET_NAME = 'Detalle por cobrar mayo';
const OUTPUT_SQL = 'supabase/migrations/00073_cargar_deudas_mayo_2026.sql';
const PERIODO_ANIO_DEFAULT = 2026;
const PERIODO_MES_DEFAULT = 5;

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

// ─── Mapeo manual: nombre normalizado del Excel -> id de socio en BD ───────
// Rellenar aquí los casos que el empate automático (subset de tokens) no resuelva.
const MANUAL_MAP = {
  'CRUZ LUIS': 48, // CRUZ JARAMILLO LUIS (el otro candidato, DE LA CRUZ ESTEBAN JOSE LUIS, ya está tomado por "DELA CRUZ JOSE")
  'DELA CRUZ JOSE': 55, // DE LA CRUZ ESTEBAN JOSE LUIS — "DELA" sin espacio no separa en tokens DE/LA
  'GUTIERRES CASTRO JORGE': 67, // GUTIERREZ CASTRO JORGE RICARDO — typo GUTIERRES con S
  'MAYHUASCA CLUDY': 90, // MAYHUASCA BASTIDAS DE TORRES CLUDDY AYDE — typo CLUDY sin doble D
  'PRADO ZOZIMA': 121, // PRADO LLANCARI ZOSIMA — typo ZOZIMA con Z
};

// Nombres del Excel que deliberadamente NO se cargan en esta migración (con motivo).
const EXCLUIR_SOCIOS = {
  'GARCIA LUCIA': 'Socia nueva (pagó "DERECHO DE NUEVO SOCIO" en junio 2026) — aún no existe en public.socios ni tiene puesto asignado. Requiere alta de padrón antes de cargar su deuda de Mayo 2026.',
};

// Override puntual cuando un socio tiene >1 almacén activo y el texto del concepto
// no menciona el piso (la heurística de detectarPiso() no aplica). Clave: "Socio::Concepto".
const PUESTO_OVERRIDE_DEPOSITO = {
  // CABERO GLORIA tiene 2 almacenes activos: 8-D2 y 8-D3. La serie retroactiva
  // "DEPOSITO N° 8-3ER PISO MM/YYYY" ya resuelve a 8-D3 (piso detectado). El cargo
  // suelto "DEPOSITO N° 8" (sin piso) corresponde entonces al otro almacén, 8-D2.
  'CABERO GLORIA::DEPOSITO N° 8': 49,
};

// ─── Utilidades de texto ────────────────────────────────────────────────────
function normalize(s) {
  return String(s)
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .toUpperCase()
    .replace(/[^A-Z0-9\s]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();
}

function esc(s) {
  return "'" + String(s).replace(/'/g, "''") + "'";
}

const BASE_CONCEPTOS = {
  LUZ: 'Luz',
  AGUA: 'Agua',
  'G. ADM': 'Gastos administrativos',
  'P. SOCIAL': 'Previsión social',
};

// P(ISO|SIO) cubre tanto "PISO" como el typo "PSIO" (letras S/I invertidas) visto en el Excel.
const FLOOR_PATTERNS = [
  { re: /\b1\s*(ER)?\s*P(ISO|SIO)\b/, floor: 1 },
  { re: /\b2\s*(DO)?\s*P(ISO|SIO)\b/, floor: 2 },
  { re: /\b3\s*(ER)?\s*P(ISO|SIO)\b/, floor: 3 },
];

function detectarPiso(conceptoNorm) {
  for (const { re, floor } of FLOOR_PATTERNS) {
    if (re.test(conceptoNorm)) return floor;
  }
  return null;
}

function parsearSufijoPeriodo(concepto) {
  const m = concepto.match(/(\d{2})\/(\d{4})\s*$/);
  if (!m) return null;
  return { mes: parseInt(m[1], 10), anio: parseInt(m[2], 10) };
}

// ─── Empate de socios ───────────────────────────────────────────────────────
function construirIndiceSocios(socios) {
  return socios.map((s) => ({
    ...s,
    apellidosNorm: normalize(s.apellidos),
    tokens: new Set(normalize(s.apellidos).split(' ').filter((t) => t.length >= 2)),
  }));
}

function empatarSocio(nombreExcel, indice) {
  const norm = normalize(nombreExcel);

  if (MANUAL_MAP[norm] !== undefined) {
    const id = MANUAL_MAP[norm];
    const s = indice.find((x) => x.id === id);
    if (s) return { socio: s, metodo: 'manual' };
  }

  const exacto = indice.find((s) => s.apellidosNorm === norm);
  if (exacto) return { socio: exacto, metodo: 'exacto' };

  const tokensExcel = norm.split(' ').filter((t) => t.length >= 2);
  const candidatos = indice.filter((s) => tokensExcel.every((t) => s.tokens.has(t)));

  if (candidatos.length === 1) return { socio: candidatos[0], metodo: 'subset' };
  if (candidatos.length > 1) return { socio: null, metodo: 'ambiguo', candidatos };
  return { socio: null, metodo: 'sin_match' };
}

// ─── Main ───────────────────────────────────────────────────────────────────
async function main() {
  console.log('Leyendo Excel:', EXCEL_PATH);
  const wb = XLSX.readFile(EXCEL_PATH, { raw: false });
  const ws = wb.Sheets[SHEET_NAME];
  if (!ws) throw new Error(`Hoja "${SHEET_NAME}" no encontrada. Hojas disponibles: ${wb.SheetNames.join(', ')}`);
  const rows = XLSX.utils.sheet_to_json(ws, { defval: '' });
  console.log(`Filas leídas: ${rows.length}`);

  console.log('Descargando socios, historial de titularidad, ocupaciones de almacén y conceptos...');
  const [{ data: socios, error: e1 }, { data: historial, error: e2 }, { data: puestos, error: e3 },
    { data: ocupaciones, error: e4 }, { data: conceptos, error: e5 }] = await Promise.all([
    supabase.from('socios').select('id, apellidos, nombres, dni').is('deleted_at', null),
    supabase.from('historial_titularidad').select('socio_id, puesto_id').is('fecha_fin', null),
    supabase.from('puestos').select('id, codigo_puesto, tipo_espacio'),
    supabase.from('ocupaciones_almacenes').select('socio_id, puesto_id').is('fecha_fin', null),
    supabase.from('conceptos').select('id, nombre'),
  ]);
  for (const e of [e1, e2, e3, e4, e5]) if (e) throw e;

  const tipoEspacioPorPuesto = new Map(puestos.map((p) => [p.id, p.tipo_espacio]));
  const codigoPorPuesto = new Map(puestos.map((p) => [p.id, p.codigo_puesto]));
  const conceptoIdPorNombre = new Map(conceptos.map((c) => [c.nombre, c.id]));

  for (const nombre of [...Object.values(BASE_CONCEPTOS), 'Deposito', 'Alquiler', 'Otros']) {
    if (!conceptoIdPorNombre.has(nombre)) throw new Error(`Concepto "${nombre}" no existe en public.conceptos`);
  }

  // puesto principal (no-Almacén) por socio
  const puestoPrincipalPorSocio = new Map();
  for (const h of historial) {
    if (tipoEspacioPorPuesto.get(h.puesto_id) !== 'Almacen') {
      if (puestoPrincipalPorSocio.has(h.socio_id)) {
        console.warn(`ADVERTENCIA: socio_id ${h.socio_id} tiene más de un puesto principal activo.`);
      }
      puestoPrincipalPorSocio.set(h.socio_id, h.puesto_id);
    }
  }

  // almacenes activos por socio
  const almacenesPorSocio = new Map();
  for (const o of ocupaciones) {
    const lista = almacenesPorSocio.get(o.socio_id) || [];
    lista.push({ puesto_id: o.puesto_id, codigo: codigoPorPuesto.get(o.puesto_id) });
    almacenesPorSocio.set(o.socio_id, lista);
  }

  const indice = construirIndiceSocios(socios);

  // ─── Empate de socios únicos del Excel ───────────────────────────────────
  const nombresExcel = [...new Set(rows.map((r) => String(r['Socio']).trim()))];
  const empateNombre = new Map();
  const sinMatch = [];
  const ambiguos = [];
  const excluidos = [];

  for (const nombre of nombresExcel) {
    const normNombre = normalize(nombre);
    if (EXCLUIR_SOCIOS[normNombre] || EXCLUIR_SOCIOS[nombre]) {
      excluidos.push({ nombre, motivo: EXCLUIR_SOCIOS[normNombre] || EXCLUIR_SOCIOS[nombre] });
      continue;
    }
    const r = empatarSocio(nombre, indice);
    if (r.socio) {
      empateNombre.set(nombre, r.socio);
    } else if (r.metodo === 'ambiguo') {
      ambiguos.push({ nombre, candidatos: r.candidatos.map((c) => `${c.id}:${c.apellidos}`) });
    } else {
      sinMatch.push(nombre);
    }
  }

  console.log(`\nSocios distintos en Excel: ${nombresExcel.length}`);
  console.log(`Empatados: ${empateNombre.size}`);
  if (excluidos.length) {
    console.log(`\nEXCLUIDOS deliberadamente (${excluidos.length}):`);
    excluidos.forEach((e) => console.log(`  "${e.nombre}" -> ${e.motivo}`));
  }
  if (ambiguos.length) {
    console.log(`\nAMBIGUOS (${ambiguos.length}) — requieren entrada en MANUAL_MAP:`);
    ambiguos.forEach((a) => console.log(`  "${a.nombre}" -> candidatos: ${a.candidatos.join(' | ')}`));
  }
  if (sinMatch.length) {
    console.log(`\nSIN MATCH (${sinMatch.length}) — agregar a MANUAL_MAP:`);
    sinMatch.forEach((n) => console.log(`  "${normalize(n)}": <id_socio>, // ${n}`));
  }
  if (ambiguos.length || sinMatch.length) {
    console.log('\nAbortando generación de SQL: hay socios sin empatar. Completa MANUAL_MAP y vuelve a ejecutar.');
    process.exit(1);
  }

  // ─── Procesamiento de filas ───────────────────────────────────────────────
  const filasResueltas = [];
  const sinResolverPuesto = [];

  for (const row of rows) {
    const nombreExcel = String(row['Socio']).trim();
    const concepto = String(row['Concepto']).trim();
    const conceptoNorm = normalize(concepto);
    const monto = Number(row['Monto por cobrar']);
    const socio = empateNombre.get(nombreExcel);
    if (!socio) continue; // excluido deliberadamente (ver EXCLUIR_SOCIOS)

    if (!(monto > 0)) {
      console.warn(`Fila omitida (monto inválido): ${nombreExcel} / ${concepto} / ${row['Monto por cobrar']}`);
      continue;
    }

    if (BASE_CONCEPTOS[concepto]) {
      const puesto_id = puestoPrincipalPorSocio.get(socio.id);
      if (!puesto_id) {
        sinResolverPuesto.push(`${nombreExcel} / ${concepto}: sin puesto principal activo`);
        continue;
      }
      filasResueltas.push({
        puesto_id,
        concepto_id: conceptoIdPorNombre.get(BASE_CONCEPTOS[concepto]),
        periodo_anio: PERIODO_ANIO_DEFAULT,
        periodo_mes: PERIODO_MES_DEFAULT,
        monto,
        observacion: 'Deuda consolidada Mayo 2026',
      });
      continue;
    }

    if (concepto === 'RECONEXION DE LUZ') {
      const puesto_id = puestoPrincipalPorSocio.get(socio.id);
      if (!puesto_id) {
        sinResolverPuesto.push(`${nombreExcel} / ${concepto}: sin puesto principal activo`);
        continue;
      }
      filasResueltas.push({
        puesto_id,
        concepto_id: conceptoIdPorNombre.get('Otros'),
        periodo_anio: PERIODO_ANIO_DEFAULT,
        periodo_mes: PERIODO_MES_DEFAULT,
        monto,
        observacion: 'Deuda consolidada Mayo 2026 - Reconexión de luz',
      });
      continue;
    }

    // DEPOSITO / DEPOSITO N° X [MM/YYYY]
    const candidatos = almacenesPorSocio.get(socio.id) || [];
    let puesto_id = null;

    if (candidatos.length === 1) {
      puesto_id = candidatos[0].puesto_id;
    } else if (candidatos.length > 1) {
      const piso = detectarPiso(conceptoNorm);
      if (piso !== null) {
        const sufijo = `-D${piso}`;
        const match = candidatos.filter((c) => c.codigo && c.codigo.endsWith(sufijo));
        if (match.length === 1) puesto_id = match[0].puesto_id;
      }
    }

    if (!puesto_id) {
      const overrideKey = `${nombreExcel}::${concepto}`;
      puesto_id = PUESTO_OVERRIDE_DEPOSITO[overrideKey] || null;
    }

    if (!puesto_id) {
      sinResolverPuesto.push(
        `${nombreExcel} / "${concepto}" (S/ ${monto}): ${candidatos.length} ocupación(es) de almacén activa(s) — ${candidatos.map((c) => c.codigo).join(', ') || 'ninguna'}`
      );
      continue;
    }

    const sufijoPeriodo = parsearSufijoPeriodo(concepto);
    const conceptoBD = conceptoNorm === 'DEPOSITO' ? 'Deposito' : 'Alquiler';
    const codigoAlmacen = codigoPorPuesto.get(puesto_id);
    const observacion = sufijoPeriodo
      ? `Deuda consolidada Mayo 2026 - Alquiler almacén ${codigoAlmacen} (retroactivo ${String(sufijoPeriodo.mes).padStart(2, '0')}/${sufijoPeriodo.anio})`
      : `Deuda consolidada Mayo 2026 - Alquiler almacén ${codigoAlmacen}`;

    filasResueltas.push({
      puesto_id,
      concepto_id: conceptoIdPorNombre.get(conceptoBD),
      periodo_anio: sufijoPeriodo ? sufijoPeriodo.anio : PERIODO_ANIO_DEFAULT,
      periodo_mes: sufijoPeriodo ? sufijoPeriodo.mes : PERIODO_MES_DEFAULT,
      monto,
      observacion,
    });
  }

  console.log(`\nFilas resueltas: ${filasResueltas.length} / ${rows.length}`);
  if (sinResolverPuesto.length) {
    console.log(`\nSIN RESOLVER PUESTO (${sinResolverPuesto.length}) — excluidas del SQL, revisar manualmente:`);
    sinResolverPuesto.forEach((m) => console.log('  ' + m));
  }

  // El índice único de montos_por_cobrar es (puesto_id, concepto_id, periodo_anio, periodo_mes).
  // Si el Excel trae varias filas para la misma combinación (p.ej. mediciones parciales de luz),
  // hay que sumarlas en una sola fila — de lo contrario ON CONFLICT DO NOTHING descartaría el resto.
  const agrupado = new Map();
  for (const f of filasResueltas) {
    const key = `${f.puesto_id}|${f.concepto_id}|${f.periodo_anio}|${f.periodo_mes}`;
    const existente = agrupado.get(key);
    if (existente) {
      existente.monto += f.monto;
      existente.observacion += ` + ${f.observacion}`;
    } else {
      agrupado.set(key, { ...f });
    }
  }
  const colisiones = filasResueltas.length - agrupado.size;
  if (colisiones > 0) {
    console.log(`\nADVERTENCIA: ${colisiones} fila(s) se sumaron por colisión de (puesto_id, concepto_id, periodo_anio, periodo_mes):`);
    for (const [key, f] of agrupado.entries()) {
      const n = filasResueltas.filter((x) => `${x.puesto_id}|${x.concepto_id}|${x.periodo_anio}|${x.periodo_mes}` === key).length;
      if (n > 1) console.log(`  ${key} -> sumado a S/ ${f.monto.toFixed(2)} (${n} filas)`);
    }
  }
  const filasFinal = [...agrupado.values()];

  const totalMonto = filasFinal.reduce((acc, f) => acc + f.monto, 0);
  console.log(`\nMonto total a insertar: S/ ${totalMonto.toFixed(2)}`);

  // ─── Generación del SQL ────────────────────────────────────────────────────
  const lines = [];
  lines.push('-- =============================================================================');
  lines.push('-- Migración 00073: Carga de deudas consolidadas de Mayo 2026');
  lines.push('-- Cooperativa Primero de Mayo · SistemaCooperativa');
  lines.push(`-- Generado: ${new Date().toISOString().slice(0, 10)} desde scripts/generar_migracion_mayo_2026.js`);
  lines.push(`-- Fuente: ${EXCEL_PATH} (hoja "${SHEET_NAME}")`);
  lines.push(`-- Filas: ${filasFinal.length} de ${rows.length} | Monto total: S/ ${totalMonto.toFixed(2)}`);
  lines.push('-- Idempotente: ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes) DO NOTHING');
  lines.push('-- =============================================================================');
  lines.push('');
  lines.push('INSERT INTO public.montos_por_cobrar');
  lines.push('  (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)');
  lines.push('VALUES');

  const valueLines = filasFinal.map((f, i) => {
    const comma = i < filasFinal.length - 1 ? ',' : '';
    return `  (${f.puesto_id}, NULL, ${f.concepto_id}, ${f.periodo_anio}, ${f.periodo_mes}, ${f.monto.toFixed(2)}, 'Pendiente', 'Manual', CURRENT_DATE, ${esc(f.observacion)})${comma}`;
  });
  lines.push(...valueLines);
  lines.push('ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes)');
  lines.push('  WHERE deleted_at IS NULL AND puesto_id IS NOT NULL');
  lines.push('  DO NOTHING;');
  lines.push('');

  fs.mkdirSync(path.dirname(OUTPUT_SQL), { recursive: true });
  fs.writeFileSync(OUTPUT_SQL, lines.join('\n'));
  console.log(`\nSQL generado: ${OUTPUT_SQL}`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
