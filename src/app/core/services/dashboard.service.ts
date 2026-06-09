import { computed, inject, Injectable, signal } from '@angular/core';
import { SUPABASE_CLIENT } from './supabase.client';

// ---------------------------------------------------------------------------
// Row shapes (raw Supabase responses)
// ---------------------------------------------------------------------------
interface RecaudacionRow {
  anio: number;
  mes: number;
  total_recaudado: number;
}

interface DeudaRow {
  total_saldo: number;
}

interface MorosoRow {
  persona_id: number;
  persona_tipo: 'socio' | 'inquilino';
  dni: string;
  apellidos: string;
  nombres: string;
  puesto_actual_codigo: string | null;
  cantidad_deudas_vencidas: number;
  monto_total_vencido: number;
  periodo_mas_antiguo_yyyymm: number;
}

// ---------------------------------------------------------------------------
// Public domain types
// ---------------------------------------------------------------------------
export interface MesRecaudacion {
  label: string;  // "Abr-2026"
  total: number;  // S/
}

export interface SocioMorosoResumen {
  socio_id: number; // persona_id
  persona_tipo: 'socio' | 'inquilino';
  dni: string;
  nombre_completo: string;
  codigo_puesto: string;
  cantidad_deudas: number;
  monto_vencido: number;
  periodo_mas_antiguo: string; // "May-2024"
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------
const MESES = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Set','Oct','Nov','Dic'] as const;

function formatPeriodoYYYYMM(yyyymm: number): string {
  if (!yyyymm || isNaN(yyyymm)) return '—';
  const anio = Math.floor(yyyymm / 100);
  const mes  = yyyymm % 100;
  return `${MESES[mes - 1] ?? String(mes)}-${anio}`;
}

function round2(n: number): number {
  return Math.round(n * 100) / 100;
}

// ---------------------------------------------------------------------------
// Service
// ---------------------------------------------------------------------------
@Injectable({ providedIn: 'root' })
export class DashboardService {
  private readonly db = inject(SUPABASE_CLIENT);

  // --- Estado interno ---
  private readonly _loading             = signal(false);
  private readonly _error               = signal<string | null>(null);
  private readonly _recaudacionMesAct   = signal(0);
  private readonly _deudaTotalPendiente = signal(0);
  private readonly _cantidadMorosos     = signal(0);
  private readonly _recaudacion6m       = signal<MesRecaudacion[]>([]);
  private readonly _morosos             = signal<SocioMorosoResumen[]>([]);
  private readonly _filtros             = signal({ socios: true, inquilinos: true, otros: true });

  // --- API pública ---
  readonly loading = this._loading.asReadonly();
  readonly error   = this._error.asReadonly();
  readonly morosos = this._morosos.asReadonly();
  readonly recaudacion6m = this._recaudacion6m.asReadonly();
  readonly filtros = this._filtros.asReadonly();

  /** KPIs computados para las tarjetas de resumen. */
  readonly kpis = computed(() => ({
    recaudacionMesActual:  this._recaudacionMesAct(),
    deudaTotalPendiente:   this._deudaTotalPendiente(),
    cantidadMorosos:       this._cantidadMorosos(),
  }));

  /** Actualiza los filtros de origen y recarga el dashboard */
  setFiltros(filtros: { socios: boolean; inquilinos: boolean; otros: boolean }): void {
    this._filtros.set(filtros);
    void this.cargar();
  }

  // -------------------------------------------------------------------------
  // Carga principal — dispara las 3 queries en paralelo
  // -------------------------------------------------------------------------
  async cargar(): Promise<void> {
    this._loading.set(true);
    this._error.set(null);
    try {
      await Promise.all([
        this.cargarRecaudacion(),
        this.cargarDeuda(),
        this.cargarMorosos(),
      ]);
    } catch (e: unknown) {
      this._error.set(e instanceof Error ? e.message : 'Error al cargar el dashboard');
    } finally {
      this._loading.set(false);
    }
  }

