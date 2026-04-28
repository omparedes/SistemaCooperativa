import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

// ---------------------------------------------------------------------------
// Tipos públicos del arqueo
// ---------------------------------------------------------------------------
export interface ArqueoPago {
  id: number;
  codigo_transaccion: string;
  fecha_pago: string;          // ISO timestamptz
  monto_total: number;
  metodo_pago: 'Efectivo' | 'Transferencia';
  comprobante: string | null;
  codigo_puesto: string;
  pagador: string;             // apellidos, nombres del socio o inquilino
  cajero_nombre: string;       // nombres del usuario que registró el pago
  conceptos: string[];         // lista de conceptos únicos del recibo
  anulado: boolean;
  motivo_anulacion: string | null;
}

export interface ArqueoConcepto {
  concepto: string;
  monto: number;               // suma de monto_aplicado de todos los detalles
  cantidad: number;            // número de líneas de detalle aplicadas
}

export interface ArqueoResumen {
  fecha: string;               // YYYY-MM-DD
  total_dia: number;
  total_efectivo: number;
  total_transferencia: number;
  cantidad_recibos: number;
  por_concepto: ArqueoConcepto[];
  recibos: ArqueoPago[];
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
   * Carga todos los pagos del día indicado.
   * @param fecha      YYYY-MM-DD (en hora local del browser)
   * @param soloMiCajero  true → filtra por created_by = auth.uid() (rol Caja)
   */
  async cargarArqueo(
    fecha: string,
    soloMiCajero: boolean,
  ): Promise<ArqueoResumen> {
    const inicio = isoInicioDia(fecha);
    const fin    = isoFinDia(fecha);

    // eslint-disable-next-line prefer-const
    let query = this.db
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
      // Sin filtro deleted_at: incluimos anulados para mostrarlos en el arqueo
      // con estilo distinto, pero excluidos de los totales en construirResumen.
      .gte('fecha_pago', inicio)
      .lte('fecha_pago', fin)
      .order('fecha_pago', { ascending: false });

    if (soloMiCajero) {
      const { data: authData } = await this.db.auth.getUser();
      if (authData.user) {
        query = query.eq('created_by', authData.user.id);
      }
    }

    const { data, error } = await query;
    if (error) throw new Error(error.message);

    const rows = (data ?? []) as unknown as PagoArqueoRow[];

    // Carga nombres de cajeros en un solo batch
    const ids = [
      ...new Set(rows.map(r => r.created_by).filter((id): id is string => id !== null)),
    ];

    const perfilMap = new Map<string, PerfilResumen>();
    if (ids.length > 0) {
      const { data: perfiles } = await this.db
        .from('perfiles')
        .select('id, nombres, email')
        .in('id', ids);
      for (const p of (perfiles ?? []) as PerfilResumen[]) {
        perfilMap.set(p.id, p);
      }
    }

    return this.construirResumen(fecha, rows, perfilMap);
  }

  // -------------------------------------------------------------------------
  private construirResumen(
    fecha: string,
    rows: PagoArqueoRow[],
    perfilMap: Map<string, PerfilResumen>,
  ): ArqueoResumen {
    let totalEfectivo = 0;
    let totalTransferencia = 0;
    const conceptoMap = new Map<string, { monto: number; cantidad: number }>();

    const recibos: ArqueoPago[] = rows.map(row => {
      const monto = Number(row.monto_total);
      const esAnulado = row.deleted_at !== null;

      // Solo sumar al total si el pago NO está anulado
      if (!esAnulado) {
        if (row.metodo_pago === 'Efectivo') totalEfectivo += monto;
        else totalTransferencia += monto;
      }

      // Para pagos anulados mostramos los detalles originales (aunque estén soft-deleted)
      // para que se vean los conceptos que contenía el recibo.
      const detalleVisible = (row.detalle ?? []).filter(
        d => (esAnulado || d.deleted_at === null) && d.monto_cobrar?.concepto?.nombre,
      );

      const conceptosUnicos = [
        ...new Set(detalleVisible.map(d => d.monto_cobrar!.concepto!.nombre)),
      ];

      // Acumular por concepto SOLO de pagos vigentes
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
      const cajeroNombre = perfil?.nombres ?? perfil?.email ?? '—';

      return {
        id: row.id,
        codigo_transaccion: row.codigo_transaccion,
        fecha_pago: row.fecha_pago,
        monto_total: monto,
        metodo_pago: row.metodo_pago as 'Efectivo' | 'Transferencia',
        comprobante: row.comprobante,
        codigo_puesto: row.puesto?.codigo_puesto ?? '—',
        pagador,
        cajero_nombre: cajeroNombre,
        conceptos: conceptosUnicos,
        anulado: esAnulado,
        motivo_anulacion: row.motivo_anulacion,
      };
    });

    const por_concepto: ArqueoConcepto[] = [...conceptoMap.entries()]
      .map(([concepto, { monto, cantidad }]) => ({
        concepto,
        monto:    round2(monto),
        cantidad,
      }))
      .sort((a, b) => b.monto - a.monto);

    const recibosVigentes = recibos.filter(r => !r.anulado).length;

    return {
      fecha,
      total_dia:           round2(totalEfectivo + totalTransferencia),
      total_efectivo:      round2(totalEfectivo),
      total_transferencia: round2(totalTransferencia),
      cantidad_recibos:    recibosVigentes,
      por_concepto,
      recibos,
    };
  }
}
