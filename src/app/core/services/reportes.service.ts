import { inject, Injectable } from '@angular/core';
import { AuthService } from './auth.service';
import { SUPABASE_CLIENT } from './supabase.client';

// ---------------------------------------------------------------------------
// Tipos públicos del arqueo
// ---------------------------------------------------------------------------
export type OrigenIngreso = 'SOCIOS' | 'INQUILINOS' | 'OTROS' | 'PENDIENTES';

export interface ArqueoPago {
  id: number;
  codigo_transaccion: string;
  fecha_pago: string;             // ISO timestamptz
  monto_total: number;
  metodo_pago: 'Efectivo' | 'Transferencia';
  comprobante: string | null;
  codigo_puesto: string;
  pagador: string;                // apellidos, nombres / o label de ingreso interno
  cajero_nombre: string;          // nombres del usuario que registró
  conceptos: string[];            // lista de conceptos únicos
  anulado: boolean;
  motivo_anulacion: string | null;
  es_ingreso_interno: boolean;    // true → fila de ingresos_internos (sin recibo)
  es_recaudacion_tarjeta: boolean; // true → abono semanal de recaudación tarjeta
  origen: OrigenIngreso;
  socio_id?: number | null;
  inquilino_id?: number | null;
}

export interface ArqueoConcepto {
  concepto: string;
  monto: number;
  cantidad: number;
}

export interface SubgrupoMetodo {
  metodo: 'Efectivo' | 'Transferencia';
  recibos: ArqueoPago[];
  cantidad: number;
  subtotal: number;
}

export interface BloqueIngresos {
  origen: OrigenIngreso;
  titulo: string;
  subgrupoEfectivo: SubgrupoMetodo;
  subgrupoTransferencia: SubgrupoMetodo;
  totalEfectivo: number;
  totalTransferencia: number;
  totalGeneral: number;
  cantidadTotal: number;
}

export interface ResumenConsolidadoMatriz {
  sociosEfectivo: number;
  sociosTransferencia: number;
  sociosTotal: number;

  inquilinosEfectivo: number;
  inquilinosTransferencia: number;
  inquilinosTotal: number;

  otrosEfectivo: number;
  otrosTransferencia: number;
  otrosTotal: number;

  pendientesEfectivo?: number;
  pendientesTransferencia?: number;
  pendientesTotal?: number;

  totalEfectivo: number;
  totalTransferencia: number;
  totalGeneral: number;
}

export interface GastoArqueoRow {
  id: number;
  fecha: string;                  // YYYY-MM-DD (columna date)
  monto: number;
  descripcion: string | null;
  comprobante_ref: string | null;
  responsable: string | null;
  categoria_nombre: string;
}

export interface CajaApertura {
  id: number;
  fecha: string;
  monto_inicial: number;
  user_id: string | null;
}

export interface CajaAjuste {
  id: number;
  fecha: string;
  tipo: 'FALTANTE' | 'SOBRANTE';
  monto: number;
  descripcion: string | null;
  user_id: string | null;
}

export interface ArqueoResumen {
  fecha: string;                    // YYYY-MM-DD
  total_dia: number;                // ingresos brutos del día
  total_efectivo: number;           // solo cobros en efectivo
  total_transferencia: number;      // cobros por transferencia/QR (no entran al físico)
  cantidad_recibos: number;
  cantidad_ingresos_internos: number;
  cantidad_recaudacion_tarjeta: number;
  cantidad_anulados: number;
  por_concepto: ArqueoConcepto[];
  recibos: ArqueoPago[];            // SOLO recibos válidos (deleted_at IS NULL)
  recibos_anulados: ArqueoPago[];   // recibos anulados excluidos del arqueo
  bloqueSocios: BloqueIngresos;
  bloqueInquilinos: BloqueIngresos;
  bloqueOtros: BloqueIngresos;
  bloquePendientes: BloqueIngresos | null;
  matrizConsolidada: ResumenConsolidadoMatriz;
  total_gastos: number;             // egresos del día (salen de caja física)
  saldo_neto: number;               // total_dia - total_gastos (contable total)
  gastos: GastoArqueoRow[];
  // ── Caja física ─────────────────────────────────────────────────────────
  apertura_monto: number;           // saldo inicial del día (0 si no registrado)
  apertura: CajaApertura | null;    // fila completa de caja_aperturas
  total_faltantes: number;          // suma de ajustes tipo FALTANTE
  total_sobrantes: number;          // suma de ajustes tipo SOBRANTE
  efectivo_fisico_caja: number;     // apertura + efectivo - gastos - faltantes + sobrantes
  ajustes: CajaAjuste[];
}

// ---------------------------------------------------------------------------
// Tipos internos (raw Supabase rows)
// ---------------------------------------------------------------------------
interface PagoArqueoRow {
  id: number;
  codigo_transaccion: string;
  fecha_pago: string;
  monto_total: number;
  metodo_pago: string;
  comprobante: string | null;
  created_by: string | null;
  deleted_at: string | null;
  motivo_anulacion: string | null;
  socio_id: number | null;
  inquilino_id: number | null;
  puesto: { codigo_puesto: string } | null;
  socio: { apellidos: string; nombres: string } | null;
  inquilino: { apellidos: string; nombres: string } | null;
  detalle: Array<{
    monto_aplicado: number;
    deleted_at: string | null;
    monto_cobrar: { concepto: { nombre: string } | null } | null;
  }>;
}

