import { inject, Injectable, signal } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';
import {
  DNI_INSTITUCIONAL,
  SocioConPuesto,
  SocioDetalle,
  TitularidadHistorial,
} from '../../pages/socios/socio.model';

interface SocioListaRow {
  id: number;
  dni: string;
  nombres: string;
  apellidos: string;
  direccion: string | null;
  telefono: string | null;
  email: string | null;
  fecha_ingreso: string;
  estado: 'Activo' | 'Inactivo';
  habilitado: boolean;
  titularidad_vigente: Array<{
    fecha_inicio: string;
    fecha_fin: string | null;
    puesto: {
      id: number;
      codigo_puesto: string;
      estado: string;
    } | null;
  }>;
}

interface SocioDetalleRow {
  id: number;
  dni: string;
  nombres: string;
  apellidos: string;
  direccion: string | null;
  telefono: string | null;
  email: string | null;
  fecha_ingreso: string;
  estado: 'Activo' | 'Inactivo';
  habilitado: boolean;
  historial_titularidad: Array<{
    id: number;
    fecha_inicio: string;
    fecha_fin: string | null;
    motivo_cambio: string | null;
    puesto: {
      id: number;
      codigo_puesto: string;
      estado: string;
      giro: { nombre: string } | null;
    } | null;
  }>;
}

@Injectable({ providedIn: 'root' })
export class SociosService {
  private readonly db = inject(SUPABASE_CLIENT);

  private readonly _socios = signal<SocioConPuesto[]>([]);
  private readonly _loading = signal(false);
  private readonly _error = signal<string | null>(null);

  readonly socios = this._socios.asReadonly();
  readonly loading = this._loading.asReadonly();
  readonly error = this._error.asReadonly();

  private async garantizarSesion(): Promise<void> {
    const { data: actual } = await this.db.auth.getUser();
    if (actual.user) return;
    const { error } = await this.db.auth.signInAnonymously();
    if (error) throw new Error(`No se pudo iniciar sesión: ${error.message}`);
  }

  async cargar(): Promise<void> {
    this._loading.set(true);
    this._error.set(null);
    try {
      await this.garantizarSesion();

      const { data, error } = await this.db
        .from('socios')
        .select(`
          id, dni, nombres, apellidos, direccion, telefono, email,
          fecha_ingreso, estado, habilitado,
          titularidad_vigente:historial_titularidad (
            fecha_inicio, fecha_fin,
            puesto:puestos ( id, codigo_puesto, estado )
          )
        `)
        .is('deleted_at', null)
        .is('titularidad_vigente.fecha_fin', null)
        .order('apellidos', { ascending: true });

      if (error) throw new Error(error.message);

      const filas = (data ?? []) as unknown as SocioListaRow[];
      this._socios.set(filas.map(f => this.mapearLista(f)));
    } catch (e: unknown) {
      this._error.set(e instanceof Error ? e.message : 'Error al cargar socios');
    } finally {
      this._loading.set(false);
    }
  }

  async cargarDetalle(id: number): Promise<SocioDetalle> {
    await this.garantizarSesion();

    const { data, error } = await this.db
      .from('socios')
      .select(`
        id, dni, nombres, apellidos, direccion, telefono, email,
        fecha_ingreso, estado, habilitado,
        historial_titularidad (
          id, fecha_inicio, fecha_fin, motivo_cambio,
          puesto:puestos (
            id, codigo_puesto, estado,
            giro:giros ( nombre )
          )
        )
      `)
      .eq('id', id)
      .is('deleted_at', null)
      .single();

    if (error) throw new Error(error.message);
    if (!data) throw new Error(`Socio ${id} no encontrado`);

    return this.mapearDetalle(data as unknown as SocioDetalleRow);
  }

  private mapearLista(row: SocioListaRow): SocioConPuesto {
    const titularidad = row.titularidad_vigente[0] ?? null;
    const puesto = titularidad?.puesto ?? null;
    return {
      id: row.id,
      dni: row.dni,
      nombres: row.nombres,
      apellidos: row.apellidos,
      direccion: row.direccion,
      telefono: row.telefono,
      email: row.email,
      fecha_ingreso: row.fecha_ingreso,
      estado: row.estado,
      habilitado: row.habilitado,
      es_institucional: row.dni === DNI_INSTITUCIONAL,
      puesto: puesto && titularidad
        ? {
            id: puesto.id,
            codigo: puesto.codigo_puesto,
            estado: puesto.estado,
            fecha_inicio_titularidad: titularidad.fecha_inicio,
          }
        : null,
    };
  }

  private mapearDetalle(row: SocioDetalleRow): SocioDetalle {
    const titularidades: TitularidadHistorial[] = (row.historial_titularidad ?? [])
      .filter(t => t.puesto !== null)
      .map(t => ({
        id: t.id,
        fecha_inicio: t.fecha_inicio,
        fecha_fin: t.fecha_fin,
        motivo_cambio: t.motivo_cambio,
        vigente: t.fecha_fin === null,
        puesto: {
          id: t.puesto!.id,
          codigo: t.puesto!.codigo_puesto,
          estado: t.puesto!.estado,
          giro: t.puesto!.giro?.nombre ?? null,
        },
      }))
      .sort((a, b) => b.fecha_inicio.localeCompare(a.fecha_inicio));

    const puesto_vigente = titularidades.find(t => t.vigente)?.puesto ?? null;

    return {
      id: row.id,
      dni: row.dni,
      nombres: row.nombres,
      apellidos: row.apellidos,
      direccion: row.direccion,
      telefono: row.telefono,
      email: row.email,
      fecha_ingreso: row.fecha_ingreso,
      estado: row.estado,
      habilitado: row.habilitado,
      es_institucional: row.dni === DNI_INSTITUCIONAL,
      titularidades,
      puesto_vigente,
    };
  }
}
