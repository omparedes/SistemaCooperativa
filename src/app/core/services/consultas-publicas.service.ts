import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';
import type {
  BusquedaResultado,
  DeudaItem,
  PagoHistorial,
  TipoPagador,
} from '../../pages/pagos/pago.model';

@Injectable({ providedIn: 'root' })
export class ConsultasPublicasService {
  private readonly db = inject(SUPABASE_CLIENT);

  /**
   * Invoca `rpc_public_buscar_pagador` (SECURITY DEFINER, accesible por anon).
   * Busca socios, inquilinos y puestos que coincidan con el término.
   */
  async buscarPagador(q: string): Promise<BusquedaResultado[]> {
    const termino = q.trim();
    if (!termino) return [];

    const { data, error } = await this.db.rpc('rpc_public_buscar_pagador', {
      p_query: termino,
    });

    if (error) throw new Error(error.message);
    return (data as unknown as BusquedaResultado[]) ?? [];
  }

  /**
   * Invoca `rpc_public_cargar_deudas` (SECURITY DEFINER, accesible por anon).
   * Devuelve los saldos pendientes de un puesto (saldo_pendiente > 0).
   */
  async cargarDeudasPuesto(puestoId: number, personaId?: number, tipo?: 'socio' | 'inquilino'): Promise<DeudaItem[]> {
    const { data, error } = await this.db.rpc('rpc_public_cargar_deudas', {
      p_puesto_id: puestoId,
      p_persona_id: personaId,
      p_tipo: tipo,
    });

    if (error) throw new Error(error.message);
    return (data as unknown as DeudaItem[]) ?? [];
  }

  /**
   * Invoca `rpc_public_obtener_historial` (SECURITY DEFINER, accesible por anon).
   * Devuelve el historial completo de pagos (incluye anulados para mostrarlos tachados).
   */
  async obtenerHistorialPorPagador(id: number, tipo: TipoPagador): Promise<PagoHistorial[]> {
    const { data, error } = await this.db.rpc('rpc_public_obtener_historial', {
      p_id: id,
      p_tipo: tipo,
    });

    if (error) throw new Error(error.message);
    return (data as unknown as PagoHistorial[]) ?? [];
  }
}
