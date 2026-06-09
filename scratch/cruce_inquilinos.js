const XLSX = require('xlsx');
const path = require('path');
const fs = require('fs');
const { createClient } = require('@supabase/supabase-js');

// Configuración de Supabase
const supabaseUrl = 'https://sucnpjawtpattgkatqqn.supabase.co';
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || 'YOUR_SUPABASE_SERVICE_ROLE_KEY';
if (supabaseKey === 'YOUR_SUPABASE_SERVICE_ROLE_KEY') {
  console.error('Error: Debes definir la variable de entorno SUPABASE_SERVICE_ROLE_KEY');
  process.exit(1);
}
const supabase = createClient(supabaseUrl, supabaseKey);

// Rutas de archivos Excel
const pagosAM = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_pagos_2026/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH - PAGOS 2026.xlsx');
const pagosNZ = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_pagos_2026/DETALLE DE DEUDA POR CADA INQUILINO N-Z -2023 - RUTH  27.09 - PAGOS 2026.xlsx');
const deudasAM = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO DE LA A -M 2023 - RUTH - DEUDAS PENDIENTES.xlsx');
const deudasNZ = path.join(__dirname, '../migracion_coop/2026/inquilinos_ruth_por_cobrar/DETALLE DE DEUDA POR CADA INQUILINO N-Z -2023 - RUTH  27.09 - DEUDAS PENDIENTES.xlsx');

