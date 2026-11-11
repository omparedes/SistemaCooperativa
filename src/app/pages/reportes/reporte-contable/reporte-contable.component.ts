import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { AuthService } from '../../../core/services/auth.service';
import { ReporteContableService } from '../../../core/services/reporte-contable.service';
import { ReporteContableExcelService } from '../../../core/services/reporte-contable-excel.service';
import {
  ComprobanteContableItem,
  FiltroCanalContable,
  FiltroDocumentoContable,
  FiltroEstadoComprobante,
  FiltroOrigenContable,
  FiltroReporteContable,
  GrupoDiarioComprobantes,
  ModoPeriodoContable,
  ResultadoReporteContable,
  round2,
} from './reporte-contable.model';

const MESES_CATALOGO = [
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
] as const;

const ANIOS_DISPONIBLES = [2025, 2026, 2027] as const;

function obtenerHoyLimaYmd(): string {
  return new Intl.DateTimeFormat('en-CA', {
    timeZone: 'America/Lima',
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
  }).format(new Date());
}

function calcularRangoMes(anio: number, mes: number): { desde: string; hasta: string; etiqueta: string } {
  const pad = (n: number) => String(n).padStart(2, '0');
  const ultimoDia = new Date(anio, mes, 0).getDate();
  const nombreMes = MESES_CATALOGO.find(m => m.num === mes)?.nombre ?? `Mes ${mes}`;
  return {
    desde: `${anio}-${pad(mes)}-01`,
    hasta: `${anio}-${pad(mes)}-${pad(ultimoDia)}`,
    etiqueta: `${nombreMes} ${anio}`,
  };
}

