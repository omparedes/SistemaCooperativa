/**
 * aplicar_historial.cjs
 * Aplica supabase/migrations/00029_historial_pagos_excel.sql
 * extrayendo cada bloque DO y enviándolo por separado a la API.
 * Muestra progreso y errores en tiempo real.
 */
'use strict';
const https = require('https');
const fs    = require('fs');

const PROJECT_REF  = 'sucnpjawtpattgkatqqn';
const ACCESS_TOKEN = 'sbp_79ceb3fff5213a0938192b5a91432061ace78db9';
const SQL_FILE     = 'supabase/migrations/00029_historial_pagos_excel.sql';

function apiQuery(sql) {
  return new Promise((resolve, reject) => {
    const body = JSON.stringify({ query: sql });
    const req  = https.request({
      hostname: 'api.supabase.com',
      path: `/v1/projects/${PROJECT_REF}/database/query`,
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${ACCESS_TOKEN}`,
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(body, 'utf8'),
      },
    }, res => {
      let data = '';
      res.on('data', c => data += c);
      res.on('end', () => {
        if (res.statusCode >= 200 && res.statusCode < 300) resolve(JSON.parse(data));
        else reject(new Error(`HTTP ${res.statusCode}: ${data.slice(0, 400)}`));
      });
    });
    req.on('error', reject);
    req.write(body, 'utf8');
    req.end();
  });
}

async function main() {
  console.log(`\nAplicando: ${SQL_FILE}\n`);
  const sql = fs.readFileSync(SQL_FILE, 'utf8');

  // Extraer sección de header (hasta primer DO block)
  const headerEnd = sql.indexOf('\nDO $b1$');
  if (headerEnd > 0) {
    const headerSql = sql.slice(0, headerEnd).trim();
    if (headerSql) {
      process.stdout.write('Ejecutando header (conceptos, etc.)... ');
      await apiQuery(headerSql);
      console.log('✓');
    }
  }

  // Extraer bloques DO individuales
  const blocks = [];
  const doPattern = /DO \$b(\d+)\$[\s\S]*?\$b\1\$;/g;
  let m;
  while ((m = doPattern.exec(sql)) !== null) {
    blocks.push({ id: parseInt(m[1]), sql: m[0] });
  }
  console.log(`Total bloques DO: ${blocks.length}\n`);

  let ok = 0, warn = 0, err = 0;
  for (const block of blocks) {
    process.stdout.write(`[${block.id}/${blocks.length}] `);
    try {
      const res = await apiQuery(block.sql);
      // Check if the result contains a WARNING
      const r = JSON.stringify(res);
      if (r.includes('WARNING') || r.includes('Warning')) {
        process.stdout.write('⚠ ');
        warn++;
      } else {
        process.stdout.write('✓ ');
        ok++;
      }
    } catch (e) {
      process.stdout.write(`✗ (${e.message.slice(0, 60)}) `);
      err++;
    }
    if (block.id % 10 === 0) process.stdout.write('\n');
  }

  // Aplicar footer
  const footerStart = sql.lastIndexOf('\n-- ─');
  if (footerStart > 0) {
    const footerSql = sql.slice(footerStart).trim();
    console.log('\n\nAplicando footer (UPDATE estado + reporte)...');
    const finalResult = await apiQuery(footerSql);
    console.log('\nReporte final:');
    if (Array.isArray(finalResult) && finalResult[0]) {
      const r = finalResult[0];
      console.log(`  Montos históricos: ${r.montos_total} (${r.montos_pagados} pagados, ${r.montos_pendientes} pendientes)`);
      console.log(`  Pagos históricos:  ${r.pagos_total}`);
      console.log(`  Detalles:          ${r.detalles_total}`);
      console.log(`  Deuda total:       S/ ${r.deuda_historica_total}`);
      console.log(`  Cobrado total:     S/ ${r.cobrado_historico_total}`);
    }
  }

  console.log(`\n✅ Completado: ${ok} OK | ${warn} con warning | ${err} con error`);
}

main().catch(e => { console.error('Error fatal:', e); process.exit(1); });
