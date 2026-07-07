import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';
import {
  BusquedaResultado,
  DeudaItem,
  LineaFifo,
  MetodoPago,
  PagoHistorial,
  TipoPagador,
} from '../../pages/pagos/pago.model';

// ---------------------------------------------------------------------------
// Row shapes from Supabase queries
// ---------------------------------------------------------------------------
interface SocioBusquedaRow {
  id: number;
  dni: string;
  nombres: string;
  apellidos: string;
  titularidad_vigente: Array<{
    fecha_fin: string | null;
    puesto: { id: number; codigo_puesto: string } | null;
  }>;
}

interface InquilinoBusquedaRow {
  id: number;
  dni: string;
  nombres: string;
  apellidos: string;
  arriendo_vigente: Array<{
    fecha_fin: string | null;
    puesto: { id: number; codigo_puesto: string } | null;
  }>;
}

interface PuestoBusquedaRow {
  id: number;
  codigo_puesto: string;
  titular_vigente: Array<{
    fecha_fin: string | null;
    socio: { id: number; dni: string; nombres: string; apellidos: string } | null;
  }>;
}

interface PagoHistorialDetalleRow {
  id: number;
  monto_aplicado: number;
  deleted_at: string | null;
  monto_cobrar: {
    monto: number;
    periodo_anio: number;
    periodo_mes: number;
    concepto: { nombre: string } | null;
    puesto: { codigo_puesto: string } | null;
  } | null;
}

interface PagoHistorialRow {
  id: number;
  codigo_transaccion: string;
  fecha_pago: string;
  monto_total: number;
  metodo_pago: string;
  comprobante: string | null;
  deleted_at: string | null;
  motivo_anulacion: string | null;
  puesto: { codigo_puesto: string } | null;
  detalle: PagoHistorialDetalleRow[];
}

// ---------------------------------------------------------------------------

@Injectable({ providedIn: 'root' })
export class PagosService {
  private readonly db = inject(SUPABASE_CLIENT);

  async buscarPagador(q: string): Promise<BusquedaResultado[]> {
    const termino = q.trim().toUpperCase();
    if (!termino) return [];

    const [socioRes, inquilinoRes, puestoRes] = await Promise.all([
      this.db
        .from('socios')
        .select(`
          id, dni, nombres, apellidos,
          titularidad_vigente:historial_titularidad(
            fecha_fin,
            puesto:puestos(id, codigo_puesto)
          )
        `)
        .is('deleted_at', null)
        .is('titularidad_vigente.fecha_fin', null)
        .or(`dni.ilike.%${termino}%,nombres.ilike.%${termino}%,apellidos.ilike.%${termino}%`)
        .limit(8),

      this.db
        .from('inquilinos')
        .select(`
          id, dni, nombres, apellidos,
          arriendo_vigente:historial_arriendos(
            fecha_fin,
            puesto:puestos(id, codigo_puesto)
          )
        `)
        .is('deleted_at', null)
        .is('arriendo_vigente.fecha_fin', null)
        .or(`dni.ilike.%${termino}%,nombres.ilike.%${termino}%,apellidos.ilike.%${termino}%`)
        .limit(8),

      this.db
        .from('puestos')
        .select(`
          id, codigo_puesto,
          titular_vigente:historial_titularidad(
            fecha_fin,
            socio:socios(id, dni, nombres, apellidos)
          )
        `)
        .is('deleted_at', null)
        .is('titular_vigente.fecha_fin', null)
        .ilike('codigo_puesto', `%${termino}%`)
        .limit(5),
    ]);

    const resultados: BusquedaResultado[] = [];
    const puestosVistos = new Set<number>();

    for (const row of (socioRes.data ?? []) as unknown as SocioBusquedaRow[]) {
      const puesto = row.titularidad_vigente[0]?.puesto;
      if (!puesto || puestosVistos.has(puesto.id)) continue;
      puestosVistos.add(puesto.id);
      resultados.push(this.mapearResultado('socio', row.id, row.dni, row.nombres, row.apellidos, puesto.id, puesto.codigo_puesto));
    }

    for (const row of (inquilinoRes.data ?? []) as unknown as InquilinoBusquedaRow[]) {
      const puesto = row.arriendo_vigente[0]?.puesto;
      if (!puesto || puestosVistos.has(puesto.id)) continue;
      puestosVistos.add(puesto.id);
      resultados.push(this.mapearResultado('inquilino', row.id, row.dni, row.nombres, row.apellidos, puesto.id, puesto.codigo_puesto));
    }

    for (const row of (puestoRes.data ?? []) as unknown as PuestoBusquedaRow[]) {
      if (puestosVistos.has(row.id)) continue;
      const socio = row.titular_vigente[0]?.socio;
      if (!socio) continue;
      puestosVistos.add(row.id);
      resultados.push(this.mapearResultado('socio', socio.id, socio.dni, socio.nombres, socio.apellidos, row.id, row.codigo_puesto));
    }

    return resultados.slice(0, 10);
  }