@Component({
  selector: 'app-reporte-contable',
  standalone: true,
  imports: [FormsModule, RouterLink],
  template: `
    <div class="p-4 sm:p-6 max-w-[1600px] mx-auto space-y-6">

      <!-- ================================================================== -->
      <!-- SECCIÓN A: ENCABEZADO Y ACCIÓN PRINCIPAL                           -->
      <!-- ================================================================== -->
      <header class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl p-5 shadow-sm">
        <div>
          <!-- Breadcrumb -->
          <nav aria-label="Breadcrumb" class="flex items-center gap-2 text-xs font-medium text-gray-500 dark:text-gray-400 mb-1.5">
            <a routerLink="/reportes" class="hover:text-brand-600 dark:hover:text-brand-400 transition-colors">
              Reportes
            </a>
            <span>/</span>
            <span class="text-gray-800 dark:text-gray-200 font-semibold">Reporte Contable</span>
          </nav>

          <div class="flex flex-wrap items-center gap-2.5">
            <h1 class="text-xl sm:text-2xl font-bold text-gray-900 dark:text-white tracking-tight">
              Reporte Contable de Ingresos
            </h1>
            <span class="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-xs font-medium bg-emerald-50 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-300 border border-emerald-200 dark:border-emerald-800">
              Solo Lectura · Conciliado
            </span>
          </div>
          <p class="text-sm text-gray-500 dark:text-gray-400 mt-1">
            Consulta y exportación detallada de comprobantes
            @if (datosReporte(); as rep) {
              <span class="text-gray-400 dark:text-gray-500">·</span>
              <span class="font-medium text-gray-700 dark:text-gray-300">{{ rep.periodoEtiqueta }} ({{ rep.periodoDesde }} a {{ rep.periodoHasta }})</span>
            }
          </p>
        </div>

        <!-- Botones de Acción Principal -->
        <div class="flex flex-wrap items-center gap-2.5">
          @if (tienePermiso()) {
            <button
              type="button"
              (click)="exportarExcel(true)"
              [disabled]="cargando() || exportando() || comprobantesFiltrados().length === 0"
              title="Generar muestra Excel anonimizada para revisión de contabilidad"
              class="inline-flex items-center gap-2 px-3.5 py-2.5 rounded-xl border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 hover:bg-gray-50 dark:hover:bg-gray-700 text-gray-700 dark:text-gray-200 text-xs sm:text-sm font-medium transition disabled:opacity-50 disabled:cursor-not-allowed">
              <svg class="w-4 h-4 text-gray-500 dark:text-gray-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
              </svg>
              Muestra Anonimizada
            </button>

            <button
              type="button"
              (click)="exportarExcel(false)"
              [disabled]="cargando() || exportando() || comprobantesFiltrados().length === 0"
              class="inline-flex items-center gap-2 px-4 py-2.5 rounded-xl bg-emerald-600 hover:bg-emerald-700 text-white text-xs sm:text-sm font-semibold shadow-sm transition disabled:opacity-50 disabled:cursor-not-allowed">
              @if (exportando()) {
                <span class="h-4 w-4 rounded-full border-2 border-white border-t-transparent animate-spin"></span>
                Generando Excel...
              } @else {
                <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 10v6m0 0l-3-3m3 3l3-3M3 17V7a2 2 0 012-2h6l2 2h6a2 2 0 012 2v8a2 2 0 01-2 2H5a2 2 0 01-2-2z"/>
                </svg>
                Exportar Excel
              }
            </button>
          }
        </div>
      </header>

      <!-- Aviso de restricción de rol si un usuario Asistente accede a la ruta -->
      @if (!tienePermiso()) {
        <div class="p-6 rounded-2xl bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 text-amber-900 dark:text-amber-200 space-y-2">
          <div class="flex items-center gap-2 font-semibold text-base">
            <svg class="w-5 h-5 text-amber-600 dark:text-amber-400 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
            </svg>
            <span>Acceso restringido para exportación de documentos personales (DNI/RUC)</span>
          </div>
          <p class="text-sm leading-relaxed">
            Su cuenta tiene asignado el rol <strong>{{ rolActual() }}</strong>. Por políticas de seguridad y protección de datos personales, la consulta y exportación del Reporte Contable con DNI está autorizada únicamente para los roles <strong>Administrador</strong> y <strong>Caja</strong>.
          </p>
        </div>
      } @else {

        <!-- Banner de error o éxito de exportación -->
        @if (error()) {
          <div class="p-4 rounded-xl bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 text-sm flex items-start justify-between gap-3">
            <div class="flex items-start gap-2.5">
              <svg class="w-5 h-5 text-red-600 dark:text-red-400 shrink-0 mt-0.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <circle cx="12" cy="12" r="10"/><path stroke-linecap="round" d="M12 8v4m0 4h.01"/>
              </svg>
              <span>{{ error() }}</span>
            </div>
            <button type="button" (click)="error.set(null)" class="text-xs underline shrink-0">Cerrar</button>
          </div>
        }

        @if (mensajeExportacion()) {
          <div class="p-3.5 rounded-xl bg-emerald-50 dark:bg-emerald-900/20 border border-emerald-200 dark:border-emerald-800 text-emerald-800 dark:text-emerald-200 text-sm flex items-center justify-between gap-3">
            <div class="flex items-center gap-2">
              <svg class="w-4 h-4 text-emerald-600 dark:text-emerald-400 shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/>
              </svg>
              <span>{{ mensajeExportacion() }}</span>
            </div>
            <button type="button" (click)="mensajeExportacion.set(null)" class="text-xs underline">Ocultar</button>
          </div>
        }

        <!-- ================================================================ -->
        <!-- SECCIÓN B: PANEL DE FILTROS                                      -->
        <!-- ================================================================ -->
        <section aria-label="Panel de filtros" class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl p-5 shadow-sm space-y-4">
          <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 pb-3 border-b border-gray-100 dark:border-gray-700">
            <div class="flex items-center gap-2">
              <h2 class="text-sm font-semibold text-gray-800 dark:text-gray-100 uppercase tracking-wider">
                Panel de Filtros Contables
              </h2>
              @if (tieneCambiosPendientesDeAplicar()) {
                <span class="px-2 py-0.5 text-[11px] font-medium rounded-full bg-amber-100 text-amber-800 dark:bg-amber-900/40 dark:text-amber-300">
                  Cambios pendientes — pulse Aplicar
                </span>
              }
            </div>

            <!-- Selector de modo de período (Mes/Año vs Rango personalizado) -->
            <div class="inline-flex rounded-xl bg-gray-100 dark:bg-gray-900 p-1 text-xs font-medium">
              <button
                type="button"
                (click)="cambiarModoPeriodoBorrador('mes_anio')"
                [class]="filtroBorrador().modoPeriodo === 'mes_anio'
                  ? 'px-3 py-1.5 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white shadow-xs font-semibold'
                  : 'px-3 py-1.5 rounded-lg text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white'">
                Mes y Año
              </button>
              <button
                type="button"
                (click)="cambiarModoPeriodoBorrador('personalizado')"
                [class]="filtroBorrador().modoPeriodo === 'personalizado'
                  ? 'px-3 py-1.5 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white shadow-xs font-semibold'
                  : 'px-3 py-1.5 rounded-lg text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white'">
                Rango Personalizado
              </button>
            </div>
          </div>

          <!-- Fila 1 de Filtros: Período, Origen, Canal, Concepto -->
          <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-6 gap-3.5">
            @if (filtroBorrador().modoPeriodo === 'mes_anio') {
              <div>
                <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Mes</label>
                <select
                  [ngModel]="filtroBorrador().mes"
                  (ngModelChange)="actualizarMesBorrador($event)"
                  class="w-full rounded-xl border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500">
                  @for (m of mesesCatalogo; track m.num) {
                    <option [ngValue]="m.num">{{ m.nombre }}</option>
                  }
                </select>
              </div>
              <div>
                <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Año</label>
                <select
                  [ngModel]="filtroBorrador().anio"
                  (ngModelChange)="actualizarAnioBorrador($event)"
                  class="w-full rounded-xl border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500">
                  @for (a of aniosDisponibles; track a) {
                    <option [ngValue]="a">{{ a }}</option>
                  }
                </select>
              </div>
            } @else {
              <div>
                <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Fecha desde</label>
                <input
                  type="date"
                  [ngModel]="filtroBorrador().fechaDesde"
                  (ngModelChange)="actualizarCampoBorrador('fechaDesde', $event)"
                  class="w-full rounded-xl border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
              </div>
              <div>
                <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Fecha hasta</label>
                <input
                  type="date"
                  [ngModel]="filtroBorrador().fechaHasta"
                  (ngModelChange)="actualizarCampoBorrador('fechaHasta', $event)"
                  class="w-full rounded-xl border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
              </div>
            }

            <!-- Origen -->
            <div>
              <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Origen</label>
              <select
                [ngModel]="filtroBorrador().origen"
                (ngModelChange)="actualizarCampoBorrador('origen', $event)"
                class="w-full rounded-xl border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500">
                <option value="TODOS">Todos</option>
                <option value="SOCIOS">Socios</option>
                <option value="INQUILINOS">Inquilinos</option>
                <option value="OTROS">Otros (Caja Rápida)</option>
              </select>
            </div>

            <!-- Canal -->
            <div>
              <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Canal</label>
              <select
                [ngModel]="filtroBorrador().canal"
                (ngModelChange)="actualizarCampoBorrador('canal', $event)"
                class="w-full rounded-xl border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500">
                <option value="TODOS">Todos los canales</option>
                <option value="EFECTIVO">Efectivo</option>
                <option value="BANCO">Banco / Transferencia / QR</option>
                <option value="SALDO_FAVOR">Saldo a favor</option>
                <option value="MIXTO">Mixto</option>
              </select>
            </div>

            <!-- Concepto Contable -->
            <div>
              <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Concepto contable</label>
              <select
                [ngModel]="filtroBorrador().concepto"
                (ngModelChange)="actualizarCampoBorrador('concepto', $event)"
                class="w-full rounded-xl border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500">
                <option value="">Todos los conceptos</option>
                @for (conc of conceptosDisponibles(); track conc) {
                  <option [value]="conc">{{ conc }}</option>
                }
              </select>
            </div>

            <!-- Estado -->
            <div>
              <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Estado</label>
              <select
                [ngModel]="filtroBorrador().estado"
                (ngModelChange)="actualizarCampoBorrador('estado', $event)"
                class="w-full rounded-xl border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500">
                <option value="VIGENTES">Vigentes</option>
                <option value="ANULADOS">Anulados</option>
                <option value="TODOS">Todos</option>
              </select>
            </div>
          </div>

          <!-- Fila 2 de Filtros: Documento (4 opciones), Búsqueda y Botones Aplicar / Restablecer -->
          <div class="grid grid-cols-1 sm:grid-cols-12 gap-3.5 items-end pt-1">
            <!-- Documento (4 opciones independientes — Decisión 1.B) -->
            <div class="sm:col-span-3">
              <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Documento (DNI / RUC)</label>
              <select
                [ngModel]="filtroBorrador().documento"
                (ngModelChange)="actualizarCampoBorrador('documento', $event)"
                class="w-full rounded-xl border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500">
                <option value="TODOS">Todos</option>
                <option value="REGISTRADOS">Registrados</option>
                <option value="SIN_REGISTRAR">Sin registrar</option>
                <option value="POR_VALIDAR">Por validar</option>
              </select>
            </div>

            <!-- Búsqueda multicriterio -->
            <div class="sm:col-span-6">
              <label class="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">
                Búsqueda rápida (nombre, DNI, número de comprobante o puesto)
              </label>
              <div class="relative">
                <input
                  type="search"
                  placeholder="Ej: RIB-202610, REC-000, apellido, DNI o código de puesto..."
                  [ngModel]="filtroBorrador().busqueda"
                  (ngModelChange)="actualizarCampoBorrador('busqueda', $event)"
                  (keyup.enter)="aplicarFiltros()"
                  class="w-full rounded-xl border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-900 dark:text-white pl-9 pr-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-brand-500" />
                <svg class="w-4 h-4 text-gray-400 absolute left-3 top-2.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-4.35-4.35m0 0A7.5 7.5 0 103.5 10.5a7.5 7.5 0 0013.15 6.15z"/>
                </svg>
              </div>
            </div>

            <!-- Botones Aplicar y Restablecer -->
            <div class="sm:col-span-3 flex items-center justify-end gap-2">
              <button
                type="button"
                (click)="restablecerFiltros()"
                [disabled]="cargando()"
                class="px-3.5 py-2 rounded-xl border border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 text-xs sm:text-sm font-medium transition disabled:opacity-50">
                Restablecer
              </button>
              <button
                type="button"
                (click)="aplicarFiltros()"
                [disabled]="cargando() || rangoFechasInvalido()"
                class="flex-1 sm:flex-initial inline-flex items-center justify-center gap-1.5 px-4 py-2 rounded-xl bg-brand-600 hover:bg-brand-700 text-white text-xs sm:text-sm font-semibold shadow-xs transition disabled:opacity-50">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z"/>
                </svg>
                Aplicar
              </button>
            </div>
          </div>

          @if (rangoFechasInvalido()) {
            <p class="text-xs text-red-600 dark:text-red-400 font-medium">
              La fecha inicial ("Desde") no puede ser posterior a la fecha final ("Hasta").
            </p>
          }
        </section>

        <!-- ================================================================ -->
        <!-- SECCIÓN C: 5 INDICADORES DE CONTROL                              -->
        <!-- ================================================================ -->
        <section aria-label="Indicadores de control" class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-5 gap-4">
          <!-- KPI 1: Comprobantes únicos -->
          <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl p-4 shadow-sm flex flex-col justify-between">
            <div>
              <div class="flex items-center justify-between gap-2">
                <span class="text-xs font-semibold uppercase tracking-wider text-gray-500 dark:text-gray-400">
                  1. Comprobantes Únicos
                </span>
                <span class="p-1.5 rounded-lg bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-300">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                  </svg>
                </span>
              </div>
              <p class="mt-2 text-2xl font-bold text-gray-900 dark:text-white">
                {{ kpis().comprobantesUnicos }}
              </p>
            </div>
            <div class="mt-3 pt-2.5 border-t border-gray-100 dark:border-gray-700/70 flex flex-wrap items-center justify-between text-xs text-gray-500 dark:text-gray-400 gap-1">
              <span>Vigentes: <strong class="text-emerald-600 dark:text-emerald-400">{{ kpis().comprobantesVigentes }}</strong></span>
              @if (kpis().comprobantesAnulados > 0) {
                <span>Anulados: <strong class="text-red-600 dark:text-red-400">{{ kpis().comprobantesAnulados }}</strong></span>
              }
              <span>Líneas: <strong class="text-gray-700 dark:text-gray-300">{{ kpis().totalLineasConceptos }}</strong></span>
            </div>
          </div>

          <!-- KPI 2: Dinero nuevo ingresado a caja y banco -->
          <div class="bg-white dark:bg-gray-800 border border-emerald-200 dark:border-emerald-800/70 rounded-2xl p-4 shadow-sm flex flex-col justify-between">
            <div>
              <div class="flex items-center justify-between gap-2">
                <span class="text-xs font-semibold uppercase tracking-wider text-emerald-700 dark:text-emerald-400">
                  2. Dinero Nuevo (Caja + Banco)
                </span>
                <span class="p-1.5 rounded-lg bg-emerald-50 dark:bg-emerald-900/30 text-emerald-600 dark:text-emerald-400">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                  </svg>
                </span>
              </div>
              <p class="mt-2 text-2xl font-bold text-emerald-700 dark:text-emerald-400">
                {{ fmtSoles(kpis().dineroNuevoTotal) }}
              </p>
            </div>
            <div class="mt-3 pt-2.5 border-t border-gray-100 dark:border-gray-700/70 text-[11px] text-gray-500 dark:text-gray-400 space-y-0.5">
              <div class="flex justify-between">
                <span>Efectivo (incl. Tarjeta):</span>
                <strong class="text-gray-700 dark:text-gray-200">{{ fmtSoles(kpis().dineroNuevoEfectivo) }}</strong>
              </div>
              <div class="flex justify-between">
                <span>Banco / Transferencia / QR:</span>
                <strong class="text-gray-700 dark:text-gray-200">{{ fmtSoles(kpis().dineroNuevoBanco) }}</strong>
              </div>
            </div>
          </div>

          <!-- KPI 3: Saldo a favor utilizado -->
          <div class="bg-white dark:bg-gray-800 border border-indigo-200 dark:border-indigo-800/70 rounded-2xl p-4 shadow-sm flex flex-col justify-between">
            <div>
              <div class="flex items-center justify-between gap-2">
                <span class="text-xs font-semibold uppercase tracking-wider text-indigo-700 dark:text-indigo-400">
                  3. Saldo a Favor Utilizado
                </span>
                <span class="p-1.5 rounded-lg bg-indigo-50 dark:bg-indigo-900/30 text-indigo-600 dark:text-indigo-400">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
                  </svg>
                </span>
              </div>
              <p class="mt-2 text-2xl font-bold text-indigo-700 dark:text-indigo-400">
                {{ fmtSoles(kpis().saldoAFavorUtilizado) }}
              </p>
            </div>
            <div class="mt-3 pt-2.5 border-t border-gray-100 dark:border-gray-700/70 text-[11px] text-gray-500 dark:text-gray-400 space-y-0.5">
              <div class="flex justify-between">
                <span>Excedentes nuevos abonados:</span>
                <strong class="text-gray-700 dark:text-gray-200">{{ fmtSoles(kpis().excedenteGenerado) }}</strong>
              </div>
              <div class="text-[10px] text-gray-400 dark:text-gray-500">
                No se suma como nuevo ingreso de caja
              </div>
            </div>
          </div>

          <!-- KPI 4: Total aplicado a conceptos -->
          <div class="bg-white dark:bg-gray-800 border border-blue-200 dark:border-blue-800/70 rounded-2xl p-4 shadow-sm flex flex-col justify-between">
            <div>
              <div class="flex items-center justify-between gap-2">
                <span class="text-xs font-semibold uppercase tracking-wider text-blue-700 dark:text-blue-400">
                  4. Total Aplicado a Conceptos
                </span>
                <span class="p-1.5 rounded-lg bg-blue-50 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 17v-2m3 2v-4m3 4v-6m2 10H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                  </svg>
                </span>
              </div>
              <p class="mt-2 text-2xl font-bold text-blue-700 dark:text-blue-400">
                {{ fmtSoles(kpis().totalAplicadoConceptos) }}
              </p>
            </div>
            <div class="mt-3 pt-2.5 border-t border-gray-100 dark:border-gray-700/70 text-[11px] text-gray-500 dark:text-gray-400 space-y-0.5">
              <div class="flex justify-between">
                <span>Deudas + Caja Rápida:</span>
                <strong class="text-gray-700 dark:text-gray-200">{{ fmtSoles(kpis().totalAplicadoDeudasInternos) }}</strong>
              </div>
              <div class="flex justify-between">
                <span>Recaudación Tarjeta (Abono):</span>
                <strong class="text-gray-700 dark:text-gray-200">{{ fmtSoles(kpis().recaudacionTarjetaEfectivo) }}</strong>
              </div>
            </div>
          </div>

          <!-- KPI 5: Personas sin documento registrado -->
          <div class="bg-white dark:bg-gray-800 border border-amber-200 dark:border-amber-800/70 rounded-2xl p-4 shadow-sm flex flex-col justify-between">
            <div>
              <div class="flex items-center justify-between gap-2">
                <span class="text-xs font-semibold uppercase tracking-wider text-amber-700 dark:text-amber-400">
                  5. Personas sin Doc. Válido
                </span>
                <span class="p-1.5 rounded-lg bg-amber-50 dark:bg-amber-900/30 text-amber-600 dark:text-amber-400">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M10 6H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V8a2 2 0 00-2-2h-5m-4 0V5a2 2 0 114 0v1m-4 0a2 2 0 104 0m-5 8a2 2 0 100-4 2 2 0 000 4zm0 0c1.306 0 2.417.835 2.83 2M9 14a3.001 3.001 0 00-2.83 2M15 11h3m-3 4h2"/>
                  </svg>
                </span>
              </div>
              <p class="mt-2 text-2xl font-bold text-amber-700 dark:text-amber-400">
                {{ kpis().personasSinDocumentoTotal }}
              </p>
            </div>
            <div class="mt-3 pt-2.5 border-t border-gray-100 dark:border-gray-700/70 flex items-center justify-between text-xs text-gray-500 dark:text-gray-400">
              <span>Sin reg.: <strong class="text-amber-700 dark:text-amber-300">{{ kpis().personasSinRegistrarCount }}</strong></span>
              <span>Por validar: <strong class="text-amber-700 dark:text-amber-300">{{ kpis().personasPorValidarCount }}</strong></span>
              @if (kpis().personasSinDocumentoTotal > 0) {
                <button
                  type="button"
                  (click)="vistaActiva.set('conciliacion')"
                  class="text-brand-600 dark:text-brand-400 hover:underline font-medium">
                  Ver lista
                </button>
              }
            </div>
          </div>
        </section>

        <!-- ================================================================ -->
        <!-- SELECTOR DE VISTA (SECCIÓN D vs SECCIÓN E vs CONCILIACIÓN)       -->
        <!-- ================================================================ -->
        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl p-3.5 shadow-sm">
          <div class="inline-flex flex-wrap gap-1.5 bg-gray-100 dark:bg-gray-900 p-1 rounded-xl">
            <button
              type="button"
              (click)="vistaActiva.set('comprobantes')"
              [class]="vistaActiva() === 'comprobantes'
                ? 'px-3.5 py-2 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white text-xs sm:text-sm font-semibold shadow-xs'
                : 'px-3.5 py-2 rounded-lg text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white text-xs sm:text-sm font-medium'">
              Vista por Comprobante (Vertical)
            </button>
            <button
              type="button"
              (click)="vistaActiva.set('matriz')"
              [class]="vistaActiva() === 'matriz'
                ? 'px-3.5 py-2 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white text-xs sm:text-sm font-semibold shadow-xs'
                : 'px-3.5 py-2 rounded-lg text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white text-xs sm:text-sm font-medium'">
              Matriz por Conceptos (Estilo Septiembre)
            </button>
            <button
              type="button"
              (click)="vistaActiva.set('conciliacion')"
              [class]="vistaActiva() === 'conciliacion'
                ? 'px-3.5 py-2 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white text-xs sm:text-sm font-semibold shadow-xs'
                : 'px-3.5 py-2 rounded-lg text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white text-xs sm:text-sm font-medium'">
              Conciliación y Documentos ({{ documentosPendientes().length }})
            </button>
          </div>

          @if (vistaActiva() === 'comprobantes' && comprobantesFiltrados().length > 0) {
            <div class="flex flex-wrap items-center gap-2 text-xs">
              <button
                type="button"
                (click)="expandirPaginaActual()"
                class="px-2.5 py-1.5 rounded-lg border border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 font-medium">
                Expandir página
              </button>
              <button
                type="button"
                (click)="contraerTodos()"
                class="px-2.5 py-1.5 rounded-lg border border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 font-medium">
                Contraer todo
              </button>
              <label class="flex items-center gap-1.5 text-gray-500 dark:text-gray-400 ml-1">
                <span>Por página:</span>
                <select
                  [ngModel]="tamanoPagina()"
                  (ngModelChange)="cambiarTamanoPagina($event)"
                  class="rounded-lg border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-900 text-gray-800 dark:text-gray-200 px-2 py-1 text-xs">
                  <option [ngValue]="25">25</option>
                  <option [ngValue]="50">50</option>
                  <option [ngValue]="100">100</option>
                </select>
              </label>
            </div>
          }
        </div>

        <!-- Estado de carga -->
        @if (cargando()) {
          <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl p-12 text-center shadow-sm">
            <div class="inline-flex items-center gap-3 text-gray-600 dark:text-gray-300 font-medium">
              <span class="h-6 w-6 rounded-full border-2 border-brand-600 border-t-transparent animate-spin"></span>
              <span>Consultando comprobantes, relaciones de padrón y abonos acumulados...</span>
            </div>
          </div>
        } @else if (comprobantesFiltrados().length === 0) {
          <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl p-12 text-center shadow-sm space-y-2">
            <p class="text-base font-semibold text-gray-700 dark:text-gray-200">
              No se encontraron comprobantes con los filtros seleccionados.
            </p>
            <p class="text-xs text-gray-500 dark:text-gray-400">
              Pruebe cambiar el período o pulse "Restablecer" para limpiar los criterios activos.
            </p>
          </div>
        } @else {

          <!-- ============================================================== -->
          <!-- SECCIÓN D: VISTA VERTICAL POR DÍA Y POR COMPROBANTE            -->
          <!-- ============================================================== -->
          @if (vistaActiva() === 'comprobantes') {
            <div class="space-y-5">
              @for (grupoDia of gruposDiariosPaginados(); track grupoDia.fechaLima) {
                <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl overflow-hidden shadow-sm">
                  <!-- Cabecera de Día con Subtotales Diarios -->
                  <div class="bg-gray-50 dark:bg-gray-900/70 px-4 sm:px-5 py-3 border-b border-gray-200 dark:border-gray-700 flex flex-col lg:flex-row lg:items-center lg:justify-between gap-2">
                    <div class="flex flex-wrap items-center gap-2.5">
                      <span class="inline-flex items-center px-2.5 py-1 rounded-lg text-xs font-bold bg-brand-600 text-white">
                        {{ grupoDia.fechaLima }}
                      </span>
                      <h3 class="text-sm font-semibold text-gray-900 dark:text-white capitalize">
                        {{ grupoDia.fechaFormateada }}
                      </h3>
                      <span class="text-xs text-gray-500 dark:text-gray-400">
                        ({{ grupoDia.cantidadComprobantes }} comprobante{{ grupoDia.cantidadComprobantes === 1 ? '' : 's' }} en el día)
                      </span>
                    </div>

                    <!-- Subtotales del Día -->
                    <div class="flex flex-wrap items-center gap-3 text-xs">
                      <span class="px-2.5 py-1 rounded-lg bg-emerald-50 dark:bg-emerald-900/25 text-emerald-800 dark:text-emerald-300 border border-emerald-200 dark:border-emerald-800/60">
                        Dinero Nuevo Día: <strong>{{ fmtSoles(grupoDia.subtotalDineroNuevo) }}</strong>
                        <span class="text-[11px] opacity-80">
                          (Ef: {{ fmtSoles(grupoDia.subtotalEfectivo) }} | Bco: {{ fmtSoles(grupoDia.subtotalBanco) }})
                        </span>
                      </span>
                      @if (grupoDia.subtotalSaldoAFavorUtilizado > 0) {
                        <span class="px-2.5 py-1 rounded-lg bg-indigo-50 dark:bg-indigo-900/25 text-indigo-800 dark:text-indigo-300 border border-indigo-200 dark:border-indigo-800/60">
                          Saldo a Favor Día: <strong>{{ fmtSoles(grupoDia.subtotalSaldoAFavorUtilizado) }}</strong>
                        </span>
                      }
                      <span class="px-2.5 py-1 rounded-lg bg-blue-50 dark:bg-blue-900/25 text-blue-800 dark:text-blue-300 border border-blue-200 dark:border-blue-800/60">
                        Aplicado Conceptos Día: <strong>{{ fmtSoles(grupoDia.subtotalAplicadoConceptos) }}</strong>
                      </span>
                    </div>
                  </div>

                  <!-- Lista de Comprobantes del Día -->
                  <div class="divide-y divide-gray-100 dark:divide-gray-700/70">
                    @for (comp of grupoDia.comprobantes; track comp.uid) {
                      <div [class]="comp.estado === 'ANULADO' ? 'bg-red-50/30 dark:bg-red-950/10' : ''">
                        <!-- Cabecera del Comprobante -->
                        <div
                          (click)="toggleComprobante(comp.uid)"
                          class="px-4 sm:px-5 py-3.5 hover:bg-gray-50/80 dark:hover:bg-white/[0.02] transition cursor-pointer flex flex-col xl:flex-row xl:items-center xl:justify-between gap-3">

                          <!-- Izquierda: Número, Hora, Estado, Tipo Persona, Nombre y Documento -->
                          <div class="flex flex-wrap items-start sm:items-center gap-2.5 min-w-0">
                            <button
                              type="button"
                              class="mt-0.5 sm:mt-0 p-1 rounded-lg text-gray-400 hover:text-gray-700 dark:hover:text-gray-200 transition"
                              [attr.aria-expanded]="estaExpandido(comp.uid)">
                              <svg
                                class="w-4 h-4 transition-transform duration-200"
                                [class.rotate-90]="estaExpandido(comp.uid)"
                                fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/>
                              </svg>
                            </button>

                            <!-- Código de Comprobante y Hora -->
                            <div class="flex items-center gap-2">
                              <span class="font-mono text-xs sm:text-sm font-bold text-gray-900 dark:text-white"
                                [class.line-through]="comp.estado === 'ANULADO'">
                                {{ comp.numeroComprobante }}
                              </span>
                              <span class="text-xs text-gray-500 dark:text-gray-400 font-mono">
                                {{ comp.horaLima }}
                              </span>
                            </div>

                            <!-- Badge Estado -->
                            @if (comp.estado === 'ANULADO') {
                              <span class="px-2 py-0.5 rounded-full text-[11px] font-bold bg-red-100 text-red-700 dark:bg-red-900/40 dark:text-red-300">
                                ANULADO
                              </span>
                            } @else {
                              <span class="px-2 py-0.5 rounded-full text-[11px] font-medium bg-emerald-50 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-300">
                                VIGENTE
                              </span>
                            }

                            <!-- Badge Tipo de Persona / Origen -->
                            <span [class]="badgeOrigenClass(comp.origen)">
                              {{ comp.tipoPersona }}
                            </span>

                            <!-- Nombre completo de Persona Registrada + Titular si difiere (Ajuste 2.2) -->
                            <div class="min-w-0">
                              <div class="flex flex-wrap items-center gap-1.5">
                                <span class="text-sm font-semibold text-gray-900 dark:text-white truncate">
                                  {{ comp.personaRegistradaNombre }}
                                </span>
                                @if (comp.esPersonaDistintaAlTitular && comp.titularPuestoNombre) {
                                  <span class="text-[11px] px-2 py-0.5 rounded-md bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300">
                                    Titular puesto: {{ comp.titularPuestoNombre }} ({{ comp.titularPuestoDocumento }})
                                  </span>
                                }
                              </div>
                            </div>

                            <!-- Badge de Documento (DNI / RUC / SIN REGISTRAR / POR VALIDAR / NO APLICA) -->
                            <span [class]="badgeDocumentoClass(comp.documento.estado)">
                              @if (comp.documento.estado === 'REGISTRADO') {
                                {{ comp.documento.tipoDocumento }}: {{ comp.documento.numeroMostrar }}
                              } @else if (comp.documento.estado === 'POR VALIDAR') {
                                POR VALIDAR: {{ comp.documento.numeroMostrar }}
                              } @else {
                                {{ comp.documento.estado }}
                              }
                            </span>

                            <!-- Puesto / Almacén -->
                            <span class="text-xs px-2 py-0.5 rounded-md bg-gray-100 dark:bg-gray-700/80 text-gray-700 dark:text-gray-300 font-medium">
                              {{ comp.puestoMostrar }}
                            </span>
                          </div>

                          <!-- Derecha: Cajero, Canal y Resumen Financiero de Pie -->
                          <div class="flex flex-wrap items-center justify-between xl:justify-end gap-3 text-xs pl-7 xl:pl-0">
                            <div class="flex items-center gap-2 text-gray-500 dark:text-gray-400">
                              <span [class]="badgeCanalClass(comp.canal)">
                                {{ comp.canalEtiqueta }}
                              </span>
                              <span class="hidden sm:inline">· Cajero: <strong class="text-gray-700 dark:text-gray-300">{{ comp.cajero }}</strong></span>
                              <span class="text-[11px] text-gray-400">({{ comp.lineas.length }} {{ comp.lineas.length === 1 ? 'línea' : 'líneas' }})</span>
                            </div>

                            <div class="flex flex-wrap items-center gap-2.5 text-right">
                              <div class="px-2.5 py-1 rounded-lg bg-emerald-50/70 dark:bg-emerald-900/20 border border-emerald-200/70 dark:border-emerald-800/50">
                                <span class="text-[10px] uppercase text-gray-500 dark:text-gray-400 block">Dinero Nuevo</span>
                                <span class="font-bold text-emerald-700 dark:text-emerald-400">{{ fmtSoles(comp.dineroNuevoCajaBanco) }}</span>
                              </div>
                              @if (comp.saldoAFavorUtilizado > 0) {
                                <div class="px-2.5 py-1 rounded-lg bg-indigo-50/70 dark:bg-indigo-900/20 border border-indigo-200/70 dark:border-indigo-800/50">
                                  <span class="text-[10px] uppercase text-gray-500 dark:text-gray-400 block">Saldo a Favor</span>
                                  <span class="font-bold text-indigo-700 dark:text-indigo-400">{{ fmtSoles(comp.saldoAFavorUtilizado) }}</span>
                                </div>
                              }
                              <div class="px-2.5 py-1 rounded-lg bg-blue-50/70 dark:bg-blue-900/20 border border-blue-200/70 dark:border-blue-800/50">
                                <span class="text-[10px] uppercase text-gray-500 dark:text-gray-400 block">Total Conceptos</span>
                                <span class="font-bold text-blue-700 dark:text-blue-400">{{ fmtSoles(comp.totalAplicadoConceptos) }}</span>
                              </div>
                            </div>
                          </div>
                        </div>

                        <!-- Contenido Desplegable del Comprobante (Líneas por Concepto y Período + Pie) -->
                        @if (estaExpandido(comp.uid)) {
                          <div class="px-4 sm:px-8 pb-4 pt-1 bg-gray-50/60 dark:bg-gray-900/40 border-t border-gray-100 dark:border-gray-700/60 space-y-3">
                            @if (comp.estado === 'ANULADO' && comp.motivoAnulacion) {
                              <div class="p-2.5 rounded-lg bg-red-100/70 dark:bg-red-900/30 text-red-800 dark:text-red-200 text-xs">
                                <strong>Motivo de anulación:</strong> {{ comp.motivoAnulacion }}
                              </div>
                            }

                            <div class="overflow-x-auto rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800">
                              <table class="w-full text-xs">
                                <thead class="bg-gray-50 dark:bg-gray-900/60 text-gray-600 dark:text-gray-400 uppercase tracking-wider">
                                  <tr>
                                    <th class="px-3 py-2 text-left font-semibold">Línea</th>
                                    <th class="px-3 py-2 text-left font-semibold">Concepto Contable</th>
                                    <th class="px-3 py-2 text-left font-semibold">Período Deuda</th>
                                    <th class="px-3 py-2 text-left font-semibold">Puesto / Almacén</th>
                                    <th class="px-3 py-2 text-right font-semibold">Cargo Original</th>
                                    <th class="px-3 py-2 text-right font-semibold">Abonado Previo</th>
                                    <th class="px-3 py-2 text-right font-semibold">Importe Aplicado</th>
                                    <th class="px-3 py-2 text-left font-semibold">Estado Obligación / Tipo Abono</th>
                                  </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-100 dark:divide-gray-700/60">
                                  @for (linea of comp.lineas; track linea.id) {
                                    <tr class="hover:bg-gray-50/70 dark:hover:bg-white/[0.01]">
                                      <td class="px-3 py-2 font-mono text-gray-500">{{ linea.numeroLinea }}/{{ linea.totalLineasComprobante }}</td>
                                      <td class="px-3 py-2 font-semibold text-gray-900 dark:text-white">{{ linea.concepto }}</td>
                                      <td class="px-3 py-2 font-mono text-gray-700 dark:text-gray-300">{{ linea.periodo }}</td>
                                      <td class="px-3 py-2 text-gray-700 dark:text-gray-300">{{ linea.puestoLinea }}</td>
                                      <td class="px-3 py-2 text-right font-mono text-gray-600 dark:text-gray-400">
                                        {{ linea.cargoOriginalDeuda !== null ? fmtSoles(linea.cargoOriginalDeuda) : '—' }}
                                      </td>
                                      <td class="px-3 py-2 text-right font-mono text-gray-600 dark:text-gray-400">
                                        {{ linea.abonadoPrevioDeuda !== null ? fmtSoles(linea.abonadoPrevioDeuda) : '—' }}
                                      </td>
                                      <td class="px-3 py-2 text-right font-mono font-bold text-gray-900 dark:text-white">
                                        {{ fmtSoles(linea.importeAplicado) }}
                                      </td>
                                      <td class="px-3 py-2">
                                        <span [class]="badgeTipoAbonoClass(linea.tipoAbonoDeuda)">
                                          {{ linea.etiquetaEstadoDeuda }}
                                        </span>
                                      </td>
                                    </tr>
                                  }
                                </tbody>
                              </table>
                            </div>

                            <!-- Pie del Comprobante diferenciando bases financieras -->
                            <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2 pt-1 text-xs text-gray-600 dark:text-gray-300">
                              <div class="flex flex-wrap items-center gap-3">
                                <span>
                                  <strong>Cuenta registrada:</strong> {{ comp.personaRegistradaNombre }}
                                  <span class="text-gray-400">(La BD registra el titular de la cuenta/operación, no el portador físico en ventanilla)</span>
                                </span>
                                @if (comp.referenciaExterna) {
                                  <span>· <strong>Ref/Obs:</strong> {{ comp.referenciaExterna }}</span>
                                }
                              </div>
                              <div class="flex flex-wrap items-center gap-4 font-medium">
                                <span>Dinero nuevo recibido: <strong class="text-emerald-700 dark:text-emerald-400">{{ fmtSoles(comp.dineroNuevoCajaBanco) }}</strong></span>
                                <span>Saldo a favor aplicado: <strong class="text-indigo-700 dark:text-indigo-400">{{ fmtSoles(comp.saldoAFavorUtilizado) }}</strong></span>
                                @if (comp.excedenteGenerado > 0) {
                                  <span>Excedente abonado a saldo: <strong class="text-amber-700 dark:text-amber-400">{{ fmtSoles(comp.excedenteGenerado) }}</strong></span>
                                }
                                <span>Total imputado a conceptos: <strong class="text-blue-700 dark:text-blue-400">{{ fmtSoles(comp.totalAplicadoConceptos) }}</strong></span>
                              </div>
                            </div>
                          </div>
                        }
                      </div>
                    }
                  </div>
                </div>
              }

              <!-- Paginación por Comprobante -->
              <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl px-5 py-3.5 shadow-sm text-xs text-gray-600 dark:text-gray-400">
                <div>
                  Mostrando comprobantes <strong>{{ rangoPaginacion().inicio }}</strong> a <strong>{{ rangoPaginacion().fin }}</strong>
                  de <strong>{{ comprobantesFiltrados().length }}</strong> filtrados
                  <span class="text-gray-400">(La exportación Excel incluye los {{ comprobantesFiltrados().length }} comprobantes completos)</span>
                </div>
                <div class="flex items-center gap-1.5">
                  <button
                    type="button"
                    (click)="irAPagina(1)"
                    [disabled]="paginaActual() <= 1"
                    class="px-2.5 py-1.5 rounded-lg border border-gray-300 dark:border-gray-600 disabled:opacity-40 hover:bg-gray-50 dark:hover:bg-gray-700">
                    « Primera
                  </button>
                  <button
                    type="button"
                    (click)="irAPagina(paginaActual() - 1)"
                    [disabled]="paginaActual() <= 1"
                    class="px-2.5 py-1.5 rounded-lg border border-gray-300 dark:border-gray-600 disabled:opacity-40 hover:bg-gray-50 dark:hover:bg-gray-700">
                    ‹ Anterior
                  </button>
                  <span class="px-3 py-1.5 font-semibold text-gray-800 dark:text-gray-200">
                    Página {{ paginaActual() }} de {{ totalPaginas() }}
                  </span>
                  <button
                    type="button"
                    (click)="irAPagina(paginaActual() + 1)"
                    [disabled]="paginaActual() >= totalPaginas()"
                    class="px-2.5 py-1.5 rounded-lg border border-gray-300 dark:border-gray-600 disabled:opacity-40 hover:bg-gray-50 dark:hover:bg-gray-700">
                    Siguiente ›
                  </button>
                  <button
                    type="button"
                    (click)="irAPagina(totalPaginas())"
                    [disabled]="paginaActual() >= totalPaginas()"
                    class="px-2.5 py-1.5 rounded-lg border border-gray-300 dark:border-gray-600 disabled:opacity-40 hover:bg-gray-50 dark:hover:bg-gray-700">
                    Última »
                  </button>
                </div>
              </div>
            </div>
          }

          <!-- ============================================================== -->
          <!-- SECCIÓN E: VISTA ALTERNATIVA — MATRIZ POR CONCEPTOS            -->
          <!-- ============================================================== -->
          @if (vistaActiva() === 'matriz') {
            <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl shadow-sm overflow-hidden">
              <div class="px-5 py-4 border-b border-gray-200 dark:border-gray-700 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-2">
                <div>
                  <h3 class="text-base font-bold text-gray-900 dark:text-white">
                    Matriz por Conceptos (Inspirada en Hojas de Arqueo de Septiembre)
                  </h3>
                  <p class="text-xs text-gray-500 dark:text-gray-400">
                    Cada fila representa un comprobante único y las columnas desglosan los conceptos realmente registrados en el período.
                  </p>
                </div>
                <span class="text-xs font-medium text-gray-500 dark:text-gray-400">
                  {{ matrizConceptos().filas.length }} comprobantes · {{ matrizConceptos().columnasConceptos.length }} columnas de concepto
                </span>
              </div>

              <div class="overflow-x-auto max-h-[650px]">
                <table class="w-full text-xs border-collapse">
                  <thead class="bg-gray-50 dark:bg-gray-900 text-gray-600 dark:text-gray-400 uppercase tracking-wider sticky top-0 z-10 shadow-xs">
                    <tr>
                      <th class="px-3 py-2.5 text-left font-semibold border-b border-gray-200 dark:border-gray-700">Fecha</th>
                      <th class="px-3 py-2.5 text-left font-semibold border-b border-gray-200 dark:border-gray-700">Comprobante</th>
                      <th class="px-3 py-2.5 text-left font-semibold border-b border-gray-200 dark:border-gray-700">Origen</th>
                      <th class="px-3 py-2.5 text-left font-semibold border-b border-gray-200 dark:border-gray-700">Persona Registrada</th>
                      <th class="px-3 py-2.5 text-left font-semibold border-b border-gray-200 dark:border-gray-700">Documento</th>
                      <th class="px-3 py-2.5 text-left font-semibold border-b border-gray-200 dark:border-gray-700">Puesto</th>
                      <th class="px-3 py-2.5 text-left font-semibold border-b border-gray-200 dark:border-gray-700">Período(s)</th>
                      @for (col of matrizConceptos().columnasConceptos; track col) {
                        <th class="px-3 py-2.5 text-right font-semibold border-b border-gray-200 dark:border-gray-700 bg-blue-50/40 dark:bg-blue-950/20">
                          {{ col }}
                        </th>
                      }
                      <th class="px-3 py-2.5 text-right font-bold border-b border-gray-200 dark:border-gray-700 bg-blue-50 dark:bg-blue-900/30 text-blue-800 dark:text-blue-300">
                        Total Conceptos
                      </th>
                      <th class="px-3 py-2.5 text-right font-semibold border-b border-gray-200 dark:border-gray-700 bg-indigo-50/50 dark:bg-indigo-900/20 text-indigo-700 dark:text-indigo-300">
                        (-) Saldo a Favor
                      </th>
                      <th class="px-3 py-2.5 text-right font-bold border-b border-gray-200 dark:border-gray-700 bg-emerald-50 dark:bg-emerald-900/30 text-emerald-800 dark:text-emerald-300">
                        (=) Dinero Nuevo
                      </th>
                      <th class="px-3 py-2.5 text-left font-semibold border-b border-gray-200 dark:border-gray-700">Canal</th>
                    </tr>
                  </thead>
                  <tbody class="divide-y divide-gray-100 dark:divide-gray-700/60">
                    @for (fila of filasMatrizPaginadas(); track fila.uid) {
                      <tr class="hover:bg-gray-50 dark:hover:bg-white/[0.02]" [class.opacity-60]="fila.estado === 'ANULADO'">
                        <td class="px-3 py-2 font-mono whitespace-nowrap">{{ fila.fechaLima }}</td>
                        <td class="px-3 py-2 font-mono font-semibold whitespace-nowrap">{{ fila.numeroComprobante }}</td>
                        <td class="px-3 py-2 whitespace-nowrap">{{ fila.origen }}</td>
                        <td class="px-3 py-2 font-medium text-gray-900 dark:text-white truncate max-w-[220px]">{{ fila.personaRegistradaNombre }}</td>
                        <td class="px-3 py-2 font-mono whitespace-nowrap">{{ fila.numeroDocumento }}</td>
                        <td class="px-3 py-2 whitespace-nowrap">{{ fila.puestoMostrar }}</td>
                        <td class="px-3 py-2 font-mono whitespace-nowrap">{{ fila.periodosResumen }}</td>
                        @for (col of matrizConceptos().columnasConceptos; track col) {
                          <td class="px-3 py-2 text-right font-mono">
                            {{ fila.montosPorConcepto[col] ? fmtSoles(fila.montosPorConcepto[col]) : '—' }}
                          </td>
                        }
                        <td class="px-3 py-2 text-right font-mono font-bold text-blue-700 dark:text-blue-400 bg-blue-50/20 dark:bg-blue-950/10">
                          {{ fmtSoles(fila.totalAplicadoConceptos) }}
                        </td>
                        <td class="px-3 py-2 text-right font-mono text-indigo-700 dark:text-indigo-400">
                          {{ fila.saldoAFavorUtilizado > 0 ? fmtSoles(fila.saldoAFavorUtilizado) : '—' }}
                        </td>
                        <td class="px-3 py-2 text-right font-mono font-bold text-emerald-700 dark:text-emerald-400 bg-emerald-50/20 dark:bg-emerald-950/10">
                          {{ fmtSoles(fila.dineroNuevoCajaBanco) }}
                        </td>
                        <td class="px-3 py-2 whitespace-nowrap">{{ fila.canalEtiqueta }}</td>
                      </tr>
                    }
                  </tbody>
                  <tfoot class="bg-gray-100 dark:bg-gray-900 font-bold text-gray-900 dark:text-white border-t-2 border-gray-300 dark:border-gray-600">
                    <tr>
                      <td colspan="7" class="px-3 py-3 text-right uppercase">Totales del Universo Filtrado (Vigentes):</td>
                      @for (col of matrizConceptos().columnasConceptos; track col) {
                        <td class="px-3 py-3 text-right font-mono">
                          {{ fmtSoles(matrizConceptos().totalesPorConcepto[col] || 0) }}
                        </td>
                      }
                      <td class="px-3 py-3 text-right font-mono text-blue-700 dark:text-blue-400">
                        {{ fmtSoles(kpis().totalAplicadoConceptos) }}
                      </td>
                      <td class="px-3 py-3 text-right font-mono text-indigo-700 dark:text-indigo-400">
                        {{ fmtSoles(kpis().saldoAFavorUtilizado) }}
                      </td>
                      <td class="px-3 py-3 text-right font-mono text-emerald-700 dark:text-emerald-400">
                        {{ fmtSoles(kpis().dineroNuevoTotal) }}
                      </td>
                      <td></td>
                    </tr>
                  </tfoot>
                </table>
              </div>
            </div>
          }

          <!-- ============================================================== -->
          <!-- VISTA DE CONCILIACIÓN (07) Y DOCUMENTOS PENDIENTES (08)        -->
          <!-- ============================================================== -->
          @if (vistaActiva() === 'conciliacion') {
            <div class="grid grid-cols-1 lg:grid-cols-12 gap-6">
              <!-- Cuadro de Conciliación Financiera (Hoja 07) -->
              <div class="lg:col-span-6 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl p-5 shadow-sm space-y-4">
                <div>
                  <h3 class="text-base font-bold text-gray-900 dark:text-white">
                    Conciliación Financiera al Centavo (Vista Previa Hoja 07)
                  </h3>
                  <p class="text-xs text-gray-500 dark:text-gray-400">
                    Verificación matemática entre Dinero Nuevo, Saldo a Favor, Hojas Clasificadas (02..06) y Central de Reportes.
                  </p>
                </div>

                <div class="overflow-x-auto rounded-xl border border-gray-200 dark:border-gray-700">
                  <table class="w-full text-xs">
                    <thead class="bg-gray-50 dark:bg-gray-900/60 text-gray-600 dark:text-gray-400 uppercase">
                      <tr>
                        <th class="px-3 py-2 text-left font-semibold">Rubro de Conciliación</th>
                        <th class="px-3 py-2 text-right font-semibold">Reporte Contable</th>
                        <th class="px-3 py-2 text-right font-semibold">Central Reportes</th>
                        <th class="px-3 py-2 text-right font-semibold">Diferencia</th>
                      </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                      <tr>
                        <td class="px-3 py-2">02_SOCIOS_OFICINA (Efectivo + Tarjeta)</td>
                        <td class="px-3 py-2 text-right font-mono font-semibold">{{ fmtSoles(conciliacion().hoja02SociosOficina) }}</td>
                        <td class="px-3 py-2 text-right text-gray-400">—</td>
                        <td class="px-3 py-2 text-right text-gray-400">—</td>
                      </tr>
                      <tr>
                        <td class="px-3 py-2">03_SOCIOS_BANCO (Transferencia / QR)</td>
                        <td class="px-3 py-2 text-right font-mono font-semibold">{{ fmtSoles(conciliacion().hoja03SociosBanco) }}</td>
                        <td class="px-3 py-2 text-right text-gray-400">—</td>
                        <td class="px-3 py-2 text-right text-gray-400">—</td>
                      </tr>
                      <tr>
                        <td class="px-3 py-2">04_INQUILINOS_OFICINA (Efectivo)</td>
                        <td class="px-3 py-2 text-right font-mono font-semibold">{{ fmtSoles(conciliacion().hoja04InquilinosOficina) }}</td>
                        <td class="px-3 py-2 text-right text-gray-400">—</td>
                        <td class="px-3 py-2 text-right text-gray-400">—</td>
                      </tr>
                      <tr>
                        <td class="px-3 py-2">05_INQUILINOS_BANCO (Transferencia / QR)</td>
                        <td class="px-3 py-2 text-right font-mono font-semibold">{{ fmtSoles(conciliacion().hoja05InquilinosBanco) }}</td>
                        <td class="px-3 py-2 text-right text-gray-400">—</td>
                        <td class="px-3 py-2 text-right text-gray-400">—</td>
                      </tr>
                      <tr>
                        <td class="px-3 py-2">06_OTROS_INGRESOS (Caja Rápida)</td>
                        <td class="px-3 py-2 text-right font-mono font-semibold">{{ fmtSoles(conciliacion().hoja06OtrosIngresos) }}</td>
                        <td class="px-3 py-2 text-right text-gray-400">—</td>
                        <td class="px-3 py-2 text-right text-gray-400">—</td>
                      </tr>
                      <tr class="bg-emerald-50/50 dark:bg-emerald-900/20 font-bold">
                        <td class="px-3 py-2">Total Dinero Nuevo Efectivo</td>
                        <td class="px-3 py-2 text-right font-mono">{{ fmtSoles(conciliacion().totalDineroNuevoEfectivo) }}</td>
                        <td class="px-3 py-2 text-right font-mono">{{ conciliacion().centralEfectivo !== null ? fmtSoles(conciliacion().centralEfectivo!) : '—' }}</td>
                        <td class="px-3 py-2 text-right font-mono">{{ conciliacion().diferenciaEfectivoVsCentral !== null ? fmtSoles(conciliacion().diferenciaEfectivoVsCentral!) : '—' }}</td>
                      </tr>
                      <tr class="bg-emerald-50/50 dark:bg-emerald-900/20 font-bold">
                        <td class="px-3 py-2">Total Dinero Nuevo Banco / QR</td>
                        <td class="px-3 py-2 text-right font-mono">{{ fmtSoles(conciliacion().totalDineroNuevoBanco) }}</td>
                        <td class="px-3 py-2 text-right font-mono">{{ conciliacion().centralTransferencia !== null ? fmtSoles(conciliacion().centralTransferencia!) : '—' }}</td>
                        <td class="px-3 py-2 text-right font-mono">{{ conciliacion().diferenciaBancoVsCentral !== null ? fmtSoles(conciliacion().diferenciaBancoVsCentral!) : '—' }}</td>
                      </tr>
                      <tr class="bg-emerald-100/70 dark:bg-emerald-900/40 font-bold text-emerald-900 dark:text-emerald-200">
                        <td class="px-3 py-2.5">TOTAL DINERO NUEVO (CAJA + BANCO)</td>
                        <td class="px-3 py-2.5 text-right font-mono">{{ fmtSoles(conciliacion().totalDineroNuevoCajaBanco) }}</td>
                        <td class="px-3 py-2.5 text-right font-mono">{{ conciliacion().centralTotalIngresos !== null ? fmtSoles(conciliacion().centralTotalIngresos!) : '—' }}</td>
                        <td class="px-3 py-2.5 text-right font-mono">{{ conciliacion().diferenciaTotalVsCentral !== null ? fmtSoles(conciliacion().diferenciaTotalVsCentral!) : '—' }}</td>
                      </tr>
                      <tr>
                        <td class="px-3 py-2">(+) Saldo a Favor Utilizado</td>
                        <td class="px-3 py-2 text-right font-mono text-indigo-700 dark:text-indigo-400 font-semibold">{{ fmtSoles(conciliacion().saldoAFavorUtilizado) }}</td>
                        <td class="px-3 py-2 text-right text-gray-400">—</td>
                        <td class="px-3 py-2 text-right text-gray-400">—</td>
                      </tr>
                      <tr>
                        <td class="px-3 py-2">(-) Excedentes Generados a Saldo a Favor</td>
                        <td class="px-3 py-2 text-right font-mono text-amber-700 dark:text-amber-400 font-semibold">{{ fmtSoles(conciliacion().excedenteGenerado) }}</td>
                        <td class="px-3 py-2 text-right text-gray-400">—</td>
                        <td class="px-3 py-2 text-right text-gray-400">—</td>
                      </tr>
                      <tr class="bg-blue-50/70 dark:bg-blue-900/30 font-bold text-blue-900 dark:text-blue-200">
                        <td class="px-3 py-2.5">(=) TOTAL APLICADO A CONCEPTOS (01_DETALLE)</td>
                        <td class="px-3 py-2.5 text-right font-mono">{{ fmtSoles(conciliacion().totalAplicadoConRecaudacionTarjeta) }}</td>
                        <td class="px-3 py-2.5 text-right font-mono">{{ conciliacion().centralTotalConceptos !== null ? fmtSoles(conciliacion().centralTotalConceptos!) : '—' }}</td>
                        <td class="px-3 py-2.5 text-right font-mono">{{ conciliacion().diferenciaConceptosVsCentral !== null ? fmtSoles(conciliacion().diferenciaConceptosVsCentral!) : '—' }}</td>
                      </tr>
                    </tbody>
                  </table>
                </div>

                <div class="space-y-1.5 text-xs text-gray-600 dark:text-gray-400 bg-gray-50 dark:bg-gray-900/50 p-3.5 rounded-xl">
                  @for (nota of conciliacion().notasConciliacion; track nota) {
                    <p>• {{ nota }}</p>
                  }
                </div>
              </div>

              <!-- Documentos Pendientes de Completar o Validar (Hoja 08) -->
              <div class="lg:col-span-6 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl p-5 shadow-sm space-y-4">
                <div>
                  <h3 class="text-base font-bold text-gray-900 dark:text-white">
                    Personas con Documento Pendiente o Por Validar (Hoja 08)
                  </h3>
                  <p class="text-xs text-gray-500 dark:text-gray-400">
                    Personas únicas con operaciones en el período que requieren registrar DNI real o validar anomalía en el Padrón.
                  </p>
                </div>

                @if (documentosPendientes().length === 0) {
                  <div class="p-8 text-center text-gray-500 dark:text-gray-400 text-xs">
                    Todas las personas del conjunto filtrado cuentan con documento válidamente registrado.
                  </div>
                } @else {
                  <div class="overflow-x-auto rounded-xl border border-gray-200 dark:border-gray-700">
                    <table class="w-full text-xs">
                      <thead class="bg-gray-50 dark:bg-gray-900/60 text-gray-600 dark:text-gray-400 uppercase">
                        <tr>
                          <th class="px-3 py-2 text-left font-semibold">Tipo</th>
                          <th class="px-3 py-2 text-left font-semibold">Persona Registrada</th>
                          <th class="px-3 py-2 text-left font-semibold">Estado</th>
                          <th class="px-3 py-2 text-left font-semibold">Dato Original BD</th>
                          <th class="px-3 py-2 text-left font-semibold">Puesto(s)</th>
                          <th class="px-3 py-2 text-right font-semibold">Comprobantes</th>
                        </tr>
                      </thead>
                      <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                        @for (doc of documentosPendientes(); track doc.personaKey) {
                          <tr class="hover:bg-gray-50 dark:hover:bg-white/[0.02]">
                            <td class="px-3 py-2 font-medium">{{ doc.tipoPersona }}</td>
                            <td class="px-3 py-2 font-semibold text-gray-900 dark:text-white">{{ doc.nombreCompleto }}</td>
                            <td class="px-3 py-2">
                              <span [class]="badgeDocumentoClass(doc.estadoDocumento)">
                                {{ doc.estadoDocumento }}
                              </span>
                            </td>
                            <td class="px-3 py-2 font-mono text-gray-600 dark:text-gray-400">{{ doc.valorOriginalBd }}</td>
                            <td class="px-3 py-2">{{ doc.puestosRelacionados }}</td>
                            <td class="px-3 py-2 text-right font-mono">{{ doc.cantidadComprobantesPeriodo }}</td>
                          </tr>
                        }
                      </tbody>
                    </table>
                  </div>
                }
              </div>
            </div>
          }
        }
      }
    </div>
  `,
})
export class ReporteContableComponent implements OnInit {
  private readonly auth = inject(AuthService);
  private readonly contableSvc = inject(ReporteContableService);
  private readonly excelSvc = inject(ReporteContableExcelService);

