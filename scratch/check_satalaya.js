const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');

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

const supabase = createClient(envVars.SUPABASE_URL, envVars.SUPABASE_SERVICE_ROLE_KEY);

async function checkSatalaya() {
  const { data: people, error } = await supabase.rpc('rpc_cc_listar_personas');
  if (error) throw error;
  
  const elvis = people.find(p => p.nombre.includes("SATALAYA"));
  console.log("Elvis SatalayaTapulima in RPC:", elvis);
}

checkSatalaya().catch(console.error);
