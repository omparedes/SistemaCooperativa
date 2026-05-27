import { inject, Injectable, signal } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

export interface Giro {
  id: number;
  nombre: string;
  tarifa_agua_base: number;
  tarifa_luz_base: number;
  activo: boolean;
  total_puestos?: number;
}

export interface GiroConPuestos extends Giro {
  puestos: PuestoDeGiro[];
}

export interface PuestoDeGiro {
  id: number;
  codigo_puesto: string;
  tipo_espacio: string;
  estado: string;
  area_m2: number | null;
  cobro_luz_activo: boolean;
  cobro_agua_activo: boolean;
  titular_apellidos: string | null;
  titular_nombres: string | null;
  inquilino_apellidos: string | null;
  inquilino_nombres: string | null;
}

export interface NuevoGiroParams {
  nombre: string;
  tarifa_agua_base: number;
  tarifa_luz_base: number;
}

@Injectable({ providedIn: 'root' })
export class GirosService {
  private readonly db = inject(SUPABASE_CLIENT);

  private readonly _giros   = signal<Giro[]>([]);
  private readonly _loading = signal(false);
  private readonly _error   = signal<string | null>(null);

  readonly giros   = this._giros.asReadonly();
  readonly loading = this._loading.asReadonly();
  readonly error   = this._error.asReadonly();

  async cargar(): Promise<void> {
    this._loading.set(true);
    this._error.set(null);
    try {
      const { data, error } = await this.db
        .from('giros')
        .select('id, nombre, tarifa_agua_base, tarifa_luz_base, activo')
        .is('deleted_at', null)
        .order('nombre');
      if (error) throw new Error(error.message);

      const ids = (data ?? []).map((g: { id: number }) => g.id);
      const cuentas: Record<number, number> = {};

      if (ids.length > 0) {
        const { data: cnt } = await this.db
          .from('puestos')
          .select('giro_id')
          .in('giro_id', ids)
          .eq('estado', 'Activo')
          .is('deleted_at', null);
        (cnt ?? []).forEach((p: { giro_id: number }) => {
          cuentas[p.giro_id] = (cuentas[p.giro_id] ?? 0) + 1;
        });
      }

      this._giros.set((data ?? []).map((g: {
        id: number; nombre: string;
        tarifa_agua_base: number; tarifa_luz_base: number; activo: boolean;
      }) => ({ ...g, total_puestos: cuentas[g.id] ?? 0 })));
    } catch (e: unknown) {
      this._error.set(e instanceof Error ? e.message : 'Error al cargar giros');
    } finally {
      this._loading.set(false);
    }
  }

  async getPuestosPorGiro(giroId: number): Promise<PuestoDeGiro[]> {
    const { data, error } = await this.db
      .from('vw_espacios_con_ocupacion')
      .select('puesto_id, codigo_puesto, tipo_espacio, estado, area_m2, cobro_luz_activo, cobro_agua_activo, titular_apellidos, titular_nombres, inquilino_apellidos, inquilino_nombres, giro_id')
      .eq('giro_id', giroId)
      .order('codigo_puesto');
    if (error) throw new Error(error.message);
    return (data ?? []).map((r: {
      puesto_id: number; codigo_puesto: string; tipo_espacio: string;
      estado: string; area_m2: number | null; cobro_luz_activo: boolean;
      cobro_agua_activo: boolean; titular_apellidos: string | null;
      titular_nombres: string | null; inquilino_apellidos: string | null;
      inquilino_nombres: string | null;
    }) => ({
      id:                   r.puesto_id,
      codigo_puesto:        r.codigo_puesto,
      tipo_espacio:         r.tipo_espacio,
      estado:               r.estado,
      area_m2:              r.area_m2,
      cobro_luz_activo:     r.cobro_luz_activo,
      cobro_agua_activo:    r.cobro_agua_activo,
      titular_apellidos:    r.titular_apellidos,
      titular_nombres:      r.titular_nombres,
      inquilino_apellidos:  r.inquilino_apellidos,
      inquilino_nombres:    r.inquilino_nombres,
    }));
  }

  async crear(params: NuevoGiroParams): Promise<number> {
    const { data: auth } = await this.db.auth.getUser();
    const { data, error } = await this.db
      .from('giros')
      .insert({ ...params, created_by: auth.user?.id ?? null })
      .select('id')
      .single();
    if (error) throw new Error(error.message);
    return (data as { id: number }).id;
  }

  async actualizar(id: number, params: Partial<NuevoGiroParams> & { activo?: boolean }): Promise<void> {
    const { error } = await this.db
      .from('giros')
      .update(params)
      .eq('id', id)
      .is('deleted_at', null);
    if (error) throw new Error(error.message);
  }

  async eliminar(id: number, motivo: string): Promise<void> {
    const { data: auth } = await this.db.auth.getUser();
    const { error } = await this.db.rpc('rpc_eliminar_giro', {
      p_giro_id:    id,
      p_motivo:     motivo,
      p_usuario_id: auth.user?.id ?? null,
    });
    if (error) throw new Error(error.message);
  }

  async asignarPuestoAGiro(puestoId: number, giroId: number | null): Promise<void> {
    const { error } = await this.db
      .from('puestos')
      .update({ giro_id: giroId })
      .eq('id', puestoId)
      .is('deleted_at', null);
    if (error) throw new Error(error.message);
  }
}
