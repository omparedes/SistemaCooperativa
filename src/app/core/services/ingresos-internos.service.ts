import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

// ---------------------------------------------------------------------------
// Tipos públicos
// ---------------------------------------------------------------------------
export type GrupoConcepto = 'SOCIOS' | 'INQUILINOS' | 'OTROS';

export interface ConceptoInterno {
  id: number;
  nombre: string;
  grupo: GrupoConcepto;
  descripcion: string | null;
}

export interface RegistrarIngresoParams {
  concepto_id: number;
  monto: number;
  metodo_pago: 'Efectivo' | 'Transferencia';
  observacion?: string;
}

// ---------------------------------------------------------------------------
// Tipo interno (raw Supabase row)
// ---------------------------------------------------------------------------
interface ConceptoRow {
  id: number;
  nombre: string;
  grupo: string | null;
  descripcion: string | null;
}

// ---------------------------------------------------------------------------
// Servicio
// ---------------------------------------------------------------------------
@Injectable({ providedIn: 'root' })
export class IngresosInternosService {
  private readonly db = inject(SUPABASE_CLIENT);

  /**
   * Devuelve conceptos activos de los grupos INQUILINOS y OTROS,
   * ordenados por grupo y nombre. Son los que aparecen en la Caja Rápida.
   */
  async getConceptos(): Promise<ConceptoInterno[]> {
    const { data, error } = await this.db
      .from('conceptos')
      .select('id, nombre, grupo, descripcion')
      .in('grupo', ['INQUILINOS', 'OTROS'])
      .is('deleted_at', null)
      .eq('activo', true)
      .order('grupo')
      .order('nombre');

    if (error) throw new Error(error.message);

    return ((data ?? []) as ConceptoRow[])
      .filter((r): r is ConceptoRow & { grupo: GrupoConcepto } => r.grupo !== null)
      .map(r => ({
        id:          r.id,
        nombre:      r.nombre,
        grupo:       r.grupo as GrupoConcepto,
        descripcion: r.descripcion,
      }));
  }

  /**
   * Registra un ingreso interno vía RPC.
   * Retorna el id del registro creado.
   */
  async registrar(params: RegistrarIngresoParams): Promise<{ id: number }> {
    const { data: authData } = await this.db.auth.getUser();
    const userId = authData.user?.id;
    if (!userId) throw new Error('Usuario no autenticado');

    const { data, error } = await this.db.rpc('registrar_ingreso_interno', {
      p_concepto_id: params.concepto_id,
      p_monto:       params.monto,
      p_metodo_pago: params.metodo_pago,
      p_usuario_id:  userId,
      p_observacion: params.observacion ?? null,
    });

    if (error) throw new Error(error.message);
    return { id: data as number };
  }
}
