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

// Cargar transacciones detalladas de Excel
const transacciones = JSON.parse(fs.readFileSync(path.join(__dirname, 'transacciones_inquilinos_completas.json'), 'utf8'));

const newTenants = [
  "FUENTES VANESSA",
  "HERRERA ELIZABETH",
  "LOAYZA JOSE",
  "FLORES WILLIAMS",
  "GONZALEZ CARMEN",
  "LUCAS  LUZ",
  "QUISPE ROSA MARIBEL",
  "SATALAYA SEGUNDO",
  "EVELYN CUYA"
];

// Mapeo de nombres de mes de Excel a número
const mesMap = {
  'ENERO': 1, 'FEBRERO': 2, 'MARZO': 3, 'ABRIL': 4, 'MAYO': 5, 'JUNIO': 6,
  'JULIO': 7, 'AGOSTO': 8, 'SETIEMBRE': 9, 'OCTUBRE': 10, 'NOVIEMBRE': 11, 'DICIEMBRE': 12
};

async function run() {
  try {
    // 1. Obtener conceptos para mapear ids
    const { data: conceptos, error: errC } = await supabase
      .from('conceptos')
      .select('id, nombre');
    if (errC) throw errC;
    
    const conceptoMap = {};
    conceptos.forEach(c => { conceptoMap[c.nombre.toUpperCase()] = c.id; });
    // Conceptos comunes mapeos alternativos
    conceptoMap['ALQUILER'] = conceptoMap['ALQUILER'] || conceptoMap['ALQUILERES'] || 3; // Alquiler usualmente es 3 o similar
    console.log('Conceptos en DB:', conceptos);

    // 2. Obtener puestos
    const { data: puestos, error: errP } = await supabase
      .from('puestos')
      .select('id, codigo_puesto, tipo_espacio');
    if (errP) throw errP;
    const puestoMap = {};
    puestos.forEach(p => { puestoMap[p.id] = p.codigo_puesto; });

    // 3. Obtener deudas
    let dbDeudas = [];
    let page = 0;
    while (true) {
      const { data: chunk, error: errDeud } = await supabase
        .from('montos_por_cobrar')
        .select('id, puesto_id, concepto_id, periodo_anio, periodo_mes, monto')
        .is('deleted_at', null)
        .range(page * 1000, (page + 1) * 1000 - 1);
      
      if (errDeud) throw errDeud;
      if (!chunk || chunk.length === 0) break;
      dbDeudas = dbDeudas.concat(chunk);
      page++;
    }
    console.log(`Deudas cargadas: ${dbDeudas.length}`);

    console.log('\n=== DEDUCCIÓN DE PUESTOS PARA INQUILINOS NUEVOS ===');

    const results = {};

    for (const name of newTenants) {
      const data = transacciones[name];
      if (!data) continue;

      const allTxs = [...data.deudas];
      if (allTxs.length === 0) {
        console.log(`\nInquilino: ${name} | No tiene deudas en Excel para cruzar`);
        continue;
      }

      console.log(`\nInquilino: ${name} | Procesando ${allTxs.length} deudas...`);
      const puestoCandidatos = {};

      for (const tx of allTxs) {
        const mesNum = mesMap[tx.periodo.toUpperCase()];
        if (!mesNum) continue;

        // Deducir año de la fecha de Excel
        // tx.fecha es YYYY-MM-DD
        const anioNum = tx.fecha ? Number(tx.fecha.split('-')[0]) : 2026;

        // Mapear concepto
        let conceptoId = conceptoMap[tx.concepto.toUpperCase()];
        if (!conceptoId) {
          if (tx.concepto.toUpperCase().includes('LUZ')) conceptoId = 1; // Luz es 1
          if (tx.concepto.toUpperCase().includes('AGUA')) conceptoId = 2; // Agua es 2
          if (tx.concepto.toUpperCase().includes('ALQUILER')) conceptoId = 3; // Alquiler es 3
        }

        // Buscar en deudas de la DB
        const matchDeudas = dbDeudas.filter(d => 
          d.periodo_mes === mesNum && 
          Math.abs(d.monto - tx.monto) < 0.01
        );

        matchDeudas.forEach(md => {
          const cod = puestoMap[md.puesto_id];
          puestoCandidatos[cod] = (puestoCandidatos[cod] || 0) + 1;
        });
      }

      // Ordenar candidatos por número de coincidencias
      const sorted = Object.entries(puestoCandidatos).sort((a, b) => b[1] - a[1]);
      console.log(` Puestos sugeridos por coincidencia de monto/periodo:`, sorted);
      results[name] = sorted;
    }

  } catch (err) {
    console.error(err);
  }
}

run();
