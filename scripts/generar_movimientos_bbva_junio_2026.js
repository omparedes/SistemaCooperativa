/**
 * generar_movimientos_bbva_junio_2026.js
 *
 * Lee "migracion_coop/junio/CONSOLIDADO MOVIMIENTOS BBVA JUNIO 2026.xlsx"
 * (hoja "Detalle BBVA"; "Validacion diaria" es solo cuadre y se ignora).
 *
 * OJO con la columna "Detalle": en este archivo NO es texto libre, son FECHAS
 * (confirmado en inspección) que representan el período que cubre el pago
 * (ej. un pago hecho el 01-06 con Detalle=2026-05-01 corresponde a la renta
 * de mayo). Se incluye como "Período: MM/YYYY" en motivo_detalle.
 *
 * cuenta_id: no existe ninguna cuenta "BBVA" en public.bancos_cuentas (solo
 * BCP e Interbank fueron sembradas en 00021). Este script AUTO-CREA la cuenta
 * (INSERT ... WHERE NOT EXISTS, no ON CONFLICT, para no duplicar si "BBVA" ya
 * existe en producción bajo otro numero_cuenta) con un numero_cuenta
 * placeholder — reemplázalo por el real antes de aplicar la migración si lo
 * conoces (ver aviso en el SQL generado).
 *
 * TERCER y último script de la cadena — cierra el archivo con COMMIT;
 * Requiere que los dos scripts anteriores hayan corrido antes.
 *
 * Uso: node scripts/generar_movimientos_bbva_junio_2026.js
 */
'use strict';
const fs = require('fs');
const XLSX = require('xlsx');

const EXCEL_PATH = 'migracion_coop/junio/CONSOLIDADO MOVIMIENTOS BBVA JUNIO 2026.xlsx';
const SHEET_NAME = 'Detalle BBVA';
const OUTPUT_SQL = 'supabase/migrations/00093_carga_movimientos_financieros_junio.sql';
const CUENTA_NUMERO_PLACEHOLDER = 'PENDIENTE-DEFINIR-BBVA';

const ADMIN_SUBQ =
  "(select id from public.perfiles where rol = 'Administrador' and activo = true limit 1)";
const CUENTA_SUBQ = "(select id from public.bancos_cuentas where nombre_banco = 'BBVA')";