interface IngresoInternoArqueoRow {
  id: number;
  monto: number;
  metodo_pago: string;
  fecha_ingreso: string;
  observacion: string | null;
  created_by: string | null;
  concepto: { nombre: string; grupo: string } | null;
}

interface GastoArqueoRawRow {
  id: number;
  fecha: string;
  monto: number;
  descripcion: string | null;
  comprobante_ref: string | null;
  responsable: string | null;
  created_by: string | null;
  categoria: { nombre: string } | null;
}

interface PerfilResumen {
  id: string;
  nombres: string | null;
  email: string;
}

interface RecaudacionAbonoArqueoRow {
  id: number;
  monto: number;
  fecha: string;
  deleted_at: string | null;
  socio: { apellidos: string; nombres: string } | null;
}

// ---------------------------------------------------------------------------
// Tipos del Reporte Consolidado (v2 — RPC server-side, 00085)
// ---------------------------------------------------------------------------
export type RangoReporte = 'hoy' | 'semana' | 'mes' | 'año';
export type RangoRapido = 'hoy' | 'ayer' | 'semana' | 'mes' | 'mes_anterior' | 'año' | 'historico';
export type ModoFiltroPeriodo = 'rapido' | 'mes_anio' | 'personalizado';
export type TipoPagadorFiltro = 'todos' | 'socios' | 'inquilinos';
export type OrigenFiltroUI = 'todos' | 'socios' | 'inquilinos' | 'otros';

export interface FiltroPeriodoReporte {
  modo: ModoFiltroPeriodo;
  rangoRapido?: RangoRapido;
  mes?: number; // 1 - 12
  anio?: number; // ej. 2026
  fechaDesde?: string; // YYYY-MM-DD
  fechaHasta?: string; // YYYY-MM-DD
}

export interface PeriodoResuelto {
  desde: string;
  hasta: string;
  etiqueta: string;
}

export interface ConceptoResumen {
  concepto: string;
  monto: number;
  cantidad: number;
  monto_socios: number;
  monto_inquilinos: number;
}

export interface EgresoCategoria {
  categoria: string;
  monto: number;
  cantidad: number;
}

export interface ReporteResumenV2 {
  rango: RangoReporte;
  fechaDesde: string;       // YYYY-MM-DD
  fechaHasta: string;       // YYYY-MM-DD
  tipoPagador: TipoPagadorFiltro;
  caja: {
    efectivo: number;
    transferencia: number;
    ingresos_internos: number;
    recaudacion_tarjeta: number;
    egresos: number;
    saldo: number;
    count_recibos: number;
    count_internos: number;
    count_recaudacion: number;
    count_anulados: number;
  };
  banco: {
    ingresos: number;
    egresos: number;
    saldo: number;
    count: number;
  };
  por_concepto: ConceptoResumen[];
  egresos_por_categoria: EgresoCategoria[];
}

export interface DetalleIngresoLinea {
  fecha_pago: string;
  codigo_transaccion: string;
  concepto: string;
  pagador: string;
  tipo_pagador: 'socio' | 'inquilino' | 'interno';
  codigo_puesto: string;
  periodo: string;
  monto: number;
  metodo_pago: string;
  cajero: string;
}

export interface DetalleEgresoLinea {
  id: number;
  fecha: string;
  categoria: string;
  descripcion: string | null;
  comprobante_ref: string | null;
  responsable: string | null;
  monto: number;
}

// ---------------------------------------------------------------------------
// Helpers de fecha (usa la zona horaria del browser → correcta para Lima)
// ---------------------------------------------------------------------------
function pad2(n: number): string { return String(n).padStart(2, '0'); }

function fechaLocal(d: Date): string {
  return `${d.getFullYear()}-${pad2(d.getMonth() + 1)}-${pad2(d.getDate())}`;
}

export function getFechaHoyLima(): string {
  const formatter = new Intl.DateTimeFormat('en-CA', {
    timeZone: 'America/Lima',
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
  });
  return formatter.format(new Date()); // YYYY-MM-DD
}

export function getNombreMes(m: number): string {
  const meses = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'];
  return meses[m - 1] || '';
}

export interface PeriodoAnteriorResultado {
  desde: string;
  hasta: string;
  etiqueta: string;
  dias: number;
}

