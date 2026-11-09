import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

export type EstadoTarjetaFiltro = 'TODOS' | 'VIGENTES' | 'ANULADOS';

export interface RecaudacionTarjetaItem {
  id: number;
  codigo_ref: string; // REC-000356
  socio_id: number;
  socio_nombre: string;
  socio_dni: string;
  socio_saldo_a_favor: number;
  codigo_puesto: string;
  monto: number;
  fecha: string;        // ISO timestamptz (fecha efectiva)
  created_at: string;   // ISO timestamptz (fecha técnica de registro)
  updated_at: string;   // ISO timestamptz (para OCC)
  created_by: string | null;
  cajero_nombre: string;
  deleted_at: string | null;
  anulado_por: string | null;
  anulado_por_nombre: string | null;
  motivo_anulacion: string | null;
  es_anulado: boolean;
}

export interface FiltrosTarjeta {
  fechaDesde?: string; // YYYY-MM-DD
  fechaHasta?: string; // YYYY-MM-DD
  estado?: EstadoTarjetaFiltro;
  busqueda?: string;
}

export interface ResumenGestionTarjeta {
  totalRecaudado: number;        // Importe total vigente del período
  totalOperaciones: number;      // Cantidad de operaciones vigentes
  sociosParticipantes: number;   // Cantidad de socios distintos con operaciones vigentes
  recaudacionesAnuladas: number; // Cantidad de operaciones anuladas en el período
  montoAnulado: number;          // Importe total anulado (informativo)
}

export interface EditarRecaudacionParams {
  id: number;
  fecha: string; // ISO timestamptz
  monto: number;
  motivo: string;
  updated_at: string;
}

export interface AuditoriaItem {
  id: string;
  action: string;
  old_data: Record<string, any> | null;
  new_data: Record<string, any> | null;
  changed_by: string | null;
  usuario_nombre?: string;
  created_at: string;
  motivo: string | null;
}

@Injectable({ providedIn: 'root' })
export class GestionTarjetaService {
  private readonly db = inject(SUPABASE_CLIENT);

  /**
   * Consulta las recaudaciones de tarjeta aplicando los filtros seleccionados.
   * Resuelve el socio, su puesto actual y los perfiles de operadores en batch.
   */
  async getRecaudaciones(filtros: FiltrosTarjeta): Promise<RecaudacionTarjetaItem[]> {
    let query = this.db
      .from('recaudacion_abonos')
      .select(`
        id,
        socio_id,
        monto,
        fecha,
        created_at,
        updated_at,
        created_by,
        deleted_at,
        anulado_por,
        motivo_anulacion,
        socio:socios(
          id,
          apellidos,
          nombres,
          dni,
          saldo_a_favor,
          historial_titularidad(
            fecha_fin,
            puesto:puestos(id, codigo_puesto)
          )
        )
      `)
      .order('fecha', { ascending: false })
      .order('id', { ascending: false });

    // Filtro por fecha de operación (Perú UTC-5)
    if (filtros.fechaDesde) {
      const [y, m, d] = filtros.fechaDesde.split('-').map(Number);
      const inicio = new Date(Date.UTC(y, m - 1, d, 5, 0, 0)).toISOString();
      query = query.gte('fecha', inicio);
    }

    if (filtros.fechaHasta) {
      const [y, m, d] = filtros.fechaHasta.split('-').map(Number);
      const fin = new Date(Date.UTC(y, m - 1, d + 1, 4, 59, 59, 999)).toISOString();
      query = query.lte('fecha', fin);
    }

    // Filtro por estado
    if (filtros.estado === 'VIGENTES') {
      query = query.is('deleted_at', null);
    } else if (filtros.estado === 'ANULADOS') {
      query = query.not('deleted_at', 'is', null);
    }

    const { data, error } = await query;
    if (error) throw new Error(error.message);

    const rows = data ?? [];

    // Recopilar usuarios para resolver nombres en batch
    const userIds = new Set<string>();
    for (const r of rows) {
      if (r.created_by) userIds.add(r.created_by);
      if (r.anulado_por) userIds.add(r.anulado_por);
    }

    const perfilMap = new Map<string, string>();
    if (userIds.size > 0) {
      const { data: perfiles } = await this.db
        .from('perfiles')
        .select('id, nombres, email')
        .in('id', [...userIds]);

      for (const p of perfiles ?? []) {
        perfilMap.set(p.id, p.nombres || p.email || '—');
      }
    }

    // Mapeo a items de dominio
    let items: RecaudacionTarjetaItem[] = rows.map((r: any) => {
      const esAnulado = r.deleted_at !== null;
      const cajero = r.created_by ? (perfilMap.get(r.created_by) ?? 'Operador') : 'Sistema';
      const anulador = r.anulado_por ? (perfilMap.get(r.anulado_por) ?? 'Administrador') : null;

      const socioData = r.socio;
      let socioNombre = '—';
      let socioDni = '—';
      let socioSaldo = 0;
      let codigoPuesto = '—';

      if (socioData) {
        socioDni = socioData.dni ?? '—';
        socioSaldo = Number(socioData.saldo_a_favor ?? 0);
        const ap = (socioData.apellidos ?? '').trim();
        const nom = (socioData.nombres ?? '').trim();
        socioNombre = ap && nom ? `${ap}, ${nom}` : (ap || nom || '—');

        const titularidades = (socioData.historial_titularidad ?? []) as Array<any>;
        const titularidadActiva = titularidades.find(t => t?.fecha_fin === null) ?? titularidades[0];
        if (titularidadActiva?.puesto?.codigo_puesto) {
          codigoPuesto = titularidadActiva.puesto.codigo_puesto;
        }
      }

      return {
        id: r.id,
        codigo_ref: `REC-${String(r.id).padStart(6, '0')}`,
        socio_id: r.socio_id,
        socio_nombre: socioNombre,
        socio_dni: socioDni,
        socio_saldo_a_favor: socioSaldo,
        codigo_puesto: codigoPuesto,
        monto: Number(r.monto),
        fecha: r.fecha,
        created_at: r.created_at,
        updated_at: r.updated_at ?? r.created_at,
        created_by: r.created_by,
        cajero_nombre: cajero,
        deleted_at: r.deleted_at,
        anulado_por: r.anulado_por,
        anulado_por_nombre: anulador,
        motivo_anulacion: r.motivo_anulacion,
        es_anulado: esAnulado,
      };
    });

    // Filtro por texto en memoria (Socio, DNI, Puesto, ID / REC)
    if (filtros.busqueda && filtros.busqueda.trim()) {
      const term = filtros.busqueda.trim().toLowerCase();
      items = items.filter(i =>
        i.id.toString().includes(term) ||
        i.codigo_ref.toLowerCase().includes(term) ||
        i.socio_nombre.toLowerCase().includes(term) ||
        i.socio_dni.toLowerCase().includes(term) ||
        i.codigo_puesto.toLowerCase().includes(term) ||
        i.cajero_nombre.toLowerCase().includes(term)
      );
    }

    return items;
  }

