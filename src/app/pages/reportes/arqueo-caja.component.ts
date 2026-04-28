import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { NgClass } from '@angular/common';
import { AuthService } from '../../core/services/auth.service';
import { PdfGeneratorService } from '../../core/services/pdf-generator.service';
import {
  ArqueoResumen,
  ReportesService,
} from '../../core/services/reportes.service';

// ---------------------------------------------------------------------------
// Helpers de formato (sin importar pipes de Angular para mantener standalone puro)
// ---------------------------------------------------------------------------
function hoyISO(): string {
  const d = new Date();
  const y = d.getFullYear();
  const m = String(d.getMonth() + 1).padStart(2, '0');
  const dd = String(d.getDate()).padStart(2, '0');
  return `${y}-${m}-${dd}`;
}

function formatHora(iso: string): string {
  const d = new Date(iso);
  return `${String(d.getHours()).padStart(2, '0')}:${String(d.getMinutes()).padStart(2, '0')}`;
}

function formatFechaLarga(yyyymmdd: string): string {
  const meses = ['enero','febrero','marzo','abril','mayo','junio',
                 'julio','agosto','septiembre','octubre','noviembre','diciembre'];
  const [y, m, d] = yyyymmdd.split('-').map(Number);
  return `${d} de ${meses[m - 1]} de ${y}`;
}

