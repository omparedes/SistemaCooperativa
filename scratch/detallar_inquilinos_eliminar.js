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

const ids = [81, 91, 83, 101, 95];

async function run() {
  try {
    // 1. Buscar en historial_arriendos
    const { data: arriendos, error: errArriendos } = await supabase
      .from('historial_arriendos')
      .select('id, puesto_id, inquilino_id, fecha_inicio, fecha_fin')
      .in('inquilino_id', ids);
    if (errArriendos) throw errArriendos;

    // 2. Buscar en ocupaciones_almacenes
    const { data: almacenes, error: errAlmacenes } = await supabase
      .from('ocupaciones_almacenes')
      .select('id, puesto_id, inquilino_id, fecha_inicio, fecha_fin')
      .in('inquilino_id', ids);
    if (errAlmacenes) throw errAlmacenes;

    // 3. Obtener nombres de puestos
    const puestoIds = [...new Set([...arriendos.map(a => a.puesto_id), ...almacenes.map(al => al.puesto_id)])];
    const { data: puestos, error: errPuestos } = await supabase
      .from('puestos')
      .select('id, codigo_puesto, tipo_espacio')
      .in('id', puestoIds);
    if (errPuestos) throw errPuestos;

    const puestoMap = {};
    puestos.forEach(p => { puestoMap[p.id] = `${p.codigo_puesto} (${p.tipo_espacio})`; });

    // 4. Obtener nombres de inquilinos
    const { data: inquilinos, error: errInq } = await supabase
      .from('inquilinos')
      .select('id, nombres, apellidos, dni')
      .in('id', ids);
    if (errInq) throw errInq;

    const inqMap = {};
    inquilinos.forEach(i => { inqMap[i.id] = `${i.apellidos} ${i.nombres} (DNI ${i.dni})`; });

    console.log('=== OCUPACIONES DE INQUILINOS A ELIMINAR ===');
    console.log('\n--- En historial_arriendos (Puestos Regular/Pequeño): ---');
    arriendos.forEach(a => {
      console.log(`Inquilino: ${inqMap[a.inquilino_id]} | Puesto: ${puestoMap[a.puesto_id]} | Inicio: ${a.fecha_inicio} | Fin: ${a.fecha_fin}`);
    });

    console.log('\n--- En ocupaciones_almacenes (Almacenes): ---');
    almacenes.forEach(a => {
      console.log(`Inquilino: ${inqMap[a.inquilino_id]} | Puesto: ${puestoMap[a.puesto_id]} | Inicio: ${a.fecha_inicio} | Fin: ${a.fecha_fin}`);
    });

  } catch (err) {
    console.error(err);
  }
}

run();
