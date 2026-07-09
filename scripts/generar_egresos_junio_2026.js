/**
 * generar_egresos_junio_2026.js
 *
 * Lee "migracion_coop/junio/CONSOLIDADO EGRESOS JUNIO 2026.xlsx" (hoja "Detalle egresos")
 * y genera el bloque INSERT INTO public.gastos dentro de
 * supabase/migrations/00093_carga_movimientos_financieros_junio.sql.
 *
 * Este es el PRIMER script de la cadena: crea el archivo de migración
 * (con el encabezado y el BEGIN;). Los otros dos (ingresos y BBVA) le hacen
 * appendFileSync después. Ver scripts/README_00093.md para el orden completo.
 *
 * Uso: node scripts/generar_egresos_junio_2026.js
 */
'use strict';
const fs = require('fs');
const path = require('path');
const XLSX = require('xlsx');

const EXCEL_PATH = 'migracion_coop/junio/CONSOLIDADO EGRESOS JUNIO 2026.xlsx';
const SHEET_NAME = 'Detalle egresos';
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

// Clasificación best-effort de categoría de gasto por palabras clave del detalle.
// Categorías existentes en public.categorias_gasto (migraciones 00001 y 00020):
// Operativo, Mantenimiento, Servicios, Remuneraciones, Dietas Directivas,
// Infraestructura y Obras, Movilidad, Limpieza y Mantenimiento.
// Es una heurística: revisar manualmente después de cargar (categoria_gasto_id
// se puede reasignar con UPDATE sin romper nada, no altera montos ni fechas).
function clasificarCategoria(detalle) {
  const d = String(detalle || '').toUpperCase();
  if (/SUELDO|PLANILLA|REMUNER/.test(d)) return 'Remuneraciones';
  if (/ASESORIA|CONTABLE|SUNARP|CERTIFICAD|NOTARIAL|REGISTRAL|LEGAL/.test(d)) return 'Servicios';
  if (/VALE DE CONSUMO|DIETA|BONO|DIA DE LA MADRE|DIA DEL PADRE|DIA DEL TRABAJO|CANASTA/.test(d))
    return 'Dietas Directivas';
  if (/PINTADO|OBRA|CONSTRUCCION|ALBA[ÑN]IL|INFRAESTRUCTURA|GASFITER|ELECTRIC/.test(d))
    return 'Infraestructura y Obras';
  if (/PASAJE|COMBUSTIBLE|GASOLINA|MOVILIDAD|TRANSPORTE|GRIFO/.test(d)) return 'Movilidad';
  if (/LIMPIEZA|SSHH|MANTENIMIENTO|JARDIN|FUMIGA|DESINFEC/.test(d)) return 'Limpieza y Mantenimiento';
  return 'Operativo';
}