  // -------------------------------------------------------------------------
  // Query 1 — vw_recaudacion_mensual (KPI mes actual + gráfico 6 meses)
  // -------------------------------------------------------------------------
  private async cargarRecaudacion(): Promise<void> {
    const now        = new Date();
    const anioActual = now.getFullYear();
    const mesActual  = now.getMonth() + 1;

    // Últimos 6 meses (incluyendo el actual) en orden cronológico
    const meses6 = Array.from({ length: 6 }, (_, i) => {
      const d = new Date(anioActual, mesActual - 1 - (5 - i), 1);
      return { anio: d.getFullYear(), mes: d.getMonth() + 1 };
    });

    const selectedTypes: string[] = [];
    if (this._filtros().socios) selectedTypes.push('socio');
    if (this._filtros().inquilinos) selectedTypes.push('inquilino');
    if (this._filtros().otros) selectedTypes.push('otros');

    if (selectedTypes.length === 0) {
      this._recaudacion6m.set(
        meses6.map(m => ({
          label: `${MESES[m.mes - 1]}-${m.anio}`,
          total: 0,
        })),
      );
      this._recaudacionMesAct.set(0);
      return;
    }

    const { data, error } = await this.db
      .from('vw_recaudacion_mensual')
      .select('anio, mes, total_recaudado')
      .in('tipo_pagador', selectedTypes)
      .gte('anio', meses6[0].anio)
      .lte('anio', anioActual)
      .order('anio', { ascending: true })
      .order('mes',  { ascending: true });

    if (error) throw new Error(error.message);

    // Agrega por (anio, mes) — la vista devuelve 1 fila por mes+concepto+tipo
    const porMes = new Map<string, number>();
    for (const row of (data ?? []) as unknown as { anio: number, mes: number, total_recaudado: number }[]) {
      const k = `${row.anio}-${row.mes}`;
      porMes.set(k, (porMes.get(k) ?? 0) + Number(row.total_recaudado));
    }

    this._recaudacion6m.set(
      meses6.map(m => ({
        label: `${MESES[m.mes - 1]}-${m.anio}`,
        total: round2(porMes.get(`${m.anio}-${m.mes}`) ?? 0),
      })),
    );

    this._recaudacionMesAct.set(
      round2(porMes.get(`${anioActual}-${mesActual}`) ?? 0),
    );
  }

  // -------------------------------------------------------------------------
  // Query 2 — vw_deuda_filtrada (KPI deuda global con filtros)
  // -------------------------------------------------------------------------
  private async cargarDeuda(): Promise<void> {
    const selectedTypes: string[] = [];
    if (this._filtros().socios) selectedTypes.push('socio');
    if (this._filtros().inquilinos) selectedTypes.push('inquilino');
    if (this._filtros().otros) selectedTypes.push('otros');

    if (selectedTypes.length === 0) {
      this._deudaTotalPendiente.set(0);
      return;
    }

    const { data, error } = await this.db
      .from('vw_deuda_consolidada_por_tipo')
      .select('total_saldo')
      .in('tipo_deudor', selectedTypes);

    if (error) throw new Error(error.message);

    const rows  = (data ?? []) as unknown as DeudaRow[];
    const total = rows.reduce((s, r) => s + Number(r.total_saldo), 0);
    this._deudaTotalPendiente.set(round2(total));
  }

  // -------------------------------------------------------------------------
  // Query 3 — vw_morosos_filtrados (KPI conteo + tabla top 10)
  // -------------------------------------------------------------------------
  private async cargarMorosos(): Promise<void> {
    const morosoTypes: string[] = [];
    if (this._filtros().socios) morosoTypes.push('socio');
    if (this._filtros().inquilinos) morosoTypes.push('inquilino');

    if (morosoTypes.length === 0) {
      this._cantidadMorosos.set(0);
      this._morosos.set([]);
      return;
    }

    // count:'exact' devuelve el total sin traer todas las filas; limit(10) trae solo la tabla.
    const { data, count, error } = await this.db
      .from('vw_morosos_filtrados')
      .select(
        'persona_id, persona_tipo, dni, apellidos, nombres, puesto_actual_codigo, ' +
        'cantidad_deudas_vencidas, monto_total_vencido, periodo_mas_antiguo_yyyymm',
        { count: 'exact' },
      )
      .in('persona_tipo', morosoTypes)
      .order('monto_total_vencido', { ascending: false })
      .limit(10);

    if (error) throw new Error(error.message);

    const rows = (data ?? []) as unknown as MorosoRow[];
    this._cantidadMorosos.set(count ?? rows.length);

    this._morosos.set(
      rows.map(r => ({
        socio_id:         r.persona_id,
        persona_tipo:     r.persona_tipo,
        dni:              r.dni,
        nombre_completo:  `${r.apellidos}, ${r.nombres}`,
        codigo_puesto:    r.puesto_actual_codigo ?? '—',
        cantidad_deudas:  Number(r.cantidad_deudas_vencidas),
        monto_vencido:    round2(Number(r.monto_total_vencido)),
        periodo_mas_antiguo: formatPeriodoYYYYMM(Number(r.periodo_mas_antiguo_yyyymm)),
      })),
    );
  }

}