  /**
   * Calcula los KPIs sobre el universo filtrado.
   */
  calcularResumen(items: RecaudacionTarjetaItem[]): ResumenGestionTarjeta {
    let totalRecaudado = 0;
    let totalOperaciones = 0;
    let montoAnulado = 0;
    let recaudacionesAnuladas = 0;
    const sociosUnicos = new Set<number>();

    for (const item of items) {
      if (item.es_anulado) {
        montoAnulado += item.monto;
        recaudacionesAnuladas++;
      } else {
        totalRecaudado += item.monto;
        totalOperaciones++;
        sociosUnicos.add(item.socio_id);
      }
    }

    return {
      totalRecaudado: Math.round(totalRecaudado * 100) / 100,
      totalOperaciones,
      sociosParticipantes: sociosUnicos.size,
      recaudacionesAnuladas,
      montoAnulado: Math.round(montoAnulado * 100) / 100,
    };
  }

  /**
   * Ejecuta la edición segura y atómica mediante la RPC dedicada con OCC.
   */
  async editarRecaudacion(params: EditarRecaudacionParams): Promise<void> {
    const { error } = await this.db.rpc('rpc_editar_recaudacion_abono', {
      p_id:         params.id,
      p_fecha:      params.fecha,
      p_monto:      params.monto,
      p_motivo:     params.motivo,
      p_updated_at: params.updated_at,
    });

    if (error) {
      throw new Error(error.message);
    }
  }

  /**
   * Ejecuta la anulación lógica segura y atómica mediante la RPC dedicada con OCC.
   */
  async anularRecaudacion(id: number, motivo: string, updated_at: string): Promise<void> {
    const { error } = await this.db.rpc('rpc_anular_recaudacion_abono', {
      p_id:         id,
      p_motivo:     motivo,
      p_updated_at: updated_at,
    });

    if (error) {
      throw new Error(error.message);
    }
  }

  /**
   * Obtiene el historial de auditoría de un registro específico de recaudación.
   */
  async getHistorialAuditoria(recaudacionId: number): Promise<AuditoriaItem[]> {
    const { data, error } = await this.db
      .from('audit_logs')
      .select('id, action, old_data, new_data, changed_by, created_at, motivo')
      .eq('table_name', 'recaudacion_abonos')
      .eq('record_id', String(recaudacionId))
      .order('created_at', { ascending: false });

    if (error) {
      // Si la tabla audit_logs no está disponible o no tiene permisos, no bloqueamos el visor
      return [];
    }

    const rows = data ?? [];
    const userIds = new Set<string>();
    rows.forEach(r => { if (r.changed_by) userIds.add(r.changed_by); });

    const perfilMap = new Map<string, string>();
    if (userIds.size > 0) {
      const { data: perfiles } = await this.db
        .from('perfiles')
        .select('id, nombres, email')
        .in('id', [...userIds]);

      for (const p of perfiles ?? []) {
        perfilMap.set(p.id, p.nombres || p.email || '—');
      }
    }

    return rows.map((r: any) => ({
      id: r.id,
      action: r.action,
      old_data: r.old_data,
      new_data: r.new_data,
      changed_by: r.changed_by,
      usuario_nombre: r.changed_by ? (perfilMap.get(r.changed_by) ?? 'Usuario registrado') : 'Sistema',
      created_at: r.created_at,
      motivo: r.motivo,
    }));
  }
}