export function calcularPeriodoAnterior(desde: string, hasta: string): PeriodoAnteriorResultado {
  const [y1, m1, d1] = desde.split('-').map(Number);
  const [y2, m2, d2] = hasta.split('-').map(Number);
  const dt1 = new Date(y1, m1 - 1, d1);
  const dt2 = new Date(y2, m2 - 1, d2);

  // Si es un mes calendario completo (primer día a último día del mes)
  const primerDiaMes = new Date(y1, m1 - 1, 1);
  const ultimoDiaMes = new Date(y1, m1, 0);
  if (dt1.getDate() === primerDiaMes.getDate() && dt2.getDate() === ultimoDiaMes.getDate() && m1 === m2 && y1 === y2) {
    const antY = m1 === 1 ? y1 - 1 : y1;
    const antM = m1 === 1 ? 12 : m1 - 1;
    const antUltimo = new Date(antY, antM, 0).getDate();
    const mm = pad2(antM);
    return {
      desde: `${antY}-${mm}-01`,
      hasta: `${antY}-${mm}-${pad2(antUltimo)}`,
      etiqueta: `${getNombreMes(antM)} ${antY}`,
      dias: antUltimo,
    };
  }

  // Si es un año completo
  if (m1 === 1 && d1 === 1 && m2 === 12 && d2 === 31 && y1 === y2) {
    const antY = y1 - 1;
    return {
      desde: `${antY}-01-01`,
      hasta: `${antY}-12-31`,
      etiqueta: `Año ${antY}`,
      dias: 365,
    };
  }

  // Rango arbitrario de N días: período anterior de igual duración que termina el día antes de desde
  const diffMs = dt2.getTime() - dt1.getTime();
  const numDias = Math.max(1, Math.round(diffMs / (1000 * 60 * 60 * 24)) + 1);
  const antFin = new Date(dt1.getTime() - 24 * 60 * 60 * 1000);
  const antIni = new Date(antFin.getTime() - (numDias - 1) * 24 * 60 * 60 * 1000);

  return {
    desde: `${antIni.getFullYear()}-${pad2(antIni.getMonth() + 1)}-${pad2(antIni.getDate())}`,
    hasta: `${antFin.getFullYear()}-${pad2(antFin.getMonth() + 1)}-${pad2(antFin.getDate())}`,
    etiqueta: `Período anterior equivalente (${numDias} días)`,
    dias: numDias,
  };
}

export function resolverPeriodoReporte(filtro: FiltroPeriodoReporte): PeriodoResuelto {
  const hoyLima = getFechaHoyLima();
  const [yStr, mStr, dStr] = hoyLima.split('-');
  const y = parseInt(yStr, 10);
  const m = parseInt(mStr, 10);
  const d = parseInt(dStr, 10);

  if (filtro.modo === 'mes_anio') {
    const selY = filtro.anio ?? y;
    const selM = filtro.mes ?? m;
    const ultimoDia = new Date(selY, selM, 0).getDate();
    const mm = pad2(selM);
    return {
      desde: `${selY}-${mm}-01`,
      hasta: `${selY}-${mm}-${pad2(ultimoDia)}`,
      etiqueta: `${getNombreMes(selM)} ${selY}`,
    };
  }

  if (filtro.modo === 'personalizado') {
    const dVal = filtro.fechaDesde || hoyLima;
    const hVal = filtro.fechaHasta || hoyLima;
    return {
      desde: dVal,
      hasta: hVal,
      etiqueta: dVal === hVal ? dVal : `${dVal} al ${hVal}`,
    };
  }

  // modo === 'rapido'
  switch (filtro.rangoRapido) {
    case 'hoy':
      return { desde: hoyLima, hasta: hoyLima, etiqueta: `Hoy (${hoyLima})` };
    case 'ayer': {
      const ayer = new Date(y, m - 1, d - 1);
      const ayerStr = `${ayer.getFullYear()}-${pad2(ayer.getMonth() + 1)}-${pad2(ayer.getDate())}`;
      return { desde: ayerStr, hasta: ayerStr, etiqueta: `Ayer (${ayerStr})` };
    }
    case 'semana': {
      const sem = new Date(y, m - 1, d - 6);
      const semStr = `${sem.getFullYear()}-${pad2(sem.getMonth() + 1)}-${pad2(sem.getDate())}`;
      return { desde: semStr, hasta: hoyLima, etiqueta: 'Últimos 7 días' };
    }
    case 'mes': {
      const ultimoDiaMes = new Date(y, m, 0).getDate();
      const mm = pad2(m);
      return { desde: `${y}-${mm}-01`, hasta: `${y}-${mm}-${pad2(ultimoDiaMes)}`, etiqueta: `Este Mes (${getNombreMes(m)} ${y})` };
    }
    case 'mes_anterior': {
      const ant = new Date(y, m - 2, 1);
      const antY = ant.getFullYear();
      const antM = ant.getMonth() + 1;
      const ultimoDiaAnt = new Date(antY, antM, 0).getDate();
      const mm = pad2(antM);
      return {
        desde: `${antY}-${mm}-01`,
        hasta: `${antY}-${mm}-${pad2(ultimoDiaAnt)}`,
        etiqueta: `Mes Anterior (${getNombreMes(antM)} ${antY})`,
      };
    }
    case 'año': {
      return { desde: `${y}-01-01`, hasta: `${y}-12-31`, etiqueta: `Este Año (${y})` };
    }
    case 'historico': {
      return { desde: '2026-01-01', hasta: hoyLima, etiqueta: 'Histórico Completo' };
    }
    default:
      return { desde: hoyLima, hasta: hoyLima, etiqueta: hoyLima };
  }
}

