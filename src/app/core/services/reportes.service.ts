import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

// ---------------------------------------------------------------------------
// Tipos públicos del arqueo
// ---------------------------------------------------------------------------
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
}

export interface ArqueoConcepto {
  concepto: string;
  monto: number;
  cantidad: number;
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
  por_concepto: ArqueoConcepto[];
  recibos: ArqueoPago[];
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
export type TipoPagadorFiltro = 'todos' | 'socios' | 'inquilinos';

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

function calcularRango(rango: RangoReporte): {
  desde: string; hasta: string; desdeISO: string; hastaISO: string;
} {
  const hoy = new Date();
  const [y, m, d] = [hoy.getFullYear(), hoy.getMonth(), hoy.getDate()];
  let inicio: Date;
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
  private readonly db = inject(SUPABASE_CLIENT);

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
      const { data: authData } = await this.db.auth.getUser();
      userId = authData.user?.id ?? null;
    }

    // ── Construir queries en paralelo ────────────────────────────────────────
    let pagosQuery = this.db
      .from('pagos')
      .select(`
        id, codigo_transaccion, fecha_pago, monto_total, metodo_pago, comprobante, created_by,
        deleted_at, motivo_anulacion,
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

    // ── Pagos tradicionales ─────────────────────────────────────────────────
    const recibos: ArqueoPago[] = rows.map(row => {
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
        for (const d of detalleVisible) {
          const nombre = d.monto_cobrar!.concepto!.nombre;
          const prev = conceptoMap.get(nombre) ?? { monto: 0, cantidad: 0 };
          conceptoMap.set(nombre, {
            monto:    prev.monto + Number(d.monto_aplicado),
            cantidad: prev.cantidad + 1,
          });
        }
      }

      const pagador = row.socio
        ? `${row.socio.apellidos}, ${row.socio.nombres}`
        : row.inquilino
          ? `${row.inquilino.apellidos}, ${row.inquilino.nombres}`
          : '—';

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
      };
    });

    // ── Ingresos internos (filtrados por deleted_at IS NULL) ─────────────────
    const filasInternas: ArqueoPago[] = ingresos.map(row => {
      const monto = Number(row.monto);

      if (row.metodo_pago === 'Efectivo') totalEfectivo += monto;
      else totalTransferencia += monto;

      const nombreConcepto = row.concepto?.nombre ?? 'Sin concepto';
      const grupoConcepto  = row.concepto?.grupo ?? 'OTROS';

      const prev = conceptoMap.get(nombreConcepto) ?? { monto: 0, cantidad: 0 };
      conceptoMap.set(nombreConcepto, {
        monto:    prev.monto + monto,
        cantidad: prev.cantidad + 1,
      });

      const pagadorLabel = grupoConcepto === 'INQUILINOS'
        ? 'Para Inquilinos'
        : 'Otros Ingresos';

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
      };
    });

    // ── Recaudación por Tarjeta (abonos semanales → saldo_a_favor) ───────────
    const CONCEPTO_TARJETA = 'Recaudación Tarjeta';
    const filasRecaudacion: ArqueoPago[] = recaudaciones.map(row => {
      const monto = Number(row.monto);
      totalEfectivo += monto;  // se acumula como efectivo (prepago físico)

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
      };
    });

    // ── Mezclar recibos por fecha desc ───────────────────────────────────────
    const todosRecibos = [...recibos, ...filasInternas, ...filasRecaudacion].sort(
      (a, b) => new Date(b.fecha_pago).getTime() - new Date(a.fecha_pago).getTime(),
    );

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
      cantidad_recibos:              recibos.filter(r => !r.anulado).length,
      cantidad_ingresos_internos:    filasInternas.length,
      cantidad_recaudacion_tarjeta:  filasRecaudacion.length,
      por_concepto,
      recibos:                       todosRecibos,
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
   * KPIs de caja/banco + desglose por concepto + egresos por categoría,
   * agregados en Postgres (una sola llamada, sin límite de 1000 filas).
   */
  async cargarResumenV2(
    rango: RangoReporte,
    tipoPagador: TipoPagadorFiltro,
  ): Promise<ReporteResumenV2> {
    const { desde, hasta } = calcularRango(rango);

    const { data, error } = await this.db.rpc('rpc_reporte_resumen', {
      p_desde:        desde,
      p_hasta:        hasta,
      p_tipo_pagador: tipoPagador,
    });
    if (error) throw new Error(error.message);

    const raw = data as unknown as Omit<ReporteResumenV2, 'rango' | 'fechaDesde' | 'fechaHasta' | 'tipoPagador'>;
    return {
      rango,
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
   * Drill-down de ingresos: líneas de recibos, ingresos internos y
   * recaudación tarjeta del rango. `concepto = null` → todas las líneas.
   */
  async cargarDetalleConcepto(
    rango: RangoReporte,
    concepto: string | null,
    tipoPagador: TipoPagadorFiltro,
  ): Promise<DetalleIngresoLinea[]> {
    const { desde, hasta } = calcularRango(rango);

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

  /** Drill-down de egresos. `categoria = null` → todos los gastos del rango. */
  async cargarDetalleEgresos(
    rango: RangoReporte,
    categoria: string | null,
  ): Promise<DetalleEgresoLinea[]> {
    const { desde, hasta } = calcularRango(rango);

    const { data, error } = await this.db.rpc('rpc_reporte_detalle_egresos', {
      p_desde:     desde,
      p_hasta:     hasta,
      p_categoria: categoria,
    });
    if (error) throw new Error(error.message);

    return ((data ?? []) as unknown as DetalleEgresoLinea[])
      .map(l => ({ ...l, monto: Number(l.monto) }));
  }
}
