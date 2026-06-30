/**
 * generar_migracion_junio_2026.js
 *
 * Lee "migracion_coop/junio/SOCIOS - CONSOLIDADO POR COBRAR JUNIO 2026.xlsx"
 * (hoja 'Detalle JUNIO'), empata cada socio contra public.socios,
 * resuelve el puesto_id correspondiente y genera
 * supabase/migrations/00076_cargar_deudas_junio_2026.sql
 *
 * Familias de filas en el Excel:
 *   1. G. ADM / P. SOCIAL  -> deuda de PUESTO principal del socio (tipo != Almacen)
 *   2. DEPOSITO X - DY     -> deuda de ALMACEN del socio.
 *      El formato "DEPOSITO <numero> - D<piso>" indica directamente el código del almacén.
 *      Ejemplos: "DEPOSITO 6 - D2" -> buscar almacén cuyo código termine en "6-D2"
 *                "DEPOSITO 8 - D3" -> buscar almacén cuyo código termine en "8-D3"
 *
 * Uso: node scripts/generar_migracion_junio_2026.js
 */
'use strict';
const fs = require('fs');
const path = require('path');
const XLSX = require('xlsx');
const { createClient } = require('@supabase/supabase-js');

const EXCEL_PATH = 'migracion_coop/junio/SOCIOS - CONSOLIDADO POR COBRAR JUNIO 2026.xlsx';
const SHEET_NAME = 'Detalle JUNIO';
const OUTPUT_SQL = 'supabase/migrations/00076_cargar_deudas_junio_2026.sql';
const PERIODO_ANIO = 2026;
const PERIODO_MES = 6;

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

// ─── Mapeo manual: nombre normalizado del Excel -> id de socio en BD ─────────
// Mismo criterio que migración de mayo: corrige typos y abreviaciones conocidas.
const MANUAL_MAP = {
  'CRUZ LUIS': 48,
  'DELA CRUZ JOSE': 55,
  'GUTIERRES CASTRO JORGE': 67,
  'MAYHUASCA CLUDY': 90,
  'PRADO ZOZIMA': 121,
};

// Excluir nombres que no están en el padrón todavía
const EXCLUIR_SOCIOS = {
  'GARCIA LUCIA': 'Socia nueva — pendiente confirmación de alta de padrón.',
  'TENORIO ALBERTINA': 'Socio nuevo en reemplazo de otro — pendiente verificación y alta en el padrón.',
};

