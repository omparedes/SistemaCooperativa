const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');
const XLSX = require('xlsx');

// 1. Cargar configuración de .env
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

// Mapeo de meses en español a índices numéricos
const MESES = {
  'ENERO': 1, 'ENE': 1,
  'FEBRERO': 2, 'FEB': 2,
  'MARZO': 3, 'MAR': 3,
  'ABRIL': 4, 'ABR': 4,
  'MAYO': 5, 'MAY': 5,
  'JUNIO': 6, 'JUN': 6,
  'JULIO': 7, 'JUL': 7,
  'AGOSTO': 8, 'AGO': 8,
  'SEPTIEMBRE': 9, 'SETIEMBRE': 9, 'SET': 9, 'SEP': 9,
  'OCTUBRE': 10, 'OCT': 10,
  'NOVIEMBRE': 11, 'NOV': 11,
  'DICIEMBRE': 12, 'DIC': 12
};

// Mapeo de conceptos del Excel a nombres canónicos en BD
const CONCEPTOS_BD = {
  'LUZ': 'Luz',
  'AGUA': 'Agua',
  'G. ADM': 'Gastos administrativos',
  'P. SOCIAL': 'Previsión social',
  'P.S': 'Previsión social',
  'DEPOSITO': 'Aporte extraordinario',
  'DEPOSITO ': 'Aporte extraordinario',
  'DEPOSITO N° 1 3PISO': 'Deposito',
  'DEPOSITO N° 8': 'Deposito',
  'DEPOSITO N° 2A 1 PISO': 'Deposito',
  'DEPOSITO N° 2 3PISO': 'Deposito',
  'DEPOSITO N° 3 3PISO': 'Deposito',
  'P.S X FALL. FLORES FLORES UMBELINA': 'Fallecimiento de socio',
  'MULTA X CAPACITACION': 'Multa',
  'MULTA 27-11-2025': 'Multa',
  'MULTA 26/03/2026': 'Multa',
  'MULTA 27/03/25': 'Multa',
  'MULTA 17/07/25': 'Multa',
  'MULTA 27/11/25': 'Multa',
  'FUMIGACION': 'Otros',
  'TALONARIO SANTA ROSA': 'Otros',
  'P': 'Otros'
};

// Definir los bloques de archivos Excel
const BLOCKS = [
  {
    name: 'A-C',
    solo2026: 'migracion_coop/2026/1.DETALLE SOCIO A-C NV 4-11-2025 - SOLO 2026.xlsx',
    deudas: 'migracion_coop/2026/1.DETALLE SOCIO A-C NV 4-11-2025 - DEUDAS PENDIENTES.xlsx'
  },
  {
    name: 'C-Q',
    solo2026: 'migracion_coop/2026/2.DETALLE SOCIO C-Q NV 4-11-2025 - SOLO 2026.xlsx',
    deudas: 'migracion_coop/2026/2.DETALLE SOCIO C-Q NV 4-11-2025 - DEUDAS PENDIENTES.xlsx'
  },
  {
    name: 'M-R',
    solo2026: 'migracion_coop/2026/3.DETALLE SOCIO M-R 3 -9-2025 - SOLO 2026.xlsx',
    deudas: 'migracion_coop/2026/3.DETALLE SOCIO M-R 3 -9-2025 - DEUDAS PENDIENTES.xlsx'
  },
  {
    name: 'M-Z',
    solo2026: 'migracion_coop/2026/4.DETALLE SOCIO M-Z NV 4-11-2025 - SOLO 2026.xlsx',
    deudas: 'migracion_coop/2026/4.DETALLE SOCIO M-Z NV 4-11-2025 - DEUDAS PENDIENTES.xlsx'
  }
];

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

