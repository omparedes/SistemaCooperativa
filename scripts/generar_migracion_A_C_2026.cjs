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
  'P.S X FALL. FLORES FLORES UMBELINA': 'Fallecimiento de socio',
  'MULTA X CAPACITACION': 'Multa',
  'MULTA 27-11-2025': 'Multa',
  'MULTA 26/03/2026': 'Multa',
  'FUMIGACION': 'Otros',
  'TALONARIO SANTA ROSA': 'Otros',
  'P': 'Otros'
};

// Helper de normalización de cadenas para comparación
function normalize(str) {
  return String(str || '')
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '') // Quitar acentos
    .replace(/[^A-Za-z0-9]/g, ' ') // Dejar solo letras y números
    .replace(/\s+/g, ' ')
    .trim()
    .toUpperCase();
}

// Distancia de Levenshtein para emparejamiento difuso
function levenshtein(a, b) {
  if (a === b) return 0;
  const m = a.length, n = b.length;
  if (m === 0) return n;
  if (n === 0) return m;
  const dp = Array.from({ length: m + 1 }, (_, i) =>
    Array.from({ length: n + 1 }, (_, j) => i === 0 ? j : j === 0 ? i : 0)
  );
  for (let i = 1; i <= m; i++) {
    for (let j = 1; j <= n; j++) {
      dp[i][j] = a[i - 1] === b[j - 1] ? dp[i - 1][j - 1] : 1 + Math.min(dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]);
    }
  }
  return dp[m][n];
}

function getSimilarity(a, b) {
  const na = normalize(a);
  const nb = normalize(b);
  const maxLen = Math.max(na.length, nb.length);
  if (maxLen === 0) return 1;
  return 1 - levenshtein(na, nb) / maxLen;
}

