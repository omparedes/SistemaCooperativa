const XLSX = require('xlsx');
const path = require('path');
const { createClient } = require('@supabase/supabase-js');

const supabaseUrl = 'https://sucnpjawtpattgkatqqn.supabase.co';
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

const file = path.join(__dirname, '../migracion_coop/SOCIOS E INQUILINOS TERMINADO.xlsx');

async function run() {
  try {
    // 1. Mostrar códigos de puestos específicos
    const ids = [57, 101, 102, 150, 170];
    const { data: puestos } = await supabase
      .from('puestos')
      .select('id, codigo_puesto, tipo_espacio')
      .in('id', ids);
    console.log('=== CÓDIGOS DE PUESTOS EN DB ===');
    puestos.forEach(p => console.log(`ID: ${p.id} -> Puesto: ${p.codigo_puesto} (${p.tipo_espacio})`));

    // 2. Volcar la hoja DEPOSITO
    const wb = XLSX.readFile(file);
    const sheet = wb.Sheets['DEPOSITO'];
    if (sheet) {
      console.log('\n=== HOJA DEPOSITO ===');
      const data = XLSX.utils.sheet_to_json(sheet, { header: 1 });
      data.slice(0, 50).forEach((row, idx) => {
        if (row.some(x => x !== undefined && x !== '')) {
          console.log(`Fila ${idx+1}:`, row.slice(0, 10).map(x => x !== undefined ? String(x).trim() : '').join(' | '));
        }
      });
    }
  } catch (err) {
    console.error(err);
  }
}

run();