// Búsqueda por similitud de nombres
function findSocio(sheetName, databaseSocios) {
  const normSheet = normalizar(sheetName);
  if (!normSheet || normSheet === 'RESUMEN' || normSheet === 'PLANTILLA') return null;

  // 1. Coincidencia exacta o contención directa
  let match = databaseSocios.find(s => {
    const dbNorm = normalizar(`${s.apellidos} ${s.nombres}`);
    const dbNormRev = normalizar(`${s.nombres} ${s.apellidos}`);
    return dbNorm === normSheet || dbNormRev === normSheet || dbNorm.includes(normSheet) || dbNormRev.includes(normSheet) || normSheet.includes(dbNorm);
  });

  // 2. Coincidencia por partes: se elige el socio con MAYOR cantidad de
  //    palabras coincidentes (no el primero que alcance el umbral), para
  //    evitar mapeos erróneos entre homónimos parciales (p.ej. dos personas
  //    que comparten apellido y un nombre, pero difieren en el resto).
  if (!match) {
    const partsSheet = normSheet.split(' ').filter(w => w.length > 2);
    let bestScore = 0;
    let bestMatch = null;
    for (const s of databaseSocios) {
      const dbNorm = normalizar(`${s.apellidos} ${s.nombres}`);
      let coincs = 0;
      for (const p of partsSheet) {
        if (dbNorm.includes(p)) coincs++;
      }
      if (coincs > bestScore) {
        bestScore = coincs;
        bestMatch = s;
      }
    }
    if (bestScore >= 2) match = bestMatch;
  }

  return match;
}

// Convierte número de fecha Excel a objeto Date local
function excelDateToJS(excelDate) {
  if (!excelDate) return null;
  if (excelDate instanceof Date) return excelDate;
  if (isNaN(excelDate)) return new Date(excelDate);
  const date = new Date((excelDate - 25569) * 86400 * 1000);
  const userTimezoneOffset = date.getTimezoneOffset() * 60000;
  return new Date(date.getTime() + userTimezoneOffset);
}