function calcularRango(rango: RangoReporte): {
  desde: string; hasta: string; desdeISO: string; hastaISO: string;
} {
  const hoy = new Date();
  const [y, m, d] = [hoy.getFullYear(), hoy.getMonth(), hoy.getDate()];
  let inicio = new Date(y, m, d);
  switch (rango) {
    case 'hoy':    inicio = new Date(y, m, d);     break;
    case 'semana': inicio = new Date(y, m, d - 6); break;
    case 'mes':    inicio = new Date(y, m, 1);     break;
    case 'año':    inicio = new Date(y, 0, 1);     break;
  }
  const fin = new Date(y, m, d, 23, 59, 59, 999);
  return {
    desde:    fechaLocal(inicio),  // YYYY-MM-DD local → correcto para columnas date
    hasta:    fechaLocal(fin),     // YYYY-MM-DD local → no salta al día siguiente
    desdeISO: inicio.toISOString(),
    hastaISO: fin.toISOString(),
  };
}

function isoInicioDia(fecha: string): string {
  const [y, m, d] = fecha.split('-').map(Number);
  return new Date(y, m - 1, d, 0, 0, 0, 0).toISOString();
}

function isoFinDia(fecha: string): string {
  const [y, m, d] = fecha.split('-').map(Number);
  return new Date(y, m - 1, d, 23, 59, 59, 999).toISOString();
}

function round2(n: number): number {
  return Math.round(n * 100) / 100;
}

// ---------------------------------------------------------------------------
// Servicio
// ---------------------------------------------------------------------------
@Injectable({ providedIn: 'root' })
export class ReportesService {
  private readonly db   = inject(SUPABASE_CLIENT);
  private readonly auth = inject(AuthService);

  /**
   * Carga pagos, ingresos internos y gastos del día indicado.
   * Los pagos anulados se incluyen en la lista pero NO en los totales.
   * Los gastos se deducen del total para calcular el saldo neto en caja.
   */
  async cargarArqueo(
    fecha: string,
    soloMiCajero: boolean,
  ): Promise<ArqueoResumen> {
    const inicio = isoInicioDia(fecha);
    const fin    = isoFinDia(fecha);

    let userId: string | null = null;
    if (soloMiCajero) {
      userId = this.auth.usuario()?.id ?? (await this.db.auth.getUser()).data.user?.id ?? null;
    }

    // ── Construir queries en paralelo ────────────────────────────────────────
    let pagosQuery = this.db
      .from('pagos')
      .select(`
        id, codigo_transaccion, fecha_pago, monto_total, metodo_pago, comprobante, created_by,
        deleted_at, motivo_anulacion, socio_id, inquilino_id,
        puesto:puestos(codigo_puesto),
        socio:socios(apellidos, nombres),
        inquilino:inquilinos(apellidos, nombres),
        detalle:detalle_pagos(
          monto_aplicado, deleted_at,
          monto_cobrar:montos_por_cobrar(
            concepto:conceptos(nombre)
          )
        )
      `)
      .gte('fecha_pago', inicio)
      .lte('fecha_pago', fin)
      .order('fecha_pago', { ascending: false });

    let iiQuery = this.db
      .from('ingresos_internos')
      .select(`
        id, monto, metodo_pago, fecha_ingreso, observacion, created_by,
        concepto:conceptos(nombre, grupo)
      `)
      .is('deleted_at', null)
      .gte('fecha_ingreso', inicio)
      .lte('fecha_ingreso', fin)
      .order('fecha_ingreso', { ascending: false });

    // gastos.fecha es de tipo DATE → compara directamente con la cadena YYYY-MM-DD
    let gastosQuery = this.db
      .from('gastos')
      .select('id, fecha, monto, descripcion, comprobante_ref, responsable, created_by, categoria:categorias_gasto(nombre)')
      .is('deleted_at', null)
      .gte('fecha', fecha)
      .lte('fecha', fecha)
      .order('fecha', { ascending: true });

    // recaudacion_abonos: abonos semanales por tarjeta → suma a total_efectivo del día
    // NO se filtra por cajero (es una operación masiva, no individual de caja)
    const recaudacionQuery = this.db
      .from('recaudacion_abonos')
      .select(`id, monto, fecha, deleted_at, socio:socios(apellidos, nombres)`)
      .is('deleted_at', null)
      .gte('fecha', inicio)
      .lte('fecha', fin)
      .order('fecha', { ascending: false });

    if (userId) {
      pagosQuery  = pagosQuery.eq('created_by', userId);
      iiQuery     = iiQuery.eq('created_by', userId);
      // gastos y recaudacion_abonos: NO se filtran por cajero — el cuadre de caja
      // debe reflejar todos los ingresos del día, independientemente del operador.
    }

    const aperturaQuery = this.db
      .from('caja_aperturas')
      .select('id, fecha, monto_inicial, user_id')
      .eq('fecha', fecha)
      .maybeSingle();

    const ajustesQuery = this.db
      .from('caja_ajustes')
      .select('id, fecha, tipo, monto, descripcion, user_id')
      .eq('fecha', fecha)
      .order('created_at');

    const [pagosRes, iiRes, gastosRes, recaudacionRes, aperturaRes, ajustesRes] = await Promise.all([
      pagosQuery, iiQuery, gastosQuery, recaudacionQuery, aperturaQuery, ajustesQuery,
    ]);
    if (pagosRes.error)       throw new Error(pagosRes.error.message);
    if (iiRes.error)          throw new Error(iiRes.error.message);
    if (gastosRes.error)      throw new Error(gastosRes.error.message);
    if (recaudacionRes.error) throw new Error(recaudacionRes.error.message);
    // apertura y ajustes son opcionales: si fallan no bloquean el arqueo
    const aperturaRow = aperturaRes.error ? null : (aperturaRes.data as CajaApertura | null);
    const ajustesRows = ajustesRes.error  ? []   : (ajustesRes.data  as CajaAjuste[]);

    const rows         = (pagosRes.data       ?? []) as unknown as PagoArqueoRow[];
    const ingresos     = (iiRes.data          ?? []) as unknown as IngresoInternoArqueoRow[];
    const gastosRaw    = (gastosRes.data      ?? []) as unknown as GastoArqueoRawRow[];
    const recaudaciones = (recaudacionRes.data ?? []) as unknown as RecaudacionAbonoArqueoRow[];

    // ── Batch de perfiles para nombres de cajeros ────────────────────────────
    const idsSet = new Set<string>();
    rows.forEach(r => { if (r.created_by) idsSet.add(r.created_by); });
    ingresos.forEach(r => { if (r.created_by) idsSet.add(r.created_by); });

    const perfilMap = new Map<string, PerfilResumen>();
    if (idsSet.size > 0) {
      const { data: perfiles } = await this.db
        .from('perfiles')
        .select('id, nombres, email')
        .in('id', [...idsSet]);
      for (const p of (perfiles ?? []) as PerfilResumen[]) {
        perfilMap.set(p.id, p);
      }
    }

    return this.construirResumen(fecha, rows, ingresos, perfilMap, gastosRaw, recaudaciones, aperturaRow, ajustesRows);
  }

