import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { NgClass } from '@angular/common';
import { FormsModule } from '@angular/forms';
import {
  ConceptoResumen,
  DetalleEgresoLinea,
  DetalleIngresoLinea,
  EgresoCategoria,
  FiltroPeriodoReporte,
  getFechaHoyLima,
  getNombreMes,
  ModoFiltroPeriodo,
  OrigenFiltroUI,
  PeriodoResuelto,
  RangoRapido,
  ReporteResumenV2,
  ReportesService,
  resolverPeriodoReporte,
  TipoPagadorFiltro,
} from '../../core/services/reportes.service';
import { ExcelExportService } from '../../core/services/excel-export.service';
import { AuthService } from '../../core/services/auth.service';

// ---------------------------------------------------------------------------
// Helpers de formato monetario y fecha
// ---------------------------------------------------------------------------
function fmtSoles(n: number): string {
  return `S/ ${(n ?? 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
}

function fmtFechaCorta(yyyymmdd: string): string {
  if (!yyyymmdd) return '—';
  const meses = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];
  const [y, m, d] = yyyymmdd.split('-').map(Number);
  return `${String(d).padStart(2, '0')} ${meses[m - 1]} ${y}`;
}

function fmtFechaHora(iso: string): string {
  if (!iso) return '—';
  const d = new Date(iso);
  const dd = String(d.getDate()).padStart(2, '0');
  const mm = String(d.getMonth() + 1).padStart(2, '0');
  const yy = d.getFullYear();
  const hh = String(d.getHours()).padStart(2, '0');
  const min = String(d.getMinutes()).padStart(2, '0');
  return `${dd}/${mm}/${yy} ${hh}:${min}`;
}

type TabVistaReporte = 'ingresos' | 'egresos' | 'combinado';

@Component({
  selector: 'app-reportes',
  standalone: true,
  imports: [NgClass, FormsModule],
  template: `
    <div class="mx-auto max-w-screen-2xl p-4 md:p-6 lg:p-8 space-y-6">

      <!-- ═════════════════════════════════════════════════════════════════ -->
      <!-- ENCABEZADO PRINCIPAL Y ACCIONES GLOBALES                          -->
      <!-- ═════════════════════════════════════════════════════════════════ -->
      <div class="flex flex-col gap-4 md:flex-row md:items-center md:justify-between border-b border-gray-200 dark:border-gray-700 pb-5">
        <div>
          <div class="flex items-center gap-2.5">
            <span class="inline-flex h-9 w-9 items-center justify-center rounded-xl bg-emerald-100 text-emerald-700 dark:bg-emerald-900/40 dark:text-emerald-400">
              <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3 13.125C3 12.504 3.504 12 4.125 12h2.25c.621 0 1.125.504 1.125 1.125v6.75C7.5 20.496 6.996 21 6.375 21h-2.25A1.125 1.125 0 013 19.875v-6.75zM9.75 8.625c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125v11.25c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V8.625zM16.5 4.125c0-.621.504-1.125 1.125-1.125h2.25C20.496 3 21 3.504 21 4.125v15.75c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V4.125z" />
              </svg>
            </span>
            <h1 class="text-2xl font-bold tracking-tight text-gray-900 dark:text-white">Central de Reportes</h1>
          </div>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
            Análisis financiero consolidado, trazabilidad de cobros y consulta histórica · Cooperativa Primero de Mayo
          </p>
        </div>

        <div class="flex flex-wrap items-center gap-3">
          <!-- Botón Exportar a Excel -->
          <button
            (click)="exportarExcel()"
            [disabled]="!reporte() || cargando() || exportando()"
            class="inline-flex items-center gap-2 rounded-xl bg-emerald-600 hover:bg-emerald-700 px-4 py-2.5 text-sm font-semibold text-white shadow-sm transition disabled:opacity-40 disabled:cursor-not-allowed">
            @if (exportando()) {
              <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
              </svg>
              <span>Generando Excel…</span>
            } @else {
              <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75V16.5M16.5 12L12 16.5m0 0L7.5 12m4.5 4.5V3" />
              </svg>
              <span>Exportar Excel</span>
            }
          </button>
        </div>
      </div>

      <!-- ═════════════════════════════════════════════════════════════════ -->
      <!-- BARRA DE FILTROS GLOBALES DE PERÍODO                              -->
      <!-- ═════════════════════════════════════════════════════════════════ -->
      <div class="rounded-2xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 p-5 shadow-sm space-y-4">
        <div class="flex flex-col lg:flex-row lg:items-center justify-between gap-4 border-b border-gray-100 dark:border-gray-700/60 pb-4">
          <!-- Modos de selección de período -->
          <div class="flex items-center gap-2">
            <span class="text-xs font-bold uppercase tracking-wider text-gray-500 dark:text-gray-400 mr-1">Modo Período:</span>
            <div class="inline-flex rounded-xl bg-gray-100 dark:bg-gray-700 p-1">
              <button
                (click)="cambiarModoPeriodo('rapido')"
                [ngClass]="filtroPeriodo().modo === 'rapido' ? 'bg-white dark:bg-gray-600 text-emerald-700 dark:text-emerald-300 shadow-sm font-semibold' : 'text-gray-600 dark:text-gray-300 hover:text-gray-900'"
                class="rounded-lg px-3 py-1 text-xs transition">
                Períodos Rápidos
              </button>
              <button
                (click)="cambiarModoPeriodo('mes_anio')"
                [ngClass]="filtroPeriodo().modo === 'mes_anio' ? 'bg-white dark:bg-gray-600 text-emerald-700 dark:text-emerald-300 shadow-sm font-semibold' : 'text-gray-600 dark:text-gray-300 hover:text-gray-900'"
                class="rounded-lg px-3 py-1 text-xs transition">
                Selector Mes y Año
              </button>
              <button
                (click)="cambiarModoPeriodo('personalizado')"
                [ngClass]="filtroPeriodo().modo === 'personalizado' ? 'bg-white dark:bg-gray-600 text-emerald-700 dark:text-emerald-300 shadow-sm font-semibold' : 'text-gray-600 dark:text-gray-300 hover:text-gray-900'"
                class="rounded-lg px-3 py-1 text-xs transition">
                Rango Personalizado
              </button>
            </div>
          </div>

          <!-- Indicador del Período Activo y Botón Restablecer -->
          <div class="flex items-center gap-3">
            <div class="flex items-center gap-1.5 px-3 py-1 rounded-lg bg-emerald-50 dark:bg-emerald-950/40 border border-emerald-200 dark:border-emerald-800/50 text-xs font-medium text-emerald-800 dark:text-emerald-300">
              <svg class="h-3.5 w-3.5 text-emerald-600 dark:text-emerald-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25m-18 0A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75m-18 0v-7.5A2.25 2.25 0 015.25 9h13.5A2.25 2.25 0 0121 11.25v7.5" />
              </svg>
              <span>{{ periodoActivo().etiqueta }} ({{ fmtFechaCorta(periodoActivo().desde) }} al {{ fmtFechaCorta(periodoActivo().hasta) }})</span>
            </div>

            <button
              (click)="restablecerFiltros()"
              title="Restablecer filtros al mes actual"
              class="inline-flex items-center gap-1 rounded-lg border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 px-2.5 py-1 text-xs text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 transition">
              <svg class="h-3.5 w-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0l3.181 3.183a8.25 8.25 0 0013.803-3.7M4.031 9.865a8.25 8.25 0 0113.803-3.7l3.181 3.182m0-4.991v4.99" />
              </svg>
              <span>Restablecer</span>
            </button>
          </div>
        </div>

        <!-- Controles específicos según el Modo de Período seleccionado -->
        <div>
          <!-- MODO 1: RÁPIDOS -->
          @if (filtroPeriodo().modo === 'rapido') {
            <div class="flex flex-wrap items-center gap-2">
              @for (op of opcionesRapidas; track op.id) {
                <button
                  (click)="seleccionarRangoRapido(op.id)"
                  [ngClass]="filtroPeriodo().rangoRapido === op.id
                    ? 'bg-emerald-600 text-white font-semibold shadow-sm'
                    : 'bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-600'"
                  class="rounded-xl px-3 py-1.5 text-xs transition">
                  {{ op.label }}
                </button>
              }
            </div>
          }

          <!-- MODO 2: MES Y AÑO -->
          @if (filtroPeriodo().modo === 'mes_anio') {
            <div class="flex flex-wrap items-center gap-4">
              <div class="flex items-center gap-2">
                <label class="text-xs font-semibold text-gray-600 dark:text-gray-300">Mes:</label>
                <select
                  [ngModel]="filtroPeriodo().mes"
                  (ngModelChange)="seleccionarMes($event)"
                  class="rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 px-3 py-1.5 text-xs text-gray-800 dark:text-white focus:border-emerald-500 focus:outline-none focus:ring-1 focus:ring-emerald-500">
                  @for (m of mesesLista; track m.num) {
                    <option [value]="m.num">{{ m.nombre }}</option>
                  }
                </select>
              </div>

              <div class="flex items-center gap-2">
                <label class="text-xs font-semibold text-gray-600 dark:text-gray-300">Año:</label>
                <select
                  [ngModel]="filtroPeriodo().anio"
                  (ngModelChange)="seleccionarAnio($event)"
                  class="rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 px-3 py-1.5 text-xs text-gray-800 dark:text-white focus:border-emerald-500 focus:outline-none focus:ring-1 focus:ring-emerald-500">
                  <option [value]="2026">2026</option>
                  <option [value]="2025">2025</option>
                </select>
              </div>

              <!-- Atajos de meses más consultados -->
              <div class="flex items-center gap-1.5 pl-2 border-l border-gray-200 dark:border-gray-700 text-xs">
                <span class="text-gray-400">Ir rápido a:</span>
                <button (click)="fijarMesAnio(10, 2026)" class="px-2 py-0.5 rounded bg-gray-100 hover:bg-emerald-100 dark:bg-gray-700 dark:hover:bg-emerald-950 text-gray-700 dark:text-gray-300 hover:text-emerald-700 transition">Octubre 2026</button>
                <button (click)="fijarMesAnio(9, 2026)" class="px-2 py-0.5 rounded bg-gray-100 hover:bg-emerald-100 dark:bg-gray-700 dark:hover:bg-emerald-950 text-gray-700 dark:text-gray-300 hover:text-emerald-700 transition">Septiembre 2026</button>
                <button (click)="fijarMesAnio(11, 2026)" class="px-2 py-0.5 rounded bg-gray-100 hover:bg-emerald-100 dark:bg-gray-700 dark:hover:bg-emerald-950 text-gray-700 dark:text-gray-300 hover:text-emerald-700 transition">Noviembre 2026</button>
              </div>
            </div>
          }

          <!-- MODO 3: RANGO PERSONALIZADO -->
          @if (filtroPeriodo().modo === 'personalizado') {
            <div class="flex flex-wrap items-center gap-4">
              <div class="flex items-center gap-2">
                <label class="text-xs font-semibold text-gray-600 dark:text-gray-300">Desde:</label>
                <input
                  type="date"
                  [ngModel]="filtroPeriodo().fechaDesde"
                  (ngModelChange)="actualizarFechaDesde($event)"
                  class="rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 px-3 py-1.5 text-xs text-gray-800 dark:text-white focus:border-emerald-500 focus:outline-none focus:ring-1 focus:ring-emerald-500" />
              </div>

              <div class="flex items-center gap-2">
                <label class="text-xs font-semibold text-gray-600 dark:text-gray-300">Hasta:</label>
                <input
                  type="date"
                  [ngModel]="filtroPeriodo().fechaHasta"
                  (ngModelChange)="actualizarFechaHasta($event)"
                  class="rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 px-3 py-1.5 text-xs text-gray-800 dark:text-white focus:border-emerald-500 focus:outline-none focus:ring-1 focus:ring-emerald-500" />
              </div>

              <button
                (click)="aplicarRangoPersonalizado()"
                [disabled]="fechaInvalida()"
                class="rounded-xl bg-emerald-600 hover:bg-emerald-700 px-3.5 py-1.5 text-xs font-semibold text-white transition disabled:opacity-50">
                Consultar Rango
              </button>

              @if (fechaInvalida()) {
                <span class="text-xs text-red-500 font-medium">⚠️ La fecha 'Desde' no puede ser posterior a 'Hasta'.</span>
              }
            </div>
          }
        </div>
      </div>

      <!-- ── Mensaje de Error ────────────────────────────────────────────── -->
      @if (error()) {
        <div class="rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-700 dark:border-red-900/50 dark:bg-red-950/20 dark:text-red-400 flex items-center justify-between">
          <div class="flex items-center gap-2">
            <svg class="h-5 w-5 text-red-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z" />
            </svg>
            <span><strong>Error al consultar reporte:</strong> {{ error() }}</span>
          </div>
          <button (click)="cargar()" class="text-xs font-semibold underline hover:no-underline">Reintentar</button>
        </div>
      }

      <!-- ── Estado de Carga (Skeletons) ─────────────────────────────────── -->
      @if (cargando()) {
        <div class="space-y-6">
          <div class="rounded-2xl border border-gray-200 bg-white dark:border-gray-700 dark:bg-gray-800 p-6 animate-pulse">
            <div class="h-4 w-48 rounded bg-gray-200 dark:bg-gray-700 mb-6"></div>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-4">
              @for (i of [1,2,3,4,5]; track i) {
                <div class="h-24 rounded-xl border border-gray-100 dark:border-gray-700/60 p-4 bg-gray-50 dark:bg-gray-700/30"></div>
              }
            </div>
          </div>
          <div class="rounded-2xl border border-gray-200 bg-white dark:border-gray-700 dark:bg-gray-800 p-6 animate-pulse">
            <div class="h-6 w-60 rounded bg-gray-200 dark:bg-gray-700 mb-4"></div>
            <div class="h-48 rounded-xl bg-gray-50 dark:bg-gray-700/30"></div>
          </div>
        </div>
      }

      @if (reporte(); as r) {

        <!-- ═══════════════════════════════════════════════════════════════ -->
        <!-- SECCIÓN 1: RESUMEN FINANCIERO CONSOLIDADO (KPIs DE CAJA)         -->
        <!-- ═══════════════════════════════════════════════════════════════ -->
        <section class="rounded-2xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 shadow-sm overflow-hidden">
          <div class="border-b border-gray-100 dark:border-gray-700 bg-gray-50/70 dark:bg-gray-700/30 px-6 py-4 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2">
            <div>
              <h2 class="text-sm font-bold uppercase tracking-wider text-gray-800 dark:text-white flex items-center gap-2">
                <span>Resumen Financiero del Período</span>
              </h2>
              <p class="text-xs text-gray-500 dark:text-gray-400 mt-0.5">
                Período auditado: {{ periodoActivo().etiqueta }} ({{ fmtFechaCorta(r.fechaDesde) }} al {{ fmtFechaCorta(r.fechaHasta) }})
              </p>
            </div>

            <!-- Desglose de documentos procesados -->
            <div class="flex flex-wrap items-center gap-2 text-xs">
              <span class="inline-flex items-center gap-1 rounded-md bg-emerald-50 dark:bg-emerald-950/40 border border-emerald-200 dark:border-emerald-800 px-2 py-0.5 text-emerald-700 dark:text-emerald-300 font-medium">
                {{ r.caja.count_recibos }} recibos emitidos
              </span>
              @if (r.caja.count_internos > 0) {
                <span class="inline-flex items-center gap-1 rounded-md bg-violet-50 dark:bg-violet-950/40 border border-violet-200 dark:border-violet-800 px-2 py-0.5 text-violet-700 dark:text-violet-300 font-medium">
                  {{ r.caja.count_internos }} sin recibo (Caja Rápida)
                </span>
              }
              @if (r.caja.count_recaudacion > 0) {
                <span class="inline-flex items-center gap-1 rounded-md bg-sky-50 dark:bg-sky-950/40 border border-sky-200 dark:border-sky-800 px-2 py-0.5 text-sky-700 dark:text-sky-300 font-medium">
                  {{ r.caja.count_recaudacion }} cobros tarjeta
                </span>
              }
              @if (r.caja.count_anulados > 0) {
                <span class="inline-flex items-center gap-1 rounded-md bg-red-50 dark:bg-red-950/40 border border-red-200 dark:border-red-800 px-2 py-0.5 text-red-600 dark:text-red-400 font-medium" title="Recibos anulados excluidos de los totales">
                  {{ r.caja.count_anulados }} anulados (excluidos)
                </span>
              }
            </div>
          </div>

          <!-- Cuadrícula de KPIs -->
          <div class="grid grid-cols-1 divide-y sm:grid-cols-2 lg:grid-cols-5 sm:divide-x lg:divide-y-0 divide-gray-100 dark:divide-gray-700">
            <!-- 1. Ingresos Totales -->
            <div class="p-5 bg-gradient-to-b from-transparent to-emerald-50/20 dark:to-emerald-950/10">
              <p class="text-xs font-semibold uppercase tracking-wider text-emerald-600 dark:text-emerald-400">Ingresos Totales</p>
              <p class="mt-2 text-2xl font-bold tabular-nums text-emerald-800 dark:text-emerald-200">
                {{ fmtSoles(r.caja.efectivo + r.caja.transferencia) }}
              </p>
              <p class="mt-1 text-xs text-gray-500 dark:text-gray-400">Total recaudado en el período</p>
            </div>

            <!-- 2. Efectivo en Gaveta -->
            <div class="p-5">
              <p class="text-xs font-semibold uppercase tracking-wider text-green-600 dark:text-green-400">Efectivo en Caja</p>
              <p class="mt-2 text-2xl font-bold tabular-nums text-green-700 dark:text-green-300">
                {{ fmtSoles(r.caja.efectivo) }}
              </p>
              <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">Ingreso físico en gaveta</p>
            </div>

            <!-- 3. Transferencia y QR -->
            <div class="p-5">
              <p class="text-xs font-semibold uppercase tracking-wider text-blue-600 dark:text-blue-400">Transferencia / QR</p>
              <p class="mt-2 text-2xl font-bold tabular-nums text-blue-700 dark:text-blue-300">
                {{ fmtSoles(r.caja.transferencia) }}
              </p>
              <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">Abonos bancarios directos</p>
            </div>

            <!-- 4. Egresos Operativos -->
            <div class="p-5">
              <p class="text-xs font-semibold uppercase tracking-wider text-red-600 dark:text-red-400">Egresos (Gastos)</p>
              <p class="mt-2 text-2xl font-bold tabular-nums text-red-700 dark:text-red-300">
                {{ fmtSoles(r.caja.egresos) }}
              </p>
              <p class="mt-1 text-xs text-gray-400 dark:text-gray-500">Total de gastos del período</p>
            </div>

            <!-- 5. Saldo Neto del Período -->
            <div class="p-5" [ngClass]="r.caja.saldo >= 0 ? 'bg-emerald-50/40 dark:bg-emerald-950/20' : 'bg-red-50/40 dark:bg-red-950/20'">
              <p class="text-xs font-semibold uppercase tracking-wider" [ngClass]="r.caja.saldo >= 0 ? 'text-emerald-700 dark:text-emerald-400' : 'text-red-600 dark:text-red-400'">
                Saldo Neto
              </p>
              <p class="mt-2 text-2xl font-bold tabular-nums" [ngClass]="r.caja.saldo >= 0 ? 'text-emerald-800 dark:text-emerald-300' : 'text-red-700 dark:text-red-300'">
                {{ fmtSoles(r.caja.saldo) }}
              </p>
              <p class="mt-1 text-xs" [ngClass]="r.caja.saldo >= 0 ? 'text-emerald-600 dark:text-emerald-500' : 'text-red-500'">
                Ingresos − Gastos operativos
              </p>
            </div>
          </div>
        </section>

        <!-- ═══════════════════════════════════════════════════════════════ -->
        <!-- PESTAÑAS DE NAVEGACIÓN: INGRESOS | EGRESOS | COMBINADO           -->
        <!-- ═══════════════════════════════════════════════════════════════ -->
        <div class="flex items-center gap-2 border-b border-gray-200 dark:border-gray-700">
          <button
            (click)="tabActiva.set('ingresos')"
            [ngClass]="tabActiva() === 'ingresos'
              ? 'border-emerald-600 text-emerald-700 dark:text-emerald-400 font-bold border-b-2'
              : 'border-transparent text-gray-500 hover:text-gray-700 dark:hover:text-gray-300'"
            class="flex items-center gap-2 px-4 py-3 text-sm transition -mb-px">
            <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
            </svg>
            <span>Análisis de Ingresos por Concepto</span>
            <span class="rounded-full bg-emerald-100 dark:bg-emerald-950 px-2 py-0.5 text-xs text-emerald-800 dark:text-emerald-300 font-medium">
              {{ r.por_concepto.length }}
            </span>
          </button>

          <button
            (click)="tabActiva.set('egresos')"
            [ngClass]="tabActiva() === 'egresos'
              ? 'border-orange-600 text-orange-700 dark:text-orange-400 font-bold border-b-2'
              : 'border-transparent text-gray-500 hover:text-gray-700 dark:hover:text-gray-300'"
            class="flex items-center gap-2 px-4 py-3 text-sm transition -mb-px">
            <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 12h-15" />
            </svg>
            <span>Análisis de Egresos por Categoría</span>
            <span class="rounded-full bg-orange-100 dark:bg-orange-950 px-2 py-0.5 text-xs text-orange-800 dark:text-orange-300 font-medium">
              {{ r.egresos_por_categoria.length }}
            </span>
          </button>

          <button
            (click)="tabActiva.set('combinado')"
            [ngClass]="tabActiva() === 'combinado'
              ? 'border-brand-600 text-brand-700 dark:text-brand-400 font-bold border-b-2'
              : 'border-transparent text-gray-500 hover:text-gray-700 dark:hover:text-gray-300'"
            class="hidden md:flex items-center gap-2 px-4 py-3 text-sm transition -mb-px">
            <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" />
            </svg>
            <span>Vista Consolidada (Ambos)</span>
          </button>
        </div>

        <!-- ═══════════════════════════════════════════════════════════════ -->
        <!-- SECCIÓN 2: ANÁLISIS DE INGRESOS POR CONCEPTO                     -->
        <!-- ═══════════════════════════════════════════════════════════════ -->
        @if (tabActiva() === 'ingresos' || tabActiva() === 'combinado') {
          <section class="rounded-2xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 shadow-sm overflow-hidden">
            <div class="border-b border-gray-100 dark:border-gray-700 bg-gray-50/70 dark:bg-gray-700/30 p-5 space-y-4">
              <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                <div>
                  <h3 class="text-base font-bold text-gray-900 dark:text-white">Ingresos por Concepto</h3>
                  <p class="text-xs text-gray-500 dark:text-gray-400 mt-0.5">
                    Filtra por concepto, origen o método de pago para auditar las operaciones correspondientes.
                  </p>
                </div>

                <div class="flex items-center gap-2">
                  <span class="text-xs font-semibold text-gray-500">Total filtrado:</span>
                  <span class="text-base font-bold text-emerald-700 dark:text-emerald-400 tabular-nums">
                    {{ fmtSoles(totalConceptosFiltrados()) }}
                  </span>
                </div>
              </div>

              <!-- Barra de Filtros Específicos de Ingresos -->
              <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3 pt-2">
                <!-- 1. Filtro por Concepto específico -->
                <div>
                  <label class="block text-xs font-semibold text-gray-600 dark:text-gray-400 mb-1">Concepto:</label>
                  <select
                    [ngModel]="filtroConceptoSeleccionado()"
                    (ngModelChange)="seleccionarFiltroConcepto($event)"
                    class="w-full rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 px-3 py-1.5 text-xs text-gray-800 dark:text-white focus:border-emerald-500 focus:outline-none">
                    <option value="">Todos los conceptos ({{ r.por_concepto.length }})</option>
                    @for (c of r.por_concepto; track c.concepto) {
                      <option [value]="c.concepto">{{ c.concepto }} ({{ fmtSoles(c.monto) }})</option>
                    }
                  </select>
                </div>

                <!-- 2. Filtro por Origen -->
                <div>
                  <label class="block text-xs font-semibold text-gray-600 dark:text-gray-400 mb-1">Origen del Pagador:</label>
                  <select
                    [ngModel]="filtroOrigen()"
                    (ngModelChange)="filtroOrigen.set($event)"
                    class="w-full rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 px-3 py-1.5 text-xs text-gray-800 dark:text-white focus:border-emerald-500 focus:outline-none">
                    <option value="todos">Todos los orígenes</option>
                    <option value="socios">Solo Socios</option>
                    <option value="inquilinos">Solo Inquilinos</option>
                    <option value="otros">Otros / Caja Rápida</option>
                  </select>
                </div>

                <!-- 3. Filtro por Método de Pago -->
                <div>
                  <label class="block text-xs font-semibold text-gray-600 dark:text-gray-400 mb-1">Método de Pago:</label>
                  <select
                    [ngModel]="filtroMetodoPago()"
                    (ngModelChange)="filtroMetodoPago.set($event)"
                    class="w-full rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 px-3 py-1.5 text-xs text-gray-800 dark:text-white focus:border-emerald-500 focus:outline-none">
                    <option value="todos">Todos los métodos</option>
                    <option value="Efectivo">Efectivo</option>
                    <option value="Transferencia">Transferencia / QR</option>
                    <option value="Saldo a favor">Saldo a favor</option>
                  </select>
                </div>

                <!-- 4. Buscador Rápido -->
                <div>
                  <label class="block text-xs font-semibold text-gray-600 dark:text-gray-400 mb-1">Buscar en texto:</label>
                  <div class="relative">
                    <input
                      type="text"
                      [ngModel]="busquedaIngreso()"
                      (ngModelChange)="busquedaIngreso.set($event)"
                      placeholder="Pagador, recibo, puesto..."
                      class="w-full rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 pl-8 pr-3 py-1.5 text-xs text-gray-800 dark:text-white focus:border-emerald-500 focus:outline-none" />
                    <svg class="h-4 w-4 absolute left-2.5 top-2 text-gray-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607z" />
                    </svg>
                  </div>
                </div>
              </div>
            </div>

            <!-- Tabla de Conceptos Agrupados -->
            @if (conceptosFiltrados().length === 0) {
              <div class="p-12 text-center text-sm text-gray-400 dark:text-gray-500 space-y-2">
                <svg class="h-8 w-8 mx-auto text-gray-300" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z" />
                </svg>
                <p>No se encontraron conceptos para los filtros seleccionados.</p>
              </div>
            } @else {
              <div class="overflow-x-auto">
                <table class="w-full text-sm">
                  <thead class="bg-gray-50 dark:bg-gray-700/40 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                    <tr>
                      <th class="w-10 px-3 py-3 text-center"></th>
                      <th class="px-4 py-3 text-left">Concepto</th>
                      <th class="px-4 py-3 text-center">Cobros / Operaciones</th>
                      <th class="px-4 py-3 text-right hidden md:table-cell">Socios</th>
                      <th class="px-4 py-3 text-right hidden md:table-cell">Inquilinos</th>
                      <th class="px-4 py-3 text-right hidden lg:table-cell">Otros (Caja Rápida)</th>
                      <th class="px-4 py-3 text-right">Total Recaudado</th>
                      <th class="px-4 py-3 text-right w-28">% Período</th>
                    </tr>
                  </thead>
                  <tbody class="divide-y divide-gray-100 dark:divide-gray-700/60">
                    @for (c of conceptosFiltrados(); track c.concepto) {
                      <tr
                        (click)="toggleIngreso(c.concepto)"
                        class="cursor-pointer transition hover:bg-emerald-50/30 dark:hover:bg-emerald-950/20">
                        <td class="px-3 py-3 text-center text-gray-400">
                          <svg class="h-4 w-4 transition-transform duration-200" [class.rotate-90]="estaExpandido('ing:' + c.concepto)" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
                          </svg>
                        </td>
                        <td class="px-4 py-3 font-medium text-gray-900 dark:text-white flex items-center gap-2">
                          <span>{{ c.concepto }}</span>
                          @if (c.concepto.includes('SS.HH') || c.concepto === 'Parqueo' || c.concepto === 'TICKET') {
                            <span class="rounded bg-violet-100 dark:bg-violet-950/60 px-1.5 py-0.5 text-[10px] font-semibold text-violet-700 dark:text-violet-300">Caja Rápida</span>
                          }
                        </td>
                        <td class="px-4 py-3 text-center text-gray-600 dark:text-gray-300 font-mono">{{ c.cantidad }}</td>
                        <td class="px-4 py-3 text-right hidden md:table-cell text-gray-600 dark:text-gray-300 tabular-nums">{{ fmtSoles(c.monto_socios) }}</td>
                        <td class="px-4 py-3 text-right hidden md:table-cell text-gray-600 dark:text-gray-300 tabular-nums">{{ fmtSoles(c.monto_inquilinos) }}</td>
                        <td class="px-4 py-3 text-right hidden lg:table-cell text-gray-600 dark:text-gray-300 tabular-nums">
                          {{ fmtSoles(c.monto - c.monto_socios - c.monto_inquilinos) }}
                        </td>
                        <td class="px-4 py-3 text-right font-bold text-gray-900 dark:text-white tabular-nums">{{ fmtSoles(c.monto) }}</td>
                        <td class="px-4 py-3 text-right">
                          <div class="flex items-center justify-end gap-2">
                            <div class="h-1.5 w-14 overflow-hidden rounded-full bg-gray-100 dark:bg-gray-700">
                              <div class="h-full rounded-full bg-emerald-500" [style.width.%]="pctConcepto(c)"></div>
                            </div>
                            <span class="text-xs text-gray-500 dark:text-gray-400 tabular-nums w-8 text-right">{{ pctConcepto(c).toFixed(0) }}%</span>
                          </div>
                        </td>
                      </tr>

                      <!-- DRILL-DOWN: DETALLE DE OPERACIONES DE ESTE CONCEPTO -->
                      @if (estaExpandido('ing:' + c.concepto)) {
                        <tr>
                          <td colspan="8" class="bg-gray-50/80 dark:bg-gray-900/40 p-4 border-y border-emerald-100 dark:border-emerald-900/30">
                            <div class="rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 p-4 shadow-sm space-y-3">
                              <div class="flex items-center justify-between border-b border-gray-100 dark:border-gray-700 pb-2">
                                <h4 class="text-xs font-bold uppercase tracking-wider text-emerald-800 dark:text-emerald-300">
                                  Detalle de Operaciones: {{ c.concepto }} ({{ getDetalleIngresoFiltrado(c.concepto).length }} operaciones)
                                </h4>
                                <span class="text-xs font-semibold text-gray-500">
                                  Subtotal: {{ fmtSoles(calcularSubtotalDetalleIngreso(c.concepto)) }}
                                </span>
                              </div>

                              @if (cargandoDetalle().has('ing:' + c.concepto)) {
                                <div class="flex items-center gap-2 py-4 text-xs text-gray-400 justify-center">
                                  <span class="h-4 w-4 animate-spin rounded-full border-2 border-emerald-500 border-t-transparent"></span>
                                  <span>Cargando detalle de operaciones en tiempo real…</span>
                                </div>
                              } @else if (getDetalleIngresoFiltrado(c.concepto).length === 0) {
                                <p class="text-xs text-gray-400 py-3 text-center">No se encontraron líneas de detalle para los filtros activos.</p>
                              } @else {
                                <div class="overflow-x-auto max-h-96">
                                  <table class="w-full text-xs">
                                    <thead class="bg-gray-50 dark:bg-gray-700/50 text-gray-500 sticky top-0">
                                      <tr>
                                        <th class="px-3 py-2 text-left font-semibold">Fecha / Hora</th>
                                        <th class="px-3 py-2 text-left font-semibold">Recibo / Ref.</th>
                                        <th class="px-3 py-2 text-left font-semibold">Pagador / Glosa</th>
                                        <th class="px-3 py-2 text-center font-semibold">Origen</th>
                                        <th class="px-3 py-2 text-left font-semibold">Puesto</th>
                                        <th class="px-3 py-2 text-center font-semibold">Período</th>
                                        <th class="px-3 py-2 text-center font-semibold">Método</th>
                                        <th class="px-3 py-2 text-right font-semibold">Monto S/</th>
                                        @if (auth.esAdmin()) {
                                          <th class="px-3 py-2 text-left font-semibold">Cajero</th>
                                        }
                                      </tr>
                                    </thead>
                                    <tbody class="divide-y divide-gray-100 dark:divide-gray-700/60">
                                      @for (l of getDetalleIngresoFiltrado(c.concepto); track l.codigo_transaccion + l.periodo + l.monto + l.fecha_pago) {
                                        <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/30">
                                          <td class="px-3 py-1.5 font-mono text-gray-500 whitespace-nowrap">{{ fmtFechaHora(l.fecha_pago) }}</td>
                                          <td class="px-3 py-1.5 font-mono font-semibold text-emerald-700 dark:text-emerald-400 whitespace-nowrap">{{ l.codigo_transaccion }}</td>
                                          <td class="px-3 py-1.5 font-medium text-gray-800 dark:text-gray-200">{{ l.pagador }}</td>
                                          <td class="px-3 py-1.5 text-center">
                                            <span class="rounded px-1.5 py-0.5 text-[10px] font-semibold uppercase"
                                              [ngClass]="l.tipo_pagador === 'socio'
                                                ? 'bg-emerald-50 text-emerald-700 dark:bg-emerald-950/60 dark:text-emerald-300'
                                                : l.tipo_pagador === 'inquilino'
                                                  ? 'bg-amber-50 text-amber-700 dark:bg-amber-950/60 dark:text-amber-300'
                                                  : 'bg-violet-50 text-violet-700 dark:bg-violet-950/60 dark:text-violet-300'">
                                              {{ l.tipo_pagador }}
                                            </span>
                                          </td>
                                          <td class="px-3 py-1.5 text-gray-600 dark:text-gray-400 whitespace-nowrap">{{ l.codigo_puesto || '—' }}</td>
                                          <td class="px-3 py-1.5 text-center font-mono text-gray-500">{{ l.periodo || '—' }}</td>
                                          <td class="px-3 py-1.5 text-center">
                                            <span class="rounded px-1.5 py-0.5 text-[10px]"
                                              [ngClass]="l.metodo_pago === 'Efectivo' ? 'bg-green-100 dark:bg-green-950 text-green-800' : 'bg-blue-100 dark:bg-blue-950 text-blue-800'">
                                              {{ l.metodo_pago }}
                                            </span>
                                          </td>
                                          <td class="px-3 py-1.5 text-right font-bold tabular-nums text-gray-900 dark:text-white">{{ fmtSoles(l.monto) }}</td>
                                          @if (auth.esAdmin()) {
                                            <td class="px-3 py-1.5 text-gray-500">{{ l.cajero || '—' }}</td>
                                          }
                                        </tr>
                                      }
                                    </tbody>
                                  </table>
                                </div>
                              }
                            </div>
                          </td>
                        </tr>
                      }
                    }
                  </tbody>
                  <!-- Total de la Tabla -->
                  <tfoot class="bg-gray-50 dark:bg-gray-700/50 font-bold text-xs text-gray-900 dark:text-white border-t border-gray-200 dark:border-gray-600">
                    <tr>
                      <td></td>
                      <td class="px-4 py-3 uppercase">Total Ingresos Filtrados</td>
                      <td class="px-4 py-3 text-center tabular-nums">{{ totalCobrosFiltrados() }}</td>
                      <td class="px-4 py-3 text-right hidden md:table-cell tabular-nums">{{ fmtSoles(totalSociosFiltrados()) }}</td>
                      <td class="px-4 py-3 text-right hidden md:table-cell tabular-nums">{{ fmtSoles(totalInquilinosFiltrados()) }}</td>
                      <td class="px-4 py-3 text-right hidden lg:table-cell tabular-nums">{{ fmtSoles(totalOtrosFiltrados()) }}</td>
                      <td class="px-4 py-3 text-right text-emerald-700 dark:text-emerald-400 text-sm tabular-nums">{{ fmtSoles(totalConceptosFiltrados()) }}</td>
                      <td></td>
                    </tr>
                  </tfoot>
                </table>
              </div>
            }
          </section>
        }

        <!-- ═══════════════════════════════════════════════════════════════ -->
        <!-- SECCIÓN 3: ANÁLISIS DE EGRESOS POR CATEGORÍA                     -->
        <!-- ═══════════════════════════════════════════════════════════════ -->
        @if (tabActiva() === 'egresos' || tabActiva() === 'combinado') {
          <section class="rounded-2xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 shadow-sm overflow-hidden">
            <div class="border-b border-orange-100 dark:border-orange-900/40 bg-orange-50/50 dark:bg-orange-950/10 p-5 space-y-4">
              <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                <div>
                  <h3 class="text-base font-bold text-gray-900 dark:text-white">Egresos por Categoría</h3>
                  <p class="text-xs text-orange-700 dark:text-orange-400 mt-0.5">
                    Desglose de gastos operativos ejecutados en el período. Total: {{ fmtSoles(r.caja.egresos) }}
                  </p>
                </div>

                <div class="flex items-center gap-2">
                  <span class="text-xs font-semibold text-gray-500">Total egresos filtrados:</span>
                  <span class="text-base font-bold text-red-600 dark:text-red-400 tabular-nums">
                    {{ fmtSoles(totalEgresosFiltrados()) }}
                  </span>
                </div>
              </div>

              <!-- Filtros específicos de egresos -->
              <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3 pt-2">
                <!-- 1. Filtro por Categoría -->
                <div>
                  <label class="block text-xs font-semibold text-gray-600 dark:text-gray-400 mb-1">Categoría de Gasto:</label>
                  <select
                    [ngModel]="filtroCategoriaSeleccionada()"
                    (ngModelChange)="seleccionarFiltroCategoria($event)"
                    class="w-full rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 px-3 py-1.5 text-xs text-gray-800 dark:text-white focus:border-orange-500 focus:outline-none">
                    <option value="">Todas las categorías ({{ r.egresos_por_categoria.length }})</option>
                    @for (e of r.egresos_por_categoria; track e.categoria) {
                      <option [value]="e.categoria">{{ e.categoria }} ({{ fmtSoles(e.monto) }})</option>
                    }
                  </select>
                </div>

                <!-- 2. Buscador en Egresos -->
                <div class="sm:col-span-2">
                  <label class="block text-xs font-semibold text-gray-600 dark:text-gray-400 mb-1">Buscar por responsable, comprobante o glosa:</label>
                  <div class="relative">
                    <input
                      type="text"
                      [ngModel]="busquedaEgreso()"
                      (ngModelChange)="busquedaEgreso.set($event)"
                      placeholder="Proveedor, descripción de factura o recibo..."
                      class="w-full rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 pl-8 pr-3 py-1.5 text-xs text-gray-800 dark:text-white focus:border-orange-500 focus:outline-none" />
                    <svg class="h-4 w-4 absolute left-2.5 top-2 text-gray-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-5.197-5.197m0 0A7.5 7.5 0 105.196 5.196a7.5 7.5 0 0010.607 10.607z" />
                    </svg>
                  </div>
                </div>
              </div>
            </div>

            <!-- Tabla de Categorías de Gasto -->
            @if (egresosFiltrados().length === 0) {
              <div class="p-12 text-center text-sm text-gray-400 dark:text-gray-500">
                No se registraron egresos para los filtros seleccionados en este período.
              </div>
            } @else {
              <div class="overflow-x-auto">
                <table class="w-full text-sm">
                  <thead class="bg-gray-50 dark:bg-gray-700/40 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                    <tr>
                      <th class="w-10 px-3 py-3 text-center"></th>
                      <th class="px-4 py-3 text-left">Categoría de Gasto</th>
                      <th class="px-4 py-3 text-center">N° Operaciones</th>
                      <th class="px-4 py-3 text-right">Monto Ejecutado</th>
                      <th class="px-4 py-3 text-right w-28">% Egresos</th>
                    </tr>
                  </thead>
                  <tbody class="divide-y divide-gray-100 dark:divide-gray-700/60">
                    @for (e of egresosFiltrados(); track e.categoria) {
                      <tr
                        (click)="toggleEgreso(e.categoria)"
                        class="cursor-pointer transition hover:bg-orange-50/30 dark:hover:bg-orange-950/20">
                        <td class="px-3 py-3 text-center text-gray-400">
                          <svg class="h-4 w-4 transition-transform duration-200" [class.rotate-90]="estaExpandido('egr:' + e.categoria)" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5" />
                          </svg>
                        </td>
                        <td class="px-4 py-3 font-medium text-gray-900 dark:text-white">{{ e.categoria }}</td>
                        <td class="px-4 py-3 text-center text-gray-600 dark:text-gray-300 font-mono">{{ e.cantidad }}</td>
                        <td class="px-4 py-3 text-right font-bold text-red-600 dark:text-red-400 tabular-nums">{{ fmtSoles(e.monto) }}</td>
                        <td class="px-4 py-3 text-right">
                          <div class="flex items-center justify-end gap-2">
                            <div class="h-1.5 w-14 overflow-hidden rounded-full bg-gray-100 dark:bg-gray-700">
                              <div class="h-full rounded-full bg-orange-500" [style.width.%]="pctEgreso(e)"></div>
                            </div>
                            <span class="text-xs text-gray-500 dark:text-gray-400 tabular-nums w-8 text-right">{{ pctEgreso(e).toFixed(0) }}%</span>
                          </div>
                        </td>
                      </tr>

                      <!-- DRILL-DOWN: DETALLE DE GASTOS DE ESTA CATEGORÍA -->
                      @if (estaExpandido('egr:' + e.categoria)) {
                        <tr>
                          <td colspan="5" class="bg-gray-50/80 dark:bg-gray-900/40 p-4 border-y border-orange-100 dark:border-orange-900/30">
                            <div class="rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 p-4 shadow-sm space-y-3">
                              <div class="flex items-center justify-between border-b border-gray-100 dark:border-gray-700 pb-2">
                                <h4 class="text-xs font-bold uppercase tracking-wider text-orange-800 dark:text-orange-300">
                                  Detalle de Gastos: {{ e.categoria }} ({{ getDetalleEgresoFiltrado(e.categoria).length }} operaciones)
                                </h4>
                                <span class="text-xs font-semibold text-gray-500">
                                  Subtotal: {{ fmtSoles(calcularSubtotalDetalleEgreso(e.categoria)) }}
                                </span>
                              </div>

                              @if (cargandoDetalle().has('egr:' + e.categoria)) {
                                <div class="flex items-center gap-2 py-4 text-xs text-gray-400 justify-center">
                                  <span class="h-4 w-4 animate-spin rounded-full border-2 border-orange-500 border-t-transparent"></span>
                                  <span>Cargando detalle de egresos…</span>
                                </div>
                              } @else if (getDetalleEgresoFiltrado(e.categoria).length === 0) {
                                <p class="text-xs text-gray-400 py-3 text-center">No se encontraron líneas de egreso con los filtros aplicados.</p>
                              } @else {
                                <div class="overflow-x-auto max-h-96">
                                  <table class="w-full text-xs">
                                    <thead class="bg-gray-50 dark:bg-gray-700/50 text-gray-500 sticky top-0">
                                      <tr>
                                        <th class="px-3 py-2 text-left font-semibold">Fecha</th>
                                        <th class="px-3 py-2 text-left font-semibold">Comprobante / Ref.</th>
                                        <th class="px-3 py-2 text-left font-semibold">Responsable</th>
                                        <th class="px-3 py-2 text-left font-semibold">Descripción / Glosa</th>
                                        <th class="px-3 py-2 text-right font-semibold">Monto S/</th>
                                      </tr>
                                    </thead>
                                    <tbody class="divide-y divide-gray-100 dark:divide-gray-700/60">
                                      @for (g of getDetalleEgresoFiltrado(e.categoria); track g.id) {
                                        <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/30">
                                          <td class="px-3 py-1.5 font-mono text-gray-500 whitespace-nowrap">{{ fmtFechaCorta(g.fecha) }}</td>
                                          <td class="px-3 py-1.5 font-mono text-gray-600 dark:text-gray-300 whitespace-nowrap">{{ g.comprobante_ref || '—' }}</td>
                                          <td class="px-3 py-1.5 font-medium text-gray-800 dark:text-gray-200">{{ g.responsable || '—' }}</td>
                                          <td class="px-3 py-1.5 text-gray-600 dark:text-gray-400">{{ g.descripcion || '—' }}</td>
                                          <td class="px-3 py-1.5 text-right font-bold tabular-nums text-red-600 dark:text-red-400">{{ fmtSoles(g.monto) }}</td>
                                        </tr>
                                      }
                                    </tbody>
                                  </table>
                                </div>
                              }
                            </div>
                          </td>
                        </tr>
                      }
                    }
                  </tbody>
                  <!-- Total Egresos -->
                  <tfoot class="bg-gray-50 dark:bg-gray-700/50 font-bold text-xs text-gray-900 dark:text-white border-t border-gray-200 dark:border-gray-600">
                    <tr>
                      <td></td>
                      <td class="px-4 py-3 uppercase">Total Egresos Filtrados</td>
                      <td class="px-4 py-3 text-center tabular-nums">{{ totalCantidadEgresosFiltrados() }}</td>
                      <td class="px-4 py-3 text-right text-red-600 dark:text-red-400 text-sm tabular-nums">{{ fmtSoles(totalEgresosFiltrados()) }}</td>
                      <td></td>
                    </tr>
                  </tfoot>
                </table>
              </div>
            }
          </section>
        }

      }
    </div>
  `,
})
export class ReportesComponent implements OnInit {
  private readonly reportesSvc = inject(ReportesService);
  private readonly excelSvc    = inject(ExcelExportService);
  protected readonly auth      = inject(AuthService);

  // Helpers expuestos al template
  protected readonly fmtSoles      = fmtSoles;
  protected readonly fmtFechaCorta = fmtFechaCorta;
  protected readonly fmtFechaHora  = fmtFechaHora;

  // Estado del período
  readonly filtroPeriodo = signal<FiltroPeriodoReporte>({
    modo: 'mes_anio',
    rangoRapido: 'mes',
    mes: 10,  // Octubre 2026 por defecto (mes más completo en producción) o mes actual
    anio: 2026,
    fechaDesde: '2026-10-01',
    fechaHasta: '2026-10-31',
  });

  // Opciones de rangos rápidos disponibles
  readonly opcionesRapidas: { id: RangoRapido; label: string }[] = [
    { id: 'hoy',          label: 'Hoy' },
    { id: 'ayer',         label: 'Ayer' },
    { id: 'semana',       label: 'Últimos 7 días' },
    { id: 'mes',          label: 'Este Mes' },
    { id: 'mes_anterior', label: 'Mes Anterior' },
    { id: 'año',          label: 'Este Año' },
    { id: 'historico',    label: 'Histórico Completo' },
  ];

  readonly mesesLista = [
    { num: 1, nombre: 'Enero' },
    { num: 2, nombre: 'Febrero' },
    { num: 3, nombre: 'Marzo' },
    { num: 4, nombre: 'Abril' },
    { num: 5, nombre: 'Mayo' },
    { num: 6, nombre: 'Junio' },
    { num: 7, nombre: 'Julio' },
    { num: 8, nombre: 'Agosto' },
    { num: 9, nombre: 'Septiembre' },
    { num: 10, nombre: 'Octubre' },
    { num: 11, nombre: 'Noviembre' },
    { num: 12, nombre: 'Diciembre' },
  ];

  // Pestaña activa
  readonly tabActiva = signal<TabVistaReporte>('ingresos');

  // Filtros específicos de ingresos
  readonly filtroConceptoSeleccionado = signal<string>('');
  readonly filtroOrigen = signal<OrigenFiltroUI>('todos');
  readonly filtroMetodoPago = signal<string>('todos');
  readonly busquedaIngreso = signal<string>('');

  // Filtros específicos de egresos
  readonly filtroCategoriaSeleccionada = signal<string>('');
  readonly busquedaEgreso = signal<string>('');

  // Estado del reporte cargado
  readonly reporte    = signal<ReporteResumenV2 | null>(null);
  readonly cargando   = signal(false);
  readonly error      = signal<string | null>(null);
  readonly exportando = signal(false);

  // Drill-down: expansión + caché lazy
  readonly expandidos      = signal<Set<string>>(new Set());
  readonly cargandoDetalle = signal<Set<string>>(new Set());
  readonly detallesIngreso = signal<Map<string, DetalleIngresoLinea[]>>(new Map());
  readonly detallesEgreso  = signal<Map<string, DetalleEgresoLinea[]>>(new Map());

  // Período resuelto computado
  readonly periodoActivo = computed<PeriodoResuelto>(() =>
    resolverPeriodoReporte(this.filtroPeriodo()),
  );

  // Validación de fecha personalizada
  readonly fechaInvalida = computed<boolean>(() => {
    const f = this.filtroPeriodo();
    if (f.modo !== 'personalizado') return false;
    return !!(f.fechaDesde && f.fechaHasta && f.fechaDesde > f.fechaHasta);
  });

  // Conceptos filtrados reactivamente
  readonly conceptosFiltrados = computed<ConceptoResumen[]>(() => {
    const r = this.reporte();
    if (!r) return [];
    let lista = r.por_concepto;

    const selConc = this.filtroConceptoSeleccionado();
    if (selConc) {
      lista = lista.filter(c => c.concepto === selConc);
    }

    const q = this.busquedaIngreso().trim().toLowerCase();
    if (q) {
      lista = lista.filter(c => c.concepto.toLowerCase().includes(q));
    }

    return lista;
  });

  // Totales computados sobre los conceptos filtrados
  readonly totalConceptosFiltrados = computed(() =>
    Math.round((this.conceptosFiltrados().reduce((s, c) => s + c.monto, 0)) * 100) / 100,
  );

  readonly totalCobrosFiltrados = computed(() =>
    this.conceptosFiltrados().reduce((s, c) => s + c.cantidad, 0),
  );

  readonly totalSociosFiltrados = computed(() =>
    Math.round((this.conceptosFiltrados().reduce((s, c) => s + c.monto_socios, 0)) * 100) / 100,
  );

  readonly totalInquilinosFiltrados = computed(() =>
    Math.round((this.conceptosFiltrados().reduce((s, c) => s + c.monto_inquilinos, 0)) * 100) / 100,
  );

  readonly totalOtrosFiltrados = computed(() =>
    Math.round((this.conceptosFiltrados().reduce((s, c) => s + (c.monto - c.monto_socios - c.monto_inquilinos), 0)) * 100) / 100,
  );

  // Egresos filtrados reactivamente
  readonly egresosFiltrados = computed<EgresoCategoria[]>(() => {
    const r = this.reporte();
    if (!r) return [];
    let lista = r.egresos_por_categoria;

    const selCat = this.filtroCategoriaSeleccionada();
    if (selCat) {
      lista = lista.filter(e => e.categoria === selCat);
    }

    const q = this.busquedaEgreso().trim().toLowerCase();
    if (q) {
      lista = lista.filter(e => e.categoria.toLowerCase().includes(q));
    }

    return lista;
  });

  readonly totalEgresosFiltrados = computed(() =>
    Math.round((this.egresosFiltrados().reduce((s, e) => s + e.monto, 0)) * 100) / 100,
  );

  readonly totalCantidadEgresosFiltrados = computed(() =>
    this.egresosFiltrados().reduce((s, e) => s + e.cantidad, 0),
  );

  ngOnInit(): void {
    void this.cargar();
  }

  // ── Carga de Datos según Período Activo ────────────────────────────────────

  async cargar(): Promise<void> {
    if (this.fechaInvalida()) return;

    this.cargando.set(true);
    this.error.set(null);
    this.reporte.set(null);
    this.expandidos.set(new Set());
    this.detallesIngreso.set(new Map());
    this.detallesEgreso.set(new Map());

    const p = this.periodoActivo();
    try {
      // Cargar KPIs de caja y agrupaciones server-side
      const r = await this.reportesSvc.cargarResumenPeriodo(p.desde, p.hasta, 'todos');
      this.reporte.set(r);

      // Si había un concepto seleccionado previamente, verificar si aún existe en este período
      if (this.filtroConceptoSeleccionado()) {
        const existe = r.por_concepto.some(c => c.concepto === this.filtroConceptoSeleccionado());
        if (!existe) {
          this.filtroConceptoSeleccionado.set('');
        }
      }
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar el reporte');
    } finally {
      this.cargando.set(false);
    }
  }

  // ── Gestión de Modos de Período ───────────────────────────────────────────

  cambiarModoPeriodo(modo: ModoFiltroPeriodo): void {
    const actual = this.filtroPeriodo();
    this.filtroPeriodo.set({
      ...actual,
      modo,
    });
    void this.cargar();
  }

  seleccionarRangoRapido(rango: RangoRapido): void {
    const actual = this.filtroPeriodo();
    this.filtroPeriodo.set({
      ...actual,
      modo: 'rapido',
      rangoRapido: rango,
    });
    void this.cargar();
  }

  seleccionarMes(mesNum: number | string): void {
    const m = Number(mesNum);
    const actual = this.filtroPeriodo();
    this.filtroPeriodo.set({
      ...actual,
      modo: 'mes_anio',
      mes: m,
    });
    void this.cargar();
  }

  seleccionarAnio(anioNum: number | string): void {
    const a = Number(anioNum);
    const actual = this.filtroPeriodo();
    this.filtroPeriodo.set({
      ...actual,
      modo: 'mes_anio',
      anio: a,
    });
    void this.cargar();
  }

  fijarMesAnio(mes: number, anio: number): void {
    this.filtroPeriodo.set({
      ...this.filtroPeriodo(),
      modo: 'mes_anio',
      mes,
      anio,
    });
    void this.cargar();
  }

  actualizarFechaDesde(val: string): void {
    this.filtroPeriodo.set({
      ...this.filtroPeriodo(),
      fechaDesde: val,
    });
  }

  actualizarFechaHasta(val: string): void {
    this.filtroPeriodo.set({
      ...this.filtroPeriodo(),
      fechaHasta: val,
    });
  }

  aplicarRangoPersonalizado(): void {
    if (this.fechaInvalida()) return;
    void this.cargar();
  }

  restablecerFiltros(): void {
    const hoyLima = getFechaHoyLima();
    const [yStr, mStr] = hoyLima.split('-');
    this.filtroPeriodo.set({
      modo: 'mes_anio',
      rangoRapido: 'mes',
      mes: parseInt(mStr, 10),
      anio: parseInt(yStr, 10),
      fechaDesde: `${yStr}-${mStr}-01`,
      fechaHasta: hoyLima,
    });
    this.filtroConceptoSeleccionado.set('');
    this.filtroOrigen.set('todos');
    this.filtroMetodoPago.set('todos');
    this.busquedaIngreso.set('');
    this.filtroCategoriaSeleccionada.set('');
    this.busquedaEgreso.set('');
    void this.cargar();
  }

  // ── Filtros Específicos de Ingresos y Egresos ─────────────────────────────

  seleccionarFiltroConcepto(conc: string): void {
    this.filtroConceptoSeleccionado.set(conc);
    if (conc) {
      // Auto-expandir el drilldown del concepto seleccionado
      const clave = `ing:${conc}`;
      const set = new Set(this.expandidos());
      set.add(clave);
      this.expandidos.set(set);
      if (!this.detallesIngreso().has(conc)) {
        void this.cargarDetalleIngreso(conc, clave);
      }
    }
  }

  seleccionarFiltroCategoria(cat: string): void {
    this.filtroCategoriaSeleccionada.set(cat);
    if (cat) {
      const clave = `egr:${cat}`;
      const set = new Set(this.expandidos());
      set.add(clave);
      this.expandidos.set(set);
      if (!this.detallesEgreso().has(cat)) {
        void this.cargarDetalleEgreso(cat, clave);
      }
    }
  }

  // ── Drill-down Lazy por Concepto y Categoría ──────────────────────────────

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
    const p = this.periodoActivo();
    try {
      const lineas = await this.reportesSvc.cargarDetalleConceptoPeriodo(p.desde, p.hasta, concepto, 'todos');
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
    const p = this.periodoActivo();
    try {
      const lineas = await this.reportesSvc.cargarDetalleEgresosPeriodo(p.desde, p.hasta, categoria);
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

  // Filtrado reactivo en memoria para el detalle del concepto expandido
  getDetalleIngresoFiltrado(concepto: string): DetalleIngresoLinea[] {
    const lineas = this.detallesIngreso().get(concepto) ?? [];
    const orig = this.filtroOrigen();
    const met = this.filtroMetodoPago();
    const q = this.busquedaIngreso().trim().toLowerCase();

    return lineas.filter(l => {
      // Filtro origen
      if (orig === 'socios' && l.tipo_pagador !== 'socio') return false;
      if (orig === 'inquilinos' && l.tipo_pagador !== 'inquilino') return false;
      if (orig === 'otros' && l.tipo_pagador !== 'interno') return false;

      // Filtro método de pago
      if (met !== 'todos' && !l.metodo_pago.toLowerCase().includes(met.toLowerCase())) return false;

      // Buscador texto
      if (q) {
        const matchesPagador = l.pagador.toLowerCase().includes(q);
        const matchesRecibo = l.codigo_transaccion.toLowerCase().includes(q);
        const matchesPuesto = (l.codigo_puesto || '').toLowerCase().includes(q);
        if (!matchesPagador && !matchesRecibo && !matchesPuesto) return false;
      }

      return true;
    });
  }

  calcularSubtotalDetalleIngreso(concepto: string): number {
    return Math.round(this.getDetalleIngresoFiltrado(concepto).reduce((s, l) => s + l.monto, 0) * 100) / 100;
  }

  getDetalleEgresoFiltrado(categoria: string): DetalleEgresoLinea[] {
    const lineas = this.detallesEgreso().get(categoria) ?? [];
    const q = this.busquedaEgreso().trim().toLowerCase();

    if (!q) return lineas;

    return lineas.filter(g => {
      const matchDesc = (g.descripcion || '').toLowerCase().includes(q);
      const matchComp = (g.comprobante_ref || '').toLowerCase().includes(q);
      const matchResp = (g.responsable || '').toLowerCase().includes(q);
      return matchDesc || matchComp || matchResp;
    });
  }

  calcularSubtotalDetalleEgreso(categoria: string): number {
    return Math.round(this.getDetalleEgresoFiltrado(categoria).reduce((s, g) => s + g.monto, 0) * 100) / 100;
  }

  // Porcentaje del concepto respecto al total de ingresos del período
  pctConcepto(c: ConceptoResumen): number {
    const total = this.totalConceptosFiltrados();
    return total > 0 ? (c.monto / total) * 100 : 0;
  }

  pctEgreso(e: EgresoCategoria): number {
    const total = this.totalEgresosFiltrados();
    return total > 0 ? (e.monto / total) * 100 : 0;
  }

  // ── Exportación a Excel Respetando Filtros ─────────────────────────────────

  async exportarExcel(): Promise<void> {
    const r = this.reporte();
    if (!r || this.exportando()) return;

    this.exportando.set(true);
    this.error.set(null);
    const p = this.periodoActivo();

    try {
      const concFiltro = this.filtroConceptoSeleccionado() || null;
      const catFiltro = this.filtroCategoriaSeleccionada() || null;

      // Obtener detalle completo del período consultado
      const [detalleIngresos, detalleEgresos] = await Promise.all([
        this.reportesSvc.cargarDetalleConceptoPeriodo(p.desde, p.hasta, concFiltro, 'todos'),
        this.reportesSvc.cargarDetalleEgresosPeriodo(p.desde, p.hasta, catFiltro),
      ]);

      const hojaResumen = [
        { Indicador: 'Institución',                 Valor: 'COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO' },
        { Indicador: 'Reporte',                     Valor: 'Central de Reportes - Análisis Financiero' },
        { Indicador: 'Período Consultado',          Valor: `${p.etiqueta} (${p.desde} al ${p.hasta})` },
        { Indicador: 'Filtro Concepto',             Valor: concFiltro || 'Todos los conceptos' },
        { Indicador: 'Filtro Categoría Egresos',    Valor: catFiltro || 'Todas las categorías' },
        { Indicador: 'Caja — Ingresos Totales',     Valor: r.caja.efectivo + r.caja.transferencia },
        { Indicador: 'Caja — Efectivo',             Valor: r.caja.efectivo },
        { Indicador: 'Caja — Transferencia / QR',   Valor: r.caja.transferencia },
        { Indicador: 'Caja — Ingresos internos',    Valor: r.caja.ingresos_internos },
        { Indicador: 'Caja — Recaudación tarjeta',  Valor: r.caja.recaudacion_tarjeta },
        { Indicador: 'Caja — Egresos (gastos)',     Valor: r.caja.egresos },
        { Indicador: 'Caja — Saldo neto',           Valor: r.caja.saldo },
        { Indicador: 'Recibos válidos emitidos',    Valor: r.caja.count_recibos },
        { Indicador: 'Operaciones Caja Rápida',     Valor: r.caja.count_internos },
        { Indicador: 'Recibos anulados (excluidos)', Valor: r.caja.count_anulados },
      ];

      const hojaConceptos = this.conceptosFiltrados().map(c => ({
        Concepto:               c.concepto,
        'Cobros / Operaciones': c.cantidad,
        'Monto Total S/':       c.monto,
        'Socios S/':            c.monto_socios,
        'Inquilinos S/':        c.monto_inquilinos,
        'Otros S/':             Math.round((c.monto - c.monto_socios - c.monto_inquilinos) * 100) / 100,
        '% del Total':          `${this.pctConcepto(c).toFixed(1)}%`,
      }));

      const hojaDetalleIngresos = detalleIngresos.map(l => ({
        Fecha:         l.fecha_pago,
        'N° Recibo':   l.codigo_transaccion,
        Concepto:      l.concepto,
        Pagador:       l.pagador,
        Tipo:          l.tipo_pagador,
        Puesto:        l.codigo_puesto,
        Período:       l.periodo,
        Método:        l.metodo_pago,
        'Monto S/':    l.monto,
        Cajero:        l.cajero,
      }));

      const hojaEgresos = detalleEgresos.map(g => ({
        Fecha:         g.fecha,
        Categoría:     g.categoria,
        Comprobante:   g.comprobante_ref ?? '',
        Responsable:   g.responsable ?? '',
        Detalle:       g.descripcion ?? '',
        'Monto S/':    g.monto,
      }));

      const sufijo = concFiltro ? `_${concFiltro.replace(/[^a-zA-Z0-9]/g, '_')}` : '';
      await this.excelSvc.exportar(
        `reporte_financiero_${p.desde}_a_${p.hasta}${sufijo}.xlsx`,
        [
          { nombre: 'Resumen Financiero',    filas: hojaResumen },
          { nombre: 'Por Concepto',          filas: hojaConceptos },
          { nombre: 'Detalle Ingresos',      filas: hojaDetalleIngresos },
          { nombre: 'Egresos por Categoría', filas: hojaEgresos },
        ],
      );
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al exportar a Excel');
    } finally {
      this.exportando.set(false);
    }
  }
}
