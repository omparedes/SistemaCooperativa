import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { NgClass } from '@angular/common';
import { AuthService } from '../../core/services/auth.service';
import { PdfGeneratorService } from '../../core/services/pdf-generator.service';
import {
  ArqueoResumen,
  ReportesService,
} from '../../core/services/reportes.service';

type AjusteTipo = 'FALTANTE' | 'SOBRANTE';

// ---------------------------------------------------------------------------
// Helpers de formato
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

function fmtFechaCorta(yyyymmdd: string): string {
  const [y, m, d] = yyyymmdd.split('-').map(Number);
  return `${String(d).padStart(2, '0')}/${String(m).padStart(2, '0')}/${y}`;
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

          @if (auth.esAdmin()) {
            <label class="flex cursor-pointer items-center gap-2 text-sm text-gray-600 dark:text-gray-400">
              <div class="relative">
                <input type="checkbox" class="sr-only peer"
                  [checked]="soloMiCajero()"
                  (change)="onToggleCajero()" />
                <div class="h-5 w-9 rounded-full bg-gray-200 peer-checked:bg-brand-500 dark:bg-gray-700 transition-colors"></div>
                <div class="absolute left-0.5 top-0.5 h-4 w-4 rounded-full bg-white shadow transition-transform peer-checked:translate-x-4"></div>
              </div>
              Solo mi caja
            </label>
          }

          <button
            (click)="cargar()"
            [disabled]="cargando()"
            class="flex h-9 items-center gap-1.5 rounded-lg border border-gray-300 px-3 text-sm text-gray-600 transition hover:bg-gray-50 disabled:opacity-50 dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700">
            <svg class="h-4 w-4" [class.animate-spin]="cargando()" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
            </svg>
            Actualizar
          </button>

          @if (auth.esAdmin() && resumen()) {
            <button
              (click)="abrirModalAjuste()"
              class="flex h-9 items-center gap-1.5 rounded-lg border border-amber-300 bg-amber-50 px-3 text-sm font-medium text-amber-700 transition hover:bg-amber-100 dark:border-amber-700 dark:bg-amber-900/30 dark:text-amber-300 dark:hover:bg-amber-900/50">
              <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3m0 0v3m0-3h3m-3 0H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
              Ajuste (Faltante/Sobrante)
            </button>
          }

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

      <!-- ── Skeleton ──────────────────────────────────────────────────── -->
      @if (cargando() && !resumen()) {
        <div class="grid grid-cols-2 gap-4 sm:grid-cols-3 xl:grid-cols-5 mb-6">
          @for (i of [1,2,3,4,5]; track i) {
            <div class="animate-pulse rounded-2xl border border-gray-200 bg-white p-5 dark:border-gray-700 dark:bg-gray-800">
              <div class="h-3 w-24 rounded bg-gray-200 dark:bg-gray-700 mb-3"></div>
              <div class="h-7 w-32 rounded bg-gray-200 dark:bg-gray-700"></div>
            </div>
          }
        </div>
      }

      <!-- ── APERTURA DE CAJA (barra siempre visible si hay datos) ────────── -->
      @if (resumen()) {
        <div class="mb-4 flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between rounded-xl border px-4 py-3"
          [class]="resumen()!.apertura
            ? 'border-emerald-200 bg-emerald-50 dark:border-emerald-800/50 dark:bg-emerald-900/20'
            : 'border-amber-200 bg-amber-50 dark:border-amber-800/50 dark:bg-amber-900/20'">

          @if (!editandoApertura()) {
            <div class="flex items-center gap-3">
              <div class="flex h-9 w-9 items-center justify-center rounded-lg"
                [class]="resumen()!.apertura ? 'bg-emerald-100 dark:bg-emerald-900/40' : 'bg-amber-100 dark:bg-amber-900/40'">
                <svg class="h-5 w-5" [class]="resumen()!.apertura ? 'text-emerald-600 dark:text-emerald-400' : 'text-amber-600 dark:text-amber-400'"
                  fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
              </div>
              <div>
                <p class="text-xs font-semibold uppercase tracking-wider"
                  [class]="resumen()!.apertura ? 'text-emerald-600 dark:text-emerald-400' : 'text-amber-600 dark:text-amber-400'">
                  Apertura de Caja
                </p>
                @if (resumen()!.apertura) {
                  <p class="text-lg font-bold text-emerald-700 dark:text-emerald-300">
                    {{ fmtSoles(resumen()!.apertura_monto) }}
                  </p>
                } @else {
                  <p class="text-sm font-medium text-amber-700 dark:text-amber-300">
                    Sin apertura registrada para esta fecha
                  </p>
                }
              </div>
            </div>
            @if (auth.esAdmin()) {
              <button
                (click)="abrirEdicionApertura()"
                class="flex items-center gap-1.5 rounded-lg border px-3 py-1.5 text-sm font-medium transition"
                [class]="resumen()!.apertura
                  ? 'border-emerald-300 text-emerald-700 hover:bg-emerald-100 dark:border-emerald-700 dark:text-emerald-300 dark:hover:bg-emerald-900/40'
                  : 'border-amber-300 bg-amber-100 text-amber-800 hover:bg-amber-200 dark:border-amber-700 dark:bg-amber-900/40 dark:text-amber-200 dark:hover:bg-amber-900/60'">
                <svg class="h-3.5 w-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                </svg>
                {{ resumen()!.apertura ? 'Editar apertura' : 'Registrar apertura' }}
              </button>
            }
          } @else {
            <!-- Formulario inline de edición de apertura -->
            <div class="flex items-center gap-2">
              <span class="text-sm font-medium text-emerald-700 dark:text-emerald-300">Saldo inicial S/</span>
              <input
                type="number"
                min="0"
                step="0.01"
                [value]="montoAperturaInput()"
                (input)="onMontoAperturaInput($event)"
                class="h-9 w-32 rounded-lg border border-emerald-300 bg-white px-3 text-sm text-gray-800 outline-none focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 dark:border-emerald-700 dark:bg-gray-800 dark:text-white"
                placeholder="0.00"
              />
            </div>
            <div class="flex items-center gap-2">
              <button
                (click)="guardarApertura()"
                [disabled]="guardandoApertura()"
                class="flex h-9 items-center gap-1.5 rounded-lg bg-emerald-600 px-4 text-sm font-medium text-white transition hover:bg-emerald-700 disabled:opacity-60">
                @if (guardandoApertura()) { Guardando… } @else { Guardar }
              </button>
              <button
                (click)="cancelarEdicionApertura()"
                [disabled]="guardandoApertura()"
                class="h-9 rounded-lg border border-gray-300 px-4 text-sm text-gray-600 transition hover:bg-gray-50 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700">
                Cancelar
              </button>
            </div>
          }
        </div>
      }

      @if (resumen(); as r) {

        <!-- ═══════════════════════════════════════════════════════════════ -->
        <!-- FILA 1: KPI Cards — Resumen financiero principal               -->
        <!-- ═══════════════════════════════════════════════════════════════ -->
        <div class="mb-4 grid grid-cols-2 gap-4 sm:grid-cols-3 xl:grid-cols-5">

          <!-- Total Recaudado (Ingresos) -->
          <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
            <p class="text-xs font-medium uppercase tracking-wider text-gray-400 dark:text-gray-500">Total Recaudado (Ingresos)</p>
            <p class="mt-2 text-2xl font-bold text-gray-900 dark:text-white">{{ fmtSoles(r.total_dia) }}</p>
            <p class="mt-1 text-xs text-gray-400">
              {{ r.cantidad_recibos }} {{ r.cantidad_recibos === 1 ? 'recibo' : 'recibos' }}
              @if (r.cantidad_ingresos_internos > 0) {
                · <span class="text-violet-500">{{ r.cantidad_ingresos_internos }} sin recibo</span>
              }
            </p>
          </div>

          <!-- Efectivo Físico Real en Gaveta -->
          <div class="rounded-2xl border border-green-200 bg-green-50 p-5 shadow-sm dark:border-green-800 dark:bg-green-900/20">
            <div class="flex items-start justify-between">
              <div>
                <p class="text-xs font-medium uppercase tracking-wider text-green-600 dark:text-green-400">Efectivo en Gaveta</p>
                <p class="mt-2 text-2xl font-bold text-green-700 dark:text-green-300">{{ fmtSoles(r.efectivo_fisico_caja) }}</p>
              </div>
              <div class="flex h-10 w-10 items-center justify-center rounded-xl bg-green-100 dark:bg-green-900/40">
                <svg class="h-5 w-5 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z"/>
                </svg>
              </div>
            </div>
            <p class="mt-1 text-xs text-green-500">
              Cobrado S/ {{ fmtSoles(r.total_efectivo) }}
              @if (r.apertura_monto > 0) {
                · Apertura S/ {{ fmtSoles(r.apertura_monto) }}
              }
              @if (r.total_faltantes > 0 || r.total_sobrantes > 0) {
                · <span class="text-amber-600 dark:text-amber-400">ajustes aplicados</span>
              }
            </p>
          </div>

          <!-- Transferencia / QR — NO cuenta en caja física -->
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
            <p class="mt-1 text-xs text-blue-500">
              {{ r.total_dia > 0 ? ((r.total_transferencia / r.total_dia) * 100).toFixed(0) : 0 }}% del total
              · <span class="font-medium">No entra a gaveta</span>
            </p>
          </div>

          <!-- Egresos (Salidas) -->
          <div class="rounded-2xl border border-orange-200 bg-orange-50 p-5 shadow-sm dark:border-orange-800 dark:bg-orange-900/20">
            <div class="flex items-start justify-between">
              <div>
                <p class="text-xs font-medium uppercase tracking-wider text-orange-600 dark:text-orange-400">Egresos (Salidas)</p>
                <p class="mt-2 text-2xl font-bold text-orange-700 dark:text-orange-300">{{ fmtSoles(r.total_gastos) }}</p>
              </div>
              <div class="flex h-10 w-10 items-center justify-center rounded-xl bg-orange-100 dark:bg-orange-900/40">
                <svg class="h-5 w-5 text-orange-600 dark:text-orange-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19 14l-7 7m0 0l-7-7m7 7V3"/>
                </svg>
              </div>
            </div>
            <p class="mt-1 text-xs text-orange-500 dark:text-orange-500">
              {{ r.gastos.length }} egreso{{ r.gastos.length !== 1 ? 's' : '' }} registrado{{ r.gastos.length !== 1 ? 's' : '' }}
            </p>
          </div>

          <!-- SALDO NETO EN CAJA -->
          <div class="rounded-2xl border-2 p-5 shadow-md"
            [ngClass]="r.saldo_neto >= 0
              ? 'border-brand-400 bg-brand-50 dark:border-brand-600 dark:bg-brand-900/20'
              : 'border-red-400 bg-red-50 dark:border-red-600 dark:bg-red-900/20'">
            <p class="text-xs font-medium uppercase tracking-wider"
              [ngClass]="r.saldo_neto >= 0 ? 'text-brand-600 dark:text-brand-400' : 'text-red-600 dark:text-red-400'">
              Saldo Neto en Caja
            </p>
            <p class="mt-2 text-2xl font-bold"
              [ngClass]="r.saldo_neto >= 0 ? 'text-brand-700 dark:text-brand-300' : 'text-red-700 dark:text-red-300'">
              {{ fmtSoles(r.saldo_neto) }}
            </p>
            <p class="mt-1 text-xs"
              [ngClass]="r.saldo_neto >= 0 ? 'text-brand-500' : 'text-red-500'">
              Ingresos − Egresos
            </p>
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
                              <div class="h-full rounded-full bg-brand-500"
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

          <!-- Método de pago + resumen financiero (col 2/5) -->
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
                  <div class="h-full rounded-full bg-green-500 transition-all duration-500"
                    [style.width.%]="r.total_dia > 0 ? (r.total_efectivo / r.total_dia) * 100 : 0">
                  </div>
                </div>
                <p class="mt-1 text-right text-xs text-gray-400 dark:text-gray-500">{{ efectivoPct() }}%</p>
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
                  <div class="h-full rounded-full bg-blue-500 transition-all duration-500"
                    [style.width.%]="r.total_dia > 0 ? (r.total_transferencia / r.total_dia) * 100 : 0">
                  </div>
                </div>
                <p class="mt-1 text-right text-xs text-gray-400 dark:text-gray-500">{{ transferenciaPct() }}%</p>
              </div>
              <!-- Desglose efectivo físico en gaveta -->
              <div class="border-t border-gray-100 pt-4 dark:border-gray-700 space-y-1.5">
                <p class="text-xs font-semibold uppercase tracking-wider text-gray-400 dark:text-gray-500 mb-2">Cálculo Efectivo Físico</p>
                @if (r.apertura_monto > 0) {
                  <div class="flex justify-between text-sm">
                    <span class="text-emerald-600 dark:text-emerald-400">(+) Apertura</span>
                    <span class="font-semibold text-emerald-600 dark:text-emerald-400 tabular-nums">{{ fmtSoles(r.apertura_monto) }}</span>
                  </div>
                }
                <div class="flex justify-between text-sm">
                  <span class="text-green-600 dark:text-green-400">(+) Cobros efectivo</span>
                  <span class="font-semibold text-green-600 dark:text-green-400 tabular-nums">{{ fmtSoles(r.total_efectivo) }}</span>
                </div>
                @if (r.total_gastos > 0) {
                  <div class="flex justify-between text-sm">
                    <span class="text-orange-600 dark:text-orange-400">(−) Egresos</span>
                    <span class="font-semibold text-orange-600 dark:text-orange-400 tabular-nums">{{ fmtSoles(r.total_gastos) }}</span>
                  </div>
                }
                @if (r.total_faltantes > 0) {
                  <div class="flex justify-between text-sm">
                    <span class="text-red-500 dark:text-red-400">(−) Faltantes</span>
                    <span class="font-semibold text-red-500 dark:text-red-400 tabular-nums">{{ fmtSoles(r.total_faltantes) }}</span>
                  </div>
                }
                @if (r.total_sobrantes > 0) {
                  <div class="flex justify-between text-sm">
                    <span class="text-teal-600 dark:text-teal-400">(+) Sobrantes</span>
                    <span class="font-semibold text-teal-600 dark:text-teal-400 tabular-nums">{{ fmtSoles(r.total_sobrantes) }}</span>
                  </div>
                }
                <div class="flex justify-between text-sm border-t border-dashed border-gray-200 dark:border-gray-700 pt-1.5">
                  <span class="font-bold text-green-700 dark:text-green-300">(=) Gaveta real</span>
                  <span class="font-bold tabular-nums text-green-700 dark:text-green-300">{{ fmtSoles(r.efectivo_fisico_caja) }}</span>
                </div>
                @if (r.total_transferencia > 0) {
                  <div class="flex justify-between text-xs border-t border-gray-100 dark:border-gray-700 pt-1.5 mt-1">
                    <span class="text-blue-500 dark:text-blue-400">+ Transferencias (banco)</span>
                    <span class="tabular-nums text-blue-500 dark:text-blue-400">{{ fmtSoles(r.total_transferencia) }}</span>
                  </div>
                  <div class="flex justify-between text-xs">
                    <span class="font-semibold text-gray-500 dark:text-gray-400">Total contable</span>
                    <span class="font-semibold tabular-nums text-gray-700 dark:text-gray-200">{{ fmtSoles(r.saldo_neto) }}</span>
                  </div>
                }
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
                @if (r.cantidad_ingresos_internos > 0) {
                  · <span class="text-violet-500 dark:text-violet-400 font-medium">{{ r.cantidad_ingresos_internos }} sin recibo</span>
                }
                @if (r.cantidad_recaudacion_tarjeta > 0) {
                  · <span class="text-emerald-500 dark:text-emerald-400 font-medium">{{ r.cantidad_recaudacion_tarjeta }} tarjeta prepago</span>
                }
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
                  @for (p of r.recibos; track (p.es_recaudacion_tarjeta ? 'rec' : p.es_ingreso_interno ? 'ii' : 'pago') + p.id) {
                    <tr [ngClass]="p.anulado
                        ? 'bg-red-50/60 dark:bg-red-900/10 opacity-70'
                        : p.es_recaudacion_tarjeta
                          ? 'bg-emerald-50/40 dark:bg-emerald-900/10 hover:bg-emerald-50 dark:hover:bg-emerald-900/20'
                          : p.es_ingreso_interno
                            ? 'bg-violet-50/40 dark:bg-violet-900/10 hover:bg-violet-50 dark:hover:bg-violet-900/20'
                            : 'hover:bg-gray-50 dark:hover:bg-gray-700/30'"
                      class="transition">
                      <td class="px-4 py-3 text-xs font-mono whitespace-nowrap"
                        [ngClass]="p.anulado ? 'text-red-400 dark:text-red-500' : 'text-gray-500 dark:text-gray-400'">
                        {{ formatHora(p.fecha_pago) }}
                      </td>
                      <td class="px-4 py-3">
                        <span class="font-mono text-xs whitespace-nowrap"
                          [ngClass]="p.anulado
                            ? 'line-through text-red-400 dark:text-red-500'
                            : p.es_recaudacion_tarjeta
                              ? 'text-emerald-600 dark:text-emerald-400'
                              : p.es_ingreso_interno
                                ? 'text-violet-600 dark:text-violet-400'
                                : 'text-brand-600 dark:text-brand-400'">
                          {{ p.codigo_transaccion }}
                        </span>
                        @if (p.anulado) {
                          <span class="mt-0.5 inline-flex items-center rounded-full bg-red-100 dark:bg-red-900/30 px-1.5 py-0.5 text-[10px] font-semibold uppercase tracking-wide text-red-600 dark:text-red-400">Anulado</span>
                        }
                        @if (p.es_recaudacion_tarjeta) {
                          <span class="mt-0.5 inline-flex items-center rounded-full bg-emerald-100 dark:bg-emerald-900/30 px-1.5 py-0.5 text-[10px] font-semibold uppercase tracking-wide text-emerald-600 dark:text-emerald-400">Tarjeta</span>
                        }
                        @if (p.es_ingreso_interno) {
                          <span class="mt-0.5 inline-flex items-center rounded-full bg-violet-100 dark:bg-violet-900/30 px-1.5 py-0.5 text-[10px] font-semibold uppercase tracking-wide text-violet-600 dark:text-violet-400">Sin Recibo</span>
                        }
                      </td>
                      <td class="px-4 py-3">
                        <p class="font-medium leading-tight"
                          [ngClass]="p.anulado ? 'text-gray-400 dark:text-gray-500 line-through' : 'text-gray-800 dark:text-white'">
                          {{ p.pagador }}
                        </p>
                        @if (p.anulado && p.motivo_anulacion) {
                          <p class="text-[10px] text-red-500 dark:text-red-400 mt-0.5">{{ p.motivo_anulacion }}</p>
                        }
                      </td>
                      <td class="px-4 py-3">
                        <span class="rounded-md px-2 py-0.5 text-xs font-semibold"
                          [ngClass]="p.anulado
                            ? 'bg-gray-100 dark:bg-gray-700 text-gray-400 dark:text-gray-500'
                            : 'bg-brand-50 text-brand-600 dark:bg-brand-900/20 dark:text-brand-400'">
                          {{ p.codigo_puesto }}
                        </span>
                      </td>
                      <td class="px-4 py-3">
                        <div class="flex flex-wrap gap-1">
                          @for (c of p.conceptos; track c) {
                            <span class="rounded-full border px-2 py-0.5 text-xs"
                              [ngClass]="p.anulado
                                ? 'border-red-200 bg-red-50 text-red-400 dark:border-red-800 dark:bg-red-900/20 dark:text-red-500 line-through'
                                : p.es_recaudacion_tarjeta
                                  ? 'border-emerald-200 bg-emerald-50 text-emerald-600 dark:border-emerald-800 dark:bg-emerald-900/20 dark:text-emerald-400 font-medium'
                                  : 'border-gray-200 bg-gray-50 text-gray-500 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-400'">
                              {{ c }}
                            </span>
                          }
                        </div>
                      </td>
                      <td class="px-4 py-3 text-center">
                        @if (p.anulado) {
                          <span class="text-xs text-gray-400 dark:text-gray-500">—</span>
                        } @else if (p.es_recaudacion_tarjeta) {
                          <span class="inline-flex items-center rounded-full bg-emerald-50 px-2.5 py-0.5 text-xs font-medium text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400">Prepago</span>
                        } @else if (p.metodo_pago === 'Efectivo') {
                          <span class="inline-flex items-center rounded-full bg-green-50 px-2.5 py-0.5 text-xs font-medium text-green-700 dark:bg-green-900/30 dark:text-green-400">Efectivo</span>
                        } @else {
                          <span class="inline-flex items-center rounded-full bg-blue-50 px-2.5 py-0.5 text-xs font-medium text-blue-700 dark:bg-blue-900/30 dark:text-blue-400">Transfer.</span>
                        }
                      </td>
                      <td class="px-4 py-3 text-right font-bold tabular-nums whitespace-nowrap"
                        [ngClass]="p.anulado ? 'line-through text-red-400 dark:text-red-500' : 'text-gray-900 dark:text-white'">
                        {{ fmtSoles(p.monto_total) }}
                      </td>
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
            <div class="flex items-center justify-between border-t border-gray-200 px-5 py-3 dark:border-gray-700">
              <p class="text-xs text-gray-400 dark:text-gray-500">
                Recibos: {{ r.cantidad_recibos }}
                @if (r.cantidad_ingresos_internos > 0) {
                  · <span class="text-violet-400">Sin recibo: {{ r.cantidad_ingresos_internos }}</span>
                }
                @if (r.cantidad_recaudacion_tarjeta > 0) {
                  · <span class="text-emerald-500">Tarjeta: {{ r.cantidad_recaudacion_tarjeta }}</span>
                }
                @if (anuladosCount() > 0) {
                  · <span class="text-red-400">Anulados: {{ anuladosCount() }}</span>
                }
                · Efectivo: {{ fmtSoles(r.total_efectivo) }}
                · Transferencia: {{ fmtSoles(r.total_transferencia) }}
              </p>
              <p class="text-sm font-bold text-gray-900 dark:text-white">
                Total: {{ fmtSoles(r.total_dia) }}
              </p>
            </div>
          }
        </div>

        <!-- ── FILA 4: Salidas de Caja (Egresos) ───────────────────────── -->
        <div class="mt-6 rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark">
          <div class="flex items-center justify-between border-b border-orange-100 bg-orange-50/60 px-5 py-4 dark:border-orange-900/30 dark:bg-orange-900/10 rounded-t-2xl">
            <div>
              <h3 class="text-sm font-semibold text-orange-800 dark:text-orange-300">Salidas de Caja (Egresos)</h3>
              <p class="mt-0.5 text-xs text-orange-500 dark:text-orange-400">
                {{ r.gastos.length }} egreso{{ r.gastos.length !== 1 ? 's' : '' }} registrado{{ r.gastos.length !== 1 ? 's' : '' }} en esta fecha
              </p>
            </div>
            <div class="flex h-8 w-8 items-center justify-center rounded-lg bg-orange-100 dark:bg-orange-900/40">
              <svg class="h-4 w-4 text-orange-600 dark:text-orange-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M19 14l-7 7m0 0l-7-7m7 7V3"/>
              </svg>
            </div>
          </div>

          @if (r.gastos.length === 0) {
            <div class="flex flex-col items-center justify-center gap-2 py-12 text-gray-400 dark:text-gray-500">
              <svg class="h-10 w-10 opacity-30" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12c-.725 0-1.45-.22-2.003-.659-1.106-.879-1.106-2.303 0-3.182s2.9-.879 4.006 0l.415.33M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
              <p class="text-sm font-medium">Sin egresos registrados para esta fecha.</p>
            </div>
          } @else {
            <div class="overflow-x-auto">
              <table class="w-full text-sm">
                <thead class="bg-gray-50 dark:bg-gray-700/40">
                  <tr>
                    <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Fecha</th>
                    <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Comprobante</th>
                    <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Responsable</th>
                    <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Categoría</th>
                    <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Detalle</th>
                    <th class="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Monto</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                  @for (g of r.gastos; track g.id) {
                    <tr class="hover:bg-orange-50/40 dark:hover:bg-orange-900/10 transition">
                      <td class="px-4 py-3 text-xs whitespace-nowrap text-gray-500 dark:text-gray-400">
                        {{ fmtFechaCorta(g.fecha) }}
                      </td>
                      <td class="px-4 py-3 font-mono text-xs text-gray-500 dark:text-gray-400 whitespace-nowrap">
                        {{ g.comprobante_ref || '—' }}
                      </td>
                      <td class="px-4 py-3 font-medium text-gray-800 dark:text-white whitespace-nowrap">
                        {{ g.responsable || '—' }}
                      </td>
                      <td class="px-4 py-3">
                        <span class="inline-flex items-center rounded-full bg-orange-50 px-2 py-0.5 text-xs font-medium text-orange-700 dark:bg-orange-900/30 dark:text-orange-400">
                          {{ g.categoria_nombre }}
                        </span>
                      </td>
                      <td class="px-4 py-3 text-gray-600 dark:text-gray-300 max-w-xs">
                        {{ g.descripcion || '—' }}
                      </td>
                      <td class="px-4 py-3 text-right font-bold tabular-nums whitespace-nowrap text-red-600 dark:text-red-400">
                        {{ fmtSoles(g.monto) }}
                      </td>
                    </tr>
                  }
                </tbody>
              </table>
            </div>
            <!-- Footer egresos -->
            <div class="flex items-center justify-between border-t border-gray-200 px-5 py-3 dark:border-gray-700">
              <p class="text-xs text-gray-400 dark:text-gray-500">
                {{ r.gastos.length }} egreso{{ r.gastos.length !== 1 ? 's' : '' }} del día
              </p>
              <p class="text-sm font-bold text-red-600 dark:text-red-400">
                Total Egresos: {{ fmtSoles(r.total_gastos) }}
              </p>
            </div>
          }
        </div>

        <!-- ── FILA 5: Ajustes (Faltantes / Sobrantes) ────────────────── -->
        @if (r.ajustes.length > 0) {
          <div class="mt-6 rounded-2xl border border-amber-200 bg-white shadow-sm dark:border-amber-800/50 dark:bg-gray-dark">
            <div class="flex items-center justify-between border-b border-amber-100 bg-amber-50/60 px-5 py-4 dark:border-amber-900/30 dark:bg-amber-900/10 rounded-t-2xl">
              <div>
                <h3 class="text-sm font-semibold text-amber-800 dark:text-amber-300">Ajustes de Cuadre Físico</h3>
                <p class="mt-0.5 text-xs text-amber-500 dark:text-amber-400">
                  {{ r.ajustes.length }} ajuste{{ r.ajustes.length !== 1 ? 's' : '' }}
                  @if (r.total_faltantes > 0) {
                    · <span class="text-red-500">Faltantes: {{ fmtSoles(r.total_faltantes) }}</span>
                  }
                  @if (r.total_sobrantes > 0) {
                    · <span class="text-teal-600">Sobrantes: {{ fmtSoles(r.total_sobrantes) }}</span>
                  }
                </p>
              </div>
            </div>
            <div class="overflow-x-auto">
              <table class="w-full text-sm">
                <thead class="bg-gray-50 dark:bg-gray-700/40">
                  <tr>
                    <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Tipo</th>
                    <th class="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Descripción</th>
                    <th class="px-4 py-3 text-right text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">Monto</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                  @for (a of r.ajustes; track a.id) {
                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/30">
                      <td class="px-4 py-3">
                        <span class="inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold uppercase"
                          [ngClass]="a.tipo === 'FALTANTE'
                            ? 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400'
                            : 'bg-teal-100 text-teal-700 dark:bg-teal-900/30 dark:text-teal-400'">
                          {{ a.tipo === 'FALTANTE' ? '− Faltante' : '+ Sobrante' }}
                        </span>
                      </td>
                      <td class="px-4 py-3 text-gray-600 dark:text-gray-300">{{ a.descripcion || '—' }}</td>
                      <td class="px-4 py-3 text-right font-bold tabular-nums"
                        [ngClass]="a.tipo === 'FALTANTE' ? 'text-red-600 dark:text-red-400' : 'text-teal-600 dark:text-teal-400'">
                        {{ a.tipo === 'FALTANTE' ? '−' : '+' }} {{ fmtSoles(a.monto) }}
                      </td>
                    </tr>
                  }
                </tbody>
              </table>
            </div>
          </div>
        }

      }

      <!-- ── MODAL: Registrar Faltante / Sobrante ─────────────────────────── -->
      @if (mostrarModalAjuste()) {
        <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4"
          (click)="cerrarModalAjuste()">
          <div class="w-full max-w-md rounded-2xl border border-gray-200 bg-white shadow-xl dark:border-gray-700 dark:bg-gray-dark"
            (click)="$event.stopPropagation()">
            <!-- Header del modal -->
            <div class="flex items-center justify-between border-b border-gray-200 px-5 py-4 dark:border-gray-700">
              <h3 class="text-base font-semibold text-gray-800 dark:text-white">Registrar Ajuste de Caja</h3>
              <button (click)="cerrarModalAjuste()"
                class="flex h-7 w-7 items-center justify-center rounded-lg text-gray-400 transition hover:bg-gray-100 hover:text-gray-600 dark:hover:bg-gray-700">
                <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
                </svg>
              </button>
            </div>

            <!-- Body del modal -->
            <div class="space-y-4 p-5">
              <!-- Tipo -->
              <div>
                <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">Tipo de ajuste</label>
                <div class="flex gap-2">
                  <button
                    (click)="ajusteTipo.set('FALTANTE')"
                    class="flex-1 rounded-lg border py-2 text-sm font-medium transition"
                    [ngClass]="ajusteTipo() === 'FALTANTE'
                      ? 'border-red-500 bg-red-500 text-white'
                      : 'border-gray-300 bg-gray-50 text-gray-600 hover:border-red-400 dark:border-gray-600 dark:bg-gray-700 dark:text-gray-300'">
                    − Faltante
                  </button>
                  <button
                    (click)="ajusteTipo.set('SOBRANTE')"
                    class="flex-1 rounded-lg border py-2 text-sm font-medium transition"
                    [ngClass]="ajusteTipo() === 'SOBRANTE'
                      ? 'border-teal-500 bg-teal-500 text-white'
                      : 'border-gray-300 bg-gray-50 text-gray-600 hover:border-teal-400 dark:border-gray-600 dark:bg-gray-700 dark:text-gray-300'">
                    + Sobrante
                  </button>
                </div>
                <p class="mt-1 text-xs"
                  [ngClass]="ajusteTipo() === 'FALTANTE' ? 'text-red-500' : 'text-teal-600'">
                  @if (ajusteTipo() === 'FALTANTE') {
                    Dinero que debería estar en gaveta pero no está.
                  } @else {
                    Dinero de más encontrado en la gaveta.
                  }
                </p>
              </div>

              <!-- Monto -->
              <div>
                <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">Monto <span class="text-red-500">*</span></label>
                <div class="relative">
                  <span class="absolute left-3 top-1/2 -translate-y-1/2 text-sm font-medium text-gray-500">S/</span>
                  <input
                    type="number"
                    min="0.01"
                    step="0.01"
                    placeholder="0.00"
                    [value]="ajusteMonto()"
                    (input)="onAjusteMontoInput($event)"
                    class="h-11 w-full rounded-lg border border-gray-300 bg-gray-50 pl-8 pr-4 text-sm text-gray-800 outline-none transition focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                  />
                </div>
              </div>

              <!-- Descripción -->
              <div>
                <label class="mb-1.5 block text-sm font-medium text-gray-700 dark:text-gray-300">
                  Descripción <span class="text-xs font-normal text-gray-400">(opcional)</span>
                </label>
                <textarea
                  rows="2"
                  placeholder="Ej. Billete de S/50 faltó al contar, error en vuelto, etc."
                  class="w-full resize-none rounded-lg border border-gray-300 bg-gray-50 px-4 py-2.5 text-sm text-gray-800 outline-none transition focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 dark:border-gray-600 dark:bg-gray-700 dark:text-white"
                  [value]="ajusteDesc()"
                  (input)="onAjusteDescInput($event)"
                ></textarea>
              </div>

              @if (errorAjuste()) {
                <p class="rounded-lg bg-red-50 px-3 py-2 text-sm text-red-600 dark:bg-red-900/20 dark:text-red-400">
                  {{ errorAjuste() }}
                </p>
              }
            </div>

            <!-- Footer del modal -->
            <div class="flex justify-end gap-2 border-t border-gray-200 px-5 py-4 dark:border-gray-700">
              <button (click)="cerrarModalAjuste()"
                [disabled]="guardandoAjuste()"
                class="rounded-lg border border-gray-300 px-4 py-2 text-sm text-gray-600 transition hover:bg-gray-50 disabled:opacity-40 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700">
                Cancelar
              </button>
              <button
                (click)="guardarAjuste()"
                [disabled]="guardandoAjuste()"
                class="flex items-center gap-2 rounded-lg px-5 py-2 text-sm font-medium text-white transition disabled:opacity-60"
                [ngClass]="ajusteTipo() === 'FALTANTE'
                  ? 'bg-red-600 hover:bg-red-700'
                  : 'bg-teal-600 hover:bg-teal-700'">
                @if (guardandoAjuste()) {
                  <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                  </svg>
                  Guardando…
                } @else {
                  Registrar {{ ajusteTipo() === 'FALTANTE' ? 'Faltante' : 'Sobrante' }}
                }
              </button>
            </div>
          </div>
        </div>
      }

    </div>
  `,
})
export class ArqueoCajaComponent implements OnInit {
  protected readonly auth = inject(AuthService);
  private readonly reportesSvc = inject(ReportesService);
  private readonly pdfSvc      = inject(PdfGeneratorService);

  protected readonly fmtSoles         = fmtSoles;
  protected readonly fmtFechaCorta    = fmtFechaCorta;
  protected readonly formatHora       = formatHora;
  protected readonly formatFechaLarga = formatFechaLarga;
  protected readonly hoy              = hoyISO();

  readonly fecha        = signal(hoyISO());
  readonly soloMiCajero = signal(!this.auth.esAdmin());
  readonly cargando     = signal(false);
  readonly error        = signal<string | null>(null);
  readonly resumen      = signal<ArqueoResumen | null>(null);
  readonly generandoPdf = signal(false);

  readonly anuladosCount = computed(() =>
    this.resumen()?.recibos.filter(r => r.anulado).length ?? 0,
  );

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

  // ── Apertura de caja ──────────────────────────────────────────────────────
  readonly editandoApertura  = signal(false);
  readonly guardandoApertura = signal(false);
  readonly montoAperturaInput = signal('');
  readonly errorApertura      = signal<string | null>(null);

  // ── Ajustes (faltante/sobrante) ───────────────────────────────────────────
  readonly mostrarModalAjuste = signal(false);
  readonly ajusteTipo         = signal<AjusteTipo>('FALTANTE');
  readonly ajusteMonto        = signal('');
  readonly ajusteDesc         = signal('');
  readonly guardandoAjuste    = signal(false);
  readonly errorAjuste        = signal<string | null>(null);

  // ── Handlers de apertura ─────────────────────────────────────────────────
  onMontoAperturaInput(ev: Event): void {
    this.montoAperturaInput.set((ev.target as HTMLInputElement).value);
  }

  abrirEdicionApertura(): void {
    this.montoAperturaInput.set(String(this.resumen()?.apertura_monto ?? 0));
    this.errorApertura.set(null);
    this.editandoApertura.set(true);
  }

  cancelarEdicionApertura(): void {
    this.editandoApertura.set(false);
    this.errorApertura.set(null);
  }

  async guardarApertura(): Promise<void> {
    const monto = parseFloat(this.montoAperturaInput());
    if (isNaN(monto) || monto < 0) {
      this.errorApertura.set('Ingresa un monto válido (≥ 0).');
      return;
    }
    this.guardandoApertura.set(true);
    this.errorApertura.set(null);
    try {
      await this.reportesSvc.upsertApertura(this.fecha(), monto);
      this.editandoApertura.set(false);
      await this.cargar();
    } catch (e: unknown) {
      this.errorApertura.set(e instanceof Error ? e.message : 'Error al guardar');
    } finally {
      this.guardandoApertura.set(false);
    }
  }

  // ── Handlers de ajustes ───────────────────────────────────────────────────
  onAjusteMontoInput(ev: Event): void {
    this.ajusteMonto.set((ev.target as HTMLInputElement).value);
  }

  onAjusteDescInput(ev: Event): void {
    this.ajusteDesc.set((ev.target as HTMLTextAreaElement).value);
  }

  abrirModalAjuste(): void {
    this.ajusteTipo.set('FALTANTE');
    this.ajusteMonto.set('');
    this.ajusteDesc.set('');
    this.errorAjuste.set(null);
    this.mostrarModalAjuste.set(true);
  }

  cerrarModalAjuste(): void {
    this.mostrarModalAjuste.set(false);
    this.errorAjuste.set(null);
  }

  async guardarAjuste(): Promise<void> {
    const monto = parseFloat(this.ajusteMonto());
    if (isNaN(monto) || monto <= 0) {
      this.errorAjuste.set('Ingresa un monto mayor a 0.');
      return;
    }
    this.guardandoAjuste.set(true);
    this.errorAjuste.set(null);
    try {
      await this.reportesSvc.registrarAjuste(
        this.fecha(), this.ajusteTipo(), monto, this.ajusteDesc(),
      );
      this.cerrarModalAjuste();
      await this.cargar();
    } catch (e: unknown) {
      this.errorAjuste.set(e instanceof Error ? e.message : 'Error al guardar');
    } finally {
      this.guardandoAjuste.set(false);
    }
  }

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
    if (!this.auth.esAdmin()) return;
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