  // ── Construcción del resumen ──────────────────────────────────────────────
  private construirResumen(
    fecha: string,
    rows: PagoArqueoRow[],
    ingresos: IngresoInternoArqueoRow[],
    perfilMap: Map<string, PerfilResumen>,
    gastosRaw: GastoArqueoRawRow[],
    recaudaciones: RecaudacionAbonoArqueoRow[] = [],
    apertura: CajaApertura | null = null,
    ajustes: CajaAjuste[] = [],
  ): ArqueoResumen {
    let totalEfectivo = 0;
    let totalTransferencia = 0;
    const conceptoMap = new Map<string, { monto: number; cantidad: number }>();

    // ── Pagos tradicionales (Socios e Inquilinos con recibo) ─────────────────
    // Los recibos con monto_total === 0 (aplicación 100 % de saldo a favor) no
    // representan ingreso de dinero nuevo en caja (el dinero ya ingresó cuando
    // se registró el abono de tarjeta o excedente previo), por lo que se excluyen
    // del arqueo de caja diario para no mostrar filas de S/ 0.00 ni duplicar conceptos.
    const rowsConIngresoCaja = rows.filter(row => Number(row.monto_total) > 0);
    const recibos: ArqueoPago[] = rowsConIngresoCaja.map(row => {
      const monto     = Number(row.monto_total);
      const esAnulado = row.deleted_at !== null;

      if (!esAnulado) {
        if (row.metodo_pago === 'Efectivo') totalEfectivo += monto;
        else totalTransferencia += monto;
      }

      const detalleVisible = (row.detalle ?? []).filter(
        d => (esAnulado || d.deleted_at === null) && d.monto_cobrar?.concepto?.nombre,
      );
      const conceptosUnicos = [
        ...new Set(detalleVisible.map(d => d.monto_cobrar!.concepto!.nombre)),
      ];

      if (!esAnulado) {
        const sumaDetalle = detalleVisible.reduce((s, d) => s + Number(d.monto_aplicado), 0);
        // En pagos mixtos (monto_total < sumaDetalle), prorratear al ingreso real en caja del día
        const factorCaja = sumaDetalle > monto && sumaDetalle > 0 ? monto / sumaDetalle : 1;
        for (const d of detalleVisible) {
          const nombre = d.monto_cobrar!.concepto!.nombre;
          const prev = conceptoMap.get(nombre) ?? { monto: 0, cantidad: 0 };
          conceptoMap.set(nombre, {
            monto:    prev.monto + Number(d.monto_aplicado) * factorCaja,
            cantidad: prev.cantidad + 1,
          });
        }
      }

      const pagador = row.socio
        ? `${row.socio.apellidos}, ${row.socio.nombres}`
        : row.inquilino
          ? `${row.inquilino.apellidos}, ${row.inquilino.nombres}`
          : '—';

      let origen: OrigenIngreso = 'PENDIENTES';
      if (row.socio_id !== null || row.socio) {
        origen = 'SOCIOS';
      } else if (row.inquilino_id !== null || row.inquilino) {
        origen = 'INQUILINOS';
      }

      const perfil = row.created_by ? perfilMap.get(row.created_by) : null;

      return {
        id: row.id,
        codigo_transaccion: row.codigo_transaccion,
        fecha_pago: row.fecha_pago,
        monto_total: monto,
        metodo_pago: row.metodo_pago as 'Efectivo' | 'Transferencia',
        comprobante: row.comprobante,
        codigo_puesto: row.puesto?.codigo_puesto ?? '—',
        pagador,
        cajero_nombre: perfil?.nombres ?? perfil?.email ?? '—',
        conceptos: conceptosUnicos,
        anulado: esAnulado,
        motivo_anulacion: row.motivo_anulacion,
        es_ingreso_interno: false,
        es_recaudacion_tarjeta: false,
        origen,
        socio_id: row.socio_id,
        inquilino_id: row.inquilino_id,
      };
    });

    // ── Ingresos internos (Caja Rápida / Sin Recibo: SS.HH., Parqueo, etc.) ──
    const filasInternas: ArqueoPago[] = ingresos.map(row => {
      const monto = Number(row.monto);

      if (row.metodo_pago === 'Efectivo') totalEfectivo += monto;
      else totalTransferencia += monto;

      const nombreConcepto = row.concepto?.nombre ?? 'Sin concepto';
      const prev = conceptoMap.get(nombreConcepto) ?? { monto: 0, cantidad: 0 };
      conceptoMap.set(nombreConcepto, {
        monto:    prev.monto + monto,
        cantidad: prev.cantidad + 1,
      });

      const observacion = row.observacion?.trim();
      const pagadorLabel = observacion ? `${nombreConcepto} (${observacion})` : nombreConcepto;

      const perfil = row.created_by ? perfilMap.get(row.created_by) : null;
      const codigoRef = `INT-${String(row.id).padStart(6, '0')}`;

      return {
        id: row.id,
        codigo_transaccion: codigoRef,
        fecha_pago: row.fecha_ingreso,
        monto_total: monto,
        metodo_pago: row.metodo_pago as 'Efectivo' | 'Transferencia',
        comprobante: null,
        codigo_puesto: '—',
        pagador: pagadorLabel,
        cajero_nombre: perfil?.nombres ?? perfil?.email ?? '—',
        conceptos: [nombreConcepto],
        anulado: false,
        motivo_anulacion: null,
        es_ingreso_interno: true,
        es_recaudacion_tarjeta: false,
        origen: 'OTROS' as OrigenIngreso,
      };
    });

    // ── Recaudación por Tarjeta (abonos semanales de socios en efectivo) ──────
    const CONCEPTO_TARJETA = 'Recaudación Tarjeta';
    const filasRecaudacion: ArqueoPago[] = recaudaciones.map(row => {
      const monto = Number(row.monto);
      totalEfectivo += monto;  // prepago físico en efectivo

      const prev = conceptoMap.get(CONCEPTO_TARJETA) ?? { monto: 0, cantidad: 0 };
      conceptoMap.set(CONCEPTO_TARJETA, {
        monto:    prev.monto + monto,
        cantidad: prev.cantidad + 1,
      });

      const pagador = row.socio
        ? `${row.socio.apellidos}, ${row.socio.nombres}`
        : '—';

      return {
        id:                      row.id,
        codigo_transaccion:      `REC-${String(row.id).padStart(6, '0')}`,
        fecha_pago:              row.fecha,
        monto_total:             monto,
        metodo_pago:             'Efectivo' as const,
        comprobante:             null,
        codigo_puesto:           '—',
        pagador,
        cajero_nombre:           '—',
        conceptos:               [CONCEPTO_TARJETA],
        anulado:                 false,
        motivo_anulacion:        null,
        es_ingreso_interno:      false,
        es_recaudacion_tarjeta:  true,
        origen:                  'SOCIOS' as OrigenIngreso,
      };
    });

    // ── Separación de movimientos válidos vs anulados ───────────────────────
    // Los movimientos anulados quedan completamente excluidos del arqueo oficial.
    const recibosAnulados = recibos.filter(r => r.anulado);
    const recibosValidos = recibos.filter(r => !r.anulado);

    // Colección cronológica de recibos válidos del día
    const todosRecibosValidos = [...recibosValidos, ...filasInternas, ...filasRecaudacion].sort(
      (a, b) => new Date(b.fecha_pago).getTime() - new Date(a.fecha_pago).getTime(),
    );

    // ── Agrupación en Bloques por Origen y Método de Pago ───────────────────
    const crearSubgrupo = (recibosList: ArqueoPago[], metodo: 'Efectivo' | 'Transferencia'): SubgrupoMetodo => {
      const items = recibosList.filter(r => r.metodo_pago === metodo);
      const subtotal = round2(items.reduce((s, r) => s + r.monto_total, 0));
      return {
        metodo,
        recibos: items,
        cantidad: items.length,
        subtotal,
      };
    };

    const crearBloque = (origen: OrigenIngreso, titulo: string, recibosList: ArqueoPago[]): BloqueIngresos => {
      const subgrupoEfectivo = crearSubgrupo(recibosList, 'Efectivo');
      const subgrupoTransferencia = crearSubgrupo(recibosList, 'Transferencia');
      const totalEf = subgrupoEfectivo.subtotal;
      const totalTr = subgrupoTransferencia.subtotal;
      const totalGeneral = round2(totalEf + totalTr);
      const cantidadTotal = subgrupoEfectivo.cantidad + subgrupoTransferencia.cantidad;

      return {
        origen,
        titulo,
        subgrupoEfectivo,
        subgrupoTransferencia,
        totalEfectivo: totalEf,
        totalTransferencia: totalTr,
        totalGeneral,
        cantidadTotal,
      };
    };

    const bloqueSocios = crearBloque(
      'SOCIOS',
      'Ingresos de Socios',
      todosRecibosValidos.filter(r => r.origen === 'SOCIOS'),
    );

    const bloqueInquilinos = crearBloque(
      'INQUILINOS',
      'Ingresos de Inquilinos',
      todosRecibosValidos.filter(r => r.origen === 'INQUILINOS'),
    );

    const bloqueOtros = crearBloque(
      'OTROS',
      'Otros Ingresos (Caja Rápida)',
      todosRecibosValidos.filter(r => r.origen === 'OTROS'),
    );

    const recibosPendientes = todosRecibosValidos.filter(r => r.origen === 'PENDIENTES');
    const bloquePendientes = recibosPendientes.length > 0
      ? crearBloque('PENDIENTES', 'Pendientes de Clasificación', recibosPendientes)
      : null;

    // ── Matriz Consolidada de Resumen Ejecutivo (Origen vs Método) ───────────
    const matrizConsolidada: ResumenConsolidadoMatriz = {
      sociosEfectivo: bloqueSocios.totalEfectivo,
      sociosTransferencia: bloqueSocios.totalTransferencia,
      sociosTotal: bloqueSocios.totalGeneral,

      inquilinosEfectivo: bloqueInquilinos.totalEfectivo,
      inquilinosTransferencia: bloqueInquilinos.totalTransferencia,
      inquilinosTotal: bloqueInquilinos.totalGeneral,

      otrosEfectivo: bloqueOtros.totalEfectivo,
      otrosTransferencia: bloqueOtros.totalTransferencia,
      otrosTotal: bloqueOtros.totalGeneral,

      pendientesEfectivo: bloquePendientes?.totalEfectivo ?? 0,
      pendientesTransferencia: bloquePendientes?.totalTransferencia ?? 0,
      pendientesTotal: bloquePendientes?.totalGeneral ?? 0,

      totalEfectivo: round2(totalEfectivo),
      totalTransferencia: round2(totalTransferencia),
      totalGeneral: round2(totalEfectivo + totalTransferencia),
    };

    const por_concepto: ArqueoConcepto[] = [...conceptoMap.entries()]
      .map(([concepto, { monto, cantidad }]) => ({
        concepto,
        monto:    round2(monto),
        cantidad,
      }))
      .sort((a, b) => b.monto - a.monto);

    // ── Gastos / Egresos del día ─────────────────────────────────────────────
    const totalGastos = round2(
      gastosRaw.reduce((s, g) => s + Number(g.monto), 0),
    );

    const gastos: GastoArqueoRow[] = gastosRaw
      .map(g => ({
        id:               g.id,
        fecha:            g.fecha,
        monto:            Number(g.monto),
        descripcion:      g.descripcion,
        comprobante_ref:  g.comprobante_ref,
        responsable:      g.responsable,
        categoria_nombre: g.categoria?.nombre ?? 'Sin categoría',
      }))
      .sort((a, b) => a.fecha.localeCompare(b.fecha));

    const total_dia  = round2(totalEfectivo + totalTransferencia);
    const saldo_neto = round2(total_dia - totalGastos);

    // ── Caja física ──────────────────────────────────────────────────────────
    const apertura_monto   = apertura ? Number(apertura.monto_inicial) : 0;
    const total_faltantes  = round2(ajustes.filter(a => a.tipo === 'FALTANTE').reduce((s, a) => s + Number(a.monto), 0));
    const total_sobrantes  = round2(ajustes.filter(a => a.tipo === 'SOBRANTE').reduce((s, a) => s + Number(a.monto), 0));
    // Efectivo físico real = lo que debería haber en la gaveta al cierre:
    // Apertura + Cobros en efectivo − Gastos pagados en efectivo − Faltantes + Sobrantes
    const efectivo_fisico_caja = round2(apertura_monto + totalEfectivo - totalGastos - total_faltantes + total_sobrantes);

    return {
      fecha,
      total_dia,
      total_efectivo:                round2(totalEfectivo),
      total_transferencia:           round2(totalTransferencia),
      cantidad_recibos:              recibosValidos.length,
      cantidad_ingresos_internos:    filasInternas.length,
      cantidad_recaudacion_tarjeta:  filasRecaudacion.length,
      cantidad_anulados:             recibosAnulados.length,
      por_concepto,
      recibos:                       todosRecibosValidos,
      recibos_anulados:              recibosAnulados,
      bloqueSocios,
      bloqueInquilinos,
      bloqueOtros,
      bloquePendientes,
      matrizConsolidada,
      total_gastos:                  totalGastos,
      saldo_neto,
      gastos,
      apertura_monto,
      apertura,
      total_faltantes,
      total_sobrantes,
      efectivo_fisico_caja,
      ajustes,
    };
  }

