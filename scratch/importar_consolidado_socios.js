// Reconciliación de deudas de socios contra el archivo consolidado revisado.
// Modo por defecto: SOLO ANÁLISIS (no escribe nada en la BD ni genera SQL).
// Uso:
//   node scratch/importar_consolidado_socios.js                -> análisis + reporte
//   node scratch/importar_consolidado_socios.js --generate-sql -> además escribe supabase/migrations/00064_...sql
const fs = require('fs');
const path = require('path');
const XLSX = require('xlsx');
const { createClient } = require('@supabase/supabase-js');

const GENERATE_SQL = process.argv.includes('--generate-sql');
const EXCEL_FILE = 'migracion_coop/2026/SOCIOS - CONSOLIDADO POR COBRAR REVISADO.xlsx';
const SHEET = 'Detalle por cobrar';
const MIGRATION_PATH = 'supabase/migrations/00064_reconciliacion_consolidado_socios.sql';
const ADMIN_UUID_FALLBACK = '00000000-0000-0000-0000-000000000000';
const OBS_PREFIX = 'Reconciliación 2026 (consolidado revisado)';
const DELETE_REASON = 'Anulado por reconciliación consolidada (consolidado revisado, sin pagos aplicados)';

// ---------------------------------------------------------------------------
// Conexión
// ---------------------------------------------------------------------------
const envFile = fs.readFileSync('.env', 'utf8');
const envVars = {};
envFile.split('\n').forEach(line => {
  const m = line.match(/^\s*([^#=\s]+)\s*=\s*(.*)\s*$/);
  if (m) {
    let v = m[2].trim();
    if (/^["']/.test(v) && /["']$/.test(v)) v = v.slice(1, -1);
    envVars[m[1]] = v;
  }
});
const supabase = createClient(envVars.SUPABASE_URL, envVars.SUPABASE_SERVICE_ROLE_KEY);

// ---------------------------------------------------------------------------
// Utilidades de texto / matching de socios (mismo criterio que reconcile_check.js)
// ---------------------------------------------------------------------------
function normalizar(texto) {
  if (!texto) return '';
  return texto.toString()
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .toUpperCase()
    .trim()
    .replace(/\s+/g, ' ');
}

function mejorMatchSocio(nombreExcel, socios) {
  const norm = normalizar(nombreExcel);
  const partes = norm.split(' ').filter(w => w.length > 2);
  let mejor = null;
  let mejorScore = 0;
  for (const s of socios) {
    const dbNorm = normalizar(`${s.apellidos} ${s.nombres}`);
    let coincidencias = 0;
    for (const p of partes) if (dbNorm.includes(p)) coincidencias++;
    if (coincidencias > mejorScore) { mejorScore = coincidencias; mejor = s; }
  }
  // Exigimos al menos 2 palabras coincidentes para aceptar el match
  return mejorScore >= 2 ? { socio: mejor, score: mejorScore } : { socio: null, score: mejorScore };
}

// ---------------------------------------------------------------------------
// Mapeo heurístico de "Concepto" (texto libre del Excel) -> concepto_id de la BD
// Tabla `conceptos`: 1 Luz · 2 Agua · 3 Gastos administrativos · 4 Previsión social
//                    5 Mantenimiento · 6 Multa · 7 Aporte extraordinario
//                    8 Deuda anterior · 9 Ajuste manual · 16 Deposito · 19 Fallecimiento de socio
// ---------------------------------------------------------------------------
function mapConcepto(rawConcepto) {
  const c = normalizar(rawConcepto);
  if (c === 'LUZ') return { id: 1, nombre: 'Luz' };
  if (c === 'AGUA') return { id: 2, nombre: 'Agua' };
  if (c === 'G. ADM' || c === 'G ADM' || c === 'GASTOS ADMINISTRATIVOS') return { id: 3, nombre: 'Gastos administrativos' };
  if (c === 'P. SOCIAL' || c === 'P SOCIAL' || c === 'PREVISION SOCIAL') return { id: 4, nombre: 'Previsión social' };
  if (c.startsWith('DEPOSITO')) return { id: 16, nombre: 'Deposito' };
  if (c.startsWith('MULTA')) return { id: 6, nombre: 'Multa' };
  if (/^P\.?\s*S\.?\s*X\s*FALL/.test(c)) return { id: 19, nombre: 'Fallecimiento de socio' };
  if (c === 'AJUSTE SALDO FINAL' || c.startsWith('AJUSTE')) return { id: 9, nombre: 'Ajuste manual' };
  if (c.startsWith('PAGO EXTRAORDINARIO')) return { id: 7, nombre: 'Aporte extraordinario' };
  // Sin mapeo confiable: FUMIGACION, TALONARIO *, etc. -> se reportan para revisión manual
  return null;
}

// ---------------------------------------------------------------------------
// Periodo: la columna "Fecha" trae el serial de Excel correspondiente al
// último día del mes del periodo (ej. 46142 -> 2026-04-30, Periodo="ABRIL").
// Se usa como fuente de verdad de año/mes (más fiable que parsear "Periodo").
// ---------------------------------------------------------------------------
function derivarPeriodo(fechaSerial) {
  const n = Number(fechaSerial);
  if (!n || Number.isNaN(n)) return null;
  const d = XLSX.SSF.parse_date_code(n);
  return { anio: d.y, mes: d.m };
}

const MESES = ['', 'ENERO', 'FEBRERO', 'MARZO', 'ABRIL', 'MAYO', 'JUNIO', 'JULIO',
  'AGOSTO', 'SETIEMBRE', 'OCTUBRE', 'NOVIEMBRE', 'DICIEMBRE'];

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------
async function main() {
  // 1) Cargar Excel
  const wb = XLSX.readFile(EXCEL_FILE);
  const ws = wb.Sheets[SHEET];
  const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' }).slice(1);
  console.log(`Excel: ${rows.length} filas en hoja "${SHEET}"`);

  // 2) Cargar catálogos de la BD
  const { data: socios, error: errS } = await supabase
    .from('socios').select('id, dni, nombres, apellidos').is('deleted_at', null);
  if (errS) throw errS;

  const { data: hist, error: errH } = await supabase
    .from('historial_titularidad').select('socio_id, puesto_id').is('fecha_fin', null);
  if (errH) throw errH;
  const puestoActivoPorSocio = {};
  hist.forEach(h => { puestoActivoPorSocio[h.socio_id] = h.puesto_id; });

  const { data: puestos, error: errP } = await supabase
    .from('puestos').select('id, codigo_puesto');
  if (errP) throw errP;
  const codigoPorPuesto = {};
  puestos.forEach(p => { codigoPorPuesto[p.id] = p.codigo_puesto; });

  let { data: adminPerfil } = await supabase
    .from('perfiles').select('id').eq('rol', 'Administrador').eq('activo', true).limit(1);
  const ADMIN_UUID = (adminPerfil && adminPerfil[0]) ? adminPerfil[0].id : ADMIN_UUID_FALLBACK;

  // 3) Procesar filas del Excel: matching + mapeo + agregación por clave única
  const sociosNoEncontrados = new Map();   // nombreExcel -> count
  const sociosSinPuesto = new Map();       // socioId -> {nombre, count}
  const conceptosSinMapear = new Map();    // conceptoRaw -> count
  const fechasInvalidas = [];

  // clave = `${puesto_id}_${concepto_id}_${anio}_${mes}` -> { monto, observTexto, socioId, puestoId, conceptoId, anio, mes, fuentes:Set }
  const excelAgrupado = new Map();

  for (let i = 0; i < rows.length; i++) {
    const r = rows[i];
    const nombreSocio = String(r[1] || '').trim();
    const conceptoRaw = String(r[5] || '').trim();
    const monto = Number(r[6]) || 0;
    if (!nombreSocio || !conceptoRaw) continue;

    const { socio } = mejorMatchSocio(nombreSocio, socios);
    if (!socio) {
      sociosNoEncontrados.set(nombreSocio, (sociosNoEncontrados.get(nombreSocio) || 0) + 1);
      continue;
    }
    const puestoId = puestoActivoPorSocio[socio.id];
    if (!puestoId) {
      sociosSinPuesto.set(socio.id, { nombre: `${socio.apellidos} ${socio.nombres}`, count: (sociosSinPuesto.get(socio.id)?.count || 0) + 1 });
      continue;
    }

    const periodo = derivarPeriodo(r[2]);
    if (!periodo) { fechasInvalidas.push({ fila: i + 2, nombreSocio, fecha: r[2] }); continue; }

    const concepto = mapConcepto(conceptoRaw);
    if (!concepto) {
      conceptosSinMapear.set(conceptoRaw, (conceptosSinMapear.get(conceptoRaw) || 0) + 1);
      continue;
    }

    const key = `${puestoId}_${concepto.id}_${periodo.anio}_${periodo.mes}`;
    if (!excelAgrupado.has(key)) {
      excelAgrupado.set(key, {
        puestoId, conceptoId: concepto.id, conceptoNombre: concepto.nombre,
        anio: periodo.anio, mes: periodo.mes, socioId: socio.id,
        socioNombre: `${socio.apellidos} ${socio.nombres}`,
        montoExcel: 0, conceptosOriginales: new Set(),
      });
    }
    const acc = excelAgrupado.get(key);
    acc.montoExcel += monto;
    acc.conceptosOriginales.add(conceptoRaw);
  }

  console.log(`\n=== RESULTADO DE MATCHING / MAPEO ===`);
  console.log(`Claves agregadas (puesto+concepto+periodo) a reconciliar: ${excelAgrupado.size}`);
  console.log(`Socios del Excel sin match en BD: ${sociosNoEncontrados.size}`);
  [...sociosNoEncontrados.entries()].forEach(([n, c]) => console.log(`   - "${n}" (${c} filas)`));
  console.log(`Socios con match pero sin puesto activo: ${sociosSinPuesto.size}`);
  [...sociosSinPuesto.values()].forEach(v => console.log(`   - ${v.nombre} (${v.count} filas)`));
  console.log(`Fechas inválidas/no parseables: ${fechasInvalidas.length}`);
  fechasInvalidas.forEach(f => console.log(`   - Fila ${f.fila} (${f.nombreSocio}): "${f.fecha}"`));
  console.log(`Conceptos SIN mapeo confiable (no se tocarán, requieren revisión manual): ${conceptosSinMapear.size}`);
  [...conceptosSinMapear.entries()].sort((a, b) => b[1] - a[1]).forEach(([c, n]) => console.log(`   - "${c}" (${n} filas)`));

  // 4) Cargar montos_por_cobrar activos de los puestos involucrados (para diff y para detectar "huérfanos")
  const puestoIds = [...new Set([...excelAgrupado.values()].map(v => v.puestoId))];
  const deudasActivas = await fetchAllPaged(
    () => supabase
      .from('montos_por_cobrar')
      .select('id, puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, observacion')
      .in('puesto_id', puestoIds)
      .is('deleted_at', null)
  );
  console.log(`Deudas activas cargadas para ${puestoIds.length} puestos: ${deudasActivas.length}`);

  const deudaPorClave = new Map();
  deudasActivas.forEach(d => {
    deudaPorClave.set(`${d.puesto_id}_${d.concepto_id}_${d.periodo_anio}_${d.periodo_mes}`, d);
  });

  // Carga masiva (paginada) de detalle_pagos para TODOS los monto_id activos de
  // estos puestos, evitando el patrón N+1 (una consulta por registro era inviable
  // con ~4000 registros: ronda de red por cada uno).
  const montoIds = deudasActivas.map(d => d.id);
  const pagadoPorMontoId = new Map();
  for (let i = 0; i < montoIds.length; i += 300) {
    const chunk = montoIds.slice(i, i + 300);
    const { data, error } = await supabase
      .from('detalle_pagos')
      .select('monto_id, monto_aplicado')
      .in('monto_id', chunk)
      .is('deleted_at', null);
    if (error) throw error;
    (data || []).forEach(p => {
      pagadoPorMontoId.set(p.monto_id, round2((pagadoPorMontoId.get(p.monto_id) || 0) + Number(p.monto_aplicado)));
    });
  }
  console.log(`detalle_pagos cargados (activos) para ${montoIds.length} montos: ${[...pagadoPorMontoId.values()].length} con pagos`);

  const montoPagado = (montoId) => pagadoPorMontoId.get(montoId) || 0;

  // Solo se automatizan los 4 conceptos "limpios" (Luz, Agua, G.Adm, P.Social):
  // su mapeo Excel -> concepto_id es 1:1 estable. Para conceptos "exóticos"
  // (Depósito, Multa, Aporte extraordinario, Ajuste manual, Fallecimiento, etc.)
  // la propia BD usa concepto_id inconsistentes para descripciones equivalentes
  // (p.ej. "depósito" aparece bajo concepto_id 7, 16 y 18 en distintos registros),
  // por lo que la clave (puesto+concepto_id+periodo) no es fiable: automatizar
  // generaría inserciones duplicadas y soft-deletes erróneos. Se reportan aparte
  // para revisión manual, sin tocar la BD.
  const CONCEPTOS_AUTOMATIZABLES = new Set([1, 2, 3, 4]);

  const aActualizar = [];   // {deuda, montoOriginalNuevo, montoPagado, estadoNuevo, obs}
  const aInsertar = [];     // {puestoId, conceptoId, anio, mes, monto, obs, socioNombre}
  const sinCambios = [];
  const exoticosExcel = []; // grupos del Excel con concepto exótico (no se tocan)

  for (const grupo of excelAgrupado.values()) {
    if (!CONCEPTOS_AUTOMATIZABLES.has(grupo.conceptoId)) {
      exoticosExcel.push(grupo);
      continue;
    }
    const key = `${grupo.puestoId}_${grupo.conceptoId}_${grupo.anio}_${grupo.mes}`;
    const existente = deudaPorClave.get(key);
    const obsTexto = `${OBS_PREFIX} - ${grupo.conceptoNombre.toUpperCase()}`;
    if (existente) {
      const pagado = montoPagado(existente.id);
      const montoOriginalNuevo = round2(grupo.montoExcel + pagado);
      const saldoRestante = round2(montoOriginalNuevo - pagado);
      const estadoNuevo = saldoRestante <= 0 ? 'Pagado' : 'Pendiente';
      if (Math.abs(montoOriginalNuevo - Number(existente.monto)) > 0.001 || existente.estado !== estadoNuevo) {
        aActualizar.push({ existente, grupo, montoOriginalNuevo, pagado, estadoNuevo, obsTexto });
      } else {
        sinCambios.push({ existente, grupo });
      }
      deudaPorClave.delete(key); // lo que sobra al final son "huérfanos" (no presentes en Excel)
    } else {
      aInsertar.push({ grupo, monto: round2(grupo.montoExcel), obsTexto });
    }
  }

  // 5) Huérfanos: el consolidado es un reporte de SALDOS PENDIENTES (no un ledger
  // completo) — los registros 'Pagado' faltan en el Excel legítimamente y NO son
  // huérfanos. Solo es señal real de discrepancia un registro 2026 que la BD aún
  // considera 'Pendiente' (con saldo > 0) pero que el consolidado ya no incluye.
  // Se restringe a conceptos automatizables por la misma razón de fiabilidad de clave.
  const huerfanosSinPago = [];
  const huerfanosConPago = [];
  const exoticosHuerfanosCandidatos = []; // deudas pendientes 2026 de concepto exótico ausentes del Excel (solo informativo)
  for (const d of deudaPorClave.values()) {
    if (d.periodo_anio !== 2026) continue; // alcance: solo deudas 2026 de socios (según instrucción del usuario)
    const pagado = montoPagado(d.id);
    const saldo = round2(Number(d.monto) - pagado);
    if (d.estado !== 'Pendiente' || saldo <= 0) continue; // ya saldado: ausencia esperada, no es huérfano
    if (!CONCEPTOS_AUTOMATIZABLES.has(d.concepto_id)) {
      exoticosHuerfanosCandidatos.push({ d, pagado });
      continue;
    }
    if (pagado > 0) huerfanosConPago.push({ d, pagado });
    else huerfanosSinPago.push(d);
  }

  // 6) Reporte
  console.log(`\n=== DIFF CONTRA BD (montos_por_cobrar activos) ===`);
  console.log(`Sin cambios:                         ${sinCambios.length}`);
  console.log(`A actualizar (monto/estado difiere): ${aActualizar.length}`);
  aActualizar.forEach(x => {
    console.log(`   - id=${x.existente.id} puesto=${codigoPorPuesto[x.grupo.puestoId]} (${x.grupo.socioNombre}) `
      + `${x.grupo.anio}-${String(x.grupo.mes).padStart(2, '0')} ${x.grupo.conceptoNombre}: `
      + `monto ${x.existente.monto} -> ${x.montoOriginalNuevo} (pagado=${x.pagado}, saldo=${round2(x.montoOriginalNuevo - x.pagado)}, estado ${x.existente.estado} -> ${x.estadoNuevo})`);
  });
  console.log(`A insertar (no existe en BD):        ${aInsertar.length}`);
  aInsertar.forEach(x => {
    console.log(`   - puesto=${codigoPorPuesto[x.grupo.puestoId]} (${x.grupo.socioNombre}) `
      + `${x.grupo.anio}-${String(x.grupo.mes).padStart(2, '0')} ${x.grupo.conceptoNombre}: monto=${x.monto}`);
  });
  console.log(`Huérfanos 2026 SIN pagos (candidatos a soft-delete): ${huerfanosSinPago.length}`);
  huerfanosSinPago.forEach(d => {
    console.log(`   - id=${d.id} puesto=${codigoPorPuesto[d.puesto_id]} ${d.periodo_anio}-${String(d.periodo_mes).padStart(2, '0')} concepto_id=${d.concepto_id} monto=${d.monto} obs="${(d.observacion || '').slice(0, 60)}"`);
  });
  console.log(`Huérfanos 2026 CON pagos aplicados (NO se tocan, revisar a mano): ${huerfanosConPago.length}`);
  huerfanosConPago.forEach(({ d, pagado }) => {
    console.log(`   - id=${d.id} puesto=${codigoPorPuesto[d.puesto_id]} ${d.periodo_anio}-${String(d.periodo_mes).padStart(2, '0')} concepto_id=${d.concepto_id} monto=${d.monto} pagado=${pagado} obs="${(d.observacion || '').slice(0, 60)}"`);
  });

  console.log(`\n=== CONCEPTOS EXÓTICOS — SOLO INFORME, NO SE AUTOMATIZAN (revisión manual) ===`);
  console.log(`Filas del Excel con concepto exótico (Depósito/Multa/Aporte extr./Ajuste/Fallecimiento/...): ${exoticosExcel.length} grupos`);
  const porConceptoExotico = new Map();
  exoticosExcel.forEach(g => porConceptoExotico.set(g.conceptoNombre, (porConceptoExotico.get(g.conceptoNombre) || 0) + 1));
  [...porConceptoExotico.entries()].forEach(([n, c]) => console.log(`   - ${n}: ${c} grupos`));
  console.log(`Deudas 'Pendiente' 2026 de concepto exótico que la BD tiene activas pero no aparecen claramente en el Excel: ${exoticosHuerfanosCandidatos.length}`);
  exoticosHuerfanosCandidatos.forEach(({ d, pagado }) => {
    console.log(`   - id=${d.id} puesto=${codigoPorPuesto[d.puesto_id]} ${d.periodo_anio}-${String(d.periodo_mes).padStart(2, '0')} concepto_id=${d.concepto_id} monto=${d.monto} pagado=${pagado} obs="${(d.observacion || '').slice(0, 70)}"`);
  });

  const totalExcel = round2([...excelAgrupado.values()].reduce((s, g) => s + g.montoExcel, 0));
  console.log(`\nTotal "por cobrar" agregado del Excel (filas mapeadas): S/ ${totalExcel}`);

  // 7) Generar SQL si se pidió
  if (GENERATE_SQL) {
    const sql = generarSQL({ aActualizar, aInsertar, huerfanosSinPago, ADMIN_UUID });
    fs.writeFileSync(MIGRATION_PATH, sql, 'utf8');
    console.log(`\nSQL de migración escrito en: ${MIGRATION_PATH}`);
    console.log(`Revisa el archivo ANTES de ejecutarlo contra la base de datos remota.`);
  } else {
    console.log(`\n(Modo análisis. Ejecuta con --generate-sql para escribir ${MIGRATION_PATH})`);
  }
}

// PostgREST/Supabase devuelve como máximo 1000 filas por consulta por defecto.
// Sin paginar, las consultas grandes se truncan silenciosamente (causa real de
// falsos "no existe" durante el diff). Se pagina con .range() hasta agotar.
async function fetchAllPaged(queryFactory, pageSize = 1000) {
  const all = [];
  let from = 0;
  while (true) {
    const { data, error } = await queryFactory().range(from, from + pageSize - 1);
    if (error) throw error;
    all.push(...data);
    if (data.length < pageSize) break;
    from += pageSize;
  }
  return all;
}

function round2(n) { return Math.round(n * 100) / 100; }

function sqlEscape(s) { return String(s).replace(/'/g, "''"); }

function generarSQL({ aActualizar, aInsertar, huerfanosSinPago, ADMIN_UUID }) {
  const fecha = new Date().toISOString().slice(0, 10);
  let out = '';
  out += `-- =============================================================================\n`;
  out += `-- Migración 00064 — Reconciliación de deudas de socios contra consolidado revisado\n`;
  out += `-- Cooperativa Primero de Mayo · SistemaCooperativa\n`;
  out += `-- Generado automáticamente: ${fecha}\n`;
  out += `-- Fuente: migracion_coop/2026/SOCIOS - CONSOLIDADO POR COBRAR REVISADO.xlsx (Detalle por cobrar)\n`;
  out += `-- MÉTODO: UPDATE para deudas con pagos aplicados (preserva detalle_pagos),\n`;
  out += `--         INSERT para deudas nuevas, soft-delete (deleted_at) para huérfanos sin pagos.\n`;
  out += `-- =============================================================================\n\n`;
  out += `DO $reconciliacion_socios$\n`;
  out += `DECLARE\n`;
  out += `    v_user_uuid uuid := '${ADMIN_UUID}';\n`;
  out += `BEGIN\n`;
  out += `    PERFORM set_config('request.jwt.claims', json_build_object('sub', v_user_uuid::text, 'role', 'authenticated')::text, true);\n\n`;

  if (aActualizar.length) {
    out += `    -- ── Actualizaciones (registros con pagos aplicados u monto/estado desalineado) ──\n`;
    aActualizar.forEach(x => {
      out += `    UPDATE public.montos_por_cobrar\n`;
      out += `       SET monto = ${x.montoOriginalNuevo.toFixed(2)},\n`;
      out += `           estado = '${x.estadoNuevo}',\n`;
      out += `           observacion = '${sqlEscape(x.obsTexto)} (Actualizado)',\n`;
      out += `           updated_at = now()\n`;
      out += `     WHERE id = ${x.existente.id} AND deleted_at IS NULL;\n`;
    });
    out += `\n`;
  }

  if (aInsertar.length) {
    out += `    -- ── Inserciones (deudas presentes en el consolidado pero ausentes en BD) ──\n`;
    aInsertar.forEach(x => {
      out += `    INSERT INTO public.montos_por_cobrar\n`;
      out += `        (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)\n`;
      out += `    VALUES (${x.grupo.puestoId}, ${x.grupo.conceptoId}, ${x.grupo.anio}, ${x.grupo.mes}, ${x.monto.toFixed(2)}, 'Pendiente', 'Manual', `
        + `'${x.grupo.anio}-${String(x.grupo.mes).padStart(2, '0')}-01', '${sqlEscape(x.obsTexto)}', v_user_uuid)\n`;
      out += `    ON CONFLICT (puesto_id, concepto_id, periodo_anio, periodo_mes) WHERE deleted_at IS NULL AND puesto_id IS NOT NULL DO NOTHING;\n`;
    });
    out += `\n`;
  }

  if (huerfanosSinPago.length) {
    out += `    -- ── Soft-delete de deudas 2026 ausentes del consolidado y sin pagos aplicados ──\n`;
    out += `    UPDATE public.montos_por_cobrar\n`;
    out += `       SET deleted_at = now(),\n`;
    out += `           anulado_por = v_user_uuid,\n`;
    out += `           motivo_anulacion = '${sqlEscape(DELETE_REASON)}'\n`;
    out += `     WHERE id IN (${huerfanosSinPago.map(d => d.id).join(', ')})\n`;
    out += `       AND deleted_at IS NULL;\n\n`;
  }

  out += `END $reconciliacion_socios$;\n\n`;
  out += `-- Verificación rápida posterior:\n`;
  out += `-- SELECT count(*) AS pendientes, round(sum(monto)::numeric,2) AS suma\n`;
  out += `--   FROM public.montos_por_cobrar WHERE estado = 'Pendiente' AND deleted_at IS NULL;\n`;
  return out;
}

main().catch(e => { console.error(e); process.exit(1); });
