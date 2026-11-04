import { Component, computed, inject, OnInit, signal, ViewChild } from '@angular/core';
import { NgClass } from '@angular/common';
import { FormsModule } from '@angular/forms';
import {
  ChartComponent,
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
  ApexLegend,
} from 'ng-apexcharts';
import {
  calcularPeriodoAnterior,
  ConceptoResumen,
  DetalleEgresoLinea,
  DetalleIngresoLinea,
  EgresoCategoria,
  FiltroPeriodoReporte,
  getFechaHoyLima,
  getNombreMes,
  ModoFiltroPeriodo,
  OrigenFiltroUI,
  PeriodoAnteriorResultado,
  PeriodoResuelto,
  RangoRapido,
  ReporteResumenV2,
  ReportesService,
  resolverPeriodoReporte,
} from '../../core/services/reportes.service';
import { ExcelExportService } from '../../core/services/excel-export.service';
import { ReportesPdfService, ReportePdfExportDatos } from '../../core/services/reportes-pdf.service';
import { ReportesExcelService, ReporteExcelExportDatos } from '../../core/services/reportes-excel.service';
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

interface SerieDiariaResultado {
  categories: string[];
  seriesData: number[];
  dias: Array<{ fecha: string; label: string; total: number; cantidad: number }>;
  totalSuma: number;
  diaMax: { fecha: string; label: string; total: number; cantidad: number } | null;
  diaMin: { fecha: string; label: string; total: number; cantidad: number } | null;
  promDiario: number;
  diasActivos: number;
  diasTotales: number;
}

