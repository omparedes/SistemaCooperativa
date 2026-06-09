const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = 'https://sucnpjawtpattgkatqqn.supabase.co';
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
if (!supabaseKey) {
  console.error('Error: SUPABASE_SERVICE_ROLE_KEY no definida');
  process.exit(1);
}
const supabase = createClient(supabaseUrl, supabaseKey);

async function searchPuesto(mes, anio, conceptoId, monto, label) {
  const { data: deudas, error } = await supabase
    .from('montos_por_cobrar')
    .select('id, puesto_id, periodo_anio, periodo_mes, monto')
    .eq('periodo_anio', anio)
    .eq('periodo_mes', mes)
    .eq('concepto_id', conceptoId) // 1 = Luz, 2 = Agua
    .eq('monto', monto);

  if (error) {
    console.error(`Error buscando ${label}:`, error);
    return;
  }

  if (deudas.length === 0) {
    console.log(`[${label}] No se encontraron deudas con monto ${monto} en ${mes}/${anio}`);
    return;
  }

  const puestoIds = deudas.map(d => d.puesto_id);
  const { data: puestos } = await supabase
    .from('puestos')
    .select('id, codigo_puesto, tipo_espacio')
    .in('id', puestoIds);
  
  const puestoMap = {};
  puestos.forEach(p => { puestoMap[p.id] = `${p.codigo_puesto} (${p.tipo_espacio})`; });

  deudas.forEach(d => {
    console.log(`[${label}] COINCIDENCIA -> Puesto: ${puestoMap[d.puesto_id]} | Deuda ID: ${d.id}`);
  });
}

async function run() {
  try {
    // Vanessa Fuentes: Luz Abril 2026 = 11.9
    await searchPuesto(4, 2026, 1, 11.9, 'Vanessa Fuentes - Luz Abril');
    // Vanessa Fuentes: Agua Abril 2026 = 3
    await searchPuesto(4, 2026, 2, 3, 'Vanessa Fuentes - Agua Abril');

    // Elizabeth Herrera: Luz Marzo 2026 = 51.1
    await searchPuesto(3, 2026, 1, 51.1, 'Elizabeth Herrera - Luz Marzo');
    // Elizabeth Herrera: Luz Abril 2026 = 4
    await searchPuesto(4, 2026, 1, 4, 'Elizabeth Herrera - Luz Abril');

    // Satalaya Segundo: Luz Enero 2026 = 9
    await searchPuesto(1, 2026, 1, 9, 'Satalaya Segundo - Luz Enero');
    // Satalaya Segundo: Luz Febrero 2026 = 5.3
    await searchPuesto(2, 2026, 1, 5.3, 'Satalaya Segundo - Luz Febrero');

  } catch (err) {
    console.error(err);
  }
}

run();
