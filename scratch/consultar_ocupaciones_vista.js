const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

const supabaseUrl = 'https://sucnpjawtpattgkatqqn.supabase.co';
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
if (!supabaseKey) {
  console.error('Error: SUPABASE_SERVICE_ROLE_KEY no definida');
  process.exit(1);
}
const supabase = createClient(supabaseUrl, supabaseKey);

async function run() {
  try {
    // 1. Obtener todas las ocupaciones activas desde la vista
    const { data: ocupaciones, error: errorOcu } = await supabase
      .from('vw_ocupacion_integral')
      .select('*');
    if (errorOcu) throw errorOcu;

    console.log(`Total registros en vw_ocupacion_integral: ${ocupaciones.length}`);

    // Escribir el reporte completo sin filtros
    fs.writeFileSync(
      path.join(__dirname, 'ocupaciones_vista.json'),
      JSON.stringify(ocupaciones, null, 2)
    );
    console.log('Saved complete occupancy report to scratch/ocupaciones_vista.json');

  } catch (err) {
    console.error('Error:', err);
  }
}

run();