async function main() {
  console.log("Cargando datos desde Supabase...");
  
  // 1. Obtener socios con puestos activos
  const { data: databaseSocios, error: sErr } = await supabase
    .from('socios')
    .select(`
      id,
      nombres,
      apellidos,
      historial_titularidad (
        puesto_id,
        puestos (
          codigo_puesto
        )
      )
    `)
    .is('deleted_at', null);

  if (sErr) {
    console.error("Error al cargar socios de Supabase:", sErr);
    process.exit(1);
  }

  // Mapear socios con puesto activo
  const sociosBD = databaseSocios.map(s => {
    const activeTit = s.historial_titularidad ? s.historial_titularidad.find(ht => !ht.fecha_fin) : null;
    const puestoId = activeTit ? activeTit.puesto_id : null;
    const codigoPuesto = activeTit && activeTit.puestos ? activeTit.puestos.codigo_puesto : null;
    const fullName = `${s.apellidos} ${s.nombres}`.trim();
    return {
      id: s.id,
      fullName: fullName,
      puestoId: puestoId,
      codigoPuesto: codigoPuesto
    };
  });

  // 2. Obtener los conceptos activos y mapear a un objeto id por nombre
  const { data: conceptos, error: cErr } = await supabase
    .from('conceptos')
    .select('id, nombre')
    .is('deleted_at', null);

  if (cErr) {
    console.error("Error al cargar conceptos de Supabase:", cErr);
    process.exit(1);
  }

  const conceptIds = {};
  conceptos.forEach(c => {
    conceptIds[c.nombre] = c.id;
  });

  // 3. Abrir Excel
  const rutaExcel = 'migracion_coop/2026/1.DETALLE SOCIO A-C NV 4-11-2025 - SOLO 2026.xlsx';
  if (!fs.existsSync(rutaExcel)) {
    console.error(`No existe el archivo Excel: ${rutaExcel}`);
    process.exit(1);
  }

  const wb = XLSX.readFile(rutaExcel, { cellDates: true });
  console.log(`Abierto Excel. Hojas detectadas: ${wb.SheetNames.length}`);

  const L = [];
  L.push(`-- =============================================================================`);
  L.push(`-- Migración 00048 — Carga de Pagos Detallados 2026 (Lista Socios A-C)`);
  L.push(`-- Cooperativa Primero de Mayo · SistemaCooperativa`);
  L.push(`-- Generado: ${new Date().toISOString().slice(0, 10)}`);
  L.push(`-- =============================================================================`);
  L.push(``);
  L.push(`DO $$`);
  L.push(`DECLARE`);
  L.push(`    v_user_uuid         uuid;`);
  L.push(`    v_pago_res          json;`);
  L.push(`    v_pago_id           bigint;`);
  L.push(`    v_monto_id          bigint;`);
  L.push(`    v_cant_pagos        integer := 0;`);
  L.push(`    v_cant_deudas       integer := 0;`);
  L.push(`BEGIN`);
  L.push(`    -- 1. Obtener un UUID de usuario administrador para auditoría`);
  L.push(`    SELECT id INTO v_user_uuid FROM public.perfiles WHERE rol = 'Administrador' AND activo = true LIMIT 1;`);
  L.push(`    IF v_user_uuid IS NULL THEN`);
  L.push(`        v_user_uuid := '00000000-0000-0000-0000-000000000000';`);
  L.push(`    END IF;`);
  L.push(``);
  L.push(`    -- Simular sesión de Supabase/JWT para pasar validaciones get_my_rol()`);
  L.push(`    PERFORM set_config('request.jwt.claims', json_build_object('sub', v_user_uuid::text, 'role', 'authenticated')::text, true);`);
  L.push(``);

  let matchCount = 0;
  let failCount = 0;

  wb.SheetNames.forEach((sheetName, i) => {
    // Buscar el socio correspondiente en BD
    let bestMatch = null;
    let bestScore = 0.70; // Umbral de coincidencia mínimo (ajustado de 0.75 a 0.70)

    sociosBD.forEach(s => {
      const score = getSimilarity(sheetName, s.fullName);
      if (score > bestScore) {
        bestScore = score;
        bestMatch = s;
      }
    });

    if (!bestMatch) {
      console.warn(`⚠️ No se encontró coincidencia para la hoja [${i}]: "${sheetName}"`);
      failCount++;
      return;
    }

    matchCount++;
    console.log(`✅ Hoja "${sheetName}" emparejada con BD: "${bestMatch.fullName}" (Puesto: ${bestMatch.codigoPuesto}, ID: ${bestMatch.id}, Score: ${bestScore.toFixed(2)})`);

    const ws = wb.Sheets[sheetName];
    const rows = XLSX.utils.sheet_to_json(ws, { header: 1, defval: '' });

    // Filtrar filas vacías o sin fecha
    const txs = [];
    rows.forEach(r => {
      if (r.length < 6 || !r[0]) return;
      const fecha = r[0] instanceof Date ? r[0] : new Date(r[0]);
      if (isNaN(fecha.getTime())) return;

      const comprobante = String(r[1] || '').trim();
      const periodo = String(r[2] || '').trim().toUpperCase();
      const conceptoRaw = String(r[3] || '').trim();
      const monto = parseFloat(r[5]);

      if (isNaN(monto) || monto <= 0) return;

      txs.push({
        fecha,
        comprobante,
        periodo,
        conceptoRaw,
        monto
      });
    });

    if (txs.length === 0) {
      console.log(`  (Hoja vacía o sin transacciones de pago válidas)`);
      return;
    }

    // Resolver conceptos y periodos antes de agrupar cargos
    txs.forEach(tx => {
      let normalizedConcept = CONCEPTOS_BD[tx.conceptoRaw.toUpperCase().trim()] || 'Otros';
      if (tx.conceptoRaw.toUpperCase().trim() === 'G. ADM' && tx.monto === 5.00) {
        normalizedConcept = 'Previsión social';
      }
      tx.conceptoId = conceptIds[normalizedConcept] || 18; // 18 = Otros
      
      tx.anio = 2026;
      if (tx.periodo === 'NOVIEMBRE' || tx.periodo === 'DICIEMBRE' || tx.periodo === 'NOV' || tx.periodo === 'DIC') {
        tx.anio = 2025;
      }
      tx.mes = MESES[tx.periodo] || 1;
    });

    // Agrupar para generar cargos únicos por puesto + concepto + periodo (anio/mes)
    const chargesMap = {};
    const uniqueCharges = [];
    
    txs.forEach(tx => {
      const key = `${tx.conceptoId}_${tx.anio}_${tx.mes}`;
      if (!chargesMap[key]) {
        chargesMap[key] = {
          conceptoId: tx.conceptoId,
          anio: tx.anio,
          mes: tx.mes,
          monto: 0,
          idx: uniqueCharges.length,
          conceptoRaw: tx.conceptoRaw
        };
        uniqueCharges.push(chargesMap[key]);
      }
      chargesMap[key].monto += tx.monto;
      tx.chargeIdx = chargesMap[key].idx;
    });

    const vSocioVar = `v_socio_${bestMatch.id}`;
    const vPuestoVar = `v_puesto_${bestMatch.id}`;

    L.push(`    -- =========================================================================`);
    L.push(`    -- SOCIO: ${bestMatch.fullName} (Puesto: ${bestMatch.codigoPuesto}, ID: ${bestMatch.id})`);
    L.push(`    -- =========================================================================`);
    L.push(`    DECLARE`);
    L.push(`        ${vSocioVar} bigint := ${bestMatch.id};`);
    L.push(`        ${vPuestoVar} bigint := ${bestMatch.puestoId ? bestMatch.puestoId : 'NULL'};`);
    
    // Declarar variables para cada monto_id de las deudas únicas
    uniqueCharges.forEach((c, idx) => {
      L.push(`        v_m_id_${bestMatch.id}_${idx} bigint;`);
    });

    L.push(`    BEGIN`);
    if (!bestMatch.puestoId) {
      L.push(`        -- ERROR: Este socio no tiene puesto asignado en la base de datos.`);
      L.push(`        RAISE WARNING 'Socio % (ID %) no tiene puesto activo asignado. Saltando...', ${JSON.stringify(bestMatch.fullName)}, ${bestMatch.id};`);
      L.push(`    END;`);
      return;
    }

    // 1. Quitar el saldo inicial 2025 y limpiar deudas/pagos previos para idempotencia
    L.push(`        -- 1. Eliminar saldo inicial anterior y limpiar deudas/pagos 2026 de este puesto para evitar duplicidades`);
    L.push(`        UPDATE public.montos_por_cobrar SET deleted_at = now(), anulado_por = v_user_uuid, motivo_anulacion = 'Remoción por carga de pagos detallados 2026' WHERE puesto_id = ${vPuestoVar} AND concepto_id = 32 AND deleted_at IS NULL;`);
    L.push(`        DELETE FROM public.detalle_pagos WHERE monto_id IN (SELECT id FROM public.montos_por_cobrar WHERE puesto_id = ${vPuestoVar} AND periodo_anio >= 2025);`);
    L.push(`        DELETE FROM public.pagos WHERE puesto_id = ${vPuestoVar};`);
    L.push(`        DELETE FROM public.montos_por_cobrar WHERE puesto_id = ${vPuestoVar} AND periodo_anio >= 2025;`);
    L.push(`        UPDATE public.socios SET saldo_a_favor = 0.00 WHERE id = ${vSocioVar};`);
    L.push(``);

    // 2. Generar cargos agrupados únicos en BD
    L.push(`        -- 2. Generar deudas agrupadas únicas`);
    uniqueCharges.forEach((c, idx) => {
      const fechaGenStr = `${c.anio}-${String(c.mes).padStart(2, '0')}-01`;
      L.push(`        INSERT INTO public.montos_por_cobrar (puesto_id, concepto_id, periodo_anio, periodo_mes, monto, estado, metodo_calculo, fecha_generacion, observacion, created_by)`);
      L.push(`        VALUES (${vPuestoVar}, ${c.conceptoId}, ${c.anio}, ${c.mes}, ${c.monto.toFixed(2)}, 'Pendiente', 'Manual', '${fechaGenStr}', 'Migración de pagos 2026 - ${c.conceptoRaw}', v_user_uuid)`);
      L.push(`        RETURNING id INTO v_m_id_${bestMatch.id}_${idx};`);
      L.push(`        v_cant_deudas := v_cant_deudas + 1;`);
    });
    L.push(``);

    // 3. Registrar pagos agrupados y aplicar a las deudas correspondientes
    L.push(`        -- 3. Registrar pagos agrupados y aplicar a las deudas correspondientes`);
    
    // Agrupar transacciones por fecha y comprobante
    const groups = {};
    txs.forEach((tx, idx) => {
      const fechaStr = tx.fecha.toISOString().split('T')[0];
      const key = `${fechaStr}||${tx.comprobante}`;
      if (!groups[key]) {
        groups[key] = [];
      }
      groups[key].push({ tx, idx });
    });

    // Estructuras para llevar el conteo acumulado de pagos sobre cada cargo único
    // y determinar si el pago actual cubre la deuda completa
    const runningPaymentSum = {}; // key: chargeIdx -> running sum

    Object.entries(groups).forEach(([groupKey, list]) => {
      const [fechaStr, comprobante] = groupKey.split('||');
      const totalPago = list.reduce((sum, item) => sum + item.tx.monto, 0);
      const isTarjeta = comprobante.startsWith('TARJETA');
      const metodo = isTarjeta ? 'Transferencia' : 'Efectivo';
      const observacion = isTarjeta ? `Pago mensual vía tarjeta - ${comprobante}` : `Pago histórico recibo N° ${comprobante}`;

      // Crear array de distribuciones jsonb para la RPC
      const distArray = list.map(item => {
        const cIdx = item.tx.chargeIdx;
        const totalDeuda = uniqueCharges[cIdx].monto;
        
        runningPaymentSum[cIdx] = (runningPaymentSum[cIdx] || 0) + item.tx.monto;
        const reachedTotal = Math.abs(runningPaymentSum[cIdx] - totalDeuda) < 0.01;

        return `jsonb_build_object('monto_id', v_m_id_${bestMatch.id}_${cIdx}, 'monto_aplicado', ${item.tx.monto.toFixed(2)}, 'cubierto_completo', ${reachedTotal})`;
      }).join(', ');

      L.push(`        v_pago_res := public.rpc_procesar_pago(`);
      L.push(`            ${vPuestoVar},`);
      L.push(`            ${vSocioVar},`);
      L.push(`            NULL,`);
      L.push(`            ${totalPago.toFixed(2)},`);
      L.push(`            '${metodo}',`);
      L.push(`            '${comprobante}',`);
      L.push(`            '${observacion}',`);
      L.push(`            v_user_uuid,`);
      L.push(`            jsonb_build_array(${distArray}),`);
      L.push(`            0.00,`);
      L.push(`            '${fechaStr} 12:00:00-05'`);
      L.push(`        );`);
      L.push(`        v_pago_id := (v_pago_res->>'pago_id')::bigint;`);
      
      // Ajustar fechas del pago y sus aplicaciones retrospectivamente para que correspondan al Excel
      L.push(`        UPDATE public.pagos SET fecha_pago = '${fechaStr} 12:00:00-05', created_at = '${fechaStr} 12:00:00-05' WHERE id = v_pago_id;`);
      L.push(`        UPDATE public.detalle_pagos SET fecha_aplicacion = '${fechaStr} 12:00:00-05', created_at = '${fechaStr} 12:00:00-05' WHERE pago_id = v_pago_id;`);
      L.push(`        v_cant_pagos := v_cant_pagos + 1;`);
      L.push(``);
    });

    L.push(`    END;`);
    L.push(``);
  });

  L.push(`    RAISE NOTICE '==================================================';`);
  L.push(`    RAISE NOTICE 'PROCESO DE MIGRACIÓN 2026 COMPLETADO CON ÉXITO';`);
  L.push(`    RAISE NOTICE '  Deudas individuales creadas: %', v_cant_deudas;`);
  L.push(`    RAISE NOTICE '  Pagos agrupados procesados:  %', v_cant_pagos;`);
  L.push(`    RAISE NOTICE '==================================================';`);
  L.push(`END $$;`);

  const sqlContent = L.join('\n');
  const pathSql = 'supabase/migrations/00048_migracion_pagos_socios_A_C_2026.sql';
  
  fs.writeFileSync(pathSql, sqlContent, 'utf8');
  console.log(`\n==================================================`);
  console.log(` MIGRACIÓN GENERADA EXITOSAMENTE`);
  console.log(`  Archivo: ${pathSql}`);
  console.log(`  Hojas emparejadas con éxito: ${matchCount} / ${wb.SheetNames.length}`);
  console.log(`  Hojas no emparejadas: ${failCount}`);
  console.log(`==================================================\n`);
}

main().catch(console.error);