  /** Registra o actualiza el saldo inicial del día (upsert por fecha). */
  async upsertApertura(fecha: string, monto: number): Promise<void> {
    const { data: authData } = await this.db.auth.getUser();
    const userId = authData.user?.id ?? null;
    const { error } = await this.db
      .from('caja_aperturas')
      .upsert(
        { fecha, monto_inicial: monto, user_id: userId },
        { onConflict: 'fecha' },
      );
    if (error) throw new Error(error.message);
  }

  /** Registra un ajuste de faltante o sobrante para la fecha indicada. */
  async registrarAjuste(
    fecha: string,
    tipo: 'FALTANTE' | 'SOBRANTE',
    monto: number,
    descripcion: string,
  ): Promise<void> {
    const { data: authData } = await this.db.auth.getUser();
    const userId = authData.user?.id ?? null;
    const { error } = await this.db
      .from('caja_ajustes')
      .insert({ fecha, tipo, monto, descripcion: descripcion.trim() || null, user_id: userId });
    if (error) throw new Error(error.message);
  }

  // ── Reporte Consolidado v2 (RPCs 00085, agregación server-side) ──────────

  /**
   * Carga resumen consolidado para cualquier rango de fechas arbitrario [desde, hasta].
   * Utiliza la RPC rpc_reporte_resumen agregada en Postgres server-side.
   */
  async cargarResumenPeriodo(
    desde: string,
    hasta: string,
    tipoPagador: TipoPagadorFiltro = 'todos',
  ): Promise<ReporteResumenV2> {
    const { data, error } = await this.db.rpc('rpc_reporte_resumen', {
      p_desde:        desde,
      p_hasta:        hasta,
      p_tipo_pagador: tipoPagador,
    });
    if (error) throw new Error(error.message);

    const raw = data as unknown as Omit<ReporteResumenV2, 'rango' | 'fechaDesde' | 'fechaHasta' | 'tipoPagador'>;
    return {
      rango: 'mes',
      fechaDesde: desde,
      fechaHasta: hasta,
      tipoPagador,
      caja:  raw.caja,
      banco: raw.banco,
      por_concepto:          (raw.por_concepto          ?? []).map(c => ({ ...c, monto: Number(c.monto) })),
      egresos_por_categoria: (raw.egresos_por_categoria ?? []).map(e => ({ ...e, monto: Number(e.monto) })),
    };
  }

