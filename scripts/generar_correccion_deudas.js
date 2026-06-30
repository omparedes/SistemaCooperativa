/**
 * generar_correccion_deudas.js
 *
 * Sincroniza el estado actual de las deudas en BD ('Pendiente') con el estado
 * exacto definido en "SOCIOS - DEUDA ACTUAL Y CONCEPTOS.xlsx".
 */
'use strict';
const fs = require('fs');
const path = require('path');
const XLSX = require('xlsx');
const { createClient } = require('@supabase/supabase-js');

const EXCEL_PATH = 'migracion_coop/junio/SOCIOS - DEUDA ACTUAL Y CONCEPTOS.xlsx';
const SHEET_NAME = 'Detalle conceptos';
const OUTPUT_SQL = 'supabase/migrations/00078_correccion_deudas_actuales.sql';

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

const MES_MAP = {
  ENERO: 1, FEBRERO: 2, MARZO: 3, ABRIL: 4, MAYO: 5, JUNIO: 6,
  JULIO: 7, AGOSTO: 8, SEPTIEMBRE: 9, SETIEMBRE: 9, OCTUBRE: 10, NOVIEMBRE: 11, DICIEMBRE: 12,
};

const MANUAL_MAP = {
  'CRUZ LUIS': 48,
  'DELA CRUZ JOSE': 55,
  'GUTIERRES CASTRO JORGE': 67,
  'MAYHUASCA CLUDY': 90,
  'PRADO ZOZIMA': 121,
  'TENORIO ALBERTINA': null,
  'GARCIA LUCIA': null
};

function normalize(s) {
  return String(s).normalize('NFD').replace(/[\u0300-\u036f]/g, '')
    .toUpperCase().replace(/[^A-Z0-9\s]/g, ' ').replace(/\s+/g, ' ').trim();
}

function parsearDeposito(concepto) {
  const m = String(concepto).trim().match(/^DEPOSITO\s+(\d+)\s*-\s*D(\d)$/i);
  if (!m) return null;
  return { num: m[1], piso: parseInt(m[2], 10) };
}

