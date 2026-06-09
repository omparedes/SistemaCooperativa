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

async function run() {
  try {
    // Consultar todos los puestos
    const { data: puestos, error: errorPuestos } = await supabase
      .from('puestos')
      .select('id, codigo_puesto, tipo_espacio, socio_id, inquilino_id')
      .is('deleted_at', null);
    if (errorPuestos) throw errorPuestos;

    console.log(`Total puestos activos en DB: ${puestos.length}`);

    // Consultar historial_arriendos activo (donde fecha_fin es null)
    // A veces la ocupación se maneja con la columna inquilino_id en la tabla puestos directamente
    // O mediante la tabla historial_arriendos
    const { data: arriendos, error: errorArriendos } = await supabase
      .from('historial_arriendos')
      .select('id, puesto_id, inquilino_id, fecha_inicio, fecha_fin')
      .is('fecha_fin', null);
    
    // Si la tabla historial_arriendos no existe o da error, no importa, usamos la columna de puestos
    console.log(`Total arriendos activos (historial_arriendos): ${arriendos ? arriendos.length : 'N/A'}`);

    // Consultar todos los inquilinos
    const { data: inquilinos, error: errorInquilinos } = await supabase
      .from('inquilinos')
      .select('id, dni, nombres, apellidos, tipo_inquilino')
      .is('deleted_at', null);
    if (errorInquilinos) throw errorInquilinos;

    // Generar un reporte del estado de ocupación actual
    const ocupaciones = puestos.map(p => {
      const inq = p.inquilino_id ? inquilinos.find(i => i.id === p.inquilino_id) : null;
      return {
        puestoId: p.id,
        codigoPuesto: p.codigo_puesto,
        tipoEspacio: p.tipo_espacio,
        inquilinoId: p.inquilino_id,
        inquilinoNombre: inq ? `${inq.apellidos} ${inq.nombres}` : null,
        inquilinoDni: inq ? inq.dni : null
      };
    });

    fs.writeFileSync(
      path.join(__dirname, 'ocupaciones_db.json'),
      JSON.stringify({
        inquilinos: inquilinos.map(i => {
          const puestoAsociado = ocupaciones.find(o => o.inquilinoId === i.id);
          return {
            id: i.id,
            dni: i.dni,
            nombres: i.nombres,
            apellidos: i.apellidos,
            tipo_inquilino: i.tipo_inquilino,
            puesto: puestoAsociado ? puestoAsociado.codigoPuesto : null
          };
        }),
        puestos: ocupaciones
      }, null, 2)
    );

    console.log('Saved occupancy report to scratch/ocupaciones_db.json');

  } catch (err) {
    console.error('Error:', err);
  }
}

run();