  /**
   * Drill-down de ingresos para fechas [desde, hasta].
   * concepto = null devuelve todas las líneas del período.
   */
  async cargarDetalleConceptoPeriodo(
    desde: string,
    hasta: string,
    concepto: string | null = null,
    tipoPagador: TipoPagadorFiltro = 'todos',
  ): Promise<DetalleIngresoLinea[]> {
    const { data, error } = await this.db.rpc('rpc_reporte_detalle_concepto', {
      p_desde:        desde,
      p_hasta:        hasta,
      p_concepto:     concepto,
      p_tipo_pagador: tipoPagador,
    });
    if (error) throw new Error(error.message);

    return ((data ?? []) as unknown as DetalleIngresoLinea[])
      .map(l => ({ ...l, monto: Number(l.monto) }));
  }

  /**
   * Drill-down de egresos para fechas [desde, hasta].
   * categoria = null devuelve todos los gastos del período.
   */
  async cargarDetalleEgresosPeriodo(
    desde: string,
    hasta: string,
    categoria: string | null = null,
  ): Promise<DetalleEgresoLinea[]> {
    const { data, error } = await this.db.rpc('rpc_reporte_detalle_egresos', {
      p_desde:     desde,
      p_hasta:     hasta,
      p_categoria: categoria,
    });
    if (error) throw new Error(error.message);

    return ((data ?? []) as unknown as DetalleEgresoLinea[])
      .map(l => ({ ...l, monto: Number(l.monto) }));
  }

