import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

// ---------------------------------------------------------------------------
// Tipos públicos
// ---------------------------------------------------------------------------

/** Un puesto sin medidor eléctrico, listo para ingresar amperaje. */
export interface PuestoSinMedidor {
  puesto_id: number;
  codigo_puesto: string;
  giro: string;
  titular: string;     // "APELLIDOS, Nombres"
  /** Amperaje registrado en el período cargado (null = no hay lectura previa). */
  amperaje_previo: number | null;
}

/** Línea editable en la tabla de medidores. */
export interface LecturaMedidor {
  puesto_id: number;
  codigo_puesto: string;
  giro: string;
  titular: string;
  amperaje: string;    // string para que el input no fuerze "0" al inicio
  horas_uso: number;
  dias_uso: number;
}

export interface ResultadoBulkMediciones {
  mediciones_nuevas: number;
  mediciones_ya_existian: number;
  montos_luz_generados: number;
}

export interface ResultadoGeneracionFija {
  puestos_elegibles: number;
  gastos_administrativos: number;
  prevision_social: number;
  mantenimiento: number;
  total_insertados: number;
}

// ---------------------------------------------------------------------------
// Row types internos
// ---------------------------------------------------------------------------
interface PuestoRow {
  id: number;
  codigo_puesto: string;
  giro: { nombre: string } | null;
  titular_vigente: Array<{
    fecha_fin: string | null;
    socio: { apellidos: string; nombres: string } | null;
  }>;
}

interface MedicionRow {
  puesto_id: number;
  amperaje: number;
}

// ---------------------------------------------------------------------------
// Servicio
// ---------------------------------------------------------------------------
@Injectable({ providedIn: 'root' })
export class FacturacionService {
  private readonly db = inject(SUPABASE_CLIENT);

  // -------------------------------------------------------------------------
  // Cargar puestos sin medidor (método amperaje)
  // -------------------------------------------------------------------------
  async cargarPuestosSinMedidor(): Promise<PuestoSinMedidor[]> {
    const { data, error } = await this.db
      .from('puestos')
      .select(`
        id, codigo_puesto,
        giro:giros(nombre),
        titular_vigente:historial_titularidad(
          fecha_fin,
          socio:socios(apellidos, nombres)
        )
      `)
      .eq('estado', 'Activo')
      .eq('tiene_medidor_luz', false)
      .is('deleted_at', null)
      .is('titular_vigente.fecha_fin', null)
      .order('codigo_puesto', { ascending: true });

    if (error) throw new Error(error.message);

    return ((data ?? []) as unknown as PuestoRow[]).map(row => {
      const titularidad = row.titular_vigente[0];
      const socio = titularidad?.socio;
      return {
        puesto_id:      row.id,
        codigo_puesto:  row.codigo_puesto,
        giro:           row.giro?.nombre ?? '—',
        titular:        socio ? `${socio.apellidos}, ${socio.nombres}` : '— Sin titular —',
        amperaje_previo: null,
      };
    });
  }

  // -------------------------------------------------------------------------
  // Cargar mediciones ya registradas para un período (pre-fill de la tabla)
  // -------------------------------------------------------------------------
  async cargarMedicionesExistentes(
    anio: number,
    mes: number,
  ): Promise<Map<number, number>> {
    const { data, error } = await this.db
      .from('mediciones_luz')
      .select('puesto_id, amperaje')
      .eq('periodo_anio', anio)
      .eq('periodo_mes', mes)
      .is('deleted_at', null);

    if (error) throw new Error(error.message);

    const map = new Map<number, number>();
    for (const row of (data ?? []) as unknown as MedicionRow[]) {
      map.set(row.puesto_id, Number(row.amperaje));
    }
    return map;
  }

  // -------------------------------------------------------------------------
  // Bulk save de mediciones (llama al RPC guardar_mediciones_luz_bulk)
  // -------------------------------------------------------------------------
  async guardarMedicionesLuzBulk(params: {
    lecturas:   Array<{ puesto_id: number; amperaje: number; horas_uso: number; dias_uso: number }>;
    anio:       number;
    mes:        number;
    precio_kwh: number;
  }): Promise<ResultadoBulkMediciones> {
    const { data: authData } = await this.db.auth.getUser();
    const userId = authData.user?.id ?? null;

    const { data, error } = await this.db.rpc('guardar_mediciones_luz_bulk', {
      p_lecturas:   params.lecturas,
      p_anio:       params.anio,
      p_mes:        params.mes,
      p_precio_kwh: params.precio_kwh,
      p_usuario:    userId,
    });

    if (error) throw new Error(error.message);

    const r = data as {
      mediciones_nuevas: number;
      mediciones_ya_existian: number;
      montos_luz_generados: number;
    };
    return {
      mediciones_nuevas:       r.mediciones_nuevas,
      mediciones_ya_existian:  r.mediciones_ya_existian,
      montos_luz_generados:    r.montos_luz_generados,
    };
  }

  // -------------------------------------------------------------------------
  // Generar cargos fijos del mes (llama al RPC generar_cargos_fijos_mes)
  // -------------------------------------------------------------------------
  async generarCargosFijosMes(params: {
    anio:                 number;
    mes:                  number;
    monto_admin:          number;
    monto_prevision:      number;
    monto_mantenimiento:  number;
  }): Promise<ResultadoGeneracionFija> {
    const { data: authData } = await this.db.auth.getUser();
    const userId = authData.user?.id ?? null;

    const { data, error } = await this.db.rpc('generar_cargos_fijos_mes', {
      p_anio:                 params.anio,
      p_mes:                  params.mes,
      p_usuario:              userId,
      p_monto_admin:          params.monto_admin,
      p_monto_prevision:      params.monto_prevision,
      p_monto_mantenimiento:  params.monto_mantenimiento,
    });

    if (error) throw new Error(error.message);

    const r = data as {
      puestos_elegibles:      number;
      gastos_administrativos: number;
      prevision_social:       number;
      mantenimiento:          number;
      total_insertados:       number;
    };
    return {
      puestos_elegibles:      r.puestos_elegibles,
      gastos_administrativos: r.gastos_administrativos,
      prevision_social:       r.prevision_social,
      mantenimiento:          r.mantenimiento,
      total_insertados:       r.total_insertados,
    };
  }

  // -------------------------------------------------------------------------
  // Contar puestos activos con titular activo (preview para cargos fijos)
  // -------------------------------------------------------------------------
  async contarPuestosElegibles(): Promise<number> {
    const { count, error } = await this.db
      .from('historial_titularidad')
      .select('id', { count: 'exact', head: true })
      .is('fecha_fin', null)
      .eq('puestos.estado', 'Activo')
      .eq('socios.estado', 'Activo');

    if (error) {
      // Fallback: contar sin join (aproximación)
      const { count: cnt2 } = await this.db
        .from('puestos')
        .select('id', { count: 'exact', head: true })
        .eq('estado', 'Activo')
        .is('deleted_at', null);
      return cnt2 ?? 0;
    }
    return count ?? 0;
  }
}
