import { afterNextRender, Component, computed, ElementRef, inject, signal, viewChild } from '@angular/core';
import { ConsultasPublicasService } from '../../core/services/consultas-publicas.service';
import { PdfGeneratorService, ReciboDatos } from '../../core/services/pdf-generator.service';
import { mensajeAmigable } from '../../shared/utils/errores';
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

          <div class="flex flex-col sm:flex-row gap-2">
            <input
              #buscador
              type="text"
              inputmode="search"
              [value]="queryInput()"
              (input)="onQueryInput($event)"
              (keydown.enter)="consultar()"
              placeholder="DNI, nombre o N° de Puesto..."
              class="w-full sm:flex-1 rounded-xl border border-slate-200 px-4 py-3 text-base text-slate-800 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-brand-500/40 focus:border-brand-400 transition"
            />
            <button
              (click)="consultar()"
              [disabled]="buscando()"
              class="w-full sm:w-auto px-5 py-3 bg-brand-500 hover:bg-brand-600 active:bg-brand-700 disabled:opacity-50 disabled:cursor-not-allowed text-white text-sm font-semibold rounded-xl transition shrink-0 flex items-center justify-center gap-2"
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
            <div class="mt-4 flex items-start gap-3 rounded-xl bg-amber-50 border border-amber-300 text-amber-800 text-base px-4 py-3.5">
              <svg class="w-6 h-6 shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9.75 9.75l4.5 4.5m0-4.5l-4.5 4.5M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
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
                  <svg class="w-5 h-5 mr-1.5 shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"/>
                  </svg>
                  LO QUE DEBO
                  @if (deudas().length > 0) {
                    <span class="ml-2 inline-flex items-center justify-center min-w-6 h-6 px-1 rounded-full bg-red-600 text-white text-sm font-bold">
                      {{ deudas().length }}
                    </span>
                  }
                </button>
                <button (click)="tab.set('realizados')" [class]="tabClass('realizados')">
                  <svg class="w-5 h-5 mr-1.5 shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                  </svg>
                  YA PAGADO
                  <span class="ml-1.5 text-sm opacity-70">({{ historial().length }})</span>
                </button>
              </div>

              <!-- Pestaña: Pagos Pendientes -->
              @if (tab() === 'pendientes') {
                @if (deudas().length === 0) {
                  <div class="m-5 flex flex-col items-center gap-3 py-14 rounded-2xl bg-green-50 border-2 border-green-200">
                    <svg class="w-20 h-20 text-green-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    <p class="text-xl font-bold text-green-700">¡Está al día con sus pagos!</p>
                    <p class="text-base text-green-600">No tiene ninguna deuda pendiente.</p>
                  </div>
                } @else {
                  <!-- Banner grande: total adeudado -->
                  <div class="m-5 flex items-center gap-4 rounded-2xl bg-red-50 border-2 border-red-300 px-5 py-4">
                    <svg class="w-12 h-12 shrink-0 text-red-500" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"/>
                    </svg>
                    <div>
                      <p class="text-sm font-bold uppercase tracking-wide text-red-600">Total que debe pagar</p>
                      <p class="text-3xl font-extrabold text-red-700">{{ moneda(totalDeuda()) }}</p>
                      <p class="text-sm text-red-500 mt-0.5">Puede pagar en la oficina de la Cooperativa.</p>
                    </div>
                  </div>

                  <div class="overflow-x-auto">
                    <table class="w-full text-base">
                      <thead class="hidden md:table-header-group">
                        <tr class="bg-slate-50 border-b border-slate-100">
                          <th class="px-5 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wide">Concepto</th>
                          <th class="px-5 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wide">Mes</th>
                          <th class="px-5 py-3 text-right text-xs font-semibold text-slate-500 uppercase tracking-wide">Monto</th>
                        </tr>
                      </thead>
                      <tbody class="hidden md:table-row-group">
                        @for (d of deudas(); track d.monto_id) {
                          <tr class="border-b border-slate-100 hover:bg-red-50/40 transition-colors">
                            <td class="px-5 py-3.5 font-medium text-slate-800">
                              {{ d.concepto }}
                              @if (esAlmacen(d)) {
                                <span class="ml-2" [class]="espacioBadgeClass(d)">
                                  {{ espacioLabel(d) }}
                                </span>
                              }
                            </td>
                            <td class="px-5 py-3.5 text-slate-600 whitespace-nowrap">{{ mesPeriodo(d.periodo_mes, d.periodo_anio) }}</td>
                            <td class="px-5 py-3.5 text-right font-bold text-red-600 whitespace-nowrap">{{ moneda(d.saldo_pendiente) }}</td>
                          </tr>
                        }
                      </tbody>
                      <tfoot>
                        <tr class="bg-red-50 border-t-2 border-red-200">
                          <td colspan="2" class="px-5 py-4 text-right text-base font-bold text-red-700">TOTAL POR PAGAR:</td>
                          <td class="px-5 py-4 text-right font-extrabold text-red-700 text-xl whitespace-nowrap">{{ moneda(totalDeuda()) }}</td>
                        </tr>
                      </tfoot>
                    </table>
                    </table>
                    
                    <!-- Vista Móvil (Tarjetas) -->
                    <div class="md:hidden flex flex-col gap-3 px-5 pb-5 mt-2">
                      @for (d of deudas(); track d.monto_id) {
                        <div class="bg-white border border-slate-200 rounded-xl p-4 shadow-sm flex justify-between items-center">
                          <div>
                            <p class="font-bold text-slate-800 text-base">{{ d.concepto }}</p>
                            <p class="text-sm text-slate-500 mt-0.5">{{ mesPeriodo(d.periodo_mes, d.periodo_anio) }}</p>
                            @if (esAlmacen(d)) {
                              <span class="mt-2 inline-block" [class]="espacioBadgeClass(d)">{{ espacioLabel(d) }}</span>
                            }
                          </div>
                          <div class="text-right">
                            <p class="text-xl font-extrabold text-red-600">{{ moneda(d.saldo_pendiente) }}</p>
                          </div>
                        </div>
                      }
                    </div>

                  </div>
                }
              }

              <!-- Pestaña: Historial de Pagos -->
              @if (tab() === 'realizados') {
                @if (historial().length === 0) {
                  <div class="flex flex-col items-center gap-3 py-16 text-slate-400">
                    <svg class="w-16 h-16" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                    </svg>
                    <p class="text-lg font-semibold text-slate-500">Todavía no hay pagos registrados</p>
                    <p class="text-base">Cuando realice un pago, aparecerá aquí con su recibo.</p>
                  </div>
                } @else {
                  <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                      <thead class="hidden md:table-header-group">
                        <tr class="bg-slate-50 border-b border-slate-100">
                          <th class="px-5 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wide">Fecha</th>
                          <th class="px-5 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wide">Método</th>
                          <th class="px-5 py-3 text-right text-xs font-semibold text-slate-500 uppercase tracking-wide">Monto</th>
                          <th class="px-5 py-3 text-center text-xs font-semibold text-slate-500 uppercase tracking-wide">Recibo</th>
                        </tr>
                      </thead>
                      <tbody class="hidden md:table-row-group">
                        @for (p of historial(); track p.id) {
                          <tr class="border-b border-slate-100 hover:bg-slate-50 transition-colors"
                              [class.opacity-60]="p.anulado">
                            <td class="px-5 py-3 text-slate-600" [class.line-through]="p.anulado">{{ fecha(p.fecha_pago) }}</td>
                            <td class="px-5 py-3 text-slate-600">{{ p.metodo_pago }}</td>
                            <td class="px-5 py-3 text-right font-semibold"
                                [class.text-slate-400]="p.anulado"
                                [class.line-through]="p.anulado"
                                [class.text-slate-800]="!p.anulado">
                              {{ moneda(p.monto_total) }}
                            </td>
                            <td class="px-5 py-3 text-center">
                              @if (!p.anulado) {
                                <button
                                  (click)="abrirReciboPdf(p)"
                                  [disabled]="generandoPdfId() === p.id"
                                  title="Descargar Recibo"
                                  class="text-brand-600 hover:text-brand-800 disabled:opacity-50 transition p-1 rounded hover:bg-brand-50 inline-flex items-center justify-center"
                                >
                                  @if (generandoPdfId() === p.id) {
                                    <svg class="animate-spin h-5 w-5" fill="none" viewBox="0 0 24 24">
                                      <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                                      <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                                    </svg>
                                  } @else {
                                    <svg class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                      <path stroke-linecap="round" stroke-linejoin="round" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                    </svg>
                                  }
                                </button>
                              } @else {
                                <span class="inline-block px-2 py-0.5 rounded-full text-xs font-semibold bg-red-100 text-red-700">
                                  Anulado
                                </span>
                              }
                            </td>
                          </tr>
                        }
                      </tbody>
                    </table>

                    <!-- Vista Móvil (Tarjetas Historial) -->
                    <div class="md:hidden flex flex-col gap-3 px-5 pb-5 mt-2">
                      @for (p of historial(); track p.id) {
                        <div class="bg-white border border-slate-200 rounded-xl p-4 shadow-sm flex justify-between items-center" [class.opacity-60]="p.anulado">
                          <div>
                            <p class="font-bold text-slate-800 text-base" [class.line-through]="p.anulado">{{ p.metodo_pago }}</p>
                            <p class="text-sm text-slate-500">{{ fecha(p.fecha_pago) }}</p>
                            @if (p.anulado) {
                              <span class="mt-2 inline-block px-2 py-0.5 rounded-full text-xs font-semibold bg-red-100 text-red-700">Anulado</span>
                            } @else {
                              <button (click)="abrirReciboPdf(p)" [disabled]="generandoPdfId() === p.id" class="mt-2 text-brand-600 hover:text-brand-800 disabled:opacity-50 transition inline-flex items-center text-sm font-medium">
                                @if (generandoPdfId() === p.id) {
                                  <svg class="animate-spin h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/></svg>
                                  Descargando...
                                } @else {
                                  <svg class="w-4 h-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/></svg>
                                  Ver Recibo
                                }
                              </button>
                            }
                          </div>
                          <div class="text-right">
                            <p class="text-xl font-bold" [ngClass]="p.anulado ? 'text-slate-400 line-through' : 'text-slate-800'">{{ moneda(p.monto_total) }}</p>
                          </div>
                        </div>
                      }
                    </div>

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
  private readonly pdfSvc = inject(PdfGeneratorService);

  private readonly buscador = viewChild<ElementRef<HTMLInputElement>>('buscador');

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
  readonly generandoPdfId = signal<number | null>(null);

  readonly totalDeuda = computed(() =>
    this.deudas().reduce((s, d) => s + d.saldo_pendiente, 0),
  );

  constructor() {
    // El cursor arranca en la barra de búsqueda: el socio escribe su DNI sin tocar el mouse.
    afterNextRender(() => this.buscador()?.nativeElement.focus());
  }

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
        this.error.set('No encontramos deudas ni historial con ese dato. Por favor verifique su DNI, nombre o número de puesto.');
      } else if (res.length === 1) {
        this.resultados.set([]);
        await this.seleccionar(res[0]);
      } else {
        this.resultados.set(res);
      }
    } catch (e) {
      this.error.set(mensajeAmigable(e, 'No pudimos completar la búsqueda. Revise su conexión e intente otra vez.'));
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
      this.error.set(mensajeAmigable(e, 'No pudimos cargar su información. Revise su conexión e intente otra vez.'));
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
    const base = 'flex-1 py-4 text-base font-semibold transition-colors flex items-center justify-center';
    if (this.tab() === nombre) {
      return nombre === 'pendientes'
        ? `${base} text-red-600 border-b-4 border-red-500 bg-red-50`
        : `${base} text-green-700 border-b-4 border-green-500 bg-green-50`;
    }
    return `${base} text-slate-400 hover:text-slate-600 hover:bg-slate-50`;
  }

  tipoBadgeClass(tipo: TipoPagador): string {
    const base = 'px-2 py-0.5 rounded-full text-xs font-semibold';
    return tipo === 'socio'
      ? `${base} bg-blue-100 text-blue-700`
      : `${base} bg-purple-100 text-purple-700`;
  }

  /** True si el cargo pertenece a un Almacén (código distinto al puesto principal). */
  esAlmacen(d: DeudaItem | HistorialItem): boolean {
    return !!d.codigo_puesto && d.codigo_puesto !== this.seleccionado()?.codigo_puesto;
  }

  espacioLabel(d: DeudaItem): string {
    return this.esAlmacen(d) ? `Almacén ${d.codigo_puesto}` : 'Puesto Principal';
  }

  espacioBadgeClass(d: DeudaItem): string {
    const base = 'ml-2 inline-block px-2 py-0.5 rounded-full text-xs font-semibold align-middle';
    return this.esAlmacen(d)
      ? `${base} bg-amber-100 text-amber-700`
      : `${base} bg-blue-100 text-blue-700`;
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

  async abrirReciboPdf(pago: PagoHistorial): Promise<void> {
    const sel = this.seleccionado();
    if (!sel) return;

    this.generandoPdfId.set(pago.id);
    try {
      const datos: ReciboDatos = {
        codigo_transaccion: pago.codigo_transaccion,
        fecha_pago:         new Date(pago.fecha_pago),
        cajero:             'Sistema de Recaudación',
        nombre_pagador:     sel.nombre_completo,
        tipo_pagador:       sel.tipo === 'socio' ? 'Socio titular' : 'Inquilino',
        dni_pagador:        sel.dni,
        codigo_puesto:      pago.codigo_puesto || sel.codigo_puesto,
        metodo_pago:        pago.metodo_pago,
        comprobante:        pago.comprobante,
        observacion:        null,
        detalle: (pago.detalle || []).map(det => ({
          concepto:           det.codigo_puesto && det.codigo_puesto !== (pago.codigo_puesto || sel.codigo_puesto)
            ? `${det.concepto} · ${det.codigo_puesto}`
            : det.concepto,
          periodo:            `${MESES[det.periodo_mes - 1] ?? det.periodo_mes}-${det.periodo_anio}`,
          saldo_original:     det.monto_original,
          aplicado:           det.monto_aplicado,
          cubierto_completo:  det.monto_aplicado >= det.monto_original * 0.99,
        })),
        total_pagado:  pago.monto_total,
        saldo_a_favor: 0,
      };
      await this.pdfSvc.generarYAbrir(datos);
    } catch (e: unknown) {
      console.error(e);
      this.error.set('No pudimos generar el recibo en PDF. Intente nuevamente en un momento.');
    } finally {
      this.generandoPdfId.set(null);
    }
  }
}
