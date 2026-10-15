import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

export type MetodoPagoIngreso = 'Efectivo' | 'Transferencia';
export type EstadoIngreso = 'TODOS' | 'VIGENTES' | 'ANULADOS';

export interface ConceptoSimple {
  id: number;
  nombre: string;
  grupo: 'INQUILINOS' | 'OTROS' | string;
}

export interface IngresoInternoItem {
  id: number;
  codigo_ref: string; // INT-000056
  concepto_id: number;
  concepto_nombre: string;
  concepto_grupo: string;
  monto: number;
  metodo_pago: MetodoPagoIngreso;
  observacion: string | null;
  fecha_ingreso: string; // ISO timestamptz (fecha operativa)
  created_at: string;    // ISO timestamptz (fecha técnica)
  updated_at: string;    // ISO timestamptz (concurrencia)
  created_by: string | null;
  cajero_nombre: string;
  deleted_at: string | null;
  anulado_por: string | null;
  anulado_por_nombre: string | null;
  motivo_anulacion: string | null;
  es_anulado: boolean;
}

export interface FiltrosIngresos {
  fechaDesde?: string; // YYYY-MM-DD
  fechaHasta?: string; // YYYY-MM-DD
  conceptoId?: number | null;
  metodoPago?: MetodoPagoIngreso | 'TODOS';
  estado?: EstadoIngreso;
  busqueda?: string;
}

export interface EditarIngresoParams {
  id: number;
  fecha_ingreso: string;
  monto: number;
  metodo_pago: MetodoPagoIngreso;
  concepto_id: number;
  observacion?: string | null;
  motivo: string;
  updated_at: string;
}

export interface ResumenFinancieroIngresos {
  totalVigente: number;
  totalEfectivo: number;
  totalTransferencia: number;
  cantidadVigentes: number;
  totalAnulados: number;
  cantidadAnuladas: number;
}

@Injectable({ providedIn: 'root' })
export class GestionIngresosService {
  private readonly db = inject(SUPABASE_CLIENT);

  /**
   * Obtiene los conceptos activos de los grupos INQUILINOS y OTROS.
   */
  async getConceptos(): Promise<ConceptoSimple[]> {
    const { data, error } = await this.db
      .from('conceptos')
      .select('id, nombre, grupo')
      .in('grupo', ['INQUILINOS', 'OTROS'])
      .is('deleted_at', null)
      .eq('activo', true)
      .order('grupo')
      .order('nombre');

    if (error) throw new Error(error.message);
    return (data ?? []) as ConceptoSimple[];
  }

