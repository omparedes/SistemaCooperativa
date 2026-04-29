import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

// ---------------------------------------------------------------------------
// Tipos públicos
// ---------------------------------------------------------------------------
export type Segmento = 'SOCIOS' | 'INQUILINOS' | 'TODOS' | 'ESPECIFICO';

export interface ConceptoCargo {
  id: number;
  nombre: string;
  tipo: 'Fijo' | 'Variable';
  descripcion: string | null;
}

export interface AfectadosConteo {
  socios: number;
  inquilinos: number;
  total: number;
}

export interface NuevoConceptoParams {
  nombre: string;
  tipo: 'Fijo' | 'Variable';
  descripcion: string;
}

export interface GenerarCargoParams {
  concepto_id: number;
  monto: number;
  segmento: Segmento;
  anio: number;
  mes: number;
  socio_id_especifico?: number;
  inquilino_id_especifico?: number;
}

export interface ResultadoCargoSegmentado {
  segmento: string;
  periodo: { anio: number; mes: number };
  insertados_socios: number;
  insertados_inquilinos: number;
  omitidos: number;
  total_insertados: number;
}

// Row shapes
interface ConceptoRow {
  id: number;
  nombre: string;
  tipo: string;
  descripcion: string | null;
}

// ---------------------------------------------------------------------------
// Servicio
// ---------------------------------------------------------------------------
@Injectable({ providedIn: 'root' })
export class CargosExtraordinariosService {
  private readonly db = inject(SUPABASE_CLIENT);

  async getConceptos(): Promise<ConceptoCargo[]> {
    const { data, error } = await this.db
      .from('conceptos')
      .select('id, nombre, tipo, descripcion')
      .is('deleted_at', null)
      .eq('activo', true)
      .order('nombre');
    if (error) throw new Error(error.message);
    return (data ?? []) as ConceptoRow[] as ConceptoCargo[];
  }

  async crearConcepto(params: NuevoConceptoParams): Promise<ConceptoCargo> {
    const { data: authData } = await this.db.auth.getUser();
    const { data, error } = await this.db
      .from('conceptos')
      .insert({
        nombre:           params.nombre.trim(),
        tipo:             params.tipo,
        descripcion:      params.descripcion.trim() || null,
        aplica_descuento: false,
        activo:           true,
        created_by:       authData.user?.id ?? null,
      })
      .select('id, nombre, tipo, descripcion')
      .single();
    if (error) throw new Error(error.message);
    return data as ConceptoRow as ConceptoCargo;
  }

  /** Cuenta socios activos y puestos con arriendo vigente. */
  async contarAfectados(): Promise<AfectadosConteo> {
    const [sociosRes, inquilinosRes] = await Promise.all([
      this.db
        .from('socios')
        .select('id', { count: 'exact', head: true })
        .eq('estado', 'Activo')
        .is('deleted_at', null),
      this.db
        .from('historial_arriendos')
        .select('id', { count: 'exact', head: true })
        .is('fecha_fin', null),
    ]);
    const socios     = sociosRes.count     ?? 0;
    const inquilinos = inquilinosRes.count ?? 0;
    return { socios, inquilinos, total: socios + inquilinos };
  }

  async generarCargoSegmentado(params: GenerarCargoParams): Promise<ResultadoCargoSegmentado> {
    const { data: authData } = await this.db.auth.getUser();
    const { data, error } = await this.db.rpc('generar_cargo_segmentado', {
      p_concepto_id:              params.concepto_id,
      p_monto:                    params.monto,
      p_segmento:                 params.segmento,
      p_anio:                     params.anio,
      p_mes:                      params.mes,
      p_usuario:                  authData.user?.id ?? null,
      p_socio_id_especifico:      params.socio_id_especifico      ?? null,
      p_inquilino_id_especifico:  params.inquilino_id_especifico  ?? null,
    });
    if (error) throw new Error(error.message);
    return data as ResultadoCargoSegmentado;
  }
}