  readonly mesesCatalogo = MESES_CATALOGO;
  readonly aniosDisponibles = ANIOS_DISPONIBLES;

  // Estado de carga y errores
  readonly cargando = signal(false);
  readonly exportando = signal(false);
  readonly error = signal<string | null>(null);
  readonly mensajeExportacion = signal<string | null>(null);

  // Permisos
  readonly tienePermiso = computed(() => this.contableSvc.tienePermisoContable());
  readonly rolActual = computed(() => this.auth.perfil()?.rol ?? 'Sin rol');

  // Datos cargados del servidor para el período activo
  readonly datosReporte = signal<ResultadoReporteContable | null>(null);

  // Estado de Filtros (Borrador editable en el panel vs Aplicado activo)
  readonly filtroBorrador = signal<FiltroReporteContable>(this.crearFiltroInicial());
  readonly filtroAplicado = signal<FiltroReporteContable>(this.crearFiltroInicial());

  // Vista activa ('comprobantes' | 'matriz' | 'conciliacion')
  readonly vistaActiva = signal<'comprobantes' | 'matriz' | 'conciliacion'>('comprobantes');

  // Control de expansión de comprobantes y paginación
  readonly expandidos = signal<Set<string>>(new Set());
  readonly paginaActual = signal(1);
  readonly tamanoPagina = signal(50);