  /**
   * Consolidado de deudas del pagador vía `rpc_caja_cargar_deudas` (00082):
   * cargos personales + puesto principal + todos los almacenes vigentes.
   * Misma fuente canónica que Cuenta Corriente y el Portal Público.
   */
  async cargarDeudasPuesto(puestoId: number, personaId?: number, tipo?: 'socio' | 'inquilino'): Promise<DeudaItem[]> {
    const { data, error } = await this.db.rpc('rpc_caja_cargar_deudas', {
      p_puesto_id:  puestoId,
      p_persona_id: personaId ?? null,
      p_tipo:       tipo ?? null,
    });

    if (error) throw new Error(error.message);

    return ((data ?? []) as unknown as DeudaItem[]).map(d => ({
      ...d,
      monto_original:  Number(d.monto_original),
      ya_pagado:       Number(d.ya_pagado),
      saldo_pendiente: Number(d.saldo_pendiente),
    }));
  }

  async obtenerSaldoAFavor(personaId: number, tipo: 'socio' | 'inquilino'): Promise<number> {
    const tabla = tipo === 'socio' ? 'socios' : 'inquilinos';
    const { data, error } = await this.db
      .from(tabla)
      .select('saldo_a_favor')
      .eq('id', personaId)
      .single();
    if (error) throw new Error(error.message);
    return Number((data as { saldo_a_favor: number } | null)?.saldo_a_favor ?? 0);
  }

  async procesarPago(params: {
    resultado: BusquedaResultado;
    distribucion: LineaFifo[];
    monto_recibido: number;
    saldo_utilizado?: number;
    metodo_pago: MetodoPago;
    comprobante: string;
    observacion: string;
  }): Promise<{ pago_id: number; codigo_transaccion: string }> {

    const { data: authData } = await this.db.auth.getUser();
    const userId = authData.user?.id ?? null;

    const saldoUtil = params.saldo_utilizado ?? 0;
    const montoDisponible = Math.round((params.monto_recibido + saldoUtil) * 100) / 100;

    if (montoDisponible <= 0) throw new Error('El monto disponible debe ser mayor a cero');

    const tipoPagador: TipoPagador = params.resultado.tipo;

    const distribucion = params.distribucion
      .filter(l => l.monto_aplicado > 0)
      .map(l => ({
        monto_id:          l.monto_id,
        monto_aplicado:    l.monto_aplicado,
        cubierto_completo: l.cubierto_completo,
      }));

    const { data, error } = await this.db.rpc('rpc_procesar_pago', {
      p_puesto_id:       params.resultado.puesto_id,
      p_socio_id:        tipoPagador === 'socio'     ? params.resultado.persona_id : null,
      p_inquilino_id:    tipoPagador === 'inquilino' ? params.resultado.persona_id : null,
      p_monto_total:     params.monto_recibido,
      p_metodo_pago:     params.metodo_pago,
      p_comprobante:     params.comprobante || null,
      p_observacion:     params.observacion || null,
      p_usuario_id:      userId,
      p_distribucion:    distribucion,
      p_saldo_utilizado: saldoUtil,
    });

    if (error) throw new Error(error.message);

    const resultado = data as unknown as { pago_id: number; codigo_transaccion: string };
    return { pago_id: resultado.pago_id, codigo_transaccion: resultado.codigo_transaccion };
  }

