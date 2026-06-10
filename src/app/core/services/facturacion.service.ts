import { inject, Injectable } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

// ---------------------------------------------------------------------------
// Tipos públicos — Medidores (legacy, mantenido para FacturacionMedidoresComponent)
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
  amperaje: string;    // string para que el input no fuerce "0" al inicio
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
  total_insertados: number;
}

// ---------------------------------------------------------------------------
// Tipos públicos — Distribución Manual Luz/Agua (00045)
// ---------------------------------------------------------------------------

/**
 * Línea editable de la tabla de distribución por puesto.
 * Se usa como modelo reactivo en el componente de distribución.
 */
export interface DistribucionDetalle {
  puesto_id: number;
  codigo_puesto: string;
  tipo_espacio: string;
  ocupante_nombre: string;
  tipo_ocupante: string | null;
  monto: number;
  observacion: string;
}

/** Encabezado de distribución mensual con sus detalles cargados. */
export interface DistribucionMensual {
  id: number | null;
  periodo_anio: number;
  periodo_mes: number;
  servicio: 'Luz' | 'Agua';
  monto_recibo_real: number;
  estado: 'Borrador' | 'En Revision' | 'Aprobado';
  detalles: DistribucionDetalle[];
}

export interface ResultadoGuardarDistribucion {
  distribucion_id: number;
  servicio: string;
  monto_recibo_real: number;
  detalles_guardados: number;
}

export interface ResultadoAprobarDistribucion {
  distribucion_id: number;
  servicio: string;
  montos_generados: number;
  montos_ya_existian: number;
}

export interface ResultadoResetearDistribucion {
  resultado: 'reseteado' | 'no_existia';
  servicio: string;
  detalles_borrados?: number;
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

// Fila de la vista vw_espacios_con_ocupacion filtrada para distribución
interface EspacioDistribucionRow {
  puesto_id: number;
  codigo_puesto: string;
  tipo_espacio: string;
  titular_apellidos: string | null;
  titular_nombres: string | null;
  inquilino_apellidos: string | null;
  inquilino_nombres: string | null;
  tipo_inquilino: string | null;
}

interface DistribucionEncabezadoRow {
  id: number;
  periodo_anio: number;
  periodo_mes: number;
  servicio: string;
  monto_recibo_real: number;
  estado: string;
  detalles: Array<{
    puesto_id: number;
    monto: number;
    observacion: string | null;
  }>;
}

// ---------------------------------------------------------------------------
// Servicio
// ---------------------------------------------------------------------------
@Injectable({ providedIn: 'root' })
export class FacturacionService {
  private readonly db = inject(SUPABASE_CLIENT);

