import { Component, computed, inject, signal } from '@angular/core';
import { ConsultasPublicasService } from '../../core/services/consultas-publicas.service';
import type { BusquedaResultado, DeudaItem, PagoHistorial, TipoPagador } from '../pagos/pago.model';

type TabActiva = 'pendientes' | 'realizados';

const MESES: ReadonlyArray<string> = [
  'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
  'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic',
];

@Component({
  selector: 'app-consultas',
  standalone: true,
  imports: [],
  template: `
    <div class="min-h-screen bg-gradient-to-br from-slate-50 via-blue-50 to-indigo-50 flex flex-col">

      <!-- Header -->
      <header class="bg-white/80 backdrop-blur-sm border-b border-slate-200 sticky top-0 z-10">
        <div class="max-w-5xl mx-auto px-4 sm:px-6 py-4 flex items-center gap-3">
          <div class="w-10 h-10 rounded-xl bg-brand-500 flex items-center justify-center text-white font-bold text-sm shrink-0">
            CP
          </div>
          <div>
            <p class="font-bold text-slate-800 leading-tight text-sm sm:text-base">Cooperativa Primero de Mayo</p>
            <p class="text-xs text-slate-500">Portal de Consultas — Deudas y Pagos</p>
          </div>
        </div>
      </header>

      <!-- Main -->
      <main class="flex-1 flex flex-col items-center px-4 py-8 sm:py-12 gap-5">

        <!-- Buscar -->
        <div class="w-full max-w-xl bg-white rounded-2xl shadow-md border border-slate-100 p-6 sm:p-8">
          <h1 class="text-xl sm:text-2xl font-bold text-slate-800 mb-1">Consulta tu Estado de Cuenta</h1>
          <p class="text-slate-500 text-sm mb-6">Ingresa tu DNI, nombre o número de puesto.</p>

          <div class="flex gap-2">
            <input
              type="text"
              [value]="queryInput()"
              (input)="onQueryInput($event)"
              (keydown.enter)="consultar()"
              placeholder="DNI, nombre o N° de Puesto..."
              class="flex-1 rounded-xl border border-slate-200 px-4 py-3 text-sm text-slate-800 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-brand-500/40 focus:border-brand-400 transition"
            />
            <button
              (click)="consultar()"
              [disabled]="buscando()"
              class="px-5 py-3 bg-brand-500 hover:bg-brand-600 active:bg-brand-700 disabled:opacity-50 disabled:cursor-not-allowed text-white text-sm font-semibold rounded-xl transition shrink-0 flex items-center gap-2"
            >
              @if (buscando()) {
                <svg class="animate-spin w-4 h-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                </svg>
                Buscando
              } @else {
                Consultar
              }
            </button>
          </div>

          @if (error()) {
            <div class="mt-4 flex items-start gap-2 rounded-xl bg-red-50 border border-red-200 text-red-700 text-sm px-4 py-3">
              <svg class="w-4 h-4 mt-0.5 shrink-0" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
              </svg>
              {{ error() }}
            </div>
          }
        </div>

        <!-- Múltiples resultados -->
        @if (resultados().length > 1) {
          <div class="w-full max-w-xl bg-white rounded-2xl shadow-md border border-slate-100 p-6">
            <p class="text-xs font-semibold text-slate-500 uppercase tracking-wide mb-3">
              {{ resultados().length }} resultados — seleccione uno
            </p>
            <div class="flex flex-col gap-2">
              @for (r of resultados(); track r.puesto_id) {
                <button
                  (click)="seleccionar(r)"
                  class="flex items-center justify-between px-4 py-3 rounded-xl border border-slate-200 hover:border-brand-400 hover:bg-brand-50 transition text-left group"
                >
                  <div>
                    <p class="font-semibold text-slate-800 text-sm group-hover:text-brand-700 transition">{{ r.nombre_completo }}</p>
                    <p class="text-xs text-slate-500 mt-0.5">DNI: {{ r.dni }}</p>
                  </div>
                  <div class="flex flex-col items-end gap-1 shrink-0 ml-4">
                    <span [class]="tipoBadgeClass(r.tipo)">
                      {{ r.tipo === 'socio' ? 'Socio' : 'Inquilino' }}
                    </span>
                    <span class="text-xs text-slate-400">Puesto {{ r.codigo_puesto }}</span>
                  </div>
                </button>
              }
            </div>
          </div>
        }

        <!-- Datos del seleccionado -->
        @if (seleccionado(); as persona) {

          <!-- Tarjeta de identidad -->
          <div class="w-full max-w-4xl bg-white rounded-2xl shadow-md border border-slate-100 p-5 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
            <div class="flex items-center gap-4">
              <div class="w-12 h-12 rounded-full bg-gradient-to-br from-brand-400 to-brand-600 flex items-center justify-center text-white font-bold text-lg shrink-0">
                {{ persona.nombre_completo.charAt(0) }}
              </div>
              <div>
                <p class="font-bold text-slate-800">{{ persona.nombre_completo }}</p>
                <p class="text-sm text-slate-500 mt-0.5 flex flex-wrap items-center gap-x-1.5 gap-y-1">
                  <span>DNI: {{ persona.dni }}</span>
                  <span class="text-slate-300">·</span>
                  <span>Puesto: <strong class="text-slate-700">{{ persona.codigo_puesto }}</strong></span>
                  <span class="text-slate-300">·</span>
                  <span [class]="tipoBadgeClass(persona.tipo)">
                    {{ persona.tipo === 'socio' ? 'Socio' : 'Inquilino' }}
                  </span>
                </p>
              </div>
            </div>
            <button
              (click)="limpiar()"
              class="text-sm text-slate-400 hover:text-brand-600 transition flex items-center gap-1.5 shrink-0"
            >
              <svg class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
              </svg>
              Nueva consulta
            </button>
          </div>

          @if (cargando()) {
            <div class="flex flex-col items-center gap-3 py-12">
              <svg class="animate-spin w-10 h-10 text-brand-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
              </svg>
              <p class="text-sm text-slate-500">Cargando información...</p>
            </div>
          } @else {

            <!-- Tabs -->
            <div class="w-full max-w-4xl bg-white rounded-2xl shadow-md border border-slate-100 overflow-hidden">

              <!-- Cabeceras de pestañas -->
              <div class="flex border-b border-slate-200">
                <button (click)="tab.set('pendientes')" [class]="tabClass('pendientes')">
                  Pagos Pendientes
                  @if (deudas().length > 0) {
                    <span class="ml-2 inline-flex items-center justify-center w-5 h-5 rounded-full bg-red-500 text-white text-xs font-bold">
                      {{ deudas().length }}
                    </span>
                  }
                </button>
                <button (click)="tab.set('realizados')" [class]="tabClass('realizados')">
                  Historial de Pagos
                  <span class="ml-1.5 text-xs opacity-60">({{ historial().length }})</span>
                </button>
              </div>

              <!-- Pestaña: Pagos Pendientes -->
              @if (tab() === 'pendientes') {
                @if (deudas().length === 0) {
                  <div class="flex flex-col items-center gap-2 py-16 text-slate-400">
                    <svg class="w-12 h-12 text-green-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    <p class="text-sm font-semibold text-green-700">¡Al día con sus pagos!</p>
                    <p class="text-xs">No tiene saldos pendientes.</p>
                  </div>
                } @else {
                  <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                      <thead>
                        <tr class="bg-slate-50 border-b border-slate-100">
                          <th class="px-5 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wide">Concepto</th>
                          <th class="px-5 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wide">Período</th>
                          <th class="px-5 py-3 text-right text-xs font-semibold text-slate-500 uppercase tracking-wide">Monto</th>
                          <th class="px-5 py-3 text-right text-xs font-semibold text-slate-500 uppercase tracking-wide">Ya Pagado</th>
                          <th class="px-5 py-3 text-right text-xs font-semibold text-slate-500 uppercase tracking-wide">Saldo</th>
                        </tr>
                      </thead>
                      <tbody>
                        @for (d of deudas(); track d.monto_id) {
                          <tr class="border-b border-slate-100 hover:bg-slate-50 transition-colors">
                            <td class="px-5 py-3 font-medium text-slate-800">{{ d.concepto }}</td>
                            <td class="px-5 py-3 text-slate-600">{{ mesPeriodo(d.periodo_mes, d.periodo_anio) }}</td>
                            <td class="px-5 py-3 text-right text-slate-600">{{ moneda(d.monto_original) }}</td>
                            <td class="px-5 py-3 text-right text-green-600">{{ moneda(d.ya_pagado) }}</td>
                            <td class="px-5 py-3 text-right font-bold text-red-600">{{ moneda(d.saldo_pendiente) }}</td>
                          </tr>
                        }
                      </tbody>
                      <tfoot>
                        <tr class="bg-slate-50 border-t-2 border-slate-200">
                          <td colspan="4" class="px-5 py-3 text-right text-sm font-semibold text-slate-700">Total por pagar:</td>
                          <td class="px-5 py-3 text-right font-bold text-red-700 text-base">{{ moneda(totalDeuda()) }}</td>
                        </tr>
                      </tfoot>
                    </table>
                  </div>
                }
              }

              <!-- Pestaña: Historial de Pagos -->
              @if (tab() === 'realizados') {
                @if (historial().length === 0) {
                  <div class="flex flex-col items-center gap-2 py-16 text-slate-400">
                    <svg class="w-12 h-12" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                    </svg>
                    <p class="text-sm font-medium">Sin pagos registrados</p>
                  </div>
                } @else {
                  <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                      <thead>
                        <tr class="bg-slate-50 border-b border-slate-100">
                          <th class="px-5 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wide">Fecha</th>
                          <th class="px-5 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wide">N° Transacción</th>
                          <th class="px-5 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wide">Método</th>
                          <th class="px-5 py-3 text-right text-xs font-semibold text-slate-500 uppercase tracking-wide">Monto</th>
                          <th class="px-5 py-3 text-center text-xs font-semibold text-slate-500 uppercase tracking-wide">Estado</th>
                        </tr>
                      </thead>
                      <tbody>
                        @for (p of historial(); track p.id) {
                          <tr class="border-b border-slate-100 hover:bg-slate-50 transition-colors"
                              [class.opacity-60]="p.anulado">
                            <td class="px-5 py-3 text-slate-600" [class.line-through]="p.anulado">{{ fecha(p.fecha_pago) }}</td>
                            <td class="px-5 py-3 font-mono text-xs text-slate-700" [class.line-through]="p.anulado">{{ p.codigo_transaccion }}</td>
                            <td class="px-5 py-3 text-slate-600">{{ p.metodo_pago }}</td>
                            <td class="px-5 py-3 text-right font-semibold"
                                [class.text-slate-400]="p.anulado"
                                [class.line-through]="p.anulado"
                                [class.text-slate-800]="!p.anulado">
                              {{ moneda(p.monto_total) }}
                            </td>
                            <td class="px-5 py-3 text-center">
                              @if (p.anulado) {
                                <span class="inline-block px-2 py-0.5 rounded-full text-xs font-semibold bg-red-100 text-red-700">
                                  ANULADO
                                </span>
                              } @else {
                                <span class="inline-block px-2 py-0.5 rounded-full text-xs font-semibold bg-green-100 text-green-700">
                                  Pagado
                                </span>
                              }
                            </td>
                          </tr>
                        }
                      </tbody>
                    </table>
                  </div>
                }
              }

            </div>
          }
        }

      </main>

      <!-- Footer -->
      <footer class="py-6 text-center text-xs text-slate-400 border-t border-slate-200">
        Cooperativa Primero de Mayo &copy; {{ currentYear }} — Portal de Consultas
      </footer>

    </div>
  `,
})
export class ConsultasComponent {
  private readonly pagosSvc = inject(ConsultasPublicasService);

