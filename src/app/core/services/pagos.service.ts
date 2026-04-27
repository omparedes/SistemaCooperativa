import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';
import {
  BusquedaResultado,
  DeudaItem,
  LineaFifo,
  MetodoPago,
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

interface MontoPorCobrarRow {
  id: number;
  monto: number;
  estado: string;
  periodo_anio: number;
  periodo_mes: number;
  fecha_generacion: string;
  concepto: { nombre: string } | null;
  pagos_parciales: Array<{ monto_aplicado: number; deleted_at: string | null }>;
}

// ---------------------------------------------------------------------------

@Injectable({ providedIn: 'root' })
export class PagosService {
  private readonly db = inject(SUPABASE_CLIENT);

  private async garantizarSesion(): Promise<void> {
    const { data: actual } = await this.db.auth.getUser();
    if (actual.user) return;
    const { error } = await this.db.auth.signInAnonymously();
    if (error) throw new Error(`No se pudo iniciar sesión: ${error.message}`);
  }

  async buscarPagador(q: string): Promise<BusquedaResultado[]> {
    await this.garantizarSesion();
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

  async cargarDeudasPuesto(puestoId: number): Promise<DeudaItem[]> {
    await this.garantizarSesion();

    const { data, error } = await this.db
      .from('montos_por_cobrar')
      .select(`
        id, monto, estado, periodo_anio, periodo_mes, fecha_generacion,
        concepto:conceptos(nombre),
        pagos_parciales:detalle_pagos(monto_aplicado, deleted_at)
      `)
      .eq('puesto_id', puestoId)
      .neq('estado', 'Cancelado')
      .is('deleted_at', null)
      .order('periodo_anio', { ascending: true })
      .order('periodo_mes', { ascending: true });

    if (error) throw new Error(error.message);

    return ((data ?? []) as unknown as MontoPorCobrarRow[])
      .map(row => {
        const ya_pagado = (row.pagos_parciales ?? [])
          .filter(p => p.deleted_at === null)
          .reduce((s, p) => s + Number(p.monto_aplicado), 0);
        const saldo_pendiente = Math.round((Number(row.monto) - ya_pagado) * 100) / 100;
        return {
          monto_id: row.id,
          concepto: row.concepto?.nombre ?? 'Sin concepto',
          periodo_anio: row.periodo_anio,
          periodo_mes: row.periodo_mes,
          monto_original: Number(row.monto),
          ya_pagado,
          saldo_pendiente,
          fecha_generacion: row.fecha_generacion,
        };
      })
      .filter(d => d.saldo_pendiente > 0);
  }

  async procesarPago(params: {
    resultado: BusquedaResultado;
    distribucion: LineaFifo[];
    metodo_pago: MetodoPago;
    comprobante: string;
    observacion: string;
  }): Promise<{ pago_id: number; codigo_transaccion: string }> {
    await this.garantizarSesion();

    const { data: authData } = await this.db.auth.getUser();
    const userId = authData.user?.id ?? null;

    const lineasActivas = params.distribucion.filter(l => l.monto_aplicado > 0);
    const monto_total = Math.round(
      lineasActivas.reduce((s, l) => s + l.monto_aplicado, 0) * 100,
    ) / 100;

    if (monto_total <= 0) throw new Error('El monto total debe ser mayor a cero');

    // 1. Insert pago — XOR socio/inquilino enforced aquí
    const pagoBase: Record<string, unknown> = {
      puesto_id: params.resultado.puesto_id,
      monto_total,
      metodo_pago: params.metodo_pago,
      comprobante: params.comprobante || null,
      observacion: params.observacion || null,
      created_by: userId,
    };

    const tipoPagador: TipoPagador = params.resultado.tipo;
    if (tipoPagador === 'socio') {
      pagoBase['socio_id'] = params.resultado.persona_id;
    } else {
      pagoBase['inquilino_id'] = params.resultado.persona_id;
    }

    const { data: pagoData, error: pagoError } = await this.db
      .from('pagos')
      .insert(pagoBase)
      .select('id, codigo_transaccion')
      .single();

    if (pagoError) throw new Error(pagoError.message);
    const pago = pagoData as { id: number; codigo_transaccion: string };

    // 2. Insert detalle_pagos (distribución FIFO)
    const detalleRows = lineasActivas.map(l => ({
      pago_id: pago.id,
      monto_id: l.monto_id,
      monto_aplicado: l.monto_aplicado,
      created_by: userId,
    }));

    const { error: detalleError } = await this.db
      .from('detalle_pagos')
      .insert(detalleRows);

    if (detalleError) throw new Error(detalleError.message);

    // 3. Marcar como 'Pagado' las deudas completamente cubiertas
    const idsToPagar = lineasActivas
      .filter(l => l.cubierto_completo)
      .map(l => l.monto_id);

    if (idsToPagar.length > 0) {
      const { error: updateError } = await this.db
        .from('montos_por_cobrar')
        .update({ estado: 'Pagado' })
        .in('id', idsToPagar);

      if (updateError) throw new Error(updateError.message);
    }

    return { pago_id: pago.id, codigo_transaccion: pago.codigo_transaccion };
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
