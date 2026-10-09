import { Component, computed, inject, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import {
  EstadoCuentaDeudaItem,
  EstadoCuentaPagoItem,
  EstadoCuentaPersonaDetalle,
  EstadosCuentaService,
  PersonaResumenDeuda,
  TipoPersona,
} from '../../core/services/estados-cuenta.service';
import { ExcelExportService, HojaExcel } from '../../core/services/excel-export.service';
import {
  EstadoCuentaFilaCompletoPdf,
  EstadoCuentaFilaPagoPdf,
  EstadoCuentaFilaPendientePdf,
  EstadoCuentaIndividualPdfDatos,
  PdfGeneratorService,
  ResumenDeudasPdfDatos,
} from '../../core/services/pdf-generator.service';

// ---------------------------------------------------------------------------
// Constantes y Helpers
// ---------------------------------------------------------------------------
const MESES = [
  '', 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
  'Jul', 'Ago', 'Set', 'Oct', 'Nov', 'Dic'
];

const MESES_COMPLETOS = [
  '', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
  'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
];

function fmtSoles(n: number): string {
  return `S/ ${(Number(n) || 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
}

function fmtFecha(isoOrDate: string): string {
  if (!isoOrDate) return '—';
  const clean = isoOrDate.slice(0, 10);
  const [y, m, d] = clean.split('-').map(Number);
  if (!y || !m || !d) return isoOrDate;
  return `${String(d).padStart(2, '0')}/${String(m).padStart(2, '0')}/${y}`;
}

function fmtPeriodo(anio: number, mes: number): string {
  if (!mes || !anio) return '—';
  return `${MESES[mes] ?? mes} ${anio}`;
}

function hoyIso(): string {
  const d = new Date();
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;
}

function primerDiaMesIso(): string {
  const d = new Date();
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-01`;
}

function primerDiaAnioIso(): string {
  const d = new Date();
  return `${d.getFullYear()}-01-01`;
}

type ModoPrincipal = 'resumen' | 'individual';
type FiltroTipoPersona = 'todos' | TipoPersona;
type FiltroEstadoDeuda = 'con-deuda' | 'todos';
type SubVistaIndividual = 'pendientes' | 'pagos' | 'completo';
type RangoFechaOpcion = 'todo' | 'hoy' | 'mes' | 'año' | 'personalizado';

export interface MovimientoLedger {
  fecha: string;
  tipo: 'Cargo' | 'Pago';
  periodo: string;
  concepto: string;
  comprobante: string;
  cargo: number;
  pago: number;
}

@Component({
  selector: 'app-estados-cuenta-reporte',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    <div class="mx-auto max-w-7xl p-4 md:p-6 space-y-6">

      <!-- ── Encabezado Principal + Selector de Modo ────────────────────── -->
      <div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <nav class="mb-1 flex items-center gap-2 text-xs text-gray-500 dark:text-gray-400">
            <span>Reportes</span>
            <span>/</span>
            <span class="text-gray-800 dark:text-white font-medium">Estados de Cuenta</span>
          </nav>
          <h2 class="text-2xl font-bold text-gray-800 dark:text-white">
            Estados de Cuenta
          </h2>
          <p class="text-sm text-gray-500 dark:text-gray-400">
            Consulta y conciliación financiera de socios e inquilinos · Cooperativa Primero de Mayo
          </p>
        </div>

        <!-- Selector de Modo (Segmented Control TailAdmin) -->
        <div class="inline-flex rounded-xl border border-gray-200 bg-gray-100 p-1 dark:border-gray-700 dark:bg-gray-800">
          <button
            type="button"
            (click)="setModo('resumen')"
            [class]="modo() === 'resumen'
              ? 'bg-white text-gray-800 shadow-sm dark:bg-gray-700 dark:text-white font-semibold'
              : 'text-gray-600 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white font-medium'"
            class="flex items-center gap-2 rounded-lg px-4 py-2 text-sm transition">
            <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M3 10h18M3 14h18m-9-4v8m-7 4h14a2 2 0 002-2V6a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
            </svg>
            Resumen de Deudas
          </button>
          <button
            type="button"
            (click)="setModo('individual')"
            [class]="modo() === 'individual'
              ? 'bg-white text-gray-800 shadow-sm dark:bg-gray-700 dark:text-white font-semibold'
              : 'text-gray-600 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white font-medium'"
            class="flex items-center gap-2 rounded-lg px-4 py-2 text-sm transition">
            <svg class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
            </svg>
            Estado Individual
          </button>
        </div>
      </div>

      <!-- ── Alerta de Error Global ──────────────────────────────────────── -->
      @if (errorMsg()) {
        <div class="rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/20 dark:text-red-400 flex items-center justify-between">
          <span><strong>Error:</strong> {{ errorMsg() }}</span>
          <button (click)="errorMsg.set(null)" class="text-red-500 hover:text-red-700">✕</button>
        </div>
      }

      <!-- ================================================================= -->
      <!-- MODO A: RESUMEN DE DEUDAS                                        -->
      <!-- ================================================================= -->
      @if (modo() === 'resumen') {

        <!-- ── KPIs del Resumen ─────────────────────────────────────────── -->
        <div class="grid gap-4" [class]="filtroTipo() === 'todos' ? 'grid-cols-2 lg:grid-cols-4' : 'grid-cols-1 sm:grid-cols-3'">
          <!-- Tarjeta 1: Conteo según filtro -->
          <div class="rounded-2xl border border-gray-200 bg-white p-4 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
            <p class="text-xs font-medium uppercase tracking-wider text-gray-500 dark:text-gray-400">
              @if (filtroTipo() === 'socio') { Socios con Deuda }
              @else if (filtroTipo() === 'inquilino') { Inquilinos con Deuda }
              @else { Personas con Deuda }
            </p>
            <p class="mt-2 text-2xl font-bold text-gray-800 dark:text-white">
              {{ conDeudaSegunTipo() }}
              <span class="text-xs font-normal text-gray-400">
                / {{ totalPersonasSegunTipo() }} {{ filtroTipo() === 'socio' ? 'socios' : filtroTipo() === 'inquilino' ? 'inquilinos' : 'total' }}
              </span>
            </p>
            <p class="mt-1 text-xs text-gray-500 dark:text-gray-400">
              @if (filtroTipo() === 'todos') {
                <span class="text-blue-600 dark:text-blue-400 font-semibold">{{ sociosConDeudaCount() }} socios</span> ·
                <span class="text-amber-600 dark:text-amber-400 font-semibold">{{ inquilinosConDeudaCount() }} inquilinos</span>
              } @else if (filtroTipo() === 'socio') {
                <span class="text-emerald-600 dark:text-emerald-400 font-medium">{{ totalSocios() - sociosConDeudaCount() }} socios al día</span>
              } @else {
                <span class="text-emerald-600 dark:text-emerald-400 font-medium">{{ totalInquilinos() - inquilinosConDeudaCount() }} inquilinos al día</span>
              }
            </p>
          </div>

          <!-- Tarjeta 2: Deuda de Socios -->
          @if (filtroTipo() === 'todos' || filtroTipo() === 'socio') {
            <div class="rounded-2xl border border-blue-100 bg-blue-50/50 p-4 shadow-sm dark:border-blue-900/30 dark:bg-blue-950/20">
              <p class="text-xs font-medium uppercase tracking-wider text-blue-600 dark:text-blue-400">Deuda de Socios</p>
              <p class="mt-2 text-2xl font-bold text-blue-700 dark:text-blue-300">
                {{ fmtSoles(totalDeudaSocios()) }}
              </p>
              <p class="mt-1 text-xs text-blue-600/80 dark:text-blue-400/80">
                {{ sociosConDeudaCount() }} de {{ totalSocios() }} socios con deuda
              </p>
            </div>
          }

          <!-- Tarjeta 3: Deuda de Inquilinos -->
          @if (filtroTipo() === 'todos' || filtroTipo() === 'inquilino') {
            <div class="rounded-2xl border border-amber-100 bg-amber-50/50 p-4 shadow-sm dark:border-amber-900/30 dark:bg-amber-950/20">
              <p class="text-xs font-medium uppercase tracking-wider text-amber-600 dark:text-amber-400">Deuda de Inquilinos</p>
              <p class="mt-2 text-2xl font-bold text-amber-700 dark:text-amber-300">
                {{ fmtSoles(totalDeudaInquilinos()) }}
              </p>
              <p class="mt-1 text-xs text-amber-600/80 dark:text-amber-400/80">
                {{ inquilinosConDeudaCount() }} de {{ totalInquilinos() }} inquilinos con deuda
              </p>
            </div>
          }

          <!-- Tarjeta 4: Total Cartera Pendiente -->
          <div class="rounded-2xl border border-red-100 bg-red-50/50 p-4 shadow-sm dark:border-red-900/30 dark:bg-red-950/20">
            <p class="text-xs font-medium uppercase tracking-wider text-red-600 dark:text-red-400">
              @if (filtroTipo() === 'todos') { Total Pendiente Cartera }
              @else if (filtroTipo() === 'socio') { Total Pendiente Socios }
              @else { Total Pendiente Inquilinos }
            </p>
            <p class="mt-2 text-2xl font-bold text-red-700 dark:text-red-300">
              {{ fmtSoles(totalDeudaVisible()) }}
            </p>
            <p class="mt-1 text-xs text-red-600/80 dark:text-red-400/80">
              {{ conDeudaSegunTipo() }} personas exigibles
            </p>
          </div>
        </div>

        <!-- ── Barra de Filtros y Búsqueda del Resumen ──────────────────── -->
        <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between rounded-2xl border border-gray-200 bg-white p-4 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
          <!-- Búsqueda -->
          <div class="relative flex-1 max-w-md">
            <svg class="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-gray-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
              <circle cx="11" cy="11" r="8"/><path stroke-linecap="round" d="m21 21-4.35-4.35"/>
            </svg>
            <input
              type="text"
              placeholder="Buscar por nombre, DNI o puesto…"
              class="h-10 w-full rounded-xl border border-gray-300 bg-white pl-9 pr-4 text-sm text-gray-800 outline-none
                     focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 dark:border-gray-700 dark:bg-gray-800 dark:text-white"
              [value]="queryResumen()"
              (input)="onQueryResumenInput($event)"
            />
          </div>

          <div class="flex flex-wrap items-center gap-2">
            <!-- Selector Tipo de Persona -->
            <div class="flex rounded-xl border border-gray-300 dark:border-gray-700 overflow-hidden h-10">
              @for (opt of tipoOpts; track opt.v) {
                <button
                  type="button"
                  (click)="setFiltroTipo(opt.v)"
                  class="px-3 text-xs sm:text-sm font-medium transition"
                  [class]="filtroTipo() === opt.v
                    ? 'bg-brand-500 text-white'
                    : 'bg-white text-gray-600 hover:bg-gray-50 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700'">
                  {{ opt.label }}
                </button>
              }
            </div>

            <!-- Selector Estado -->
            <div class="flex rounded-xl border border-gray-300 dark:border-gray-700 overflow-hidden h-10">
              <button
                type="button"
                (click)="setFiltroEstado('con-deuda')"
                class="px-3 text-xs sm:text-sm font-medium transition"
                [class]="filtroEstado() === 'con-deuda'
                  ? 'bg-brand-500 text-white'
                  : 'bg-white text-gray-600 hover:bg-gray-50 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700'">
                Con Deuda
              </button>
              <button
                type="button"
                (click)="setFiltroEstado('todos')"
                class="px-3 text-xs sm:text-sm font-medium transition"
                [class]="filtroEstado() === 'todos'
                  ? 'bg-brand-500 text-white'
                  : 'bg-white text-gray-600 hover:bg-gray-50 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700'">
                Todos
              </button>
            </div>

            <!-- Botones Exportar -->
            <button
              type="button"
              (click)="exportarPdfResumen()"
              [disabled]="cargandoResumen() || exportandoPdf() || personasFiltradas().length === 0"
              class="inline-flex items-center gap-1.5 rounded-xl border border-gray-300 bg-white px-3 h-10 text-xs sm:text-sm font-medium text-gray-700
                     shadow-sm hover:bg-gray-50 dark:border-gray-600 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700 disabled:opacity-50">
              <svg class="h-4 w-4 text-red-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
              </svg>
              PDF
            </button>
            <button
              type="button"
              (click)="exportarExcelResumen()"
              [disabled]="cargandoResumen() || exportandoExcel() || personasFiltradas().length === 0"
              class="inline-flex items-center gap-1.5 rounded-xl border border-gray-300 bg-white px-3 h-10 text-xs sm:text-sm font-medium text-gray-700
                     shadow-sm hover:bg-gray-50 dark:border-gray-600 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700 disabled:opacity-50">
              <svg class="h-4 w-4 text-emerald-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9 17v-2m3 2v-4m3 4v-6m2 10H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
              </svg>
              Excel
            </button>
          </div>
        </div>

        <!-- ── Tabla del Resumen ────────────────────────────────────────── -->
        <div class="overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark">
          @if (cargandoResumen()) {
            <div class="flex h-56 items-center justify-center">
              <svg class="h-8 w-8 animate-spin text-brand-500" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
              </svg>
            </div>
          } @else {
            <div class="overflow-x-auto">
              <table class="w-full text-sm">
                <thead class="bg-gray-50 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:bg-gray-700/50 dark:text-gray-400">
                  <tr>
                    <th class="px-5 py-3.5 text-center">Tipo</th>
                    <th class="px-5 py-3.5 text-left">Persona / Razón Social</th>
                    <th class="px-5 py-3.5 text-center">DNI / Doc</th>
                    <th class="px-5 py-3.5 text-center">Puesto</th>
                    <th class="px-5 py-3.5 text-center">Pendientes</th>
                    <th class="px-5 py-3.5 text-right">Total Pendiente</th>
                    <th class="px-5 py-3.5 text-center">Acción</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                  @for (p of personasPaginadas(); track p.tipo + p.id) {
                    <tr class="hover:bg-gray-50/80 dark:hover:bg-gray-700/30 transition-colors">
                      <td class="px-5 py-3.5 text-center">
                        <span class="inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold"
                              [class]="p.tipo === 'socio'
                                ? 'bg-blue-100 text-blue-700 dark:bg-blue-900/40 dark:text-blue-300'
                                : 'bg-amber-100 text-amber-700 dark:bg-amber-900/40 dark:text-amber-300'">
                          {{ p.tipo === 'socio' ? 'Socio' : 'Inquilino' }}
                        </span>
                      </td>
                      <td class="px-5 py-3.5 font-medium text-gray-800 dark:text-white">
                        {{ p.nombre }}
                      </td>
                      <td class="px-5 py-3.5 text-center font-mono text-xs text-gray-500 dark:text-gray-400">
                        {{ p.dni || '—' }}
                      </td>
                      <td class="px-5 py-3.5 text-center font-mono text-xs text-gray-700 dark:text-gray-300">
                        {{ p.codigo_puesto || '—' }}
                      </td>
                      <td class="px-5 py-3.5 text-center">
                        @if (p.cant_pendientes > 0) {
                          <span class="inline-flex items-center rounded-full bg-red-100 px-2 py-0.5 text-xs font-bold text-red-700 dark:bg-red-900/40 dark:text-red-300">
                            {{ p.cant_pendientes }}
                          </span>
                        } @else {
                          <span class="text-xs text-gray-400">0</span>
                        }
                      </td>
                      <td class="px-5 py-3.5 text-right">
                        @if (p.deuda_pendiente > 0) {
                          <span class="font-bold text-red-600 dark:text-red-400">
                            {{ fmtSoles(p.deuda_pendiente) }}
                          </span>
                        } @else {
                          <span class="text-emerald-600 dark:text-emerald-400 font-medium">S/ 0.00</span>
                        }
                      </td>
                      <td class="px-5 py-3.5 text-center">
                        <button
                          type="button"
                          (click)="seleccionarPersonaDesdeResumen(p)"
                          class="inline-flex items-center gap-1 rounded-lg border border-brand-300 bg-brand-50/50 px-3 py-1.5 text-xs font-semibold text-brand-700
                                 hover:bg-brand-100 hover:border-brand-400 dark:border-brand-800 dark:bg-brand-900/20 dark:text-brand-300 dark:hover:bg-brand-900/40 transition">
                          Ver estado
                          <svg class="h-3 w-3" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/>
                          </svg>
                        </button>
                      </td>
                    </tr>
                  } @empty {
                    <tr>
                      <td colspan="7" class="py-12 text-center text-sm text-gray-400 dark:text-gray-500">
                        No se encontraron personas con los filtros seleccionados.
                      </td>
                    </tr>
                  }
                </tbody>
              </table>
            </div>

            <!-- Paginación -->
            @if (totalPaginasResumen() > 1) {
              <div class="flex items-center justify-between border-t border-gray-200 px-5 py-3 dark:border-gray-700">
                <p class="text-xs text-gray-500 dark:text-gray-400">
                  Mostrando {{ (paginaResumen() - 1) * tamPagina + 1 }}–{{ Math.min(paginaResumen() * tamPagina, personasFiltradas().length) }}
                  de {{ personasFiltradas().length }}
                </p>
                <div class="flex items-center gap-1">
                  <button
                    type="button"
                    (click)="paginaAnteriorResumen()"
                    [disabled]="paginaResumen() === 1"
                    class="rounded border border-gray-300 px-3 py-1 text-xs text-gray-600 hover:bg-gray-50 disabled:opacity-40
                           dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700">
                    ← Anterior
                  </button>
                  <span class="px-2 text-xs text-gray-600 dark:text-gray-400">
                    {{ paginaResumen() }} / {{ totalPaginasResumen() }}
                  </span>
                  <button
                    type="button"
                    (click)="paginaSiguienteResumen()"
                    [disabled]="paginaResumen() === totalPaginasResumen()"
                    class="rounded border border-gray-300 px-3 py-1 text-xs text-gray-600 hover:bg-gray-50 disabled:opacity-40
                           dark:border-gray-600 dark:text-gray-400 dark:hover:bg-gray-700">
                    Siguiente →
                  </button>
                </div>
              </div>
            }
          }
        </div>
      }

      <!-- ================================================================= -->
      <!-- MODO B: ESTADO INDIVIDUAL                                        -->
      <!-- ================================================================= -->
      @if (modo() === 'individual') {

        <!-- ── Buscador / Selector Autocomplete de Persona ───────────────── -->
        <div class="rounded-2xl border border-gray-200 bg-white p-4 shadow-sm dark:border-gray-700 dark:bg-gray-dark space-y-3">
          <div class="flex flex-col sm:flex-row sm:items-center gap-3">
            <!-- Selector Tipo -->
            <div class="flex rounded-xl border border-gray-300 dark:border-gray-700 overflow-hidden h-10 shrink-0">
              <button
                type="button"
                (click)="setFiltroTipoIndividual('socio')"
                class="px-4 text-xs sm:text-sm font-medium transition"
                [class]="filtroTipoIndividual() === 'socio'
                  ? 'bg-brand-500 text-white'
                  : 'bg-white text-gray-600 hover:bg-gray-50 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700'">
                Socio
              </button>
              <button
                type="button"
                (click)="setFiltroTipoIndividual('inquilino')"
                class="px-4 text-xs sm:text-sm font-medium transition"
                [class]="filtroTipoIndividual() === 'inquilino'
                  ? 'bg-brand-500 text-white'
                  : 'bg-white text-gray-600 hover:bg-gray-50 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700'">
                Inquilino
              </button>
            </div>

            <!-- Campo de Autocompletado -->
            <div class="relative flex-1">
              <svg class="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-gray-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <circle cx="11" cy="11" r="8"/><path stroke-linecap="round" d="m21 21-4.35-4.35"/>
              </svg>
              <input
                type="text"
                placeholder="Escribe el nombre, DNI o puesto para buscar persona…"
                class="h-10 w-full rounded-xl border border-gray-300 bg-white pl-9 pr-4 text-sm text-gray-800 outline-none
                       focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 dark:border-gray-700 dark:bg-gray-800 dark:text-white"
                [value]="queryIndividual()"
                (input)="onQueryIndividualInput($event)"
                (focus)="mostrarDropdownIndividual.set(true)"
              />

              <!-- Menú Desplegable Autocomplete -->
              @if (mostrarDropdownIndividual() && sugerenciasIndividuales().length > 0) {
                <div class="absolute left-0 right-0 top-12 z-30 max-h-60 overflow-y-auto rounded-xl border border-gray-200 bg-white shadow-xl dark:border-gray-700 dark:bg-gray-800">
                  @for (sug of sugerenciasIndividuales(); track sug.tipo + sug.id) {
                    <div
                      (click)="seleccionarPersona(sug)"
                      class="flex items-center justify-between px-4 py-2.5 hover:bg-brand-50 dark:hover:bg-gray-700 cursor-pointer border-b border-gray-100 dark:border-gray-700/50 last:border-0">
                      <div>
                        <p class="font-medium text-sm text-gray-800 dark:text-white">{{ sug.nombre }}</p>
                        <p class="text-xs text-gray-400">
                          DNI {{ sug.dni || '—' }}
                          @if (sug.codigo_puesto) { · Puesto {{ sug.codigo_puesto }} }
                        </p>
                      </div>
                      <div class="text-right">
                        @if (sug.deuda_pendiente > 0) {
                          <span class="text-xs font-bold text-red-600 dark:text-red-400">{{ fmtSoles(sug.deuda_pendiente) }}</span>
                        } @else {
                          <span class="text-xs text-emerald-600 dark:text-emerald-400">Al día</span>
                        }
                      </div>
                    </div>
                  }
                </div>
              }
            </div>
          </div>
        </div>

        <!-- ── Ficha del Titular / Persona Seleccionada ──────────────────── -->
        @if (personaSeleccionada()) {
          <div class="rounded-2xl border border-gray-200 bg-white p-5 shadow-sm dark:border-gray-700 dark:bg-gray-dark">
            <div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
              <!-- Datos de la persona -->
              <div class="flex items-center gap-4">
                <div class="flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl text-sm font-bold shadow-sm"
                     [class]="personaSeleccionada()!.tipo === 'socio'
                       ? 'bg-blue-100 text-blue-700 dark:bg-blue-900/40 dark:text-blue-300'
                       : 'bg-amber-100 text-amber-700 dark:bg-amber-900/40 dark:text-amber-300'">
                  {{ personaSeleccionada()!.tipo === 'socio' ? 'SC' : 'IQ' }}
                </div>
                <div>
                  <div class="flex items-center gap-2">
                    <h3 class="text-lg font-bold text-gray-900 dark:text-white">
                      {{ personaSeleccionada()!.nombre }}
                    </h3>
                    <span class="rounded-full px-2.5 py-0.5 text-xs font-semibold"
                          [class]="personaSeleccionada()!.tipo === 'socio'
                            ? 'bg-blue-100 text-blue-700 dark:bg-blue-900/40 dark:text-blue-300'
                            : 'bg-amber-100 text-amber-700 dark:bg-amber-900/40 dark:text-amber-300'">
                      {{ personaSeleccionada()!.tipo === 'socio' ? 'Socio' : 'Inquilino' }}
                    </span>
                  </div>
                  <p class="text-xs text-gray-400 mt-0.5">
                    DNI {{ personaSeleccionada()!.dni || '—' }}
                    @if (personaSeleccionada()!.codigo_puesto) { · Puesto {{ personaSeleccionada()!.codigo_puesto }} }
                    · Fecha consulta: {{ fmtFecha(hoyStr()) }}
                  </p>
                </div>
              </div>

              <!-- Bloque Saldo Pendiente Destacado -->
              <div class="flex flex-wrap items-center gap-3">
                @if ((personaSeleccionada()!.saldo_a_favor || 0) > 0) {
                  <div class="rounded-xl border border-emerald-200 bg-emerald-50 px-3.5 py-2 text-right dark:border-emerald-800/40 dark:bg-emerald-950/20">
                    <p class="text-2xs uppercase tracking-wider text-emerald-600 dark:text-emerald-400 font-semibold">Saldo a Favor</p>
                    <p class="text-base font-bold text-emerald-700 dark:text-emerald-300">
                      {{ fmtSoles(personaSeleccionada()!.saldo_a_favor) }}
                    </p>
                  </div>
                }
                <div class="rounded-xl border border-red-200 bg-red-50 px-4 py-2 text-right dark:border-red-800/40 dark:bg-red-950/20">
                  <p class="text-2xs uppercase tracking-wider text-red-600 dark:text-red-400 font-semibold">Saldo Pendiente Actual</p>
                  <p class="text-xl font-black text-red-700 dark:text-red-300">
                    {{ fmtSoles(personaSeleccionada()!.deuda_pendiente) }}
                  </p>
                </div>

                <!-- Botones Exportar Individual -->
                <div class="flex items-center gap-2">
                  <button
                    type="button"
                    (click)="exportarPdfIndividual()"
                    [disabled]="cargandoDetalle() || exportandoPdf()"
                    class="inline-flex items-center gap-1.5 rounded-xl border border-gray-300 bg-white px-3.5 py-2 text-xs sm:text-sm font-medium text-gray-700
                           shadow-sm hover:bg-gray-50 dark:border-gray-600 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700 disabled:opacity-50">
                    <svg class="h-4 w-4 text-red-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                    PDF
                  </button>
                  <button
                    type="button"
                    (click)="exportarExcelIndividual()"
                    [disabled]="cargandoDetalle() || exportandoExcel()"
                    class="inline-flex items-center gap-1.5 rounded-xl border border-gray-300 bg-white px-3.5 py-2 text-xs sm:text-sm font-medium text-gray-700
                           shadow-sm hover:bg-gray-50 dark:border-gray-600 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700 disabled:opacity-50">
                    <svg class="h-4 w-4 text-emerald-600" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M9 17v-2m3 2v-4m3 4v-6m2 10H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                    Excel
                  </button>
                </div>
              </div>
            </div>
          </div>

          <!-- ── Sub-vistas Individuales (Tabs) ─────────────────────────── -->
          <div class="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-dark overflow-hidden">
            <!-- Headers de las Sub-vistas -->
            <div class="flex border-b border-gray-200 bg-gray-50/50 dark:border-gray-700 dark:bg-gray-800/40">
              <button
                type="button"
                (click)="setSubVista('pendientes')"
                class="flex items-center gap-2 px-6 py-3.5 text-sm font-medium transition border-b-2"
                [class]="subVista() === 'pendientes'
                  ? 'border-brand-500 text-brand-600 dark:text-brand-400 bg-white dark:bg-gray-dark'
                  : 'border-transparent text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200'">
                Pendientes
                @if (deudasPendientes().length > 0) {
                  <span class="rounded-full bg-red-100 px-2 py-0.5 text-xs font-bold text-red-600 dark:bg-red-900/40 dark:text-red-400">
                    {{ deudasPendientes().length }}
                  </span>
                }
              </button>
              <button
                type="button"
                (click)="setSubVista('pagos')"
                class="flex items-center gap-2 px-6 py-3.5 text-sm font-medium transition border-b-2"
                [class]="subVista() === 'pagos'
                  ? 'border-brand-500 text-brand-600 dark:text-brand-400 bg-white dark:bg-gray-dark'
                  : 'border-transparent text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200'">
                Pagos Realizados
                <span class="rounded-full bg-emerald-100 px-2 py-0.5 text-xs font-bold text-emerald-700 dark:bg-emerald-900/40 dark:text-emerald-300">
                  {{ pagosFiltrados().length }}
                </span>
              </button>
              <button
                type="button"
                (click)="setSubVista('completo')"
                class="flex items-center gap-2 px-6 py-3.5 text-sm font-medium transition border-b-2"
                [class]="subVista() === 'completo'
                  ? 'border-brand-500 text-brand-600 dark:text-brand-400 bg-white dark:bg-gray-dark'
                  : 'border-transparent text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200'">
                Estado Completo
                <span class="rounded-full bg-gray-200 px-2 py-0.5 text-xs text-gray-700 dark:bg-gray-700 dark:text-gray-300">
                  {{ movimientosLedgerFiltrados().length }}
                </span>
              </button>
            </div>

            <!-- ── Filtros de Fecha (para Pagos y Estado Completo) ─────── -->
            @if (subVista() !== 'pendientes') {
              <div class="flex flex-wrap items-center justify-between gap-3 p-4 border-b border-gray-100 dark:border-gray-700/60 bg-gray-50/20">
                <div class="flex items-center gap-1.5 flex-wrap">
                  <span class="text-xs font-semibold text-gray-500 dark:text-gray-400 mr-1">Período:</span>
                  @for (r of rangoOpts; track r.v) {
                    <button
                      type="button"
                      (click)="setRangoFecha(r.v)"
                      class="rounded-lg px-3 py-1.5 text-xs font-medium transition"
                      [class]="rangoFecha() === r.v
                        ? 'bg-brand-500 text-white font-semibold'
                        : 'border border-gray-200 bg-white text-gray-600 hover:bg-gray-50 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-300'">
                      {{ r.label }}
                    </button>
                  }
                </div>

                <!-- Rango personalizado -->
                @if (rangoFecha() === 'personalizado') {
                  <div class="flex items-center gap-2">
                    <input
                      type="date"
                      [(ngModel)]="fechaDesde"
                      class="h-9 rounded-lg border border-gray-300 bg-white px-2.5 text-xs text-gray-800 dark:border-gray-600 dark:bg-gray-800 dark:text-white"
                    />
                    <span class="text-xs text-gray-400">al</span>
                    <input
                      type="date"
                      [(ngModel)]="fechaHasta"
                      class="h-9 rounded-lg border border-gray-300 bg-white px-2.5 text-xs text-gray-800 dark:border-gray-600 dark:bg-gray-800 dark:text-white"
                    />
                  </div>
                }
              </div>
            }

            <!-- ── Contenido de la Sub-vista Activa ───────────────────── -->
            @if (cargandoDetalle()) {
              <div class="flex h-48 items-center justify-center">
                <svg class="h-8 w-8 animate-spin text-brand-500" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                </svg>
              </div>
            } @else {

              <!-- SUB-VISTA 1: PENDIENTES -->
              @if (subVista() === 'pendientes') {
                <div class="overflow-x-auto">
                  <table class="w-full text-sm">
                    <thead class="bg-gray-50 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:bg-gray-700/50 dark:text-gray-400">
                      <tr>
                        <th class="px-5 py-3 text-center">Período</th>
                        <th class="px-5 py-3 text-left">Concepto / Espacio</th>
                        <th class="px-5 py-3 text-center">Puesto</th>
                        <th class="px-5 py-3 text-right">Importe Orig.</th>
                        <th class="px-5 py-3 text-right">Ya Pagado</th>
                        <th class="px-5 py-3 text-right">Saldo Pendiente</th>
                      </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                      @for (d of deudasPendientes(); track d.id) {
                        <tr class="hover:bg-gray-50/50 dark:hover:bg-gray-700/20">
                          <td class="px-5 py-3 text-center font-mono text-xs text-gray-600 dark:text-gray-300">
                            {{ fmtPeriodo(d.periodo_anio, d.periodo_mes) }}
                          </td>
                          <td class="px-5 py-3 font-medium text-gray-800 dark:text-white">
                            {{ d.concepto }}
                            @if (d.observacion) {
                              <p class="text-2xs text-gray-400 italic line-clamp-1">{{ d.observacion }}</p>
                            }
                          </td>
                          <td class="px-5 py-3 text-center font-mono text-xs text-gray-500 dark:text-gray-400">
                            {{ d.codigo_puesto || '—' }}
                          </td>
                          <td class="px-5 py-3 text-right text-gray-600 dark:text-gray-300">
                            {{ fmtSoles(d.monto) }}
                          </td>
                          <td class="px-5 py-3 text-right">
                            @if (d.ya_pagado > 0) {
                              <span class="text-emerald-600 dark:text-emerald-400 font-medium">{{ fmtSoles(d.ya_pagado) }}</span>
                            } @else {
                              <span class="text-gray-400">—</span>
                            }
                          </td>
                          <td class="px-5 py-3 text-right font-bold text-red-600 dark:text-red-400">
                            {{ fmtSoles(d.saldo_pendiente) }}
                          </td>
                        </tr>
                      } @empty {
                        <tr>
                          <td colspan="6" class="py-12 text-center text-sm text-gray-400 dark:text-gray-500">
                            No se encontraron obligaciones pendientes. La persona está al día.
                          </td>
                        </tr>
                      }
                    </tbody>
                    @if (deudasPendientes().length > 0) {
                      <tfoot class="bg-gray-50/80 font-semibold dark:bg-gray-800/60 border-t border-gray-200 dark:border-gray-700">
                        <tr>
                          <td colspan="5" class="px-5 py-3 text-right text-xs uppercase tracking-wider text-gray-600 dark:text-gray-300">
                            TOTAL DEUDA PENDIENTE:
                          </td>
                          <td class="px-5 py-3 text-right text-base font-bold text-red-600 dark:text-red-400">
                            {{ fmtSoles(personaSeleccionada()!.deuda_pendiente) }}
                          </td>
                        </tr>
                      </tfoot>
                    }
                  </table>
                </div>
              }

              <!-- SUB-VISTA 2: PAGOS -->
              @if (subVista() === 'pagos') {
                <div class="overflow-x-auto">
                  <table class="w-full text-sm">
                    <thead class="bg-gray-50 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:bg-gray-700/50 dark:text-gray-400">
                      <tr>
                        <th class="px-5 py-3 text-center">Fecha</th>
                        <th class="px-5 py-3 text-left">N.º Transacción</th>
                        <th class="px-5 py-3 text-center">Método</th>
                        <th class="px-5 py-3 text-left">Conceptos Cubiertos</th>
                        <th class="px-5 py-3 text-center">Comprobante</th>
                        <th class="px-5 py-3 text-right">Monto Pagado</th>
                      </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                      @for (pg of pagosFiltrados(); track pg.id) {
                        <tr [class]="pg.anulado ? 'opacity-40 bg-gray-50 dark:bg-gray-800/40' : 'hover:bg-gray-50/50 dark:hover:bg-gray-700/20'">
                          <td class="px-5 py-3 text-center text-xs text-gray-600 dark:text-gray-300">
                            {{ fmtFecha(pg.fecha_pago) }}
                          </td>
                          <td class="px-5 py-3 font-mono text-xs font-medium text-gray-800 dark:text-white">
                            {{ pg.codigo_transaccion }}
                            @if (pg.anulado) {
                              <span class="ml-1 inline-flex rounded bg-red-100 px-1.5 py-0.2 text-2xs font-bold text-red-700 dark:bg-red-900/40 dark:text-red-300">ANULADO</span>
                            }
                          </td>
                          <td class="px-5 py-3 text-center">
                            <span class="rounded-full px-2 py-0.5 text-2xs font-medium"
                                  [class]="pg.metodo_pago === 'Efectivo'
                                    ? 'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400'
                                    : 'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400'">
                              {{ pg.metodo_pago }}
                            </span>
                          </td>
                          <td class="px-5 py-3 text-xs text-gray-600 dark:text-gray-300">
                            <div class="flex flex-wrap gap-1">
                              @for (c of pg.detalle; track c.concepto) {
                                <span class="rounded border border-gray-200 bg-gray-50 px-1.5 py-0.5 text-2xs dark:border-gray-700 dark:bg-gray-800">
                                  {{ c.concepto }}: {{ fmtSoles(c.monto_aplicado) }}
                                </span>
                              }
                            </div>
                          </td>
                          <td class="px-5 py-3 text-center font-mono text-xs text-gray-500 dark:text-gray-400">
                            {{ pg.comprobante || '—' }}
                          </td>
                          <td class="px-5 py-3 text-right font-bold" [class]="pg.anulado ? 'line-through text-gray-400' : 'text-emerald-600 dark:text-emerald-400'">
                            {{ fmtSoles(pg.monto_total) }}
                          </td>
                        </tr>
                      } @empty {
                        <tr>
                          <td colspan="6" class="py-12 text-center text-sm text-gray-400 dark:text-gray-500">
                            No se encontraron pagos válidos para el período seleccionado.
                          </td>
                        </tr>
                      }
                    </tbody>
                    @if (pagosFiltrados().length > 0) {
                      <tfoot class="bg-gray-50/80 font-semibold dark:bg-gray-800/60 border-t border-gray-200 dark:border-gray-700">
                        <tr>
                          <td colspan="5" class="px-5 py-3 text-right text-xs uppercase tracking-wider text-gray-600 dark:text-gray-300">
                            TOTAL PAGADO EN EL PERÍODO:
                          </td>
                          <td class="px-5 py-3 text-right text-base font-bold text-emerald-600 dark:text-emerald-400">
                            {{ fmtSoles(totalPagosPeriodo()) }}
                          </td>
                        </tr>
                      </tfoot>
                    }
                  </table>
                </div>
              }

              <!-- SUB-VISTA 3: ESTADO COMPLETO (LEDGER) -->
              @if (subVista() === 'completo') {
                <div class="overflow-x-auto">
                  <table class="w-full text-sm">
                    <thead class="bg-gray-50 text-xs font-semibold uppercase tracking-wider text-gray-500 dark:bg-gray-700/50 dark:text-gray-400">
                      <tr>
                        <th class="px-5 py-3 text-center">Fecha</th>
                        <th class="px-5 py-3 text-center">Tipo</th>
                        <th class="px-5 py-3 text-center">Período</th>
                        <th class="px-5 py-3 text-left">Concepto / Detalle</th>
                        <th class="px-5 py-3 text-center">Doc / Ref</th>
                        <th class="px-5 py-3 text-right">Cargo (Debe)</th>
                        <th class="px-5 py-3 text-right">Pago (Haber)</th>
                      </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                      @for (m of movimientosLedgerFiltrados(); track m.fecha + m.tipo + m.concepto) {
                        <tr class="hover:bg-gray-50/50 dark:hover:bg-gray-700/20">
                          <td class="px-5 py-3 text-center text-xs text-gray-600 dark:text-gray-300">
                            {{ fmtFecha(m.fecha) }}
                          </td>
                          <td class="px-5 py-3 text-center">
                            <span class="inline-flex rounded-full px-2 py-0.5 text-2xs font-bold"
                                  [class]="m.tipo === 'Cargo'
                                    ? 'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-300'
                                    : 'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400'">
                              {{ m.tipo }}
                            </span>
                          </td>
                          <td class="px-5 py-3 text-center font-mono text-xs text-gray-500 dark:text-gray-400">
                            {{ m.periodo }}
                          </td>
                          <td class="px-5 py-3 text-gray-800 dark:text-white font-medium text-xs">
                            {{ m.concepto }}
                          </td>
                          <td class="px-5 py-3 text-center font-mono text-xs text-gray-500 dark:text-gray-400">
                            {{ m.comprobante || '—' }}
                          </td>
                          <td class="px-5 py-3 text-right text-xs">
                            @if (m.cargo > 0) {
                              <span class="font-bold text-red-600 dark:text-red-400">{{ fmtSoles(m.cargo) }}</span>
                            } @else {
                              <span class="text-gray-300 dark:text-gray-600">—</span>
                            }
                          </td>
                          <td class="px-5 py-3 text-right text-xs">
                            @if (m.pago > 0) {
                              <span class="font-bold text-emerald-600 dark:text-emerald-400">{{ fmtSoles(m.pago) }}</span>
                            } @else {
                              <span class="text-gray-300 dark:text-gray-600">—</span>
                            }
                          </td>
                        </tr>
                      } @empty {
                        <tr>
                          <td colspan="7" class="py-12 text-center text-sm text-gray-400 dark:text-gray-500">
                            No se encontraron movimientos registrados en el período seleccionado.
                          </td>
                        </tr>
                      }
                    </tbody>
                    @if (movimientosLedgerFiltrados().length > 0) {
                      <tfoot class="bg-gray-50/80 font-semibold dark:bg-gray-800/60 border-t border-gray-200 dark:border-gray-700">
                        <tr>
                          <td colspan="5" class="px-5 py-3 text-right text-xs uppercase tracking-wider text-gray-600 dark:text-gray-300">
                            TOTALES DEL PERÍODO:
                          </td>
                          <td class="px-5 py-3 text-right text-xs font-bold text-red-600 dark:text-red-400">
                            {{ fmtSoles(totalCargosPeriodo()) }}
                          </td>
                          <td class="px-5 py-3 text-right text-xs font-bold text-emerald-600 dark:text-emerald-400">
                            {{ fmtSoles(totalPagosPeriodo()) }}
                          </td>
                        </tr>
                      </tfoot>
                    }
                  </table>
                </div>
              }

            }
          </div>
        } @else {
          <!-- Estado Inicial sin persona seleccionada -->
          <div class="rounded-2xl border border-dashed border-gray-300 p-12 text-center dark:border-gray-700 bg-white/50 dark:bg-gray-800/20">
            <svg class="mx-auto h-12 w-12 text-gray-400 mb-3" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z"/>
            </svg>
            <p class="text-base font-semibold text-gray-700 dark:text-gray-200">
              Seleccione un socio o inquilino
            </p>
            <p class="text-sm text-gray-500 dark:text-gray-400 mt-1 max-w-md mx-auto">
              Utilice el buscador superior para localizar a la persona por nombre, DNI o número de puesto y consultar su estado de cuenta.
            </p>
          </div>
        }
      }

    </div>
  `,
})
export class EstadosCuentaReporteComponent implements OnInit {
  private readonly svc = inject(EstadosCuentaService);
  private readonly pdfSvc = inject(PdfGeneratorService);
  private readonly excelSvc = inject(ExcelExportService);

  readonly fmtSoles = fmtSoles;
  readonly fmtFecha = fmtFecha;
  readonly fmtPeriodo = fmtPeriodo;
  readonly hoyStr = hoyIso;
  protected readonly Math = Math;

  // Estado general
  readonly modo = signal<ModoPrincipal>('resumen');
  readonly errorMsg = signal<string | null>(null);
  readonly exportandoPdf = signal(false);
  readonly exportandoExcel = signal(false);

  // ── MODO RESUMEN ──────────────────────────────────────────────────────────
  readonly cargandoResumen = signal(true);
  readonly personas = signal<PersonaResumenDeuda[]>([]);
  readonly queryResumen = signal('');
  readonly filtroTipo = signal<FiltroTipoPersona>('todos');
  readonly filtroEstado = signal<FiltroEstadoDeuda>('con-deuda');
  readonly paginaResumen = signal(1);
  readonly tamPagina = 25;

  readonly tipoOpts: { label: string; v: FiltroTipoPersona }[] = [
    { label: 'Todos', v: 'todos' },
    { label: 'Socios', v: 'socio' },
    { label: 'Inquilinos', v: 'inquilino' },
  ];

  readonly personasFiltradas = computed(() => {
    const q = this.queryResumen().toLowerCase().trim();
    const ft = this.filtroTipo();
    const fe = this.filtroEstado();

    return this.personas().filter(p => {
      const matchQ = !q
        || p.nombre.toLowerCase().includes(q)
        || (p.dni || '').toLowerCase().includes(q)
        || (p.codigo_puesto || '').toLowerCase().includes(q);

      const matchT = ft === 'todos' || p.tipo === ft;
      const matchE = fe === 'todos' || (fe === 'con-deuda' && p.deuda_pendiente > 0);

      return matchQ && matchT && matchE;
    });
  });

  readonly personasPaginadas = computed(() => {
    const start = (this.paginaResumen() - 1) * this.tamPagina;
    return this.personasFiltradas().slice(start, start + this.tamPagina);
  });

  readonly totalPaginasResumen = computed(() =>
    Math.max(1, Math.ceil(this.personasFiltradas().length / this.tamPagina))
  );

  readonly totalSocios = computed(() =>
    this.personas().filter(p => p.tipo === 'socio').length
  );

  readonly sociosConDeudaCount = computed(() =>
    this.personas().filter(p => p.tipo === 'socio' && p.deuda_pendiente > 0).length
  );

  readonly totalInquilinos = computed(() =>
    this.personas().filter(p => p.tipo === 'inquilino').length
  );

  readonly inquilinosConDeudaCount = computed(() =>
    this.personas().filter(p => p.tipo === 'inquilino' && p.deuda_pendiente > 0).length
  );

  readonly personasConDeudaCount = computed(() =>
    this.personas().filter(p => p.deuda_pendiente > 0).length
  );

  readonly conDeudaSegunTipo = computed(() => {
    const t = this.filtroTipo();
    if (t === 'socio') return this.sociosConDeudaCount();
    if (t === 'inquilino') return this.inquilinosConDeudaCount();
    return this.personasConDeudaCount();
  });

  readonly totalPersonasSegunTipo = computed(() => {
    const t = this.filtroTipo();
    if (t === 'socio') return this.totalSocios();
    if (t === 'inquilino') return this.totalInquilinos();
    return this.personas().length;
  });

  readonly totalDeudaSocios = computed(() =>
    this.personas()
      .filter(p => p.tipo === 'socio')
      .reduce((sum, p) => sum + p.deuda_pendiente, 0)
  );

  readonly totalDeudaInquilinos = computed(() =>
    this.personas()
      .filter(p => p.tipo === 'inquilino')
      .reduce((sum, p) => sum + p.deuda_pendiente, 0)
  );

  readonly totalDeudaVisible = computed(() =>
    this.personasFiltradas().reduce((sum, p) => sum + p.deuda_pendiente, 0)
  );

  // ── MODO INDIVIDUAL ───────────────────────────────────────────────────────
  readonly filtroTipoIndividual = signal<TipoPersona>('socio');
  readonly queryIndividual = signal('');
  readonly mostrarDropdownIndividual = signal(false);
  readonly personaSeleccionada = signal<PersonaResumenDeuda | null>(null);
  readonly cargandoDetalle = signal(false);
  readonly detalle = signal<EstadoCuentaPersonaDetalle | null>(null);
  readonly subVista = signal<SubVistaIndividual>('pendientes');

  // Filtros de fecha individual
  readonly rangoFecha = signal<RangoFechaOpcion>('todo');
  fechaDesde = primerDiaMesIso();
  fechaHasta = hoyIso();

  readonly rangoOpts: { label: string; v: RangoFechaOpcion }[] = [
    { label: 'Todo', v: 'todo' },
    { label: 'Hoy', v: 'hoy' },
    { label: 'Este mes', v: 'mes' },
    { label: 'Este año', v: 'año' },
    { label: 'Personalizado', v: 'personalizado' },
  ];

  readonly sugerenciasIndividuales = computed(() => {
    const q = this.queryIndividual().toLowerCase().trim();
    const t = this.filtroTipoIndividual();
    return this.personas().filter(p => {
      const matchT = p.tipo === t;
      if (!q) return matchT;
      const matchQ = p.nombre.toLowerCase().includes(q)
        || (p.dni || '').toLowerCase().includes(q)
        || (p.codigo_puesto || '').toLowerCase().includes(q);
      return matchT && matchQ;
    }).slice(0, 8);
  });

  readonly deudasPendientes = computed<EstadoCuentaDeudaItem[]>(() =>
    (this.detalle()?.deudas ?? [])
      .filter((d: EstadoCuentaDeudaItem) => d.saldo_pendiente > 0)
      .sort((a: EstadoCuentaDeudaItem, b: EstadoCuentaDeudaItem) => {
        if (a.periodo_anio !== b.periodo_anio) return a.periodo_anio - b.periodo_anio;
        if (a.periodo_mes !== b.periodo_mes) return a.periodo_mes - b.periodo_mes;
        return a.id - b.id;
      })
  );

  readonly pagosFiltrados = computed<EstadoCuentaPagoItem[]>(() => {
    const pagos: EstadoCuentaPagoItem[] = this.detalle()?.pagos ?? [];
    const r = this.rangoFecha();
    const [desde, hasta] = this.calcularLimitesFecha(r);

    return pagos
      .filter((p: EstadoCuentaPagoItem) => {
        if (!desde || !hasta) return true;
        const f = p.fecha_pago ? p.fecha_pago.slice(0, 10) : '';
        return f >= desde && f <= hasta;
      })
      .sort((a: EstadoCuentaPagoItem, b: EstadoCuentaPagoItem) => (b.fecha_pago || '').localeCompare(a.fecha_pago || ''));
  });

  readonly totalPagosPeriodo = computed<number>(() =>
    this.pagosFiltrados()
      .filter((p: EstadoCuentaPagoItem) => !p.anulado)
      .reduce((sum: number, p: EstadoCuentaPagoItem) => sum + p.monto_total, 0)
  );

  readonly movimientosLedgerFiltrados = computed<MovimientoLedger[]>(() => {
    const det = this.detalle();
    if (!det) return [];

    const r = this.rangoFecha();
    const [desde, hasta] = this.calcularLimitesFecha(r);

    const ledger: MovimientoLedger[] = [];

    // 1. Cargos
    for (const d of det.deudas) {
      const fecha = d.fecha_generacion || `${d.periodo_anio}-${String(d.periodo_mes).padStart(2, '0')}-01`;
      if (desde && hasta && (fecha < desde || fecha > hasta)) continue;

      ledger.push({
        fecha,
        tipo: 'Cargo',
        periodo: fmtPeriodo(d.periodo_anio, d.periodo_mes),
        concepto: d.concepto + (d.codigo_puesto ? ` (${d.codigo_puesto})` : ''),
        comprobante: d.observacion || '',
        cargo: d.monto,
        pago: 0,
      });
    }

    // 2. Pagos válidos
    for (const p of det.pagos) {
      if (p.anulado) continue;
      const fecha = p.fecha_pago ? p.fecha_pago.slice(0, 10) : '';
      if (desde && hasta && (fecha < desde || fecha > hasta)) continue;

      const conceptosStr = p.detalle.map((dt: { concepto: string; monto_aplicado: number }) => dt.concepto).join(', ') || 'Pago recibido';
      ledger.push({
        fecha,
        tipo: 'Pago',
        periodo: '—',
        concepto: `${conceptosStr} (${p.metodo_pago})`,
        comprobante: p.codigo_transaccion + (p.comprobante ? ` / ${p.comprobante}` : ''),
        cargo: 0,
        pago: p.monto_total,
      });
    }

    return ledger.sort((a: MovimientoLedger, b: MovimientoLedger) => b.fecha.localeCompare(a.fecha));
  });

  readonly totalCargosPeriodo = computed(() =>
    this.movimientosLedgerFiltrados()
      .filter(m => m.tipo === 'Cargo')
      .reduce((sum, m) => sum + m.cargo, 0)
  );

  async ngOnInit(): Promise<void> {
    await this.cargarPersonas();
  }

  async cargarPersonas(): Promise<void> {
    this.cargandoResumen.set(true);
    this.errorMsg.set(null);
    try {
      const data = await this.svc.listarResumenDeudas();
      this.personas.set(data);
    } catch (e: unknown) {
      this.errorMsg.set(e instanceof Error ? e.message : 'Error al cargar el resumen de deudas.');
    } finally {
      this.cargandoResumen.set(false);
    }
  }

  // ── Control de Modo ───────────────────────────────────────────────────────
  setModo(m: ModoPrincipal): void {
    this.modo.set(m);
  }

  // ── Eventos de Modo Resumen ───────────────────────────────────────────────
  setFiltroTipo(t: FiltroTipoPersona): void {
    this.filtroTipo.set(t);
    this.paginaResumen.set(1);
  }

  setFiltroEstado(e: FiltroEstadoDeuda): void {
    this.filtroEstado.set(e);
    this.paginaResumen.set(1);
  }

  onQueryResumenInput(ev: Event): void {
    this.queryResumen.set((ev.target as HTMLInputElement).value);
    this.paginaResumen.set(1);
  }

  paginaAnteriorResumen(): void {
    this.paginaResumen.update(p => Math.max(1, p - 1));
  }

  paginaSiguienteResumen(): void {
    this.paginaResumen.update(p => Math.min(this.totalPaginasResumen(), p + 1));
  }

  seleccionarPersonaDesdeResumen(p: PersonaResumenDeuda): void {
    this.filtroTipoIndividual.set(p.tipo);
    this.seleccionarPersona(p);
    this.modo.set('individual');
  }

  // ── Eventos de Modo Individual ────────────────────────────────────────────
  setFiltroTipoIndividual(t: TipoPersona): void {
    this.filtroTipoIndividual.set(t);
    this.queryIndividual.set('');
    this.mostrarDropdownIndividual.set(false);
  }

  onQueryIndividualInput(ev: Event): void {
    this.queryIndividual.set((ev.target as HTMLInputElement).value);
    this.mostrarDropdownIndividual.set(true);
  }

  async seleccionarPersona(p: PersonaResumenDeuda): Promise<void> {
    this.personaSeleccionada.set(p);
    this.queryIndividual.set(p.nombre);
    this.mostrarDropdownIndividual.set(false);
    this.cargandoDetalle.set(true);
    this.errorMsg.set(null);

    try {
      const data = await this.svc.obtenerDetalle(p.tipo, p.id);
      this.detalle.set(data);
      // Actualizar saldos en la persona seleccionada con la foto fresca de deudas
      this.personaSeleccionada.set(data.persona);
    } catch (e: unknown) {
      this.errorMsg.set(e instanceof Error ? e.message : 'Error al cargar el detalle de la persona.');
    } finally {
      this.cargandoDetalle.set(false);
    }
  }

  setSubVista(sv: SubVistaIndividual): void {
    this.subVista.set(sv);
  }

  setRangoFecha(r: RangoFechaOpcion): void {
    this.rangoFecha.set(r);
    if (r === 'hoy') {
      this.fechaDesde = hoyIso();
      this.fechaHasta = hoyIso();
    } else if (r === 'mes') {
      this.fechaDesde = primerDiaMesIso();
      this.fechaHasta = hoyIso();
    } else if (r === 'año') {
      this.fechaDesde = primerDiaAnioIso();
      this.fechaHasta = hoyIso();
    }
  }

  private calcularLimitesFecha(r: RangoFechaOpcion): [string | null, string | null] {
    if (r === 'todo') return [null, null];
    if (r === 'hoy') return [hoyIso(), hoyIso()];
    if (r === 'mes') return [primerDiaMesIso(), hoyIso()];
    if (r === 'año') return [primerDiaAnioIso(), hoyIso()];
    if (r === 'personalizado') {
      const d = this.fechaDesde || primerDiaMesIso();
      const h = this.fechaHasta || hoyIso();
      return [d <= h ? d : h, d <= h ? h : d];
    }
    return [null, null];
  }

  private obtenerPeriodoLabel(): string {
    const r = this.rangoFecha();
    if (r === 'todo') return 'Histórico completo';
    if (r === 'hoy') return `Hoy (${fmtFecha(hoyIso())})`;
    if (r === 'mes') {
      const d = new Date();
      return `${MESES_COMPLETOS[d.getMonth() + 1]} ${d.getFullYear()}`;
    }
    if (r === 'año') return `Año ${new Date().getFullYear()}`;
    return `${fmtFecha(this.fechaDesde)} al ${fmtFecha(this.fechaHasta)}`;
  }

  // ── EXPORTACIÓN RESUMEN CONSOLIDADO ───────────────────────────────────────
  async exportarPdfResumen(): Promise<void> {
    if (this.personasFiltradas().length === 0) return;
    this.exportandoPdf.set(true);

    try {
      const datosPdf: ResumenDeudasPdfDatos = {
        generado_en: `${fmtFecha(hoyIso())} ${new Date().toLocaleTimeString('es-PE', { hour: '2-digit', minute: '2-digit' })}`,
        filtro_tipo: this.filtroTipo() === 'todos' ? 'Todos' : this.filtroTipo() === 'socio' ? 'Socios' : 'Inquilinos',
        filtro_estado: this.filtroEstado() === 'con-deuda' ? 'Con deuda' : 'Todos',
        total_personas: this.totalPersonasSegunTipo(),
        personas_con_deuda: this.conDeudaSegunTipo(),
        deuda_socios: this.totalDeudaSocios(),
        deuda_inquilinos: this.totalDeudaInquilinos(),
        total_pendiente: this.totalDeudaVisible(),
        personas: this.personasFiltradas().map(p => ({
          tipo: p.tipo === 'socio' ? 'Socio' : 'Inquilino',
          identificacion: p.dni || '',
          nombre: p.nombre,
          puesto: p.codigo_puesto || '',
          cant_pendientes: p.cant_pendientes,
          total_pendiente: p.deuda_pendiente,
        })),
      };

      await this.pdfSvc.descargarPdfResumenDeudas(datosPdf);
    } catch (e: unknown) {
      this.errorMsg.set(e instanceof Error ? e.message : 'Error al generar el PDF del resumen.');
    } finally {
      this.exportandoPdf.set(false);
    }
  }

  async exportarExcelResumen(): Promise<void> {
    const lista = this.personasFiltradas();
    if (lista.length === 0) return;
    this.exportandoExcel.set(true);

    try {
      const filas = lista.map(p => ({
        'Tipo': p.tipo === 'socio' ? 'Socio' : 'Inquilino',
        'Documento': p.dni || '',
        'Persona': p.nombre,
        'Puesto / Referencia': p.codigo_puesto || '',
        'Obligaciones Pendientes': p.cant_pendientes,
        'Deuda Pendiente (S/)': Math.round(p.deuda_pendiente * 100) / 100,
        'Saldo a Favor (S/)': Math.round(p.saldo_a_favor * 100) / 100,
      }));

      const hojas: HojaExcel[] = [{ nombre: 'Resumen de deudas', filas }];
      const cleanFecha = hoyIso();
      const nombreArchivo = `deudas-${this.filtroTipo()}-${cleanFecha}.xlsx`;
      await this.excelSvc.exportar(nombreArchivo, hojas);
    } catch (e: unknown) {
      this.errorMsg.set(e instanceof Error ? e.message : 'Error al exportar a Excel.');
    } finally {
      this.exportandoExcel.set(false);
    }
  }

  // ── EXPORTACIÓN INDIVIDUAL ────────────────────────────────────────────────
  async exportarPdfIndividual(): Promise<void> {
    const p = this.personaSeleccionada();
    if (!p) return;
    this.exportandoPdf.set(true);

    try {
      const sv = this.subVista();
      const datos: EstadoCuentaIndividualPdfDatos = {
        generado_en: `${fmtFecha(hoyIso())} ${new Date().toLocaleTimeString('es-PE', { hour: '2-digit', minute: '2-digit' })}`,
        tipo_persona: p.tipo === 'socio' ? 'Socio' : 'Inquilino',
        nombre: p.nombre,
        dni: p.dni || '',
        puesto: p.codigo_puesto || '',
        sub_vista: sv,
        periodo_label: sv === 'pendientes' ? 'Obligaciones Pendientes' : this.obtenerPeriodoLabel(),
        saldo_pendiente_actual: p.deuda_pendiente,
        saldo_a_favor: p.saldo_a_favor,
        total_cargos_periodo: this.totalCargosPeriodo(),
        total_pagos_periodo: this.totalPagosPeriodo(),
      };

      if (sv === 'pendientes') {
        datos.filas_pendientes = this.deudasPendientes().map((d: EstadoCuentaDeudaItem) => ({
          periodo: fmtPeriodo(d.periodo_anio, d.periodo_mes),
          concepto: d.concepto,
          puesto: d.codigo_puesto || '',
          monto_original: d.monto,
          ya_pagado: d.ya_pagado,
          saldo_pendiente: d.saldo_pendiente,
        }));
      } else if (sv === 'pagos') {
        datos.filas_pagos = this.pagosFiltrados().map((pg: EstadoCuentaPagoItem) => ({
          fecha: fmtFecha(pg.fecha_pago),
          codigo_transaccion: pg.codigo_transaccion + (pg.anulado ? ' (ANULADO)' : ''),
          metodo_pago: pg.metodo_pago,
          conceptos: pg.detalle.map((dt: { concepto: string; monto_aplicado: number }) => dt.concepto).join(', '),
          comprobante: pg.comprobante || '',
          monto: pg.anulado ? 0 : pg.monto_total,
        }));
      } else {
        datos.filas_completo = this.movimientosLedgerFiltrados().map((m: MovimientoLedger) => ({
          fecha: fmtFecha(m.fecha),
          tipo: m.tipo,
          periodo: m.periodo,
          concepto: m.concepto,
          comprobante: m.comprobante,
          cargo: m.cargo,
          pago: m.pago,
        }));
      }

      await this.pdfSvc.descargarPdfEstadoCuentaIndividual(datos);
    } catch (e: unknown) {
      this.errorMsg.set(e instanceof Error ? e.message : 'Error al generar el PDF del estado de cuenta.');
    } finally {
      this.exportandoPdf.set(false);
    }
  }

  async exportarExcelIndividual(): Promise<void> {
    const p = this.personaSeleccionada();
    if (!p) return;
    this.exportandoExcel.set(true);

    try {
      const sv = this.subVista();
      let filas: Record<string, unknown>[] = [];
      let nombreHoja = 'Estado de cuenta';

      if (sv === 'pendientes') {
        nombreHoja = 'Deudas pendientes';
        filas = this.deudasPendientes().map((d: EstadoCuentaDeudaItem) => ({
          'Período': fmtPeriodo(d.periodo_anio, d.periodo_mes),
          'Concepto': d.concepto,
          'Puesto / Ref': d.codigo_puesto || '',
          'Importe Original (S/)': Math.round(d.monto * 100) / 100,
          'Ya Pagado (S/)': Math.round(d.ya_pagado * 100) / 100,
          'Saldo Pendiente (S/)': Math.round(d.saldo_pendiente * 100) / 100,
        }));
      } else if (sv === 'pagos') {
        nombreHoja = 'Historial de pagos';
        filas = this.pagosFiltrados().map((pg: EstadoCuentaPagoItem) => ({
          'Fecha de Pago': fmtFecha(pg.fecha_pago),
          'Transacción': pg.codigo_transaccion,
          'Método': pg.metodo_pago,
          'Conceptos': pg.detalle.map((dt: { concepto: string; monto_aplicado: number }) => `${dt.concepto} (S/ ${dt.monto_aplicado.toFixed(2)})`).join(', '),
          'Comprobante': pg.comprobante || '',
          'Estado': pg.anulado ? 'ANULADO' : 'Efectivo',
          'Monto Total (S/)': pg.anulado ? 0 : Math.round(pg.monto_total * 100) / 100,
        }));
      } else {
        nombreHoja = 'Movimientos cuenta';
        filas = this.movimientosLedgerFiltrados().map((m: MovimientoLedger) => ({
          'Fecha': fmtFecha(m.fecha),
          'Tipo': m.tipo,
          'Período': m.periodo,
          'Concepto / Detalle': m.concepto,
          'Documento / Referencia': m.comprobante,
          'Cargo (S/)': m.cargo > 0 ? Math.round(m.cargo * 100) / 100 : 0,
          'Pago (S/)': m.pago > 0 ? Math.round(m.pago * 100) / 100 : 0,
        }));
      }

      const hojas: HojaExcel[] = [{ nombre: nombreHoja, filas }];
      const cleanNombre = (p.dni || p.nombre).replace(/[^a-zA-Z0-9-]/g, '_').slice(0, 15);
      const nombreArchivo = `estado-cuenta-${p.tipo}-${cleanNombre}-${hoyIso()}.xlsx`;
      await this.excelSvc.exportar(nombreArchivo, hojas);
    } catch (e: unknown) {
      this.errorMsg.set(e instanceof Error ? e.message : 'Error al exportar a Excel.');
    } finally {
      this.exportandoExcel.set(false);
    }
  }
}