  readonly currentYear = new Date().getFullYear();

  readonly queryInput = signal('');
  readonly buscando = signal(false);
  readonly cargando = signal(false);
  readonly error = signal<string | null>(null);
  readonly resultados = signal<BusquedaResultado[]>([]);
  readonly seleccionado = signal<BusquedaResultado | null>(null);
  readonly deudas = signal<DeudaItem[]>([]);
  readonly historial = signal<PagoHistorial[]>([]);
  readonly tab = signal<TabActiva>('pendientes');

  readonly totalDeuda = computed(() =>
    this.deudas().reduce((s, d) => s + d.saldo_pendiente, 0),
  );

  onQueryInput(event: Event): void {
    this.queryInput.set((event.target as HTMLInputElement).value);
  }

  async consultar(): Promise<void> {
    const q = this.queryInput().trim();
    if (!q || this.buscando()) return;

    this.error.set(null);
    this.seleccionado.set(null);
    this.deudas.set([]);
    this.historial.set([]);
    this.buscando.set(true);

    try {
      const res = await this.pagosSvc.buscarPagador(q);
      if (res.length === 0) {
        this.resultados.set([]);
        this.error.set('No se encontró ningún socio o puesto con ese criterio.');
      } else if (res.length === 1) {
        this.resultados.set([]);
        await this.seleccionar(res[0]);
      } else {
        this.resultados.set(res);
      }
    } catch (e) {
      this.error.set(e instanceof Error ? e.message : 'Error al buscar. Intente nuevamente.');
    } finally {
      this.buscando.set(false);
    }
  }