function fmtSoles(n: number): string {
  return `S/ ${n.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
}

// ---------------------------------------------------------------------------
// Componente
// ---------------------------------------------------------------------------
@Component({
  selector: 'app-arqueo-caja',
  standalone: true,
  imports: [NgClass],
  template: `
    <div class="mx-auto max-w-screen-xl p-4 md:p-6 2xl:p-8">

      <!-- ── Encabezado ─────────────────────────────────────────────────── -->
      <div class="mb-6 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h2 class="text-2xl font-bold text-gray-800 dark:text-white">Arqueo de Caja Diario</h2>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
            Cooperativa Primero de Mayo —
            @if (resumen()) { {{ formatFechaLarga(resumen()!.fecha) }} }
          </p>
        </div>

        <div class="flex flex-wrap items-center gap-3">

          <!-- Selector de fecha -->
          <div class="flex items-center gap-2">
            <label class="text-sm font-medium text-gray-600 dark:text-gray-400 whitespace-nowrap">Fecha:</label>
            <input
              type="date"
              [value]="fecha()"
              (change)="onFechaChange($event)"
              [max]="hoy"
              class="h-9 rounded-lg border border-gray-300 bg-white px-3 text-sm text-gray-700 focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-800 dark:text-white"
            />
          </div>

          <!-- Toggle solo mi caja (visible solo para Admin) -->
          @if (auth.esAdmin()) {
            <label class="flex cursor-pointer items-center gap-2 text-sm text-gray-600 dark:text-gray-400">
              <div class="relative">
                <input
                  type="checkbox"
                  class="sr-only peer"
                  [checked]="soloMiCajero()"
                  (change)="onToggleCajero()"
                />
                <div class="h-5 w-9 rounded-full bg-gray-200 peer-checked:bg-brand-500 dark:bg-gray-700 transition-colors"></div>
                <div class="absolute left-0.5 top-0.5 h-4 w-4 rounded-full bg-white shadow transition-transform peer-checked:translate-x-4"></div>
              </div>
              Solo mi caja
            </label>
          }

          <!-- Actualizar -->
          <button
            (click)="cargar()"
            [disabled]="cargando()"
            class="flex h-9 items-center gap-1.5 rounded-lg border border-gray-300 px-3 text-sm text-gray-600 transition hover:bg-gray-50 disabled:opacity-50 dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700">
            <svg class="h-4 w-4" [class.animate-spin]="cargando()" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
            </svg>
            Actualizar
          </button>

          <!-- Imprimir -->
          <button
            (click)="imprimirArqueo()"
            [disabled]="!resumen() || cargando() || generandoPdf()"
            class="flex h-9 items-center gap-1.5 rounded-lg bg-brand-600 px-4 text-sm font-medium text-white transition hover:bg-brand-700 disabled:opacity-40">
            @if (generandoPdf()) {
              <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
              </svg>
              Generando PDF…
            } @else {
              <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"/>
              </svg>
              Imprimir Arqueo (PDF)
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

      <!-- ═════════════════════════════════════════════════════════════════ -->
      <!-- CONTENIDO                                                         -->
      <!-- ═════════════════════════════════════════════════════════════════ -->

      @if (cargando() && !resumen()) {
        <!-- Skeleton inicial -->
        <div class="grid grid-cols-2 gap-4 sm:grid-cols-4 mb-6">
          @for (i of [1,2,3,4]; track i) {
            <div class="animate-pulse rounded-2xl border border-gray-200 bg-white p-5 dark:border-gray-700 dark:bg-gray-800">
              <div class="h-3 w-24 rounded bg-gray-200 dark:bg-gray-700 mb-3"></div>
              <div class="h-7 w-32 rounded bg-gray-200 dark:bg-gray-700"></div>
            </div>
          }
        </div>
      }

      @if (resumen(); as r) {

        <!-- ── FILA 1: KPI Cards ─────────────────────────────────────────── -->
        <div class="mb-6 grid grid-cols-2 gap-4 sm:grid-cols-4">

          <!-- Total día -->
          <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
            <p class="text-xs font-medium uppercase tracking-wider text-gray-400 dark:text-gray-500">Total del Día</p>
            <p class="mt-2 text-2xl font-bold text-gray-900 dark:text-white">{{ fmtSoles(r.total_dia) }}</p>
            <p class="mt-1 text-xs text-gray-400">{{ r.cantidad_recibos }} {{ r.cantidad_recibos === 1 ? 'recibo' : 'recibos' }}</p>
          </div>

          <!-- Efectivo -->
          <div class="rounded-2xl border border-green-200 bg-green-50 p-5 shadow-sm dark:border-green-800 dark:bg-green-900/20">
            <div class="flex items-start justify-between">
              <div>
                <p class="text-xs font-medium uppercase tracking-wider text-green-600 dark:text-green-400">Efectivo (Gaveta)</p>
                <p class="mt-2 text-2xl font-bold text-green-700 dark:text-green-300">{{ fmtSoles(r.total_efectivo) }}</p>
              </div>
              <div class="flex h-10 w-10 items-center justify-center rounded-xl bg-green-100 dark:bg-green-900/40">
                <svg class="h-5 w-5 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z"/>
                </svg>
              </div>
            </div>
            <p class="mt-1 text-xs text-green-500 dark:text-green-500">
              {{ r.total_dia > 0 ? ((r.total_efectivo / r.total_dia) * 100).toFixed(0) : 0 }}% del total
            </p>
          </div>

          <!-- Transferencia -->
          <div class="rounded-2xl border border-blue-200 bg-blue-50 p-5 shadow-sm dark:border-blue-800 dark:bg-blue-900/20">
            <div class="flex items-start justify-between">
              <div>
                <p class="text-xs font-medium uppercase tracking-wider text-blue-600 dark:text-blue-400">Transferencia / QR</p>
                <p class="mt-2 text-2xl font-bold text-blue-700 dark:text-blue-300">{{ fmtSoles(r.total_transferencia) }}</p>
              </div>
              <div class="flex h-10 w-10 items-center justify-center rounded-xl bg-blue-100 dark:bg-blue-900/40">
                <svg class="h-5 w-5 text-blue-600 dark:text-blue-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
                </svg>
              </div>
            </div>
            <p class="mt-1 text-xs text-blue-500 dark:text-blue-500">
              {{ r.total_dia > 0 ? ((r.total_transferencia / r.total_dia) * 100).toFixed(0) : 0 }}% del total
            </p>
          </div>

          <!-- Conceptos distintos -->
          <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
            <p class="text-xs font-medium uppercase tracking-wider text-gray-400 dark:text-gray-500">Conceptos Cobrados</p>
            <p class="mt-2 text-2xl font-bold text-gray-900 dark:text-white">{{ r.por_concepto.length }}</p>
            <p class="mt-1 text-xs text-gray-400">categorías distintas</p>
          </div>
        </div>

        <!-- ── FILA 2: Por concepto + Método de pago ─────────────────────── -->
        <div class="mb-6 grid grid-cols-1 gap-4 lg:grid-cols-5">

          <!-- Tabla: desglose por concepto (col 3/5) -->
          <div class="lg:col-span-3 rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark">
            <div class="border-b border-gray-200 px-5 py-4 dark:border-gray-700">
              <h3 class="text-sm font-semibold text-gray-800 dark:text-white">Desglose por concepto</h3>
            </div>
            @if (r.por_concepto.length === 0) {
              <p class="p-6 text-center text-sm text-gray-400 dark:text-gray-500">Sin cobros en esta fecha.</p>
            } @else {
              <div class="overflow-x-auto">
                <table class="w-full text-sm">
                  <thead class="bg-gray-50 dark:bg-gray-700/40">
                    <tr>
                      <th class="px-5 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Concepto</th>
                      <th class="px-5 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Recibos</th>
                      <th class="px-5 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Monto</th>
                      <th class="px-5 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">% del día</th>
                    </tr>
                  </thead>
                  <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                    @for (c of r.por_concepto; track c.concepto) {
                      <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/30">
                        <td class="px-5 py-3 font-medium text-gray-800 dark:text-white">{{ c.concepto }}</td>
                        <td class="px-5 py-3 text-center text-gray-500 dark:text-gray-400">{{ c.cantidad }}</td>
                        <td class="px-5 py-3 text-right font-semibold text-gray-900 dark:text-white tabular-nums">{{ fmtSoles(c.monto) }}</td>
                        <td class="px-5 py-3 text-right">
                          <div class="flex items-center justify-end gap-2">
                            <div class="h-1.5 w-16 overflow-hidden rounded-full bg-gray-200 dark:bg-gray-700">
                              <div
                                class="h-full rounded-full bg-brand-500"
                                [style.width.%]="r.total_dia > 0 ? (c.monto / r.total_dia) * 100 : 0">
                              </div>
                            </div>
                            <span class="text-xs tabular-nums text-gray-500 dark:text-gray-400">
                              {{ r.total_dia > 0 ? ((c.monto / r.total_dia) * 100).toFixed(0) : 0 }}%
                            </span>
                          </div>
                        </td>
                      </tr>
                    }
                  </tbody>
                  <tfoot class="bg-gray-50 dark:bg-gray-700/40">
                    <tr>
                      <td class="px-5 py-3 text-xs font-semibold uppercase text-gray-600 dark:text-gray-300">Total</td>
                      <td></td>
                      <td class="px-5 py-3 text-right text-sm font-bold text-gray-900 dark:text-white tabular-nums">{{ fmtSoles(r.total_dia) }}</td>
                      <td></td>
                    </tr>
                  </tfoot>
                </table>
              </div>
            }
          </div>

          <!-- Desglose método de pago (col 2/5) -->
          <div class="lg:col-span-2 rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark">
            <div class="border-b border-gray-200 px-5 py-4 dark:border-gray-700">
              <h3 class="text-sm font-semibold text-gray-800 dark:text-white">Método de pago</h3>
            </div>
            <div class="p-5 space-y-5">

              <!-- Efectivo -->
              <div>
                <div class="mb-2 flex items-center justify-between">
                  <div class="flex items-center gap-2">
                    <span class="inline-flex h-6 w-6 items-center justify-center rounded-full bg-green-100 dark:bg-green-900/40">
                      <span class="h-2 w-2 rounded-full bg-green-500"></span>
                    </span>
                    <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Efectivo</span>
                  </div>
                  <span class="text-sm font-bold text-gray-900 dark:text-white tabular-nums">{{ fmtSoles(r.total_efectivo) }}</span>
                </div>
                <div class="h-2 w-full overflow-hidden rounded-full bg-gray-100 dark:bg-gray-700">
                  <div
                    class="h-full rounded-full bg-green-500 transition-all duration-500"
                    [style.width.%]="r.total_dia > 0 ? (r.total_efectivo / r.total_dia) * 100 : 0">
                  </div>
                </div>
                <p class="mt-1 text-right text-xs text-gray-400 dark:text-gray-500">
                  {{ efectivoPct() }}%
                </p>
              </div>

              <!-- Transferencia -->
              <div>
                <div class="mb-2 flex items-center justify-between">
                  <div class="flex items-center gap-2">
                    <span class="inline-flex h-6 w-6 items-center justify-center rounded-full bg-blue-100 dark:bg-blue-900/40">
                      <span class="h-2 w-2 rounded-full bg-blue-500"></span>
                    </span>
                    <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Transferencia / QR</span>
                  </div>
                  <span class="text-sm font-bold text-gray-900 dark:text-white tabular-nums">{{ fmtSoles(r.total_transferencia) }}</span>
                </div>
                <div class="h-2 w-full overflow-hidden rounded-full bg-gray-100 dark:bg-gray-700">
                  <div
                    class="h-full rounded-full bg-blue-500 transition-all duration-500"
                    [style.width.%]="r.total_dia > 0 ? (r.total_transferencia / r.total_dia) * 100 : 0">
                  </div>
                </div>
                <p class="mt-1 text-right text-xs text-gray-400 dark:text-gray-500">
                  {{ transferenciaPct() }}%
                </p>
              </div>

              <div class="border-t border-gray-100 pt-4 dark:border-gray-700">
                <div class="flex justify-between text-sm">
                  <span class="text-gray-500 dark:text-gray-400">Total recaudado</span>
                  <span class="font-bold text-gray-900 dark:text-white tabular-nums">{{ fmtSoles(r.total_dia) }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- ── FILA 3: Lista detallada de recibos ──────────────────────── -->
        <div class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark">
          <div class="flex items-center justify-between border-b border-gray-200 px-5 py-4 dark:border-gray-700">
            <div>
              <h3 class="text-sm font-semibold text-gray-800 dark:text-white">Recibos emitidos</h3>
              <p class="mt-0.5 text-xs text-gray-400 dark:text-gray-500">
                {{ r.cantidad_recibos }} válido{{ r.cantidad_recibos !== 1 ? 's' : '' }}
                @if (anuladosCount() > 0) {
                  · <span class="text-red-500 dark:text-red-400 font-medium">{{ anuladosCount() }} anulado{{ anuladosCount() !== 1 ? 's' : '' }}</span>
                }
                · ordenados por hora
              </p>
            </div>
            @if (cargando()) {
              <svg class="h-4 w-4 animate-spin text-brand-500" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
              </svg>
            }
          </div>

          @if (r.recibos.length === 0) {
            <div class="flex flex-col items-center justify-center gap-2 py-16 text-gray-400 dark:text-gray-500">
              <svg class="h-10 w-10 opacity-30" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
              </svg>
              <p class="text-sm">Sin recibos registrados para esta fecha.</p>
            </div>
          } @else {
            <div class="overflow-x-auto">
              <table class="w-full text-sm">
                <thead class="bg-gray-50 dark:bg-gray-700/40">
                  <tr>
                    <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Hora</th>
                    <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Código</th>
                    <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Pagador</th>
                    <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Puesto</th>
                    <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Conceptos</th>
                    <th class="px-4 py-3 text-center text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Método</th>
                    <th class="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Monto</th>
                    @if (auth.esAdmin()) {
                      <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Cajero</th>
                    }
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                  @for (p of r.recibos; track p.id) {
                    <tr [ngClass]="p.anulado
                        ? 'bg-red-50/60 dark:bg-red-900/10 opacity-70'
                        : 'hover:bg-gray-50 dark:hover:bg-gray-700/30'"
                      class="transition">

                      <!-- Hora -->
                      <td class="px-4 py-3 text-xs font-mono whitespace-nowrap"
                        [ngClass]="p.anulado ? 'text-red-400 dark:text-red-500' : 'text-gray-500 dark:text-gray-400'">
                        {{ formatHora(p.fecha_pago) }}
                      </td>

                      <!-- Código + badge ANULADO -->
                      <td class="px-4 py-3">
                        <span class="font-mono text-xs whitespace-nowrap"
                          [ngClass]="p.anulado
                            ? 'line-through text-red-400 dark:text-red-500'
                            : 'text-brand-600 dark:text-brand-400'">
                          {{ p.codigo_transaccion }}
                        </span>
                        @if (p.anulado) {
                          <span class="mt-0.5 inline-flex items-center rounded-full bg-red-100 dark:bg-red-900/30 px-1.5 py-0.5 text-[10px] font-semibold uppercase tracking-wide text-red-600 dark:text-red-400">
                            Anulado
                          </span>
                        }
                      </td>

                      <!-- Pagador -->
                      <td class="px-4 py-3">
                        <p class="font-medium leading-tight"
                          [ngClass]="p.anulado ? 'text-gray-400 dark:text-gray-500 line-through' : 'text-gray-800 dark:text-white'">
                          {{ p.pagador }}
                        </p>
                        @if (p.anulado && p.motivo_anulacion) {
                          <p class="text-[10px] text-red-500 dark:text-red-400 mt-0.5">{{ p.motivo_anulacion }}</p>
                        }
                      </td>

                      <!-- Puesto -->
                      <td class="px-4 py-3">
                        <span class="rounded-md px-2 py-0.5 text-xs font-semibold"
                          [ngClass]="p.anulado
                            ? 'bg-gray-100 dark:bg-gray-700 text-gray-400 dark:text-gray-500'
                            : 'bg-brand-50 text-brand-600 dark:bg-brand-900/20 dark:text-brand-400'">
                          {{ p.codigo_puesto }}
                        </span>
                      </td>

                      <!-- Conceptos -->
                      <td class="px-4 py-3">
                        <div class="flex flex-wrap gap-1">
                          @for (c of p.conceptos; track c) {
                            <span class="rounded-full border px-2 py-0.5 text-xs"
                              [ngClass]="p.anulado
                                ? 'border-red-200 bg-red-50 text-red-400 dark:border-red-800 dark:bg-red-900/20 dark:text-red-500 line-through'
                                : 'border-gray-200 bg-gray-50 text-gray-500 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400'">
                              {{ c }}
                            </span>
                          }
                        </div>
                      </td>

                      <!-- Método -->
                      <td class="px-4 py-3 text-center">
                        @if (p.anulado) {
                          <span class="text-xs text-gray-400 dark:text-gray-500">—</span>
                        } @else if (p.metodo_pago === 'Efectivo') {
                          <span class="inline-flex items-center rounded-full bg-green-50 px-2.5 py-0.5 text-xs font-medium text-green-700 dark:bg-green-900/30 dark:text-green-400">
                            Efectivo
                          </span>
                        } @else {
                          <span class="inline-flex items-center rounded-full bg-blue-50 px-2.5 py-0.5 text-xs font-medium text-blue-700 dark:bg-blue-900/30 dark:text-blue-400">
                            Transfer.
                          </span>
                        }
                      </td>

                      <!-- Monto -->
                      <td class="px-4 py-3 text-right font-bold tabular-nums whitespace-nowrap"
                        [ngClass]="p.anulado
                          ? 'line-through text-red-400 dark:text-red-500'
                          : 'text-gray-900 dark:text-white'">
                        {{ fmtSoles(p.monto_total) }}
                      </td>

                      <!-- Cajero (solo Admin) -->
                      @if (auth.esAdmin()) {
                        <td class="px-4 py-3 text-xs"
                          [ngClass]="p.anulado ? 'text-gray-400 dark:text-gray-500' : 'text-gray-500 dark:text-gray-400'">
                          {{ p.cajero_nombre }}
                        </td>
                      }
                    </tr>
                  }
                </tbody>
              </table>
            </div>

            <!-- Totales pie de tabla -->
            <div class="flex items-center justify-between border-t border-gray-200 px-5 py-3 dark:border-gray-700">
              <p class="text-xs text-gray-400 dark:text-gray-500">
                Válidos: {{ r.cantidad_recibos }} ·
                Efectivo: {{ fmtSoles(r.total_efectivo) }} ·
                Transferencia: {{ fmtSoles(r.total_transferencia) }}
                @if (anuladosCount() > 0) {
                  · <span class="text-red-400">Anulados: {{ anuladosCount() }}</span>
                }
              </p>
              <p class="text-sm font-bold text-gray-900 dark:text-white">
                Total: {{ fmtSoles(r.total_dia) }}
              </p>
            </div>
          }
        </div>
      }
    </div>
  `,
})
export class ArqueoCajaComponent implements OnInit {
  protected readonly auth = inject(AuthService);
  private readonly reportesSvc = inject(ReportesService);
  private readonly pdfSvc      = inject(PdfGeneratorService);

  // Helpers expuestos al template
  protected readonly fmtSoles        = fmtSoles;
  protected readonly formatHora      = formatHora;
  protected readonly formatFechaLarga = formatFechaLarga;
  protected readonly hoy             = hoyISO();

  // Estado
  readonly fecha         = signal(hoyISO());
  readonly soloMiCajero  = signal(!this.auth.esAdmin()); // Caja siempre filtra por cajero
  readonly cargando      = signal(false);
  readonly error         = signal<string | null>(null);
  readonly resumen       = signal<ArqueoResumen | null>(null);
  readonly generandoPdf  = signal(false);

  // Conteo de recibos anulados (solo para el label del encabezado de tabla)
  readonly anuladosCount = computed(() =>
    this.resumen()?.recibos.filter(r => r.anulado).length ?? 0,
  );

  // Computed para los porcentajes de la barra de métodos
  readonly efectivoPct = computed(() => {
    const r = this.resumen();
    if (!r || r.total_dia === 0) return '0';
    return ((r.total_efectivo / r.total_dia) * 100).toFixed(0);
  });

  readonly transferenciaPct = computed(() => {
    const r = this.resumen();
    if (!r || r.total_dia === 0) return '0';
    return ((r.total_transferencia / r.total_dia) * 100).toFixed(0);
  });

  ngOnInit(): void {
    void this.cargar();
  }

  async cargar(): Promise<void> {
    this.cargando.set(true);
    this.error.set(null);
    try {
      const r = await this.reportesSvc.cargarArqueo(
        this.fecha(),
        this.soloMiCajero(),
      );
      this.resumen.set(r);
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar el arqueo');
    } finally {
      this.cargando.set(false);
    }
  }

  onFechaChange(ev: Event): void {
    const val = (ev.target as HTMLInputElement).value;
    if (val) {
      this.fecha.set(val);
      void this.cargar();
    }
  }

  onToggleCajero(): void {
    if (!this.auth.esAdmin()) return; // Caja nunca puede ver otros cajeros
    this.soloMiCajero.set(!this.soloMiCajero());
    void this.cargar();
  }

  async imprimirArqueo(): Promise<void> {
    const r = this.resumen();
    if (!r) return;

    const cajero = this.auth.perfil()?.nombres
      ?? this.auth.perfil()?.email
      ?? 'Sistema de Recaudación';

    this.generandoPdf.set(true);
    try {
      await this.pdfSvc.generarArqueoYAbrir(r, cajero);
    } catch (e: unknown) {
      this.error.set(`Error al generar PDF: ${e instanceof Error ? e.message : 'error desconocido'}`);
    } finally {
      this.generandoPdf.set(false);
    }
  }
}
