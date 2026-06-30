/**
 * generar_migracion_pagos_junio.js
 *
 * Lee "migracion_coop/junio/SOCIOS - CONSOLIDADO PAGOS JUNIO 2026.xlsx"
 * (hoja 'Pagos detalle junio'), agrupa por (Nro recibo, Socio) y genera
 * supabase/migrations/00074_cargar_pagos_junio_2026.sql con:
 *   - 1 fila en public.pagos por recibo (monto_total = suma de sus líneas).
 *   - 1 fila en public.detalle_pagos por línea, contra la deuda correspondiente
 *     en public.montos_por_cobrar (resuelta dinámicamente en SQL: si no existe
 *     se crea en 'Pendiente' con el monto total que se le va a aplicar, y luego
 *     se reevalúa su estado Pendiente/Pagado tras cada aplicación).
 *
 * Reglas de concepto (decididas con el usuario):
 *   - LUZ/AGUA/G. ADM/P. SOCIAL/FUMIGACION -> deuda de PUESTO (puesto principal del socio).
 *   - MULTA* / PAGO EXTRAORDINARIO* / P.S X FALL* -> deuda del SOCIO (Multa/Aporte
 *     extraordinario/Fallecimiento de socio), puesto_id NULL en montos_por_cobrar,
 *     pero el pago en sí siempre lleva puesto_id (principal del socio) por NOT NULL.
 *   - DEPOSITO / DEPOSITO N° X -> deuda de PUESTO de almacén (ocupaciones_almacenes).
 *   - DERECHO DE NUEVO SOCIO -> solo aplica a GARCIA LUCIA, que está excluida.
 *   - metodo_pago: 'Efectivo' para todos (el Excel no distingue método).
 *
 * Uso: node scripts/generar_migracion_pagos_junio.js
 */
'use strict';
const fs = require('fs');
const path = require('path');
const XLSX = require('xlsx');
const { createClient } = require('@supabase/supabase-js');

const EXCEL_PATH = 'migracion_coop/junio/SOCIOS - CONSOLIDADO PAGOS JUNIO 2026.xlsx';
const SHEET_NAME = 'Pagos detalle junio';
const OUTPUT_SQL = 'supabase/migrations/00074_cargar_pagos_junio_2026.sql';
const METODO_PAGO_DEFAULT = 'Efectivo';

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

// ─── Mapeo manual de socios (mismo criterio que generar_migracion_mayo_2026.js) ─
const MANUAL_MAP = {
  'CRUZ LUIS': 48,
  'DELA CRUZ JOSE': 55,
  'GUTIERRES CASTRO JORGE': 67,
  'MAYHUASCA CLUDY': 90,
  'PRADO ZOZIMA': 121,
};

const EXCLUIR_SOCIOS = {
  'GARCIA LUCIA': 'Excluida explícitamente de este procesamiento (socia nueva, aún sin alta completa en el padrón).',
};

// Override puntual cuando un socio tiene >1 almacén activo y el concepto no menciona el piso.
const PUESTO_OVERRIDE_DEPOSITO = {
  'CABERO GLORIA::DEPOSITO N° 8': 49, // 8-D2 (8-D3 ya identificado por "3ER PISO" en otras filas)
};

