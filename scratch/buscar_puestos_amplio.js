const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = 'https://sucnpjawtpattgkatqqn.supabase.co';
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
if (!supabaseKey) {
  console.error('Error: SUPABASE_SERVICE_ROLE_KEY no definida');
  process.exit(1);
}
const supabase = createClient(supabaseUrl, supabaseKey);

const searchParams = [
  { monto: 11.9, conceptoId: 1, label: "Vanessa Fuentes - Luz (11.9)" },
  { monto: 3, conceptoId: 2, label: "Vanessa Fuentes - Agua (3)" },
  { monto: 150, conceptoId: 16, label: "Evelyn Cuya - Depósito (150)" },
  { monto: 180, conceptoId: 11, label: "Jose Loayza - Alquiler (180)" },
  { monto: 90, conceptoId: 11, label: "Jose Loayza - Alquiler (90)" },
  { monto: 170, conceptoId: 11, label: "Jose Loayza - Alquiler (170)" },
  { monto: 500, conceptoId: 11, label: "Williams Flores - Alquiler (500)" },
  { monto: 101.6, conceptoId: 11, label: "Carmen Gonzalez - Alquiler (101.6)" },
  { monto: 350, conceptoId: 11, label: "Luz Lucas - Alquiler (350)" },
  { monto: 444.3, conceptoId: 11, label: "Rosa Maribel Quispe - Alquiler (444.3)" }
];

async function run() {
  try {
    // Obtener puestos
    const { data: puestos } = await supabase.from('puestos').select('id, codigo_puesto, tipo_espacio');
    const puestoMap = {};
    puestos.forEach(p => { puestoMap[p.id] = `${p.codigo_puesto} (${p.tipo_espacio})`; });

    console.log('=== BÚSQUEDA AMPLIA DE PUESTOS EN LA DB ===');

    for (const param of searchParams) {
      const { data: deudas, error } = await supabase
        .from('montos_por_cobrar')
        .select('id, puesto_id, concepto_id, periodo_anio, periodo_mes, monto')
        .eq('concepto_id', param.conceptoId)
        .eq('monto', param.monto);

      if (error) {
        console.error(`Error en ${param.label}:`, error);
        continue;
      }

      if (deudas.length === 0) {
        console.log(`[${param.label}] -> Sin coincidencias`);
      } else {
        console.log(`[${param.label}] -> Encontradas ${deudas.length} deudas:`);
        deudas.forEach(d => {
          console.log(`  - Puesto: ${puestoMap[d.puesto_id]} | ID Deuda: ${d.id} | Periodo: ${d.periodo_mes}/${d.periodo_anio}`);
        });
      }
    }

  } catch (err) {
    console.error(err);
  }
}

run();