  async seleccionar(r: BusquedaResultado): Promise<void> {
    this.seleccionado.set(r);
    this.resultados.set([]);
    this.cargando.set(true);
    this.error.set(null);

    try {
      const [deudas, historial] = await Promise.all([
        this.pagosSvc.cargarDeudasPuesto(r.puesto_id, r.persona_id, r.tipo),
        this.pagosSvc.obtenerHistorialPorPagador(r.persona_id, r.tipo),
      ]);
      this.deudas.set(deudas);
      this.historial.set(historial);
      this.tab.set('pendientes');
    } catch (e) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar los datos.');
    } finally {
      this.cargando.set(false);
    }
  }

  limpiar(): void {
    this.queryInput.set('');
    this.resultados.set([]);
    this.seleccionado.set(null);
    this.deudas.set([]);
    this.historial.set([]);
    this.error.set(null);
  }

  tabClass(nombre: TabActiva): string {
    const base = 'flex-1 py-4 text-sm transition-colors flex items-center justify-center';
    return this.tab() === nombre
      ? `${base} font-semibold text-brand-600 border-b-2 border-brand-500 bg-brand-50`
      : `${base} text-slate-500 hover:text-slate-700 hover:bg-slate-50`;
  }

  tipoBadgeClass(tipo: TipoPagador): string {
    const base = 'px-2 py-0.5 rounded-full text-xs font-semibold';
    return tipo === 'socio'
      ? `${base} bg-blue-100 text-blue-700`
      : `${base} bg-purple-100 text-purple-700`;
  }

  mesPeriodo(mes: number, anio: number): string {
    return `${MESES[mes - 1] ?? '?'} ${anio}`;
  }

  fecha(iso: string): string {
    return new Date(iso).toLocaleDateString('es-PE', {
      day: '2-digit', month: 'short', year: 'numeric',
    });
  }

  moneda(monto: number): string {
    return new Intl.NumberFormat('es-PE', { style: 'currency', currency: 'PEN' }).format(monto);
  }
}
