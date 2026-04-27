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
  total_general: number;
}

interface MorosoRow {
  socio_id: number;
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
  socio_id: number;
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

  // --- API pública ---
  readonly loading = this._loading.asReadonly();
  readonly error   = this._error.asReadonly();
  readonly morosos = this._morosos.asReadonly();
  readonly recaudacion6m = this._recaudacion6m.asReadonly();

  /** KPIs computados para las tarjetas de resumen. */
  readonly kpis = computed(() => ({
    recaudacionMesActual:  this._recaudacionMesAct(),
    deudaTotalPendiente:   this._deudaTotalPendiente(),
    cantidadMorosos:       this._cantidadMorosos(),
  }));

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

    // Filtramos por año: añadimos lte para no traer años futuros.
    // Los meses fuera de la ventana de 6 son ignorados por el Map
    // (precisión exacta requeriría anio*100+mes que PostgREST no computa
    // directamente sin RPC — esta es la solución pragmática sin sobrecarga).
    const { data, error } = await this.db
      .from('vw_recaudacion_mensual')
      .select('anio, mes, total_recaudado')
      .gte('anio', meses6[0].anio)
      .lte('anio', anioActual)
      .order('anio', { ascending: true })
      .order('mes',  { ascending: true });

    if (error) throw new Error(error.message);

    // Agrega por (anio, mes) — la vista devuelve 1 fila por mes+concepto
    const porMes = new Map<string, number>();
    for (const row of (data ?? []) as unknown as RecaudacionRow[]) {
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
  // Query 2 — vw_deuda_total_por_puesto (KPI deuda global)
  // -------------------------------------------------------------------------
  private async cargarDeuda(): Promise<void> {
    const { data, error } = await this.db
      .from('vw_deuda_total_por_puesto')
      .select('total_general');

    if (error) throw new Error(error.message);

    const rows  = (data ?? []) as unknown as DeudaRow[];
    const total = rows.reduce((s, r) => s + Number(r.total_general), 0);
    this._deudaTotalPendiente.set(round2(total));
  }

  // -------------------------------------------------------------------------
  // Query 3 — vw_socios_morosos (KPI conteo + tabla top 10)
  // -------------------------------------------------------------------------
  private async cargarMorosos(): Promise<void> {
    const { data, error } = await this.db
      .from('vw_socios_morosos')
      .select(
        'socio_id, dni, apellidos, nombres, puesto_actual_codigo, ' +
        'cantidad_deudas_vencidas, monto_total_vencido, periodo_mas_antiguo_yyyymm',
      )
      .order('monto_total_vencido', { ascending: false });

    if (error) throw new Error(error.message);

    const rows = (data ?? []) as unknown as MorosoRow[];
    this._cantidadMorosos.set(rows.length);

    this._morosos.set(
      rows.slice(0, 10).map(r => ({
        socio_id:         r.socio_id,
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
