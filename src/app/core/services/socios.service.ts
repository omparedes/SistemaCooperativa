import { inject, Injectable, signal } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';
import {
  DNI_INSTITUCIONAL,
  EstadoSocio,
  SocioConPuesto,
  SocioDetalle,
  TitularidadHistorial,
} from '../../pages/socios/socio.model';

// ---------------------------------------------------------------------------
// Parámetros de mutación
// ---------------------------------------------------------------------------
export interface NuevoSocioParams {
  nombres:       string;
  apellidos:     string;
  dni:           string;
  email:         string | null;
  telefono:      string | null;
  direccion:     string | null;
  fecha_ingreso: string;          // 'YYYY-MM-DD'
  estado:        EstadoSocio;
}

export interface ActualizarSocioParams {
  nombres?:       string;
  apellidos?:     string;
  dni?:           string;
  email?:         string | null;
  telefono?:      string | null;
  direccion?:     string | null;
  fecha_ingreso?: string;
  estado?:        EstadoSocio;
  habilitado?:    boolean;
}

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
      tipo_espacio: 'Principal' | 'Almacen';
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
      tipo_espacio: 'Principal' | 'Almacen';
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

  async cargar(): Promise<void> {
    this._loading.set(true);
    this._error.set(null);
    try {

      const { data, error } = await this.db
        .from('socios')
        .select(`
          id, dni, nombres, apellidos, direccion, telefono, email,
          fecha_ingreso, estado, habilitado,
          titularidad_vigente:historial_titularidad (
            fecha_inicio, fecha_fin,
            puesto:puestos ( id, codigo_puesto, estado, tipo_espacio )
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

    const { data, error } = await this.db
      .from('socios')
      .select(`
        id, dni, nombres, apellidos, direccion, telefono, email,
        fecha_ingreso, estado, habilitado,
        historial_titularidad (
          id, fecha_inicio, fecha_fin, motivo_cambio,
          puesto:puestos (
            id, codigo_puesto, estado, tipo_espacio,
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

  // ── CRUD ──────────────────────────────────────────────────────────────────

  /** Inserta un socio nuevo. Retorna el id generado. */
  async crear(params: NuevoSocioParams): Promise<number> {
    const { data: auth } = await this.db.auth.getUser();
    const userId = auth.user?.id ?? null;

    const { data, error } = await this.db
      .from('socios')
      .insert({ ...params, created_by: userId })
      .select('id')
      .single();

    if (error) throw new Error(error.message);
    return (data as { id: number }).id;
  }

  /** Actualiza los datos personales de un socio existente. */
  async actualizar(id: number, params: ActualizarSocioParams): Promise<void> {
    const { error } = await this.db
      .from('socios')
      .update(params)
      .eq('id', id)
      .is('deleted_at', null);

    if (error) throw new Error(error.message);
  }

  /** Soft-delete de un socio + cierre de titularidad vigente (atómico). */
  async eliminar(id: number, motivo: string): Promise<void> {
    const { data: auth } = await this.db.auth.getUser();
    const userId = auth.user?.id ?? null;

    const { error } = await this.db.rpc('rpc_eliminar_socio', {
      p_socio_id:   id,
      p_motivo:     motivo,
      p_usuario_id: userId,
    });

    if (error) throw new Error(error.message);
  }

  /**
   * Gestiona la titularidad de puesto de un socio.
   * - Si había puesto anterior, cierra esa titularidad (pone fecha_fin = hoy).
   * - Si hay nuevo puesto, inserta una nueva titularidad vigente.
   * - Soporta quitar el puesto (nuevoPuestoId = null).
   */
  /** Cierra titularidad anterior y abre la nueva en una sola transacción (atómico). */
  async gestionarTitularidad(
    socioId:          number,
    nuevoPuestoId:    number | null,
    puestoIdAnterior: number | null,
  ): Promise<void> {
    const { data: auth } = await this.db.auth.getUser();
    const userId = auth.user?.id ?? null;

    const { error } = await this.db.rpc('rpc_gestionar_titularidad', {
      p_socio_id:        socioId,
      p_nuevo_puesto_id: nuevoPuestoId,
      p_viejo_puesto_id: puestoIdAnterior,
      p_usuario_id:      userId,
    });

    if (error) throw new Error(error.message);
  }

  private mapearLista(row: SocioListaRow): SocioConPuesto {
    // Separar vigentes por tipo: Principal tiene prioridad en el campo `puesto`
    const vigentes = (row.titularidad_vigente ?? []).filter(t => t.fecha_fin === null && t.puesto !== null);
    const tPrincipal = vigentes.find(t => t.puesto!.tipo_espacio === 'Principal') ?? null;
    const tAlmacenes = vigentes.filter(t => t.puesto!.tipo_espacio === 'Almacen');

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
      puesto: tPrincipal
        ? {
            id: tPrincipal.puesto!.id,
            codigo: tPrincipal.puesto!.codigo_puesto,
            estado: tPrincipal.puesto!.estado,
            tipo_espacio: 'Principal',
            fecha_inicio_titularidad: tPrincipal.fecha_inicio,
          }
        : null,
      almacenes: tAlmacenes.map(t => ({
        id: t.puesto!.id,
        codigo: t.puesto!.codigo_puesto,
        estado: t.puesto!.estado,
        tipo_espacio: 'Almacen',
        fecha_inicio_titularidad: t.fecha_inicio,
      })),
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
          tipo_espacio: t.puesto!.tipo_espacio,
          giro: t.puesto!.giro?.nombre ?? null,
        },
      }))
      .sort((a, b) => b.fecha_inicio.localeCompare(a.fecha_inicio));

    const vigentes = titularidades.filter(t => t.vigente);
    const puesto_vigente = vigentes.find(t => t.puesto.tipo_espacio === 'Principal')?.puesto ?? null;
    const almacenes_vigentes = vigentes.filter(t => t.puesto.tipo_espacio === 'Almacen').map(t => t.puesto);

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
      almacenes_vigentes,
    };
  }
}