  // -------------------------------------------------------------------------
  // Cargar puestos sin medidor (método amperaje — legacy)
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
  // Bulk save de mediciones (llama al RPC guardar_mediciones_luz_bulk — legacy)
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
    anio:             number;
    mes:              number;
    monto_admin:      number;
    monto_prevision:  number;
  }): Promise<ResultadoGeneracionFija> {
    const { data: authData } = await this.db.auth.getUser();
    const userId = authData.user?.id ?? null;

    const { data, error } = await this.db.rpc('generar_cargos_fijos_mes', {
      p_anio:           params.anio,
      p_mes:            params.mes,
      p_usuario:        userId,
      p_monto_admin:    params.monto_admin,
      p_monto_prevision: params.monto_prevision,
    });

    if (error) throw new Error(error.message);

    const r = data as {
      puestos_principales:    number;
      puestos_almacenes:      number;
      gastos_administrativos: number;
      prevision_social:       number;
      total_insertados:       number;
    };
    return {
      puestos_elegibles:      (r.puestos_principales ?? 0) + (r.puestos_almacenes ?? 0),
      gastos_administrativos: r.gastos_administrativos,
      prevision_social:       r.prevision_social,
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
      const { count: cnt2 } = await this.db
        .from('puestos')
        .select('id', { count: 'exact', head: true })
        .eq('estado', 'Activo')
        .is('deleted_at', null);
      return cnt2 ?? 0;
    }
    return count ?? 0;
  }

  // =========================================================================
  // DISTRIBUCIÓN MANUAL LUZ / AGUA (00045)
  // =========================================================================

  /**
   * Carga los puestos elegibles para distribuir el servicio indicado:
   * activos, sin deleted_at y con cobro_luz_activo / cobro_agua_activo = true.
   * Usa la vista vw_espacios_con_ocupacion para obtener el ocupante vigente.
   */
  async cargarPuestosParaDistribucion(
    servicio: 'Luz' | 'Agua',
  ): Promise<DistribucionDetalle[]> {
    const flagCol = servicio === 'Luz' ? 'cobro_luz_activo' : 'cobro_agua_activo';

    const { data, error } = await this.db
      .from('vw_espacios_con_ocupacion')
      .select(
        'puesto_id, codigo_puesto, tipo_espacio, ' +
        'titular_apellidos, titular_nombres, ' +
        'inquilino_apellidos, inquilino_nombres, tipo_inquilino',
      )
      .eq('estado', 'Activo')
      .eq(flagCol, true)
      .order('codigo_puesto', { ascending: true });

    if (error) throw new Error(error.message);

    return ((data ?? []) as unknown as EspacioDistribucionRow[]).map(row => {
      const tieneInquilino = !!row.inquilino_apellidos;
      const nombre = tieneInquilino
        ? `${row.inquilino_apellidos}, ${row.inquilino_nombres}`
        : row.titular_apellidos
          ? `${row.titular_apellidos}, ${row.titular_nombres}`
          : '— Sin ocupante —';

      return {
        puesto_id:      row.puesto_id,
        codigo_puesto:  row.codigo_puesto,
        tipo_espacio:   row.tipo_espacio,
        ocupante_nombre: nombre,
        tipo_ocupante:  tieneInquilino ? row.tipo_inquilino : 'Socio',
        monto:          0,
        observacion:    '',
      };
    });
  }

  /**
   * Carga el encabezado y detalles de una distribución existente para el
   * período indicado. Devuelve null si no existe distribución guardada.
   */
  async cargarDistribucionExistente(
    servicio: 'Luz' | 'Agua',
    anio: number,
    mes: number,
  ): Promise<DistribucionMensual | null> {
    const { data, error } = await this.db
      .from('distribuciones_mensuales')
      .select(`
        id, periodo_anio, periodo_mes, servicio,
        monto_recibo_real, estado,
        detalles:distribucion_detalles(puesto_id, monto, observacion)
      `)
      .eq('periodo_anio', anio)
      .eq('periodo_mes', mes)
      .eq('servicio', servicio)
      .maybeSingle();

    if (error) throw new Error(error.message);
    if (!data) return null;

    const row = data as unknown as DistribucionEncabezadoRow;
    return {
      id:               row.id,
      periodo_anio:     row.periodo_anio,
      periodo_mes:      row.periodo_mes,
      servicio:         row.servicio as 'Luz' | 'Agua',
      monto_recibo_real: Number(row.monto_recibo_real),
      estado:           row.estado as 'Borrador' | 'En Revision' | 'Aprobado',
      detalles:         (row.detalles ?? []).map(d => ({
        puesto_id:       d.puesto_id,
        codigo_puesto:   '',   // se cruza con la lista de puestos en el componente
        tipo_espacio:    '',
        ocupante_nombre: '',
        tipo_ocupante:   null,
        monto:           Number(d.monto),
        observacion:     d.observacion ?? '',
      })),
    };
  }

  /**
   * Llama al RPC guardar_progreso_distribucion.
   * Crea o actualiza el encabezado y hace Upsert de los detalles.
   */
  async guardarProgresoDistribucion(params: {
    servicio:         'Luz' | 'Agua';
    anio:             number;
    mes:              number;
    montoReciboReal:  number;
    detalles:         Array<{ puesto_id: number; monto: number; observacion: string }>;
  }): Promise<ResultadoGuardarDistribucion> {
    const { data: authData } = await this.db.auth.getUser();
    const userId = authData.user?.id ?? null;

    const { data, error } = await this.db.rpc('guardar_progreso_distribucion', {
      p_servicio:          params.servicio,
      p_anio:              params.anio,
      p_mes:               params.mes,
      p_monto_recibo_real: params.montoReciboReal,
      p_detalles:          params.detalles,
      p_usuario:           userId,
    });

    if (error) throw new Error(error.message);
    const r = data as { distribucion_id: number; servicio: string; monto_recibo_real: number; detalles_guardados: number };
    return {
      distribucion_id:   r.distribucion_id,
      servicio:          r.servicio,
      monto_recibo_real: Number(r.monto_recibo_real),
      detalles_guardados: r.detalles_guardados,
    };
  }

  /**
   * Llama al RPC resetear_distribucion_mensual.
   * Borra el encabezado y todos los detalles (solo si estado !== 'Aprobado').
   */
  async resetearDistribucionMensual(
    servicio: 'Luz' | 'Agua',
    anio: number,
    mes: number,
  ): Promise<ResultadoResetearDistribucion> {
    const { data, error } = await this.db.rpc('resetear_distribucion_mensual', {
      p_servicio: servicio,
      p_anio:     anio,
      p_mes:      mes,
    });

    if (error) throw new Error(error.message);
    const r = data as { resultado: 'reseteado' | 'no_existia'; servicio: string; detalles_borrados?: number };
    return {
      resultado:        r.resultado,
      servicio:         r.servicio,
      detalles_borrados: r.detalles_borrados,
    };
  }

  /**
   * Llama al RPC aprobar_distribucion_mensual.
   * Genera montos_por_cobrar y marca el encabezado como 'Aprobado'.
   */
  async aprobarDistribucionMensual(
    servicio: 'Luz' | 'Agua',
    anio: number,
    mes: number,
  ): Promise<ResultadoAprobarDistribucion> {
    const { data: authData } = await this.db.auth.getUser();
    const userId = authData.user?.id ?? null;

    const { data, error } = await this.db.rpc('aprobar_distribucion_mensual', {
      p_servicio: servicio,
      p_anio:     anio,
      p_mes:      mes,
      p_usuario:  userId,
    });

    if (error) throw new Error(error.message);
    const r = data as { distribucion_id: number; servicio: string; montos_generados: number; montos_ya_existian: number };
    return {
      distribucion_id:    r.distribucion_id,
      servicio:           r.servicio,
      montos_generados:   r.montos_generados,
      montos_ya_existian: r.montos_ya_existian,
    };
  }

  // ---------------------------------------------------------------------------
  // Alquiler de Almacenes (migración 00072)
  // ---------------------------------------------------------------------------

  async generarAlquilerAlmacenesMes(params: { anio: number; mes: number }): Promise<{
    periodo: { anio: number; mes: number };
    almacenes_procesados: number;
    cargos_generados: number;
    total_monto: number;
  }> {
    const { data: authData } = await this.db.auth.getUser();
    const userId = authData.user?.id ?? null;

    const { data, error } = await this.db.rpc('generar_alquiler_almacenes_mes', {
      p_anio:    params.anio,
      p_mes:     params.mes,
      p_usuario: userId,
    });

    if (error) throw new Error(error.message);
    return data as {
      periodo: { anio: number; mes: number };
      almacenes_procesados: number;
      cargos_generados: number;
      total_monto: number;
    };
  }

  async cargarResumenAlmacenesElegibles(): Promise<{ cantidad: number; total: number }> {
    const { data, error } = await this.db
      .from('ocupaciones_almacenes')
      .select('costo_alquiler, puestos!inner(estado, deleted_at)')
      .is('fecha_fin', null)
      .eq('puestos.estado', 'Activo')
      .is('puestos.deleted_at', null);

    if (error) throw new Error(error.message);

    const rows = (data ?? []) as { costo_alquiler: number }[];
    return {
      cantidad: rows.length,
      total:    rows.reduce((acc, r) => acc + (r.costo_alquiler ?? 0), 0),
    };
  }
}