  // -------------------------------------------------------------------------
  // Historial de pagos por socio o inquilino
  // -------------------------------------------------------------------------
  async obtenerHistorialPorPagador(
    id: number,
    tipo: TipoPagador,
  ): Promise<PagoHistorial[]> {

    const campo = tipo === 'socio' ? 'socio_id' : 'inquilino_id';

    const { data, error } = await this.db
      .from('pagos')
      .select(`
        id, codigo_transaccion, fecha_pago, monto_total, metodo_pago, comprobante,
        deleted_at, motivo_anulacion,
        puesto:puestos(codigo_puesto),
        detalle:detalle_pagos(
          id, monto_aplicado, deleted_at,
          monto_cobrar:montos_por_cobrar(
            monto, periodo_anio, periodo_mes,
            concepto:conceptos(nombre),
            puesto:puestos(codigo_puesto)
          )
        )
      `)
      .eq(campo, id)
      // Sin filtro deleted_at: incluimos anulados para mostrarlos con estilo distinto
      .order('fecha_pago', { ascending: false })
      .limit(100);

    if (error) throw new Error(error.message);

    return ((data ?? []) as unknown as PagoHistorialRow[]).map(r => {
      const pagoAnulado = r.deleted_at !== null;
      return {
        id: r.id,
        codigo_transaccion: r.codigo_transaccion,
        fecha_pago: r.fecha_pago,
        monto_total: Number(r.monto_total),
        metodo_pago: r.metodo_pago as MetodoPago,
        comprobante: r.comprobante,
        codigo_puesto: r.puesto?.codigo_puesto ?? '—',
        anulado: pagoAnulado,
        motivo_anulacion: r.motivo_anulacion,
        deleted_at: r.deleted_at,
        detalle: (r.detalle ?? [])
          // Para pagos anulados: mostramos todos los detalles (incluso los soft-deleted)
          // para ver los conceptos que contenía. Para pagos vigentes: solo activos.
          .filter(d => pagoAnulado || d.deleted_at === null)
          .map(d => ({
            monto_aplicado: Number(d.monto_aplicado),
            concepto:      d.monto_cobrar?.concepto?.nombre ?? 'Concepto eliminado',
            codigo_puesto: d.monto_cobrar?.puesto?.codigo_puesto ?? null,
            periodo_anio:  d.monto_cobrar?.periodo_anio ?? 0,
            periodo_mes:   d.monto_cobrar?.periodo_mes ?? 0,
            monto_original: Number(d.monto_cobrar?.monto ?? d.monto_aplicado),
          })),
      };
    });
  }

  // -------------------------------------------------------------------------
  // Anulación de pago (soft delete vía RPC)
  // -------------------------------------------------------------------------
  async anularPago(pagoId: number, motivo: string): Promise<void> {
    const { data: authData } = await this.db.auth.getUser();
    const userId = authData.user?.id;
    if (!userId) throw new Error('Usuario no autenticado');

    const { error } = await this.db.rpc('anular_pago', {
      p_pago_id:    pagoId,
      p_motivo:     motivo,
      p_usuario_id: userId,
    });

    if (error) throw new Error(error.message);
  }

  // -------------------------------------------------------------------------
  // Realtime: suscripción a nuevos pagos de un pagador concreto
  // Devuelve la función de limpieza para llamar en ngOnDestroy.
  // -------------------------------------------------------------------------
  suscribirCambiosDePagos(
    id: number,
    tipo: TipoPagador,
    onCambio: () => void,
  ): () => void {
    const filtro = `${tipo === 'socio' ? 'socio_id' : 'inquilino_id'}=eq.${id}`;
    const channel = this.db
      .channel(`pagos-${tipo}-${id}`)
      .on(
        'postgres_changes',
        { event: 'INSERT', schema: 'public', table: 'pagos', filter: filtro },
        () => onCambio(),
      )
      .subscribe();

    return () => void this.db.removeChannel(channel);
  }

  private mapearResultado(
    tipo: TipoPagador,
    personaId: number,
    dni: string,
    nombres: string,
    apellidos: string,
    puestoId: number,
    codigoPuesto: string,
  ): BusquedaResultado {
    return {
      tipo,
      persona_id: personaId,
      dni,
      nombre_completo: `${apellidos}, ${nombres}`,
      puesto_id: puestoId,
      codigo_puesto: codigoPuesto,
    };
  }
}
