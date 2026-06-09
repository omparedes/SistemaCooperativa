const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = 'https://sucnpjawtpattgkatqqn.supabase.co';
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function run() {
  try {
    const { data: puesto, error } = await supabase
      .from('puestos')
      .select('id, codigo_puesto, tipo_espacio')
      .eq('codigo_puesto', '11-D2')
      .single();

    if (error) throw error;
    console.log(`Puesto 11-D2: ID=${puesto.id} | Tipo=${puesto.tipo_espacio}`);
  } catch (err) {
    console.error(err);
  }
}

run();
