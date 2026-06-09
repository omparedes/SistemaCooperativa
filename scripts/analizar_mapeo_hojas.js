const XLSX = require('xlsx');
const path = require('path');
const { createClient } = require('@supabase/supabase-js');

const excelPath = path.join(__dirname, '../migracion_coop/2026/1.DETALLE SOCIO A-C NV 4-11-2025 - DEUDAS PENDIENTES.xlsx');

// Parser manual de .env
const fs = require('fs');
const envFile = fs.readFileSync('.env', 'utf8');
const envVars = {};
envFile.split('\n').forEach(line => {
  const match = line.match(/^\s*([^#=\s]+)\s*=\s*(.*)\s*$/);
  if (match) {
    let val = match[2].trim();
    if (val.startsWith('"') && val.endsWith('"')) val = val.slice(1, -1);
    if (val.startsWith("'") && val.endsWith("'")) val = val.slice(1, -1);
    envVars[match[1]] = val;
  }
});

const supabaseUrl = envVars.SUPABASE_URL;
const supabaseKey = envVars.SUPABASE_SERVICE_ROLE_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

const sociosEsperados = [
  "AGUIRRE QUISPE WILFREDO GILMER",
  "ALARCON ANAMPA BETSY",
  "ALARCON ANAMPA  NANCY GUISELA",
  "ALHUAY PALOMINO DE ALHUAY JUANA",
  "ALVAREZ CAMPOS ROLANDO",
  "ALVAREZ CAMPOS VICTOR",
  "ALVAREZ MARIN MARIANELA",
  "ANAMPA CORAHUA CLEMENCIA MIGDONIA",
  "ANCCO LEON VALENTINA",
  "ATANASIO ORTEGA MAXIMILIANA",
  "AYALA HUASHUAYO NORMA GLADYS",
  "AYALA TABOADA ELISEO",
  "BASTIDAS MEDINA DINA",
  "BASTIDAS MEDINA HERMENEGILDO",
  "BERNAOLA DE PRADO FLORENCIA",
  "BRAVO HEREDIA ANA MARITZA",
  "BURGA CARRASCO ELIDA",
  "CABALLERO CALZADO GLADYS VICTORIA",
  "CABERO MENDOZA GLORIA",
  "CAHUANA VDA DE DAVILA VICENTINA",
  "CAJALEON CARRASCO LUIS ENRIQUE",
  "CALDERON TORRES ESTELA",
  "CALDERON VERA SEGUNDO ALCIDES",
  "CALLE ALVAREZ MARCO ANTONIO",
  "CALLE CALLE FIDEL",
  "CAMPUZANO CABELLO VICENTA DONATILA",
  "CARDEÑA VILLAFUERTE ALEJANDRINA",
  "CARPIO VASQUEZ TEOFILA",
  "CARRASCO SALVATIERRA FELICITA",
  "CARTAJENA MAMANI BENJAMIN D",
  "CARTAJENA PALOMINO ALVARO BENJAMIN",
  "CASTRO ALEJANDRO HORTENCIA LUCILA",
  "CASTRO GUTIERREZ AQUILA LUCRECIA",
  "CCOYLLO CHINCHAY DANIEL MASIA",
  "CCOYLLO CHINCHAY JUDITH NATY",
  "CCOYLLO POLANCO DANIEL",
  "CCOYLLO MAYHUASCA ALEXIS",
  "CCOYLLO POLANCO GERMAN",
  "CERDA YUPANQUI CARMEN ROSA",
  "CHALLCO DE PALOMINO NICOLAZA",
  "CHIRINOS CABRACANCHA MARIA LOURDES",
  "CCOYLLO BUSTILLOS DEYSI",
  "CHOQUE HUAMANI FELIX CEFERINO",
  "CHUCHULLO HACHA JOSE PEDRO",
  "CLEMENTE ALLER CIRILA",
  "CORDOVA PEREZ MARCO ANTONIO"
];

// Helper para limpiar espacios y normalizar texto
function normalizar(texto) {
  if (!texto) return '';
  return texto.toString()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "") // remover acentos
    .toUpperCase()
    .replace(/CARTAJENA/g, 'CARTAGENA')
    .replace(/CHOQUE\s+HUAMANI/g, 'CHOQUEHUAMANI')
    .trim()
    .replace(/\s+/g, ' ');
}

// Convierte número de fecha Excel a objeto { anio, mes, dia } y Date
function excelDateToJS(excelDate) {
  if (!excelDate || isNaN(excelDate)) return null;
  const date = new Date((excelDate - 25569) * 86400 * 1000);
  // Ajustar zona horaria local
  const userTimezoneOffset = date.getTimezoneOffset() * 60000;
  const localDate = new Date(date.getTime() + userTimezoneOffset);
  
  return {
    date: localDate,
    anio: localDate.getFullYear(),
    mes: localDate.getMonth() + 1,
    dia: localDate.getDate()
  };
}

async function start() {
  console.log('Cargando socios de la base de datos...');
  // Traemos los socios de Supabase
  const { data: dbSocios, error: errS } = await supabase
    .from('socios')
    .select('id, dni, apellidos, nombres, estado');

  if (errS) {
    console.error('Error al cargar socios de Supabase:', errS);
    return;
  }

  // Traemos los puestos asignados a socios (historial_titularidad) para saber el puesto_id activo (fecha_fin is null)
  const { data: titularidad, error: errT } = await supabase
    .from('historial_titularidad')
    .select('*')
    .is('fecha_fin', null);

  if (errT) {
    console.error('Error al cargar historial_titularidad:', errT);
    return;
  }

  // Traemos los conceptos para mapear los nombres del excel
  const { data: conceptos, error: errC } = await supabase
    .from('conceptos')
    .select('id, nombre, tipo');

  if (errC) {
    console.error('Error al cargar conceptos:', errC);
    return;
  }

  console.log(`Socios en BD: ${dbSocios.length}`);
  console.log(`Conceptos en BD: ${conceptos.length}`);

  // Abrir el excel
  const workbook = XLSX.readFile(excelPath);

  // Mapeamos los socios esperados con los de la base de datos
  const mappedDbSocios = [];
  const unmatchedSocios = [];

  for (const nombreSocio of sociosEsperados) {
    const normEsperado = normalizar(nombreSocio);
    
    // Buscar coincidencia en la BD
    // En la base de datos, el nombre suele estar en 'apellidos' o repartido en 'nombres' y 'apellidos'
    let socioEncontrado = dbSocios.find(s => {
      const dbNorm = normalizar(`${s.apellidos} ${s.nombres}`);
      const dbNormRev = normalizar(`${s.nombres} ${s.apellidos}`);
      return dbNorm.includes(normEsperado) || dbNormRev.includes(normEsperado) || normEsperado.includes(dbNorm);
    });

    // Búsqueda aproximada si no hay exacta
    if (!socioEncontrado) {
      // Intentamos con partes del nombre
      const partes = normEsperado.split(' ');
      socioEncontrado = dbSocios.find(s => {
        const dbNorm = normalizar(`${s.apellidos} ${s.nombres}`);
        // Al menos 3 partes del nombre deben coincidir
        let coincidencias = 0;
        for (const p of partes) {
          if (p.length > 2 && dbNorm.includes(p)) coincidencias++;
        }
        return coincidencias >= 3;
      });
    }

    if (socioEncontrado) {
      // Buscar su puesto asignado activo
      const puestoActivo = titularidad.find(t => t.socio_id === socioEncontrado.id);
      mappedDbSocios.push({
        nombreEsperado: nombreSocio,
        dbSocio: socioEncontrado,
        puestoId: puestoActivo ? puestoActivo.puesto_id : null
      });
    } else {
      unmatchedSocios.push(nombreSocio);
    }
  }

  console.log(`\nMatching de Socios Esperados con BD:`);
  console.log(`Matcheados: ${mappedDbSocios.length} de ${sociosEsperados.length}`);
  if (unmatchedSocios.length > 0) {
    console.log(`NO MATCHEADOS en BD (${unmatchedSocios.length}):`, unmatchedSocios);
  }

  // Ahora emparejamos las hojas del Excel con los socios esperados
  const sheetMatches = [];
  const unmatchedSheets = [];

  for (const sheetName of workbook.SheetNames) {
    const normSheet = normalizar(sheetName);
    if (!normSheet || normSheet === 'RESUMEN' || normSheet === 'PLANTILLA') continue; // Ignorar hojas de resumen

    // Buscar coincidencia con los socios esperados
    let match = mappedDbSocios.find(m => {
      const normEsp = normalizar(m.nombreEsperado);
      return normEsp.includes(normSheet) || normSheet.includes(normEsp);
    });

    if (!match) {
      // Búsqueda más laxa
      const partesSheet = normSheet.split(' ');
      match = mappedDbSocios.find(m => {
        const normEsp = normalizar(m.nombreEsperado);
        let coincidencias = 0;
        for (const p of partesSheet) {
          if (p.length > 2 && normEsp.includes(p)) coincidencias++;
        }
        return coincidencias >= 2;
      });
    }

    if (match) {
      sheetMatches.push({
        sheetName,
        partner: match
      });
    } else {
      unmatchedSheets.push(sheetName);
    }
  }

  console.log(`\nMatching de Hojas Excel con Socios:`);
  console.log(`Hojas matcheadas: ${sheetMatches.length} de ${workbook.SheetNames.filter(n => n !== 'RESUMEN' && n !== 'PLANTILLA').length}`);
  if (unmatchedSheets.length > 0) {
    console.log(`Hojas sin matchear (${unmatchedSheets.length}):`, unmatchedSheets);
  }

  // Analizar el contenido de las hojas y agrupar las deudas
  const deudasExtraidas = [];
  let deudasTotalesExcel = 0;

  for (const entry of sheetMatches) {
    const sheet = workbook.Sheets[entry.sheetName];
    const rows = XLSX.utils.sheet_to_json(sheet, { header: 1 });
    
    // Recorrer filas de la hoja
    for (let r = 0; r < rows.length; r++) {
      const fila = rows[r];
      if (!fila || fila.length === 0 || fila[0] === undefined) continue;

      // Estructura esperada: [ FechaNum, 'POR COBRAR', 'MES_STR', 'Concepto', Monto ]
      const excelFecha = fila[0];
      const tipo = fila[1];
      const mesStr = fila[2];
      let conceptoOriginal = fila[3];
      const monto = fila[4];

      if (tipo !== 'POR COBRAR' || !conceptoOriginal || isNaN(monto) || monto <= 0) {
        continue; // Ignorar si no es una deuda válida
      }

      // Convertir fecha de excel
      const parsedFecha = excelDateToJS(excelFecha);
      if (!parsedFecha) {
        console.warn(`[Hoja: ${entry.sheetName}] Fila ${r} con fecha inválida:`, fila);
        continue;
      }

      // Mapear concepto
      conceptoOriginal = conceptoOriginal.toString().trim();
      let conceptoBD = null;

      // Mapeo inteligente de concepto
      const normCon = normalizar(conceptoOriginal);
      
      // Buscar concepto en la base de datos
      if (normCon.includes('LUZ')) {
        conceptoBD = conceptos.find(c => c.nombre === 'Luz');
      } else if (normCon.includes('AGUA')) {
        conceptoBD = conceptos.find(c => c.nombre === 'Agua');
      } else if (normCon.includes('G. ADM') || normCon.includes('GASTO') || normCon.includes('ADMINIST')) {
        conceptoBD = conceptos.find(c => c.nombre === 'Gastos administrativos');
      } else if (normCon.includes('P. SOCIAL') || normCon.includes('PREVISION')) {
        conceptoBD = conceptos.find(c => c.nombre === 'Previsión social');
      } else if (normCon.includes('MULTA')) {
        conceptoBD = conceptos.find(c => c.nombre === 'Multa');
      } else if (normCon.includes('DEPOSITO')) {
        // En este mercado, el 'depósito' o garantía podría ser un concepto de garantía, o cobro extraordinario
        // Busquemos si existe un concepto de Depósito o similar
        conceptoBD = conceptos.find(c => normalizar(c.nombre).includes('DEPOSITO') || normalizar(c.nombre).includes('GARANTIA'));
        if (!conceptoBD) {
          // Si no existe, vemos si podemos mapearlo a algún cargo extraordinario o concepto general
          conceptoBD = conceptos.find(c => c.nombre === 'Cargos Extraordinarios' || c.nombre === 'Otros');
        }
      } else if (normCon.includes('FUMIGACION')) {
        conceptoBD = conceptos.find(c => normalizar(c.nombre).includes('FUMIGACION'));
        if (!conceptoBD) {
          conceptoBD = conceptos.find(c => c.nombre === 'Cargos Extraordinarios' || c.nombre === 'Otros');
        }
      }

      // Fallback si no se encuentra concepto exacto
      if (!conceptoBD) {
        // Buscamos un concepto general en la BD
        conceptoBD = conceptos.find(c => c.nombre === 'Otros') || conceptos[conceptos.length - 1];
      }

      deudasTotalesExcel++;
      deudasExtraidas.push({
        hoja: entry.sheetName,
        socioNombre: entry.partner.nombreEsperado,
        socioId: entry.partner.dbSocio.id,
        puestoId: entry.partner.puestoId,
        excelFecha,
        fechaDate: parsedFecha.date,
        anio: parsedFecha.anio,
        mes: parsedFecha.mes,
        conceptoOriginal,
        conceptoBDId: conceptoBD.id,
        conceptoBDNombre: conceptoBD.nombre,
        conceptoBDTipo: conceptoBD.tipo,
        monto: parseFloat(monto.toFixed(2))
      });
    }
  }

  console.log(`\nDeudas extraídas del Excel: ${deudasExtraidas.length} registros.`);
  
  // Resumen de deudas extraídas por concepto
  const conteoConceptos = {};
  for (const d of deudasExtraidas) {
    conteoConceptos[d.conceptoOriginal] = (conteoConceptos[d.conceptoOriginal] || 0) + 1;
  }
  console.log('Conteo por conceptos originales del Excel:', conteoConceptos);

  // Validar consistencia XOR de deudas en Supabase
  // Deudas pertenecientes al PUESTO (luz, agua, admin, prevision) vs SOCIO (multas, aportes, otros)
  let erroresXOR = 0;
  const clavesUnicas = {};
  const deudasDuplicadas = [];
  
  for (const d of deudasExtraidas) {
    const requierePuesto = ['Luz', 'Agua', 'Gastos administrativos', 'Previsión social'].includes(d.conceptoBDNombre);
    if (requierePuesto && !d.puestoId) {
      console.warn(`⚠️ ALERTA: La deuda de '${d.conceptoBDNombre}' (S/ ${d.monto}) del periodo ${d.anio}-${d.mes} para ${d.socioNombre} requiere PUESTO, pero el socio NO tiene un puesto asignado activo en la BD.`);
      erroresXOR++;
    }
    
    // Generar clave única para detectar colisión en idx_montos_unica_puesto_concepto_periodo
    if (d.puestoId) {
      const clave = `${d.puestoId}-${d.conceptoBDId}-${d.anio}-${d.mes}`;
      if (clavesUnicas[clave]) {
        deudasDuplicadas.push({
          clave,
          socio: d.socioNombre,
          concepto: d.conceptoBDNombre,
          periodo: `${d.anio}-${d.mes}`,
          anterior: clavesUnicas[clave],
          actual: d
        });
      } else {
        clavesUnicas[clave] = d;
      }
    }
  }
  
  console.log(`Errores de validación XOR (requiere puesto activo): ${erroresXOR}`);
  console.log(`Combinaciones de deudas duplicadas detectadas (colisiones de llave única): ${deudasDuplicadas.length}`);
  
  if (deudasDuplicadas.length > 0) {
    console.log('\nListado de colisiones de deudas encontradas:');
    for (const dup of deudasDuplicadas) {
      console.log(`- Socio: ${dup.socio}, Concepto: ${dup.concepto}, Periodo: ${dup.periodo}`);
      console.log(`  * Detalle anterior: S/ ${dup.anterior.monto} (Concepto original: ${dup.anterior.conceptoOriginal})`);
      console.log(`  * Detalle colisionante: S/ ${dup.actual.monto} (Concepto original: ${dup.actual.conceptoOriginal})`);
    }
  }
}

start();