// ─── Main ─────────────────────────────────────────────────────────────────────
function main() {
  console.log('Leyendo Excel:', EXCEL_PATH);
  const wb = XLSX.readFile(EXCEL_PATH, { cellDates: true });
  const ws = wb.Sheets[SHEET_NAME];
  if (!ws) throw new Error(`Hoja "${SHEET_NAME}" no encontrada. Disponibles: ${wb.SheetNames.join(', ')}`);
  const rows = XLSX.utils.sheet_to_json(ws, { defval: null });
  console.log(`Filas leídas: ${rows.length}`);

  const resueltas = [];
  const omitidas = [];
  const conteoCategoria = {};

  for (const row of rows) {
    const fecha = excelDateISO(row['Fecha']);
    const monto = Number(row['Total']);
    const detalle = row['Detalle'];

    if (!fecha || !(monto > 0)) {
      omitidas.push(`${row['Comprobante'] || '(sin comprobante)'} / ${detalle || ''}: fecha o monto inválido`);
      continue;
    }

    const categoria = clasificarCategoria(detalle);
    conteoCategoria[categoria] = (conteoCategoria[categoria] || 0) + 1;

    resueltas.push({
      fecha,
      monto,
      descripcion: detalle,
      comprobante_ref: row['Comprobante'],
      responsable: row['Responsable'],
      categoria,
    });
  }

  const total = resueltas.reduce((acc, f) => acc + f.monto, 0);
  console.log(`\nFilas resueltas: ${resueltas.length} / ${rows.length}`);
  console.log('Distribución por categoría (heurística — revisar manualmente):');
  for (const [cat, n] of Object.entries(conteoCategoria)) console.log(`  ${cat}: ${n}`);
  if (omitidas.length) {
    console.log(`\nOMITIDAS (${omitidas.length}):`);
    omitidas.forEach((m) => console.log('  ' + m));
  }
  console.log(`\nMonto total a insertar en gastos: S/ ${total.toFixed(2)}`);

  // ─── Generación del SQL ───────────────────────────────────────────────────
  const lines = [];
  lines.push('-- =============================================================================');
  lines.push('-- Migración 00093 — Movimientos financieros externos de Junio 2026');
  lines.push('-- Cooperativa Primero de Mayo · SistemaCooperativa');
  lines.push(`-- Generado: ${new Date().toISOString().slice(0, 10)}`);
  lines.push('-- Fuentes:');
  lines.push(`--   1) ${EXCEL_PATH} (hoja "${SHEET_NAME}") -> public.gastos`);
  lines.push('--   2) CONSOLIDADO INGRESOS SSHH Y PARQUEO JUNIO 2026.xlsx -> public.ingresos_internos');
  lines.push('--   3) CONSOLIDADO MOVIMIENTOS BBVA JUNIO 2026.xlsx -> public.movimientos_bancarios');
  lines.push('-- Generado ejecutando en orden:');
  lines.push('--   node scripts/generar_egresos_junio_2026.js');
  lines.push('--   node scripts/generar_ingresos_sshh_parqueo_junio_2026.js');
  lines.push('--   node scripts/generar_movimientos_bbva_junio_2026.js');
  lines.push('-- NO idempotente (gastos/ingresos_internos/movimientos_bancarios no tienen');
  lines.push('-- llave de negocio única): esta migración debe aplicarse UNA sola vez.');
  lines.push('-- =============================================================================');
  lines.push('');
  lines.push('BEGIN;');
  lines.push('');
  lines.push('-- -----------------------------------------------------------------------------');
  lines.push(`-- 1) Gastos (Egresos) — ${resueltas.length} filas, S/ ${total.toFixed(2)}`);
  lines.push('-- -----------------------------------------------------------------------------');
  lines.push('INSERT INTO public.gastos');
  lines.push('  (categoria_gasto_id, fecha, monto, descripcion, comprobante_ref, responsable, created_by)');
  lines.push('VALUES');

  const valueLines = resueltas.map((f, i) => {
    const comma = i < resueltas.length - 1 ? ',' : ';';
    const categoriaSubq = `(select id from public.categorias_gasto where nombre = ${esc(f.categoria)})`;
    return `  (${categoriaSubq}, '${f.fecha}', ${f.monto.toFixed(2)}, ${esc(f.descripcion)}, ${esc(f.comprobante_ref)}, ${esc(f.responsable)}, ${ADMIN_SUBQ})${comma}`;
  });
  lines.push(...valueLines);
  lines.push('');

  if (fs.existsSync(OUTPUT_SQL)) {
    console.warn(`\nAVISO: ${OUTPUT_SQL} ya existía y será sobrescrito (este script debe correr PRIMERO).`);
  }
  fs.mkdirSync(path.dirname(OUTPUT_SQL), { recursive: true });
  fs.writeFileSync(OUTPUT_SQL, lines.join('\n'));
  console.log(`\nSQL escrito (creando archivo): ${OUTPUT_SQL}`);
  console.log('Siguiente paso: node scripts/generar_ingresos_sshh_parqueo_junio_2026.js');
}

main();
