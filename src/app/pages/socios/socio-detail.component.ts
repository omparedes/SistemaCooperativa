import { Component, computed, effect, inject, OnDestroy, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { toSignal } from '@angular/core/rxjs-interop';
import { SociosService } from '../../core/services/socios.service';
import { PagosService } from '../../core/services/pagos.service';
import { PdfGeneratorService, ReciboDatos } from '../../core/services/pdf-generator.service';
import { SocioDetalle } from './socio.model';
import { PagoHistorial } from '../pagos/pago.model';

type Tab = 'puestos' | 'pagos';

const MESES = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Set','Oct','Nov','Dic'] as const;

function formatPeriodo(anio: number, mes: number): string {
  return `${MESES[mes - 1] ?? String(mes)}-${anio}`;
}

@Component({
  selector: 'app-socio-detail',
  standalone: true,
  imports: [CommonModule, RouterModule],
  template: `
    <div class="p-6 max-w-7xl mx-auto">
      <a routerLink="/socios"
        class="inline-flex items-center text-sm text-brand-600 dark:text-brand-400 hover:underline mb-4">
        ← Volver al directorio
      </a>

      @let d = detalle();

      @if (loading()) {
        <div class="bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl p-12 flex items-center justify-center gap-3 text-gray-500 dark:text-gray-400">
          <span class="inline-block h-5 w-5 rounded-full border-2 border-brand-600 border-t-transparent animate-spin"></span>
          Cargando detalle del socio...
        </div>
      } @else if (error()) {
        <div class="p-4 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 text-sm">
          <strong>Error:</strong> {{ error() }}
        </div>
      } @else if (d) {
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

          <!-- ═══════════════════ TARJETA IZQUIERDA: PERFIL ═══════════════════ -->
          <aside class="lg:col-span-1 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-sm p-6">
            <div class="flex flex-col items-center text-center mb-6">
              <div class="w-20 h-20 rounded-full bg-brand-100 dark:bg-brand-900/30 flex items-center justify-center text-2xl font-semibold text-brand-700 dark:text-brand-300 mb-3">
                {{ iniciales() }}
              </div>
              <h2 class="text-xl font-semibold text-gray-900 dark:text-white">{{ d.apellidos }}</h2>
              @if (d.nombres) {
                <p class="text-sm text-gray-500 dark:text-gray-400">{{ d.nombres }}</p>
              }
              @if (d.es_institucional) {
                <span class="mt-2 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-purple-50 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300">
                  Titular institucional
                </span>
              }
            </div>

            <div class="flex items-center justify-center gap-2 mb-6">
              <span [ngClass]="d.estado === 'Activo'
                      ? 'bg-emerald-50 dark:bg-emerald-900/30 text-emerald-700 dark:text-emerald-300'
                      : 'bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300'"
                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium">
                {{ d.estado }}
              </span>
              <span [ngClass]="d.habilitado
                      ? 'bg-emerald-50 dark:bg-emerald-900/30 text-emerald-700 dark:text-emerald-300'
                      : 'bg-amber-50 dark:bg-amber-900/30 text-amber-700 dark:text-amber-300'"
                    class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium">
                {{ d.habilitado ? 'Hábil' : 'Inhábil' }}
              </span>
            </div>

            <dl class="space-y-3 text-sm border-t border-gray-100 dark:border-gray-700 pt-4">
              <div>
                <dt class="text-xs uppercase text-gray-500 dark:text-gray-400 tracking-wide">DNI</dt>
                <dd class="font-mono text-gray-900 dark:text-white">{{ d.dni }}</dd>
              </div>
              <div>
                <dt class="text-xs uppercase text-gray-500 dark:text-gray-400 tracking-wide">Teléfono</dt>
                <dd class="text-gray-900 dark:text-white">{{ d.telefono || '—' }}</dd>
              </div>
              <div>
                <dt class="text-xs uppercase text-gray-500 dark:text-gray-400 tracking-wide">Email</dt>
                <dd class="text-gray-900 dark:text-white break-all">{{ d.email || '—' }}</dd>
              </div>
              <div>
                <dt class="text-xs uppercase text-gray-500 dark:text-gray-400 tracking-wide">Dirección</dt>
                <dd class="text-gray-900 dark:text-white">{{ d.direccion || '—' }}</dd>
              </div>
              <div>
                <dt class="text-xs uppercase text-gray-500 dark:text-gray-400 tracking-wide">Fecha de ingreso</dt>
                <dd class="text-gray-900 dark:text-white">{{ d.fecha_ingreso | date:'dd/MM/yyyy' }}</dd>
              </div>
            </dl>

            <div class="border-t border-gray-100 dark:border-gray-700 mt-4 pt-4">
              <dt class="text-xs uppercase text-gray-500 dark:text-gray-400 tracking-wide mb-2">Puesto vigente</dt>
              @if (d.puesto_vigente; as pv) {
                <div class="flex items-center gap-2">
                  <span class="inline-flex items-center px-3 py-1 rounded-lg text-sm font-semibold bg-brand-50 dark:bg-brand-900/30 text-brand-700 dark:text-brand-300">
                    {{ pv.codigo }}
                  </span>
                  @if (pv.giro) {
                    <span class="text-xs text-gray-500 dark:text-gray-400">· {{ pv.giro }}</span>
                  }
                </div>
              } @else {
                <p class="text-sm text-gray-400 dark:text-gray-500 italic">Sin puesto asignado</p>
              }
            </div>

            <button (click)="irARegistrarPago()"
              [disabled]="!d.puesto_vigente || d.estado === 'Inactivo'"
              class="mt-6 w-full inline-flex items-center justify-center gap-2 px-4 py-2.5 bg-brand-600 hover:bg-brand-700 disabled:bg-gray-300 dark:disabled:bg-gray-700 disabled:cursor-not-allowed text-white rounded-lg font-medium shadow-sm transition">
              💰 Registrar Pago
            </button>
            @if (!d.puesto_vigente) {
              <p class="mt-2 text-xs text-center text-gray-500 dark:text-gray-400">
                Asigna un puesto antes de registrar pagos.
              </p>
            } @else if (d.estado === 'Inactivo') {
              <p class="mt-2 text-xs text-center text-amber-600 dark:text-amber-400">
                Socio Inactivo: no genera nuevos cobros.
              </p>
            }
          </aside>

          <!-- ═══════════════════ TARJETA DERECHA: TABS ═══════════════════════ -->
          <section class="lg:col-span-2 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-sm">
            <div class="border-b border-gray-200 dark:border-gray-700 px-4">
              <nav class="flex gap-1" role="tablist">
                <button (click)="tab.set('puestos')" role="tab"
                  [ngClass]="tab() === 'puestos'
                    ? 'text-brand-600 dark:text-brand-400 border-brand-600 dark:border-brand-400'
                    : 'text-gray-500 border-transparent'"
                  class="px-4 py-3 -mb-px border-b-2 font-medium text-sm transition hover:text-brand-600 dark:hover:text-brand-400">
                  Historial de Puestos
                  <span class="ml-1.5 inline-flex items-center justify-center px-2 py-0.5 rounded-full text-xs bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300">
                    {{ d.titularidades.length }}
                  </span>
                </button>

                <button (click)="tab.set('pagos')" role="tab"
                  [ngClass]="tab() === 'pagos'
                    ? 'text-brand-600 dark:text-brand-400 border-brand-600 dark:border-brand-400'
                    : 'text-gray-500 border-transparent'"
                  class="px-4 py-3 -mb-px border-b-2 font-medium text-sm transition hover:text-brand-600 dark:hover:text-brand-400">
                  Historial de Pagos
                  @if (historialLoading()) {
                    <span class="ml-1.5 inline-block h-3 w-3 rounded-full border border-brand-400 border-t-transparent animate-spin align-middle"></span>
                  } @else if (historial().length > 0) {
                    <span class="ml-1.5 inline-flex items-center justify-center px-2 py-0.5 rounded-full text-xs bg-brand-100 dark:bg-brand-900/40 text-brand-600 dark:text-brand-300">
                      {{ historial().length }}
                    </span>
                  }
                </button>
              </nav>
            </div>

            <div class="p-4">
              <!-- ─── TAB: PUESTOS ─────────────────────────────────────────── -->
              @if (tab() === 'puestos') {
                @if (d.titularidades.length === 0) {
                  <p class="py-12 text-center text-gray-500 dark:text-gray-400">
                    Este socio nunca ha tenido un puesto asignado.
                  </p>
                } @else {
                  <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                      <thead class="bg-gray-50 dark:bg-gray-900/50 text-gray-600 dark:text-gray-400 uppercase text-xs">
                        <tr>
                          <th class="px-3 py-2.5 text-left font-medium">Puesto</th>
                          <th class="px-3 py-2.5 text-left font-medium">Giro</th>
                          <th class="px-3 py-2.5 text-left font-medium">Inicio</th>
                          <th class="px-3 py-2.5 text-left font-medium">Fin</th>
                          <th class="px-3 py-2.5 text-left font-medium">Motivo</th>
                          <th class="px-3 py-2.5 text-center font-medium">Estado</th>
                        </tr>
                      </thead>
                      <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                        @for (t of d.titularidades; track t.id) {
                          <tr [ngClass]="t.vigente ? 'bg-emerald-50/40 dark:bg-emerald-900/10' : ''">
                            <td class="px-3 py-2.5">
                              <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-semibold bg-brand-50 dark:bg-brand-900/30 text-brand-700 dark:text-brand-300">
                                {{ t.puesto.codigo }}
                              </span>
                            </td>
                            <td class="px-3 py-2.5 text-gray-600 dark:text-gray-300 text-xs">{{ t.puesto.giro || '—' }}</td>
                            <td class="px-3 py-2.5 text-gray-700 dark:text-gray-300 whitespace-nowrap">{{ t.fecha_inicio | date:'dd/MM/yyyy' }}</td>
                            <td class="px-3 py-2.5 text-gray-700 dark:text-gray-300 whitespace-nowrap">{{ t.fecha_fin ? (t.fecha_fin | date:'dd/MM/yyyy') : '—' }}</td>
                            <td class="px-3 py-2.5 text-gray-600 dark:text-gray-400 text-xs">{{ t.motivo_cambio || '—' }}</td>
                            <td class="px-3 py-2.5 text-center">
                              @if (t.vigente) {
                                <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-emerald-50 dark:bg-emerald-900/30 text-emerald-700 dark:text-emerald-300">Vigente</span>
                              } @else {
                                <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300">Cerrada</span>
                              }
                            </td>
                          </tr>
                        }
                      </tbody>
                    </table>
                  </div>
                }

              <!-- ─── TAB: PAGOS ────────────────────────────────────────────── -->
              } @else {
                @if (historialLoading()) {
                  <div class="py-12 flex items-center justify-center gap-3 text-gray-400 dark:text-gray-500">
                    <span class="inline-block h-4 w-4 rounded-full border-2 border-brand-500 border-t-transparent animate-spin"></span>
                    Cargando historial de pagos...
                  </div>

                } @else if (historialError()) {
                  <div class="p-3 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-700 dark:text-red-300 text-sm">
                    {{ historialError() }}
                  </div>

                } @else if (historial().length === 0) {
                  <div class="py-16 flex flex-col items-center text-center text-gray-500 dark:text-gray-400">
                    <svg class="h-12 w-12 mb-3 opacity-30" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                    <p class="font-medium text-gray-700 dark:text-gray-300">Sin pagos registrados</p>
                    <p class="text-sm mt-1">Los recibos de este socio aparecerán aquí.</p>
                  </div>

                } @else {
                  <!-- Indicador de Realtime -->
                  <div class="mb-3 flex items-center gap-1.5 text-xs text-gray-400 dark:text-gray-500">
                    <span class="inline-block h-2 w-2 rounded-full bg-green-400 animate-pulse"></span>
                    Actualización en tiempo real activa
                  </div>

                  <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                      <thead class="bg-gray-50 dark:bg-gray-900/50 text-gray-600 dark:text-gray-400 uppercase text-xs">
                        <tr>
                          <th class="px-3 py-2.5 text-left font-medium">Fecha / Hora</th>
                          <th class="px-3 py-2.5 text-left font-medium">Código</th>
                          <th class="px-3 py-2.5 text-right font-medium">Monto</th>
                          <th class="px-3 py-2.5 text-center font-medium">Método</th>
                          <th class="px-3 py-2.5 text-center font-medium">Conceptos</th>
                          <th class="px-3 py-2.5"></th>
                        </tr>
                      </thead>
                      <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                        @for (p of historial(); track p.id) {
                          <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/60 transition">
                            <td class="px-3 py-2.5 text-xs text-gray-600 dark:text-gray-400 whitespace-nowrap">
                              {{ p.fecha_pago | date:'dd/MM/yyyy HH:mm' }}
                            </td>
                            <td class="px-3 py-2.5">
                              <span class="font-mono text-xs text-brand-600 dark:text-brand-400 whitespace-nowrap">
                                {{ p.codigo_transaccion }}
                              </span>
                            </td>
                            <td class="px-3 py-2.5 text-right font-semibold text-gray-900 dark:text-white tabular-nums whitespace-nowrap">
                              S/ {{ p.monto_total.toFixed(2) }}
                            </td>
                            <td class="px-3 py-2.5 text-center">
                              @if (p.metodo_pago === 'Efectivo') {
                                <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-50 dark:bg-green-900/30 text-green-700 dark:text-green-300">
                                  Efectivo
                                </span>
                              } @else {
                                <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-blue-50 dark:bg-blue-900/30 text-blue-700 dark:text-blue-300">
                                  Transferencia
                                </span>
                              }
                            </td>
                            <td class="px-3 py-2.5 text-center">
                              <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300">
                                {{ p.detalle.length }} {{ p.detalle.length === 1 ? 'concepto' : 'conceptos' }}
                              </span>
                            </td>
                            <td class="px-3 py-2.5 text-right">
                              <button
                                (click)="abrirReciboPdf(p)"
                                [disabled]="generandoPdfId() === p.id"
                                title="Abrir recibo PDF"
                                class="inline-flex items-center gap-1 px-2.5 py-1.5 rounded-lg border border-gray-200 dark:border-gray-600 text-gray-500 dark:text-gray-400 hover:border-brand-400 hover:text-brand-600 dark:hover:text-brand-400 transition disabled:opacity-40 text-xs">
                                @if (generandoPdfId() === p.id) {
                                  <svg class="h-3.5 w-3.5 animate-spin" fill="none" viewBox="0 0 24 24">
                                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                                  </svg>
                                } @else {
                                  <svg class="h-3.5 w-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"/>
                                  </svg>
                                }
                                PDF
                              </button>
                            </td>
                          </tr>
                        }
                      </tbody>
                    </table>
                  </div>
                }
              }
            </div>
          </section>
        </div>
      } @else {
        <p class="text-gray-500 dark:text-gray-400">Selecciona un socio.</p>
      }
    </div>
  `,
})
export class SocioDetailComponent implements OnDestroy {
  private readonly route      = inject(ActivatedRoute);
  private readonly router     = inject(Router);
  private readonly svc        = inject(SociosService);
  private readonly pagosSvc   = inject(PagosService);
  private readonly pdfSvc     = inject(PdfGeneratorService);

  private readonly idParam = toSignal(this.route.paramMap, { initialValue: null });

  readonly socioId = computed<number | null>(() => {
    const p = this.idParam();
    if (!p) return null;
    const n = Number(p.get('id'));
    return Number.isFinite(n) ? n : null;
  });

  readonly detalle         = signal<SocioDetalle | null>(null);
  readonly loading         = signal(false);
  readonly error           = signal<string | null>(null);
  readonly tab             = signal<Tab>('puestos');
  readonly historial       = signal<PagoHistorial[]>([]);
  readonly historialLoading = signal(false);
  readonly historialError  = signal<string | null>(null);
  readonly generandoPdfId  = signal<number | null>(null);

  readonly iniciales = computed(() => {
    const d = this.detalle();
    if (!d) return '?';
    return `${d.apellidos} ${d.nombres}`.trim()
      .split(/\s+/).filter(p => p.length > 0).slice(0, 2)
      .map(p => p[0].toUpperCase()).join('') || '?';
  });

  private cleanupRealtime: (() => void) | null = null;

  constructor() {
    effect(() => {
      const id = this.socioId();
      if (id !== null) {
        // Cancela suscripción previa si el usuario navega entre fichas
        this.cleanupRealtime?.();
        this.cleanupRealtime = null;
        void this.cargar(id);
      }
    });
  }

  ngOnDestroy(): void {
    this.cleanupRealtime?.();
  }

  private async cargar(id: number): Promise<void> {
    this.loading.set(true);
    this.detalle.set(null);
    this.error.set(null);
    this.tab.set('puestos');
    this.historial.set([]);
    try {
      // Carga en paralelo: detalle del socio + historial de pagos
      const [det] = await Promise.all([
        this.svc.cargarDetalle(id),
        this.cargarHistorial(id),
      ]);
      this.detalle.set(det);

      // Suscripción Realtime: recarga el historial ante nuevos INSERT en pagos
      this.cleanupRealtime = this.pagosSvc.suscribirCambiosDePagos(
        id, 'socio', () => void this.cargarHistorial(id),
      );
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar el detalle');
      // Si cargarDetalle falla antes de que cargarHistorial resuelva,
      // garantizamos que el spinner del tab no quede colgado.
      this.historialLoading.set(false);
    } finally {
      this.loading.set(false);
    }
  }

  private async cargarHistorial(id: number): Promise<void> {
    this.historialLoading.set(true);
    this.historialError.set(null);
    try {
      const lista = await this.pagosSvc.obtenerHistorialPorPagador(id, 'socio');
      this.historial.set(lista);
    } catch (e: unknown) {
      this.historialError.set(e instanceof Error ? e.message : 'Error al cargar historial');
    } finally {
      this.historialLoading.set(false);
    }
  }

  irARegistrarPago(): void {
    void this.router.navigate(['/pagos/registrar']);
  }

  async abrirReciboPdf(pago: PagoHistorial): Promise<void> {
    const d = this.detalle();
    if (!d) return;

    this.generandoPdfId.set(pago.id);
    try {
      const datos: ReciboDatos = {
        codigo_transaccion: pago.codigo_transaccion,
        fecha_pago:         new Date(pago.fecha_pago),
        cajero:             'Sistema de Recaudación',
        nombre_pagador:     `${d.apellidos}, ${d.nombres}`,
        tipo_pagador:       'Socio titular',
        dni_pagador:        d.dni,
        codigo_puesto:      pago.codigo_puesto,
        metodo_pago:        pago.metodo_pago,
        comprobante:        pago.comprobante,
        detalle: pago.detalle.map(det => ({
          concepto:           det.concepto,
          periodo:            formatPeriodo(det.periodo_anio, det.periodo_mes),
          saldo_original:     det.monto_original,
          aplicado:           det.monto_aplicado,
          // Aproximación: si aplicado >= original el concepto quedó cancelado.
          // Casos de pago parcial previo pueden subestimar esto, pero los montos son exactos.
          cubierto_completo:  det.monto_aplicado >= det.monto_original * 0.99,
        })),
        total_pagado:  pago.monto_total,
        saldo_a_favor: 0,
      };
      await this.pdfSvc.generarYAbrir(datos);
    } catch (e: unknown) {
      this.historialError.set(
        `No se pudo generar el PDF: ${e instanceof Error ? e.message : 'error desconocido'}`,
      );
    } finally {
      this.generandoPdfId.set(null);
    }
  }
}