// ─── Utilidades ──────────────────────────────────────────────────────────────
function normalize(s) {
  return String(s)
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toUpperCase()
    .replace(/[^A-Z0-9\s]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();
}

function esc(s) {
  return "'" + String(s).replace(/'/g, "''") + "'";
}

// ─── Parsear concepto DEPOSITO X - DY ────────────────────────────────────────
// Ej: "DEPOSITO 6 - D2"  -> { num: '6', piso: 2 }
// Ej: "DEPOSITO 10 - D2" -> { num: '10', piso: 2 }
function parsearDeposito(concepto) {
  const m = String(concepto).trim().match(/^DEPOSITO\s+(\d+)\s*-\s*D(\d)$/i);
  if (!m) return null;
  return { num: m[1], piso: parseInt(m[2], 10) };
}

// ─── Empate de socios ────────────────────────────────────────────────────────
function construirIndiceSocios(socios) {
  return socios.map((s) => ({
    ...s,
    apellidosNorm: normalize(s.apellidos),
    tokens: new Set(normalize(s.apellidos).split(' ').filter((t) => t.length >= 2)),
  }));
}

function empatarSocio(nombreExcel, indice) {
  const norm = normalize(nombreExcel);

  if (MANUAL_MAP[norm] !== undefined && MANUAL_MAP[norm] !== null) {
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

// ─── Main ─────────────────────────────────────────────────────────────────────
async function main() {
  console.log('Leyendo Excel:', EXCEL_PATH);
  const wb = XLSX.readFile(EXCEL_PATH, { raw: false });
  const ws = wb.Sheets[SHEET_NAME];
  if (!ws) throw new Error(`Hoja "${SHEET_NAME}" no encontrada. Disponibles: ${wb.SheetNames.join(', ')}`);
  const rows = XLSX.utils.sheet_to_json(ws, { defval: '' });
  console.log(`Filas leídas: ${rows.length}`);

  console.log('Descargando datos de BD (socios, historial, puestos, ocupaciones, conceptos)...');
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

  const tipoEspacioPorPuesto = new Map(puestos.map((p) => [p.id, p.tipo_espacio]));
  const codigoPorPuesto = new Map(puestos.map((p) => [p.id, p.codigo_puesto]));
  const conceptoIdPorNombre = new Map(conceptos.map((c) => [c.nombre, c.id]));

  // Verificar que los conceptos necesarios existen en BD
  const conceptosRequeridos = ['Gastos administrativos', 'Previsión social', 'Deposito', 'Alquiler'];
  for (const nombre of conceptosRequeridos) {
    if (!conceptoIdPorNombre.has(nombre))
      throw new Error(`Concepto "${nombre}" no existe en public.conceptos`);
  }

  // puesto principal (no-Almacén) por socio
  const puestoPrincipalPorSocio = new Map();
  for (const h of historial) {
    if (tipoEspacioPorPuesto.get(h.puesto_id) !== 'Almacen') {
      puestoPrincipalPorSocio.set(h.socio_id, h.puesto_id);
    }
  }

  // almacenes activos por socio (con su código de puesto)
  const almacenesPorSocio = new Map();
  for (const o of ocupaciones) {
    const lista = almacenesPorSocio.get(o.socio_id) || [];
    lista.push({ puesto_id: o.puesto_id, codigo: codigoPorPuesto.get(o.puesto_id) || '' });
    almacenesPorSocio.set(o.socio_id, lista);
  }

  const indice = construirIndiceSocios(socios);

  // ─── Empate de socios únicos ──────────────────────────────────────────────
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
  const omitidas = [];

  for (const row of rows) {
    const nombreExcel = String(row['Socio']).trim();
    const concepto = String(row['Concepto']).trim();
    const monto = Number(row['Monto por cobrar']);
    const socio = empateNombre.get(nombreExcel);
    if (!socio) continue; // excluido

    if (!(monto > 0)) {
      omitidas.push(`${nombreExcel} / ${concepto}: monto inválido (${row['Monto por cobrar']})`);
      continue;
    }

    // Concepto: Gastos Administrativos
    if (concepto === 'G. ADM') {
      const puesto_id = puestoPrincipalPorSocio.get(socio.id);
      if (!puesto_id) {
        sinResolverPuesto.push(`${nombreExcel} / G. ADM: sin puesto principal activo`);
        continue;
      }
      filasResueltas.push({
        puesto_id,
        socio_id: null,
        concepto_id: conceptoIdPorNombre.get('Gastos administrativos'),
        monto,
        observacion: `Deuda consolidada Junio 2026`,
      });
      continue;
    }

    // Concepto: Previsión Social
    if (concepto === 'P. SOCIAL') {
      const puesto_id = puestoPrincipalPorSocio.get(socio.id);
      if (!puesto_id) {
        sinResolverPuesto.push(`${nombreExcel} / P. SOCIAL: sin puesto principal activo`);
        continue;
      }
      filasResueltas.push({
        puesto_id,
        socio_id: null,
        concepto_id: conceptoIdPorNombre.get('Previsión social'),
        monto,
        observacion: `Deuda consolidada Junio 2026`,
      });
      continue;
    }

    // Concepto: DEPOSITO X - DY (almacén)
    const depositoInfo = parsearDeposito(concepto);
    if (depositoInfo) {
      const almacenes = almacenesPorSocio.get(socio.id) || [];

      // Buscar el almacén que coincida con el número y piso del concepto
      // Código de almacén esperado: "<numero>-D<piso>" (ej. "6-D2", "10-D2")
      const sufijoBuscado = `${depositoInfo.num}-D${depositoInfo.piso}`;
      let puesto_id = null;

      // Intento 1: código termina exactamente con "num-Dpiso"
      const matchExacto = almacenes.filter((a) => a.codigo && a.codigo.endsWith(sufijoBuscado));
      if (matchExacto.length === 1) {
        puesto_id = matchExacto[0].puesto_id;
      } else if (matchExacto.length > 1) {
        sinResolverPuesto.push(
          `${nombreExcel} / "${concepto}": múltiples almacenes con sufijo "${sufijoBuscado}" — ${matchExacto.map((a) => a.codigo).join(', ')}`
        );
        continue;
      }

      if (!puesto_id) {
        sinResolverPuesto.push(
          `${nombreExcel} / "${concepto}" (S/ ${monto}): no se encontró almacén con código terminado en "${sufijoBuscado}". ` +
          `Almacenes activos del socio: ${almacenes.map((a) => a.codigo).join(', ') || 'ninguno'}`
        );
        continue;
      }

      // El concepto contable es 'Deposito' (concepto id=16) para almacenes con depósito mensual
      const codigoAlmacen = codigoPorPuesto.get(puesto_id) || sufijoBuscado;
      filasResueltas.push({
        puesto_id,
        socio_id: null,
        concepto_id: conceptoIdPorNombre.get('Deposito'),
        monto,
        observacion: `Deuda consolidada Junio 2026 - Depósito almacén ${codigoAlmacen}`,
      });
      continue;
    }

    // Concepto desconocido
    omitidas.push(`${nombreExcel} / "${concepto}" (S/ ${monto}): concepto no reconocido — revisar clasificación`);
  }

  console.log(`\nFilas resueltas: ${filasResueltas.length} / ${rows.length}`);
  if (sinResolverPuesto.length) {
    console.log(`\nSIN RESOLVER PUESTO (${sinResolverPuesto.length}):`);
    sinResolverPuesto.forEach((m) => console.log('  ' + m));
  }
  if (omitidas.length) {
    console.log(`\nOMITIDAS (${omitidas.length}):`);
    omitidas.forEach((m) => console.log('  ' + m));
  }

  // ─── Agrupar filas que comparten la misma clave única ────────────────────
  // (puesto_id, concepto_id, periodo_anio, periodo_mes) — evitar conflictos ON CONFLICT
  const agrupado = new Map();
  for (const f of filasResueltas) {
    const key = `${f.puesto_id}|${f.concepto_id}|${PERIODO_ANIO}|${PERIODO_MES}`;
    const existente = agrupado.get(key);
    if (existente) {
      existente.monto += f.monto;
    } else {
      agrupado.set(key, { ...f });
    }
  }
  const colisiones = filasResueltas.length - agrupado.size;
  if (colisiones > 0) {
    console.log(`\nADVERTENCIA: ${colisiones} fila(s) agrupadas por colisión de clave única`);
  }
  const filasFinal = [...agrupado.values()];

  const totalMonto = filasFinal.reduce((acc, f) => acc + f.monto, 0);
  console.log(`\nMonto total a insertar: S/ ${totalMonto.toFixed(2)}`);
  console.log(`Filas finales: ${filasFinal.length}`);

  // ─── Generación del SQL ───────────────────────────────────────────────────
  const lines = [];
  lines.push('-- =============================================================================');
  lines.push('-- Migración 00076: Carga de montos por cobrar de Junio 2026');
  lines.push('-- Cooperativa Primero de Mayo · SistemaCooperativa');
  lines.push(`-- Generado: ${new Date().toISOString().slice(0, 10)} desde scripts/generar_migracion_junio_2026.js`);
  lines.push(`-- Fuente: ${EXCEL_PATH} (hoja "${SHEET_NAME}")`);
  lines.push(`-- Filas: ${filasFinal.length} de ${rows.length} | Monto total: S/ ${totalMonto.toFixed(2)}`);
  lines.push('-- Idempotente: ON CONFLICT ... DO NOTHING');
  lines.push('-- =============================================================================');
  lines.push('');
  lines.push('INSERT INTO public.montos_por_cobrar');
  lines.push('  (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion)');
  lines.push('VALUES');

  const valueLines = filasFinal.map((f, i) => {
    const comma = i < filasFinal.length - 1 ? ',' : '';
    return `  (${f.puesto_id}, NULL, ${f.concepto_id}, ${PERIODO_ANIO}, ${PERIODO_MES}, ${f.monto.toFixed(2)}, 'Pendiente', 'Manual', CURRENT_DATE, ${esc(f.observacion)})${comma}`;
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