async function run() {
  try {
    // 1. Obtener inquilinos actuales de la DB
    // deleted_at IS NULL
    const { data: dbInquilinos, error } = await supabase
      .from('inquilinos')
      .select('id, dni, nombres, apellidos, tipo_inquilino')
      .is('deleted_at', null);

    if (error) throw error;

    console.log(`Inquilinos activos en DB: ${dbInquilinos.length}`);

    // Lista del prompt (los que el usuario nos mandó como lista actual en el sistema)
    const listaPrompt = [
      "ACCO NOA VICTOR",
      "ACCO NOA VICTOR",
      "AIRE MALPARTIDA HECTOR",
      "ALARCON ESPINOZA MARTHA ESPERANZA",
      "ALVAREZ BERRIO FLORENCIA ASUNTA",
      "ALVAREZ CHIARA EDGAR SALVADOR",
      "ANCHAYA HUAMAN ABEL",
      "ARMESTAR GODOS JUANA JACKELYNE",
      "ARREDONDO GARCIA GLADYS",
      "AVILA CHAVEZ ROSA MARINA",
      "AYALA HUASHUAYO MARLENE ESTHER",
      "AZURZA TRIBINOS DAYSI ELIZABETH",
      "BELLIDO DE LA TORRE DE CHUQUITAIPE ZENAIDA",
      "BENITES TRIBINOS ERIKA",
      "BURGA CARRASCO ELMER",
      "BUSTAMANTE CHILON GRACIELA",
      "BUSTAMANTE JOSE",
      "CAHUANA PUCURIMAY ALEX ENRIQUE",
      "CARRASCO PICHIHUA MERY RUTH",
      "CARTAGENA ALVARO",
      "CASTILLO ZAPATA ESAEL",
      "CASTRO RODRIGUEZ JANETT CONSUELO",
      "CAYO HUAMANI BACILIO ANTONIO",
      "CCENCHO CARRASCO DAVID VICENTE",
      "CERDAN MUNOZ MARIA DOMINGA",
      "CERRON GALVAN OBDULIA",
      "CERVANTES GARCIA CARLOS ARTURO",
      "CHAMBI APAZA SIMONA",
      "CHIPANA DE VARGAS ANATOLIA",
      "CHOQUEHUANCA HUAMAN DAVID",
      "CHOQUEHUANCA HUAMAN DERSE",
      "CLAROS TORRES SANTOS JESUS",
      "COLINA CORREA SIRLEY KARINA",
      "CONDORI MAMANI LIDIA AGRIPINA",
      "COOPERATIVA PRIMERO DE MAYO",
      "CUNIAS SANTOS MARIELA",
      "DAVILA CAHUANA MARISOL",
      "DAVILA HILARES YESENIA BEATRIZ",
      "DURAN CHACON BLANCA NIEVES",
      "ENCARNACION PAUCARPOMA GLADYS",
      "ESPARTA CARDENAS JULIO HECTOR",
      "FERREYRA COSME TANIA MABEL",
      "FLORES LAREDO DOMINICIA LUCIANA",
      "GARCIA MEDINA VDA DE MOLINA CLEMENCIA BEATRIZ",
      "GOMERO DULANTO MARGARITA JUANA",
      "GOMEZ MITMA MARIBEL",
      "HERNANDEZ HERNANDEZ LILIBETH MARIA",
      "HERRERA CAMPOS ORFELITA",
      "HERRERA PEVES ROMINA DEL CARMEN",
      "HUAMANI CONTRERAS MAXIMO FLAVIO",
      "IDALINA MONTENEGRO BAUTISTA",
      "KARINA LUZ LUCIANO INGA",
      "LA ROSA LOPEZ MARGARITA LILIANA",
      "LAPAS ZALAZAR ANA MARIA",
      "LEON RODRIGUEZ ANGIE MARGARITA",
      "LEONARDO AMARILLO FEDERICO MANUEL",
      "LEONARDO AMARILLO ROSANA PILAR",
      "LOPEZ CERRON HAYDEE",
      "MALLMA CONDORI LISBETH LUCIA",
      "MARILIN DEL CARMEN VERA",
      "MAYHUASCA BASTIDAS DORIS",
      "MESIAS GLADYS",
      "MIRANDA CACERES FELICITA",
      "MUJICA PALOMINO SANDRA LIZ",
      "OBREGON CASTILLO FERNANDO MARTIN",
      "PALOMINO CUSI ROSA",
      "PENA VDA DE VILLANUEVA TERESA",
      "PENA VILLANUEVA ASHLEY MARYORI",
      "PFUNO RAMOS VICTOR RAUL",
      "PRADO CATANO MIRIAM MILAGROS",
      "QUISPE CHAVEZ MARI SOL",
      "QUISPE MAMANI PATRICIA PAOLA",
      "QUISPE NAPUCHE LISBETH KARITO",
      "REBAZA REBAZA CASILDA CATALINA",
      "RENTERIA HUANCAS ROSA ARMANDINA",
      "SALAZAR VASQUEZ MARIA ROSARIO",
      "SALDANA DONAYRE JESSICA PATRICIA",
      "SANCHEZ PRADO DIANA ZENAIDA",
      "SUAREZ REBAZA LUIS ABRAHAM",
      "TUEROS QUISPE PRUDENCIO",
      "VILLANUEVA INGA ROSA",
      "YAURIMUCHA RIMACHI URSULA",
      "YAUYOS MENDIETA MARLENE",
      "YUPANQUI QUISPE SAYDA",
      "ZANABRIA LADERA DE COCHACHI LILIA RUFINA"
    ];

    console.log(`Inquilinos en lista del prompt (sin duplicados exactos): ${[...new Set(listaPrompt)].length}`);

    // 2. Cargar nombres de las hojas del Excel
    const loadSheets = (file) => XLSX.readFile(file).SheetNames;
    const sheetsPagos = [...loadSheets(pagosAM), ...loadSheets(pagosNZ)].filter(s => s !== '2016');
    const sheetsDeudas = [...loadSheets(deudasAM), ...loadSheets(deudasNZ)].filter(s => s !== '2016' && s !== 'REVISION');

    console.log(`Total hojas pagos en Excel: ${sheetsPagos.length}`);
    console.log(`Total hojas deudas en Excel: ${sheetsDeudas.length}`);

    // Cruzar hojas de pagos y deudas
    const todasLasHojas = [...new Set([...sheetsPagos, ...sheetsDeudas])];
    console.log(`Hojas únicas en Excel (pagos + deudas): ${todasLasHojas.length}`);

    // Normalizar texto para comparación
    const normalizar = (txt) => {
      if (!txt) return '';
      return txt.toLowerCase()
        .normalize("NFD").replace(/[\u0300-\u036f]/g, "") // quitar tildes
        .replace(/ñ/g, 'n')
        .replace(/[^a-z0-9]/g, ' ') // reemplazar caracteres especiales por espacios
        .replace(/\s+/g, ' ') // unificar espacios
        .trim();
    };

    const dbNormalizados = dbInquilinos.map(i => ({
      ...i,
      nombreCompleto: `${i.apellidos} ${i.nombres}`,
      nombreNormalizado: normalizar(`${i.apellidos} ${i.nombres}`),
      nombreNormalizadoInvertido: normalizar(`${i.nombres} ${i.apellidos}`)
    }));

    const hojasNormalizadas = todasLasHojas.map(h => ({
      original: h,
      normalizado: normalizar(h)
    }));

    // Intentar emparejar
    console.log('\n--- INTENTANDO EMPAREJAR HOJAS EXCEL CON DB ---');
    const matched = [];
    const unmatchedExcel = [];

    for (const hoja of hojasNormalizadas) {
      // Intento 1: Coincidencia exacta o contenida
      let dbMatch = dbNormalizados.find(db => 
        db.nombreNormalizado.includes(hoja.normalizado) || 
        db.nombreNormalizadoInvertido.includes(hoja.normalizado) ||
        hoja.normalizado.includes(db.nombreNormalizado) ||
        hoja.normalizado.includes(db.nombreNormalizadoInvertido)
      );

      // Intento 2: Buscar por palabras individuales si no hay match directo
      if (!dbMatch) {
        const words = hoja.normalizado.split(' ').filter(w => w.length > 2);
        if (words.length > 0) {
          dbMatch = dbNormalizados.find(db => {
            return words.every(w => db.nombreNormalizado.includes(w) || db.nombreNormalizadoInvertido.includes(w));
          });
        }
      }

      if (dbMatch) {
        matched.push({
          excel: hoja.original,
          db: dbMatch,
          tipo: 'MATCH'
        });
      } else {
        unmatchedExcel.push(hoja.original);
      }
    }

    console.log(`Emparejados automáticamente: ${matched.length}`);
    console.log(`Sin emparejar en Excel: ${unmatchedExcel.length}`);
    console.log('Hojas de Excel sin emparejar en DB:', unmatchedExcel);

    // Inquilinos de DB que no tienen hoja en Excel
    const dbNotMatched = dbNormalizados.filter(db => {
      return !matched.some(m => m.db.id === db.id);
    });

    console.log(`\nInquilinos en DB que NO tienen hoja de deudas/pagos 2026: ${dbNotMatched.length}`);
    dbNotMatched.forEach(db => {
      console.log(` - ID: ${db.id} | DNI: ${db.dni} | Nombres: ${db.nombreCompleto}`);
    });

    // Guardar el análisis
    fs.writeFileSync(
      path.join(__dirname, 'cruce_inquilinos_report.json'), 
      JSON.stringify({
        resumen: {
          dbActivos: dbInquilinos.length,
          hojasExcel: todasLasHojas.length,
          emparejados: matched.length,
          sinEmparejarExcel: unmatchedExcel.length,
          sinEmparejarDB: dbNotMatched.length
        },
        emparejados: matched.map(m => ({
          excel: m.excel,
          dbId: m.db.id,
          dbDni: m.db.dni,
          dbNombre: m.db.nombreCompleto
        })),
        sinEmparejarExcel: unmatchedExcel,
        sinEmparejarDB: dbNotMatched.map(db => ({
          id: db.id,
          dni: db.dni,
          nombre: db.nombreCompleto
        }))
      }, null, 2)
    );

    console.log('\nReporte completo guardado en scratch/cruce_inquilinos_report.json');

  } catch (err) {
    console.error('Error durante el cruce:', err);
  }
}

run();
