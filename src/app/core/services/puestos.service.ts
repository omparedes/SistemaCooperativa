import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';
import { EspacioOcupacion, EspacioJerarquia, TipoEspacio } from '../../pages/espacios/espacios.model';

// ---------------------------------------------------------------------------
// Tipos públicos — selects simples (formularios de Socio / Inquilino)
// ---------------------------------------------------------------------------
export interface Giro {
  id: number;
  nombre: string;
}

export interface PuestoDisponible {
  id: number;
  codigo_puesto: string;
  tipo_espacio: TipoEspacio;
  giro_id: number | null;
  giro_nombre: string | null;
  area_m2: number | null;
  socio_titular_id: number | null;
}

// ---------------------------------------------------------------------------
// Tipos internos
// ---------------------------------------------------------------------------
interface GiroRow { id: number; nombre: string; }

interface PuestoRow {
  id: number;
  codigo_puesto: string;
  tipo_espacio: TipoEspacio;
  giro_id: number | null;
  area_m2: number | null;
  giro: { nombre: string } | null;
  titularidad_activa: Array<{ socio_id: number; fecha_fin: string | null }>;
  arriendo_activo:    Array<{ inquilino_id: number; fecha_fin: string | null }>;
}

// ---------------------------------------------------------------------------
// Servicio
// ---------------------------------------------------------------------------
@Injectable({ providedIn: 'root' })
export class PuestosService {
  private readonly db = inject(SUPABASE_CLIENT);

  // ── Catálogo ──────────────────────────────────────────────────────────────

  async getGiros(): Promise<Giro[]> {
    const { data, error } = await this.db
      .from('giros')
      .select('id, nombre')
      .is('deleted_at', null)
      .order('nombre');
    if (error) throw new Error(error.message);
    return (data ?? []) as GiroRow[];
  }

  // ── Espacios completos (Gestión de Espacios) ───────────────────────────────

  /**
   * Todos los espacios activos con ocupante vigente.
   * Usa la vista vw_espacios_con_ocupacion (migración 00042).
   */
  async getEspacios(): Promise<EspacioOcupacion[]> {
    const { data, error } = await this.db
      .from('vw_espacios_con_ocupacion')
      .select('*');
    if (error) throw new Error(error.message);
    return (data ?? []) as EspacioOcupacion[];
  }

  /**
   * Construye la jerarquía Principal → [Almacenes] agrupando por titular.
   * Los almacenes se asocian al Principal del mismo titular vigente.
   * Espacios sin titular (sin historial_titularidad activo) van en una lista aparte.
   */
  async getEspaciosJerarquicos(): Promise<{
    jerarquias: EspacioJerarquia[];
    sinTitular: EspacioOcupacion[];
  }> {
    const todos = await this.getEspacios();

    const principales = todos.filter(e => e.tipo_espacio === 'Principal');
    const almacenes   = todos.filter(e => e.tipo_espacio === 'Almacen');

    const jerarquias: EspacioJerarquia[] = principales.map(p => ({
      principal: p,
      almacenes: almacenes.filter(a => a.titular_id !== null && a.titular_id === p.titular_id),
    }));

    // Almacenes sin titular o cuyo titular no tiene Principal en el padrón
    const almacenesAsignados = new Set(jerarquias.flatMap(j => j.almacenes.map(a => a.puesto_id)));
    const sinTitular = [
      ...principales.filter(p => p.titular_id === null),
      ...almacenes.filter(a => !almacenesAsignados.has(a.puesto_id)),
    ];

    return { jerarquias, sinTitular };
  }

  // ── Toggle de servicios (solo Administrador) ──────────────────────────────

  /**
   * Activa o desactiva el cobro de Luz o Agua para un puesto.
   * Llama a la RPC toggle_servicio_puesto (SECURITY DEFINER, valida rol Admin).
   */
  async toggleServicio(
    puestoId: number,
    servicio: 'luz' | 'agua',
    activo: boolean,
  ): Promise<{ activo_prev: boolean; activo_nuevo: boolean }> {
    const { data: auth } = await this.db.auth.getUser();
    const { data, error } = await this.db.rpc('toggle_servicio_puesto', {
      p_puesto_id: puestoId,
      p_servicio:  servicio,
      p_activo:    activo,
      p_usuario:   auth.user?.id ?? null,
    });
    if (error) throw new Error(error.message);
    return data as { activo_prev: boolean; activo_nuevo: boolean };
  }

  // ── Selects para formularios ──────────────────────────────────────────────

