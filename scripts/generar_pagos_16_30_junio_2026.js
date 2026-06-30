/**
 * generar_pagos_16_30_junio_2026.js
 *
 * Lee "migracion_coop/junio/SOCIOS - CONSOLIDADO PAGOS 16-30 JUNIO 2026.xlsx"
 * (hoja 'Detalle pagos') y genera supabase/migrations/00077_pagos_16_30_junio_2026.sql
 *
 * Lógica por fila de pago:
 *   1. Empata el socio en public.socios (mismo algoritmo que migración de deudas).
 *   2. Resuelve el puesto_id (puesto principal o almacén según concepto).
 *   3. Busca en montos_por_cobrar la deuda que corresponde a:
 *        puesto_id + concepto_id + periodo_mes + periodo_anio con estado = 'Pendiente'
 *   4. Agrupa todos los conceptos del mismo socio pagados el mismo día → 1 pago (cabecera).
 *   5. Para cada deuda encontrada:
 *        - Pago total (monto_pagado >= deuda.monto): marca la deuda como 'Cancelado'
 *        - Pago parcial (monto_pagado < deuda.monto): inserta detalle_pago con monto parcial
 *   6. Inserta en public.pagos (cabecera) y public.detalle_pagos (distribución por deuda).
 *
 * Conceptos especiales (sin deuda en montos_por_cobrar):
 *   - MULTA 27/11/2025  → concepto Otros (18), registra pago pero no busca deuda
 *   - FUMIGACION        → concepto Fumigación (si existe) o Otros (18)
 *   - USO DE LUZ        → concepto Luz (1) del periodo correspondiente
 *   - DERECHO DE NUEVO SOCIO → OMITIDO (TENORIO ALBERTINA excluida)
 *
 * Uso: node scripts/generar_pagos_16_30_junio_2026.js
 */
'use strict';
const fs = require('fs');
const path = require('path');
const XLSX = require('xlsx');
const { createClient } = require('@supabase/supabase-js');

const EXCEL_PATH = 'migracion_coop/junio/SOCIOS - CONSOLIDADO PAGOS 16-30 JUNIO 2026.xlsx';
const SHEET_NAME = 'Detalle pagos';
const OUTPUT_SQL = 'supabase/migrations/00077_pagos_16_30_junio_2026.sql';

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

// ─── Mapeo manual: nombre normalizado → id de socio ─────────────────────────
const MANUAL_MAP = {
  'CRUZ LUIS': 48,
  'DELA CRUZ JOSE': 55,
  'GUTIERRES CASTRO JORGE': 67,
  'MAYHUASCA CLUDY': 90,
  'PRADO ZOZIMA': 121,
};

// Socios excluidos completamente (sin alta confirmada en padrón)
const EXCLUIR_SOCIOS = {
  'TENORIO ALBERTINA': 'Nuevo socio en reemplazo — pendiente verificación de alta en padrón.',
};

// ─── Mapa de meses en español ────────────────────────────────────────────────
const MES_MAP = {
  ENERO: 1, FEBRERO: 2, MARZO: 3, ABRIL: 4, MAYO: 5, JUNIO: 6,
  JULIO: 7, AGOSTO: 8, SEPTIEMBRE: 9, OCTUBRE: 10, NOVIEMBRE: 11, DICIEMBRE: 12,
};

// ─── Utilidades ──────────────────────────────────────────────────────────────
function normalize(s) {
  return String(s).normalize('NFD').replace(/[\u0300-\u036f]/g, '')
    .toUpperCase().replace(/[^A-Z0-9\s]/g, ' ').replace(/\s+/g, ' ').trim();
}