  /**
   * Consulta los ingresos internos aplicando los filtros solicitados.
   * Resuelve los perfiles de los cajeros en lote.
   */
  async getIngresos(filtros: FiltrosIngresos): Promise<IngresoInternoItem[]> {
    let query = this.db
      .from('ingresos_internos')
      .select(`
        id,
        concepto_id,
        monto,
        metodo_pago,
        observacion,
        fecha_ingreso,
        created_at,
        updated_at,
        created_by,
        deleted_at,
        anulado_por,
        motivo_anulacion,
        concepto:conceptos(id, nombre, grupo)
      `)
      .order('fecha_ingreso', { ascending: false });

    // Filtro por fecha de operación (Lima UTC-5)
    if (filtros.fechaDesde) {
      const [y, m, d] = filtros.fechaDesde.split('-').map(Number);
      const inicio = new Date(Date.UTC(y, m - 1, d, 5, 0, 0)).toISOString();
      query = query.gte('fecha_ingreso', inicio);
    }

    if (filtros.fechaHasta) {
      const [y, m, d] = filtros.fechaHasta.split('-').map(Number);
      const fin = new Date(Date.UTC(y, m - 1, d + 1, 4, 59, 59, 999)).toISOString();
      query = query.lte('fecha_ingreso', fin);
    }

    // Filtro por concepto
    if (filtros.conceptoId) {
      query = query.eq('concepto_id', filtros.conceptoId);
    }

    // Filtro por método de pago
    if (filtros.metodoPago && filtros.metodoPago !== 'TODOS') {
      query = query.eq('metodo_pago', filtros.metodoPago);
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
    let items: IngresoInternoItem[] = rows.map((r: any) => {
      const esAnulado = r.deleted_at !== null;
      const cajero = r.created_by ? (perfilMap.get(r.created_by) ?? 'Usuario registrado') : 'Sistema';
      const anulador = r.anulado_por ? (perfilMap.get(r.anulado_por) ?? 'Administrador') : null;

      return {
        id: r.id,
        codigo_ref: `INT-${String(r.id).padStart(6, '0')}`,
        concepto_id: r.concepto_id,
        concepto_nombre: r.concepto?.nombre ?? 'Sin Concepto',
        concepto_grupo: r.concepto?.grupo ?? 'OTROS',
        monto: Number(r.monto),
        metodo_pago: r.metodo_pago as MetodoPagoIngreso,
        observacion: r.observacion,
        fecha_ingreso: r.fecha_ingreso,
        created_at: r.created_at,
        updated_at: r.updated_at,
        created_by: r.created_by,
        cajero_nombre: cajero,
        deleted_at: r.deleted_at,
        anulado_por: r.anulado_por,
        anulado_por_nombre: anulador,
        motivo_anulacion: r.motivo_anulacion,
        es_anulado: esAnulado,
      };
    });

    // Filtro por texto en memoria (cubre ID, código INT, observación y cajero)
    if (filtros.busqueda && filtros.busqueda.trim()) {
      const term = filtros.busqueda.trim().toLowerCase();
      items = items.filter(i =>
        i.id.toString().includes(term) ||
        i.codigo_ref.toLowerCase().includes(term) ||
        (i.observacion && i.observacion.toLowerCase().includes(term)) ||
        i.concepto_nombre.toLowerCase().includes(term) ||
        i.cajero_nombre.toLowerCase().includes(term)
      );
    }

    return items;
  }

  /**
   * Calcula los KPIs sobre el universo total filtrado.
   */
  calcularResumen(items: IngresoInternoItem[]): ResumenFinancieroIngresos {
    let totalVigente = 0;
    let totalEfectivo = 0;
    let totalTransferencia = 0;
    let cantidadVigentes = 0;
    let totalAnulados = 0;
    let cantidadAnuladas = 0;

    for (const item of items) {
      if (item.es_anulado) {
        totalAnulados += item.monto;
        cantidadAnuladas++;
      } else {
        totalVigente += item.monto;
        cantidadVigentes++;
        if (item.metodo_pago === 'Efectivo') {
          totalEfectivo += item.monto;
        } else {
          totalTransferencia += item.monto;
        }
      }
    }

    return {
      totalVigente,
      totalEfectivo,
      totalTransferencia,
      cantidadVigentes,
      totalAnulados,
      cantidadAnuladas,
    };
  }

  /**
   * Ejecuta la edición segura mediante la RPC dedicada con OCC.
   */
  async editarIngreso(params: EditarIngresoParams): Promise<void> {
    const { error } = await this.db.rpc('rpc_editar_ingreso_interno', {
      p_id:            params.id,
      p_fecha_ingreso: params.fecha_ingreso,
      p_monto:         params.monto,
      p_metodo_pago:   params.metodo_pago,
      p_concepto_id:   params.concepto_id,
      p_observacion:   params.observacion ?? null,
      p_motivo:        params.motivo,
      p_updated_at:    params.updated_at,
    });

    if (error) {
      throw new Error(error.message);
    }
  }

  /**
   * Ejecuta la anulación lógica segura mediante la RPC dedicada con OCC.
   */
  async anularIngreso(id: number, motivo: string, updated_at: string): Promise<void> {
    const { error } = await this.db.rpc('rpc_anular_ingreso_interno', {
      p_id:         id,
      p_motivo:     motivo,
      p_updated_at: updated_at,
    });

    if (error) {
      throw new Error(error.message);
    }
  }
}