  /**
   * Puestos PRINCIPALES activos disponibles para asignar como titular a un socio.
   * Excluye puestos ya asignados (excepto el del socio en edición).
   */
  async getPuestosParaSocios(excluirSocioId?: number): Promise<PuestoDisponible[]> {
    const { data, error } = await this.db
      .from('puestos')
      .select(`
        id, codigo_puesto, tipo_espacio, giro_id, area_m2,
        giro:giros(nombre),
        titularidad_activa:historial_titularidad(socio_id, fecha_fin)
      `)
      .eq('estado', 'Activo')
      .eq('tipo_espacio', 'Principal')
      .is('deleted_at', null)
      .order('codigo_puesto');

    if (error) throw new Error(error.message);

    return ((data ?? []) as unknown as PuestoRow[])
      .filter(p => {
        const activas = p.titularidad_activa.filter(t => t.fecha_fin === null);
        if (activas.length === 0) return true;
        return !!excluirSocioId && activas[0].socio_id === excluirSocioId;
      })
      .map(p => this.mapPuesto(p));
  }

  /**
   * Puestos ALMACÉN activos disponibles para asignar la titularidad a un socio.
   * Usado en la pantalla de Gestión de Espacios para asignar depósitos/SP/EP.
   */
  async getPuestosAlmacenParaSocios(excluirSocioId?: number): Promise<PuestoDisponible[]> {
    const { data, error } = await this.db
      .from('puestos')
      .select(`
        id, codigo_puesto, tipo_espacio, giro_id, area_m2,
        giro:giros(nombre),
        titularidad_activa:historial_titularidad(socio_id, fecha_fin)
      `)
      .eq('estado', 'Activo')
      .eq('tipo_espacio', 'Almacen')
      .is('deleted_at', null)
      .order('codigo_puesto');

    if (error) throw new Error(error.message);

    return ((data ?? []) as unknown as PuestoRow[])
      .filter(p => {
        const activas = p.titularidad_activa.filter(t => t.fecha_fin === null);
        if (activas.length === 0) return true;
        return !!excluirSocioId && activas[0].socio_id === excluirSocioId;
      })
      .map(p => this.mapPuesto(p));
  }

  /**
   * Puestos PRINCIPALES activos disponibles para asignar a un INQUILINO.
   * Excluye puestos ya arrendados (excepto el del inquilino en edición).
   */
  async getPuestosParaInquilinos(excluirInquilinoId?: number): Promise<PuestoDisponible[]> {
    const { data, error } = await this.db
      .from('puestos')
      .select(`
        id, codigo_puesto, tipo_espacio, giro_id, area_m2,
        giro:giros(nombre),
        titularidad_activa:historial_titularidad(socio_id, fecha_fin),
        arriendo_activo:historial_arriendos(inquilino_id, fecha_fin)
      `)
      .eq('estado', 'Activo')
      .eq('tipo_espacio', 'Principal')
      .is('deleted_at', null)
      .order('codigo_puesto');

    if (error) throw new Error(error.message);

    return ((data ?? []) as unknown as PuestoRow[])
      .filter(p => {
        const activos = p.arriendo_activo.filter(a => a.fecha_fin === null);
        if (activos.length === 0) return true;
        return !!excluirInquilinoId && activos[0].inquilino_id === excluirInquilinoId;
      })
      .map(p => this.mapPuesto(p));
  }

  /**
   * Puestos ALMACÉN activos disponibles para asignar a un TERCERO.
   * Solo almacenes sin arriendo vigente (o el del tercero en edición).
   */
  async getPuestosAlmacenParaTerceros(excluirInquilinoId?: number): Promise<PuestoDisponible[]> {
    const { data, error } = await this.db
      .from('puestos')
      .select(`
        id, codigo_puesto, tipo_espacio, giro_id, area_m2,
        giro:giros(nombre),
        titularidad_activa:historial_titularidad(socio_id, fecha_fin),
        arriendo_activo:historial_arriendos(inquilino_id, fecha_fin)
      `)
      .eq('estado', 'Activo')
      .eq('tipo_espacio', 'Almacen')
      .is('deleted_at', null)
      .order('codigo_puesto');

    if (error) throw new Error(error.message);

    return ((data ?? []) as unknown as PuestoRow[])
      .filter(p => {
        const activos = p.arriendo_activo.filter(a => a.fecha_fin === null);
        if (activos.length === 0) return true;
        return !!excluirInquilinoId && activos[0].inquilino_id === excluirInquilinoId;
      })
      .map(p => this.mapPuesto(p));
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  private mapPuesto(p: PuestoRow): PuestoDisponible {
    const titular = p.titularidad_activa?.find(t => t.fecha_fin === null);
    return {
      id:               p.id,
      codigo_puesto:    p.codigo_puesto,
      tipo_espacio:     p.tipo_espacio,
      giro_id:          p.giro_id,
      giro_nombre:      p.giro?.nombre ?? null,
      area_m2:          p.area_m2,
      socio_titular_id: titular?.socio_id ?? null,
    };
  }
}
