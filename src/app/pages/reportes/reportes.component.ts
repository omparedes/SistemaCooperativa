import { Component, inject, OnInit, signal } from '@angular/core';
import { NgClass } from '@angular/common';
import {
  RangoReporte,
  ReporteConsolidado,
  ReportesService,
} from '../../core/services/reportes.service';
import { InventarioService } from '../../core/services/inventario.service';

// ---------------------------------------------------------------------------
// Helpers de formato
// ---------------------------------------------------------------------------
function fmtSoles(n: number): string {
  return `S/ ${n.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
}

function fmtFechaPeriodo(desde: string, hasta: string): string {
  if (desde === hasta) return fmtFechaCorta(desde);
  return `${fmtFechaCorta(desde)} al ${fmtFechaCorta(hasta)}`;
}

function fmtFechaCorta(yyyymmdd: string): string {
  const meses = ['ene','feb','mar','abr','may','jun','jul','ago','sep','oct','nov','dic'];
  const [y, m, d] = yyyymmdd.split('-').map(Number);
  return `${String(d).padStart(2,'0')} ${meses[m-1]} ${y}`;
}

const RANGO_LABELS: Record<RangoReporte, string> = {
  hoy:    'Hoy',
  semana: 'Últimos 7 días',
  mes:    'Este Mes',
  año:    'Este Año',
};

// ---------------------------------------------------------------------------
// Componente
// ---------------------------------------------------------------------------
@Component({
  selector: 'app-reportes',
  standalone: true,
  imports: [NgClass],
  template: `
    <div class="mx-auto max-w-screen-xl p-4 md:p-6">

      <!-- ── Encabezado ─────────────────────────────────────────────────── -->
      <div class="mb-6 flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
        <div>
          <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Central de Reportes</h2>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
            Visión financiera consolidada · Cooperativa Primero de Mayo
          </p>
        </div>

        <!-- Pills de rango -->
        <div class="flex items-center gap-1 rounded-xl border border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-gray-800 p-1 shrink-0">
          @for (r of rangos; track r) {
            <button
              (click)="setRango(r)"
              [ngClass]="rango() === r
                ? 'bg-white dark:bg-gray-700 text-brand-600 dark:text-brand-400 shadow-sm font-semibold'
                : 'text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-200'"
              class="rounded-lg px-3 py-1.5 text-sm transition-all whitespace-nowrap">
              {{ rangoLabel(r) }}
            </button>
          }
        </div>
      </div>

      <!-- ── Error ──────────────────────────────────────────────────────── -->
      @if (error()) {
        <div class="mb-6 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ error() }}
        </div>
      }

      <!-- ── Skeletons (cargando) ───────────────────────────────────────── -->
      @if (cargando()) {
        <div class="space-y-6">
          @for (s of [1, 2]; track s) {
            <div class="rounded-2xl border border-gray-200 bg-white p-6 dark:border-gray-700 dark:bg-gray-dark">
              <div class="h-4 w-40 rounded bg-gray-200 dark:bg-gray-700 mb-5 animate-pulse"></div>
              <div class="grid grid-cols-1 gap-4 sm:grid-cols-3">
                @for (i of [1,2,3]; track i) {
                  <div class="animate-pulse rounded-xl border border-gray-100 dark:border-gray-700 p-4">
                    <div class="h-3 w-24 rounded bg-gray-200 dark:bg-gray-700 mb-3"></div>
                    <div class="h-8 w-32 rounded bg-gray-200 dark:bg-gray-700 mb-2"></div>
                    <div class="h-3 w-20 rounded bg-gray-200 dark:bg-gray-700"></div>
                  </div>
                }
              </div>
            </div>
          }
        </div>
      }

      @if (reporte(); as r) {

        <!-- ════════════════════════════════════════════════════════════════ -->
        <!-- SECCIÓN 1: Caja Física                                          -->
        <!-- ════════════════════════════════════════════════════════════════ -->
        <section class="mb-6 rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark overflow-hidden">

          <div class="border-b border-gray-100 dark:border-gray-700 bg-gray-50 dark:bg-gray-700/30 px-6 py-4">
            <div class="flex items-center gap-3">
              <div class="flex h-9 w-9 items-center justify-center rounded-xl bg-brand-50 dark:bg-brand-900/20">
                <svg class="h-5 w-5 text-brand-600 dark:text-brand-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z"/>
                </svg>
              </div>
              <div>
                <h3 class="text-sm font-bold text-gray-800 dark:text-white uppercase tracking-wide">Resumen de Caja Física</h3>
                <p class="text-xs text-gray-400 dark:text-gray-500 mt-0.5">
                  Pagos y Gastos Operativos · {{ fmtPeriodo(r) }}
                </p>
              </div>
            </div>
          </div>

          <div class="grid grid-cols-1 divide-y sm:grid-cols-3 sm:divide-x sm:divide-y-0 divide-gray-100 dark:divide-gray-700">

            <!-- Ingresos Caja -->
            <div class="p-6">
              <div class="flex items-start justify-between">
                <div>
                  <p class="text-xs font-semibold uppercase tracking-wider text-green-600 dark:text-green-400">Ingresos</p>
                  <p class="mt-2 text-3xl font-bold tabular-nums text-green-700 dark:text-green-300">
                    {{ fmtSoles(r.caja_ingresos) }}
                  </p>
                </div>
                <div class="flex h-11 w-11 items-center justify-center rounded-xl bg-green-50 dark:bg-green-900/20 shrink-0">
                  <svg class="h-6 w-6 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/>
                  </svg>
                </div>
              </div>
              <div class="mt-3 flex flex-wrap gap-2 text-xs text-gray-400 dark:text-gray-500">
                <span class="rounded-full bg-green-50 dark:bg-green-900/20 text-green-600 dark:text-green-400 px-2 py-0.5 font-medium">
                  {{ r.caja_count_recibos }} recibo{{ r.caja_count_recibos !== 1 ? 's' : '' }}
                </span>
                @if (r.caja_count_internos > 0) {
                  <span class="rounded-full bg-violet-50 dark:bg-violet-900/20 text-violet-600 dark:text-violet-400 px-2 py-0.5 font-medium">
                    {{ r.caja_count_internos }} sin recibo
                  </span>
                }
              </div>
            </div>

            <!-- Egresos Caja -->
            <div class="p-6">
              <div class="flex items-start justify-between">
                <div>
                  <p class="text-xs font-semibold uppercase tracking-wider text-red-600 dark:text-red-400">Egresos (Gastos)</p>
                  <p class="mt-2 text-3xl font-bold tabular-nums text-red-700 dark:text-red-300">
                    {{ fmtSoles(r.caja_egresos) }}
                  </p>
                </div>
                <div class="flex h-11 w-11 items-center justify-center rounded-xl bg-red-50 dark:bg-red-900/20 shrink-0">
                  <svg class="h-6 w-6 text-red-600 dark:text-red-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M20 12H4"/>
                  </svg>
                </div>
              </div>
              <p class="mt-3 text-xs text-gray-400 dark:text-gray-500">Egresos operativos registrados</p>
            </div>

            <!-- Saldo Neto Caja -->
            <div class="p-6"
              [ngClass]="r.caja_saldo >= 0
                ? 'bg-green-50/40 dark:bg-green-900/10'
                : 'bg-red-50/40 dark:bg-red-900/10'">
              <div class="flex items-start justify-between">
                <div>
                  <p class="text-xs font-semibold uppercase tracking-wider"
                    [ngClass]="r.caja_saldo >= 0 ? 'text-brand-600 dark:text-brand-400' : 'text-red-600 dark:text-red-400'">
                    Saldo Neto
                  </p>
                  <p class="mt-2 text-3xl font-bold tabular-nums"
                    [ngClass]="r.caja_saldo >= 0 ? 'text-brand-700 dark:text-brand-300' : 'text-red-700 dark:text-red-300'">
                    {{ fmtSoles(r.caja_saldo) }}
                  </p>
                </div>
                <div class="flex h-11 w-11 items-center justify-center rounded-xl shrink-0"
                  [ngClass]="r.caja_saldo >= 0 ? 'bg-brand-50 dark:bg-brand-900/20' : 'bg-red-50 dark:bg-red-900/20'">
                  <svg class="h-6 w-6" [ngClass]="r.caja_saldo >= 0 ? 'text-brand-600 dark:text-brand-400' : 'text-red-600 dark:text-red-400'" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 7h6m0 10v-3m-3 3h.01M9 17h.01M9 14h.01M12 14h.01M15 11h.01M12 11h.01M9 11h.01M7 21h10a2 2 0 002-2V5a2 2 0 00-2-2H7a2 2 0 00-2 2v14a2 2 0 002 2z"/>
                  </svg>
                </div>
              </div>
              <p class="mt-3 text-xs"
                [ngClass]="r.caja_saldo >= 0 ? 'text-brand-500' : 'text-red-500'">
                Ingresos − Egresos del período
              </p>
            </div>

          </div>
        </section>

        <!-- ════════════════════════════════════════════════════════════════ -->
        <!-- SECCIÓN 2: Movimientos Bancarios                                -->
        <!-- ════════════════════════════════════════════════════════════════ -->
        <section class="mb-6 rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark overflow-hidden">

          <div class="border-b border-gray-100 dark:border-gray-700 bg-gray-50 dark:bg-gray-700/30 px-6 py-4">
            <div class="flex items-center gap-3">
              <div class="flex h-9 w-9 items-center justify-center rounded-xl bg-blue-50 dark:bg-blue-900/20">
                <svg class="h-5 w-5 text-blue-600 dark:text-blue-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M3 6l3 1m0 0l-3 9a5.002 5.002 0 006.001 0M6 7l3 9M6 7l6-2m6 2l3-1m-3 1l-3 9a5.002 5.002 0 006.001 0M18 7l3 9m-3-9l-6-2m0-2v2m0 16V5m0 16H9m3 0h3"/>
                </svg>
              </div>
              <div>
                <h3 class="text-sm font-bold text-gray-800 dark:text-white uppercase tracking-wide">Resumen Bancario</h3>
                <p class="text-xs text-gray-400 dark:text-gray-500 mt-0.5">
                  Movimientos en cuentas bancarias · {{ fmtPeriodo(r) }}
                  @if (r.banco_count_movimientos > 0) {
                    · <span class="text-blue-500">{{ r.banco_count_movimientos }} movimiento{{ r.banco_count_movimientos !== 1 ? 's' : '' }}</span>
                  }
                </p>
              </div>
            </div>
          </div>

          <div class="grid grid-cols-1 divide-y sm:grid-cols-3 sm:divide-x sm:divide-y-0 divide-gray-100 dark:divide-gray-700">

            <!-- Ingresos Bancarios -->
            <div class="p-6">
              <div class="flex items-start justify-between">
                <div>
                  <p class="text-xs font-semibold uppercase tracking-wider text-green-600 dark:text-green-400">Ingresos Bancarios</p>
                  <p class="mt-2 text-3xl font-bold tabular-nums text-green-700 dark:text-green-300">
                    {{ fmtSoles(r.banco_ingresos) }}
                  </p>
                </div>
                <div class="flex h-11 w-11 items-center justify-center rounded-xl bg-green-50 dark:bg-green-900/20 shrink-0">
                  <svg class="h-6 w-6 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M19 14l-7 7m0 0l-7-7m7 7V3"/>
                  </svg>
                </div>
              </div>
              <p class="mt-3 text-xs text-gray-400 dark:text-gray-500">Depósitos y transferencias entrantes</p>
            </div>

            <!-- Egresos Bancarios -->
            <div class="p-6">
              <div class="flex items-start justify-between">
                <div>
                  <p class="text-xs font-semibold uppercase tracking-wider text-red-600 dark:text-red-400">Egresos Bancarios</p>
                  <p class="mt-2 text-3xl font-bold tabular-nums text-red-700 dark:text-red-300">
                    {{ fmtSoles(r.banco_egresos) }}
                  </p>
                </div>
                <div class="flex h-11 w-11 items-center justify-center rounded-xl bg-red-50 dark:bg-red-900/20 shrink-0">
                  <svg class="h-6 w-6 text-red-600 dark:text-red-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M5 10l7-7m0 0l7 7m-7-7v18"/>
                  </svg>
                </div>
              </div>
              <p class="mt-3 text-xs text-gray-400 dark:text-gray-500">Pagos y retiros bancarios</p>
            </div>

            <!-- Saldo Neto Banco -->
            <div class="p-6"
              [ngClass]="r.banco_saldo >= 0
                ? 'bg-blue-50/40 dark:bg-blue-900/10'
                : 'bg-red-50/40 dark:bg-red-900/10'">
              <div class="flex items-start justify-between">
                <div>
                  <p class="text-xs font-semibold uppercase tracking-wider"
                    [ngClass]="r.banco_saldo >= 0 ? 'text-blue-600 dark:text-blue-400' : 'text-red-600 dark:text-red-400'">
                    Saldo Neto Banco
                  </p>
                  <p class="mt-2 text-3xl font-bold tabular-nums"
                    [ngClass]="r.banco_saldo >= 0 ? 'text-blue-700 dark:text-blue-300' : 'text-red-700 dark:text-red-300'">
                    {{ fmtSoles(r.banco_saldo) }}
                  </p>
                </div>
                <div class="flex h-11 w-11 items-center justify-center rounded-xl shrink-0"
                  [ngClass]="r.banco_saldo >= 0 ? 'bg-blue-50 dark:bg-blue-900/20' : 'bg-red-50 dark:bg-red-900/20'">
                  <svg class="h-6 w-6" [ngClass]="r.banco_saldo >= 0 ? 'text-blue-600 dark:text-blue-400' : 'text-red-600 dark:text-red-400'" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
                  </svg>
                </div>
              </div>
              <p class="mt-3 text-xs"
                [ngClass]="r.banco_saldo >= 0 ? 'text-blue-500' : 'text-red-500'">
                Ingresos − Egresos bancarios del período
              </p>
            </div>

          </div>

          @if (r.banco_count_movimientos === 0) {
            <div class="border-t border-gray-100 dark:border-gray-700 px-6 py-4 text-center text-sm text-gray-400 dark:text-gray-500">
              Sin movimientos bancarios registrados en este período.
            </div>
          }
        </section>

        <!-- ════════════════════════════════════════════════════════════════ -->
        <!-- SECCIÓN 3: Estado del Almacén                                   -->
        <!-- ════════════════════════════════════════════════════════════════ -->
        <section class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark overflow-hidden">

          <div class="border-b border-gray-100 dark:border-gray-700 bg-gray-50 dark:bg-gray-700/30 px-6 py-4">
            <div class="flex items-center gap-3">
              <div class="flex h-9 w-9 items-center justify-center rounded-xl shrink-0"
                [ngClass]="alertasStock().length > 0
                  ? 'bg-orange-50 dark:bg-orange-900/20'
                  : 'bg-green-50 dark:bg-green-900/20'">
                <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"
                  [ngClass]="alertasStock().length > 0 ? 'text-orange-600 dark:text-orange-400' : 'text-green-600 dark:text-green-400'">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 10V7m0 10l-8-4"/>
                </svg>
              </div>
              <div>
                <h3 class="text-sm font-bold text-gray-800 dark:text-white uppercase tracking-wide">Estado del Almacén</h3>
                <p class="text-xs mt-0.5"
                  [ngClass]="alertasStock().length > 0
                    ? 'text-orange-500 dark:text-orange-400'
                    : 'text-green-500 dark:text-green-400'">
                  @if (alertasStock().length > 0) {
                    {{ alertasStock().length }} producto{{ alertasStock().length !== 1 ? 's' : '' }} requieren reposición
                  } @else {
                    Todos los productos están sobre el stock mínimo
                  }
                </p>
              </div>
            </div>
          </div>

          @if (cargandoInventario()) {
            <div class="p-6 flex items-center gap-3 text-gray-400 dark:text-gray-500 text-sm">
              <span class="inline-block h-4 w-4 rounded-full border-2 border-brand-500 border-t-transparent animate-spin"></span>
              Cargando estado del almacén…
            </div>
          } @else if (alertasStock().length === 0) {
            <div class="flex flex-col items-center gap-2 py-12 text-gray-400 dark:text-gray-500">
              <svg class="h-10 w-10 text-green-400 opacity-70" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
              <p class="text-sm font-medium text-green-700 dark:text-green-400">¡Almacén en buen estado!</p>
              <p class="text-xs">Ningún producto está por debajo del stock mínimo.</p>
            </div>
          } @else {
            <div class="overflow-x-auto">
              <table class="w-full text-sm">
                <thead class="bg-orange-50/60 dark:bg-orange-900/10">
                  <tr>
                    <th class="px-5 py-3 text-left text-xs font-semibold uppercase tracking-wider text-orange-700 dark:text-orange-400">Código</th>
                    <th class="px-5 py-3 text-left text-xs font-semibold uppercase tracking-wider text-orange-700 dark:text-orange-400">Producto</th>
                    <th class="px-5 py-3 text-left text-xs font-semibold uppercase tracking-wider text-orange-700 dark:text-orange-400">Categoría</th>
                    <th class="px-5 py-3 text-center text-xs font-semibold uppercase tracking-wider text-orange-700 dark:text-orange-400">Stock Actual</th>
                    <th class="px-5 py-3 text-center text-xs font-semibold uppercase tracking-wider text-orange-700 dark:text-orange-400">Stock Mín.</th>
                    <th class="px-5 py-3 text-center text-xs font-semibold uppercase tracking-wider text-orange-700 dark:text-orange-400">Déficit</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-orange-100 dark:divide-orange-900/20">
                  @for (p of alertasStock(); track p.id) {
                    <tr class="hover:bg-orange-50/40 dark:hover:bg-orange-900/10 transition">
                      <td class="px-5 py-3 font-mono text-xs text-gray-500 dark:text-gray-400 whitespace-nowrap">{{ p.codigo }}</td>
                      <td class="px-5 py-3">
                        <p class="font-medium text-gray-800 dark:text-white">{{ p.nombre }}</p>
                        <p class="text-xs text-gray-400 dark:text-gray-500">{{ p.unidad_medida }}</p>
                      </td>
                      <td class="px-5 py-3">
                        @if (p.categoria) {
                          <span class="inline-flex items-center rounded-full bg-gray-100 dark:bg-gray-700 px-2 py-0.5 text-xs text-gray-600 dark:text-gray-300">
                            {{ p.categoria }}
                          </span>
                        } @else {
                          <span class="text-xs text-gray-300 dark:text-gray-600">—</span>
                        }
                      </td>
                      <td class="px-5 py-3 text-center">
                        <span class="text-base font-bold tabular-nums text-red-600 dark:text-red-400">
                          {{ p.stock_actual }}
                        </span>
                      </td>
                      <td class="px-5 py-3 text-center text-sm text-gray-500 dark:text-gray-400 tabular-nums">
                        {{ p.stock_minimo }}
                      </td>
                      <td class="px-5 py-3 text-center">
                        <span class="inline-flex items-center rounded-full bg-red-100 dark:bg-red-900/30 px-2.5 py-0.5 text-xs font-semibold text-red-700 dark:text-red-400">
                          −{{ +(p.stock_minimo - p.stock_actual).toFixed(3) }} {{ p.unidad_medida }}
                        </span>
                      </td>
                    </tr>
                  }
                </tbody>
              </table>
            </div>
          }
        </section>

      }
    </div>
  `,
})
export class ReportesComponent implements OnInit {
  private readonly reportesSvc   = inject(ReportesService);
  private readonly inventarioSvc = inject(InventarioService);

  // Helpers expuestos al template
  protected readonly fmtSoles = fmtSoles;

  readonly rangos: RangoReporte[] = ['hoy', 'semana', 'mes', 'año'];

  readonly rango    = signal<RangoReporte>('mes');
  readonly reporte  = signal<ReporteConsolidado | null>(null);
  readonly cargando = signal(false);
  readonly error    = signal<string | null>(null);

  readonly cargandoInventario = this.inventarioSvc.loading;
  readonly alertasStock       = this.inventarioSvc.alertasStockBajo;

  ngOnInit(): void {
    void this.cargar();
    void this.inventarioSvc.cargarProductos();
  }

  async cargar(): Promise<void> {
    this.cargando.set(true);
    this.error.set(null);
    this.reporte.set(null);   // limpia datos anteriores antes de recargar
    try {
      const r = await this.reportesSvc.cargarReporteConsolidado(this.rango());
      this.reporte.set(r);
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar el reporte');
    } finally {
      this.cargando.set(false);
    }
  }

  setRango(r: RangoReporte): void {
    this.rango.set(r);
    void this.cargar();
  }

  protected rangoLabel(r: RangoReporte): string {
    return RANGO_LABELS[r];
  }

  protected fmtPeriodo(r: ReporteConsolidado): string {
    return fmtFechaPeriodo(r.fechaDesde, r.fechaHasta);
  }
}
