const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = 'https://sucnpjawtpattgkatqqn.supabase.co';
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
if (!supabaseKey) {
  console.error('Error: SUPABASE_SERVICE_ROLE_KEY no definida');
  process.exit(1);
}
const supabase = createClient(supabaseUrl, supabaseKey);

async function run() {
  try {
    // Buscar deudas de Agua por 3 en periodo 3/2026 o 4/2026
    const { data: deudas, error } = await supabase
      .from('montos_por_cobrar')
      .select('id, puesto_id, periodo_anio, periodo_mes, monto')
      .eq('concepto_id', 2) // Agua
      .eq('monto', 3)
      .eq('periodo_anio', 2026)
      .in('periodo_mes', [3, 4]);

    if (error) throw error;

    const puestoIds = deudas.map(d => d.puesto_id);
    const { data: puestos } = await supabase
      .from('puestos')
      .select('id, codigo_puesto, tipo_espacio')
      .in('id', puestoIds);
    
    const puestoMap = {};
    puestos.forEach(p => { puestoMap[p.id] = `${p.codigo_puesto} (${p.tipo_espacio})`; });

    console.log(`Deudas de agua por 3 encontradas:`);
    deudas.forEach(d => {
      console.log(`Puesto: ${puestoMap[d.puesto_id]} | ID Deuda: ${d.id} | Periodo: ${d.periodo_mes}/${d.periodo_anio}`);
    });

  } catch (err) {
    console.error(err);
  }
}

run();