  /**
   * Compatibilidad hacia atrás: KPIs de caja/banco por RangoReporte rápido.
   */
  async cargarResumenV2(
    rango: RangoReporte,
    tipoPagador: TipoPagadorFiltro,
  ): Promise<ReporteResumenV2> {
    const { desde, hasta } = calcularRango(rango);
    return this.cargarResumenPeriodo(desde, hasta, tipoPagador);
  }

  /**
   * Compatibilidad hacia atrás: drill-down de ingresos por RangoReporte rápido.
   */
  async cargarDetalleConcepto(
    rango: RangoReporte,
    concepto: string | null,
    tipoPagador: TipoPagadorFiltro,
  ): Promise<DetalleIngresoLinea[]> {
    const { desde, hasta } = calcularRango(rango);
    return this.cargarDetalleConceptoPeriodo(desde, hasta, concepto, tipoPagador);
  }

  /**
   * Compatibilidad hacia atrás: drill-down de egresos por RangoReporte rápido.
   */
  async cargarDetalleEgresos(
    rango: RangoReporte,
    categoria: string | null,
  ): Promise<DetalleEgresoLinea[]> {
    const { desde, hasta } = calcularRango(rango);
    return this.cargarDetalleEgresosPeriodo(desde, hasta, categoria);
  }
}
