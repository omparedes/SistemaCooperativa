'use strict';
const fs   = require('fs');
const http = require('https');

// Parser manual de .env
const envFile = fs.readFileSync('.env', 'utf8');
const envVars = {};
envFile.split('\n').forEach(line => {
  const match = line.match(/^\s*([^#=\s]+)\s*=\s*(.*)\s*$/);
  if (match) {
    let val = match[2].trim();
    if (val.startsWith('"') && val.endsWith('"')) val = val.slice(1, -1);
    if (val.startsWith("'") && val.endsWith("'")) val = val.slice(1, -1);
    envVars[match[1]] = val;
  }
});

const ACCESS_TOKEN = envVars.SUPABASE_ACCESS_TOKEN;
const PROJECT_REF  = envVars.SUPABASE_PROJECT_REF;
const URL = `/v1/projects/${PROJECT_REF}/database/query`;

if (!ACCESS_TOKEN || !PROJECT_REF) {
  console.error("Missing SUPABASE_ACCESS_TOKEN or SUPABASE_PROJECT_REF in .env");
  process.exit(1);
}

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
  console.log(`Reading migration file...`);
  const sql = fs.readFileSync('supabase/migrations/00068_correccion_socios_calderon_cordova_rodriguez.sql', 'utf8');
  
  console.log(`Executing migration on remote project ${PROJECT_REF}...`);
  try {
    const r = await query(sql);
    console.log(`✓ Migration applied successfully! (${r.length} bytes of response)`);
  } catch (err) {
    console.error(`✗ ERROR executing migration:`);
    console.error(err.message);
    process.exit(1);
  }
}

main().catch(console.error);
