import { Component, computed, inject } from '@angular/core';
import { NgClass } from '@angular/common';
import { DashboardService } from '../../core/services/dashboard.service';

function fmtSoles(n: number): string {
  return `S/ ${n.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
}

const MESES = ['enero','febrero','marzo','abril','mayo','junio','julio','agosto','septiembre','octubre','noviembre','diciembre'];

/** Circunferencia del anillo SVG (r = 52). */
const CIRC = 2 * Math.PI * 52;

/**
 * Panel Ejecutivo del Dashboard: Ingresos vs Egresos del mes, anillo de
 * morosidad y ranking de deuda por concepto. Dibujado 100 % con CSS/SVG
 * (sin librerías de gráficos). Datos: rpc_dashboard_ejecutivo (00087).
 */
@Component({
  selector: 'app-dashboard-ejecutivo',
  standalone: true,
  imports: [NgClass],
  template: `
    @if (dashService.ejecutivo(); as ej) {
      <div class="mt-6">
        <div class="mb-4 flex items-center gap-3">
          <div class="flex h-9 w-9 items-center justify-center rounded-xl bg-brand-50 dark:bg-brand-900/20">
            <svg class="h-5 w-5 text-brand-600 dark:text-brand-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M7.5 14.25v2.25m3-4.5v4.5m3-6.75v6.75m3-9v9M6 20.25h12A2.25 2.25 0 0020.25 18V6A2.25 2.25 0 0018 3.75H6A2.25 2.25 0 003.75 6v12A2.25 2.25 0 006 20.25z"/>
            </svg>
          </div>
          <div>
            <h3 class="text-sm font-bold uppercase tracking-wide text-gray-800 dark:text-white">Panel Ejecutivo</h3>
            <p class="text-xs text-gray-400 dark:text-gray-500">{{ labelMes() }} · en tiempo real</p>
          </div>
        </div>

        <div class="grid grid-cols-1 gap-4 lg:grid-cols-3">

          <!-- ══ Tarjeta 1: Ingresos vs Egresos del mes ══════════════════ -->
          <div class="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
            <p class="text-xs font-bold uppercase tracking-wider text-gray-400 dark:text-gray-500">Ingresos vs Egresos</p>
            <p class="mb-5 text-xs text-gray-400 dark:text-gray-500">Mes en curso</p>

            <!-- Ingresos -->
            <div class="mb-5">
              <div class="mb-1.5 flex items-baseline justify-between">
                <span class="flex items-center gap-2 text-sm font-medium text-gray-600 dark:text-gray-300">
                  <span class="h-2.5 w-2.5 rounded-full bg-green-500"></span> Ingresos
                </span>
                <span class="text-lg font-bold tabular-nums text-green-600 dark:text-green-400">{{ fmtSoles(ej.mes.ingresos) }}</span>
              </div>
              <div class="h-3.5 w-full overflow-hidden rounded-full bg-gray-100 dark:bg-gray-700">
                <div class="h-full rounded-full bg-gradient-to-r from-green-400 to-green-600 transition-all duration-700"
                  [style.width.%]="pctBarra(ej.mes.ingresos)"></div>
              </div>
            </div>

            <!-- Egresos -->
            <div class="mb-5">
              <div class="mb-1.5 flex items-baseline justify-between">
                <span class="flex items-center gap-2 text-sm font-medium text-gray-600 dark:text-gray-300">
                  <span class="h-2.5 w-2.5 rounded-full bg-red-500"></span> Egresos
                </span>
                <span class="text-lg font-bold tabular-nums text-red-600 dark:text-red-400">{{ fmtSoles(ej.mes.egresos) }}</span>
              </div>
              <div class="h-3.5 w-full overflow-hidden rounded-full bg-gray-100 dark:bg-gray-700">
                <div class="h-full rounded-full bg-gradient-to-r from-red-400 to-red-600 transition-all duration-700"
                  [style.width.%]="pctBarra(ej.mes.egresos)"></div>
              </div>
            </div>

            <!-- Balance -->
            <div class="flex items-center justify-between rounded-xl px-4 py-3"
              [ngClass]="balance() >= 0
                ? 'bg-green-50 dark:bg-green-900/20'
                : 'bg-red-50 dark:bg-red-900/20'">
              <span class="text-sm font-semibold"
                [ngClass]="balance() >= 0 ? 'text-green-700 dark:text-green-300' : 'text-red-700 dark:text-red-300'">
                Balance del mes
              </span>
              <span class="text-xl font-extrabold tabular-nums"
                [ngClass]="balance() >= 0 ? 'text-green-700 dark:text-green-300' : 'text-red-700 dark:text-red-300'">
                {{ balance() >= 0 ? '+' : '' }}{{ fmtSoles(balance()) }}
              </span>
            </div>
          </div>

          <!-- ══ Tarjeta 2: Anillo de Morosidad ═══════════════════════════ -->
          <div class="flex flex-col items-center rounded-2xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
            <p class="self-start text-xs font-bold uppercase tracking-wider text-gray-400 dark:text-gray-500">Nivel de Morosidad</p>
            <p class="mb-3 self-start text-xs text-gray-400 dark:text-gray-500">Personas con deuda vencida sobre el padrón</p>

            <div class="relative my-2">
              <svg width="150" height="150" viewBox="0 0 120 120" class="-rotate-90">
                <circle cx="60" cy="60" r="52" fill="none" stroke-width="12"
                  class="stroke-gray-100 dark:stroke-gray-700"/>
                <circle cx="60" cy="60" r="52" fill="none" stroke-width="12" stroke-linecap="round"
                  [attr.stroke-dasharray]="circ"
                  [attr.stroke-dashoffset]="circ * (1 - pctMorosidad() / 100)"
                  [ngClass]="colorAnillo()"
                  style="transition: stroke-dashoffset 900ms ease"/>
              </svg>
              <div class="absolute inset-0 flex flex-col items-center justify-center">
                <span class="text-3xl font-extrabold tabular-nums" [ngClass]="colorTexto()">{{ pctMorosidad().toFixed(0) }}%</span>
                <span class="text-[11px] font-semibold uppercase tracking-wide text-gray-400">morosidad</span>
              </div>
            </div>

            <div class="mt-2 grid w-full grid-cols-2 gap-2 text-center">
              <div class="rounded-xl bg-gray-50 px-3 py-2 dark:bg-gray-700/40">
                <p class="text-lg font-bold text-gray-800 dark:text-white">{{ ej.morosidad.personas_con_deuda }}</p>
                <p class="text-[11px] text-gray-400">con deuda</p>
              </div>
              <div class="rounded-xl bg-gray-50 px-3 py-2 dark:bg-gray-700/40">
                <p class="text-lg font-bold text-gray-800 dark:text-white">{{ ej.morosidad.total_personas }}</p>
                <p class="text-[11px] text-gray-400">padrón activo</p>
              </div>
            </div>
            <p class="mt-3 text-xs text-gray-400 dark:text-gray-500">
              Deuda global: <span class="font-bold text-red-500">{{ fmtSoles(ej.morosidad.deuda_total) }}</span>
            </p>
          </div>

          <!-- ══ Tarjeta 3: Conceptos con mayor deuda ═════════════════════ -->
          <div class="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
            <p class="text-xs font-bold uppercase tracking-wider text-gray-400 dark:text-gray-500">Conceptos con Mayor Deuda</p>
            <p class="mb-4 text-xs text-gray-400 dark:text-gray-500">Dinero pendiente de cobro por servicio</p>

            @if (ej.deuda_por_concepto.length === 0) {
              <p class="py-8 text-center text-sm text-green-600">Sin deuda pendiente. 🎉</p>
            } @else {
              <div class="space-y-3.5">
                @for (c of ej.deuda_por_concepto; track c.concepto; let idx = $index) {
                  <div>
                    <div class="mb-1 flex items-baseline justify-between gap-2">
                      <span class="flex min-w-0 items-center gap-2 text-sm font-medium text-gray-700 dark:text-gray-300">
                        <span class="flex h-5 w-5 shrink-0 items-center justify-center rounded-md text-[10px] font-bold"
                          [ngClass]="idx === 0
                            ? 'bg-red-100 text-red-600 dark:bg-red-900/40 dark:text-red-400'
                            : 'bg-gray-100 text-gray-500 dark:bg-gray-700 dark:text-gray-400'">
                          {{ idx + 1 }}
                        </span>
                        <span class="truncate">{{ c.concepto }}</span>
                      </span>
                      <span class="shrink-0 text-sm font-bold tabular-nums text-gray-900 dark:text-white">{{ fmtSoles(c.monto) }}</span>
                    </div>
                    <div class="h-2 w-full overflow-hidden rounded-full bg-gray-100 dark:bg-gray-700">
                      <div class="h-full rounded-full transition-all duration-700"
                        [ngClass]="idx === 0 ? 'bg-gradient-to-r from-red-400 to-red-600' : 'bg-gradient-to-r from-amber-300 to-amber-500'"
                        [style.width.%]="pctConcepto(c.monto)"></div>
                    </div>
                  </div>
                }
              </div>
            }
          </div>

        </div>
      </div>
    }
  `,
})
export class DashboardEjecutivoComponent {
  protected readonly dashService = inject(DashboardService);
  protected readonly fmtSoles = fmtSoles;
  protected readonly circ = CIRC;

  readonly balance = computed(() => {
    const m = this.dashService.ejecutivo()?.mes;
    return m ? Math.round((m.ingresos - m.egresos) * 100) / 100 : 0;
  });

  readonly pctMorosidad = computed(() => {
    const m = this.dashService.ejecutivo()?.morosidad;
    if (!m || m.total_personas === 0) return 0;
    return Math.min((m.personas_con_deuda / m.total_personas) * 100, 100);
  });

  labelMes(): string {
    const desde = this.dashService.ejecutivo()?.mes.desde;
    if (!desde) return '';
    const [y, m] = desde.split('-').map(Number);
    return `${MESES[m - 1].charAt(0).toUpperCase()}${MESES[m - 1].slice(1)} ${y}`;
  }

  /** Ancho de barra relativo al mayor de ingresos/egresos (mínimo visible 2 %). */
  pctBarra(valor: number): number {
    const m = this.dashService.ejecutivo()?.mes;
    const max = Math.max(m?.ingresos ?? 0, m?.egresos ?? 0);
    if (max === 0) return 0;
    return Math.max((valor / max) * 100, valor > 0 ? 2 : 0);
  }

  pctConcepto(monto: number): number {
    const top = this.dashService.ejecutivo()?.deuda_por_concepto[0]?.monto ?? 0;
    return top > 0 ? Math.max((monto / top) * 100, 3) : 0;
  }

  colorAnillo(): string {
    const p = this.pctMorosidad();
    return p < 15 ? 'stroke-green-500' : p < 35 ? 'stroke-amber-500' : 'stroke-red-500';
  }

  colorTexto(): string {
    const p = this.pctMorosidad();
    return p < 15 ? 'text-green-600 dark:text-green-400'
         : p < 35 ? 'text-amber-600 dark:text-amber-400'
         : 'text-red-600 dark:text-red-400';
  }
}
