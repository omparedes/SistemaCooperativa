import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

export type TipoBeneficio = 'dieta' | 'provision_social';

export interface BeneficioSocio {
  id: number;
  socio_id: number;
  tipo: TipoBeneficio;
  fecha: string;
  monto: number;
  motivo?: string;
  observacion?: string;
  created_at?: string;
}

export interface BeneficioSocioAgrupado {
  socio_id: number;
  dni: string;
  nombre_completo: string;
  total_monto: number;
  registros: BeneficioSocio[];
}

@Injectable({ providedIn: 'root' })
export class BeneficiosService {
  private readonly db = inject(SUPABASE_CLIENT);

  /**
   * Obtiene todos los beneficios de un socio específico por tipo.
   */
  async obtenerPorSocio(socioId: number, tipo: TipoBeneficio): Promise<BeneficioSocio[]> {
    const { data, error } = await this.db
      .from('beneficios_socios')
      .select('*')
      .eq('socio_id', socioId)
      .eq('tipo', tipo)
      .is('deleted_at', null)
      .order('fecha', { ascending: false });

    if (error) throw new Error(error.message);
    return (data as any[]).map(d => ({
      ...d,
      monto: Number(d.monto)
    }));
  }

  /**
   * Obtiene todos los beneficios de un año específico y tipo, agrupados por socio.
   * Útil para el módulo de reportes.
   */
  async reporteAnual(tipo: TipoBeneficio, anio: number): Promise<BeneficioSocioAgrupado[]> {
    const fechaInicio = `${anio}-01-01`;
    const fechaFin = `${anio}-12-31`;

    const { data, error } = await this.db
      .from('beneficios_socios')
      .select(`
        *,
        socio:socios (id, nombres, apellidos, dni)
      `)
      .eq('tipo', tipo)
      .gte('fecha', fechaInicio)
      .lte('fecha', fechaFin)
      .is('deleted_at', null)
      .order('fecha', { ascending: false });

    if (error) throw new Error(error.message);

    const agrupados = new Map<number, BeneficioSocioAgrupado>();

    for (const row of (data as any[])) {
      const socioId = row.socio.id;
      if (!agrupados.has(socioId)) {
        agrupados.set(socioId, {
          socio_id: socioId,
          dni: row.socio.dni,
          nombre_completo: `${row.socio.apellidos} ${row.socio.nombres}`.trim(),
          total_monto: 0,
          registros: []
        });
      }
      const group = agrupados.get(socioId)!;
      group.registros.push({
        ...row,
        monto: Number(row.monto)
      });
      group.total_monto += Number(row.monto);
    }

    return Array.from(agrupados.values()).sort((a, b) => a.nombre_completo.localeCompare(b.nombre_completo));
  }

  /**
   * Crea un nuevo registro de beneficio.
   */
  async crear(beneficio: Omit<BeneficioSocio, 'id' | 'created_at'>): Promise<void> {
    const { data: auth } = await this.db.auth.getUser();
    const userId = auth.user?.id ?? null;

    const { error } = await this.db.from('beneficios_socios').insert({
      ...beneficio,
      created_by: userId
    });

    if (error) throw new Error(error.message);
  }

  /**
   * Soft-delete de un registro de beneficio.
   */
  async eliminar(id: number): Promise<void> {
    const { data: auth } = await this.db.auth.getUser();
    const userId = auth.user?.id ?? null;

    const { error } = await this.db
      .from('beneficios_socios')
      .update({
        deleted_at: new Date().toISOString(),
        deleted_by: userId
      })
      .eq('id', id);

    if (error) throw new Error(error.message);
  }
}