  // Validación de fechas en borrador
  readonly rangoFechasInvalido = computed(() => {
    const f = this.filtroBorrador();
    if (f.modoPeriodo !== 'personalizado') return false;
    return !f.fechaDesde || !f.fechaHasta || f.fechaDesde > f.fechaHasta;
  });

  readonly tieneCambiosPendientesDeAplicar = computed(() => {
    return JSON.stringify(this.filtroBorrador()) !== JSON.stringify(this.filtroAplicado());
  });

  readonly conceptosDisponibles = computed(() => {
    return this.datosReporte()?.conceptosDisponibles ?? [];
  });

  // Universo filtrado reactivo según filtroAplicado
  readonly comprobantesFiltrados = computed<ComprobanteContableItem[]>(() => {
    const rep = this.datosReporte();
    if (!rep) return [];
    return this.contableSvc.filtrarComprobantes(rep.universoComprobantes, this.filtroAplicado());
  });

  // 5 KPIs reactivos sobre el universo filtrado
  readonly kpis = computed(() => {
    return this.contableSvc.calcularKpis(
      this.comprobantesFiltrados(),
      this.filtroAplicado().estado,
    );
  });

  // Paginación por comprobante (sobre comprobantesFiltrados)
  readonly totalPaginas = computed(() => {
    const total = this.comprobantesFiltrados().length;
    return Math.max(1, Math.ceil(total / this.tamanoPagina()));
  });

