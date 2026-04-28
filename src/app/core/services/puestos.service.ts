import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

// ---------------------------------------------------------------------------
// Tipos públicos
// ---------------------------------------------------------------------------
export interface Giro {
  id: number;
  nombre: string;
}

export interface PuestoDisponible {
  id: number;
  codigo_puesto: string;
  giro_id: number | null;
  giro_nombre: string | null;
  area_m2: number | null;
  socio_titular_id: number | null; // titular vigente (para historial_arriendos)
}

// ---------------------------------------------------------------------------
// Tipos internos
// ---------------------------------------------------------------------------
interface GiroRow {
  id: number;
  nombre: string;
}

interface PuestoRow {
  id: number;
  codigo_puesto: string;
  giro_id: number | null;
  area_m2: number | null;
  giro: { nombre: string } | null;
  titularidad_activa: Array<{ socio_id: number; fecha_fin: string | null }>;
  arriendo_activo: Array<{ inquilino_id: number; fecha_fin: string | null }>;
}

// ---------------------------------------------------------------------------
// Servicio
// ---------------------------------------------------------------------------
@Injectable({ providedIn: 'root' })
export class PuestosService {
  private readonly db = inject(SUPABASE_CLIENT);

  /** Catálogo completo de giros ordenado por nombre. */
  async getGiros(): Promise<Giro[]> {
    const { data, error } = await this.db
      .from('giros')
      .select('id, nombre')
      .order('nombre');

    if (error) throw new Error(error.message);
    return (data ?? []) as GiroRow[];
  }

  /**
   * Puestos Activos disponibles para asignar a un SOCIO como titular.
   * Incluye el puesto actualmente asignado al socio en edición (si hay).
   * @param excluirSocioId  ID del socio en edición → su puesto aparece disponible.
   */
  async getPuestosParaSocios(excluirSocioId?: number): Promise<PuestoDisponible[]> {
    const { data, error } = await this.db
      .from('puestos')
      .select(`
        id, codigo_puesto, giro_id, area_m2,
        giro:giros(nombre),
        titularidad_activa:historial_titularidad(socio_id, fecha_fin)
      `)
      .eq('estado', 'Activo')
      .is('deleted_at', null)
      .order('codigo_puesto');

    if (error) throw new Error(error.message);

    return ((data ?? []) as unknown as PuestoRow[])
      .filter(p => {
        const activas = p.titularidad_activa.filter(t => t.fecha_fin === null);
        if (activas.length === 0) return true;
        // Disponible si el único titular activo es el socio que estamos editando
        return !!excluirSocioId && activas[0].socio_id === excluirSocioId;
      })
      .map(p => {
        const titular = p.titularidad_activa.find(t => t.fecha_fin === null);
        return {
          id:              p.id,
          codigo_puesto:   p.codigo_puesto,
          giro_id:         p.giro_id,
          giro_nombre:     p.giro?.nombre ?? null,
          area_m2:         p.area_m2,
          socio_titular_id: titular?.socio_id ?? null,
        };
      });
  }

  /**
   * Puestos Activos disponibles para asignar a un INQUILINO como arrendatario.
   * Incluye el puesto actualmente arrendado por el inquilino en edición (si hay).
   * @param excluirInquilinoId  ID del inquilino en edición → su puesto aparece disponible.
   */
  async getPuestosParaInquilinos(excluirInquilinoId?: number): Promise<PuestoDisponible[]> {
    const { data, error } = await this.db
      .from('puestos')
      .select(`
        id, codigo_puesto, giro_id, area_m2,
        giro:giros(nombre),
        titularidad_activa:historial_titularidad(socio_id, fecha_fin),
        arriendo_activo:historial_arriendos(inquilino_id, fecha_fin)
      `)
      .eq('estado', 'Activo')
      .is('deleted_at', null)
      .order('codigo_puesto');

    if (error) throw new Error(error.message);

    return ((data ?? []) as unknown as PuestoRow[])
      .filter(p => {
        const activos = p.arriendo_activo.filter(a => a.fecha_fin === null);
        if (activos.length === 0) return true;
        return !!excluirInquilinoId && activos[0].inquilino_id === excluirInquilinoId;
      })
      .map(p => {
        const titular = p.titularidad_activa.find(t => t.fecha_fin === null);
        return {
          id:               p.id,
          codigo_puesto:    p.codigo_puesto,
          giro_id:          p.giro_id,
          giro_nombre:      p.giro?.nombre ?? null,
          area_m2:          p.area_m2,
          socio_titular_id: titular?.socio_id ?? null,
        };
      });
  }
}
