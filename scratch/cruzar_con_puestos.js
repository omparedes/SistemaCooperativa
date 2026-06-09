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

// Hojas sin emparejar
const unmappedSheets = [
  "ALVARO GUSTAVO",
  "AYALA HILARY",
  "ATO MARIA",
  "CALLIROS FIORELLA",
  "CASTILLO ASAEL",
  "CAYO BASILIO",
  "DURAND BLANCA",
  "FLORES DOMINICA",
  "FUENTES VANESSA",
  "HERRERA ELIZABETH",
  "LEON RODRIGUEZ - FUENTES",
  "LOAYZA JOSE",
  "LUJAN  DEISSY",
  "FLORES WILLIAMS",
  "GONZALEZ CARMEN",
  "GONZALES ROSMARY",
  "IBARRA EMMA",
  "LUCAS  LUZ",
  "PEÑA TEREZA",
  "QUISPE MARISOL",
  "QUISPE ROSA MARIBEL",
  "SATALAYA SEGUNDO",
  "TITO ISABEL",
  "MALCA LUZ",
  "EVELYN CUYA"
];

async function run() {
  try {
    // 1. Obtener todos los pagos registrados en la DB para cruzarlos
    console.log('Obteniendo pagos de la DB...');
    const { data: dbPagos, error: errPagos } = await supabase
      .from('pagos')
      .select('id, comprobante, monto_total, fecha_pago, puesto_id')
      .is('deleted_at', null);
    
    if (errPagos) throw errPagos;
    console.log(`Total pagos en DB: ${dbPagos.length}`);

    // 2. Obtener todas las deudas (montos_por_cobrar) de la DB para cruzarlas
    console.log('Obteniendo montos_por_cobrar de la DB...');
    // Paginado porque pueden ser más de 1000
    let dbDeudas = [];
    let page = 0;
    while (true) {
      const { data: chunk, error: errDeud } = await supabase
        .from('montos_por_cobrar')
        .select('id, puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado')
        .is('deleted_at', null)
        .range(page * 1000, (page + 1) * 1000 - 1);
      
      if (errDeud) throw errDeud;
      if (!chunk || chunk.length === 0) break;
      dbDeudas = dbDeudas.concat(chunk);
      page++;
    }
    console.log(`Total deudas en DB: ${dbDeudas.length}`);

    // 3. Obtener mapeo de puesto_id a codigo_puesto
    const { data: puestos, error: errPue } = await supabase
      .from('puestos')
      .select('id, codigo_puesto');
    if (errPue) throw errPue;
    const puestoMap = {};
    puestos.forEach(p => { puestoMap[p.id] = p.codigo_puesto; });

    console.log('\n--- ANALIZANDO HOJAS SIN EMPAREJAR ---');
    const sheetMatches = [];

    for (const sheetName of unmappedSheets) {
      const data = transacciones[sheetName];
      if (!data) {
        console.log(`Hoja ${sheetName} no encontrada en el JSON de transacciones.`);
        continue;
      }

      // Tomar todas las transacciones (deudas y pagos) de esta hoja
      const allTxs = [...data.pagos, ...data.deudas];
      if (allTxs.length === 0) {
        console.log(`Hoja: ${sheetName} | SIN TRANSACCIONES`);
        sheetMatches.push({ sheet: sheetName, matches: [], status: 'EMPTY_SHEET' });
        continue;
      }

      // Buscar si alguna transacción coincide con la DB
      const matches = [];
      for (const tx of allTxs) {
        // Buscar coincidencia por comprobante (documento) y monto en pagos
        if (tx.documento && tx.documento !== 'POR COBRAR') {
          // Buscar en pagos de la DB
          const pMatches = dbPagos.filter(p => 
            p.comprobante && 
            p.comprobante.trim().toLowerCase() === tx.documento.trim().toLowerCase() && 
            Math.abs(p.monto_total - tx.monto) < 0.01
          );

          pMatches.forEach(pm => {
            matches.push({
              tipo: 'PAGO_COMPROBANTE',
              puesto: puestoMap[pm.puesto_id],
              puestoId: pm.puesto_id,
              monto: pm.monto_total,
              comprobante: pm.comprobante,
              tx: tx
            });
          });
        }
      }

      // Agrupar coincidencias por puesto
      const puestoCounts = {};
      matches.forEach(m => {
        puestoCounts[m.puesto] = (puestoCounts[m.puesto] || 0) + 1;
      });

      console.log(`Hoja: ${sheetName.padEnd(25)} | Coincidencias de recibos: ${matches.length} | Puestos sugeridos:`, puestoCounts);
      
      sheetMatches.push({
        sheet: sheetName,
        matches: matches,
        puestosSugeridos: puestoCounts,
        status: matches.length > 0 ? 'MATCHED_BY_TX' : 'NO_TX_MATCH'
      });
    }

    fs.writeFileSync(
      path.join(__dirname, 'coincidencias_transacciones_puestos.json'),
      JSON.stringify(sheetMatches, null, 2)
    );
    console.log('\nSaved matches to scratch/coincidencias_transacciones_puestos.json');

  } catch (err) {
    console.error('Error:', err);
  }
}

run();