  readonly rangoPaginacion = computed(() => {
    const total = this.comprobantesFiltrados().length;
    if (total === 0) return { inicio: 0, fin: 0 };
    const inicio = (this.paginaActual() - 1) * this.tamanoPagina() + 1;
    const fin = Math.min(total, this.paginaActual() * this.tamanoPagina());
    return { inicio, fin };
  });

  readonly comprobantesPaginados = computed(() => {
    const todos = this.comprobantesFiltrados();
    const start = (this.paginaActual() - 1) * this.tamanoPagina();
    return todos.slice(start, start + this.tamanoPagina());
  });

  // Agrupación diaria de la página actual de comprobantes
  readonly gruposDiariosPaginados = computed<GrupoDiarioComprobantes[]>(() => {
    return this.contableSvc.agruparPorDia(
      this.comprobantesPaginados(),
      this.filtroAplicado().estado,
    );
  });

  // Matriz por conceptos (Sección E)
  readonly matrizConceptos = computed(() => {
    return this.contableSvc.construirMatrizPorConceptos(this.comprobantesFiltrados());
  });

  readonly filasMatrizPaginadas = computed(() => {
    const filas = this.matrizConceptos().filas;
    const start = (this.paginaActual() - 1) * this.tamanoPagina();
    return filas.slice(start, start + this.tamanoPagina());
  });

