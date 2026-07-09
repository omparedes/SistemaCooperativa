import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from '../../core/services/supabase.client';

export interface SocioElectoral {
  id: number;
  dni: string;
  nombres: string;
  apellidos: string;
  estado: 'Activo' | 'Inactivo';
}

export interface VeredictoElectoral {
  socio: SocioElectoral;
  deuda_total: number;
  /** Hábil = socio Activo y deuda exactamente 0. */
  habil: boolean;
  /** Motivo de inhabilidad ('deuda' | 'inactivo' | null si es hábil). */
  motivo_inhabil: 'deuda' | 'inactivo' | null;
  ya_registrado_hoy: boolean;
}

export interface PadronElectoralItem {
  id: number;
  dni: string;
  nombres: string;
  apellidos: string;
  codigo_puesto: string | null;
}

export interface PadronElectoralMoroso extends PadronElectoralItem {
  deuda_total: number;
}

export interface PadronElectoral {
  generado_en: string;
  total_activos: number;
  habiles: PadronElectoralItem[];
  inhabilitados: PadronElectoralMoroso[];
}

function hoyLima(): string {
  const d = new Date();
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;
}

/**
 * Padrón Electoral: verifica la habilidad del socio (deuda = 0 vía la fuente
 * canónica rpc_caja_cargar_deudas) y registra asistencia a la asamblea del día.
 */
@Injectable({ providedIn: 'root' })
export class AsambleasService {
  private readonly db = inject(SUPABASE_CLIENT);

  async buscarSocios(q: string): Promise<SocioElectoral[]> {
    // Sanitizado: comas/paréntesis rompen el filtro .or() de PostgREST.
    const termino = q.trim().toUpperCase().replace(/[,()]/g, ' ').trim();
    if (!termino) return [];

    const { data, error } = await this.db
      .from('socios')
      .select('id, dni, nombres, apellidos, estado')
      .is('deleted_at', null)
      .or(`dni.ilike.%${termino}%,apellidos.ilike.%${termino}%,nombres.ilike.%${termino}%`)
      .order('apellidos')
      .limit(8);

    if (error) throw new Error(error.message);
    return (data ?? []) as SocioElectoral[];
  }

  /** Consulta la deuda consolidada (fuente canónica) y arma el veredicto. */
  async evaluarSocio(socio: SocioElectoral): Promise<VeredictoElectoral> {
    const [{ data, error }, yaRegistrado] = await Promise.all([
      this.db.rpc('rpc_caja_cargar_deudas', {
        p_puesto_id:  null,
        p_persona_id: socio.id,
        p_tipo:       'socio',
      }),
      this.yaRegistradoHoy(socio.id),
    ]);
    if (error) throw new Error(error.message);

    const deudas = (data ?? []) as Array<{ saldo_pendiente: number }>;
    const total = Math.round(deudas.reduce((s, d) => s + Number(d.saldo_pendiente), 0) * 100) / 100;

    const inactivo = socio.estado !== 'Activo';
    const habil = !inactivo && total < 0.01;

    return {
      socio,
      deuda_total: total,
      habil,
      motivo_inhabil: habil ? null : (inactivo ? 'inactivo' : 'deuda'),
      ya_registrado_hoy: yaRegistrado,
    };
  }

  private async yaRegistradoHoy(socioId: number): Promise<boolean> {
    const { data, error } = await this.db
      .from('asistencias_asamblea')
      .select('id')
      .eq('socio_id', socioId)
      .eq('fecha_asamblea', hoyLima())
      .maybeSingle();
    if (error) return false;
    return data !== null;
  }

  /** Inserta la asistencia del día (única por socio, congela habilidad y deuda). */
  async registrarAsistencia(v: VeredictoElectoral): Promise<void> {
    const { data: auth } = await this.db.auth.getUser();
    const { error } = await this.db.from('asistencias_asamblea').insert({
      socio_id:         v.socio.id,
      habil:            v.habil,
      deuda_al_momento: v.deuda_total,
      created_by:       auth.user?.id ?? null,
    });
    if (error) throw new Error(error.message);
  }

  /** Total de asistentes registrados hoy (para el contador en vivo). */
  async contarAsistentesHoy(): Promise<{ total: number; habiles: number }> {
    const { data, error } = await this.db
      .from('asistencias_asamblea')
      .select('habil')
      .eq('fecha_asamblea', hoyLima());
    if (error) throw new Error(error.message);
    const rows = (data ?? []) as Array<{ habil: boolean }>;
    return { total: rows.length, habiles: rows.filter(r => r.habil).length };
  }

  /** Padrón electoral completo: socios Activos separados en Hábiles/Inhabilitados. */
  async obtenerPadronCompleto(): Promise<PadronElectoral> {
    const { data, error } = await this.db.rpc('rpc_asambleas_padron');
    if (error) throw new Error(error.message);
    return data as PadronElectoral;
  }
}
