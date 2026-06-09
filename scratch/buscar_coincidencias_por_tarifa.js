const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = 'https://sucnpjawtpattgkatqqn.supabase.co';
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
if (!supabaseKey) {
  console.error('Error: SUPABASE_SERVICE_ROLE_KEY no definida');
  process.exit(1);
}
const supabase = createClient(supabaseUrl, supabaseKey);

const searchParams = [
  { monto: 350, label: "Luz Lucas - Alquiler (350)" },
  { monto: 500, label: "Williams Flores - Alquiler (500)" },
  { monto: 101.6, label: "Carmen Gonzalez - Alquiler (101.6)" },
  { monto: 444.3, label: "Rosa Maribel Quispe - Alquiler (444.3)" },
  { monto: 180, label: "Jose Loayza - Alquiler (180)" },
  { monto: 90, label: "Jose Loayza - Alquiler (90)" },
  { monto: 170, label: "Jose Loayza - Alquiler (170)" }
];

async function run() {
  try {
    const { data: puestos } = await supabase.from('puestos').select('id, codigo_puesto, tipo_espacio');
    const puestoMap = {};
    puestos.forEach(p => { puestoMap[p.id] = `${p.codigo_puesto} (${p.tipo_espacio})`; });

    console.log('=== BÚSQUEDA DE TARIFA DE ALQUILER EN HISTÓRICO DE DEUDAS 2025 ===');

    for (const param of searchParams) {
      const { data: deudas, error } = await supabase
        .from('montos_por_cobrar')
        .select('id, puesto_id, concepto_id, periodo_anio, periodo_mes, monto')
        .eq('concepto_id', 11) // Alquiler
        .eq('monto', param.monto)
        .eq('periodo_anio', 2025); // Solo deudas de 2025

      if (error) {
        console.error(`Error en ${param.label}:`, error);
        continue;
      }

      if (deudas.length === 0) {
        console.log(`[${param.label}] -> Sin coincidencias en 2025`);
      } else {
        console.log(`[${param.label}] -> Encontradas ${deudas.length} deudas en 2025:`);
        deudas.forEach(d => {
          console.log(`  - Puesto: ${puestoMap[d.puesto_id]} | ID Deuda: ${d.id} | Periodo: ${d.periodo_mes}/2025`);
        });
      }
    }

  } catch (err) {
    console.error(err);
  }
}

run();
