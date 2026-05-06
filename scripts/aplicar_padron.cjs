/**
 * aplicar_padron.cjs
 * Aplica supabase/migrations/00028_recrear_padron_real.sql a Supabase
 * sección por sección para evitar problemas de escape en JSON.
 */
'use strict';
const fs   = require('fs');
const http = require('https');

const ACCESS_TOKEN = 'sbp_79ceb3fff5213a0938192b5a91432061ace78db9';
const PROJECT_REF  = 'sucnpjawtpattgkatqqn';
const URL = `/v1/projects/${PROJECT_REF}/database/query`;

function query(sql) {
  return new Promise((resolve, reject) => {
    const body = JSON.stringify({ query: sql });
    const req = http.request({
      hostname: 'api.supabase.com',
      path: URL,
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${ACCESS_TOKEN}`,
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(body, 'utf8'),
      },
    }, (res) => {
      let data = '';
      res.on('data', c => data += c);
      res.on('end', () => {
        if (res.statusCode >= 200 && res.statusCode < 300) {
          resolve(data);
        } else {
          reject(new Error(`HTTP ${res.statusCode}: ${data}`));
        }
      });
    });
    req.on('error', reject);
    req.write(body, 'utf8');
    req.end();
  });
}

async function main() {
  const sql = fs.readFileSync('supabase/migrations/00028_recrear_padron_real.sql', 'utf8');
  const lines = sql.split('\n');

  // Find section boundaries
  const findLine = (pattern, from = 0) => {
    for (let i = from; i < lines.length; i++) {
      if (lines[i].match(pattern)) return i;
    }
    return -1;
  };

  // Extract lines [start, end) as SQL string
  const section = (start, end) => lines.slice(start, end).join('\n').trim();

  const paso1Start  = findLine(/^TRUNCATE/);
  const paso2Start  = findLine(/^INSERT INTO public\.puestos/);
  const paso3Start  = findLine(/^INSERT INTO public\.socios/);
  const paso4Start  = findLine(/^INSERT INTO public\.historial_titularidad/);
  const paso5Start  = findLine(/^INSERT INTO public\.inquilinos/);
  const paso6Start  = findLine(/^INSERT INTO public\.historial_arriendos/);
  const paso7Start  = findLine(/^DO \$\$/);
  const commitLine  = findLine(/^COMMIT/);

  // The TRUNCATE needs CASCADE — extract up to and including the "RESTART IDENTITY CASCADE;" line
  const truncateEnd = findLine(/RESTART IDENTITY CASCADE/, paso1Start) + 1;

  const sections = [
    { name: 'TRUNCATE CASCADE (wipe)',     sql: section(paso1Start, truncateEnd) },
    { name: 'INSERT puestos (246)',         sql: section(paso2Start, paso3Start - 2) },
    { name: 'INSERT socios (185)',          sql: section(paso3Start, paso4Start - 2) },
    { name: 'INSERT titularidades (185)',   sql: section(paso4Start, paso5Start - 2) },
    { name: 'INSERT inquilinos (65)',       sql: section(paso5Start, paso6Start - 3) },
    { name: 'INSERT arriendos (49)',        sql: section(paso6Start, paso7Start - 2) },
    { name: 'Verificación (DO block)',      sql: section(paso7Start, commitLine) },
  ];

  for (const s of sections) {
    if (!s.sql.trim()) { console.log(`⏭  Saltando (vacío): ${s.name}`); continue; }
    process.stdout.write(`→ ${s.name} ... `);
    try {
      const r = await query(s.sql);
      console.log(`✓  (${r.length} bytes)`);
    } catch (err) {
      console.log(`✗ ERROR`);
      console.error(err.message.slice(0, 500));
      process.exit(1);
    }
  }

  console.log('\n✅ Migración 00028 aplicada exitosamente.');

  // Final count check
  const check = await query(`
    SELECT
      (SELECT count(*) FROM public.socios)      AS socios,
      (SELECT count(*) FROM public.inquilinos)  AS inquilinos,
      (SELECT count(*) FROM public.puestos)     AS puestos,
      (SELECT count(*) FROM public.historial_titularidad WHERE fecha_fin IS NULL) AS titularidades,
      (SELECT count(*) FROM public.historial_arriendos   WHERE fecha_fin IS NULL) AS arriendos;
  `);
  console.log('\nResultado final:', check);
}

main().catch(e => { console.error(e); process.exit(1); });