async function main() {
  console.log("Cargando datos desde Supabase...");
  
  // 1. Cargar socios
  const { data: dbSocios, error: errS } = await supabase
    .from('socios')
    .select('id, nombres, apellidos, dni');
  if (errS) throw errS;

  // 2. Cargar titularidades activas
  const { data: dbTitularidades, error: errT } = await supabase
    .from('historial_titularidad')
    .select('socio_id, puesto_id')
    .is('fecha_fin', null);
  if (errT) throw errT;

  const socioPuestoMap = {};
  dbTitularidades.forEach(t => {
    socioPuestoMap[t.socio_id] = t.puesto_id;
  });

  // 3. Cargar conceptos activos
  const { data: dbConceptos, error: errC } = await supabase
    .from('conceptos')
    .select('id, nombre')
    .is('deleted_at', null);
  if (errC) throw errC;

  const conceptMap = {};
  dbConceptos.forEach(c => {
    conceptMap[c.nombre] = c.id;
  });

  const L = [];
  L.push(`-- =============================================================================`);
  L.push(`-- Migración 00059 — Corrección de Fechas, Deudas y Pagos de Socios`);
  L.push(`-- Cooperativa Primero de Mayo · SistemaCooperativa`);
  L.push(`-- Generado automáticamente: ${new Date().toISOString().slice(0, 10)}`);
  L.push(`-- =============================================================================`);
  L.push(``);
  L.push(`-- HEADER_SECTION_START`);
  L.push(`-- (El script limpiará deudas/pagos socio a socio en cada bloque DO para mayor seguridad)`);
  L.push(`-- HEADER_SECTION_END`);
  L.push(``);

  let totalMappedSheets = 0;
  let blockId = 0;

  for (const block of BLOCKS) {
    console.log(`\nProcesando bloque: ${block.name}`);
    
    // Cargar Excels
    const wbSolo = XLSX.readFile(block.solo2026, { cellDates: true });
    const wbDeudas = XLSX.readFile(block.deudas, { cellDates: true });
    
    console.log(`- Leído SOLO 2026 (${wbSolo.SheetNames.length} hojas)`);
    console.log(`- Leído DEUDAS PENDIENTES (${wbDeudas.SheetNames.length} hojas)`);

    // Mapear hojas a socios de la base de datos
    const partnerData = {};

    const registerPartner = (socio) => {
      if (!partnerData[socio.id]) {
        partnerData[socio.id] = {
          socio,
          puestoId: socioPuestoMap[socio.id] || null,
          rawCharges: [],
          rawPayments: []
        };
      }
      return partnerData[socio.id];
    };

    // 1. Procesar archivo de Pagos (SOLO 2026)
    wbSolo.SheetNames.forEach(sheetName => {
      const socio = findSocio(sheetName, dbSocios);
      if (!socio) return;
      
      const entry = registerPartner(socio);
      const ws = wbSolo.Sheets[sheetName];
      const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });

      rows.forEach(r => {
        if (r.length < 6 || !r[0]) return;
        const fecha = excelDateToJS(r[0]);
        if (!fecha || isNaN(fecha.getTime())) return;

        const comprobante = String(r[1] || '').trim();
        const periodoStr = String(r[2] || '').trim().toUpperCase();
        const conceptoRaw = String(r[3] || '').trim();
        const monto = parseFloat(r[5]);

        if (isNaN(monto) || monto <= 0 || !MESES[periodoStr]) return;

        let normalizedConcept = CONCEPTOS_BD[conceptoRaw.toUpperCase().trim()] || 'Otros';
        if (conceptoRaw.toUpperCase().trim() === 'G. ADM' && monto === 5.00) {
          normalizedConcept = 'Previsión social';
        }
        const conceptoId = conceptMap[normalizedConcept] || 18; // 18 = Otros

        // Deducir el año real del periodo cronológicamente
        const payMonth = fecha.getMonth() + 1;
        const payYear = fecha.getFullYear();
        const periodMonth = MESES[periodoStr];
        const periodYear = (periodMonth > payMonth) ? (payYear - 1) : payYear;

        entry.rawCharges.push({
          anio: periodYear,
          mes: periodMonth,
          conceptoId,
          monto,
          conceptoRaw,
          source: 'SOLO 2026'
        });

        entry.rawPayments.push({
          fechaPago: fecha,
          comprobante,
          periodoStr,
          conceptoRaw,
          conceptoId,
          periodYear,
          periodMonth,
          monto
        });
      });
    });

    // 2. Procesar archivo de Deudas Pendientes (DEUDAS PENDIENTES)
    wbDeudas.SheetNames.forEach(sheetName => {
      const socio = findSocio(sheetName, dbSocios);
      if (!socio) return;

      const entry = registerPartner(socio);
      const ws = wbDeudas.Sheets[sheetName];
      const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });

      rows.forEach(r => {
        if (r.length < 5 || !r[0]) return;
        const fecha = excelDateToJS(r[0]);
        if (!fecha || isNaN(fecha.getTime())) return;

        const tipo = String(r[1] || '').trim().toUpperCase();
        const periodoStr = String(r[2] || '').trim().toUpperCase();
        const conceptoRaw = String(r[3] || '').trim();
        const monto = parseFloat(r[4]);

        if (tipo !== 'POR COBRAR' || isNaN(monto) || monto <= 0 || !MESES[periodoStr]) return;

        let normalizedConcept = CONCEPTOS_BD[conceptoRaw.toUpperCase().trim()] || 'Otros';
        if (conceptoRaw.toUpperCase().trim() === 'G. ADM' && monto === 5.00) {
          normalizedConcept = 'Previsión social';
        }
        const conceptoId = conceptMap[normalizedConcept] || 18; // 18 = Otros

        // Para deudas pendientes, la fecha en Columna A es la fecha de generación real de la deudor
        const periodYear = fecha.getFullYear();
        const periodMonth = MESES[periodoStr];

        entry.rawCharges.push({
          anio: periodYear,
          mes: periodMonth,
          conceptoId,
          monto,
          conceptoRaw,
          source: 'DEUDAS PENDIENTES'
        });
      });
    });

    // Escribir el SQL para los socios de este bloque
    Object.values(partnerData).forEach(entry => {
      if (entry.rawCharges.length === 0 && entry.rawPayments.length === 0) return;
      if (!entry.puestoId) {
        L.push(`-- SOCIO OMITIDO: ${entry.socio.apellidos} ${entry.socio.nombres} (ID: ${entry.socio.id}) - No tiene puesto asignado\n`);
        return;
      }

      totalMappedSheets++;
      blockId++;
      const bid = blockId;
      const socioFullName = `${entry.socio.apellidos} ${entry.socio.nombres}`.trim();

      // Agrupar todos los cargos únicos
      const chargesMap = {};
      const uniqueCharges = [];
      entry.rawCharges.forEach(c => {
        const key = `${c.conceptoId}_${c.anio}_${c.mes}`;
        if (!chargesMap[key]) {
          chargesMap[key] = {
            conceptoId: c.conceptoId,
            anio: c.anio,
            mes: c.mes,
            monto: 0,
            idx: uniqueCharges.length,
            conceptoRaw: c.conceptoRaw
          };
          uniqueCharges.push(chargesMap[key]);
        }
        chargesMap[key].monto += c.monto;
      });

      L.push(`-- [${'─'.repeat(56)}]`);
      L.push(`-- [${bid}] SOCIO: ${socioFullName} (Puesto: ${entry.puestoId}, ID: ${entry.socio.id})`);
      L.push(`DO $b${bid}$`);
      L.push(`DECLARE`);
      L.push(`    v_user_uuid         uuid;`);
      L.push(`    v_pago_res          json;`);
      L.push(`    v_pago_id           bigint;`);
      L.push(`    v_socio_${entry.socio.id} bigint := ${entry.socio.id};`);
      L.push(`    v_puesto_${entry.socio.id} bigint := ${entry.puestoId};`);

      // Declarar variables de montos
      uniqueCharges.forEach((c, idx) => {
        L.push(`    v_m_id_${entry.socio.id}_${idx} bigint;`);
      });

      L.push(`BEGIN`);
      L.push(`    -- Obtener un UUID de usuario administrador para auditoría`);
      L.push(`    SELECT id INTO v_user_uuid FROM public.perfiles WHERE rol = 'Administrador' AND activo = true LIMIT 1;`);
      L.push(`    IF v_user_uuid IS NULL THEN v_user_uuid := '00000000-0000-0000-0000-000000000000'; END IF;`);
      L.push(`    PERFORM set_config('request.jwt.claims', json_build_object('sub', v_user_uuid::text, 'role', 'authenticated')::text, true);`);
      L.push(``);
      L.push(`    -- 1. Limpiar datos previos de este puesto para evitar duplicados`);
      L.push(`    DELETE FROM public.detalle_pagos WHERE monto_id IN (`);
      L.push(`        SELECT id FROM public.montos_por_cobrar `);
      L.push(`        WHERE puesto_id = v_puesto_${entry.socio.id} `);
      L.push(`          AND (observacion LIKE 'Migración de deudas 2026 - %' OR observacion LIKE 'Migración de pagos 2026 - %')`);
      L.push(`    );`);
      L.push(`    DELETE FROM public.pagos WHERE puesto_id = v_puesto_${entry.socio.id} `);
      L.push(`      AND (observacion LIKE 'Pago histórico%' OR observacion LIKE 'Pago mensual vía tarjeta - %' OR observacion LIKE 'Pago mensual vía banco - %' OR observacion LIKE 'Pago histórico recibo N° %');`);
      L.push(`    DELETE FROM public.montos_por_cobrar WHERE puesto_id = v_puesto_${entry.socio.id} `);
      L.push(`      AND (observacion LIKE 'Migración de deudas 2026 - %' OR observacion LIKE 'Migración de pagos 2026 - %');`);
      L.push(`    UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = v_socio_${entry.socio.id};`);
      L.push(``);

      // Insertar deudas agrupadas únicas
      L.push(`    -- 2. Insertar deudas agrupadas`);
      uniqueCharges.forEach((c, idx) => {
        const fechaGenStr = `${c.anio}-${String(c.mes).padStart(2, '0')}-01`;
        L.push(`    INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)`);
        L.push(`    VALUES (v_puesto_${entry.socio.id}, ${c.conceptoId}, ${c.anio}, ${c.mes}, ${c.monto.toFixed(2)}, 'Pendiente', 'Manual', '${fechaGenStr}', 'Migración de deudas 2026 - ${c.conceptoRaw}', v_user_uuid)`);
        L.push(`    RETURNING id INTO v_m_id_${entry.socio.id}_${idx};`);
      });
      L.push(``);

      // Procesar pagos agrupados
      if (entry.rawPayments.length > 0) {
        L.push(`    -- 3. Registrar pagos detallados y aplicarlos`);

        // Agrupar por fecha y comprobante
        const paymentsGroups = {};
        entry.rawPayments.forEach(p => {
          const fechaStr = p.fechaPago.toISOString().split('T')[0];
          const key = `${fechaStr}||${p.comprobante}`;
          if (!paymentsGroups[key]) {
            paymentsGroups[key] = [];
          }
          paymentsGroups[key].push(p);
        });

        // Sumador de pagos para determinar cubierto_completo
        const runningPaymentSum = {}; // key: cIdx -> running sum

        Object.entries(paymentsGroups).forEach(([groupKey, list]) => {
          const [fechaStr, comprobante] = groupKey.split('||');
          const totalPago = list.reduce((sum, item) => sum + item.monto, 0);
          const isTarjeta = comprobante.toUpperCase().startsWith('TARJETA') || comprobante.toUpperCase().startsWith('CHEQUE');
          const metodo = isTarjeta ? 'Transferencia' : 'Efectivo';
          const observacion = isTarjeta ? `Pago mensual vía banco - ${comprobante}` : `Pago histórico recibo N° ${comprobante}`;

          const distArray = list.map(item => {
            const chargeKey = `${item.conceptoId}_${item.periodYear}_${item.periodMonth}`;
            const targetCharge = uniqueCharges.find(c => `${c.conceptoId}_${c.anio}_${c.mes}` === chargeKey);
            const cIdx = targetCharge.idx;

            runningPaymentSum[cIdx] = (runningPaymentSum[cIdx] || 0) + item.monto;
            const reachedTotal = Math.abs(runningPaymentSum[cIdx] - targetCharge.monto) < 0.01;

            return `jsonb_build_object('monto_id', v_m_id_${entry.socio.id}_${cIdx}, 'monto_applied', ${item.monto.toFixed(2)}, 'monto_aplicado', ${item.monto.toFixed(2)}, 'cubierto_completo', ${reachedTotal})`;
          }).join(', ');

          L.push(`    v_pago_res := public.rpc_procesar_pago(`);
          L.push(`        v_puesto_${entry.socio.id},`);
          L.push(`        v_socio_${entry.socio.id},`);
          L.push(`        NULL,`);
          L.push(`        ${totalPago.toFixed(2)},`);
          L.push(`        '${metodo}',`);
          L.push(`        '${comprobante}',`);
          L.push(`        '${observacion}',`);
          L.push(`        v_user_uuid,`);
          L.push(`        jsonb_build_array(${distArray}),`);
          L.push(`        0.00,`);
          L.push(`        '${fechaStr} 12:00:00-05'`);
          L.push(`    );`);
          L.push(`    v_pago_id := (v_pago_res->>'pago_id')::bigint;`);
          L.push(`    UPDATE public.pagos SET fecha_pago = '${fechaStr} 12:00:00-05', created_at = '${fechaStr} 12:00:00-05', observacion = '${observacion}' WHERE id = v_pago_id;`);
          L.push(`    UPDATE public.detalle_pagos SET fecha_aplicacion = '${fechaStr} 12:00:00-05', created_at = '${fechaStr} 12:00:00-05' WHERE pago_id = v_pago_id;`);
        });
      }

      L.push(`EXCEPTION WHEN OTHERS THEN RAISE WARNING 'Error b${bid} ${socioFullName.replace(/'/g, "''")}:%',SQLERRM;`);
      L.push(`END;`);
      L.push(`$b${bid}$;`);
      L.push(``);
    });
  }

  L.push(`-- FOOTER_SECTION_START`);
  L.push(`-- Reporte final de validación`);
  L.push(`SELECT`);
  L.push(`  (SELECT count(*) FROM public.montos_por_cobrar WHERE deleted_at IS NULL)      AS montos_total,`);
  L.push(`  (SELECT count(*) FROM public.montos_por_cobrar WHERE deleted_at IS NULL AND estado='Pagado')   AS montos_pagados,`);
  L.push(`  (SELECT count(*) FROM public.montos_por_cobrar WHERE deleted_at IS NULL AND estado='Pendiente') AS montos_pendientes,`);
  L.push(`  (SELECT count(*) FROM public.pagos          WHERE deleted_at IS NULL)          AS pagos_total;`);
  L.push(`-- FOOTER_SECTION_END`);
  L.push(``);
  L.push(`COMMIT;`);

  const sqlContent = L.join('\n');
  const pathSql = 'supabase/migrations/00059_correccion_deudas_y_pagos_socios.sql';
  fs.writeFileSync(pathSql, sqlContent, 'utf8');

  console.log(`\n==================================================`);
  console.log(`MIGRACIÓN GENERADA EXITOSAMENTE`);
  console.log(`  Archivo: ${pathSql}`);
  console.log(`  Total de socios mapeados: ${totalMappedSheets}`);
  console.log(`==================================================\n`);
}

main().catch(console.error);