function esc(s) {
  return "'" + String(s).replace(/'/g, "''") + "'";
}

function excelDateToISO(serial) {
  if (!serial || isNaN(serial)) return null;
  const d = new Date((Number(serial) - 25569) * 86400 * 1000);
  return d.toISOString().slice(0, 10);
}

// Parsea "DEPOSITO X - DY" → { num: 'X', piso: Y } o null
function parsearDeposito(concepto) {
  const m = String(concepto).trim().match(/^DEPOSITO\s+(\d+)\s*-\s*D(\d)$/i);
  if (!m) return null;
  return { num: m[1], piso: parseInt(m[2], 10) };
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
  const allRows = XLSX.utils.sheet_to_json(ws, { defval: '' });
  const rows = allRows.filter(r => Number(r['Monto pagado']) > 0);
  console.log(`Filas leídas: ${allRows.length} | Con monto > 0: ${rows.length}`);

  console.log('Descargando datos de BD...');
  const [
    { data: socios, error: e1 },
    { data: historial, error: e2 },
    { data: puestos, error: e3 },
    { data: ocupaciones, error: e4 },
    { data: conceptos, error: e5 },
    { data: deudas, error: e6 },
  ] = await Promise.all([
    supabase.from('socios').select('id, apellidos, nombres, dni').is('deleted_at', null),
    supabase.from('historial_titularidad').select('socio_id, puesto_id').is('fecha_fin', null),
    supabase.from('puestos').select('id, codigo_puesto, tipo_espacio'),
    supabase.from('ocupaciones_almacenes').select('socio_id, puesto_id').is('fecha_fin', null),
    supabase.from('conceptos').select('id, nombre'),
    supabase.from('montos_por_cobrar')
      .select(`
        id, puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado,
        detalle_pagos ( monto_aplicado, deleted_at )
      `)
      .not('estado', 'eq', 'Cancelado')
      .is('deleted_at', null),
  ]);
  for (const e of [e1, e2, e3, e4, e5, e6]) if (e) throw e;

  const tipoEspacioPorPuesto = new Map(puestos.map(p => [p.id, p.tipo_espacio]));
  const codigoPorPuesto = new Map(puestos.map(p => [p.id, p.codigo_puesto]));

  // Mapas de concepto nombre → id
  const cIdPorNombre = new Map(conceptos.map(c => [c.nombre, c.id]));

  // Verificar conceptos requeridos
  const requeridos = ['Gastos administrativos', 'Previsión social', 'Luz', 'Agua', 'Deposito', 'Otros'];
  for (const n of requeridos) {
    if (!cIdPorNombre.has(n)) throw new Error(`Concepto "${n}" no encontrado en BD`);
  }

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
    // Calcular ya_pagado sumando detalle_pagos vigentes
    const ya_pagado = (d.detalle_pagos || [])
      .filter(dp => dp.deleted_at === null)
      .reduce((acc, dp) => acc + Number(dp.monto_aplicado), 0);
    const saldo = Math.round((Number(d.monto) - ya_pagado) * 100) / 100;
    if (saldo <= 0.005) continue; // ya pagado completo, ignorar
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
  // Mapa de concepto Excel → concepto_id en BD
  function resolverConceptoId(concepto) {
    const c = String(concepto).trim();
    if (c === 'LUZ' || c === 'USO DE LUZ') return cIdPorNombre.get('Luz');
    if (c === 'AGUA') return cIdPorNombre.get('Agua');
    if (c === 'G. ADM') return cIdPorNombre.get('Gastos administrativos');
    if (c === 'P. SOCIAL') return cIdPorNombre.get('Previsión social');
    if (c.startsWith('DEPOSITO')) return cIdPorNombre.get('Deposito');
    // MULTA, FUMIGACION, etc. → Otros
    return cIdPorNombre.get('Otros');
  }

  // Resolver puesto_id para un socio y concepto dado
  function resolverPuestoId(socio, concepto) {
    const depositoInfo = parsearDeposito(String(concepto).trim());
    if (depositoInfo) {
      // Es un almacén específico: "DEPOSITO X - DY"
      const almacenes = almacenesPorSocio.get(socio.id) || [];
      const sufijo = `${depositoInfo.num}-D${depositoInfo.piso}`;
      const match = almacenes.filter(a => a.codigo && a.codigo.endsWith(sufijo));
      if (match.length === 1) return { puesto_id: match[0].puesto_id, tipo: 'almacen' };
      if (match.length > 1) return { puesto_id: null, tipo: 'ambiguo_almacen', sufijo };
      return { puesto_id: null, tipo: 'sin_almacen', sufijo };
    }
    if (String(concepto).trim() === 'DEPOSITO') {
      // Depósito sin número: socio tiene 1 almacén
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
  // Cada pago del mismo día se agrupa en un solo INSERT en pagos,
  // con un detalle_pago por cada deuda que cubre.
  const pagosPorSocioFecha = new Map(); // clave: "nombreExcel|fechaISO"

  const omitidas = [];

  for (const row of rows) {
    const nombreExcel = String(row['Socio']).trim();
    const concepto = String(row['Concepto']).trim();
    const monto = Number(row['Monto pagado']);
    const fechaISO = excelDateToISO(row['Fecha']);
    const periodoStr = String(row['Periodo']).trim().toUpperCase();
    const periodo_mes = MES_MAP[periodoStr] || null;
    const periodo_anio = 2026; // Todos los pagos son de 2026

    const socio = empateNombre.get(nombreExcel);
    if (!socio) continue; // excluido

    if (!fechaISO) {
      omitidas.push(`${nombreExcel} / ${concepto}: fecha inválida`);
      continue;
    }
    if (!(monto > 0)) continue;

    // Resolver puesto y concepto
    const { puesto_id, tipo } = resolverPuestoId(socio, concepto);
    const concepto_id = resolverConceptoId(concepto);

    if (!puesto_id && tipo !== 'principal') {
      omitidas.push(`${nombreExcel} / "${concepto}" / ${periodoStr}: no se pudo resolver puesto de almacén (${tipo})`);
      continue;
    }
    if (!puesto_id) {
      omitidas.push(`${nombreExcel} / "${concepto}": socio sin puesto principal activo`);
      continue;
    }
    if (!periodo_mes) {
      omitidas.push(`${nombreExcel} / "${concepto}": período desconocido "${periodoStr}"`);
      continue;
    }

    // Buscar deuda pendiente que corresponde a este pago
    const deudaKey = `${puesto_id}|${concepto_id}|${periodo_anio}|${periodo_mes}`;
    const deuda = deudaIndex.get(deudaKey) || null;

    const pagoKey = `${nombreExcel}|${fechaISO}`;
    if (!pagosPorSocioFecha.has(pagoKey)) {
      pagosPorSocioFecha.set(pagoKey, {
        socio,
        puesto_id: puestoPrincipalPorSocio.get(socio.id) || puesto_id,
        fecha: fechaISO,
        lineas: [],
      });
    }
    pagosPorSocioFecha.get(pagoKey).lineas.push({
      concepto,
      concepto_id,
      puesto_id,
      monto,
      periodo_mes,
      periodo_anio,
      deuda,
    });
  }

  // ─── Generación del SQL ───────────────────────────────────────────────────
  const lines = [];
  lines.push('-- =============================================================================');
  lines.push('-- Migración 00077: Pagos 16-30 Junio 2026');
  lines.push('-- Cooperativa Primero de Mayo · SistemaCooperativa');
  lines.push(`-- Generado: ${new Date().toISOString().slice(0, 10)} desde scripts/generar_pagos_16_30_junio_2026.js`);
  lines.push(`-- Fuente: ${EXCEL_PATH} (hoja "${SHEET_NAME}")`);
  lines.push(`-- Registra pagos reales 16-26 jun 2026. Marca deudas como Cancelado si pago total.`);
  lines.push('-- Idempotente: usa DO $$ ... END$$ con EXCEPTION para manejar duplicados por comprobante.');
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
    const { socio, puesto_id, fecha, lineas } = pago;
    const montoTotal = lineas.reduce((acc, l) => acc + l.monto, 0);
    const obsLineas = lineas.map(l => `${l.concepto} ${l.periodo_anio}/${String(l.periodo_mes).padStart(2,'0')}`).join(', ');

    lines.push(`  -- Socio: ${socio.apellidos} | Fecha: ${fecha} | Total: S/ ${montoTotal.toFixed(2)}`);
    lines.push(`  INSERT INTO public.pagos (puesto_id, socio_id, monto_total, metodo_pago, comprobante, fecha_pago, observacion)`);
    lines.push(`  VALUES (${puesto_id}, ${socio.id}, ${montoTotal.toFixed(2)}, 'Efectivo', NULL, ${esc(fecha + 'T12:00:00+00:00')}, ${esc('Pago 16-30 jun 2026: ' + obsLineas)})`);
    lines.push(`  RETURNING id INTO v_pago_id;`);
    lines.push('');

    for (const linea of lineas) {
      if (linea.deuda) {
        // Pago aplicado a una deuda existente
        const cubierto = linea.monto >= linea.deuda.monto - 0.005; // tolerancia 0.5 centavos
        lines.push(`  -- Deuda id=${linea.deuda.id}: ${linea.concepto} ${linea.periodo_anio}/${String(linea.periodo_mes).padStart(2,'0')} | Monto deuda: S/${linea.deuda.monto} | Pagado: S/${linea.monto} | ${cubierto ? 'TOTAL (Cancelado)' : 'PARCIAL'}`);
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
        // Pago sin deuda correspondiente (concepto especial o deuda ya cancelada)
        lines.push(`  -- SIN DEUDA: ${linea.concepto} ${linea.periodo_anio}/${String(linea.periodo_mes).padStart(2,'0')} S/${linea.monto} — registrado en pago pero sin monto_id`);
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
  console.log(`\nSQL generado: ${OUTPUT_SQL}`);
}

main().catch(err => { console.error(err); process.exit(1); });
