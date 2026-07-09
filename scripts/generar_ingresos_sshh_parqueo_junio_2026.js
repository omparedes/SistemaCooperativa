/**
 * generar_ingresos_sshh_parqueo_junio_2026.js
 *
 * Lee "migracion_coop/junio/CONSOLIDADO INGRESOS SSHH Y PARQUEO JUNIO 2026.xlsx".
 * El archivo NO es una sola hoja: tiene 3 pestañas —
 *   - "Detalle Parqueo": Fecha, Pestana, Inquilino(=siempre literal "PARQUEO"),
 *     Comprobante, Detalle (¡es una FECHA suelta, no texto — se ignora), Monto.
 *   - "Detalle SSHH": Fecha, Pestana, Piso ("1ER PISO"/"2DO PISO"), Monto.
 *     No tiene Comprobante ni Detalle.
 *   - "Resumen diario": solo validación cruzada, no se inserta.
 *
 * Genera el bloque INSERT INTO public.ingresos_internos y lo agrega (append)
 * a supabase/migrations/00093_carga_movimientos_financieros_junio.sql.
 *
 * SEGUNDO script de la cadena — requiere que
 * generar_egresos_junio_2026.js haya corrido antes (crea el archivo base).
 *
 * Uso: node scripts/generar_ingresos_sshh_parqueo_junio_2026.js
 */
'use strict';
const fs = require('fs');
const XLSX = require('xlsx');

const EXCEL_PATH = 'migracion_coop/junio/CONSOLIDADO INGRESOS SSHH Y PARQUEO JUNIO 2026.xlsx';
const OUTPUT_SQL = 'supabase/migrations/00093_carga_movimientos_financieros_junio.sql';

const ADMIN_SUBQ =
  "(select id from public.perfiles where rol = 'Administrador' and activo = true limit 1)";

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

// ─── Main ─────────────────────────────────────────────────────────────────────
function main() {
  if (!fs.existsSync(OUTPUT_SQL)) {
    throw new Error(
      `${OUTPUT_SQL} no existe. Ejecuta primero: node scripts/generar_egresos_junio_2026.js`
    );
  }

  console.log('Leyendo Excel:', EXCEL_PATH);
  const wb = XLSX.readFile(EXCEL_PATH, { cellDates: true });

  const wsParqueo = wb.Sheets['Detalle Parqueo'];
  const wsSshh = wb.Sheets['Detalle SSHH'];
  if (!wsParqueo) throw new Error(`Hoja "Detalle Parqueo" no encontrada. Disponibles: ${wb.SheetNames.join(', ')}`);
  if (!wsSshh) throw new Error(`Hoja "Detalle SSHH" no encontrada. Disponibles: ${wb.SheetNames.join(', ')}`);

  const rowsParqueo = XLSX.utils.sheet_to_json(wsParqueo, { defval: null });
  const rowsSshh = XLSX.utils.sheet_to_json(wsSshh, { defval: null });
  console.log(`Filas leídas — Parqueo: ${rowsParqueo.length}, SSHH: ${rowsSshh.length}`);

  const resueltas = [];
  const omitidas = [];
  let conceptoSshh2doUsado = false;

  // Parqueo: la columna "Detalle" del Excel es una fecha suelta sin significado
  // claro (confirmado en inspección) — se ignora deliberadamente.
  for (const row of rowsParqueo) {
    const fecha = excelDateISO(row['Fecha']);
    const monto = Number(row['Monto']);
    if (!fecha || !(monto > 0)) {
      omitidas.push(`Parqueo ${row['Comprobante'] || '(sin comprobante)'}: fecha o monto inválido`);
      continue;
    }
    const comprobante = row['Comprobante'] ? String(row['Comprobante']).trim() : null;
    const observacion = comprobante ? `Parqueo (Comp: ${comprobante})` : 'Parqueo';
    resueltas.push({
      fecha,
      monto,
      observacion,
      conceptoNombre: 'Parqueo',
    });
  }

  // SSHH: sin Comprobante/Detalle, solo Piso.
  for (const row of rowsSshh) {
    const fecha = excelDateISO(row['Fecha']);
    const monto = Number(row['Monto']);
    const piso = String(row['Piso'] || '').trim().toUpperCase();
    if (!fecha || !(monto > 0)) {
      omitidas.push(`SSHH ${row['Pestana'] || ''}: fecha o monto inválido`);
      continue;
    }
    let conceptoNombre;
    let observacion;
    if (piso.startsWith('1ER')) {
      conceptoNombre = 'SS.HH 1er PISO';
      observacion = 'SS.HH 1er Piso';
    } else if (piso.startsWith('2DO')) {
      conceptoNombre = 'SS.HH 2do PISO';
      observacion = 'SS.HH 2do Piso';
      conceptoSshh2doUsado = true;
    } else {
      omitidas.push(`SSHH ${row['Pestana'] || ''}: piso desconocido "${row['Piso']}"`);
      continue;
    }
    resueltas.push({ fecha, monto, observacion, conceptoNombre });
  }

  const total = resueltas.reduce((acc, f) => acc + f.monto, 0);
  console.log(`\nFilas resueltas: ${resueltas.length} / ${rowsParqueo.length + rowsSshh.length}`);
  if (omitidas.length) {
    console.log(`OMITIDAS (${omitidas.length}):`);
    omitidas.forEach((m) => console.log('  ' + m));
  }
  console.log(`Monto total a insertar en ingresos_internos: S/ ${total.toFixed(2)}`);

  // ─── Generación del SQL ───────────────────────────────────────────────────
  const lines = [];
  lines.push('-- -----------------------------------------------------------------------------');
  lines.push(`-- 2) Ingresos internos (SS.HH + Parqueo) — ${resueltas.length} filas, S/ ${total.toFixed(2)}`);
  lines.push('-- -----------------------------------------------------------------------------');

  if (conceptoSshh2doUsado) {
    lines.push("-- Concepto 'SS.HH 2do PISO' no existía (migración 00014 solo creó 1er piso); se agrega aquí.");
    lines.push('INSERT INTO public.conceptos (nombre, tipo, aplica_descuento, activo, grupo, descripcion)');
    lines.push('VALUES');
    lines.push(
      "  ('SS.HH 2do PISO', 'Variable', false, true, 'OTROS', 'Cobro por uso de servicios higiénicos segundo piso.')"
    );
    lines.push('ON CONFLICT (nombre) DO NOTHING;');
    lines.push('');
  }

  lines.push('INSERT INTO public.ingresos_internos');
  lines.push('  (concepto_id, monto, metodo_pago, observacion, fecha_ingreso, created_by)');
  lines.push('VALUES');

  const valueLines = resueltas.map((f, i) => {
    const comma = i < resueltas.length - 1 ? ',' : ';';
    const conceptoSubq = `(select id from public.conceptos where nombre = ${esc(f.conceptoNombre)})`;
    return `  (${conceptoSubq}, ${f.monto.toFixed(2)}, 'Efectivo', ${esc(f.observacion)}, '${f.fecha}'::timestamptz, ${ADMIN_SUBQ})${comma}`;
  });
  lines.push(...valueLines);
  lines.push('');

  fs.appendFileSync(OUTPUT_SQL, lines.join('\n'));
  console.log(`\nSQL agregado a: ${OUTPUT_SQL}`);
  console.log('Siguiente paso: node scripts/generar_movimientos_bbva_junio_2026.js');
}

main();
