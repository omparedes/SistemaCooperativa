import { Component, computed, inject, OnInit } from '@angular/core';
import { RouterLink } from '@angular/router';
import {
  NgApexchartsModule,
  ApexAxisChartSeries,
  ApexChart,
  ApexXAxis,
  ApexYAxis,
  ApexDataLabels,
  ApexPlotOptions,
  ApexStroke,
  ApexGrid,
  ApexFill,
  ApexTooltip,
} from 'ng-apexcharts';
import { DashboardService } from '../../core/services/dashboard.service';

// Formatea un número como moneda peruana sin librerías externas
function fmtSoles(n: number): string {
  return 'S/ ' + n.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [RouterLink, NgApexchartsModule],
  template: `
    <div class="mx-auto max-w-screen-xl p-4 md:p-6 2xl:p-10">

      <!-- ── Encabezado ─────────────────────────────────────────────────── -->
      <div class="mb-6 flex items-center justify-between">
        <div>
          <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Dashboard Gerencial</h2>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
            Cooperativa Primero de Mayo — Resumen financiero en tiempo real
          </p>
        </div>
        <button
          (click)="recargar()"
          [disabled]="dashService.loading()"
          class="flex items-center gap-2 rounded-lg border border-gray-300 px-4 py-2 text-sm font-medium text-gray-600 transition hover:bg-gray-50 disabled:opacity-50 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700">
          <svg class="h-4 w-4" [class.animate-spin]="dashService.loading()" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
          </svg>
          Actualizar
        </button>
      </div>

      <!-- ── Error global ──────────────────────────────────────────────── -->
      @if (dashService.error()) {
        <div class="mb-6 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ dashService.error() }}
        </div>
      }

      <!-- ════════════════════════════════════════════════════════════════ -->
      <!-- FILA 1 — KPI Cards                                              -->
      <!-- ════════════════════════════════════════════════════════════════ -->
      <div class="mb-6 grid grid-cols-1 gap-4 sm:grid-cols-3">

        <!-- KPI 1: Recaudación Mes Actual -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
          @if (dashService.loading()) {
            <div class="animate-pulse space-y-3">
              <div class="h-3 w-28 rounded bg-gray-200 dark:bg-gray-700"></div>
              <div class="h-8 w-36 rounded bg-gray-200 dark:bg-gray-700"></div>
            </div>
          } @else {
            <div class="flex items-start justify-between gap-3">
              <div class="flex-1 min-w-0">
                <p class="text-xs font-medium uppercase tracking-wider text-gray-400 dark:text-gray-500">
                  Recaudación Mes Actual
                </p>
                <p class="mt-2 truncate text-2xl font-bold text-gray-900 dark:text-white">
                  {{ fmtSoles(dashService.kpis().recaudacionMesActual) }}
                </p>
                <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">{{ mesActualLabel }}</p>
              </div>
              <div class="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-green-50 dark:bg-green-900/20">
                <svg class="h-6 w-6 text-green-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12c-.725 0-1.45-.22-2.003-.659-1.106-.879-1.106-2.303 0-3.182s2.9-.879 4.006 0l.415.33M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
              </div>
            </div>
            <div class="mt-4 flex items-center gap-1.5">
              <span class="rounded-full bg-green-100 px-2 py-0.5 text-xs font-medium text-green-600 dark:bg-green-900/30 dark:text-green-400">
                Pagos registrados en Supabase
              </span>
            </div>
          }
        </div>

        <!-- KPI 2: Deuda Total Pendiente -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
          @if (dashService.loading()) {
            <div class="animate-pulse space-y-3">
              <div class="h-3 w-28 rounded bg-gray-200 dark:bg-gray-700"></div>
              <div class="h-8 w-36 rounded bg-gray-200 dark:bg-gray-700"></div>
            </div>
          } @else {
            <div class="flex items-start justify-between gap-3">
              <div class="flex-1 min-w-0">
                <p class="text-xs font-medium uppercase tracking-wider text-gray-400 dark:text-gray-500">
                  Deuda Total Pendiente
                </p>
                <p class="mt-2 truncate text-2xl font-bold text-gray-900 dark:text-white">
                  {{ fmtSoles(dashService.kpis().deudaTotalPendiente) }}
                </p>
                <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">En todos los puestos activos</p>
              </div>
              <div class="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-red-50 dark:bg-red-900/20">
                <svg class="h-6 w-6 text-red-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"/>
                </svg>
              </div>
            </div>
            <div class="mt-4 flex items-center gap-1.5">
              <span class="rounded-full bg-red-100 px-2 py-0.5 text-xs font-medium text-red-600 dark:bg-red-900/30 dark:text-red-400">
                Saldo pendiente de cobro
              </span>
            </div>
          }
        </div>

        <!-- KPI 3: Socios Morosos -->
        <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
          @if (dashService.loading()) {
            <div class="animate-pulse space-y-3">
              <div class="h-3 w-28 rounded bg-gray-200 dark:bg-gray-700"></div>
              <div class="h-8 w-20 rounded bg-gray-200 dark:bg-gray-700"></div>
            </div>
          } @else {
            <div class="flex items-start justify-between gap-3">
              <div class="flex-1 min-w-0">
                <p class="text-xs font-medium uppercase tracking-wider text-gray-400 dark:text-gray-500">
                  Socios Morosos
                </p>
                <p class="mt-2 text-2xl font-bold text-gray-900 dark:text-white">
                  {{ dashService.kpis().cantidadMorosos }}
                  <span class="text-base font-normal text-gray-400">puestos</span>
                </p>
                <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">Con ≥ 1 deuda de períodos anteriores</p>
              </div>
              <div class="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-amber-50 dark:bg-amber-900/20">
                <svg class="h-6 w-6 text-amber-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 018.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0111.964-3.07M12 6.375a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm8.25 2.25a2.625 2.625 0 11-5.25 0 2.625 2.625 0 015.25 0z"/>
                </svg>
              </div>
            </div>
            <div class="mt-4">
              <span class="rounded-full bg-amber-100 px-2 py-0.5 text-xs font-medium text-amber-600 dark:bg-amber-900/30 dark:text-amber-400">
                Inhábiles para asamblea
              </span>
            </div>
          }
        </div>
      </div>

      <!-- ════════════════════════════════════════════════════════════════ -->
      <!-- FILA 2 — Gráfico Recaudación Últimos 6 Meses                   -->
      <!-- ════════════════════════════════════════════════════════════════ -->
      <div class="mb-6 rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
        <div class="mb-5 flex items-center justify-between">
          <div>
            <h3 class="text-base font-semibold text-gray-800 dark:text-white">
              Recaudación — Últimos 6 meses
            </h3>
            <p class="mt-0.5 text-xs text-gray-400 dark:text-gray-500">
              Total cobrado por mes (todas las categorías)
            </p>
          </div>
          <span class="rounded-full border border-brand-200 bg-brand-50 px-3 py-1 text-xs font-medium text-brand-600 dark:border-brand-800 dark:bg-brand-900/20 dark:text-brand-400">
            ApexCharts
          </span>
        </div>

        @if (dashService.loading()) {
          <!-- Skeleton del gráfico -->
          <div class="flex h-64 animate-pulse items-end gap-3 px-4">
            @for (i of [40, 65, 30, 80, 55, 90]; track i) {
              <div class="flex-1 rounded-t-md bg-gray-200 dark:bg-gray-700" [style.height.%]="i"></div>
            }
          </div>
        } @else if (chartSeries()[0]?.data?.length) {
          <apx-chart
            [series]="chartSeries()"
            [chart]="chartConfig"
            [xaxis]="chartXAxis()"
            [yaxis]="chartYAxis"
            [dataLabels]="chartDataLabels"
            [plotOptions]="chartPlotOptions"
            [colors]="chartColors"
            [grid]="chartGrid"
            [fill]="chartFill"
            [tooltip]="chartTooltip"
            [stroke]="chartStroke"
          ></apx-chart>
        } @else {
          <div class="flex h-64 flex-col items-center justify-center gap-2 text-gray-400 dark:text-gray-500">
            <svg class="h-10 w-10 opacity-40" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M3 13.125C3 12.504 3.504 12 4.125 12h2.25c.621 0 1.125.504 1.125 1.125v6.75C7.5 20.496 6.996 21 6.375 21h-2.25A1.125 1.125 0 013 19.875v-6.75zM9.75 8.625c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125v11.25c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V8.625zM16.5 4.125c0-.621.504-1.125 1.125-1.125h2.25C20.496 3 21 3.504 21 4.125v15.75c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V4.125z"/>
            </svg>
            <p class="text-sm">Sin datos de recaudación en los últimos 6 meses</p>
          </div>
        }
      </div>

      <!-- ════════════════════════════════════════════════════════════════ -->
      <!-- FILA 3 — Tabla Top 10 Morosos                                  -->
      <!-- ════════════════════════════════════════════════════════════════ -->
      <div class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark">
        <div class="flex items-center justify-between border-b border-gray-200 px-5 py-4 dark:border-gray-700">
          <div>
            <h3 class="text-base font-semibold text-gray-800 dark:text-white">
              Top 10 — Mayores Deudas Vencidas
            </h3>
            <p class="mt-0.5 text-xs text-gray-400 dark:text-gray-500">
              Puestos con mayor deuda en períodos anteriores · Ordenados por monto
            </p>
          </div>
          <a routerLink="/socios"
             class="rounded-lg border border-gray-300 px-3 py-1.5 text-xs font-medium text-gray-600 transition hover:bg-gray-50 dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700">
            Ver todos los socios →
          </a>
        </div>

        @if (dashService.loading()) {
          <!-- Skeleton filas -->
          <div class="divide-y divide-gray-100 dark:divide-gray-700">
            @for (i of [1,2,3,4,5]; track i) {
              <div class="flex animate-pulse gap-4 px-5 py-4">
                <div class="h-4 flex-1 rounded bg-gray-200 dark:bg-gray-700"></div>
                <div class="h-4 w-16 rounded bg-gray-200 dark:bg-gray-700"></div>
                <div class="h-4 w-24 rounded bg-gray-200 dark:bg-gray-700"></div>
              </div>
            }
          </div>
        } @else if (dashService.morosos().length === 0) {
          <div class="flex flex-col items-center justify-center gap-2 py-16 text-gray-400 dark:text-gray-500">
            <svg class="h-10 w-10 opacity-40" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
            </svg>
            <p class="text-sm font-medium text-green-600 dark:text-green-400">¡Sin socios morosos! Todos al día.</p>
          </div>
        } @else {
          <div class="overflow-x-auto">
            <table class="w-full text-left text-sm">
              <thead>
                <tr class="bg-gray-50 dark:bg-gray-700/40">
                  <th class="px-5 py-3.5 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">#</th>
                  <th class="px-5 py-3.5 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Socio / Puesto</th>
                  <th class="px-5 py-3.5 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Deudas</th>
                  <th class="px-5 py-3.5 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Monto vencido</th>
                  <th class="px-5 py-3.5 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Desde</th>
                  <th class="px-5 py-3.5"></th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                @for (s of dashService.morosos(); track s.socio_id; let idx = $index) {
                  <tr class="transition hover:bg-gray-50 dark:hover:bg-gray-700/30">

                    <!-- Ranking -->
                    <td class="px-5 py-4">
                      <span class="flex h-6 w-6 items-center justify-center rounded-full text-xs font-bold"
                            [class]="idx === 0 ? 'bg-red-100 text-red-600 dark:bg-red-900/30 dark:text-red-400'
                                   : idx === 1 ? 'bg-orange-100 text-orange-600 dark:bg-orange-900/30 dark:text-orange-400'
                                   : idx === 2 ? 'bg-amber-100 text-amber-600 dark:bg-amber-900/30 dark:text-amber-400'
                                   : 'bg-gray-100 text-gray-500 dark:bg-gray-700 dark:text-gray-400'">
                        {{ idx + 1 }}
                      </span>
                    </td>

                    <!-- Nombre + DNI + Puesto -->
                    <td class="px-5 py-4">
                      <p class="font-medium text-gray-900 dark:text-white leading-tight">{{ s.nombre_completo }}</p>
                      <div class="mt-1 flex items-center gap-2">
                        <span class="text-xs text-gray-400">DNI {{ s.dni }}</span>
                        <span class="rounded-full bg-brand-50 px-2 py-0.5 text-xs font-medium text-brand-600 dark:bg-brand-900/20 dark:text-brand-400">
                          P-{{ s.codigo_puesto }}
                        </span>
                      </div>
                    </td>

                    <!-- Cant. deudas -->
                    <td class="px-5 py-4">
                      <span class="inline-flex h-7 w-7 items-center justify-center rounded-full bg-red-50 text-xs font-bold text-red-500 dark:bg-red-900/20 dark:text-red-400">
                        {{ s.cantidad_deudas }}
                      </span>
                    </td>

                    <!-- Monto -->
                    <td class="px-5 py-4">
                      <span class="text-base font-bold text-red-500 dark:text-red-400">
                        {{ fmtSoles(s.monto_vencido) }}
                      </span>
                    </td>

                    <!-- Período más antiguo -->
                    <td class="px-5 py-4">
                      <span class="rounded-full border border-gray-200 px-2.5 py-1 text-xs text-gray-500 dark:border-gray-600 dark:text-gray-400">
                        {{ s.periodo_mas_antiguo }}
                      </span>
                    </td>

                    <!-- Acción -->
                    <td class="px-5 py-4 text-right">
                      <a [routerLink]="['/socios', s.socio_id]"
                         class="inline-flex items-center gap-1 rounded-lg border border-brand-300 px-3 py-1.5 text-xs font-medium text-brand-600 transition hover:bg-brand-50 dark:border-brand-700 dark:text-brand-400 dark:hover:bg-brand-900/20">
                        Ver detalle
                        <svg class="h-3 w-3" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3"/>
                        </svg>
                      </a>
                    </td>
                  </tr>
                }
              </tbody>
            </table>
          </div>

          <!-- Footer con total -->
          <div class="border-t border-gray-200 px-5 py-3 dark:border-gray-700">
            <p class="text-right text-xs text-gray-400 dark:text-gray-500">
              Mostrando {{ dashService.morosos().length }} de
              {{ dashService.kpis().cantidadMorosos }} socios morosos
            </p>
          </div>
        }
      </div>

    </div>
  `,
})
export class DashboardComponent implements OnInit {
  protected readonly dashService = inject(DashboardService);