  // Documentos pendientes y Conciliación (Hojas 07 y 08)
  readonly documentosPendientes = computed(() => {
    return this.contableSvc.extraerDocumentosPendientes(this.comprobantesFiltrados());
  });

  readonly conciliacion = computed(() => {
    const f = this.filtroAplicado();
    const haySubfiltro =
      f.origen !== 'TODOS' ||
      f.canal !== 'TODOS' ||
      f.concepto !== '' ||
      f.documento !== 'TODOS' ||
      f.busqueda.trim() !== '';

    return this.contableSvc.calcularConciliacion(
      this.comprobantesFiltrados(),
      this.datosReporte()?.resumenCentralOficial ?? null,
      haySubfiltro,
    );
  });

  ngOnInit(): void {
    if (this.tienePermiso()) {
      void this.cargarPeriodoServidor();
    }
  }

  private crearFiltroInicial(): FiltroReporteContable {
    // Por defecto inicializamos en Octubre 2026 (período oficial de validación contable)
    // o el mes actual si está dentro de 2026
    const rangoOct = calcularRangoMes(2026, 10);
    return {
      modoPeriodo: 'mes_anio',
      mes: 10,
      anio: 2026,
      fechaDesde: rangoOct.desde,
      fechaHasta: rangoOct.hasta,
      origen: 'TODOS',
      canal: 'TODOS',
      concepto: '',
      estado: 'VIGENTES',
      documento: 'TODOS',
      busqueda: '',
    };
  }

