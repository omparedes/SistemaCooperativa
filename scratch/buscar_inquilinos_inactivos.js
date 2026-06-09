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

const namesToSearch = [
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

async function run() {
  try {
    // Buscar todos los inquilinos (activos y borrados)
    const { data: allInquilinos, error } = await supabase
      .from('inquilinos')
      .select('id, dni, nombres, apellidos, deleted_at, tipo_inquilino');

    if (error) throw error;

    console.log(`Inquilinos en total (incluyendo borrados): ${allInquilinos.length}`);

    const normalizar = (txt) => {
      if (!txt) return '';
      return txt.toLowerCase()
        .normalize("NFD").replace(/[\u0300-\u036f]/g, "")
        .replace(/ñ/g, 'n')
        .replace(/[^a-z0-9]/g, ' ')
        .replace(/\s+/g, ' ')
        .trim();
    };

    const inqNormalizados = allInquilinos.map(i => ({
      ...i,
      fullName: `${i.apellidos} ${i.nombres}`,
      normName: normalizar(`${i.apellidos} ${i.nombres}`),
      normNameInv: normalizar(`${i.nombres} ${i.apellidos}`)
    }));

    for (const name of namesToSearch) {
      const normSearch = normalizar(name);
      const matches = inqNormalizados.filter(inq => 
        inq.normName.includes(normSearch) || 
        inq.normNameInv.includes(normSearch) ||
        normSearch.includes(inq.normName) ||
        normSearch.includes(inq.normNameInv)
      );

      if (matches.length > 0) {
        console.log(`\nCoincidencias para "${name}":`);
        matches.forEach(m => {
          console.log(` - ID: ${m.id} | DNI: ${m.dni} | Nombres: ${m.fullName} | DeletedAt: ${m.deleted_at} | Tipo: ${m.tipo_inquilino}`);
        });
      } else {
        console.log(`\nNo se encontró ninguna coincidencia en la DB para "${name}"`);
      }
    }

  } catch (err) {
    console.error(err);
  }
}

run();