async function main() {
  console.log('Leyendo BD...');
  const [
    { data: socios }, { data: historial }, { data: puestos }, { data: ocupaciones },
    { data: conceptos }
  ] = await Promise.all([
    supabase.from('socios').select('id, apellidos, nombres, dni').is('deleted_at', null),
    supabase.from('historial_titularidad').select('socio_id, puesto_id').is('fecha_fin', null),
    supabase.from('puestos').select('id, codigo_puesto, tipo_espacio'),
    supabase.from('ocupaciones_almacenes').select('socio_id, puesto_id').is('fecha_fin', null),
    supabase.from('conceptos').select('id, nombre')
  ]);

  let allDeudasBD = [];
  let page = 0;
  while (true) {
    const { data, error } = await supabase.from('montos_por_cobrar')
      .select('id, puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado, detalle_pagos(monto_aplicado, deleted_at)')
      .is('deleted_at', null)
      .range(page * 1000, (page + 1) * 1000 - 1);
    if (error) throw error;
    if (!data || data.length === 0) break;
    allDeudasBD.push(...data);
    page++;
  }
  const deudasBD = allDeudasBD;

  const cIdPorNombre = new Map(conceptos.map(c => [c.nombre, c.id]));
  const cNombrePorId = new Map(conceptos.map(c => [c.id, c.nombre]));
  const tipoEspacioPorPuesto = new Map(puestos.map(p => [p.id, p.tipo_espacio]));
  const codigoPorPuesto = new Map(puestos.map(p => [p.id, p.codigo_puesto]));

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

  const indiceSocios = socios.map(s => ({
    ...s,
    apellidosNorm: normalize(s.apellidos),
    tokens: new Set(normalize(s.apellidos).split(' ').filter(t => t.length >= 2)),
  }));

  function empatarSocio(nombre) {
    const norm = normalize(nombre);
    if (MANUAL_MAP[norm] !== undefined) {
      if (MANUAL_MAP[norm] === null) return null;
      return indiceSocios.find(x => x.id === MANUAL_MAP[norm]);
    }
    const exacto = indiceSocios.find(s => s.apellidosNorm === norm);
    if (exacto) return exacto;
    const tokensExcel = norm.split(' ').filter(t => t.length >= 2);
    const candidatos = indiceSocios.filter(s => tokensExcel.every(t => s.tokens.has(t)));
    if (candidatos.length === 1) return candidatos[0];
    throw new Error(`Ambigüedad o sin match para socio: ${nombre}`);
  }

  function resolverConceptoId(concepto) {
    const c = String(concepto).trim();
    if (c === 'LUZ' || c === 'USO DE LUZ') return cIdPorNombre.get('Luz');
    if (c === 'AGUA') return cIdPorNombre.get('Agua');
    if (c === 'G. ADM') return cIdPorNombre.get('Gastos administrativos');
    if (c === 'P. SOCIAL') return cIdPorNombre.get('Previsión social');
    if (c.startsWith('DEPOSITO') || c === 'ALQUILER') return cIdPorNombre.get('Deposito');
    if (c === 'FUMIGACION' || c === 'MULTA' || c.startsWith('MULTA')) return cIdPorNombre.get('Otros');
    return cIdPorNombre.get('Otros');
  }

  function resolverPuestoId(socio, concepto) {
    const depositoInfo = parsearDeposito(String(concepto).trim());
    if (depositoInfo) {
      const almacenes = almacenesPorSocio.get(socio.id) || [];
      const sufijo = `${depositoInfo.num}-D${depositoInfo.piso}`;
      const match = almacenes.filter(a => a.codigo && a.codigo.endsWith(sufijo));
      if (match.length === 1) return match[0].puesto_id;
      return null;
    }
    if (String(concepto).trim() === 'DEPOSITO') {
      const almacenes = almacenesPorSocio.get(socio.id) || [];
      if (almacenes.length === 1) return almacenes[0].puesto_id;
      return null;
    }
    return puestoPrincipalPorSocio.get(socio.id) || null;
  }

  console.log('Procesando Excel...');
  const wb = XLSX.readFile(EXCEL_PATH, { raw: false });
  const rows = XLSX.utils.sheet_to_json(wb.Sheets[SHEET_NAME], { defval: '' })
    .filter(r => Number(r['Monto pendiente']) > 0);

  // Mapa de deudas en Excel
  // key: "socio_id|puesto_id|concepto_id|anio|mes"
  const excelDeudas = new Map();
  for (const r of rows) {
    const socioNombre = String(r['Socio']).trim();
    const socio = empatarSocio(socioNombre);
    if (!socio) continue; // Excluido

    const conceptoStr = String(r['Concepto']).trim();
    const concepto_id = resolverConceptoId(conceptoStr);
    const puesto_id = resolverPuestoId(socio, conceptoStr);
    if (!puesto_id) {
      console.warn(`WARNING: No se pudo resolver puesto para ${socio.apellidos} - ${conceptoStr}`);
      continue;
    }

    let periodoAnio = 2026;
    let periodoMesStr = String(r['Periodo']).trim().toUpperCase();
    if (!periodoMesStr) {
      console.warn(`WARNING: Periodo vacío para ${socio.apellidos} - ${conceptoStr}, omitiendo...`);
      continue;
    }
    
    // Check if period is like "DICIEMBRE 2025"
    if (periodoMesStr.includes(' 20')) {
      const parts = periodoMesStr.split(' ');
      periodoMesStr = parts[0];
      periodoAnio = parseInt(parts[1], 10);
    }
    
    const periodo_mes = MES_MAP[periodoMesStr];
    if (!periodo_mes) {
      console.warn(`WARNING: Mes no reconocido: ${periodoMesStr}`);
      continue;
    }

    const montoPendiente = Number(r['Monto pendiente']);
    const key = `${puesto_id}|${concepto_id}|${periodoAnio}|${periodo_mes}`;
    
    if (excelDeudas.has(key)) {
      excelDeudas.get(key).monto += montoPendiente; // Sumar si hay duplicados (raro)
    } else {
      excelDeudas.set(key, { socio, puesto_id, concepto_id, periodoAnio, periodo_mes, monto: montoPendiente, conceptoStr });
    }
  }

  // Mapa de deudas en BD
  const bdDeudas = new Map();
  for (const d of deudasBD) {
    if (!d.puesto_id) continue;
    const yaPagado = (d.detalle_pagos || []).filter(dp => !dp.deleted_at).reduce((acc, dp) => acc + Number(dp.monto_aplicado), 0);
    const saldo = Math.round((Number(d.monto) - yaPagado) * 100) / 100;
    
    const key = `${d.puesto_id}|${d.concepto_id}|${d.periodo_anio}|${d.periodo_mes}`;
    
    // Agrupamos en BD por si hay duplicados también
    if (bdDeudas.has(key)) {
      const exist = bdDeudas.get(key);
      exist.ids.push(d.id);
      exist.saldo += saldo;
      exist.yaPagado += yaPagado;
    } else {
      bdDeudas.set(key, { ids: [d.id], saldo, yaPagado, original: d });
    }
  }

  console.log('Sample Excel keys:', Array.from(excelDeudas.keys()).slice(0, 3));
  console.log('Sample BD keys:', Array.from(bdDeudas.keys()).slice(0, 3));

  const inserts = [];

  const updatesMonto = [];
  const deletes = []; // Deudas que están en BD pero NO en Excel -> se asume canceladas/inválidas

  for (const [key, ex] of excelDeudas.entries()) {
    const bd = bdDeudas.get(key);
    if (bd) {
      // Existe en BD, verificamos si el saldo cuadra o si el estado es incorrecto
      const idToUpdate = bd.ids[0];
      const needsMontoUpdate = Math.abs(bd.saldo - ex.monto) > 0.01;
      const needsEstadoUpdate = bd.original.estado !== 'Pendiente';
      
      if (needsMontoUpdate || needsEstadoUpdate) {
        const nuevoMontoTotal = (ex.monto + bd.yaPagado).toFixed(2);
        updatesMonto.push(`UPDATE public.montos_por_cobrar SET monto = ${nuevoMontoTotal}, estado = 'Pendiente' WHERE id = ${idToUpdate};`);
      }
      // Lo quitamos de bdDeudas para saber cuáles sobran
      bdDeudas.delete(key);
    } else {
      // No existe en BD -> es nuevo (ej. deudas de Junio que no se corrieron)
      const q_socio_id = ex.puesto_id ? 'NULL' : ex.socio.id;
      const q_puesto_id = ex.puesto_id ? ex.puesto_id : 'NULL';
      inserts.push(`INSERT INTO public.montos_por_cobrar (puesto_id, socio_id, concepto_id, periodo_anio, periodo_mes, monto, estado) VALUES (${q_puesto_id}, ${q_socio_id}, ${ex.concepto_id}, ${ex.periodoAnio}, ${ex.periodo_mes}, ${ex.monto.toFixed(2)}, 'Pendiente');`);
    }
  }

  for (const [key, bd] of bdDeudas.entries()) {
    // These are debts in the DB that are NOT in the Excel.
    // We only care if they are currently marked as 'Pendiente', because it means they shouldn't be pending.
    if (bd.original.estado === 'Pendiente') {
      for (const id of bd.ids) {
        deletes.push(`UPDATE public.montos_por_cobrar SET estado = 'Cancelado' WHERE id = ${id};`);
      }
    }
  }

  const lines = [];
  lines.push('-- =============================================================================');
  lines.push('-- Migración 00078: Corrección exacta de Deudas Pendientes');
  lines.push('-- Sincroniza la BD para que las deudas pendientes coincidan EXACTAMENTE');
  lines.push('-- con "SOCIOS - DEUDA ACTUAL Y CONCEPTOS.xlsx".');
  lines.push('-- =============================================================================');
  lines.push('');
  lines.push('BEGIN;');
  lines.push('');

  lines.push(`-- 1. DEUDAS YA PAGADAS O INVÁLIDAS (${deletes.length})`);
  lines.push('-- Estas deudas estaban "Pendientes" en la BD pero no figuran en el Excel.');
  lines.push(deletes.join('\n'));
  lines.push('');

  lines.push(`-- 2. AJUSTES DE MONTO (${updatesMonto.length})`);
  lines.push('-- Estas deudas tenían un saldo diferente al del Excel.');
  lines.push(updatesMonto.join('\n'));
  lines.push('');

  lines.push(`-- 3. NUEVAS DEUDAS (${inserts.length})`);
  lines.push('-- Deudas que están en el Excel pero faltaban en la BD (ej. Junio 2026).');
  lines.push(inserts.join('\n'));
  lines.push('');

  lines.push('COMMIT;');

  fs.mkdirSync(path.dirname(OUTPUT_SQL), { recursive: true });
  fs.writeFileSync(OUTPUT_SQL, lines.join('\n'));
  
  console.log(`\n=== Resumen de Corrección ===`);
  console.log(`Deudas a Cancelar (no en Excel) : ${deletes.length}`);
  console.log(`Deudas a Ajustar Monto          : ${updatesMonto.length}`);
  console.log(`Nuevas Deudas a Insertar        : ${inserts.length}`);
  console.log(`SQL generado: ${OUTPUT_SQL}`);
}

main().catch(err => { console.error(err); process.exit(1); });
