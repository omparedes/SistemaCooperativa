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
}

export interface ArqueoConcepto {
  concepto: string;
  monto: number;
  cantidad: number;
}

export interface ArqueoResumen {
  fecha: string;                  // YYYY-MM-DD
  total_dia: number;
  total_efectivo: number;
  total_transferencia: number;
  cantidad_recibos: number;           // solo pagos tradicionales vigentes
  cantidad_ingresos_internos: number; // solo ingresos internos del día
  por_concepto: ArqueoConcepto[];
  recibos: ArqueoPago[];              // pagos + ingresos internos mezclados, por hora desc
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

interface PerfilResumen {
  id: string;
  nombres: string | null;
  email: string;
}

// ---------------------------------------------------------------------------
// Helpers de fecha (usa la zona horaria del browser → correcta para Lima)
// ---------------------------------------------------------------------------
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
   * Carga pagos e ingresos internos del día indicado.
   * Los pagos anulados se incluyen en la lista pero NO en los totales.
   * Los ingresos internos siempre suman a los totales.
   */
  async cargarArqueo(
    fecha: string,
    soloMiCajero: boolean,
  ): Promise<ArqueoResumen> {
    const inicio = isoInicioDia(fecha);
    const fin    = isoFinDia(fecha);

    // Obtener userId una sola vez para ambas queries
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

    if (userId) {
      pagosQuery = pagosQuery.eq('created_by', userId);
      iiQuery    = iiQuery.eq('created_by', userId);
    }

    const [pagosRes, iiRes] = await Promise.all([pagosQuery, iiQuery]);
    if (pagosRes.error) throw new Error(pagosRes.error.message);
    if (iiRes.error)    throw new Error(iiRes.error.message);

    const rows     = (pagosRes.data ?? []) as unknown as PagoArqueoRow[];
    const ingresos = (iiRes.data ?? []) as unknown as IngresoInternoArqueoRow[];

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

    return this.construirResumen(fecha, rows, ingresos, perfilMap);
  }

  // ── Construcción del resumen ──────────────────────────────────────────────
  private construirResumen(
    fecha: string,
    rows: PagoArqueoRow[],
    ingresos: IngresoInternoArqueoRow[],
    perfilMap: Map<string, PerfilResumen>,
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
      };
    });

    // ── Ingresos internos (nunca anulados en esta query — filtered IS NULL) ──
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

      // Código de referencia visual (no es un código de transacción real)
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
      };
    });

    // ── Mezclar y ordenar por fecha desc ─────────────────────────────────────
    const todosRecibos = [...recibos, ...filasInternas].sort(
      (a, b) => new Date(b.fecha_pago).getTime() - new Date(a.fecha_pago).getTime(),
    );

    const por_concepto: ArqueoConcepto[] = [...conceptoMap.entries()]
      .map(([concepto, { monto, cantidad }]) => ({
        concepto,
        monto:    round2(monto),
        cantidad,
      }))
      .sort((a, b) => b.monto - a.monto);

    return {
      fecha,
      total_dia:                   round2(totalEfectivo + totalTransferencia),
      total_efectivo:              round2(totalEfectivo),
      total_transferencia:         round2(totalTransferencia),
      cantidad_recibos:            recibos.filter(r => !r.anulado).length,
      cantidad_ingresos_internos:  filasInternas.length,
      por_concepto,
      recibos:                     todosRecibos,
    };
  }
}
