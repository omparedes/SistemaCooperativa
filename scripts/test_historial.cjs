/** Aplica solo los primeros 3 bloques DO como prueba */
'use strict';
const https = require('https');
const fs    = require('fs');

const PROJECT_REF  = 'sucnpjawtpattgkatqqn';
const ACCESS_TOKEN = 'sbp_79ceb3fff5213a0938192b5a91432061ace78db9';

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
        if (res.statusCode >= 200 && res.statusCode < 300) resolve({ ok: true, data: JSON.parse(data) });
        else resolve({ ok: false, error: data.slice(0, 500) });
      });
    });
    req.on('error', reject);
    req.write(body, 'utf8');
    req.end();
  });
}

async function main() {
  const sql = fs.readFileSync('supabase/migrations/00029_historial_pagos_excel.sql', 'utf8');

  // Insertar concepto Alquiler primero
  const alqSql = `INSERT INTO public.conceptos(nombre,tipo,activo,descripcion) VALUES('Alquiler','Fijo',true,'Arriendo mensual pagado por inquilinos') ON CONFLICT(nombre) DO NOTHING;`;
  const r0 = await apiQuery(alqSql);
  console.log('Concepto Alquiler:', r0.ok ? '✓' : `✗ ${r0.error}`);

  // Extraer primeros 3 bloques DO
  const doPattern = /DO \$b(\d+)\$[\s\S]*?\$b\1\$;/g;
  const blocks = [];
  let m;
  while ((m = doPattern.exec(sql)) !== null && blocks.length < 3) {
    blocks.push({ id: parseInt(m[1]), sql: m[0] });
  }

  for (const block of blocks) {
    const sizeKB = (Buffer.byteLength(block.sql, 'utf8') / 1024).toFixed(1);
    process.stdout.write(`Bloque ${block.id} (${sizeKB} KB)... `);
    const r = await apiQuery(block.sql);
    console.log(r.ok ? '✓' : `✗ ${r.error?.slice(0, 200)}`);
  }

  // Verificar resultado
  const check = await apiQuery(`SELECT (SELECT count(*) FROM public.montos_por_cobrar WHERE deleted_at IS NULL) AS montos, (SELECT count(*) FROM public.pagos WHERE deleted_at IS NULL) AS pagos, (SELECT count(*) FROM public.detalle_pagos WHERE deleted_at IS NULL) AS detalles;`);
  console.log('\nEstado BD después de 3 bloques:', check.data);
}

main().catch(e => console.error(e));
