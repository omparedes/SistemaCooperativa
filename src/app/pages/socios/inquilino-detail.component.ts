import { Component, computed, effect, inject, OnDestroy, signal } from '@angular/core';
import { DatePipe, DecimalPipe, NgClass } from '@angular/common';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { toSignal } from '@angular/core/rxjs-interop';
import { InquilinosService } from '../../core/services/inquilinos.service';
import { PagosService } from '../../core/services/pagos.service';
import { PdfGeneratorService, ReciboDatos } from '../../core/services/pdf-generator.service';
import { AuthService } from '../../core/services/auth.service';
import { InquilinoDetalle } from './inquilino.model';
import { DNI_INSTITUCIONAL } from './socio.model';
import { PagoHistorial } from '../pagos/pago.model';

type Tab = 'arriendos' | 'pagos';

const MESES = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Set','Oct','Nov','Dic'] as const;

function formatPeriodo(anio: number, mes: number): string {
  return `${MESES[mes - 1] ?? String(mes)}-${anio}`;
}

const MOTIVOS_ANULACION = [
  'Monto incorrecto',
  'Error de persona',
  'Transferencia errónea',
  'Yape falso',
  'Otro (especificar)',
] as const;

@Component({
  selector: 'app-inquilino-detail',
  standalone: true,
  imports: [NgClass, DatePipe, DecimalPipe, RouterModule],
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
          Cargando detalle del inquilino...
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
              <div class="w-20 h-20 rounded-full bg-amber-100 dark:bg-amber-900/30 flex items-center justify-center text-2xl font-semibold text-amber-700 dark:text-amber-300 mb-3">
                {{ iniciales() }}
              </div>
              <h2 class="text-xl font-semibold text-gray-900 dark:text-white">{{ d.apellidos }}</h2>
              @if (d.nombres) {
                <p class="text-sm text-gray-500 dark:text-gray-400">{{ d.nombres }}</p>
              }
              <span class="mt-2 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-amber-50 dark:bg-amber-900/30 text-amber-700 dark:text-amber-300">
                Inquilino · posesionario
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
            </dl>

            <div class="border-t border-gray-100 dark:border-gray-700 mt-4 pt-4">
              <dt class="text-xs uppercase text-gray-500 dark:text-gray-400 tracking-wide mb-2">Arriendo vigente</dt>
              @if (d.arriendo_vigente; as av) {
                <div class="space-y-2">
                  <div class="flex items-center gap-2">
                    <span class="inline-flex items-center px-3 py-1 rounded-lg text-sm font-semibold bg-brand-50 dark:bg-brand-900/30 text-brand-700 dark:text-brand-300">
                      {{ av.puesto.codigo }}
                    </span>
                    @if (av.monto_arriendo) {
                      <span class="text-sm text-gray-700 dark:text-gray-300 tabular-nums">
                        S/ {{ av.monto_arriendo | number:'1.2-2' }}/mes
                      </span>
                    }
                  </div>
                  <div class="text-xs text-gray-500 dark:text-gray-400">Desde {{ av.fecha_inicio | date:'dd/MM/yyyy' }}</div>
                  @if (av.titular) {
                    <div class="text-xs text-gray-500 dark:text-gray-400">
                      Titular:
                      @if (av.titular.dni === DNI_COOP) {
                        <span class="inline-flex items-center px-1.5 py-0.5 rounded text-xs font-medium bg-purple-50 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300">
                          Cooperativa
                        </span>
                      } @else {
                        <span>{{ av.titular.apellidos }}</span>
                      }
                    </div>
                  }
                </div>
              } @else {
                <p class="text-sm text-gray-400 dark:text-gray-500 italic">Sin arriendo activo</p>
              }
            </div>

            <button (click)="irARegistrarPago()"
              [disabled]="!d.arriendo_vigente"
              class="mt-6 w-full inline-flex items-center justify-center gap-2 px-4 py-2.5 bg-brand-600 hover:bg-brand-700 disabled:bg-gray-300 dark:disabled:bg-gray-700 disabled:cursor-not-allowed text-white rounded-lg font-medium shadow-sm transition">
              💰 Registrar Pago
            </button>
            @if (!d.arriendo_vigente) {
              <p class="mt-2 text-xs text-center text-gray-500 dark:text-gray-400">
                Sin arriendo vigente: no se pueden registrar pagos.
              </p>
            }
          </aside>

          <!-- ═══════════════════ TARJETA DERECHA: TABS ═══════════════════════ -->
          <section class="lg:col-span-2 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl shadow-sm">
            <div class="border-b border-gray-200 dark:border-gray-700 px-4">
              <nav class="flex gap-1" role="tablist">
                <button (click)="tab.set('arriendos')" role="tab"
                  [ngClass]="tab() === 'arriendos'
                    ? 'text-brand-600 dark:text-brand-400 border-brand-600 dark:border-brand-400'
                    : 'text-gray-500 border-transparent'"
                  class="px-4 py-3 -mb-px border-b-2 font-medium text-sm transition hover:text-brand-600 dark:hover:text-brand-400">
                  Historial de Arriendos
                  <span class="ml-1.5 inline-flex items-center justify-center px-2 py-0.5 rounded-full text-xs bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300">
                    {{ d.arriendos.length }}
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
              <!-- ─── TAB: ARRIENDOS ────────────────────────────────────────── -->
              @if (tab() === 'arriendos') {
                @if (d.arriendos.length === 0) {
                  <p class="py-12 text-center text-gray-500 dark:text-gray-400">
                    Este inquilino no tiene arriendos registrados.
                  </p>
                } @else {
                  <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                      <thead class="bg-gray-50 dark:bg-gray-900/50 text-gray-600 dark:text-gray-400 uppercase text-xs">
                        <tr>
                          <th class="px-3 py-2.5 text-left font-medium">Puesto</th>
                          <th class="px-3 py-2.5 text-left font-medium">Titular</th>
                          <th class="px-3 py-2.5 text-right font-medium">Monto/mes</th>
                          <th class="px-3 py-2.5 text-left font-medium">Inicio</th>
                          <th class="px-3 py-2.5 text-left font-medium">Fin</th>
                          <th class="px-3 py-2.5 text-left font-medium">Motivo término</th>
                          <th class="px-3 py-2.5 text-center font-medium">Estado</th>
                        </tr>
                      </thead>
                      <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                        @for (a of d.arriendos; track a.id) {
                          <tr [ngClass]="a.vigente ? 'bg-emerald-50/40 dark:bg-emerald-900/10' : ''">
                            <td class="px-3 py-2.5">
                              <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-semibold bg-brand-50 dark:bg-brand-900/30 text-brand-700 dark:text-brand-300">
                                {{ a.puesto.codigo }}
                              </span>
                            </td>
                            <td class="px-3 py-2.5 text-xs text-gray-600 dark:text-gray-300">
                              @if (a.titular?.dni === DNI_COOP) {
                                <span class="inline-flex items-center px-1.5 py-0.5 rounded text-xs font-medium bg-purple-50 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300">
                                  Cooperativa
                                </span>
                              } @else {
                                {{ a.titular?.apellidos || '—' }}
                              }
                            </td>
                            <td class="px-3 py-2.5 text-right tabular-nums text-gray-700 dark:text-gray-300">
                              {{ a.monto_arriendo ? (a.monto_arriendo | number:'1.2-2') : '—' }}
                            </td>
                            <td class="px-3 py-2.5 text-gray-700 dark:text-gray-300 whitespace-nowrap">{{ a.fecha_inicio | date:'dd/MM/yyyy' }}</td>
                            <td class="px-3 py-2.5 text-gray-700 dark:text-gray-300 whitespace-nowrap">{{ a.fecha_fin ? (a.fecha_fin | date:'dd/MM/yyyy') : '—' }}</td>
                            <td class="px-3 py-2.5 text-gray-600 dark:text-gray-400 text-xs">{{ a.motivo_termino || '—' }}</td>
                            <td class="px-3 py-2.5 text-center">
                              @if (a.vigente) {
                                <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-emerald-50 dark:bg-emerald-900/30 text-emerald-700 dark:text-emerald-300">Vigente</span>
                              } @else {
                                <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300">Cerrado</span>
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
                    <p class="text-sm mt-1">Los recibos de este inquilino aparecerán aquí.</p>
                  </div>

                } @else {
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
                          <th class="px-3 py-2.5 text-right font-medium">Acciones</th>
                        </tr>
                      </thead>
                      <tbody class="divide-y divide-gray-100 dark:divide-gray-700">
                        @for (p of historial(); track p.id) {
                          <tr [ngClass]="p.anulado
                              ? 'bg-red-50/40 dark:bg-red-900/10 opacity-75'
                              : 'hover:bg-gray-50 dark:hover:bg-gray-800/60'"
                            class="transition">
                            <!-- Fecha -->
                            <td class="px-3 py-2.5 text-xs whitespace-nowrap"
                              [ngClass]="p.anulado ? 'text-gray-400 dark:text-gray-500' : 'text-gray-600 dark:text-gray-400'">
                              {{ p.fecha_pago | date:'dd/MM/yyyy HH:mm' }}
                            </td>

                            <!-- Código + badge ANULADO -->
                            <td class="px-3 py-2.5">
                              <span class="font-mono text-xs whitespace-nowrap"
                                [ngClass]="p.anulado
                                  ? 'line-through text-gray-400 dark:text-gray-500'
                                  : 'text-brand-600 dark:text-brand-400'">
                                {{ p.codigo_transaccion }}
                              </span>
                              @if (p.anulado) {
                                <span class="block mt-0.5 text-[10px] font-semibold uppercase tracking-wide text-red-600 dark:text-red-400">
                                  Anulado
                                  @if (p.motivo_anulacion) {
                                    <span class="font-normal normal-case tracking-normal">· {{ p.motivo_anulacion }}</span>
                                  }
                                </span>
                              }
                            </td>

                            <!-- Monto -->
                            <td class="px-3 py-2.5 text-right font-semibold tabular-nums whitespace-nowrap"
                              [ngClass]="p.anulado
                                ? 'line-through text-gray-400 dark:text-gray-500'
                                : 'text-gray-900 dark:text-white'">
                              S/ {{ p.monto_total.toFixed(2) }}
                            </td>

                            <!-- Método -->
                            <td class="px-3 py-2.5 text-center">
                              @if (!p.anulado) {
                                @if (p.metodo_pago === 'Efectivo') {
                                  <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-green-50 dark:bg-green-900/30 text-green-700 dark:text-green-300">
                                    Efectivo
                                  </span>
                                } @else {
                                  <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-blue-50 dark:bg-blue-900/30 text-blue-700 dark:text-blue-300">
                                    Transferencia
                                  </span>
                                }
                              } @else {
                                <span class="text-xs text-gray-400 dark:text-gray-500">—</span>
                              }
                            </td>

                            <!-- Conceptos -->
                            <td class="px-3 py-2.5 text-center">
                              <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs"
                                [ngClass]="p.anulado
                                  ? 'bg-red-50 dark:bg-red-900/20 text-red-400 dark:text-red-500 line-through'
                                  : 'bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300'">
                                {{ p.detalle.length }} {{ p.detalle.length === 1 ? 'concepto' : 'conceptos' }}
                              </span>
                            </td>

                            <!-- Acciones -->
                            <td class="px-3 py-2.5 text-right">
                              <div class="flex items-center justify-end gap-1">
                                <!-- PDF (siempre disponible) -->
                                <button
                                  (click)="abrirReciboPdf(p)"
                                  [disabled]="generandoPdfId() === p.id"
                                  title="Abrir recibo PDF"
                                  class="inline-flex items-center gap-1 px-2 py-1.5 rounded-lg border border-gray-200 dark:border-gray-600 text-gray-500 dark:text-gray-400 hover:border-brand-400 hover:text-brand-600 dark:hover:text-brand-400 transition disabled:opacity-40 text-xs">
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

                                <!-- Anular (solo Admin, solo pagos vigentes) -->
                                @if (authSvc.esAdmin() && !p.anulado) {
                                  <button
                                    (click)="abrirModalAnular(p)"
                                    title="Anular recibo"
                                    class="inline-flex items-center gap-1 px-2 py-1.5 rounded-lg border border-red-200 dark:border-red-800 text-red-500 dark:text-red-400 hover:bg-red-50 dark:hover:bg-red-900/20 hover:border-red-400 transition text-xs">
                                    <svg class="h-3.5 w-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                      <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
                                    </svg>
                                    Anular
                                  </button>
                                }
                              </div>
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
        <p class="text-gray-500 dark:text-gray-400">Selecciona un inquilino.</p>
      }
    </div>

    <!-- ═══════════════════════════════════════════════════════════════════════ -->
    <!-- MODAL DE ANULACIÓN                                                      -->
    <!-- ═══════════════════════════════════════════════════════════════════════ -->
    @if (modalAnularAbierto()) {
      <div class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm"
        (click)="cerrarModalAnular()">
        <div class="w-full max-w-md bg-white dark:bg-gray-800 rounded-2xl shadow-2xl overflow-hidden"
          (click)="$event.stopPropagation()">

          <!-- Cabecera del modal -->
          <div class="flex items-start justify-between p-5 border-b border-gray-200 dark:border-gray-700">
            <div>
              <h3 class="text-base font-semibold text-gray-900 dark:text-white">Anular Recibo</h3>
              <p class="mt-0.5 text-xs font-mono text-brand-600 dark:text-brand-400">
                {{ pagoAAnular()?.codigo_transaccion }}
              </p>
            </div>
            <button (click)="cerrarModalAnular()"
              class="text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 transition">
              <svg class="h-5 w-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
              </svg>
            </button>
          </div>

          <!-- Cuerpo del modal -->
          <div class="p-5 space-y-4">
            <!-- Advertencia -->
            <div class="rounded-xl bg-amber-50 dark:bg-amber-900/20 border border-amber-200 dark:border-amber-800 p-3 text-xs text-amber-800 dark:text-amber-300 leading-relaxed">
              <strong class="block mb-0.5">Acción irreversible</strong>
              El recibo quedará marcado como anulado y las deudas asociadas
              (S/ {{ pagoAAnular()?.monto_total?.toFixed(2) }}) volverán a estado
              <strong>Pendiente</strong> para recobrarse correctamente.
            </div>

            <!-- Selector de motivo -->
            <div>
              <p class="text-xs font-medium text-gray-700 dark:text-gray-300 mb-2">Motivo de anulación</p>
              <div class="space-y-2">
                @for (m of MOTIVOS; track m) {
                  <button (click)="motivoSeleccionado.set(m)"
                    [ngClass]="motivoSeleccionado() === m
                      ? 'border-brand-500 bg-brand-50 dark:bg-brand-900/20 text-brand-700 dark:text-brand-300'
                      : 'border-gray-200 dark:border-gray-600 text-gray-600 dark:text-gray-300 hover:border-gray-300 dark:hover:border-gray-500'"
                    class="w-full text-left px-4 py-2.5 rounded-xl border text-sm font-medium transition">
                    {{ m }}
                  </button>
                }
              </div>
            </div>

            <!-- Texto libre cuando el motivo es "Otro" -->
            @if (motivoSeleccionado() === 'Otro (especificar)') {
              <textarea
                [value]="motivoPersonalizado()"
                (input)="onMotivoInput($event)"
                rows="3"
                placeholder="Describe el motivo de la anulación..."
                class="w-full rounded-xl border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-700 px-3 py-2.5 text-sm text-gray-900 dark:text-white placeholder-gray-400 focus:border-brand-500 focus:ring-2 focus:ring-brand-500/20 focus:outline-none resize-none">
              </textarea>
            }

            <!-- Error inline -->
            @if (errorAnulacion()) {
              <p class="text-xs text-red-600 dark:text-red-400">{{ errorAnulacion() }}</p>
            }
          </div>

          <!-- Pie del modal -->
          <div class="flex gap-3 px-5 pb-5">
            <button (click)="cerrarModalAnular()"
              [disabled]="anulando()"
              class="flex-1 px-4 py-2.5 rounded-xl border border-gray-300 dark:border-gray-600 text-sm font-medium text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 transition disabled:opacity-50">
              Cancelar
            </button>
            <button (click)="confirmarAnulacion()"
              [disabled]="!motivoFinal() || anulando()"
              class="flex-1 px-4 py-2.5 rounded-xl bg-red-600 hover:bg-red-700 disabled:bg-red-300 dark:disabled:bg-red-900 text-white text-sm font-semibold transition disabled:cursor-not-allowed">
              @if (anulando()) {
                <span class="inline-flex items-center gap-2 justify-center">
                  <svg class="h-4 w-4 animate-spin" fill="none" viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"/>
                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"/>
                  </svg>
                  Anulando...
                </span>
              } @else {
                Confirmar Anulación
              }
            </button>
          </div>
        </div>
      </div>
    }
  `,
})
export class InquilinoDetailComponent implements OnDestroy {
  private readonly route     = inject(ActivatedRoute);
  private readonly router    = inject(Router);
  private readonly svc       = inject(InquilinosService);
  private readonly pagosSvc  = inject(PagosService);
  private readonly pdfSvc    = inject(PdfGeneratorService);
  protected readonly authSvc = inject(AuthService);

  readonly DNI_COOP = DNI_INSTITUCIONAL;

  private readonly idParam = toSignal(this.route.paramMap, { initialValue: null });

  readonly inquilinoId = computed<number | null>(() => {
    const p = this.idParam();
    if (!p) return null;
    const n = Number(p.get('id'));
    return Number.isFinite(n) ? n : null;
  });

  readonly detalle          = signal<InquilinoDetalle | null>(null);
  readonly loading          = signal(false);
  readonly error            = signal<string | null>(null);
  readonly tab              = signal<Tab>('arriendos');
  readonly historial        = signal<PagoHistorial[]>([]);
  readonly historialLoading = signal(false);
  readonly historialError   = signal<string | null>(null);
  readonly generandoPdfId   = signal<number | null>(null);

  // Estado del modal de anulación
  readonly modalAnularAbierto  = signal(false);
  readonly pagoAAnular         = signal<PagoHistorial | null>(null);
  readonly motivoSeleccionado  = signal('');
  readonly motivoPersonalizado = signal('');
  readonly anulando            = signal(false);
  readonly errorAnulacion      = signal<string | null>(null);

  protected readonly MOTIVOS = MOTIVOS_ANULACION;

  readonly motivoFinal = computed(() =>
    this.motivoSeleccionado() === 'Otro (especificar)'
      ? this.motivoPersonalizado().trim()
      : this.motivoSeleccionado(),
  );

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
      const id = this.inquilinoId();
      if (id !== null) {
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
    this.tab.set('arriendos');
    this.historial.set([]);
    try {
      const [det] = await Promise.all([
        this.svc.cargarDetalle(id),
        this.cargarHistorial(id),
      ]);
      this.detalle.set(det);

      this.cleanupRealtime = this.pagosSvc.suscribirCambiosDePagos(
        id, 'inquilino', () => void this.cargarHistorial(id),
      );
    } catch (e: unknown) {
      this.error.set(e instanceof Error ? e.message : 'Error al cargar el detalle');
      this.historialLoading.set(false);
    } finally {
      this.loading.set(false);
    }
  }

  private async cargarHistorial(id: number): Promise<void> {
    this.historialLoading.set(true);
    this.historialError.set(null);
    try {
      const lista = await this.pagosSvc.obtenerHistorialPorPagador(id, 'inquilino');
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

  // ─── Anulación ─────────────────────────────────────────────────────────────

  abrirModalAnular(pago: PagoHistorial): void {
    this.pagoAAnular.set(pago);
    this.motivoSeleccionado.set('');
    this.motivoPersonalizado.set('');
    this.errorAnulacion.set(null);
    this.modalAnularAbierto.set(true);
  }

  cerrarModalAnular(): void {
    if (this.anulando()) return;
    this.modalAnularAbierto.set(false);
    this.pagoAAnular.set(null);
  }

  onMotivoInput(ev: Event): void {
    this.motivoPersonalizado.set((ev.target as HTMLTextAreaElement).value);
  }

  async confirmarAnulacion(): Promise<void> {
    const pago = this.pagoAAnular();
    const id   = this.inquilinoId();
    if (!pago || !id) return;

    const motivo = this.motivoFinal();
    if (!motivo) {
      this.errorAnulacion.set('Debes seleccionar o ingresar un motivo.');
      return;
    }

    this.anulando.set(true);
    this.errorAnulacion.set(null);
    try {
      await this.pagosSvc.anularPago(pago.id, motivo);
      this.cerrarModalAnular();
      await this.cargarHistorial(id);
    } catch (e: unknown) {
      this.errorAnulacion.set(e instanceof Error ? e.message : 'Error al anular el pago');
    } finally {
      this.anulando.set(false);
    }
  }

  // ─── PDF ───────────────────────────────────────────────────────────────────

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
        tipo_pagador:       'Inquilino',
        dni_pagador:        d.dni,
        codigo_puesto:      pago.codigo_puesto,
        metodo_pago:        pago.metodo_pago,
        comprobante:        pago.comprobante,
        detalle: pago.detalle.map(det => ({
          concepto:          det.concepto,
          periodo:           formatPeriodo(det.periodo_anio, det.periodo_mes),
          saldo_original:    det.monto_original,
          aplicado:          det.monto_aplicado,
          cubierto_completo: det.monto_aplicado >= det.monto_original * 0.99,
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
