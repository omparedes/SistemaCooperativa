import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from '../../core/services/supabase.client';
import { AbonoLog, ResultadoRecaudacion, SocioTarjeta } from './recaudacion.model';

interface SocioRow {
  id: number;
  apellidos: string;
  dni: string;
  estado: string;
  saldo_a_favor: number;
  usa_recaudacion_tarjeta: boolean;
  historial_titularidad: Array<{
    puesto: { id: number; codigo_puesto: string } | null;
  }>;
}

interface AbonoRow {
  id: number;
  socio_id: number;
  monto: number;
  fecha: string;
  deleted_at: string | null;
  socio: { apellidos: string } | null;
}

@Injectable({ providedIn: 'root' })
export class RecaudacionService {
  private readonly db = inject(SUPABASE_CLIENT);

  // ── Listar socios con tarjeta activa ──────────────────────────────────────
  async listarConTarjeta(): Promise<SocioTarjeta[]> {
    const { data, error } = await this.db
      .from('socios')
      .select(`
        id, apellidos, dni, estado, saldo_a_favor, usa_recaudacion_tarjeta,
        historial_titularidad!inner(
          puesto:puestos(id, codigo_puesto)
        )
      `)
      .is('deleted_at', null)
      .eq('estado', 'Activo')
      .eq('usa_recaudacion_tarjeta', true)
      .is('historial_titularidad.fecha_fin', null)
      .order('apellidos');

    if (error) throw new Error(error.message);
    return ((data ?? []) as unknown as SocioRow[]).map(r => ({
      id: r.id,
      apellidos: r.apellidos,
      dni: r.dni,
      estado: r.estado,
      saldo_a_favor: Number(r.saldo_a_favor ?? 0),
      usa_recaudacion_tarjeta: r.usa_recaudacion_tarjeta,
      codigo_puesto: r.historial_titularidad[0]?.puesto?.codigo_puesto,
      puesto_id: r.historial_titularidad[0]?.puesto?.id,
    }));
  }

  // ── Listar TODOS los socios activos (para gestión de participantes) ────────
  async listarTodosParaGestion(): Promise<SocioTarjeta[]> {
    const { data, error } = await this.db
      .from('socios')
      .select(`
        id, apellidos, dni, estado, saldo_a_favor, usa_recaudacion_tarjeta,
        historial_titularidad(
          puesto:puestos(id, codigo_puesto)
        )
      `)
      .is('deleted_at', null)
      .eq('estado', 'Activo')
      .is('historial_titularidad.fecha_fin', null)
      .order('apellidos');

    if (error) throw new Error(error.message);
    return ((data ?? []) as unknown as SocioRow[]).map(r => ({
      id: r.id,
      apellidos: r.apellidos,
      dni: r.dni,
      estado: r.estado,
      saldo_a_favor: Number(r.saldo_a_favor ?? 0),
      usa_recaudacion_tarjeta: r.usa_recaudacion_tarjeta,
      codigo_puesto: r.historial_titularidad[0]?.puesto?.codigo_puesto,
      puesto_id: r.historial_titularidad[0]?.puesto?.id,
    }));
  }

  // ── Toggle participación ──────────────────────────────────────────────────
  async toggleTarjeta(socioId: number, activo: boolean): Promise<void> {
    const { error } = await this.db
      .from('socios')
      .update({ usa_recaudacion_tarjeta: activo })
      .eq('id', socioId);
    if (error) throw new Error(error.message);
  }

  // ── Registrar recaudación masiva ──────────────────────────────────────────
  async registrarRecaudacion(
    abonos: { socio_id: number; monto: number }[],
    fecha: string,
  ): Promise<ResultadoRecaudacion> {
    const userId = (await this.db.auth.getUser()).data.user?.id ?? null;
    const fechaIso = new Date(fecha + 'T12:00:00').toISOString();

    const { data, error } = await this.db.rpc('rpc_recaudacion_masiva', {
      p_abonos:  abonos,
      p_fecha:   fechaIso,
      p_user_id: userId,
    });
    if (error) throw new Error(error.message);
    return data as unknown as ResultadoRecaudacion;
  }

  // ── Historial de abonos recientes (últimos 30 días) ───────────────────────
  async listarAbonos(limite = 50): Promise<AbonoLog[]> {
    const { data, error } = await this.db
      .from('recaudacion_abonos')
      .select(`
        id, socio_id, monto, fecha, deleted_at,
        socio:socios(apellidos)
      `)
      .is('deleted_at', null)
      .order('fecha', { ascending: false })
      .limit(limite);

    if (error) throw new Error(error.message);
    return ((data ?? []) as unknown as AbonoRow[]).map(r => ({
      id: r.id,
      socio_id: r.socio_id,
      nombre_socio: r.socio?.apellidos ?? '—',
      monto: Number(r.monto),
      fecha: r.fecha,
      deleted_at: r.deleted_at,
    }));
  }
}