@Component({
  selector: 'app-reportes',
  standalone: true,
  imports: [NgClass, FormsModule, NgApexchartsModule],
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
            <h1 class="text-2xl font-bold tracking-tight text-gray-900 dark:text-white">Central de Reportes y Análisis Financiero</h1>
          </div>
          <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">
            Análisis financiero consolidado, gráficos de evolución, tendencias y comparaciones históricas · Cooperativa Primero de Mayo
          </p>
        </div>

        <div class="flex flex-wrap items-center gap-3">
          <!-- Botón Comparar con Período Anterior -->
          <button
            (click)="toggleComparacion()"
            [ngClass]="compararConAnterior()
              ? 'bg-blue-600 text-white font-semibold shadow-sm'
              : 'border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 hover:bg-gray-50'"
            class="inline-flex items-center gap-2 rounded-xl px-4 py-2.5 text-sm font-medium transition shadow-sm">
            <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M7.5 21L3 16.5m0 0L7.5 12M3 16.5h13.5m0-13.5L21 7.5m0 0L16.5 12M21 7.5H7.5" />
            </svg>
            <span>{{ compararConAnterior() ? 'Comparación Activa' : 'Comparar con Anterior' }}</span>
          </button>

          <!-- Botón Exportar a Excel (Multipestaña Profesional) -->
          <button
            (click)="exportarExcel()"
            [disabled]="!reporte() || cargando() || exportando() || exportandoPdf()"
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

          <!-- Botón Exportar a PDF Institucional (A4 Consejo de Administración) -->
          <div class="relative inline-block text-left">
            <div class="inline-flex rounded-xl shadow-sm">
              <button
                (click)="exportarPdf('descargar')"
                [disabled]="!reporte() || cargando() || exportando() || exportandoPdf()"
                class="inline-flex items-center gap-2 rounded-l-xl bg-blue-700 hover:bg-blue-800 px-4 py-2.5 text-sm font-semibold text-white transition disabled:opacity-40 disabled:cursor-not-allowed">
                @if (exportandoPdf()) {
                  <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                  </svg>
                  <span>Generando PDF…</span>
                } @else {
                  <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m2.25 0H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z" />
                  </svg>
                  <span>Exportar PDF</span>
                }
              </button>
              <button
                (click)="menuExportarPdfAbierto.set(!menuExportarPdfAbierto())"
                [disabled]="!reporte() || cargando() || exportando() || exportandoPdf()"
                class="inline-flex items-center rounded-r-xl bg-blue-800 hover:bg-blue-900 px-2 py-2.5 text-sm font-semibold text-white transition disabled:opacity-40 disabled:cursor-not-allowed border-l border-blue-600">
                <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 8.25l-7.5 7.5-7.5-7.5" />
                </svg>
              </button>
            </div>

            @if (menuExportarPdfAbierto()) {
              <div
                class="absolute right-0 mt-2 w-56 rounded-xl bg-white dark:bg-gray-800 shadow-xl border border-gray-100 dark:border-gray-700 py-1.5 z-50 text-xs">
                <button
                  (click)="exportarPdf('descargar'); menuExportarPdfAbierto.set(false)"
                  class="w-full text-left px-4 py-2 hover:bg-blue-50 dark:hover:bg-blue-900/30 text-gray-700 dark:text-gray-200 flex items-center gap-2">
                  <svg class="h-4 w-4 text-blue-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75V16.5M16.5 12L12 16.5m0 0L7.5 12m4.5 4.5V3" />
                  </svg>
                  <span>Descargar archivo PDF (A4)</span>
                </button>
                <button
                  (click)="exportarPdf('abrir'); menuExportarPdfAbierto.set(false)"
                  class="w-full text-left px-4 py-2 hover:bg-blue-50 dark:hover:bg-blue-900/30 text-gray-700 dark:text-gray-200 flex items-center gap-2">
                  <svg class="h-4 w-4 text-emerald-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M13.5 6H5.25A2.25 2.25 0 003 8.25v10.5A2.25 2.25 0 005.25 21h10.5A2.25 2.25 0 0018 18.75V10.5m-10.5 6L21 3m0 0h-5.25M21 3v5.25" />
                  </svg>
                  <span>Abrir / Imprimir en nueva pestaña</span>
                </button>
              </div>
            }
          </div>
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

              <!-- Atajos de meses -->
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
        </div>
      }

      @if (reporte(); as r) {

        <!-- ═══════════════════════════════════════════════════════════════ -->
        <!-- SECCIÓN COMPARATIVA: PERÍODO ACTUAL VS ANTERIOR (ETAPA 2)       -->
        <!-- ═══════════════════════════════════════════════════════════════ -->
        @if (compararConAnterior() && reporteAnterior()) {
          <section class="rounded-2xl border border-blue-200 dark:border-blue-900/50 bg-gradient-to-r from-blue-50/50 via-white to-blue-50/30 dark:from-blue-950/20 dark:via-gray-800 dark:to-blue-950/10 p-5 shadow-sm space-y-4">
            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-2 border-b border-blue-100 dark:border-blue-900/40 pb-3">
              <div class="flex items-center gap-2">
                <span class="flex h-7 w-7 items-center justify-center rounded-lg bg-blue-100 dark:bg-blue-900/50 text-blue-700 dark:text-blue-300">
                  <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M7.5 21L3 16.5m0 0L7.5 12M3 16.5h13.5m0-13.5L21 7.5m0 0L16.5 12M21 7.5H7.5" />
                  </svg>
                </span>
                <h3 class="text-sm font-bold text-gray-900 dark:text-white uppercase tracking-wider">
                  Análisis Comparativo: {{ periodoActivo().etiqueta }} vs {{ infoPeriodoAnterior()?.etiqueta }}
                </h3>
              </div>

              @if (esPeriodoIncompleto()) {
                <span class="inline-flex items-center gap-1.5 rounded-lg bg-amber-50 dark:bg-amber-950/40 border border-amber-200 dark:border-amber-800/60 px-2.5 py-1 text-xs text-amber-800 dark:text-amber-300 font-medium">
                  ⚠️ Período actual en curso. Comparación proporcional a días transcurridos.
                </span>
              }
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
              <!-- Comparación Ingresos -->
              <div class="rounded-xl border border-gray-100 dark:border-gray-700/80 bg-white dark:bg-gray-800 p-4 shadow-2xs">
                <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider">Ingresos Totales</p>
                <div class="mt-2 flex items-baseline justify-between">
                  <span class="text-xl font-bold tabular-nums text-gray-900 dark:text-white">{{ fmtSoles(variacionIngresos().actual) }}</span>
                  <span class="text-xs text-gray-400">Ant: {{ fmtSoles(variacionIngresos().anterior) }}</span>
                </div>
                <div class="mt-2 flex items-center gap-1.5 text-xs font-semibold"
                  [ngClass]="variacionIngresos().diferencia >= 0 ? 'text-emerald-600 dark:text-emerald-400' : 'text-red-600 dark:text-red-400'">
                  <span>{{ variacionIngresos().diferencia >= 0 ? '▲ +' : '▼ ' }}{{ fmtSoles(variacionIngresos().diferencia) }}</span>
                  <span>({{ variacionIngresos().porcentaje >= 0 ? '+' : '' }}{{ variacionIngresos().porcentaje.toFixed(1) }}%)</span>
                </div>
              </div>

              <!-- Comparación Egresos -->
              <div class="rounded-xl border border-gray-100 dark:border-gray-700/80 bg-white dark:bg-gray-800 p-4 shadow-2xs">
                <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider">Egresos Operativos</p>
                <div class="mt-2 flex items-baseline justify-between">
                  <span class="text-xl font-bold tabular-nums text-red-600 dark:text-red-400">{{ fmtSoles(variacionEgresos().actual) }}</span>
                  <span class="text-xs text-gray-400">Ant: {{ fmtSoles(variacionEgresos().anterior) }}</span>
                </div>
                <div class="mt-2 flex items-center gap-1.5 text-xs font-semibold"
                  [ngClass]="variacionEgresos().diferencia <= 0 ? 'text-emerald-600 dark:text-emerald-400' : 'text-amber-600 dark:text-amber-400'">
                  <span>{{ variacionEgresos().diferencia >= 0 ? '▲ +' : '▼ ' }}{{ fmtSoles(variacionEgresos().diferencia) }}</span>
                  <span>({{ variacionEgresos().porcentaje >= 0 ? '+' : '' }}{{ variacionEgresos().porcentaje.toFixed(1) }}%)</span>
                </div>
              </div>

              <!-- Comparación Saldo Neto -->
              <div class="rounded-xl border border-gray-100 dark:border-gray-700/80 bg-white dark:bg-gray-800 p-4 shadow-2xs">
                <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider">Saldo Neto</p>
                <div class="mt-2 flex items-baseline justify-between">
                  <span class="text-xl font-bold tabular-nums" [ngClass]="variacionSaldo().actual >= 0 ? 'text-emerald-700 dark:text-emerald-300' : 'text-red-600 dark:text-red-400'">
                    {{ fmtSoles(variacionSaldo().actual) }}
                  </span>
                  <span class="text-xs text-gray-400">Ant: {{ fmtSoles(variacionSaldo().anterior) }}</span>
                </div>
                <div class="mt-2 text-xs font-semibold text-gray-600 dark:text-gray-300">
                  Dif: {{ fmtSoles(variacionSaldo().diferencia) }}
                </div>
              </div>

              <!-- Comparación Operaciones -->
              <div class="rounded-xl border border-gray-100 dark:border-gray-700/80 bg-white dark:bg-gray-800 p-4 shadow-2xs">
                <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider">Recibos Emitidos</p>
                <div class="mt-2 flex items-baseline justify-between">
                  <span class="text-xl font-bold tabular-nums text-gray-900 dark:text-white">{{ r.caja.count_recibos }}</span>
                  <span class="text-xs text-gray-400">Ant: {{ reporteAnterior()?.caja?.count_recibos ?? 0 }}</span>
                </div>
                <div class="mt-2 text-xs text-gray-500">
                  Variación: {{ r.caja.count_recibos - (reporteAnterior()?.caja?.count_recibos ?? 0) }} recibos
                </div>
              </div>
            </div>
          </section>
        }

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
            <span>Análisis de Ingresos y Evolución</span>
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
            <span>Análisis de Egresos y Categorías</span>
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
        <!-- SECCIÓN 2: ANÁLISIS DE INGRESOS + GRÁFICO DE EVOLUCIÓN (ETAPA 2)-->
        <!-- ═══════════════════════════════════════════════════════════════ -->
        @if (tabActiva() === 'ingresos' || tabActiva() === 'combinado') {
          <section class="rounded-2xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 shadow-sm overflow-hidden space-y-5">
            <div class="border-b border-gray-100 dark:border-gray-700 bg-gray-50/70 dark:bg-gray-700/30 p-5 space-y-4">
              <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                <div>
                  <h3 class="text-base font-bold text-gray-900 dark:text-white">Ingresos por Concepto</h3>
                  <p class="text-xs text-gray-500 dark:text-gray-400 mt-0.5">
                    Filtra por concepto, origen o método de pago para auditar y graficar las operaciones correspondientes.
                  </p>
                </div>

                <div class="flex items-center gap-3">
                  <!-- Botón Ver Evolución Gráfica -->
                  <button
                    (click)="mostrarGraficoIngresos.set(!mostrarGraficoIngresos())"
                    class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-semibold transition"
                    [ngClass]="mostrarGraficoIngresos()
                      ? 'bg-emerald-700 text-white shadow-sm'
                      : 'border border-emerald-300 dark:border-emerald-700 bg-emerald-50 dark:bg-emerald-950/40 text-emerald-800 dark:text-emerald-300 hover:bg-emerald-100'">
                    <svg class="h-3.5 w-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 18L9 11.25l4.306 4.307a11.95 11.95 0 015.814-5.519l2.74-1.22m0 0l-5.94-2.28m5.94 2.28l-2.28 5.941" />
                    </svg>
                    <span>{{ mostrarGraficoIngresos() ? 'Ocultar Gráfica' : 'Ver Evolución Gráfica' }}</span>
                  </button>

                  <div class="flex items-center gap-2 pl-2 border-l border-gray-200 dark:border-gray-700">
                    <span class="text-xs font-semibold text-gray-500">Total filtrado:</span>
                    <span class="text-base font-bold text-emerald-700 dark:text-emerald-400 tabular-nums">
                      {{ fmtSoles(totalConceptosFiltrados()) }}
                    </span>
                  </div>
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

            <!-- ── PANEL GRÁFICO APEXCHARTS DE EVOLUCIÓN (ETAPA 2) ──────────── -->
            @if (mostrarGraficoIngresos()) {
              <div class="p-5 border-b border-gray-200 dark:border-gray-700 bg-gray-50/40 dark:bg-gray-900/20 space-y-4">
                <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                  <div>
                    <h4 class="text-sm font-bold text-gray-900 dark:text-white flex items-center gap-2">
                      <span class="inline-block h-2.5 w-2.5 rounded-full bg-emerald-500"></span>
                      <span>Evolución Temporal: {{ conceptoGraficoActivo() }}</span>
                    </h4>
                    <p class="text-xs text-gray-400 mt-0.5">
                      Recaudación diaria continua (días sin movimiento explícitamente en S/ 0.00).
                    </p>
                  </div>

                  <!-- Botones rápidos de selección de concepto para graficar -->
                  <div class="flex flex-wrap items-center gap-1.5 text-xs">
                    <span class="text-gray-400 mr-1">Graficar:</span>
                    <button (click)="seleccionarConceptoParaGrafico('')" [ngClass]="!filtroConceptoSeleccionado() ? 'bg-emerald-600 text-white font-semibold' : 'bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-200 dark:border-gray-700'" class="px-2 py-0.5 rounded-lg transition">Todos</button>
                    <button (click)="seleccionarConceptoParaGrafico('SS.HH 1er PISO')" [ngClass]="filtroConceptoSeleccionado() === 'SS.HH 1er PISO' ? 'bg-emerald-600 text-white font-semibold' : 'bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-200 dark:border-gray-700'" class="px-2 py-0.5 rounded-lg transition">SS.HH</button>
                    <button (click)="seleccionarConceptoParaGrafico('Parqueo')" [ngClass]="filtroConceptoSeleccionado() === 'Parqueo' ? 'bg-emerald-600 text-white font-semibold' : 'bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-200 dark:border-gray-700'" class="px-2 py-0.5 rounded-lg transition">Parqueo</button>
                    <button (click)="seleccionarConceptoParaGrafico('Alquiler')" [ngClass]="filtroConceptoSeleccionado() === 'Alquiler' ? 'bg-emerald-600 text-white font-semibold' : 'bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-200 dark:border-gray-700'" class="px-2 py-0.5 rounded-lg transition">Alquiler</button>
                    <button (click)="seleccionarConceptoParaGrafico('Luz')" [ngClass]="filtroConceptoSeleccionado() === 'Luz' ? 'bg-emerald-600 text-white font-semibold' : 'bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-200 dark:border-gray-700'" class="px-2 py-0.5 rounded-lg transition">Luz</button>
                    <button (click)="seleccionarConceptoParaGrafico('Agua')" [ngClass]="filtroConceptoSeleccionado() === 'Agua' ? 'bg-emerald-600 text-white font-semibold' : 'bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 border border-gray-200 dark:border-gray-700'" class="px-2 py-0.5 rounded-lg transition">Agua</button>
                  </div>
                </div>

                <!-- KPIs del Gráfico: Día Pico, Día Mínimo, Promedio Diario -->
                @if (metricasGraficoIngresos(); as m) {
                  <div class="grid grid-cols-2 sm:grid-cols-4 gap-3 p-3 rounded-xl bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 text-xs">
                    <div>
                      <p class="text-gray-400">Total en Gráfico:</p>
                      <p class="text-sm font-bold text-emerald-700 dark:text-emerald-400 tabular-nums">{{ fmtSoles(m.totalSuma) }}</p>
                    </div>
                    <div>
                      <p class="text-gray-400">Día Pico (Mayor):</p>
                      <p class="text-sm font-bold text-gray-800 dark:text-white tabular-nums">
                        {{ m.diaMax ? m.diaMax.label + ' (' + fmtSoles(m.diaMax.total) + ')' : '—' }}
                      </p>
                    </div>
                    <div>
                      <p class="text-gray-400">Día Mínimo (con cobro):</p>
                      <p class="text-sm font-bold text-gray-800 dark:text-white tabular-nums">
                        {{ m.diaMin ? m.diaMin.label + ' (' + fmtSoles(m.diaMin.total) + ')' : '—' }}
                      </p>
                    </div>
                    <div>
                      <p class="text-gray-400">Promedio Diario (calendario):</p>
                      <p class="text-sm font-bold text-gray-800 dark:text-white tabular-nums">
                        {{ fmtSoles(m.promDiario) }} / día
                      </p>
                    </div>
                  </div>
                }

                <!-- Gráfica ApexCharts -->
                <div class="rounded-xl bg-white dark:bg-gray-800 p-2 border border-gray-200 dark:border-gray-700">
                  @if (cargandoGrafico()) {
                    <div class="flex h-64 items-center justify-center gap-2 text-xs text-gray-400">
                      <span class="h-4 w-4 animate-spin rounded-full border-2 border-emerald-500 border-t-transparent"></span>
                      <span>Generando serie histórica en ApexCharts…</span>
                    </div>
                  } @else if (chartIngresosSeries()[0].data.length > 0) {
                    <apx-chart
                      #chartIngresosRef
                      [series]="chartIngresosSeries()"
                      [chart]="chartIngresosConfig"
                      [xaxis]="chartIngresosXAxis()"
                      [yaxis]="chartIngresosYAxis"
                      [dataLabels]="chartDataLabelsFalse"
                      [colors]="chartIngresosColors"
                      [grid]="chartGridShared"
                      [stroke]="chartStrokeSmooth"
                      [fill]="chartFillGradient"
                      [tooltip]="chartTooltipCurrency"
                    ></apx-chart>
                  } @else {
                    <div class="flex h-64 items-center justify-center text-xs text-gray-400">
                      Sin movimientos para el concepto y filtros seleccionados.
                    </div>
                  }
                </div>
              </div>
            }

            <!-- Tabla de Conceptos Agrupados -->
            @if (conceptosFiltrados().length === 0) {
              <div class="p-12 text-center text-sm text-gray-400 dark:text-gray-500 space-y-2">
                <svg class="h-8 w-8 mx-auto text-gray-300" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z" />
                </svg>
                <p>No se encontraron conceptos para los filtros seleccionados.</p>
              </div>
            } @else {
              <div class="overflow-x-auto px-5 pb-5">
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
                                <div class="flex items-center gap-3">
                                  <button
                                    (click)="seleccionarConceptoParaGrafico(c.concepto); $event.stopPropagation()"
                                    class="text-xs text-emerald-600 hover:text-emerald-700 underline font-semibold">
                                    Ver gráfico de este concepto
                                  </button>
                                  <span class="text-xs font-semibold text-gray-500">
                                    Subtotal: {{ fmtSoles(calcularSubtotalDetalleIngreso(c.concepto)) }}
                                  </span>
                                </div>
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
        <!-- SECCIÓN 3: ANÁLISIS DE EGRESOS + GRÁFICO DE CATEGORÍAS (ETAPA 2)-->
        <!-- ═══════════════════════════════════════════════════════════════ -->
        @if (tabActiva() === 'egresos' || tabActiva() === 'combinado') {
          <section class="rounded-2xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 shadow-sm overflow-hidden space-y-5">
            <div class="border-b border-orange-100 dark:border-orange-900/40 bg-orange-50/50 dark:bg-orange-950/10 p-5 space-y-4">
              <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                <div>
                  <h3 class="text-base font-bold text-gray-900 dark:text-white">Egresos por Categoría</h3>
                  <p class="text-xs text-orange-700 dark:text-orange-400 mt-0.5">
                    Desglose de gastos operativos ejecutados en el período. Total: {{ fmtSoles(r.caja.egresos) }}
                  </p>
                </div>

                <div class="flex items-center gap-3">
                  <!-- Botón Ver Gráfica de Egresos -->
                  <button
                    (click)="mostrarGraficoEgresos.set(!mostrarGraficoEgresos())"
                    class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl text-xs font-semibold transition"
                    [ngClass]="mostrarGraficoEgresos()
                      ? 'bg-orange-600 text-white shadow-sm'
                      : 'border border-orange-300 dark:border-orange-700 bg-orange-50 dark:bg-orange-950/40 text-orange-800 dark:text-orange-300 hover:bg-orange-100'">
                    <svg class="h-3.5 w-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M3 13.125C3 12.504 3.504 12 4.125 12h2.25c.621 0 1.125.504 1.125 1.125v6.75C7.5 20.496 6.996 21 6.375 21h-2.25A1.125 1.125 0 013 19.875v-6.75zM9.75 8.625c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125v11.25c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V8.625zM16.5 4.125c0-.621.504-1.125 1.125-1.125h2.25C20.496 3 21 3.504 21 4.125v15.75c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V4.125z" />
                    </svg>
                    <span>{{ mostrarGraficoEgresos() ? 'Ocultar Gráfica' : 'Ver Gráfica de Categorías' }}</span>
                  </button>

                  <div class="flex items-center gap-2 pl-2 border-l border-gray-200 dark:border-gray-700">
                    <span class="text-xs font-semibold text-gray-500">Total egresos:</span>
                    <span class="text-base font-bold text-red-600 dark:text-red-400 tabular-nums">
                      {{ fmtSoles(totalEgresosFiltrados()) }}
                    </span>
                  </div>
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

            <!-- ── PANEL GRÁFICO APEXCHARTS DE EGRESOS POR CATEGORÍA ────────── -->
            @if (mostrarGraficoEgresos() && chartEgresosSeries()[0].data.length > 0) {
              <div class="p-5 border-b border-gray-200 dark:border-gray-700 bg-orange-50/20 dark:bg-orange-950/10 space-y-4">
                <div class="flex items-center justify-between">
                  <div>
                    <h4 class="text-sm font-bold text-gray-900 dark:text-white flex items-center gap-2">
                      <span class="inline-block h-2.5 w-2.5 rounded-full bg-orange-500"></span>
                      <span>Distribución de Gastos por Categoría (Orden de Mayor a Menor)</span>
                    </h4>
                    <p class="text-xs text-gray-400 mt-0.5">
                      Participación porcentual sobre el total de egresos operativos ejecutados en el período.
                    </p>
                  </div>
                </div>

                <div class="rounded-xl bg-white dark:bg-gray-800 p-2 border border-gray-200 dark:border-gray-700">
                  <apx-chart
                    [series]="chartEgresosSeries()"
                    [chart]="chartEgresosConfig"
                    [xaxis]="chartEgresosXAxis()"
                    [yaxis]="chartEgresosYAxis"
                    [plotOptions]="chartEgresosPlotOptions"
                    [dataLabels]="chartDataLabelsFalse"
                    [colors]="chartEgresosColors"
                    [grid]="chartGridShared"
                    [tooltip]="chartTooltipCurrency"
                  ></apx-chart>
                </div>
              </div>
            }

            <!-- Tabla de Categorías de Gasto -->
            @if (egresosFiltrados().length === 0) {
              <div class="p-12 text-center text-sm text-gray-400 dark:text-gray-500">
                No se registraron egresos para los filtros seleccionados en este período.
              </div>
            } @else {
              <div class="overflow-x-auto px-5 pb-5">
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
  private readonly excelSvc        = inject(ExcelExportService);
  private readonly reportesPdfSvc  = inject(ReportesPdfService);
  private readonly reportesExcelSvc = inject(ReportesExcelService);

  @ViewChild('chartIngresosRef') chartIngresosRef?: ChartComponent;

  readonly exportandoPdf = signal<boolean>(false);
  readonly menuExportarPdfAbierto = signal<boolean>(false);
  protected readonly auth      = inject(AuthService);

  // Helpers expuestos al template
  protected readonly fmtSoles      = fmtSoles;
  protected readonly fmtFechaCorta = fmtFechaCorta;
  protected readonly fmtFechaHora  = fmtFechaHora;

  // Estado del período activo
  readonly filtroPeriodo = signal<FiltroPeriodoReporte>({
    modo: 'mes_anio',
    rangoRapido: 'mes',
    mes: 10,  // Octubre 2026 por defecto (mes más completo en producción)
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

  // ── ETAPA 2: ESTADO DE COMPARACIÓN CON PERÍODO ANTERIOR ───────────────────
  readonly compararConAnterior  = signal<boolean>(false);
  readonly reporteAnterior      = signal<ReporteResumenV2 | null>(null);
  readonly cargandoComparacion  = signal<boolean>(false);

  // ── ETAPA 2: CONTROL DE VISUALIZACIÓN DE GRÁFICOS APEXCHARTS ──────────────
  readonly mostrarGraficoIngresos = signal<boolean>(true);
  readonly mostrarGraficoEgresos  = signal<boolean>(true);
  readonly cargandoGrafico        = signal<boolean>(false);

  // Período resuelto computado
  readonly periodoActivo = computed<PeriodoResuelto>(() =>
    resolverPeriodoReporte(this.filtroPeriodo()),
  );

  readonly infoPeriodoAnterior = computed<PeriodoAnteriorResultado | null>(() => {
    const p = this.periodoActivo();
    return calcularPeriodoAnterior(p.desde, p.hasta);
  });

  // Detección de período incompleto (ej. el mes actual en curso)
  readonly esPeriodoIncompleto = computed<boolean>(() => {
    const p = this.periodoActivo();
    const hoyLima = getFechaHoyLima();
    return p.desde <= hoyLima && p.hasta >= hoyLima;
  });

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

  // ── ETAPA 2: CÁLCULOS COMPARATIVOS PERÍODO ACTUAL VS ANTERIOR ─────────────

  readonly variacionIngresos = computed(() => {
    const act = (this.reporte()?.caja?.efectivo ?? 0) + (this.reporte()?.caja?.transferencia ?? 0);
    const ant = (this.reporteAnterior()?.caja?.efectivo ?? 0) + (this.reporteAnterior()?.caja?.transferencia ?? 0);
    const dif = Math.round((act - ant) * 100) / 100;
    const pct = ant > 0 ? ((act - ant) / ant) * 100 : 0;
    return { actual: act, anterior: ant, diferencia: dif, porcentaje: pct };
  });

  readonly variacionEgresos = computed(() => {
    const act = this.reporte()?.caja?.egresos ?? 0;
    const ant = this.reporteAnterior()?.caja?.egresos ?? 0;
    const dif = Math.round((act - ant) * 100) / 100;
    const pct = ant > 0 ? ((act - ant) / ant) * 100 : 0;
    return { actual: act, anterior: ant, diferencia: dif, porcentaje: pct };
  });

  readonly variacionSaldo = computed(() => {
    const act = this.reporte()?.caja?.saldo ?? 0;
    const ant = this.reporteAnterior()?.caja?.saldo ?? 0;
    const dif = Math.round((act - ant) * 100) / 100;
    return { actual: act, anterior: ant, diferencia: dif };
  });

  // ── ETAPA 2: GENERACIÓN DE SERIES PARA APEXCHARTS ──────────────────────────

  readonly conceptoGraficoActivo = computed<string>(() => {
    return this.filtroConceptoSeleccionado() || 'Total Ingresos (Consolidado)';
  });

  // Almacén de líneas activas para graficar
  private readonly lineasParaGrafico = signal<DetalleIngresoLinea[]>([]);

  readonly serieDiariaIngresos = computed<SerieDiariaResultado>(() => {
    const p = this.periodoActivo();
    const lineas = this.lineasParaGrafico();
    return this.calcularSerieDiaria(p.desde, p.hasta, lineas);
  });

  readonly metricasGraficoIngresos = computed(() => {
    return this.serieDiariaIngresos();
  });

  readonly chartIngresosSeries = computed<ApexAxisChartSeries>(() => [{
    name: this.conceptoGraficoActivo(),
    data: this.serieDiariaIngresos().seriesData,
  }]);

  readonly chartIngresosXAxis = computed<ApexXAxis>(() => ({
    categories: this.serieDiariaIngresos().categories,
    axisBorder: { show: false },
    axisTicks:  { show: false },
    labels: {
      rotate: -45,
      style: { fontFamily: 'Outfit, sans-serif', fontSize: '11px', colors: '#6b7280' },
    },
  }));

  // Configuración ApexCharts Ingresos (Área verde esmeralda)
  readonly chartIngresosConfig: ApexChart = {
    fontFamily: 'Outfit, sans-serif',
    type: 'area',
    height: 280,
    toolbar: { show: false },
    animations: { enabled: true, speed: 450 },
  };

  readonly chartIngresosColors: string[] = ['#059669'];

  readonly chartStrokeSmooth: ApexStroke = {
    curve: 'smooth',
    width: 2.5,
  };

  readonly chartFillGradient: ApexFill = {
    type: 'gradient',
    gradient: {
      shadeIntensity: 1,
      opacityFrom: 0.45,
      opacityTo: 0.05,
      stops: [0, 90, 100],
    },
  };

  readonly chartIngresosYAxis: ApexYAxis = {
    labels: {
      formatter: (val: number) => `S/ ${val >= 1000 ? (val / 1000).toFixed(1) + 'k' : val.toFixed(0)}`,
      style: { fontFamily: 'Outfit, sans-serif', fontSize: '11px' },
    },
  };

  // ── Configuración ApexCharts Egresos por Categoría (Barras Horizontales) ───

  readonly chartEgresosSeries = computed<ApexAxisChartSeries>(() => [{
    name: 'Gasto S/',
    data: this.egresosFiltrados().map(e => e.monto),
  }]);

  readonly chartEgresosXAxis = computed<ApexXAxis>(() => ({
    categories: this.egresosFiltrados().map(e => e.categoria),
    labels: {
      formatter: (val: string) => `S/ ${Number(val) >= 1000 ? (Number(val) / 1000).toFixed(1) + 'k' : val}`,
      style: { fontFamily: 'Outfit, sans-serif', fontSize: '11px' },
    },
  }));

  readonly chartEgresosConfig: ApexChart = {
    fontFamily: 'Outfit, sans-serif',
    type: 'bar',
    height: 280,
    toolbar: { show: false },
    animations: { enabled: true, speed: 450 },
  };

  readonly chartEgresosColors: string[] = ['#ea580c'];

  readonly chartEgresosPlotOptions: ApexPlotOptions = {
    bar: {
      horizontal: true,
      borderRadius: 4,
      barHeight: '60%',
    },
  };

  readonly chartEgresosYAxis: ApexYAxis = {
    labels: {
      style: { fontFamily: 'Outfit, sans-serif', fontSize: '11px' },
    },
  };

  // Configuración compartida
  readonly chartDataLabelsFalse: ApexDataLabels = { enabled: false };

  readonly chartGridShared: ApexGrid = {
    borderColor: '#f3f4f6',
    strokeDashArray: 3,
    yaxis: { lines: { show: true } },
    xaxis: { lines: { show: false } },
  };

  readonly chartTooltipCurrency: ApexTooltip = {
    y: { formatter: (val: number) => fmtSoles(val) },
    theme: 'light',
  };

  // ── Inicialización ────────────────────────────────────────────────────────

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
      // 1. Cargar KPIs de caja y agrupaciones server-side del período actual
      const r = await this.reportesSvc.cargarResumenPeriodo(p.desde, p.hasta, 'todos');
      this.reporte.set(r);

      // 2. Si la comparación está activa, cargar período anterior
      if (this.compararConAnterior()) {
        await this.cargarReporteAnterior();
      }

      // 3. Cargar líneas para el gráfico de ingresos
      await this.actualizarLineasGrafico();

    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar el reporte');
    } finally {
      this.cargando.set(false);
    }
  }

  async toggleComparacion(): Promise<void> {
    const nuevoEstado = !this.compararConAnterior();
    this.compararConAnterior.set(nuevoEstado);
    if (nuevoEstado && !this.reporteAnterior()) {
      await this.cargarReporteAnterior();
    }
  }

  private async cargarReporteAnterior(): Promise<void> {
    const ant = this.infoPeriodoAnterior();
    if (!ant) return;
    this.cargandoComparacion.set(true);
    try {
      const rAnt = await this.reportesSvc.cargarResumenPeriodo(ant.desde, ant.hasta, 'todos');
      this.reporteAnterior.set(rAnt);
    } catch {
      // En caso de fallo silencioso en comparación, no interrumpir el reporte principal
    } finally {
      this.cargandoComparacion.set(false);
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
    this.compararConAnterior.set(false);
    void this.cargar();
  }

  // ── Filtros Específicos de Ingresos y Egresos ─────────────────────────────

  seleccionarFiltroConcepto(conc: string): void {
    this.filtroConceptoSeleccionado.set(conc);
    void this.actualizarLineasGrafico();

    if (conc) {
      const clave = `ing:${conc}`;
      const set = new Set(this.expandidos());
      set.add(clave);
      this.expandidos.set(set);
      if (!this.detallesIngreso().has(conc)) {
        void this.cargarDetalleIngreso(conc, clave);
      }
    }
  }

  seleccionarConceptoParaGrafico(conc: string): void {
    this.seleccionarFiltroConcepto(conc);
    this.mostrarGraficoIngresos.set(true);
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

      // Si este es el concepto que se está graficando, actualizar serie
      if (this.filtroConceptoSeleccionado() === concepto) {
        this.lineasParaGrafico.set(lineas);
      }
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

  // ── ETAPA 2: ACTUALIZACIÓN DE LÍNEAS PARA EL GRÁFICO DE APEXCHARTS ────────

  private async actualizarLineasGrafico(): Promise<void> {
    const conc = this.filtroConceptoSeleccionado() || null;
    const p = this.periodoActivo();

    // Si ya lo tenemos en caché de detalles
    if (conc && this.detallesIngreso().has(conc)) {
      this.lineasParaGrafico.set(this.detallesIngreso().get(conc) ?? []);
      return;
    }

    this.cargandoGrafico.set(true);
    try {
      const lineas = await this.reportesSvc.cargarDetalleConceptoPeriodo(p.desde, p.hasta, conc, 'todos');
      this.lineasParaGrafico.set(lineas);
      if (conc) {
        const map = new Map(this.detallesIngreso());
        map.set(conc, lineas);
        this.detallesIngreso.set(map);
      }
    } catch {
      this.lineasParaGrafico.set([]);
    } finally {
      this.cargandoGrafico.set(false);
    }
  }

  // Generador de serie temporal continua con relleno de ceros
  private calcularSerieDiaria(desde: string, hasta: string, lineas: DetalleIngresoLinea[]): SerieDiariaResultado {
    const [y1, m1, d1] = desde.split('-').map(Number);
    const [y2, m2, d2] = hasta.split('-').map(Number);
    const dt1 = new Date(y1, m1 - 1, d1);
    const dt2 = new Date(y2, m2 - 1, d2);

    const pad = (n: number) => String(n).padStart(2, '0');
    const mapaDias = new Map<string, { label: string; total: number; cantidad: number }>();

    // Generar secuencia continua de días
    const cur = new Date(dt1);
    while (cur <= dt2) {
      const key = `${cur.getFullYear()}-${pad(cur.getMonth() + 1)}-${pad(cur.getDate())}`;
      const label = `${pad(cur.getDate())}/${pad(cur.getMonth() + 1)}`;
      mapaDias.set(key, { label, total: 0, cantidad: 0 });
      cur.setDate(cur.getDate() + 1);
    }

    // Filtrar líneas según origen o método si aplica
    const orig = this.filtroOrigen();
    const met = this.filtroMetodoPago();

    for (const l of lineas) {
      if (orig === 'socios' && l.tipo_pagador !== 'socio') continue;
      if (orig === 'inquilinos' && l.tipo_pagador !== 'inquilino') continue;
      if (orig === 'otros' && l.tipo_pagador !== 'interno') continue;
      if (met !== 'todos' && !l.metodo_pago.toLowerCase().includes(met.toLowerCase())) continue;

      const fechaLima = new Intl.DateTimeFormat('en-CA', {
        timeZone: 'America/Lima',
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
      }).format(new Date(l.fecha_pago));

      if (mapaDias.has(fechaLima)) {
        const slot = mapaDias.get(fechaLima)!;
        slot.total = Math.round((slot.total + Number(l.monto)) * 100) / 100;
        slot.cantidad += 1;
      }
    }

    const dias = Array.from(mapaDias.entries()).map(([fecha, { label, total, cantidad }]) => ({
      fecha,
      label,
      total,
      cantidad,
    }));

    const totalSuma = Math.round(dias.reduce((s, d) => s + d.total, 0) * 100) / 100;
    const diasConMov = dias.filter(d => d.total > 0);
    let diaMax = null;
    let diaMin = null;
    if (diasConMov.length > 0) {
      diaMax = [...diasConMov].sort((a, b) => b.total - a.total)[0];
      diaMin = [...diasConMov].sort((a, b) => a.total - b.total)[0];
    }
    const promDiario = dias.length > 0 ? Math.round((totalSuma / dias.length) * 100) / 100 : 0;

    return {
      categories: dias.map(d => d.label),
      seriesData: dias.map(d => d.total),
      dias,
      totalSuma,
      diaMax,
      diaMin,
      promDiario,
      diasActivos: diasConMov.length,
      diasTotales: dias.length,
    };
  }

  // Filtrado reactivo en memoria para el detalle del concepto expandido
  getDetalleIngresoFiltrado(concepto: string): DetalleIngresoLinea[] {
    const lineas = this.detallesIngreso().get(concepto) ?? [];
    const orig = this.filtroOrigen();
    const met = this.filtroMetodoPago();
    const q = this.busquedaIngreso().trim().toLowerCase();

    return lineas.filter(l => {
      if (orig === 'socios' && l.tipo_pagador !== 'socio') return false;
      if (orig === 'inquilinos' && l.tipo_pagador !== 'inquilino') return false;
      if (orig === 'otros' && l.tipo_pagador !== 'interno') return false;
      if (met !== 'todos' && !l.metodo_pago.toLowerCase().includes(met.toLowerCase())) return false;

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

    /**
   * Construye el payload común de exportación garantizando equivalencia
   * financiera al 100% entre pantalla, Excel y PDF.
   */
  private construirPayloadExportacion(
    r: ReporteResumenV2,
    p: PeriodoResuelto,
    concFiltro: string | null,
    catFiltro: string | null,
    detalleIngresos: DetalleIngresoLinea[],
    detalleEgresos: DetalleEgresoLinea[],
    graficoB64: string | null = null,
  ): ReportePdfExportDatos & ReporteExcelExportDatos {
    const actIng = r.caja.efectivo + r.caja.transferencia;
    const actEg = r.caja.egresos;
    const actSal = r.caja.saldo;

    // Datos de comparación si está activa
    let compData = null;
    const ant = this.reporteAnterior();
    const infoAnt = this.infoPeriodoAnterior();
    if (this.compararConAnterior() && ant && infoAnt) {
      const antIng = ant.caja.efectivo + ant.caja.transferencia;
      const antEg = ant.caja.egresos;
      const antSal = ant.caja.saldo;
      compData = {
        periodoAnteriorEtiqueta: infoAnt.etiqueta,
        periodoAnteriorDesde: infoAnt.desde,
        periodoAnteriorHasta: infoAnt.hasta,
        esIncompleto: this.esPeriodoIncompleto(),
        ingresos: {
          actual: actIng,
          anterior: antIng,
          diferencia: Math.round((actIng - antIng) * 100) / 100,
          porcentaje: antIng > 0 ? ((actIng - antIng) / antIng) * 100 : 0,
        },
        egresos: {
          actual: actEg,
          anterior: antEg,
          diferencia: Math.round((actEg - antEg) * 100) / 100,
          porcentaje: antEg > 0 ? ((actEg - antEg) / antEg) * 100 : 0,
        },
        saldoNeto: {
          actual: actSal,
          anterior: antSal,
          diferencia: Math.round((actSal - antSal) * 100) / 100,
          porcentaje: antSal > 0 ? ((actSal - antSal) / antSal) * 100 : 0,
        },
      };
    }

    // Datos de evolución temporal
    const evo = this.serieDiariaIngresos();
    let evoData = null;
    if (evo && evo.diasTotales > 0) {
      evoData = {
        conceptoNombre: concFiltro || 'Total General de Ingresos',
        total: evo.totalSuma,
        diasTotales: evo.diasTotales,
        diasConCobro: evo.diasActivos,
        diasCero: Math.max(0, evo.diasTotales - evo.diasActivos),
        promedioDiario: evo.promDiario,
        diaPico: {
          fecha: evo.diaMax?.label || evo.diaMax?.fecha || '-',
          monto: evo.diaMax?.total || 0,
        },
        diaMinimo: {
          fecha: evo.diaMin?.label || evo.diaMin?.fecha || '-',
          monto: evo.diaMin?.total || 0,
        },
        serie: evo.dias.map(d => ({
          fecha: d.fecha,
          dia: d.label,
          monto: d.total,
          cantidad: d.cantidad,
        })),
      };
    }

    const pad = (n: number) => String(n).padStart(2, '0');
    const ahora = new Date();
    const fechaEmision = `${ahora.getFullYear()}-${pad(ahora.getMonth() + 1)}-${pad(ahora.getDate())} ${pad(ahora.getHours())}:${pad(ahora.getMinutes())}`;

    return {
      titulo: 'CENTRAL DE REPORTES — INFORME FINANCIERO Y CONTROL DE CAJA',
      subtitulo: 'COOPERATIVA DE SERVICIOS ESPECIALES — RUC: 20100000000',
      institucion: 'COOPERATIVA DE SERVICIOS ESPECIALES PRIMERO DE MAYO LTDA.',
      ruc: '20100000000',
      periodoEtiqueta: p.etiqueta,
      periodoDesde: p.desde,
      periodoHasta: p.hasta,
      generadoEn: fechaEmision,
      usuario: 'Administración ERP',

      filtroConcepto: concFiltro,
      filtroCategoria: catFiltro,
      filtroTipoPagador: this.filtroOrigen(),
      filtroMetodoPago: this.filtroMetodoPago(),
      vistaActiva: this.tabActiva(),

      resumenCaja: {
        totalIngresos: actIng,
        efectivo: r.caja.efectivo,
        transferencia: r.caja.transferencia,
        ingresosInternos: r.caja.ingresos_internos,
        recaudacionTarjeta: r.caja.recaudacion_tarjeta,
        egresos: actEg,
        saldoNeto: actSal,
        countRecibos: r.caja.count_recibos,
        countInternos: r.caja.count_internos,
        countAnulados: r.caja.count_anulados,
      },

      comparacion: compData,
      evolucionTemporal: evoData,

      conceptos: this.conceptosFiltrados().map(c => ({
        concepto: c.concepto,
        cantidad: c.cantidad,
        monto: c.monto,
        montoSocios: c.monto_socios,
        montoInquilinos: c.monto_inquilinos,
        montoOtros: Math.round((c.monto - c.monto_socios - c.monto_inquilinos) * 100) / 100,
        porcentaje: this.pctConcepto(c),
      })),

      categoriasEgreso: this.egresosFiltrados().map(e => ({
        categoria: e.categoria,
        cantidad: e.cantidad,
        monto: e.monto,
        porcentaje: this.pctEgreso(e),
      })),

      movimientosIngreso: detalleIngresos.map(l => ({
        fecha: l.fecha_pago,
        recibo: l.codigo_transaccion,
        concepto: l.concepto,
        pagador: l.pagador,
        tipoPagador: l.tipo_pagador,
        puesto: l.codigo_puesto,
        periodo: l.periodo,
        metodoPago: l.metodo_pago,
        monto: l.monto,
        cajero: l.cajero,
      })),

      movimientosEgreso: detalleEgresos.map(g => ({
        fecha: g.fecha,
        categoria: g.categoria,
        comprobante: g.comprobante_ref ?? '',
        responsable: g.responsable ?? '',
        descripcion: g.descripcion ?? '',
        monto: g.monto,
      })),

      graficoBase64: graficoB64,
    };
  }

  /**
   * Exporta a Excel profesional con libro multipestaña (Etapa 3)
   */
  async exportarExcel(): Promise<void> {
    const r = this.reporte();
    if (!r || this.exportando() || this.exportandoPdf()) return;

    this.exportando.set(true);
    this.error.set(null);
    const p = this.periodoActivo();

    try {
      const concFiltro = this.filtroConceptoSeleccionado() || null;
      const catFiltro = this.filtroCategoriaSeleccionada() || null;

      const [detalleIngresos, detalleEgresos] = await Promise.all([
        this.reportesSvc.cargarDetalleConceptoPeriodo(p.desde, p.hasta, concFiltro, 'todos'),
        this.reportesSvc.cargarDetalleEgresosPeriodo(p.desde, p.hasta, catFiltro),
      ]);

      const payload = this.construirPayloadExportacion(r, p, concFiltro, catFiltro, detalleIngresos, detalleEgresos);
      await this.reportesExcelSvc.exportarLibroFinanciero(payload);
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : String(err);
      this.error.set(`Error al exportar a Excel: ${msg}`);
    } finally {
      this.exportando.set(false);
    }
  }

  /**
   * Exporta a PDF institucional A4 para el Consejo de Administración (Etapa 3)
   */
  async exportarPdf(modo: 'descargar' | 'abrir' = 'descargar'): Promise<void> {
    const r = this.reporte();
    if (!r || this.exportando() || this.exportandoPdf()) return;

    this.exportandoPdf.set(true);
    this.error.set(null);
    const p = this.periodoActivo();

    try {
      const concFiltro = this.filtroConceptoSeleccionado() || null;
      const catFiltro = this.filtroCategoriaSeleccionada() || null;

      const [detalleIngresos, detalleEgresos] = await Promise.all([
        this.reportesSvc.cargarDetalleConceptoPeriodo(p.desde, p.hasta, concFiltro, 'todos'),
        this.reportesSvc.cargarDetalleEgresosPeriodo(p.desde, p.hasta, catFiltro),
      ]);

      // Captura de imagen base64 de ApexCharts si está disponible
      let graficoB64: string | null = null;
      try {
        if (this.chartIngresosRef) {
          const res = await this.chartIngresosRef.dataURI();
          if (res && 'imgURI' in res && typeof res.imgURI === 'string') {
            graficoB64 = res.imgURI;
          }
        }
      } catch {
        // Fallback elegante sin distorsión
      }

      const payload = this.construirPayloadExportacion(r, p, concFiltro, catFiltro, detalleIngresos, detalleEgresos, graficoB64);

      if (modo === 'abrir') {
        await this.reportesPdfSvc.generarYAbrir(payload);
      } else {
        await this.reportesPdfSvc.descargar(payload);
      }
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : String(err);
      this.error.set(`Error al generar el reporte PDF: ${msg}`);
    } finally {
      this.exportandoPdf.set(false);
    }
  }
}
