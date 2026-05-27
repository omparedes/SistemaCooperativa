import { inject, Injectable, signal } from '@angular/core';
import { SUPABASE_CLIENT } from '../../core/services/supabase.client';
import {
  EspacioJerarquia,
  EspacioOcupacion,
  OcupacionAlmacen,
  TipoOcupante,
  esEspacioPrincipal,
} from './espacios.model';

export interface AsignarAlmacenParams {
  puestoId:      number;
  tipoOcupante:  TipoOcupante;
  socioId?:      number;
  inquilinoId?:  number;
  fechaInicio?:  string;
}

export interface TransferirPuestoParams {
  puestoId:       number;
  nuevoSocioId:   number;
  motivo:         string;
  fechaEfectiva?: string;
}

export interface TransferirPuestoResult {
  puesto_id:                 number;
  codigo_puesto:             string;
  socio_anterior_id:         number | null;
  socio_nuevo_id:            number;
  fecha_efectiva:            string;
  tiene_deudas_pendientes:   boolean;
  deudas_pendientes_count:   number;
  deudas_pendientes_total:   number;
}

// Raw row from ocupaciones_almacenes with joins
interface OcupacionAlmacenRow {
  id: number;
  puesto_id: number;
  tipo_ocupante: TipoOcupante;
  socio_id: number | null;
  socio: { nombres: string; apellidos: string } | null;
  inquilino_id: number | null;
  inquilino: { nombres: string; apellidos: string; tipo_inquilino: string } | null;
  fecha_inicio: string;
  fecha_fin: string | null;
  motivo_cierre: string | null;
  puesto: { codigo_puesto: string } | null;
}

@Injectable({ providedIn: 'root' })
export class EspaciosService {
  private readonly db = inject(SUPABASE_CLIENT);

  private readonly _espacios = signal<EspacioOcupacion[]>([]);
  private readonly _loading  = signal(false);
  private readonly _error    = signal<string | null>(null);

  readonly espacios = this._espacios.asReadonly();
  readonly loading  = this._loading.asReadonly();
  readonly error    = this._error.asReadonly();

  // ── Carga principal ───────────────────────────────────────────────────────

  async cargar(): Promise<void> {
    this._loading.set(true);
    this._error.set(null);
    try {
      const { data, error } = await this.db
        .from('vw_espacios_con_ocupacion')
        .select('*');
      if (error) throw new Error(error.message);
      this._espacios.set((data ?? []) as EspacioOcupacion[]);
    } catch (e: unknown) {
      this._error.set(e instanceof Error ? e.message : 'Error al cargar espacios.');
    } finally {
      this._loading.set(false);
    }
  }

  /** Construye jerarquía Regular/Pequeño → [Almacenes del mismo titular]. */
  buildJerarquias(): { jerarquias: EspacioJerarquia[]; sinTitular: EspacioOcupacion[] } {
    const todos      = this._espacios();
    const principales = todos.filter(e => esEspacioPrincipal(e.tipo_espacio));
    const almacenes   = todos.filter(e => e.tipo_espacio === 'Almacen');

    const jerarquias: EspacioJerarquia[] = principales.map(p => ({
      principal: p,
      almacenes: almacenes.filter(
        a => a.titular_id !== null && a.titular_id === p.titular_id,
      ),
    }));

    const asignados = new Set(jerarquias.flatMap(j => j.almacenes.map(a => a.puesto_id)));
    const sinTitular = [
      ...principales.filter(p => p.titular_id === null),
      ...almacenes.filter(a => !asignados.has(a.puesto_id)),
    ];

    return { jerarquias, sinTitular };
  }

  // ── Toggle de servicios ───────────────────────────────────────────────────

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

  /** Actualiza optimistamente un espacio en la señal interna. */
  actualizarEspacio(id: number, patch: Partial<EspacioOcupacion>): void {
    this._espacios.update(list =>
      list.map(e => e.puesto_id === id ? { ...e, ...patch } : e),
    );
  }

  // ── Ocupaciones de Almacén ────────────────────────────────────────────────

  async getOcupacionesAlmacen(puestoId: number): Promise<OcupacionAlmacen[]> {
    const { data, error } = await this.db
      .from('ocupaciones_almacenes')
      .select(`
        id, puesto_id, tipo_ocupante, socio_id, inquilino_id,
        fecha_inicio, fecha_fin, motivo_cierre,
        socio:socios (nombres, apellidos),
        inquilino:inquilinos (nombres, apellidos, tipo_inquilino),
        puesto:puestos (codigo_puesto)
      `)
      .eq('puesto_id', puestoId)
      .order('fecha_inicio', { ascending: false });

    if (error) throw new Error(error.message);
    return ((data ?? []) as unknown as OcupacionAlmacenRow[]).map(r => this.mapOcupacion(r));
  }

  async asignarAlmacen(params: AsignarAlmacenParams): Promise<number> {
    const { data: auth } = await this.db.auth.getUser();
    const { data, error } = await this.db.rpc('rpc_asignar_almacen', {
      p_puesto_id:     params.puestoId,
      p_tipo_ocupante: params.tipoOcupante,
      p_socio_id:      params.socioId      ?? null,
      p_inquilino_id:  params.inquilinoId  ?? null,
      p_fecha_inicio:  params.fechaInicio  ?? null,
      p_usuario:       auth.user?.id       ?? null,
    });
    if (error) throw new Error(error.message);
    return (data as { id: number }).id;
  }

  async liberarAlmacen(
    ocupacionId: number,
    motivo: string,
    fechaFin?: string,
  ): Promise<void> {
    const { data: auth } = await this.db.auth.getUser();
    const { error } = await this.db.rpc('rpc_liberar_almacen', {
      p_ocupacion_id: ocupacionId,
      p_motivo:       motivo,
      p_fecha_fin:    fechaFin ?? null,
      p_usuario:      auth.user?.id ?? null,
    });
    if (error) throw new Error(error.message);
  }

  // ── Transferencia de puesto ───────────────────────────────────────────────

  async transferirPuesto(params: TransferirPuestoParams): Promise<TransferirPuestoResult> {
    const { data: auth } = await this.db.auth.getUser();
    const { data, error } = await this.db.rpc('rpc_transferir_puesto', {
      p_puesto_id:      params.puestoId,
      p_nuevo_socio_id: params.nuevoSocioId,
      p_motivo:         params.motivo,
      p_fecha_efectiva: params.fechaEfectiva ?? null,
      p_usuario:        auth.user?.id        ?? null,
    });
    if (error) throw new Error(error.message);
    return data as TransferirPuestoResult;
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  private mapOcupacion(r: OcupacionAlmacenRow): OcupacionAlmacen {
    return {
      id:                   r.id,
      puesto_id:            r.puesto_id,
      codigo_puesto:        r.puesto?.codigo_puesto ?? '',
      tipo_ocupante:        r.tipo_ocupante,
      socio_id:             r.socio_id,
      socio_nombres:        r.socio?.nombres        ?? null,
      socio_apellidos:      r.socio?.apellidos       ?? null,
      inquilino_id:         r.inquilino_id,
      inquilino_nombres:    r.inquilino?.nombres     ?? null,
      inquilino_apellidos:  r.inquilino?.apellidos   ?? null,
      tipo_inquilino:       (r.inquilino?.tipo_inquilino ?? null) as 'Inquilino' | 'Tercero' | null,
      fecha_inicio:         r.fecha_inicio,
      fecha_fin:            r.fecha_fin,
      motivo_cierre:        r.motivo_cierre,
    };
  }
}