  private resolverPeriodo(f: FiltroReporteContable): { desde: string; hasta: string; etiqueta: string } {
    if (f.modoPeriodo === 'mes_anio') {
      return calcularRangoMes(f.anio, f.mes);
    }
    return {
      desde: f.fechaDesde,
      hasta: f.fechaHasta,
      etiqueta: `Rango personalizado`,
    };
  }

  // ── Acciones del Panel de Filtros ─────────────────────────────────────────

  cambiarModoPeriodoBorrador(modo: ModoPeriodoContable): void {
    const actual = this.filtroBorrador();
    if (modo === 'mes_anio') {
      const r = calcularRangoMes(actual.anio, actual.mes);
      this.filtroBorrador.set({
        ...actual,
        modoPeriodo: 'mes_anio',
        fechaDesde: r.desde,
        fechaHasta: r.hasta,
      });
    } else {
      this.filtroBorrador.set({
        ...actual,
        modoPeriodo: 'personalizado',
      });
    }
  }

  actualizarMesBorrador(mesNum: number | string): void {
    const mes = Number(mesNum);
    const actual = this.filtroBorrador();
    const r = calcularRangoMes(actual.anio, mes);
    this.filtroBorrador.set({
      ...actual,
      mes,
      fechaDesde: r.desde,
      fechaHasta: r.hasta,
    });
  }