// ─── Utilidades ──────────────────────────────────────────────────────────────
function esc(v) {
  if (v === null || v === undefined) return 'NULL';
  const s = String(v).trim();
  if (s === '') return 'NULL';
  return "'" + s.replace(/'/g, "''") + "'";
}

function excelDateISO(v) {
  if (!(v instanceof Date) || isNaN(v.getTime())) return null;
  const y = v.getUTCFullYear();
  const m = String(v.getUTCMonth() + 1).padStart(2, '0');
  const d = String(v.getUTCDate()).padStart(2, '0');
  return `${y}-${m}-${d}`;
}

function excelDatePeriodo(v) {
  if (!(v instanceof Date) || isNaN(v.getTime())) return null;
  const y = v.getUTCFullYear();
  const m = String(v.getUTCMonth() + 1).padStart(2, '0');
  return `${m}/${y}`;
}

// Heurística de tipo: en este archivo Bloque solo trae INQUILINOS/SOCIOS y
// todos los montos son positivos (son cobros recibidos vía BBVA), así que se
// espera 'Ingreso' en el 100% de las filas. Se deja esta detección como red
// de seguridad para archivos futuros que sí mezclen egresos.
function clasificarTipo(bloque, detalleTexto) {
  const s = `${bloque || ''} ${detalleTexto || ''}`.toUpperCase();
  if (/EGRESO|RETIRO|COMISI[OÓ]N|TRANSFERENCIA SALIENTE/.test(s)) return 'Egreso';
  return 'Ingreso';
}

// ─── Main ─────────────────────────────────────────────────────────────────────
function main() {
  if (!fs.existsSync(OUTPUT_SQL)) {
    throw new Error(
      `${OUTPUT_SQL} no existe. Ejecuta primero: node scripts/generar_egresos_junio_2026.js ` +
        'y node scripts/generar_ingresos_sshh_parqueo_junio_2026.js'
    );
  }

  console.log('Leyendo Excel:', EXCEL_PATH);
  const wb = XLSX.readFile(EXCEL_PATH, { cellDates: true });
  const ws = wb.Sheets[SHEET_NAME];
  if (!ws) throw new Error(`Hoja "${SHEET_NAME}" no encontrada. Disponibles: ${wb.SheetNames.join(', ')}`);
  const rows = XLSX.utils.sheet_to_json(ws, { defval: null });
  console.log(`Filas leídas: ${rows.length}`);

  const resueltas = [];
  const omitidas = [];
  const egresosDetectados = [];

  for (const row of rows) {
    const fecha = excelDateISO(row['Fecha']);
    const monto = Number(row['Total']);
    if (!fecha || !(monto > 0)) {
      omitidas.push(`${row['Comprobante'] || '(sin comprobante)'}: fecha o monto inválido`);
      continue;
    }

    const bloque = row['Bloque'] ? String(row['Bloque']).trim() : null;
    const responsable = row['Responsable'] ? String(row['Responsable']).trim() : null;
    const comprobante = row['Comprobante'] ? String(row['Comprobante']).trim() : null;
    const periodo = excelDatePeriodo(row['Detalle']);

    const tipo = clasificarTipo(bloque, null);
    if (tipo === 'Egreso') egresosDetectados.push(comprobante || `${bloque}/${responsable}`);

    let motivo = bloque || 'BBVA';
    motivo += ` - ${responsable || 'Sin responsable'}`;
    if (periodo) motivo += ` - Período: ${periodo}`;

    resueltas.push({ fecha, monto, tipo, motivo, nro_operacion: comprobante });
  }

  const total = resueltas.reduce((acc, f) => acc + f.monto, 0);
  console.log(`\nFilas resueltas: ${resueltas.length} / ${rows.length}`);
  if (omitidas.length) {
    console.log(`OMITIDAS (${omitidas.length}):`);
    omitidas.forEach((m) => console.log('  ' + m));
  }
  if (egresosDetectados.length) {
    console.log(`\nADVERTENCIA: ${egresosDetectados.length} fila(s) clasificadas como 'Egreso' — revisar manualmente:`);
    egresosDetectados.forEach((m) => console.log('  ' + m));
  }
  console.log(`Monto total a insertar en movimientos_bancarios: S/ ${total.toFixed(2)}`);

  // ─── Generación del SQL ───────────────────────────────────────────────────
  const lines = [];
  lines.push('-- -----------------------------------------------------------------------------');
  lines.push(`-- 3) Movimientos bancarios BBVA — ${resueltas.length} filas, S/ ${total.toFixed(2)}`);
  lines.push('-- -----------------------------------------------------------------------------');
  lines.push("-- ATENCIÓN: numero_cuenta es un PLACEHOLDER. Verifica si la cuenta 'BBVA' ya");
  lines.push('-- existe en producción bajo otro numero_cuenta (SELECT * FROM bancos_cuentas)');
  lines.push('-- antes de aplicar; de ser así, actualiza numero_cuenta manualmente después,');
  lines.push('-- el lookup de abajo es por nombre_banco y no se ve afectado por ese valor.');
  lines.push('INSERT INTO public.bancos_cuentas (nombre_banco, numero_cuenta, moneda, saldo_actual)');
  lines.push(`SELECT 'BBVA', ${esc(CUENTA_NUMERO_PLACEHOLDER)}, 'PEN', 0`);
  lines.push("WHERE NOT EXISTS (SELECT 1 FROM public.bancos_cuentas WHERE nombre_banco = 'BBVA');");
  lines.push('');

  lines.push('INSERT INTO public.movimientos_bancarios');
  lines.push('  (cuenta_id, fecha_operacion, tipo, monto, motivo_detalle, nro_operacion, created_by)');
  lines.push('VALUES');

  const valueLines = resueltas.map((f, i) => {
    const comma = i < resueltas.length - 1 ? ',' : ';';
    return `  (${CUENTA_SUBQ}, '${f.fecha}', ${esc(f.tipo)}, ${f.monto.toFixed(2)}, ${esc(f.motivo)}, ${esc(f.nro_operacion)}, ${ADMIN_SUBQ})${comma}`;
  });
  lines.push(...valueLines);
  lines.push('');
  lines.push('COMMIT;');
  lines.push('');

  fs.appendFileSync(OUTPUT_SQL, lines.join('\n'));
  console.log(`\nSQL agregado y migración cerrada (COMMIT) en: ${OUTPUT_SQL}`);
}

main();
