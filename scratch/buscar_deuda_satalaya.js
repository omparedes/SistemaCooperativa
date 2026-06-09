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
    // Buscar la deuda de 2030 o 2064.7 de Satalaya Segundo
    const { data: deudas, error } = await supabase
      .from('montos_por_cobrar')
      .select('id, puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado')
      .eq('monto', 2030);

    if (error) throw error;

    console.log(`Deudas encontradas con monto 2030: ${deudas.length}`);

    // Mapear puestos
    if (deudas.length > 0) {
      const puestoIds = deudas.map(d => d.puesto_id);
      const { data: puestos } = await supabase
        .from('puestos')
        .select('id, codigo_puesto, tipo_espacio')
        .in('id', puestoIds);
      
      const puestoMap = {};
      puestos.forEach(p => { puestoMap[p.id] = `${p.codigo_puesto} (${p.tipo_espacio})`; });

      deudas.forEach(d => {
        console.log(`Deuda ID: ${d.id} | Puesto: ${puestoMap[d.puesto_id]} | Anio: ${d.periodo_anio} | Mes: ${d.periodo_mes} | Monto: ${d.monto}`);
      });
    }

  } catch (err) {
    console.error(err);
  }
}

run();