// ─── Utilidades de texto ────────────────────────────────────────────────────
function normalize(s) {
  return String(s)
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .toUpperCase()
    .replace(/[^A-Z0-9\s.]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();
}

function esc(s) {
  return "'" + String(s).replace(/'/g, "''") + "'";
}

function excelSerialToDate(serial) {
  const utc_days = Math.floor(Number(serial) - 25569);
  const date = new Date(utc_days * 86400 * 1000);
  return date.toISOString().slice(0, 10) + ' 12:00:00-05';
}

const PERIODO_MES = {
  ENERO: 1, FEBRERO: 2, MARZO: 3, MAAR: 3, ABRIL: 4, MAYO: 5, JUNIO: 6,
  JULIO: 7, AGOSTO: 8, SETIEMBRE: 9, SEPTIEMBRE: 9, OCTUBRE: 10, NOVIEMBRE: 11, DICIEMBRE: 12,
};

const FLOOR_PATTERNS = [
  { re: /\b1\s*(ER)?\s*P(ISO|SIO)\b/, floor: 1 },
  { re: /\b2\s*(DO)?\s*P(ISO|SIO)\b/, floor: 2 },
  { re: /\b3\s*(ER)?\s*P(ISO|SIO)\b/, floor: 3 },
];

function detectarPiso(conceptoNorm) {
  for (const { re, floor } of FLOOR_PATTERNS) if (re.test(conceptoNorm)) return floor;
  return null;
}

function clasificarConcepto(conceptoRaw) {
  const concepto = String(conceptoRaw).trim();
  const norm = normalize(concepto);

  if (concepto === 'LUZ') return { nivel: 'puesto', conceptoNombre: 'Luz' };
  if (concepto === 'AGUA') return { nivel: 'puesto', conceptoNombre: 'Agua' };
  if (concepto === 'G. ADM') return { nivel: 'puesto', conceptoNombre: 'Gastos administrativos' };
  if (concepto === 'P. SOCIAL') return { nivel: 'puesto', conceptoNombre: 'Previsión social' };
  if (concepto === 'FUMIGACION') return { nivel: 'puesto', conceptoNombre: 'Otros' };
  if (concepto === 'DERECHO DE NUEVO SOCIO') return { nivel: 'omitir', motivo: 'DERECHO DE NUEVO SOCIO solo aplica a Garcia Lucia (excluida)' };
  if (norm.startsWith('MULTA')) return { nivel: 'socio', conceptoNombre: 'Multa' };
  if (norm.startsWith('PAGO EXTRAORDINARIO')) return { nivel: 'socio', conceptoNombre: 'Aporte extraordinario' };
  if (/^P\.?\s*S\.?\s*X\s*FALL/.test(norm) || norm.includes('FALLECIMIENTO')) return { nivel: 'socio', conceptoNombre: 'Fallecimiento de socio' };
  if (norm === 'DEPOSITO' || norm.startsWith('DEPOSITO')) return { nivel: 'almacen', conceptoNombre: norm === 'DEPOSITO' ? 'Deposito' : 'Alquiler' };

  return { nivel: 'desconocido' };
}

// ─── Empate de socios (idéntico a generar_migracion_mayo_2026.js) ──────────
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
    const s = indice.find((x) => x.id === MANUAL_MAP[norm]);
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
    supabase.from('socios').select('id, apellidos').is('deleted_at', null),
    supabase.from('historial_titularidad').select('socio_id, puesto_id').is('fecha_fin', null),
    supabase.from('puestos').select('id, codigo_puesto, tipo_espacio'),
    supabase.from('ocupaciones_almacenes').select('socio_id, puesto_id').is('fecha_fin', null),
    supabase.from('conceptos').select('id, nombre'),
  ]);
  for (const e of [e1, e2, e3, e4, e5]) if (e) throw e;

  const tipoEspacioPorPuesto = new Map(puestos.map((p) => [p.id, p.tipo_espacio]));
  const codigoPorPuesto = new Map(puestos.map((p) => [p.id, p.codigo_puesto]));
  const conceptoIdPorNombre = new Map(conceptos.map((c) => [c.nombre, c.id]));

  const puestoPrincipalPorSocio = new Map();
  for (const h of historial) {
    if (tipoEspacioPorPuesto.get(h.puesto_id) !== 'Almacen') puestoPrincipalPorSocio.set(h.socio_id, h.puesto_id);
  }

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
    if (r.socio) empateNombre.set(nombre, r.socio);
    else if (r.metodo === 'ambiguo') ambiguos.push({ nombre, candidatos: r.candidatos.map((c) => `${c.id}:${c.apellidos}`) });
    else sinMatch.push(nombre);
  }

  console.log(`\nSocios distintos en Excel: ${nombresExcel.length} | Empatados: ${empateNombre.size}`);
  if (excluidos.length) {
    console.log(`EXCLUIDOS (${excluidos.length}):`);
    excluidos.forEach((e) => console.log(`  "${e.nombre}" -> ${e.motivo}`));
  }
  if (ambiguos.length) {
    console.log(`\nAMBIGUOS (${ambiguos.length}):`);
    ambiguos.forEach((a) => console.log(`  "${a.nombre}" -> ${a.candidatos.join(' | ')}`));
  }
  if (sinMatch.length) {
    console.log(`\nSIN MATCH (${sinMatch.length}) — agregar a MANUAL_MAP:`);
    sinMatch.forEach((n) => console.log(`  "${normalize(n)}": <id_socio>, // ${n}`));
  }
  if (ambiguos.length || sinMatch.length) {
    console.log('\nAbortando: hay socios sin empatar. Completa MANUAL_MAP y vuelve a ejecutar.');
    process.exit(1);
  }

  // ─── Clasificación de cada fila ───────────────────────────────────────────
  const lineasValidas = [];
  const omitidas = [];
  const desconocidas = [];

  for (const row of rows) {
    const nombreExcel = String(row['Socio']).trim();
    if (!empateNombre.has(nombreExcel)) continue; // excluido (ver EXCLUIR_SOCIOS)
    const socio = empateNombre.get(nombreExcel);
    const concepto = String(row['Concepto']).trim();
    const conceptoNorm = normalize(concepto);
    const monto = Number(row['Monto pagado']);
    const periodoTexto = normalize(String(row['Periodo']).trim());
    const periodoMes = PERIODO_MES[periodoTexto];
    const periodoAnio = Number(row['Año periodo']);
    const nroRecibo = String(row['Nro recibo']).trim();

    if (!(monto > 0)) { omitidas.push(`${nombreExcel} / ${concepto} / recibo ${nroRecibo}: monto inválido (${row['Monto pagado']})`); continue; }
    if (!periodoMes) { omitidas.push(`${nombreExcel} / ${concepto} / recibo ${nroRecibo}: periodo "${row['Periodo']}" no reconocido`); continue; }

    const clasificacion = clasificarConcepto(concepto);

    if (clasificacion.nivel === 'omitir') { omitidas.push(`${nombreExcel} / ${concepto} / recibo ${nroRecibo}: ${clasificacion.motivo}`); continue; }
    if (clasificacion.nivel === 'desconocido') { desconocidas.push(`${nombreExcel} / "${concepto}" / recibo ${nroRecibo} (S/ ${monto})`); continue; }

    let targetTipo, targetId, conceptoNombre = clasificacion.conceptoNombre;

    if (clasificacion.nivel === 'puesto') {
      targetTipo = 'puesto';
      targetId = puestoPrincipalPorSocio.get(socio.id);
      if (!targetId) { omitidas.push(`${nombreExcel} / ${concepto}: sin puesto principal activo`); continue; }
    } else if (clasificacion.nivel === 'socio') {
      targetTipo = 'socio';
      targetId = socio.id;
    } else if (clasificacion.nivel === 'almacen') {
      const candidatos = almacenesPorSocio.get(socio.id) || [];
      let puestoId = null;
      if (candidatos.length === 1) puestoId = candidatos[0].puesto_id;
      else if (candidatos.length > 1) {
        const piso = detectarPiso(conceptoNorm);
        if (piso !== null) {
          const m = candidatos.filter((c) => c.codigo && c.codigo.endsWith(`-D${piso}`));
          if (m.length === 1) puestoId = m[0].puesto_id;
        }
      }
      if (!puestoId) puestoId = PUESTO_OVERRIDE_DEPOSITO[`${nombreExcel}::${concepto}`] || null;
      if (!puestoId) { omitidas.push(`${nombreExcel} / "${concepto}" (S/ ${monto}): ${candidatos.length} ocupación(es) de almacén activa(s) — ${candidatos.map((c) => c.codigo).join(', ') || 'ninguna'}`); continue; }
      targetTipo = 'puesto';
      targetId = puestoId;
    }

    const puestoPagoId = puestoPrincipalPorSocio.get(socio.id);
    if (!puestoPagoId) { omitidas.push(`${nombreExcel} / ${concepto}: socio sin puesto principal (requerido por public.pagos.puesto_id)`); continue; }

    lineasValidas.push({
      nroRecibo,
      socioId: socio.id,
      socioNombre: nombreExcel,
      puestoPagoId,
      fechaPago: excelSerialToDate(row['Fecha pago']),
      targetTipo,
      targetId,
      conceptoId: conceptoIdPorNombre.get(conceptoNombre),
      conceptoNombre,
      periodoAnio,
      periodoMes,
      monto,
      conceptoOriginal: concepto,
    });
  }

  console.log(`\nLíneas válidas: ${lineasValidas.length} / ${rows.length}`);
  if (omitidas.length) {
    console.log(`\nOMITIDAS (${omitidas.length}):`);
    omitidas.forEach((m) => console.log('  ' + m));
  }
  if (desconocidas.length) {
    console.log(`\nCONCEPTOS DESCONOCIDOS (${desconocidas.length}) — revisar clasificarConcepto():`);
    desconocidas.forEach((m) => console.log('  ' + m));
    console.log('\nAbortando generación de SQL hasta resolver los conceptos desconocidos.');
    process.exit(1);
  }

  const totalMonto = lineasValidas.reduce((acc, l) => acc + l.monto, 0);
  console.log(`\nMonto total a registrar: S/ ${totalMonto.toFixed(2)}`);

  // ─── Total a pagar por cada deuda (para crearla con el monto correcto si no existe) ─
  const totalPorDeuda = new Map();
  for (const l of lineasValidas) {
    const key = `${l.targetTipo}|${l.targetId}|${l.conceptoId}|${l.periodoAnio}|${l.periodoMes}`;
    totalPorDeuda.set(key, (totalPorDeuda.get(key) || 0) + l.monto);
  }

  // ─── Agrupación por recibo (Nro recibo + Socio) ───────────────────────────
  const recibos = new Map();
  for (const l of lineasValidas) {
    const key = `${l.nroRecibo}::${l.socioNombre}`;
    const grupo = recibos.get(key) || { ...l, lineas: [] };
    grupo.lineas.push(l);
    recibos.set(key, grupo);
  }
  const gruposOrdenados = [...recibos.values()].sort((a, b) => a.fechaPago.localeCompare(b.fechaPago) || a.nroRecibo.localeCompare(b.nroRecibo));
  console.log(`Recibos (pagos) a crear: ${gruposOrdenados.length}`);

  // ─── Generación del SQL ────────────────────────────────────────────────────
  const lines = [];
  lines.push('-- =============================================================================');
  lines.push('-- Migración 00074: Carga de pagos consolidados de Junio 2026');
  lines.push('-- Cooperativa Primero de Mayo · SistemaCooperativa');
  lines.push(`-- Generado: ${new Date().toISOString().slice(0, 10)} desde scripts/generar_migracion_pagos_junio.js`);
  lines.push(`-- Fuente: ${EXCEL_PATH} (hoja "${SHEET_NAME}")`);
  lines.push(`-- Recibos: ${gruposOrdenados.length} | Líneas: ${lineasValidas.length} | Monto total: S/ ${totalMonto.toFixed(2)}`);
  lines.push('-- GARCIA LUCIA excluida explícitamente.');
  lines.push('-- Las deudas se resuelven dinámicamente: si no existen al momento de aplicar este');
  lines.push('-- archivo se crean en Pendiente (requiere que la migración 00073 ya se haya aplicado');
  lines.push('-- para los cargos de Mayo 2026, dado el orden secuencial de migraciones).');
  lines.push('-- =============================================================================');
  lines.push('');
  lines.push('BEGIN;');
  lines.push('');
  lines.push('DO $$');
  lines.push('DECLARE');
  lines.push('    v_user_uuid uuid;');
  lines.push('BEGIN');
  lines.push("    SELECT id INTO v_user_uuid FROM public.perfiles WHERE rol = 'Administrador' AND activo = true LIMIT 1;");
  lines.push('    IF v_user_uuid IS NULL THEN');
  lines.push("        v_user_uuid := '00000000-0000-0000-0000-000000000000';");
  lines.push('    END IF;');
  lines.push("    PERFORM set_config('request.jwt.claims', json_build_object('sub', v_user_uuid::text, 'role', 'authenticated')::text, true);");
  lines.push('');

  for (const grupo of gruposOrdenados) {
    lines.push(`    -- ===== Recibo ${grupo.nroRecibo} — ${grupo.socioNombre} (${grupo.fechaPago}) =====`);
    lines.push('    DECLARE');
    lines.push('        v_pago_id bigint;');
    lines.push('        v_monto_id bigint;');
    lines.push('        v_monto numeric;');
    lines.push('        v_estado text;');
    lines.push('        v_aplicado numeric;');
    lines.push('    BEGIN');
    lines.push(`        IF NOT EXISTS (SELECT 1 FROM public.pagos WHERE comprobante = ${esc(grupo.nroRecibo)} AND puesto_id = ${grupo.puestoPagoId} AND deleted_at IS NULL) THEN`);
    lines.push('            INSERT INTO public.pagos (socio_id, puesto_id, fecha_pago, monto_total, metodo_pago, comprobante, observacion, created_by)');
    lines.push(`            VALUES (${grupo.socioId}, ${grupo.puestoPagoId}, ${esc(grupo.fechaPago)}, ${grupo.lineas.reduce((a, l) => a + l.monto, 0).toFixed(2)}, ${esc(METODO_PAGO_DEFAULT)}, ${esc(grupo.nroRecibo)}, 'Migración de pagos Junio 2026', v_user_uuid)`);
    lines.push('            RETURNING id INTO v_pago_id;');
    lines.push('        ELSE');
    lines.push(`            SELECT id INTO v_pago_id FROM public.pagos WHERE comprobante = ${esc(grupo.nroRecibo)} AND puesto_id = ${grupo.puestoPagoId} AND deleted_at IS NULL LIMIT 1;`);
    lines.push(`            RAISE NOTICE 'Recibo ${grupo.nroRecibo} ya existía como pago id %, reutilizando', v_pago_id;`);
    lines.push('        END IF;');
    lines.push('');

    for (const l of grupo.lineas) {
      const whereClave = l.targetTipo === 'puesto'
        ? `puesto_id = ${l.targetId} AND concepto_id = ${l.conceptoId} AND periodo_anio = ${l.periodoAnio} AND periodo_mes = ${l.periodoMes}`
        : `socio_id = ${l.targetId} AND concepto_id = ${l.conceptoId} AND periodo_anio = ${l.periodoAnio} AND periodo_mes = ${l.periodoMes}`;
      const insertCols = l.targetTipo === 'puesto'
        ? `puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by`
        : `socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by`;
      const key = `${l.targetTipo}|${l.targetId}|${l.conceptoId}|${l.periodoAnio}|${l.periodoMes}`;
      const montoSiNoExiste = totalPorDeuda.get(key).toFixed(2);
      const insertVals = l.targetTipo === 'puesto'
        ? `${l.targetId}, ${l.conceptoId}, ${l.periodoAnio}, ${l.periodoMes}, ${montoSiNoExiste}, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (${l.conceptoOriginal})', v_user_uuid`
        : `${l.targetId}, ${l.conceptoId}, ${l.periodoAnio}, ${l.periodoMes}, ${montoSiNoExiste}, 'Pendiente', 'Manual', CURRENT_DATE, 'Deuda generada por reconciliación de pago Junio 2026 (${l.conceptoOriginal})', v_user_uuid`;

      lines.push(`        -- ${l.conceptoOriginal} (${l.conceptoNombre}) periodo ${l.periodoMes}/${l.periodoAnio} — S/ ${l.monto.toFixed(2)}`);
      lines.push(`        SELECT id, monto, estado INTO v_monto_id, v_monto, v_estado FROM public.montos_por_cobrar WHERE ${whereClave} AND deleted_at IS NULL;`);
      lines.push('        IF v_monto_id IS NULL THEN');
      lines.push(`            INSERT INTO public.montos_por_cobrar (${insertCols})`);
      lines.push(`            VALUES (${insertVals})`);
      lines.push('            RETURNING id, monto, estado INTO v_monto_id, v_monto, v_estado;');
      lines.push('        END IF;');
      lines.push(`        IF NOT EXISTS (SELECT 1 FROM public.detalle_pagos WHERE pago_id = v_pago_id AND monto_id = v_monto_id AND deleted_at IS NULL) THEN`);
      lines.push(`            INSERT INTO public.detalle_pagos (pago_id, monto_id, monto_aplicado, created_by) VALUES (v_pago_id, v_monto_id, ${l.monto.toFixed(2)}, v_user_uuid);`);
      lines.push('        END IF;');
      lines.push('        SELECT COALESCE(SUM(monto_aplicado), 0) INTO v_aplicado FROM public.detalle_pagos WHERE monto_id = v_monto_id AND deleted_at IS NULL;');
      lines.push("        UPDATE public.montos_por_cobrar SET estado = CASE WHEN v_aplicado >= monto THEN 'Pagado' ELSE 'Pendiente' END WHERE id = v_monto_id;");
      lines.push('');
    }

    lines.push('    END;');
    lines.push('');
  }

  lines.push('END $$;');
  lines.push('');
  lines.push('COMMIT;');
  lines.push('');

  fs.mkdirSync(path.dirname(OUTPUT_SQL), { recursive: true });
  fs.writeFileSync(OUTPUT_SQL, lines.join('\n'));
  console.log(`\nSQL generado: ${OUTPUT_SQL}`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