  actualizarAnioBorrador(anioNum: number | string): void {
    const anio = Number(anioNum);
    const actual = this.filtroBorrador();
    const r = calcularRangoMes(anio, actual.mes);
    this.filtroBorrador.set({
      ...actual,
      anio,
      fechaDesde: r.desde,
      fechaHasta: r.hasta,
    });
  }

  actualizarCampoBorrador<K extends keyof FiltroReporteContable>(
    campo: K,
    valor: FiltroReporteContable[K],
  ): void {
    this.filtroBorrador.set({
      ...this.filtroBorrador(),
      [campo]: valor,
    });
  }

  async aplicarFiltros(): Promise<void> {
    if (this.rangoFechasInvalido()) return;

    const previo = this.filtroAplicado();
    const nuevo = { ...this.filtroBorrador() };
    const perPrevio = this.resolverPeriodo(previo);
    const perNuevo = this.resolverPeriodo(nuevo);

    this.filtroAplicado.set(nuevo);
    this.paginaActual.set(1);

    // Si cambió el rango de fechas, consultar nuevamente a Supabase
    if (
      !this.datosReporte() ||
      perPrevio.desde !== perNuevo.desde ||
      perPrevio.hasta !== perNuevo.hasta
    ) {
      await this.cargarPeriodoServidor();
    }
  }

  async restablecerFiltros(): Promise<void> {
    const inicial = this.crearFiltroInicial();
    const perActual = this.resolverPeriodo(this.filtroAplicado());
    const perInicial = this.resolverPeriodo(inicial);

    this.filtroBorrador.set(inicial);
    this.filtroAplicado.set(inicial);
    this.paginaActual.set(1);
    this.expandidos.set(new Set());

    if (
      !this.datosReporte() ||
      perActual.desde !== perInicial.desde ||
      perActual.hasta !== perInicial.hasta
    ) {
      await this.cargarPeriodoServidor();
    }
  }

  private async cargarPeriodoServidor(): Promise<void> {
    if (!this.tienePermiso()) return;

    this.cargando.set(true);
    this.error.set(null);
    this.mensajeExportacion.set(null);

    const per = this.resolverPeriodo(this.filtroAplicado());

    try {
      const res = await this.contableSvc.cargarReportePeriodo(
        per.desde,
        per.hasta,
        per.etiqueta,
      );
      this.datosReporte.set(res);

      // Expandir automáticamente los primeros 3 comprobantes para facilitar inspección inmediata
      const primeros = res.universoComprobantes.slice(0, 3).map(c => c.uid);
      this.expandidos.set(new Set(primeros));
    } catch (err: unknown) {
      this.error.set(err instanceof Error ? err.message : 'Error al cargar el Reporte Contable.');
    } finally {
      this.cargando.set(false);
    }
  }

  // ── Exportación Excel (.xlsx de 9 hojas) ──────────────────────────────────

  async exportarExcel(anonimizar = false): Promise<void> {
    const rep = this.datosReporte();
    if (!rep || this.exportando() || !this.tienePermiso()) return;

    // Si el usuario modificó algún filtro en pantalla sin pulsar Aplicar, sincronizarlo primero
    if (this.tieneCambiosPendientesDeAplicar() && !this.rangoFechasInvalido()) {
      await this.aplicarFiltros();
    }

    const repActualizado = this.datosReporte();
    if (!repActualizado) return;

    this.exportando.set(true);
    this.error.set(null);
    this.mensajeExportacion.set(null);

    try {
      const nombreArchivo = await this.excelSvc.exportarArchivoContable({
        reporte: repActualizado,
        filtro: this.filtroAplicado(),
        comprobantesFiltrados: this.comprobantesFiltrados(),
        kpis: this.kpis(),
        conciliacion: this.conciliacion(),
        documentosPendientes: this.documentosPendientes(),
        anonimizarMuestra: anonimizar,
      });

      this.mensajeExportacion.set(
        `Archivo Excel generado correctamente: ${nombreArchivo} (${this.comprobantesFiltrados().length} comprobantes exportados en 9 hojas conciliadas).`,
      );
    } catch (err: unknown) {
      this.error.set(
        err instanceof Error ? `Error al exportar Excel: ${err.message}` : 'Error al exportar Excel.',
      );
    } finally {
      this.exportando.set(false);
    }
  }

  // ── Controles de Expansión y Paginación ───────────────────────────────────

  estaExpandido(uid: string): boolean {
    return this.expandidos().has(uid);
  }

  toggleComprobante(uid: string): void {
    const copia = new Set(this.expandidos());
    if (copia.has(uid)) {
      copia.delete(uid);
    } else {
      copia.add(uid);
    }
    this.expandidos.set(copia);
  }

  expandirPaginaActual(): void {
    const copia = new Set(this.expandidos());
    for (const c of this.comprobantesPaginados()) {
      copia.add(c.uid);
    }
    this.expandidos.set(copia);
  }

  contraerTodos(): void {
    this.expandidos.set(new Set());
  }

  irAPagina(pagina: number): void {
    const max = this.totalPaginas();
    const destino = Math.max(1, Math.min(max, pagina));
    this.paginaActual.set(destino);
  }

  cambiarTamanoPagina(nuevoTamano: number | string): void {
    this.tamanoPagina.set(Number(nuevoTamano));
    this.paginaActual.set(1);
  }

  // ── Helpers de Formato y Estilos Visuales ─────────────────────────────────

  fmtSoles(monto: number): string {
    return `S/ ${round2(monto).toLocaleString('es-PE', {
      minimumFractionDigits: 2,
      maximumFractionDigits: 2,
    })}`;
  }

  badgeOrigenClass(origen: string): string {
    switch (origen) {
      case 'SOCIOS':
        return 'px-2 py-0.5 rounded-full text-[11px] font-semibold bg-emerald-100 text-emerald-800 dark:bg-emerald-900/40 dark:text-emerald-300';
      case 'INQUILINOS':
        return 'px-2 py-0.5 rounded-full text-[11px] font-semibold bg-blue-100 text-blue-800 dark:bg-blue-900/40 dark:text-blue-300';
      default:
        return 'px-2 py-0.5 rounded-full text-[11px] font-semibold bg-amber-100 text-amber-800 dark:bg-amber-900/40 dark:text-amber-300';
    }
  }

  badgeDocumentoClass(estado: string): string {
    switch (estado) {
      case 'REGISTRADO':
        return 'px-2 py-0.5 rounded-md text-xs font-mono font-medium bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-200 border border-gray-200 dark:border-gray-600';
      case 'SIN REGISTRAR':
        return 'px-2 py-0.5 rounded-md text-xs font-bold bg-red-100 text-red-800 dark:bg-red-900/40 dark:text-red-300 border border-red-200 dark:border-red-800';
      case 'POR VALIDAR':
        return 'px-2 py-0.5 rounded-md text-xs font-bold bg-amber-100 text-amber-800 dark:bg-amber-900/40 dark:text-amber-300 border border-amber-200 dark:border-amber-800';
      default:
        return 'px-2 py-0.5 rounded-md text-xs font-medium bg-gray-100 text-gray-500 dark:bg-gray-800 dark:text-gray-400';
    }
  }

  badgeCanalClass(canal: string): string {
    switch (canal) {
      case 'EFECTIVO':
        return 'px-2 py-0.5 rounded-md text-[11px] font-semibold bg-emerald-50 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-300';
      case 'BANCO':
        return 'px-2 py-0.5 rounded-md text-[11px] font-semibold bg-sky-50 text-sky-700 dark:bg-sky-900/30 dark:text-sky-300';
      case 'SALDO_FAVOR':
        return 'px-2 py-0.5 rounded-md text-[11px] font-semibold bg-indigo-50 text-indigo-700 dark:bg-indigo-900/30 dark:text-indigo-300';
      default:
        return 'px-2 py-0.5 rounded-md text-[11px] font-semibold bg-purple-50 text-purple-700 dark:bg-purple-900/30 dark:text-purple-300';
    }
  }

  badgeTipoAbonoClass(tipo: string): string {
    if (tipo === 'Total') {
      return 'px-2 py-0.5 rounded-md text-[11px] font-medium bg-emerald-50 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-300';
    }
    if (tipo.startsWith('Liquidación')) {
      return 'px-2 py-0.5 rounded-md text-[11px] font-medium bg-blue-50 text-blue-700 dark:bg-blue-900/30 dark:text-blue-300';
    }
    if (tipo.startsWith('Parcial')) {
      return 'px-2 py-0.5 rounded-md text-[11px] font-medium bg-amber-50 text-amber-800 dark:bg-amber-900/30 dark:text-amber-300';
    }
    return 'px-2 py-0.5 rounded-md text-[11px] font-medium bg-gray-100 text-gray-700 dark:bg-gray-700 dark:text-gray-300';
  }
}
