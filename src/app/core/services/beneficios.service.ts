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
  updated_at?: string;
}

export interface BeneficioSocioAgrupado {
  socio_id: number;
  dni: string;
  nombre_completo: string;
  total_monto: number;
  registros: BeneficioSocio[];
}

export interface BeneficioSocioUpdateInput {
  socio_id: number;
  fecha: string;
  monto: number;
  motivo: string;
  observacion?: string;
}

@Injectable({ providedIn: 'root' })
export class BeneficiosService {
  private readonly db = inject(SUPABASE_CLIENT);

  /**
   * Obtiene todos los beneficios activos de un socio específico por tipo.
   */
  async obtenerPorSocio(socioId: number, tipo: TipoBeneficio): Promise<BeneficioSocio[]> {
    const { data, error } = await this.db
      .from('beneficios_socios')
      .select('*')
      .eq('socio_id', socioId)
      .eq('tipo', tipo)
      .is('deleted_at', null)
      .order('fecha', { ascending: false })
      .order('id', { ascending: false });

    if (error) throw new Error(error.message);
    return (data as any[]).map(d => ({
      ...d,
      monto: Number(d.monto),
    }));
  }

  /**
   * Obtiene todos los beneficios activos de un año específico y tipo, agrupados por socio.
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
      .order('fecha', { ascending: false })
      .order('id', { ascending: false });

    if (error) throw new Error(error.message);

    const agrupados = new Map<number, BeneficioSocioAgrupado>();

    for (const row of data as any[]) {
      const socioId = row.socio.id;
      if (!agrupados.has(socioId)) {
        agrupados.set(socioId, {
          socio_id: socioId,
          dni: row.socio.dni,
          nombre_completo: `${row.socio.apellidos} ${row.socio.nombres}`.trim(),
          total_monto: 0,
          registros: [],
        });
      }
      const group = agrupados.get(socioId)!;
      group.registros.push({
        ...row,
        monto: Number(row.monto),
      });
      group.total_monto += Number(row.monto);
    }

    return Array.from(agrupados.values()).sort((a, b) =>
      a.nombre_completo.localeCompare(b.nombre_completo),
    );
  }

  /**
   * Crea un nuevo registro de beneficio (Dieta o Provisión Social).
   */
  async crear(beneficio: Omit<BeneficioSocio, 'id' | 'created_at' | 'updated_at'>): Promise<void> {
    const fecha = (beneficio.fecha ?? '').trim();
    const motivo = (beneficio.motivo ?? '').trim();
    const observacion = (beneficio.observacion ?? '').trim();
    const monto = Number(beneficio.monto);

    if (!fecha) {
      throw new Error('La fecha es obligatoria.');
    }
    if (!Number.isFinite(monto) || monto <= 0) {
      throw new Error('El monto debe ser mayor a cero (S/ 0.00).');
    }
    if (!motivo) {
      throw new Error(
        beneficio.tipo === 'dieta'
          ? 'El concepto o descripción es obligatorio.'
          : 'El motivo es obligatorio.',
      );
    }

    const { data: auth } = await this.db.auth.getUser();
    const userId = auth.user?.id ?? null;

    const { error } = await this.db.from('beneficios_socios').insert({
      socio_id: beneficio.socio_id,
      tipo: beneficio.tipo,
      fecha,
      monto,
      motivo,
      observacion: observacion || null,
      created_by: userId,
    });

    if (error) throw new Error(error.message);
  }

  /**
   * Edita un registro existente de Dieta o Provisión Social mediante RPC segura.
   * Restringido exclusivamente al rol Administrador en backend y con registro en audit_logs.
   */
  async editar(id: number, input: BeneficioSocioUpdateInput): Promise<void> {
    const fecha = (input.fecha ?? '').trim();
    const motivo = (input.motivo ?? '').trim();
    const observacion = (input.observacion ?? '').trim();
    const monto = Number(input.monto);

    if (!fecha) {
      throw new Error('La fecha es obligatoria.');
    }
    if (!Number.isFinite(monto) || monto <= 0) {
      throw new Error('El monto debe ser mayor a cero (S/ 0.00).');
    }
    if (!motivo) {
      throw new Error('El concepto o motivo es obligatorio.');
    }

    const { error } = await this.db.rpc('rpc_editar_beneficio_socio', {
      p_id: id,
      p_socio_id: input.socio_id,
      p_fecha: fecha,
      p_monto: monto,
      p_motivo: motivo,
      p_observacion: observacion || null,
    });

    if (error) throw new Error(error.message);
  }

  /**
   * Eliminación lógica (soft-delete) de un registro de beneficio mediante RPC segura.
   * Restringido exclusivamente al rol Administrador en backend y con registro en audit_logs.
   */
  async eliminar(id: number, socioId?: number): Promise<void> {
    const { error } = await this.db.rpc('rpc_eliminar_beneficio_socio', {
      p_id: id,
      p_socio_id: socioId ?? null,
    });

    if (error) throw new Error(error.message);
  }
}