  protected readonly fmtSoles = fmtSoles;

  protected readonly mesActualLabel: string = (() => {
    const meses = ['Enero','Febrero','Marzo','Abril','Mayo','Junio',
                   'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
    const now = new Date();
    return `${meses[now.getMonth()]} ${now.getFullYear()}`;
  })();

  ngOnInit(): void {
    void this.dashService.cargar();
  }

  recargar(): void {
    void this.dashService.cargar();
  }

  // ── ApexCharts: series y xaxis derivados de las signals del servicio ──────

  readonly chartSeries = computed<ApexAxisChartSeries>(() => [{
    name: 'Recaudado S/',
    data: this.dashService.recaudacion6m().map(m => m.total),
  }]);

  readonly chartXAxis = computed<ApexXAxis>(() => ({
    categories: this.dashService.recaudacion6m().map(m => m.label),
    axisBorder: { show: false },
    axisTicks:  { show: false },
    labels: { style: { fontFamily: 'Outfit, sans-serif', fontSize: '12px' } },
  }));

  // ── Configuración estática del gráfico ────────────────────────────────────

  readonly chartConfig: ApexChart = {
    fontFamily: 'Outfit, sans-serif',
    type: 'bar',
    height: 300,
    toolbar: { show: false },
    animations: { enabled: true, speed: 500 },
  };

  readonly chartColors: string[] = ['#465fff'];

  readonly chartPlotOptions: ApexPlotOptions = {
    bar: {
      horizontal: false,
      columnWidth: '42%',
      borderRadius: 6,
      borderRadiusApplication: 'end',
    },
  };

  readonly chartDataLabels: ApexDataLabels = { enabled: false };

  readonly chartStroke: ApexStroke = {
    show: true,
    width: 3,
    colors: ['transparent'],
  };

  readonly chartYAxis: ApexYAxis = {
    labels: {
      formatter: (val: number, _opts?: object) => `S/ ${val >= 1000 ? (val / 1000).toFixed(1) + 'k' : val.toFixed(0)}`,
      style: { fontFamily: 'Outfit, sans-serif', fontSize: '12px' },
    },
  };

  readonly chartGrid: ApexGrid = {
    borderColor: '#e5e7eb',
    strokeDashArray: 4,
    yaxis: { lines: { show: true } },
    xaxis: { lines: { show: false } },
  };

  readonly chartFill: ApexFill = { opacity: 1 };

  readonly chartTooltip: ApexTooltip = {
    y: { formatter: (val: number) => fmtSoles(val) },
    theme: 'light',
  };
}
