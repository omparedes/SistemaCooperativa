import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { NgClass } from '@angular/common';
import {
  ConceptoResumen,
  DetalleEgresoLinea,
  DetalleIngresoLinea,
  RangoReporte,
  ReporteResumenV2,
  ReportesService,
  TipoPagadorFiltro,
} from '../../core/services/reportes.service';
import { ExcelExportService } from '../../core/services/excel-export.service';
import { InventarioService } from '../../core/services/inventario.service';
import { AuthService } from '../../core/services/auth.service';

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

function fmtFechaHora(iso: string): string {
  const d = new Date(iso);
  return `${String(d.getDate()).padStart(2,'0')}/${String(d.getMonth()+1).padStart(2,'0')} ${String(d.getHours()).padStart(2,'0')}:${String(d.getMinutes()).padStart(2,'0')}`;
}

const RANGO_LABELS: Record<RangoReporte, string> = {
  hoy:    'Hoy',
  semana: 'Últimos 7 días',
  mes:    'Este Mes',
  año:    'Este Año',
};

const PAGADOR_LABELS: Record<TipoPagadorFiltro, string> = {
  todos:      'Todos',
  socios:     'Solo Socios',
  inquilinos: 'Solo Inquilinos',
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

      <!-- ── Encabezado + filtros ───────────────────────────────────────── -->
      <div class="mb-6 flex flex-col gap-4 lg:flex-row lg:items-start lg:justify-between">
        <div>
          <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Central de Reportes</h2>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
            Visión financiera consolidada · Cooperativa Primero de Mayo
          </p>
        </div>

        <div class="flex flex-wrap items-center gap-3">
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

          <!-- Filtro tipo de pagador -->
          <div class="flex items-center gap-1 rounded-xl border border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-gray-800 p-1 shrink-0">
            @for (t of tiposPagador; track t) {
              <button
                (click)="setTipoPagador(t)"
                [ngClass]="tipoPagador() === t
                  ? 'bg-white dark:bg-gray-700 text-emerald-600 dark:text-emerald-400 shadow-sm font-semibold'
                  : 'text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-200'"
                class="rounded-lg px-3 py-1.5 text-sm transition-all whitespace-nowrap">
                {{ pagadorLabel(t) }}
              </button>
            }
          </div>

          <!-- Exportar a Excel -->
          <button
            (click)="exportarExcel()"
            [disabled]="!reporte() || cargando() || exportando()"
            class="flex h-9 items-center gap-1.5 rounded-lg bg-emerald-600 px-4 text-sm font-medium text-white transition hover:bg-emerald-700 disabled:opacity-40">
            @if (exportando()) {
              <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
              </svg>
              Exportando…
            } @else {
              <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
              </svg>
              Exportar a Excel
            }
          </button>
        </div>
      </div>

      <!-- ── Error ──────────────────────────────────────────────────────── -->
      @if (error()) {
        <div class="mb-6 rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400">
          <strong>Error:</strong> {{ error() }}
        </div>
      }

      <!-- ── Skeletons ──────────────────────────────────────────────────── -->
      @if (cargando()) {
        <div class="space-y-6">
          @for (s of [1, 2]; track s) {
            <div class="rounded-2xl border border-gray-200 bg-white p-6 dark:border-gray-700 dark:bg-gray-dark">
              <div class="h-4 w-40 rounded bg-gray-200 dark:bg-gray-700 mb-5 animate-pulse"></div>
              <div class="grid grid-cols-1 gap-4 sm:grid-cols-4">
                @for (i of [1,2,3,4]; track i) {
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

        <!-- ══════════════════════════════════════════════════════════════ -->
        <!-- SECCIÓN 1: KPIs de Caja                                        -->
        <!-- ══════════════════════════════════════════════════════════════ -->
        <section class="mb-6 rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark overflow-hidden">
          <div class="border-b border-gray-100 dark:border-gray-700 bg-gray-50 dark:bg-gray-700/30 px-6 py-4">
            <h3 class="text-sm font-bold text-gray-800 dark:text-white uppercase tracking-wide">Resumen de Caja</h3>
            <p class="text-xs text-gray-400 dark:text-gray-500 mt-0.5">
              {{ fmtPeriodo(r) }} · {{ pagadorLabel(r.tipoPagador) }}
              · <span class="text-green-600 dark:text-green-400">{{ r.caja.count_recibos }} recibos</span>
              @if (r.caja.count_internos > 0) {
                · <span class="text-violet-500">{{ r.caja.count_internos }} sin recibo</span>
              }
              @if (r.caja.count_recaudacion > 0) {
                · <span class="text-emerald-500">{{ r.caja.count_recaudacion }} tarjeta</span>
              }
              @if (r.caja.count_anulados > 0) {
                · <span class="text-red-500">{{ r.caja.count_anulados }} anulados (excluidos)</span>
              }
            </p>
          </div>

          <div class="grid grid-cols-1 divide-y sm:grid-cols-2 lg:grid-cols-4 sm:divide-x lg:divide-y-0 divide-gray-100 dark:divide-gray-700">
            <!-- Efectivo -->
            <div class="p-5">
              <p class="text-xs font-semibold uppercase tracking-wider text-green-600 dark:text-green-400">Efectivo</p>
              <p class="mt-2 text-2xl font-bold tabular-nums text-green-700 dark:text-green-300">{{ fmtSoles(r.caja.efectivo) }}</p>
              <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">Entra a gaveta (incluye tarjeta prepago)</p>
            </div>
            <!-- Transferencia -->
            <div class="p-5">
              <p class="text-xs font-semibold uppercase tracking-wider text-blue-600 dark:text-blue-400">Transferencia / QR</p>
              <p class="mt-2 text-2xl font-bold tabular-nums text-blue-700 dark:text-blue-300">{{ fmtSoles(r.caja.transferencia) }}</p>
              <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">No entra a gaveta</p>
            </div>
            <!-- Egresos -->
            <div class="p-5">
              <p class="text-xs font-semibold uppercase tracking-wider text-red-600 dark:text-red-400">Egresos (Gastos)</p>
              <p class="mt-2 text-2xl font-bold tabular-nums text-red-700 dark:text-red-300">{{ fmtSoles(r.caja.egresos) }}</p>
              <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">Egresos operativos del período</p>
            </div>
            <!-- Saldo -->
            <div class="p-5"
              [ngClass]="r.caja.saldo >= 0 ? 'bg-brand-50/40 dark:bg-brand-900/10' : 'bg-red-50/40 dark:bg-red-900/10'">
              <p class="text-xs font-semibold uppercase tracking-wider"
                [ngClass]="r.caja.saldo >= 0 ? 'text-brand-600 dark:text-brand-400' : 'text-red-600 dark:text-red-400'">
                Saldo Neto
              </p>
              <p class="mt-2 text-2xl font-bold tabular-nums"
                [ngClass]="r.caja.saldo >= 0 ? 'text-brand-700 dark:text-brand-300' : 'text-red-700 dark:text-red-300'">
                {{ fmtSoles(r.caja.saldo) }}
              </p>
              <p class="mt-1 text-xs"
                [ngClass]="r.caja.saldo >= 0 ? 'text-brand-500' : 'text-red-500'">
                Ingresos − Egresos del período
              </p>
            </div>
          </div>
        </section>

        <!-- ══════════════════════════════════════════════════════════════ -->
        <!-- SECCIÓN 2: Ingresos por Concepto (drill-down)                  -->
        <!-- ══════════════════════════════════════════════════════════════ -->
        <section class="mb-6 rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark overflow-hidden">
          <div class="border-b border-gray-100 dark:border-gray-700 bg-gray-50 dark:bg-gray-700/30 px-6 py-4">
            <h3 class="text-sm font-bold text-gray-800 dark:text-white uppercase tracking-wide">Ingresos por Concepto</h3>
            <p class="text-xs text-gray-400 dark:text-gray-500 mt-0.5">
              Haz clic en un concepto para ver el detalle de quién pagó, cuándo y con qué recibo.
            </p>
          </div>

          @if (r.por_concepto.length === 0) {
            <p class="p-8 text-center text-sm text-gray-400 dark:text-gray-500">Sin ingresos en este período.</p>
          } @else {
            <div class="overflow-x-auto">
              <table class="w-full text-sm">
                <thead class="bg-gray-50 dark:bg-gray-700/40">
                  <tr>
                    <th class="w-8"></th>
                    <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Concepto</th>
                    <th class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Cobros</th>
                    @if (tipoPagador() === 'todos') {
                      <th class="hidden md:table-cell px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Socios</th>
                      <th class="hidden md:table-cell px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Inquilinos</th>
                    }
                    <th class="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Monto</th>
                    <th class="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">% del total</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                  @for (c of r.por_concepto; track c.concepto) {
                    <tr class="cursor-pointer transition hover:bg-gray-50 dark:hover:bg-gray-700/30"
                        (click)="toggleIngreso(c.concepto)">
                      <td class="pl-4 text-gray-400">
                        <svg class="h-4 w-4 transition-transform" [class.rotate-90]="estaExpandido('ing:' + c.concepto)"
                          fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/>
                        </svg>
                      </td>
                      <td class="px-4 py-3 font-medium text-gray-800 dark:text-white">{{ c.concepto }}</td>
                      <td class="px-4 py-3 text-center text-gray-500 dark:text-gray-400">{{ c.cantidad }}</td>
                      @if (tipoPagador() === 'todos') {
                        <td class="hidden md:table-cell px-4 py-3 text-right tabular-nums text-gray-500 dark:text-gray-400">{{ fmtSoles(c.monto_socios) }}</td>
                        <td class="hidden md:table-cell px-4 py-3 text-right tabular-nums text-gray-500 dark:text-gray-400">{{ fmtSoles(c.monto_inquilinos) }}</td>
                      }
                      <td class="px-4 py-3 text-right font-semibold tabular-nums text-gray-900 dark:text-white">{{ fmtSoles(c.monto) }}</td>
                      <td class="px-4 py-3 text-right">
                        <div class="flex items-center justify-end gap-2">
                          <div class="h-1.5 w-16 overflow-hidden rounded-full bg-gray-200 dark:bg-gray-700">
                            <div class="h-full rounded-full bg-brand-500" [style.width.%]="pctConcepto(c)"></div>
                          </div>
                          <span class="w-9 text-xs tabular-nums text-gray-500 dark:text-gray-400">{{ pctConcepto(c).toFixed(0) }}%</span>
                        </div>
                      </td>
                    </tr>

                    <!-- Fila expandida: detalle lazy -->
                    @if (estaExpandido('ing:' + c.concepto)) {
                      <tr>
                        <td [attr.colspan]="tipoPagador() === 'todos' ? 7 : 5" class="bg-gray-50/70 dark:bg-gray-800/50 px-6 py-3">
                          @if (cargandoDetalle().has('ing:' + c.concepto)) {
                            <div class="flex items-center gap-2 py-3 text-sm text-gray-400">
                              <span class="inline-block h-4 w-4 rounded-full border-2 border-brand-500 border-t-transparent animate-spin"></span>
                              Cargando detalle…
                            </div>
                          } @else if ((detallesIngreso().get(c.concepto) ?? []).length === 0) {
                            <p class="py-3 text-sm text-gray-400">Sin líneas de detalle.</p>
                          } @else {
                            <div class="overflow-x-auto rounded-lg border border-gray-200 dark:border-gray-700">
                              <table class="w-full text-xs">
                                <thead class="bg-white dark:bg-gray-800">
                                  <tr>
                                    <th class="px-3 py-2 text-left font-semibold uppercase tracking-wider text-gray-400">Fecha</th>
                                    <th class="px-3 py-2 text-left font-semibold uppercase tracking-wider text-gray-400">Recibo</th>
                                    <th class="px-3 py-2 text-left font-semibold uppercase tracking-wider text-gray-400">Pagador</th>
                                    <th class="px-3 py-2 text-center font-semibold uppercase tracking-wider text-gray-400">Tipo</th>
                                    <th class="px-3 py-2 text-left font-semibold uppercase tracking-wider text-gray-400">Puesto</th>
                                    <th class="px-3 py-2 text-center font-semibold uppercase tracking-wider text-gray-400">Período</th>
                                    <th class="px-3 py-2 text-center font-semibold uppercase tracking-wider text-gray-400">Método</th>
                                    <th class="px-3 py-2 text-right font-semibold uppercase tracking-wider text-gray-400">Monto</th>
                                    @if (auth.esAdmin()) {
                                      <th class="px-3 py-2 text-left font-semibold uppercase tracking-wider text-gray-400">Cajero</th>
                                    }
                                  </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-100 dark:divide-gray-700 bg-white dark:bg-gray-800">
                                  @for (l of detallesIngreso().get(c.concepto) ?? []; track l.codigo_transaccion + l.periodo + l.monto) {
                                    <tr>
                                      <td class="px-3 py-2 font-mono whitespace-nowrap text-gray-500 dark:text-gray-400">{{ fmtFechaHora(l.fecha_pago) }}</td>
                                      <td class="px-3 py-2 font-mono whitespace-nowrap text-brand-600 dark:text-brand-400">{{ l.codigo_transaccion }}</td>
                                      <td class="px-3 py-2 text-gray-800 dark:text-white">{{ l.pagador }}</td>
                                      <td class="px-3 py-2 text-center">
                                        <span class="rounded-full px-2 py-0.5 text-[10px] font-semibold uppercase"
                                          [ngClass]="l.tipo_pagador === 'socio'
                                            ? 'bg-brand-50 text-brand-600 dark:bg-brand-900/20 dark:text-brand-400'
                                            : l.tipo_pagador === 'inquilino'
                                              ? 'bg-amber-50 text-amber-600 dark:bg-amber-900/20 dark:text-amber-400'
                                              : 'bg-violet-50 text-violet-600 dark:bg-violet-900/20 dark:text-violet-400'">
                                          {{ l.tipo_pagador }}
                                        </span>
                                      </td>
                                      <td class="px-3 py-2 whitespace-nowrap text-gray-500 dark:text-gray-400">{{ l.codigo_puesto }}</td>
                                      <td class="px-3 py-2 text-center font-mono text-gray-500 dark:text-gray-400">{{ l.periodo }}</td>
                                      <td class="px-3 py-2 text-center text-gray-500 dark:text-gray-400">{{ l.metodo_pago }}</td>
                                      <td class="px-3 py-2 text-right font-bold tabular-nums text-gray-900 dark:text-white">{{ fmtSoles(l.monto) }}</td>
                                      @if (auth.esAdmin()) {
                                        <td class="px-3 py-2 text-gray-500 dark:text-gray-400">{{ l.cajero }}</td>
                                      }
                                    </tr>
                                  }
                                </tbody>
                              </table>
                            </div>
                          }
                        </td>
                      </tr>
                    }
                  }
                </tbody>
                <tfoot class="bg-gray-50 dark:bg-gray-700/40">
                  <tr>
                    <td></td>
                    <td class="px-4 py-3 text-xs font-semibold uppercase text-gray-600 dark:text-gray-300">Total</td>
                    <td class="px-4 py-3 text-center text-xs text-gray-500">{{ totalCobros() }}</td>
                    @if (tipoPagador() === 'todos') {
                      <td class="hidden md:table-cell"></td>
                      <td class="hidden md:table-cell"></td>
                    }
                    <td class="px-4 py-3 text-right text-sm font-bold tabular-nums text-gray-900 dark:text-white">{{ fmtSoles(totalConceptos()) }}</td>
                    <td></td>
                  </tr>
                </tfoot>
              </table>
            </div>
          }
        </section>

        <!-- ══════════════════════════════════════════════════════════════ -->
        <!-- SECCIÓN 3: Egresos por Categoría (drill-down)                  -->
        <!-- ══════════════════════════════════════════════════════════════ -->
        <section class="mb-6 rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark overflow-hidden">
          <div class="border-b border-orange-100 dark:border-orange-900/30 bg-orange-50/60 dark:bg-orange-900/10 px-6 py-4">
            <h3 class="text-sm font-bold text-orange-800 dark:text-orange-300 uppercase tracking-wide">Egresos por Categoría</h3>
            <p class="text-xs text-orange-500 dark:text-orange-400 mt-0.5">
              Total del período: {{ fmtSoles(r.caja.egresos) }}
            </p>
          </div>

          @if (r.egresos_por_categoria.length === 0) {
            <p class="p-8 text-center text-sm text-gray-400 dark:text-gray-500">Sin egresos en este período.</p>
          } @else {
            <div class="overflow-x-auto">
              <table class="w-full text-sm">
                <thead class="bg-gray-50 dark:bg-gray-700/40">
                  <tr>
                    <th class="w-8"></th>
                    <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Categoría</th>
                    <th class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Egresos</th>
                    <th class="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Monto</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                  @for (e of r.egresos_por_categoria; track e.categoria) {
                    <tr class="cursor-pointer transition hover:bg-orange-50/40 dark:hover:bg-orange-900/10"
                        (click)="toggleEgreso(e.categoria)">
                      <td class="pl-4 text-gray-400">
                        <svg class="h-4 w-4 transition-transform" [class.rotate-90]="estaExpandido('egr:' + e.categoria)"
                          fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/>
                        </svg>
                      </td>
                      <td class="px-4 py-3 font-medium text-gray-800 dark:text-white">{{ e.categoria }}</td>
                      <td class="px-4 py-3 text-center text-gray-500 dark:text-gray-400">{{ e.cantidad }}</td>
                      <td class="px-4 py-3 text-right font-semibold tabular-nums text-red-600 dark:text-red-400">{{ fmtSoles(e.monto) }}</td>
                    </tr>

                    @if (estaExpandido('egr:' + e.categoria)) {
                      <tr>
                        <td colspan="4" class="bg-gray-50/70 dark:bg-gray-800/50 px-6 py-3">
                          @if (cargandoDetalle().has('egr:' + e.categoria)) {
                            <div class="flex items-center gap-2 py-3 text-sm text-gray-400">
                              <span class="inline-block h-4 w-4 rounded-full border-2 border-orange-500 border-t-transparent animate-spin"></span>
                              Cargando detalle…
                            </div>
                          } @else {
                            <div class="overflow-x-auto rounded-lg border border-gray-200 dark:border-gray-700">
                              <table class="w-full text-xs">
                                <thead class="bg-white dark:bg-gray-800">
                                  <tr>
                                    <th class="px-3 py-2 text-left font-semibold uppercase tracking-wider text-gray-400">Fecha</th>
                                    <th class="px-3 py-2 text-left font-semibold uppercase tracking-wider text-gray-400">Comprobante</th>
                                    <th class="px-3 py-2 text-left font-semibold uppercase tracking-wider text-gray-400">Responsable</th>
                                    <th class="px-3 py-2 text-left font-semibold uppercase tracking-wider text-gray-400">Detalle</th>
                                    <th class="px-3 py-2 text-right font-semibold uppercase tracking-wider text-gray-400">Monto</th>
                                  </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-100 dark:divide-gray-700 bg-white dark:bg-gray-800">
                                  @for (g of detallesEgreso().get(e.categoria) ?? []; track g.id) {
                                    <tr>
                                      <td class="px-3 py-2 whitespace-nowrap text-gray-500 dark:text-gray-400">{{ fmtFechaCorta(g.fecha) }}</td>
                                      <td class="px-3 py-2 font-mono text-gray-500 dark:text-gray-400">{{ g.comprobante_ref || '—' }}</td>
                                      <td class="px-3 py-2 text-gray-800 dark:text-white">{{ g.responsable || '—' }}</td>
                                      <td class="px-3 py-2 text-gray-500 dark:text-gray-400">{{ g.descripcion || '—' }}</td>
                                      <td class="px-3 py-2 text-right font-bold tabular-nums text-red-600 dark:text-red-400">{{ fmtSoles(g.monto) }}</td>
                                    </tr>
                                  }
                                </tbody>
                              </table>
                            </div>
                          }
                        </td>
                      </tr>
                    }
                  }
                </tbody>
              </table>
            </div>
          }
        </section>

        <!-- ══════════════════════════════════════════════════════════════ -->
        <!-- SECCIÓN 4: Resumen Bancario                                    -->
        <!-- ══════════════════════════════════════════════════════════════ -->
        <section class="mb-6 rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark overflow-hidden">
          <div class="border-b border-gray-100 dark:border-gray-700 bg-gray-50 dark:bg-gray-700/30 px-6 py-4">
            <h3 class="text-sm font-bold text-gray-800 dark:text-white uppercase tracking-wide">Resumen Bancario</h3>
            <p class="text-xs text-gray-400 dark:text-gray-500 mt-0.5">
              Movimientos en cuentas bancarias · {{ fmtPeriodo(r) }}
              @if (r.banco.count > 0) {
                · <span class="text-blue-500">{{ r.banco.count }} movimiento{{ r.banco.count !== 1 ? 's' : '' }}</span>
              }
            </p>
          </div>

          <div class="grid grid-cols-1 divide-y sm:grid-cols-3 sm:divide-x sm:divide-y-0 divide-gray-100 dark:divide-gray-700">
            <div class="p-5">
              <p class="text-xs font-semibold uppercase tracking-wider text-green-600 dark:text-green-400">Ingresos Bancarios</p>
              <p class="mt-2 text-2xl font-bold tabular-nums text-green-700 dark:text-green-300">{{ fmtSoles(r.banco.ingresos) }}</p>
            </div>
            <div class="p-5">
              <p class="text-xs font-semibold uppercase tracking-wider text-red-600 dark:text-red-400">Egresos Bancarios</p>
              <p class="mt-2 text-2xl font-bold tabular-nums text-red-700 dark:text-red-300">{{ fmtSoles(r.banco.egresos) }}</p>
            </div>
            <div class="p-5"
              [ngClass]="r.banco.saldo >= 0 ? 'bg-blue-50/40 dark:bg-blue-900/10' : 'bg-red-50/40 dark:bg-red-900/10'">
              <p class="text-xs font-semibold uppercase tracking-wider"
                [ngClass]="r.banco.saldo >= 0 ? 'text-blue-600 dark:text-blue-400' : 'text-red-600 dark:text-red-400'">
                Saldo Neto Banco
              </p>
              <p class="mt-2 text-2xl font-bold tabular-nums"
                [ngClass]="r.banco.saldo >= 0 ? 'text-blue-700 dark:text-blue-300' : 'text-red-700 dark:text-red-300'">
                {{ fmtSoles(r.banco.saldo) }}
              </p>
            </div>
          </div>

          @if (r.banco.count === 0) {
            <div class="border-t border-gray-100 dark:border-gray-700 px-6 py-4 text-center text-sm text-gray-400 dark:text-gray-500">
              Sin movimientos bancarios registrados en este período.
            </div>
          }
        </section>

        <!-- ══════════════════════════════════════════════════════════════ -->
        <!-- SECCIÓN 5: Estado del Almacén                                  -->
        <!-- ══════════════════════════════════════════════════════════════ -->
        <section class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark overflow-hidden">
          <div class="border-b border-gray-100 dark:border-gray-700 bg-gray-50 dark:bg-gray-700/30 px-6 py-4">
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

          @if (cargandoInventario()) {
            <div class="p-6 flex items-center gap-3 text-gray-400 dark:text-gray-500 text-sm">
              <span class="inline-block h-4 w-4 rounded-full border-2 border-brand-500 border-t-transparent animate-spin"></span>
              Cargando estado del almacén…
            </div>
          } @else if (alertasStock().length === 0) {
            <div class="flex flex-col items-center gap-2 py-10 text-gray-400 dark:text-gray-500">
              <svg class="h-10 w-10 text-green-400 opacity-70" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
              <p class="text-sm font-medium text-green-700 dark:text-green-400">¡Almacén en buen estado!</p>
            </div>
          } @else {
            <div class="overflow-x-auto">
              <table class="w-full text-sm">
                <thead class="bg-orange-50/60 dark:bg-orange-900/10">
                  <tr>
                    <th class="px-5 py-3 text-left text-xs font-semibold uppercase tracking-wider text-orange-700 dark:text-orange-400">Código</th>
                    <th class="px-5 py-3 text-left text-xs font-semibold uppercase tracking-wider text-orange-700 dark:text-orange-400">Producto</th>
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
                      <td class="px-5 py-3 text-center">
                        <span class="text-base font-bold tabular-nums text-red-600 dark:text-red-400">{{ p.stock_actual }}</span>
                      </td>
                      <td class="px-5 py-3 text-center text-sm text-gray-500 dark:text-gray-400 tabular-nums">{{ p.stock_minimo }}</td>
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
  private readonly excelSvc      = inject(ExcelExportService);
  protected readonly auth        = inject(AuthService);

  // Helpers expuestos al template
  protected readonly fmtSoles      = fmtSoles;
  protected readonly fmtFechaCorta = fmtFechaCorta;
  protected readonly fmtFechaHora  = fmtFechaHora;

  readonly rangos: RangoReporte[] = ['hoy', 'semana', 'mes', 'año'];
  readonly tiposPagador: TipoPagadorFiltro[] = ['todos', 'socios', 'inquilinos'];

  readonly rango       = signal<RangoReporte>('mes');
  readonly tipoPagador = signal<TipoPagadorFiltro>('todos');
  readonly reporte     = signal<ReporteResumenV2 | null>(null);
  readonly cargando    = signal(false);
  readonly error       = signal<string | null>(null);
  readonly exportando  = signal(false);

  // Drill-down: expansión + caché lazy por concepto/categoría
  readonly expandidos      = signal<Set<string>>(new Set());
  readonly cargandoDetalle = signal<Set<string>>(new Set());
  readonly detallesIngreso = signal<Map<string, DetalleIngresoLinea[]>>(new Map());
  readonly detallesEgreso  = signal<Map<string, DetalleEgresoLinea[]>>(new Map());

  readonly cargandoInventario = this.inventarioSvc.loading;
  readonly alertasStock       = this.inventarioSvc.alertasStockBajo;

  readonly totalConceptos = computed(() =>
    Math.round((this.reporte()?.por_concepto.reduce((s, c) => s + c.monto, 0) ?? 0) * 100) / 100,
  );

  readonly totalCobros = computed(() =>
    this.reporte()?.por_concepto.reduce((s, c) => s + c.cantidad, 0) ?? 0,
  );

  ngOnInit(): void {
    void this.cargar();
    void this.inventarioSvc.cargarProductos();
  }

  async cargar(): Promise<void> {
    this.cargando.set(true);
    this.error.set(null);
    this.reporte.set(null);
    // Los filtros cambiaron: el detalle cacheado ya no es válido
    this.expandidos.set(new Set());
    this.detallesIngreso.set(new Map());
    this.detallesEgreso.set(new Map());
    try {
      const r = await this.reportesSvc.cargarResumenV2(this.rango(), this.tipoPagador());
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

  setTipoPagador(t: TipoPagadorFiltro): void {
    this.tipoPagador.set(t);
    void this.cargar();
  }

  // ── Drill-down ─────────────────────────────────────────────────────────────

  estaExpandido(clave: string): boolean {
    return this.expandidos().has(clave);
  }

  toggleIngreso(concepto: string): void {
    const clave = `ing:${concepto}`;
    if (this.toggleExpansion(clave)) return;
    if (!this.detallesIngreso().has(concepto)) {
      void this.cargarDetalleIngreso(concepto, clave);
    }
  }

  toggleEgreso(categoria: string): void {
    const clave = `egr:${categoria}`;
    if (this.toggleExpansion(clave)) return;
    if (!this.detallesEgreso().has(categoria)) {
      void this.cargarDetalleEgreso(categoria, clave);
    }
  }

  /** Alterna la expansión. Devuelve true si la fila quedó COLAPSADA. */
  private toggleExpansion(clave: string): boolean {
    const set = new Set(this.expandidos());
    if (set.has(clave)) {
      set.delete(clave);
      this.expandidos.set(set);
      return true;
    }
    set.add(clave);
    this.expandidos.set(set);
    return false;
  }

  private async cargarDetalleIngreso(concepto: string, clave: string): Promise<void> {
    this.marcarCargandoDetalle(clave, true);
    try {
      const lineas = await this.reportesSvc.cargarDetalleConcepto(this.rango(), concepto, this.tipoPagador());
      const map = new Map(this.detallesIngreso());
      map.set(concepto, lineas);
      this.detallesIngreso.set(map);
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar el detalle');
    } finally {
      this.marcarCargandoDetalle(clave, false);
    }
  }

  private async cargarDetalleEgreso(categoria: string, clave: string): Promise<void> {
    this.marcarCargandoDetalle(clave, true);
    try {
      const lineas = await this.reportesSvc.cargarDetalleEgresos(this.rango(), categoria);
      const map = new Map(this.detallesEgreso());
      map.set(categoria, lineas);
      this.detallesEgreso.set(map);
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar el detalle');
    } finally {
      this.marcarCargandoDetalle(clave, false);
    }
  }

  private marcarCargandoDetalle(clave: string, activo: boolean): void {
    const set = new Set(this.cargandoDetalle());
    if (activo) set.add(clave); else set.delete(clave);
    this.cargandoDetalle.set(set);
  }

  // ── Exportación a Excel ────────────────────────────────────────────────────

  async exportarExcel(): Promise<void> {
    const r = this.reporte();
    if (!r || this.exportando()) return;

    this.exportando.set(true);
    this.error.set(null);
    try {
      // Detalle completo del rango (una sola RPC por hoja)
      const [detalleIngresos, detalleEgresos] = await Promise.all([
        this.reportesSvc.cargarDetalleConcepto(this.rango(), null, this.tipoPagador()),
        this.reportesSvc.cargarDetalleEgresos(this.rango(), null),
      ]);

      const hojaResumen = [
        { Indicador: 'Período',                 Valor: `${r.fechaDesde} al ${r.fechaHasta}` },
        { Indicador: 'Filtro de pagador',       Valor: this.pagadorLabel(r.tipoPagador) },
        { Indicador: 'Caja — Efectivo',         Valor: r.caja.efectivo },
        { Indicador: 'Caja — Transferencia/QR', Valor: r.caja.transferencia },
        { Indicador: 'Caja — Ingresos internos', Valor: r.caja.ingresos_internos },
        { Indicador: 'Caja — Recaudación tarjeta', Valor: r.caja.recaudacion_tarjeta },
        { Indicador: 'Caja — Egresos (gastos)', Valor: r.caja.egresos },
        { Indicador: 'Caja — Saldo neto',       Valor: r.caja.saldo },
        { Indicador: 'Recibos emitidos',        Valor: r.caja.count_recibos },
        { Indicador: 'Recibos anulados (excluidos)', Valor: r.caja.count_anulados },
        { Indicador: 'Banco — Ingresos',        Valor: r.banco.ingresos },
        { Indicador: 'Banco — Egresos',         Valor: r.banco.egresos },
        { Indicador: 'Banco — Saldo neto',      Valor: r.banco.saldo },
      ];

      const hojaConceptos = r.por_concepto.map(c => ({
        Concepto:     c.concepto,
        Cobros:       c.cantidad,
        'Monto S/':   c.monto,
        'Socios S/':      c.monto_socios,
        'Inquilinos S/':  c.monto_inquilinos,
      }));

      const hojaDetalle = detalleIngresos.map(l => ({
        Fecha:      l.fecha_pago,
        Recibo:     l.codigo_transaccion,
        Concepto:   l.concepto,
        Pagador:    l.pagador,
        Tipo:       l.tipo_pagador,
        Puesto:     l.codigo_puesto,
        Período:    l.periodo,
        Método:     l.metodo_pago,
        'Monto S/': l.monto,
        Cajero:     l.cajero,
      }));

      const hojaEgresos = detalleEgresos.map(g => ({
        Fecha:       g.fecha,
        Categoría:   g.categoria,
        Comprobante: g.comprobante_ref ?? '',
        Responsable: g.responsable ?? '',
        Detalle:     g.descripcion ?? '',
        'Monto S/':  g.monto,
      }));

      const sufijo = r.tipoPagador !== 'todos' ? `_${r.tipoPagador}` : '';
      await this.excelSvc.exportar(
        `reporte_${r.fechaDesde}_a_${r.fechaHasta}${sufijo}.xlsx`,
        [
          { nombre: 'Resumen',          filas: hojaResumen },
          { nombre: 'Por Concepto',     filas: hojaConceptos },
          { nombre: 'Detalle Ingresos', filas: hojaDetalle },
          { nombre: 'Egresos',          filas: hojaEgresos },
        ],
      );
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al exportar a Excel');
    } finally {
      this.exportando.set(false);
    }
  }

  // ── Helpers de template ────────────────────────────────────────────────────

  protected rangoLabel(r: RangoReporte): string {
    return RANGO_LABELS[r];
  }

  protected pagadorLabel(t: TipoPagadorFiltro): string {
    return PAGADOR_LABELS[t];
  }

  protected fmtPeriodo(r: ReporteResumenV2): string {
    return fmtFechaPeriodo(r.fechaDesde, r.fechaHasta);
  }

  protected pctConcepto(c: ConceptoResumen): number {
    const total = this.totalConceptos();
    return total > 0 ? (c.monto / total) * 100 : 0;
  }
}
